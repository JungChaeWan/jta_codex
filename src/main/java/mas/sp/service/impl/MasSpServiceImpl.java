package mas.sp.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_DTLINFVO;
import mas.sp.vo.SP_DTLINF_ITEMVO;
import mas.sp.vo.SP_GUIDINFOVO;
import mas.sp.vo.SP_OPTINFVO;
import mas.sp.vo.SP_PRDTINFSVO;
import mas.sp.vo.SP_PRDTINFVO;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssExcelService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.impl.CmmConfhistDAO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.cmm.vo.CM_SRCHWORDVO;
import oss.rsv.vo.OSS_RSVEXCELVO;
import oss.sp.service.impl.SpDAO;
import web.order.vo.MRTNVO;
import web.order.vo.RSVSVO;
import common.Constant;
import egovframework.cmmn.service.EgovProperties;

@Service("masSpService")
public class MasSpServiceImpl implements MasSpService {
	private static final Logger log = LoggerFactory.getLogger(MasSpServiceImpl.class);
	/** SpDAO */
	@Resource(name = "spDAO")
	private SpDAO spDAO;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "cmmConfhistDAO")
	private CmmConfhistDAO cmmConfhistDAO;

	@Resource(name = "ossExcelService")
	private OssExcelService ossExcelService;

	@Override
	public Map<String, Object> selectSpPrdtInfList(SP_PRDTINFSVO sp_prdtinfSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<SP_PRDTINFVO> resultList = spDAO.selectSpPrdtInfList(sp_prdtinfSVO);
		Integer totalCnt = spDAO.getCntSpPrdtInfList(sp_prdtinfSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public SP_PRDTINFVO selectBySpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
		SP_PRDTINFVO resultVO = spDAO.selectBySpPrdtInf(sp_PRDTINFVO);
//		resultVO.setUseQlfct(commonDAO.getLobData("spPrdt", "useQlfct", resultVO.getPrdtNum()));
//		resultVO.setCancelGuide(commonDAO.getLobData("spPrdt", "cancelGuide", resultVO.getPrdtNum()));

		if(resultVO != null){
			resultVO.setSrchWord1(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "1"));
			resultVO.setSrchWord2(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "2"));
			resultVO.setSrchWord3(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "3"));
			resultVO.setSrchWord4(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "4"));
			resultVO.setSrchWord5(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "5"));
			resultVO.setSrchWord6(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "6"));
			resultVO.setSrchWord7(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "7"));
			resultVO.setSrchWord8(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "8"));
			resultVO.setSrchWord9(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "9"));
			resultVO.setSrchWord10(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "10"));
		}

		return resultVO;
	}

	@Override
	public String insertSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO, String fileList) throws Exception {
		// 승인상태 - 등록중
		sp_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_REG);

		if(sp_PRDTINFVO.getUseAbleTm() == null || StringUtils.isEmpty(String.valueOf(sp_PRDTINFVO.getUseAbleTm()))) {
			sp_PRDTINFVO.setUseAbleTm(0);
		}
		if(Constant.FLAG_N.equals(sp_PRDTINFVO.getExprDaynumYn())) {
			sp_PRDTINFVO.setExprDaynum(0);
		}

		String prdtNum = (String) spDAO.insertSpPrdtInf(sp_PRDTINFVO);

		String savePath = EgovProperties.getProperty("PRODUCT.SP.SAVEDFILE");

		ossFileUtilService.dextUploadImgFileList(fileList, savePath, prdtNum);

		// 숙박 개별 상품인 경우
		if(Constant.CATEGORY_PACK_AD.equals(sp_PRDTINFVO.getCtgr())){
			// 주요정보.
			CM_ICONINFVO icon = new CM_ICONINFVO();
			icon.setLinkNum(sp_PRDTINFVO.getPrdtNum());
			icon.setIconCds(sp_PRDTINFVO.getIconCd());
			icon.setFrstRegId(sp_PRDTINFVO.getFrstRegId());
			ossCmmService.insertCmIconinf(icon);
		}

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(sp_PRDTINFVO.getPrdtNum());
		srchWordVO.setFrstRegId(sp_PRDTINFVO.getFrstRegId());
		srchWordVO.setLastModId(sp_PRDTINFVO.getFrstRegId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);

		/*sp_PRDTINFVO.setPrdtNum(prdtNum);
		updateSpPrdtInf(sp_PRDTINFVO);*/
		return prdtNum;
	}

	@Override
	public void updateSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO, MultipartHttpServletRequest multiRequest) throws Exception {
		this.updateSpPrdtInf(sp_PRDTINFVO);

	}

	@Override
	public void insertSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		spDAO.insertSpOptInf(sp_OPTINFVO);
	}

	@Override
	public void updateSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
		spDAO.updateSpPrdtInf(sp_PRDTINFVO);

		// 숙박 개별 상품인 경우
		if(Constant.CATEGORY_PACK_AD.equals(sp_PRDTINFVO.getCtgr())){
			// 주요정보.
			CM_ICONINFVO icon = new CM_ICONINFVO();
			icon.setLinkNum(sp_PRDTINFVO.getPrdtNum());
			icon.setIconCds(sp_PRDTINFVO.getIconCd());
			icon.setFrstRegId(sp_PRDTINFVO.getLastModId());
			ossCmmService.updateCmIconinf(icon);
		}

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(sp_PRDTINFVO.getPrdtNum());
		srchWordVO.setFrstRegId(sp_PRDTINFVO.getLastModId());
		srchWordVO.setLastModId(sp_PRDTINFVO.getLastModId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(sp_PRDTINFVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);
	}
	
	@Override
	public void salePrintN(SP_PRDTINFVO sp_PRDTINFVO) {
		spDAO.salePrintN(sp_PRDTINFVO);
	}	

	@Override
	public void insertSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		spDAO.insertSpDivInf(sp_DIVINFVO);
	}

	@Override
	public List<SP_OPTINFVO> selectPrdtOptionList(SP_OPTINFVO sp_OPTINFVO) {
		return spDAO.selectSpDivOptInf(sp_OPTINFVO);
	}

	@Override
	public SP_DIVINFVO selectSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		return spDAO.selectSpDivInf(sp_DIVINFVO);
	}

	@Override
	public Integer selectDivInfMaxViewSn(SP_DIVINFVO sp_DIVINFVO) {
		return spDAO.selectDivInfMaxViewSn(sp_DIVINFVO);
	}

	@Override
	public void addDivViewSn(SP_DIVINFVO oldVO) {
		spDAO.addDivViewSn(oldVO);
	}

	@Override
	public void minusDivViewSn(SP_DIVINFVO oldVO) {
		spDAO.minusDivViewSn(oldVO);
	}

	@Override
	public void updateSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		spDAO.updateSpDivInf(sp_DIVINFVO);

	}

	@Override
	public void deleteSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		spDAO.deleteSpDivInf(sp_DIVINFVO);

	}

	@Override
	public void deleteSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		spDAO.deleteSpOptInf(sp_OPTINFVO);
	}

	@Override
	public void deleteSpAllOptInf(SP_OPTINFVO sp_OPTINFVO) {
		spDAO.deleteSpAllOptInf(sp_OPTINFVO);
	}

	@Override
	public Integer selectOptInfMaxViewSn(SP_OPTINFVO sp_OPTINFVO) {
		return spDAO.selectOptInfMaxViewSn(sp_OPTINFVO);
	}

	@Override
	public void addOptViewSn(SP_OPTINFVO oldVO) {
		spDAO.addOptViewSn(oldVO);

	}

	@Override
	public void minusOptViewSn(SP_OPTINFVO oldVO) {
		spDAO.minusOptViewSn(oldVO);

	}

	@Override
	public SP_OPTINFVO selectSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		return (SP_OPTINFVO) spDAO.selectSpOptInf(sp_OPTINFVO);
	}

	@Override
	public void updateSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		spDAO.updateSpOptInf(sp_OPTINFVO);

	}

	@Override
	public void deleteSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
		spDAO.deleteSpPrdtInf(sp_PRDTINFVO);
	}

	@Override
	public String btnApproval(SP_PRDTINFVO sp_PRDTINFVO) {
		if(Constant.TRADE_STATUS_REG.equals(sp_PRDTINFVO.getTradeStatus())) {

			if(!Constant.SP_PRDT_DIV_FREE.equals(sp_PRDTINFVO.getPrdtDiv()) ) {
				SP_OPTINFVO sp_OPTINFVO = new SP_OPTINFVO();
				sp_OPTINFVO.setPrdtNum(sp_PRDTINFVO.getPrdtNum());
				List<SP_OPTINFVO> ss = spDAO.selectSpOptInfList(sp_OPTINFVO);
				if(ss.size() > 0) {
					return Constant.TRADE_STATUS_REG;
				}
			} else {
				return Constant.TRADE_STATUS_REG;
			}
		} else if(Constant.TRADE_STATUS_APPR_REQ.equals(sp_PRDTINFVO.getTradeStatus())) {
			return Constant.TRADE_STATUS_APPR_REQ;
		} else if(Constant.TRADE_STATUS_EDIT.equals(sp_PRDTINFVO.getTradeStatus())) {
			return Constant.TRADE_STATUS_REG;
		}
		return Constant.TRADE_STATUS_APPR;
	}

	/**
	 * 쇼셜상품 재고관리 리스트
	 */
	@Override
	public List<SP_OPTINFVO> selectStockList(SP_PRDTINFVO sp_PRDTINFVO) {
		return spDAO.selectStockList(sp_PRDTINFVO);
	}

	/**
	 * 현재 판매중인 상품 리스트
	 */
	@Override
	public List<SP_PRDTINFVO> selectSpPrdtSaleList(SP_PRDTINFVO sp_PRDTINFVO) {
		sp_PRDTINFVO.setStockYn(Constant.FLAG_Y);
		sp_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
		return spDAO.selectSpPrdtSaleList(sp_PRDTINFVO);
	}

	@Override
	public void updateDdlYn(SP_OPTINFVO sp_OPTINFVO) {
		spDAO.updateDdlYn(sp_OPTINFVO);
	}

	@Override
	public List<SP_PRDTINFVO> selectPrmtProductList(SP_PRDTINFVO sp_PRDTINFVO) {
		return spDAO.selectPrmtProductList(sp_PRDTINFVO);
	}

	@Override
	public void insertBatchSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		 spDAO.insertBatchSpOptInf(sp_OPTINFVO);
	}

	@Override
	public String copyProduct(SP_PRDTINFVO sp_PRDTINFVO) throws Exception {
		// 상품 기본 정보 넣기(SELECT INSERT)
    	String newPrdtNum = spDAO.copyBySpPrdtInf(sp_PRDTINFVO);

    	// 상품 구분자 정보 넣기.(SELECT INSERT)
    	sp_PRDTINFVO.setNewPrdtNum(newPrdtNum);
    	spDAO.copyBySpDivInf(sp_PRDTINFVO);

    	// 상품 옵션 정보 넣기.
    	spDAO.copyBySpOptInf(sp_PRDTINFVO);

    	// 상품 이미지 넣기.
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(sp_PRDTINFVO.getPrdtNum());
    	imgVO.setNewLinkNum(newPrdtNum);
    	ossCmmService.insertPrdtimgCopy(imgVO);

    	// 상품 상세 이미지 정보 넣기.
    	CM_DTLIMGVO imgDtlVO = new CM_DTLIMGVO();
    	imgDtlVO.setLinkNum(sp_PRDTINFVO.getPrdtNum());
    	imgDtlVO.setNewLinkNum(newPrdtNum);
    	ossCmmService.insertPrdtDtlimgCopy(imgDtlVO);

    	return newPrdtNum;

	}

	@Override
	public String prdtApprMsg(String prdtNum) {
		return (String) cmmConfhistDAO.selectApprMsg(prdtNum);
	}

	@Override
	public Map<String, Object> insertExcelSpOption( Workbook workbook, MultipartFile excelUpFile, String deleteOpt, SP_OPTINFVO sp_OPTINFVO) throws IOException {

		// 기존 데이터 삭제 여부
		if(Constant.FLAG_Y.equals(deleteOpt)) {
			// 옵션삭제
			spDAO.deleteSpOptInf(sp_OPTINFVO);

			SP_DIVINFVO sp_DIVINFVO = new SP_DIVINFVO();
			sp_DIVINFVO.setPrdtNum(sp_OPTINFVO.getPrdtNum());
			sp_DIVINFVO.setSpDivSn(sp_OPTINFVO.getSpDivSn());

			if(sp_OPTINFVO.getSpDivSn() == null || sp_OPTINFVO.getSpDivSn() == 0) {
				// 구분자 삭제
				spDAO.deleteSpDivInf(sp_DIVINFVO);
			}
		}

		int s_cnt = 0;
		int f_cnt = 0;
		Map<String, Object> resultCnt = new HashMap<>();

		if (excelUpFile != null && !excelUpFile.isEmpty()) {
			// 엑셀 파일 읽기
			Sheet worksheet = workbook.getSheetAt(0);
			SP_DIVINFVO sp_DIVINFVO = new SP_DIVINFVO();
			int spDivSn = 0;

			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {
				Row row = worksheet.getRow(i);

				//빈행 체크
				if (row.getCell(0).getStringCellValue() == null || row.getCell(0).getCellType() != Cell.CELL_TYPE_STRING) {
					resultCnt.put("RESULT", "ROW_FAIL");
					resultCnt.put("MESSAGE", (i + 1) + "행");
					break;
				}

				SP_OPTINFVO spOptInf = new SP_OPTINFVO();
				spOptInf.setPrdtDivNm(row.getCell(0).getStringCellValue()); //상품구분명
				spOptInf.setAplDt(Integer.toString((int) row.getCell(1).getNumericCellValue())); //적용일자
				spOptInf.setOptNm(row.getCell(2).getStringCellValue()); //옵션명
				spOptInf.setNmlAmt((int) row.getCell(3).getNumericCellValue()); //정상가
				spOptInf.setSaleAmt((int) row.getCell(4).getNumericCellValue()); //정상가
				spOptInf.setOptPrdtNum((int) row.getCell(5).getNumericCellValue()); //상품수
				spOptInf.setStdMem(Integer.toString((int) row.getCell(6).getNumericCellValue())); //기준인원
				spOptInf.setDdlYn(Constant.FLAG_N);

				if (spOptInf == null) {
					f_cnt++;
				} else {
					try {
						spOptInf.setPrdtNum(sp_OPTINFVO.getPrdtNum());

						if (sp_OPTINFVO.getSpDivSn() != null && sp_OPTINFVO.getSpDivSn() > 0) { //구분자 선택된게 있었을 경우.
							log.info("divNm :: " + sp_DIVINFVO.getPrdtDivNm());

							if (StringUtils.isEmpty(sp_DIVINFVO.getPrdtDivNm())) {
								sp_DIVINFVO.setPrdtNum(sp_OPTINFVO.getPrdtNum());
								sp_DIVINFVO.setSpDivSn(sp_OPTINFVO.getSpDivSn());
								sp_DIVINFVO = spDAO.selectSpDivInf(sp_DIVINFVO);
							}
							if (StringUtils.equals(spOptInf.getPrdtDivNm(), sp_DIVINFVO.getPrdtDivNm())) {
								spDivSn = sp_OPTINFVO.getSpDivSn();
							} else {
								spDivSn = 0;
							}
						} else if (!StringUtils.equals(spOptInf.getPrdtDivNm(), sp_DIVINFVO.getPrdtDivNm())) {
							sp_DIVINFVO.setPrdtDivNm(spOptInf.getPrdtDivNm());
							sp_DIVINFVO.setPrdtNum(spOptInf.getPrdtNum());

							int maxViewSn = spDAO.selectDivInfMaxViewSn(sp_DIVINFVO);
							sp_DIVINFVO.setViewSn(String.valueOf(maxViewSn + 1));
							spDivSn = spDAO.insertSpDivInf(sp_DIVINFVO);
						}

						if (spDivSn > 0) {
							spOptInf.setSpDivSn(spDivSn);
							int maxViewSn = spDAO.selectOptInfMaxViewSn(spOptInf);
							spOptInf.setViewSn(String.valueOf(maxViewSn + 1));
							spOptInf.setPrintYn(Constant.FLAG_Y);
							spDAO.insertSpOptInf(spOptInf);
							s_cnt++;
						}
					} catch (Exception e) {
						f_cnt++;
						log.error("SP Option excel upload :: " + e.getMessage());
					}
				}
			}
		}


		resultCnt.put("s_cnt", s_cnt);
		resultCnt.put("f_cnt", f_cnt);

		return resultCnt;

	}

	@Override
	public int updateBatchSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		return spDAO.updateBatchSpOptInf(sp_OPTINFVO);
	}

	@Override
	public List<SP_OPTINFVO> selectTourDivList(SP_OPTINFVO sp_OPTINFVO) {
		return spDAO.selectTourDivList(sp_OPTINFVO);
	}

	@Override
	public List<SP_ADDOPTINFVO> selectPrdtAddOptionList(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		return spDAO.selectPrdtAddOptionList(sp_ADDOPTINFVO);
	}

	@Override
	public Integer selectAddOptInfMaxViewSn(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		return spDAO.selectAddOptInfMaxViewSn(sp_ADDOPTINFVO);
	}

	@Override
	public void addAddOptViewSn(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		spDAO.addAddOptViewSn(sp_ADDOPTINFVO);
	}

	@Override
	public void insertSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		spDAO.insetSpAddOptInf(sp_ADDOPTINFVO);
	}

	@Override
	public SP_ADDOPTINFVO selectSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		return spDAO.selectSpAddOptInf(sp_ADDOPTINFVO);
	}

	@Override
	public void minusAddOptViewSn(SP_ADDOPTINFVO oldVO) {
		spDAO.minusAddOptViewSn(oldVO);
	}

	@Override
	public void updateSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		spDAO.updateSpAddOptInf(sp_ADDOPTINFVO);
	}

	@Override
	public void deleteAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		spDAO.deleteAddOptInf(sp_ADDOPTINFVO);
	}

	@Override
	public void updateSpTradeStatus(SP_PRDTINFVO sp_PRDTINFVO) {
		spDAO.updateSpPrdtInf(sp_PRDTINFVO);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:19:21
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Integer checkExsistPrdt(RSVSVO rsvSVO){
		return spDAO.checkExsistPrdt(rsvSVO);
	}






	@Override
	public SP_DTLINFVO selectDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		return spDAO.selectDtlInf(sp_DTLINFVO);
	}

	@Override
	public List<SP_DTLINFVO> selectDtlInfList(SP_DTLINFVO sp_DTLINFVO) {
		return spDAO.selectDtlInfList(sp_DTLINFVO);
	}

	@Override
	public List<SP_DTLINF_ITEMVO> selectDtlInfItemList(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO) {
		return spDAO.selectDtlInfItemList(sp_DTLINF_ITEMVO);
	}

	@Override
	public String insertDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		String spDtlinfNum = spDAO.getDtlInfNextNum();
		sp_DTLINFVO.setSpDtlinfNum(spDtlinfNum);
		spDAO.insetDtlInf(sp_DTLINFVO);
		return spDtlinfNum;
	}

	@Override
	public void insetDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO) {
		spDAO.insetDtlInfItem(sp_DTLINF_ITEMVO);
	}

	@Override
	public void deleteDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO) {
		spDAO.deleteDtlInfItem(sp_DTLINF_ITEMVO);
	}

	@Override
	public void updateDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		spDAO.updateDtlInf(sp_DTLINFVO);

	}

	@Override
	public void addViewSnDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		spDAO.addViewSnDtlInf(sp_DTLINFVO);

	}

	@Override
	public void minusViewSnDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		spDAO.minusViewSnDtlInf(sp_DTLINFVO);

	}

	@Override
	public Integer getDtlInfMaxSN(SP_DTLINFVO sp_DTLINFVO) {
		return spDAO.getDtlInfMaxSN(sp_DTLINFVO);
	}

	@Override
	public void deleteDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		spDAO.deleteDtlInf(sp_DTLINFVO);

	}

	@Override
	public SP_GUIDINFOVO selectGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO) {
		return spDAO.selectGuidinfo(sp_GUIDINFOVO);
	}

	@Override
	public void updateGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO) {

		SP_GUIDINFOVO giTest = new SP_GUIDINFOVO();
		giTest.setPrdtNum(sp_GUIDINFOVO.getPrdtNum());

		SP_GUIDINFOVO res = spDAO.selectGuidinfo(giTest);
		if(res==null){
			spDAO.insertGuidinfo(sp_GUIDINFOVO);
		}else{
			spDAO.updateGuidinfo(sp_GUIDINFOVO);
		}

	}

	@Override
	public void updateGuidinfoBgColor(SP_GUIDINFOVO sp_GUIDINFOVO) {

		SP_GUIDINFOVO giTest = new SP_GUIDINFOVO();
		giTest.setPrdtNum(sp_GUIDINFOVO.getPrdtNum());

		SP_GUIDINFOVO res = spDAO.selectGuidinfo(giTest);
		if(res==null){
			spDAO.insertGuidinfoBgColor(sp_GUIDINFOVO);
		}else{
			spDAO.updateGuidinfoBgColor(sp_GUIDINFOVO);
		}

	}
	
	@Override
	public List<MRTNVO> selectMrtnUserList(MRTNVO mrtnSVO){
		return spDAO.selectMrtnUserList(mrtnSVO);
	}
	
	@Override
	public void mrtnUserUpdate(MRTNVO mrtnVO) {
		spDAO.mrtnUserUpdate(mrtnVO);
	}
	
	@Override
	public MRTNVO selectMrtnTshirts(MRTNVO mrtnSVO) {
		return spDAO.selectMrtnTshirts(mrtnSVO);
	}
	
	@Override
	public void insertTshirts(MRTNVO mrtnVO) {
		spDAO.insertTshirts(mrtnVO);
	}
	
	@Override
	public void mrtnTshirtsUpdate(MRTNVO mrtnVO) {
		spDAO.mrtnTshirtsUpdate(mrtnVO);
	}
}
