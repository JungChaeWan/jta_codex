package oss.corp.service.impl;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.impl.CmssDAO;
import oss.corp.service.OssCorpPnsReqService;
import oss.corp.vo.*;
import oss.etc.vo.FILESVO;
import oss.user.vo.USERVO;

import javax.annotation.Resource;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

@Service("ossCorpPnsReqService")
public class OssCorpPnsReqServiceImpl implements OssCorpPnsReqService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="corpPnsReqDAO")
	private CorpPnsReqDAO corpPnsReqDAO;
	
	@Resource(name="corpDAO")
	private CorpDAO corpDAO;
	
	/*@Resource(name="hiTourDAO")
	private HiTourDAO hiTourDAO;*/
	
	@Resource(name = "cmssDAO")
	private CmssDAO cmssDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
	@Override
	public void insertCorpPnsReq(CORP_PNSREQVO corpPnsReqVO,
								 MultipartHttpServletRequest multiRequest) throws Exception {

		String requestNum = corpPnsReqDAO.getCorpPnsReqPk();

		corpPnsReqVO.setRequestNum(requestNum);

		corpPnsReqDAO.insertCorpPnsReq(corpPnsReqVO);

		String savePath = EgovProperties.getProperty("CORP.PNS.REQUEST.SAVEDFILE");

		ossFileUtilService.uploadCorpPnsRequestFile(multiRequest, savePath, requestNum);
	}

	@Override
	public Map<String, Object> selectCorpPnsReqList(CORP_PNSREQSVO corpPnsReqSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<CORP_PNSREQVO> resultList = corpPnsReqDAO.selectCorpPnsReqList(corpPnsReqSVO);
		Integer totalCnt = corpPnsReqDAO.getCntCorpPnsReqList(corpPnsReqSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public CORP_PNSREQVO selectCorpPnsReq(CORP_PNSREQVO corpPnsReqVO) {
		return corpPnsReqDAO.selectCorpPnsReq(corpPnsReqVO);
	}

	@Override
	public void updateCorpPnsReq(CORP_PNSREQVO corpPnsReqVO, MultipartHttpServletRequest multiRequest) throws Exception {
		corpPnsReqDAO.updateCorpPnsReq(corpPnsReqVO);

		// 입점신청 서류 업로드
		String savePath = EgovProperties.getProperty("CORP.PNS.REQUEST.SAVEDFILE");

		ossFileUtilService.uploadCorpPnsRequestFile(multiRequest, savePath, corpPnsReqVO.getRequestNum());
	}

	@Override
	public void apprCorpPnsReq(CORP_PNSREQVO corpPnsReqVO) {
		corpPnsReqDAO.apprCorpPnsReq(corpPnsReqVO);
	}

	@Override
	public String saveCorpAccount(CORPVO corpVO) {
		// 업체 정보 테이블 insert
		CORP_PNSREQVO corpPnsReqVO = new CORP_PNSREQVO();
		corpPnsReqVO.setRequestNum(corpVO.getRequestNum());
		corpPnsReqVO = selectCorpPnsReq(corpPnsReqVO);
		
		String corpId = corpPnsReqDAO.insertCorp(corpVO);
		
		// 수수료 승인내역 등록
		CMSSVO cmssVO = new CMSSVO();
		cmssVO.setCmssNum(corpVO.getCmssNum());
		
		cmssVO = cmssDAO.selectByCmss(cmssVO);

		cmssVO.setCorpId(corpId);
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cmssVO.setRegId(corpInfo.getUserId());
		cmssVO.setConfDiv("INS");
		
		cmssDAO.insertCmssConfHist(cmssVO);
		
		// B2B 수수료 승인내역 등록
		CMSSVO cmssVO2 = new CMSSVO();
		cmssVO2.setCmssNum(corpVO.getB2bCmssNum());
		
		cmssVO2 = cmssDAO.selectByCmss(cmssVO2);

		cmssVO2.setCorpId(corpId);
		cmssVO2.setRegId(corpInfo.getUserId());
		cmssVO2.setConfDiv("INS");
		
		cmssDAO.insertCmssConfHist(cmssVO2);
		
		// 업체 ID / 사용자 ID 매핑.
		CORPADMVO corpAdmVO = new CORPADMVO();
		corpAdmVO.setCorpId(corpId);
		corpAdmVO.setUserId(corpPnsReqVO.getFrstRegId());

		corpDAO.mergeCorpAdm(corpAdmVO);
		
		// 업체 신청 테이블 CONF_CORP_ID 값 update, CorpCd 선택한거 update
		corpPnsReqVO.setConfCorpId(corpId);
		corpPnsReqVO.setCorpCd(corpVO.getCorpCd());

		corpPnsReqDAO.updateConfCorpId(corpPnsReqVO);

		// 신청서류 파일 정보 수정(REQUEST_NUM -> CORP_ID)
		CORP_PNSREQFILEVO corpPnsreqfileVO = new CORP_PNSREQFILEVO();
		corpPnsreqfileVO.setRequestNum(corpVO.getRequestNum());
		corpPnsreqfileVO.setCorpId(corpId);

		corpPnsReqDAO.updateCorpPnsReqFile(corpPnsreqfileVO);
		return corpId;
	}

	@Override
	public List<VISIT_JEJU> selectVisitJeju(VISIT_JEJU visitVO) {
		List<VISIT_JEJU> visitJejuList = new ArrayList<VISIT_JEJU>();	
		
		try {			
			if (EgovStringUtil.isEmpty(visitVO.getPage())) {
				visitVO.setPage("1");
			}
    		
    		// 운영
    		String visitApiUrl = "https://api.visitjeju.net/interface/contents/list.json?locale=kr&apiKey=0ab179792e444aafbd03a1f0415c43fc&device=pc&sorting=" + URLEncoder.encode("created desc", "UTF-8") + "&page=" + visitVO.getPage();
    		// 개발
    		//String visitApiUrl = "http://ice-dev-k.i-on.net:8080/interface/contents/list.json?locale=kr&apiKey=0ab179792e444aafbd03a1f0415c43fc&device=PC&sorting=" + URLEncoder.encode("created desc", "UTF-8") + "&page=" + visitVO.getPage();
    		if (EgovStringUtil.isEmpty(visitVO.getTitle()) == false) {
    			visitApiUrl += "&title=" + URLEncoder.encode(visitVO.getTitle(), "UTF-8");
    		}
    		    		
    		URL url = new URL(visitApiUrl);
    		
    		Scanner scan = new Scanner(url.openStream());
    		String jsonText = new String();
    		while (scan.hasNext()) {
    			jsonText += scan.nextLine();
    		}
    		scan.close();
    		
    		JSONObject obj = new org.json.JSONObject(jsonText);
    		if ("SUCCESS".equals(obj.getString("resultMessage"))) {
    			JSONArray items = obj.getJSONArray("items");
    			String pageSize = obj.getString("pageSize");
    			String pageCount = obj.getString("pageCount");
    			String totalCount = obj.getString("totalCount");
    			String currentPage = obj.getString("currentPage");
    			
    			for (int i=0, end=items.length(); i<end; i++) {
    				JSONObject item = (JSONObject) items.get(i);
    				
    				if (EgovStringUtil.isEmpty(item.getString("contentsid")) == false) {
	    				VISIT_JEJU visitInfo = new VISIT_JEJU();
	    				visitInfo.setTitle(item.getString("title"));
	    				visitInfo.setContentsid(item.getString("contentsid"));
	    				visitInfo.setAddress(item.getString("address"));
	    				String createdInfo = item.getString("created");
	    				visitInfo.setCreatedDate(createdInfo.substring(0, 4) + "-" + createdInfo.substring(4, 6) + "-" + createdInfo.substring(6, 8));
	    				visitInfo.setPageCount(pageCount);
	    				visitInfo.setTotalCount(totalCount);
	    				visitInfo.setPageSize(pageSize);
	    				visitInfo.setCurrentPage(currentPage);
	    				
	    				visitJejuList.add(visitInfo);
    				}
    			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {			
		}
		
		return visitJejuList;
	}

	@Override
	public Integer getCntCorpPnsMain(CORP_PNSREQVO corpPnsReqVO) {
		return corpPnsReqDAO.getCntCorpPnsMain(corpPnsReqVO);
	}


	@Override
	public List<CORP_PNSREQFILEVO> selectCorpPnsReqFileList(CORP_PNSREQFILEVO corpPnsReqFileVO) {
		return corpPnsReqDAO.selectCorpPnsReqFileList(corpPnsReqFileVO);
	}

	@Override
	public Map<String, Object> selectFileList(FILESVO fileSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<FILESVO> resultList = corpPnsReqDAO.selectFileList(fileSVO);

		Integer totalCnt = corpPnsReqDAO.selectFileListCnt(fileSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}


}
