package api.service.impl;

import api.service.APIOrcService;
import api.vo.APIOrcCarlistVO;
import api.vo.APIOrcModelVO;
import api.vo.APIOrcPartnersCarlistVO;
import api.vo.APIRCLOGVO;
import common.Constant;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.SmsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.impl.RsvDAO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.vo.CMSSVO;
import web.order.vo.RC_RSVVO;
import web.product.service.WebRcProductService;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

@Service("apiOrcService")
public class APIOrcServiceImpl extends EgovAbstractServiceImpl implements APIOrcService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "apiInsDAO")
	private APIInsDAO apiInsDAO;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "smsService")
	protected SmsService smsService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name = "apiDAO")
	private APIDAO apiDAO;

	/** ORC common API url*/
	public static final String ORC_URL =  "https://api.erp.orcar.kr";
	public static final String ORC_TOKEN = "Basic dGFtbmFvOjJEcjYtQzJIR0VRNnBCQnF1R1hNdzVoR1hZTnlHQXVuZ2hZQw==";

	/** 렌터카 정보 */
	@Override
	public HashMap<String,Object> vehicleModels(RC_PRDTINFVO webParam) {
		RestTemplate restTemplate = new RestTemplate();
		String url = ORC_URL + "/v1/vehicle-models";

		// URL에 파라미터 추가
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url)
			.queryParam("partnersCompanyCodes", webParam.getCorpId());

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", ORC_TOKEN);

		 // HttpEntity에 헤더 추가
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<APIOrcModelVO[]> response = restTemplate.exchange(uriBuilder.build().toUri(), HttpMethod.GET, entity, APIOrcModelVO[].class);

        /** 전체연동일 경우 전체차량 판매중지로 변경 */
		if("Y".equals(webParam.getTotalInterlock())){
			apiInsDAO.updateCarSaleEnd(webParam);
		}

		int resultCnt1 = 0;
		int resultCnt2 = 0;

        for (APIOrcModelVO responseVO : response.getBody()) {
			for(APIOrcPartnersCarlistVO resultPartnerCode : responseVO.getPartnersVehicleModels()){
				RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();

				/** 차량매핑ID */
				apiRcPrdtVO.setLinkMappingNum(Integer.toString(responseVO.getId()));
				/** 탐나오차량ID */
				apiRcPrdtVO.setRcCardivNum(resultPartnerCode.getCode());
				/** 탐나오업체ID */
				apiRcPrdtVO.setCorpId(responseVO.getPartnersCompanyCode());
				/** 운전경력 */
				apiRcPrdtVO.setRntQlfctCareer(Integer.toString(responseVO.getDriverExperience()));
				/** 운전나이 */
				apiRcPrdtVO.setRntQlfctAge(Integer.toString(responseVO.getDriverAge()));
				/** 연식 */
				int minModelYear = responseVO.getMinModelYear();
				int maxModelYear = minModelYear+1;
				apiRcPrdtVO.setModelYear(minModelYear+"~"+maxModelYear);

				/** 변속기 */
				if("AUTOMATIC".equals(responseVO.getTransmission())){
					apiRcPrdtVO.setTransDiv("TR02");
				}else{
					apiRcPrdtVO.setTransDiv("TR01");
				}

				/** 라이센스 10인이하 2종, 이상이면 1종*/
				if(responseVO.getSeat() <= 10){
					apiRcPrdtVO.setRntQlfctLicense("2");
				}else{
					apiRcPrdtVO.setRntQlfctLicense("1");
				}

				/** 라이센스 */
				apiRcPrdtVO.setFrstRegId("admin");
				apiRcPrdtVO.setLastModId("admin");
				List<String> options = responseVO.getOptions();

				Boolean updateOption = true;

				/** 자차미포함 생성*/
				if("2".equals(webParam.getInsIsrDiv0())){
					apiRcPrdtVO.setIsrDiv("ID00");
					int insCarNum = apiInsDAO.selectCntInsList(apiRcPrdtVO);
					if(insCarNum < 1){
						apiInsDAO.inserInsList(apiRcPrdtVO);
						resultCnt1 ++;
					} else {
						if ("Y".equals(webParam.getTotalInterlock())) {
							apiInsDAO.updateInsList(apiRcPrdtVO);
						} else {
							apiInsDAO.updateInsList2(apiRcPrdtVO);
						}
						resultCnt2++;
						updateOption = false;
					}
				}

				/** 보험1 설정 */
				apiRcPrdtVO.setIsrDiv("ID10");

				if(!"".equals(webParam.getInsIsrDiv1()) && responseVO.getBasicInsurance() !=null){

					if("1".equals(webParam.getInsIsrDiv1())){
						apiRcPrdtVO.setIsrTypeDiv("GENL");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv1());
						apiRcPrdtVO.setGeneralIsrAge(Integer.toString(responseVO.getBasicInsurance().getDriverAge()));
						apiRcPrdtVO.setGeneralIsrCareer(Integer.toString(responseVO.getBasicInsurance().getDriverExperience()));
						apiRcPrdtVO.setGeneralIsrRewardAmt(responseVO.getBasicInsurance().getCoverageLimit());
						apiRcPrdtVO.setGeneralIsrBurcha("면책금:"+responseVO.getBasicInsurance().getDeductible() + "<pre></pre>휴차보상료:" + responseVO.getBasicInsurance().getLossOfUseCompensation() + "<pre></pre>기타:" + responseVO.getBasicInsurance().getContent());
					}else if("1".equals(webParam.getInsIsrDiv2())){
						apiRcPrdtVO.setIsrTypeDiv("LUXY");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv2());
						apiRcPrdtVO.setLuxyIsrAge(Integer.toString(responseVO.getPremiumInsurance().getDriverAge()));
						apiRcPrdtVO.setLuxyIsrCareer(Integer.toString(responseVO.getPremiumInsurance().getDriverExperience()));
						apiRcPrdtVO.setLuxyIsrRewardAmt(responseVO.getPremiumInsurance().getCoverageLimit());
						apiRcPrdtVO.setLuxyIsrBurcha("면책금:"+responseVO.getPremiumInsurance().getDeductible() + "<pre></pre>휴차보상료:" + responseVO.getPremiumInsurance().getLossOfUseCompensation() + "<pre></pre>기타:" + responseVO.getPremiumInsurance().getContent());
					}

					/** 보험1 추가*/
					int insNum = apiInsDAO.selectCntInsList(apiRcPrdtVO);
					if (insNum < 1) {
						apiInsDAO.inserInsList(apiRcPrdtVO);
						resultCnt1++;
					}else if(insNum > 0) {
						if("Y".equals(webParam.getTotalInterlock())){
							apiInsDAO.updateInsList(apiRcPrdtVO);
						}else{
							apiInsDAO.updateInsList2(apiRcPrdtVO);
						}
						resultCnt2++;
						updateOption = false;
					}
				}

				if(!"".equals(webParam.getInsIsrDiv2())  && responseVO.getPremiumInsurance() !=null){
					/** 보험2 설정 */
					if("2".equals(webParam.getInsIsrDiv1())){
						apiRcPrdtVO.setIsrTypeDiv("GENL");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv1());
						apiRcPrdtVO.setGeneralIsrAge(Integer.toString(responseVO.getBasicInsurance().getDriverAge()));
						apiRcPrdtVO.setGeneralIsrCareer(Integer.toString(responseVO.getBasicInsurance().getDriverExperience()));
						apiRcPrdtVO.setGeneralIsrRewardAmt(responseVO.getBasicInsurance().getCoverageLimit());
						apiRcPrdtVO.setGeneralIsrBurcha("면책금:"+responseVO.getBasicInsurance().getDeductible() + "<pre></pre>휴차보상료:" + responseVO.getBasicInsurance().getLossOfUseCompensation() + "<pre></pre>기타:" + responseVO.getBasicInsurance().getContent());
					}else if("2".equals(webParam.getInsIsrDiv2())){
						apiRcPrdtVO.setIsrTypeDiv("LUXY");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv2());
						apiRcPrdtVO.setLuxyIsrAge(Integer.toString(responseVO.getPremiumInsurance().getDriverAge()));
						apiRcPrdtVO.setLuxyIsrCareer(Integer.toString(responseVO.getPremiumInsurance().getDriverExperience()));
						apiRcPrdtVO.setLuxyIsrRewardAmt(responseVO.getPremiumInsurance().getCoverageLimit());
						apiRcPrdtVO.setLuxyIsrBurcha("면책금:"+responseVO.getPremiumInsurance().getDeductible() + "<pre></pre>휴차보상료:" + responseVO.getPremiumInsurance().getLossOfUseCompensation() + "<pre></pre>기타:" + responseVO.getPremiumInsurance().getContent());
					}

					/** 보험2 추가*/
					int insNum = apiInsDAO.selectCntInsList(apiRcPrdtVO);
					if (insNum < 1) {
						apiInsDAO.inserInsList(apiRcPrdtVO);
						resultCnt1++;
					}else if(insNum > 0) {
						if("Y".equals(webParam.getTotalInterlock())){
							apiInsDAO.updateInsList(apiRcPrdtVO);
						}else{
							apiInsDAO.updateInsList2(apiRcPrdtVO);
						}
						resultCnt2++;
						updateOption = false;
					}
				}

				/** 옵션추가 */
				if("Y".equals(webParam.getTotalInterlock()) || (!"Y".equals(webParam.getTotalInterlock()) && updateOption == false) ){
					apiInsDAO.deleteCarOptList(apiRcPrdtVO);
				}
				List<CDVO> iconCdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
				for(CDVO cdvo : iconCdList){
					/** 차량모델옵션 */
					for(String tempOption : options){
						if(cdvo.getCdNm().contains(tempOption)){
						/*if(tempOption.contains(cdvo.getCdNm())){*/
							apiRcPrdtVO.setIconCds(cdvo.getCdNum());
							apiInsDAO.insertCarOptList(apiRcPrdtVO);
						}
					}
				}
			}
		}

		HashMap<String,Object> modelMap = new HashMap<>();
        modelMap.put("resultCnt1", resultCnt1);
		modelMap.put("resultCnt2", resultCnt2);

		return modelMap;
	}

	/** 렌터카 상세정보 */
	@Override
	public RC_PRDTINFVO vehicleModelDetail(RC_PRDTINFVO webParam) {
		RestTemplate restTemplate = new RestTemplate();
		String url = ORC_URL + "/v1/vehicle-models";

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(url)
			.queryParam("partnersCompanyCodes", webParam.getCorpId())
        	.queryParam("vehicleModelIds", webParam.getLinkMappingNum());

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", ORC_TOKEN);

		// HttpEntity에 헤더 추가
        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<APIOrcModelVO[]> response = restTemplate.exchange(uriBuilder.build().toUri(), HttpMethod.GET, entity, APIOrcModelVO[].class);

		RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
        for (APIOrcModelVO responseVO : response.getBody()) {
				/** 차량매핑ID */
				apiRcPrdtVO.setLinkMappingNum(Integer.toString(responseVO.getId()));
				/** 탐나오업체ID */
				apiRcPrdtVO.setCorpId(responseVO.getPartnersCompanyCode());
				/** 오르카 차량명 */
				apiRcPrdtVO.setRcNm(responseVO.getName());
				/** 운전경력 */
				apiRcPrdtVO.setRntQlfctCareer(Integer.toString(responseVO.getDriverExperience()));
				/** 운전나이 */
				apiRcPrdtVO.setRntQlfctAge(Integer.toString(responseVO.getDriverAge()));
				/** 연식 */
				int minModelYear = responseVO.getMinModelYear();
				int maxModelYear = responseVO.getMaxModelYear();
				apiRcPrdtVO.setModelYear(minModelYear+"~"+maxModelYear);

				/** 변속기 */
				if("AUTOMATIC".equals(responseVO.getTransmission())){
					apiRcPrdtVO.setTransDivNm("자동");
				}else{
					apiRcPrdtVO.setTransDivNm("수동");
				}
				/** 라이센스 10인이하 2종, 이상이면 1종*/
				if(responseVO.getSeat() <= 10){
					apiRcPrdtVO.setRntQlfctLicense("2");
				}else{
					apiRcPrdtVO.setRntQlfctLicense("1");
				}
				apiRcPrdtVO.setIconCd(responseVO.getOptions());
		}
		return apiRcPrdtVO;
	}

	/** 이용가능 렌터카정보 리스트*/
	@Override
	public List<APIOrcCarlistVO> vehicleAvailList(RC_PRDTINFSVO webParam){
		RestTemplate restTemplate = new RestTemplate();
		String url = ORC_URL + "/v1/vehicle-models/availabilities";

		/** pickUpAt */
        String starDtA = webParam.getsFromDt();
        String starTmA = webParam.getsFromTm().substring(0,2);

        // LocalDate로 변환 (yyyyMMdd 형식)
        DateTimeFormatter dateFormatterA = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate dateA = LocalDate.parse(starDtA, dateFormatterA);

        // LocalTime 생성 (starTmA를 시간으로 사용)
        LocalTime timeA = LocalTime.of(Integer.parseInt(starTmA), 0, 0); // 09:00:00

        // OffsetDateTime 생성
        OffsetDateTime offsetDateTimeA = OffsetDateTime.of(dateA, timeA, ZoneOffset.ofHours(9));

        /** dropOffAt */
        String starDtB = webParam.getsToDt();
        String starTmB = webParam.getsToTm().substring(0,2);;

        // LocalDate로 변환 (yyyyMMdd 형식)
        DateTimeFormatter dateFormatterB = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate dateB = LocalDate.parse(starDtB, dateFormatterB);

        // LocalTime 생성 (starTmA를 시간으로 사용)
        LocalTime timeB = LocalTime.of(Integer.parseInt(starTmB), 0, 0); // 09:00:00

        // OffsetDateTime 생성
        OffsetDateTime offsetDateTimeB = OffsetDateTime.of(dateB, timeB, ZoneOffset.ofHours(9));

        // ISO 8601 형식으로 출력
        String pickUpAt =  offsetDateTimeA.toString();
        String dropOffAt = offsetDateTimeB.toString();

		// URL에 파라미터 추가
         UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("pickUpAt", pickUpAt)  // 인코딩 없이 그대로 "홍길동" 사용
                .queryParam("dropOffAt", dropOffAt)
                .build(false);  // false로 설정하여 인코딩 비활성화

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", ORC_TOKEN);

		 // HttpEntity에 헤더 추가
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<List<APIOrcCarlistVO>> response = restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, entity, new ParameterizedTypeReference<List<APIOrcCarlistVO>>() {});

		return response.getBody();
	}

	/** 이용가능 렌터카정보 상세*/
	@Override
	public RC_PRDTINFVO vehicleAvailDetail(RC_PRDTINFSVO webParam, RC_PRDTINFVO prdtVO){
		RestTemplate restTemplate = new RestTemplate();
		String url = ORC_URL + "/v1/vehicle-models/availabilities";

		String modelId = prdtVO.getLinkMappingNum();

		/** get 렌터카 수수료율 for 입금가계산 */
		CMSSVO cmssVO = new CMSSVO();
		cmssVO.setCmssNum("CMSS000001");
		cmssVO = ossCmmService.selectByCmss(cmssVO);
		final Float adjAplPct = Float.parseFloat(cmssVO.getAdjAplPct());

		/** pickUpAt */
        String starDtA = webParam.getsFromDt();
        String starTmA = webParam.getsFromTm().substring(0,2);

        // LocalDate로 변환 (yyyyMMdd 형식)
        DateTimeFormatter dateFormatterA = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate dateA = LocalDate.parse(starDtA, dateFormatterA);

        // LocalTime 생성 (starTmA를 시간으로 사용)
        LocalTime timeA = LocalTime.of(Integer.parseInt(starTmA), 0, 0); // 09:00:00

        // OffsetDateTime 생성
        OffsetDateTime offsetDateTimeA = OffsetDateTime.of(dateA, timeA, ZoneOffset.ofHours(9));

        /** dropOffAt */
        String starDtB = webParam.getsToDt();
        String starTmB = webParam.getsToTm().substring(0,2);

        // LocalDate로 변환 (yyyyMMdd 형식)
        DateTimeFormatter dateFormatterB = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate dateB = LocalDate.parse(starDtB, dateFormatterB);

        // LocalTime 생성 (starTmA를 시간으로 사용)
        LocalTime timeB = LocalTime.of(Integer.parseInt(starTmB), 0, 0); // 09:00:00

        // OffsetDateTime 생성
        OffsetDateTime offsetDateTimeB = OffsetDateTime.of(dateB, timeB, ZoneOffset.ofHours(9));

        // ISO 8601 형식으로 출력
        String pickUpAt =  offsetDateTimeA.toString();
        String dropOffAt = offsetDateTimeB.toString();

		// URL에 파라미터 추가
         UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("pickUpAt", pickUpAt)  // 인코딩 없이 그대로 "홍길동" 사용
                .queryParam("dropOffAt", dropOffAt)
                .queryParam("vehicleModelIds", modelId)
                .build(false);  // false로 설정하여 인코딩 비활성화

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", ORC_TOKEN);

		// HttpEntity에 헤더 추가
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<List<APIOrcCarlistVO>> response = restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, entity, new ParameterizedTypeReference<List<APIOrcCarlistVO>>() {});

        for(APIOrcCarlistVO tempVO : response.getBody() ){
			if(Integer.toString(tempVO.getVehicleModel().getId()).equals(prdtVO.getLinkMappingNum()) && tempVO.getVehicleModel().getPartnersCompanyCode().equals(prdtVO.getCorpId())){
				if(prdtVO.getLinkMappingIsrNum() == null || prdtVO.getLinkMappingIsrNum().equals("")){
					prdtVO.setSaleAmt(Integer.toString(tempVO.getStandardPrice()));
					if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
						prdtVO.setSaleAmt(Integer.toString((int)((tempVO.getStandardPrice() * 100) / (100 - adjAplPct) / 10) * 10));
					}
					prdtVO.setAbleYn("Y");
				}else if(prdtVO.getLinkMappingIsrNum().equals("1")){
					prdtVO.setSaleAmt(Integer.toString(tempVO.getBasicInsuredPrice()));
					if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
						prdtVO.setSaleAmt(Integer.toString((int)((tempVO.getBasicInsuredPrice() * 100) / (100 - adjAplPct) / 10) * 10));
					}
					prdtVO.setAbleYn("Y");
				}else if(prdtVO.getLinkMappingIsrNum().equals("2")){
					prdtVO.setSaleAmt(Integer.toString(tempVO.getPremiumInsuredPrice()));
					if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
						prdtVO.setSaleAmt(Integer.toString((int)((tempVO.getPremiumInsuredPrice() * 100) / (100 - adjAplPct) / 10) * 10));
					}
					prdtVO.setAbleYn("Y");
				}
			}
		}
		return prdtVO;
	}

	public String vehicleReservation(String rcRsvNum){
		RC_RSVVO rsvDtlVO = new RC_RSVVO();
		rsvDtlVO.setRcRsvNum(rcRsvNum);
		rsvDtlVO = rsvDAO.selectRcDetailRsv(rsvDtlVO);

		/** 상품정보 */
		RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
		prdtSVO.setsPrdtNum(rsvDtlVO.getPrdtNum());
		prdtSVO.setsFromDt(rsvDtlVO.getRentStartDt());
		prdtSVO.setsFromTm(rsvDtlVO.getRentStartTm());
		prdtSVO.setsToDt(rsvDtlVO.getRentEndDt());
		prdtSVO.setsToTm(rsvDtlVO.getRentEndTm());
		prdtSVO.setsApiRentDiv(rsvDtlVO.getApiRentDiv());
		RC_PRDTINFVO prdtVO = webRcProductService.selectRcPrdt(prdtSVO);

		/** 탐나오업체ID */
		String partnersCompanyCode = prdtVO.getCorpId();
		/** 예약자명1 */
		String customerName = rsvDtlVO.getUseNm();
		/** 예약자연락처2*/
		String customerPhoneNumber = rsvDtlVO.getUseTelnum();
		/** 예약자명2 */
		String customerName2 = rsvDtlVO.getRsvNm();
		/** 예약자연락처2*/
		String customerPhoneNumber2 = rsvDtlVO.getRsvTelnum();
		/** 차량모델ID */
		String vehicleModelId  = prdtVO.getLinkMappingNum();
		/** 차량요금 */
		String vehiclePrice = rsvDtlVO.getNmlAmt();
		/** 탐나오 소예약번호*/
		String partnersReservationKey  = rsvDtlVO.getRcRsvNum();
		/** 일반자차:BASIC, 고급자차:PREMIUM */
		String vehicleModelInsuranceType = "";
		if("1".equals(prdtVO.getLinkMappingIsrNum())){
			vehicleModelInsuranceType = "BASIC";
		}else if("2".equals(prdtVO.getLinkMappingIsrNum())){
			vehicleModelInsuranceType = "PREMIUM";
		}

		RestTemplate restTemplate = new RestTemplate();
		String url = ORC_URL + "/v1/reservations";

		/** pickUpAt */
        String starDtA = rsvDtlVO.getRentStartDt();
        String starTmA = rsvDtlVO.getRentStartTm().substring(0,2);

        // LocalDate로 변환 (yyyyMMdd 형식)
        DateTimeFormatter dateFormatterA = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate dateA = LocalDate.parse(starDtA, dateFormatterA);

        // LocalTime 생성 (starTmA를 시간으로 사용)
        LocalTime timeA = LocalTime.of(Integer.parseInt(starTmA), 0, 0); // 09:00:00

        // OffsetDateTime 생성
        OffsetDateTime offsetDateTimeA = OffsetDateTime.of(dateA, timeA, ZoneOffset.ofHours(9));

        /** dropOffAt */
        String starDtB = rsvDtlVO.getRentEndDt();
        String starTmB = rsvDtlVO.getRentEndTm().substring(0,2);

        // LocalDate로 변환 (yyyyMMdd 형식)
        DateTimeFormatter dateFormatterB = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate dateB = LocalDate.parse(starDtB, dateFormatterB);

        // LocalTime 생성 (starTmA를 시간으로 사용)
        LocalTime timeB = LocalTime.of(Integer.parseInt(starTmB), 0, 0); // 09:00:00

        // OffsetDateTime 생성
        OffsetDateTime offsetDateTimeB = OffsetDateTime.of(dateB, timeB, ZoneOffset.ofHours(9));

        /** 대여일시 */
        String pickUpAt =  offsetDateTimeA.toString();
        /** 반납일시 */
        String dropOffAt = offsetDateTimeB.toString();


        JSONObject items = new JSONObject();
		items.put("partnersCompanyCode", partnersCompanyCode);
        items.put("customerName", customerName);
		items.put("customerPhoneNumber", customerPhoneNumber);
		items.put("customerName2", customerName2);
		items.put("customerPhoneNumber2", customerPhoneNumber2);
		items.put("vehicleModelId", vehicleModelId);
		items.put("vehiclePrice", vehiclePrice);
		items.put("partnersReservationKey", partnersReservationKey);
		items.put("pickUpAt", pickUpAt);
		items.put("dropOffAt", dropOffAt);

		if(!vehicleModelInsuranceType.equals("")){
			items.put("vehicleModelInsuranceType", vehicleModelInsuranceType);
		}

		String resultMsg = "";

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", ORC_TOKEN);

		// HttpEntity에 헤더 추가
        HttpEntity<JSONObject> entity = new HttpEntity<>(items,headers);

        try {
			ResponseEntity<JSONObject> response = restTemplate.postForEntity(url, entity, JSONObject.class);
			HttpStatus statusCode = response.getStatusCode();

			/** 성공일 경우 */
			if (statusCode.value() >= 200 && statusCode.value() < 300) {
				/** 로그저장 초기화 */
				APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
				/** 예약FLAG */
				apiRcLogVO.setApiRentDiv("O");
				apiRcLogVO.setSeqNum("0");
				apiRcLogVO.setRcRsvNum(rsvDtlVO.getRcRsvNum());
				apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());
				apiRcLogVO.setRequestMsg(items.toString());
				if(response.getBody().get("id") != null){
					resultMsg = response.getBody().get("id").toString();
					rsvDtlVO.setLinkMappingRsvnum(resultMsg);
					/** 예약번호 업데이트 */
					rsvDAO.updateRcLinkYn(rsvDtlVO);
					apiRcLogVO.setRsvResult("0");
				}
				/**로그 저장*/
				apiDAO.insertRcApiLog(apiRcLogVO);
			}
		} catch (HttpClientErrorException e) {
        	log.info("orcar res Error Code: " + e.getStatusCode() + "|" + rcRsvNum);
			log.info("orcar res Error Msg: " + e.getResponseBodyAsString() + "|" + rcRsvNum);
		}
		return resultMsg;
	}

	public Boolean vehicleCancel(RC_RSVVO rsvDtlVO){

		Boolean succeed = false;

		RestTemplate restTemplate = new RestTemplate();
		String url = ORC_URL + "/v1/reservations/";

		url += rsvDtlVO.getLinkMappingRsvnum() + "/cancel";

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", ORC_TOKEN);

		// HttpEntity에 헤더 추가
        HttpEntity<JSONObject> entity = new HttpEntity<>(headers);

        try {
			ResponseEntity<JSONObject> response = restTemplate.postForEntity(url, entity, JSONObject.class);
			HttpStatus statusCode = response.getStatusCode();

			/** 성공일 경우 */
			if (statusCode.value() >= 200 && statusCode.value() < 300) {
				/** 로그저장 초기화 */
				APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
				/** 예약FLAG */
				apiRcLogVO.setApiRentDiv("O");
				apiRcLogVO.setSeqNum("1");
				apiRcLogVO.setRcRsvNum(rsvDtlVO.getRcRsvNum());
				apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());
				apiRcLogVO.setRequestMsg(url);
				apiRcLogVO.setRsvResult("0");
				/**로그 저장*/
				apiDAO.insertRcApiLog(apiRcLogVO);
				succeed = true;
			}
		} catch (HttpClientErrorException e) {
        	/** 로그저장 초기화 */
				APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
				/** 예약FLAG */
				apiRcLogVO.setApiRentDiv("O");
				apiRcLogVO.setSeqNum("1");
				apiRcLogVO.setRcRsvNum(rsvDtlVO.getRcRsvNum());
				apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());
				apiRcLogVO.setRequestMsg(url);
				apiRcLogVO.setFaultReason(e.getResponseBodyAsString());
				apiRcLogVO.setRsvResult("1");
				/**로그 저장*/
				apiDAO.insertRcApiLog(apiRcLogVO);
        	log.info("orcar cancel Error Code: " + e.getStatusCode() + "|" + rsvDtlVO.getRcRsvNum());
			log.info("orcar cancel Error Msg: " + e.getResponseBodyAsString() + "|" + rsvDtlVO.getRcRsvNum());
		}
		return succeed;
	}
}