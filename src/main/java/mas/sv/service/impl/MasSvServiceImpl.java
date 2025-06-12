package mas.sv.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.Constant;
import egovframework.cmmn.service.EgovProperties;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_ADDOPTINFVO;
import mas.sv.vo.SV_CORPDLVAMTVO;
import mas.sv.vo.SV_DFTINFVO;
import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import mas.sv.vo.SV_PRDTINFSVO;
import mas.sv.vo.SV_PRDTINFVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssExcelService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.impl.CmmConfhistDAO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.cmm.vo.CM_SRCHWORDVO;
import web.order.vo.RSVSVO;

@Service("masSvService")
public class MasSvServiceImpl implements MasSvService {

	@Resource(name = "svDAO")
	private SvDAO svDAO;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "cmmConfhistDAO")
	private CmmConfhistDAO cmmConfhistDAO;

	@Resource(name = "ossExcelService")
	private OssExcelService ossExcelService;

	@Override
	public Map<String, Object> selectPrdtList(SV_PRDTINFSVO sv_PRDTINFSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<SV_PRDTINFVO> resultList = svDAO.selectPrdtInfList(sv_PRDTINFSVO);
		Integer totalCnt = svDAO.getCntPrdtInfList(sv_PRDTINFSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public String insertSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO, String fileList) throws Exception {
		// 승인상태 - 등록중
		sv_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_REG);

		String prdtNum = (String) svDAO.insertSvPrdtInf(sv_PRDTINFVO);

		String savePath = EgovProperties.getProperty("PRODUCT.SV.SAVEDFILE");

		ossFileUtilService.dextUploadImgFileList(fileList, savePath, prdtNum);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());
		srchWordVO.setFrstRegId(sv_PRDTINFVO.getFrstRegId());
		srchWordVO.setLastModId(sv_PRDTINFVO.getFrstRegId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);

		return prdtNum;
	}

	@Override
	public SV_PRDTINFVO selectBySvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO) {
		SV_PRDTINFVO resultVO = svDAO.selectBySvPrdtInf(sv_PRDTINFVO);

		if (resultVO != null) {
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
	public String prdtApprMsg(String prdtNum) {
		return (String) cmmConfhistDAO.selectApprMsg(prdtNum);
	}

	@Override
	public Object btnApproval(SV_PRDTINFVO resultVO) {
		if (Constant.TRADE_STATUS_REG.equals(resultVO.getTradeStatus())) {
			SV_OPTINFVO sv_OPTINFVO = new SV_OPTINFVO();
			sv_OPTINFVO.setPrdtNum(resultVO.getPrdtNum());
			List<SV_OPTINFVO> ss = svDAO.selectSvOptInfList(sv_OPTINFVO);
			if (ss.size() > 0) {
				return Constant.TRADE_STATUS_REG;
			}

		} else if (Constant.TRADE_STATUS_APPR_REQ.equals(resultVO.getTradeStatus())) {
			return Constant.TRADE_STATUS_APPR_REQ;
		} else if (Constant.TRADE_STATUS_EDIT.equals(resultVO.getTradeStatus())) {
			return Constant.TRADE_STATUS_REG;
		}
		return Constant.TRADE_STATUS_APPR;
	}

	@Override
	public void updateSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO) {
		svDAO.updateSvPrdtInf(sv_PRDTINFVO);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());
		srchWordVO.setFrstRegId(sv_PRDTINFVO.getLastModId());
		srchWordVO.setLastModId(sv_PRDTINFVO.getLastModId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);

	}
	
	@Override
	public void salePrintN(SV_PRDTINFVO sv_PRDTINFVO) {
		svDAO.salePrintN(sv_PRDTINFVO);
	}	


	@Override
	public void updateSvPrdtInfData(SV_PRDTINFVO sv_PRDTINFVO) {
		svDAO.updateSvPrdtInfData(sv_PRDTINFVO);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());
		srchWordVO.setFrstRegId(sv_PRDTINFVO.getLastModId());
		srchWordVO.setLastModId(sv_PRDTINFVO.getLastModId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(sv_PRDTINFVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);

	}

	@Override
	public void deleteSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		svDAO.deleteSvOptInf(sv_OPTINFVO);

	}

	@Override
	public void deleteSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		svDAO.deleteSvDivInf(sv_DIVINFVO);

	}

	@Override
	public void deleteSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO) {
		svDAO.deleteSvPrdtInf(sv_PRDTINFVO);
	}

	@Override
	public List<SV_OPTINFVO> selectPrdtOptionList(SV_OPTINFVO sv_OPTINFVO) {
		return svDAO.selectSvDivOptInf(sv_OPTINFVO);
	}

	@Override
	public List<SV_OPTINFVO> selectDivList(SV_OPTINFVO sv_OPTINFVO) {
		return svDAO.selectDivList(sv_OPTINFVO);
	}

	@Override
	public SV_DIVINFVO selectSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		return svDAO.selectSvDivInf(sv_DIVINFVO);
	}

	@Override
	public Integer selectDivInfMaxViewSn(SV_DIVINFVO sv_DIVINFVO) {
		return svDAO.selectDivInfMaxViewSn(sv_DIVINFVO);
	}

	@Override
	public void addDivViewSn(SV_DIVINFVO sv_DIVINFVO) {
		svDAO.addDivViewSn(sv_DIVINFVO);
	}

	@Override
	public void minusDivViewSn(SV_DIVINFVO oldVO) {
		svDAO.minusDivViewSn(oldVO);
	}

	@Override
	public void insertSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		svDAO.insertSvDivInf(sv_DIVINFVO);
	}

	@Override
	public void insertSvDivInf2(SV_DIVINFVO sv_DIVINFVO) {
		svDAO.insertSvDivInf2(sv_DIVINFVO);
	}

	@Override
	public void updateSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		svDAO.updateSvDivInf(sv_DIVINFVO);
	}

	@Override
	public Integer selectOptInfMaxViewSn(SV_OPTINFVO sv_OPTINFVO) {
		return svDAO.selectOptInfMaxViewSn(sv_OPTINFVO);
	}

	@Override
	public void addOptViewSn(SV_OPTINFVO sv_OPTINFVO) {
		svDAO.addOptViewSn(sv_OPTINFVO);

	}

	@Override
	public void minusOptViewSn(SV_OPTINFVO oldVO) {
		svDAO.minusOptViewSn(oldVO);
	}

	@Override
	public void insertOptInf(SV_OPTINFVO sv_OPTINFVO) {
		svDAO.insertSvOptInf(sv_OPTINFVO);
	}

	@Override
	public SV_OPTINFVO selectSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		return (SV_OPTINFVO) svDAO.selectSvOptInf(sv_OPTINFVO);
	}

	@Override
	public void updateSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		svDAO.updateSvOptInf(sv_OPTINFVO);
	}

	@Override
	public Integer selectAddOptInfMaxViewSn(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		return svDAO.selectAddOptInfMaxViewSn(sv_ADDOPTINFVO);
	}

	@Override
	public List<SV_ADDOPTINFVO> selectPrdtAddOptionList(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		return svDAO.selectPrdtAddOptionList(sv_ADDOPTINFVO);
	}

	@Override
	public void addAddOptViewSn(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		svDAO.addAddOptViewSn(sv_ADDOPTINFVO);

	}

	@Override
	public void insertSvAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		svDAO.insetSvAddOptInf(sv_ADDOPTINFVO);
	}

	@Override
	public SV_ADDOPTINFVO selectSvAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		return svDAO.selectSvAddOptInf(sv_ADDOPTINFVO);
	}

	@Override
	public void minusAddOptViewSn(SV_ADDOPTINFVO oldVO) {
		svDAO.minusAddOptViewSn(oldVO);
	}

	@Override
	public void updateSvAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		svDAO.updateSvAddOptInf(sv_ADDOPTINFVO);
	}

	@Override
	public void deleteAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		svDAO.deleteAddOptInf(sv_ADDOPTINFVO);

	}

	@Override
	public List<SV_PRDTINFVO> selectSvPrdtSaleList(SV_PRDTINFVO sv_PRDTINFVO) {
		sv_PRDTINFVO.setStockYn(Constant.FLAG_Y);
		sv_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
		return svDAO.selectSvPrdtSaleList(sv_PRDTINFVO);
	}

	@Override
	public List<SV_OPTINFVO> selectStockList(SV_PRDTINFVO sv_PRDTINFVO) {
		return svDAO.selectStockList(sv_PRDTINFVO);
	}

	@Override
	public void updateDdlYn(SV_OPTINFVO sv_OPTINFVO) {
		svDAO.updateDdlYn(sv_OPTINFVO);
	}

	@Override
	public List<SV_PRDTINFVO> selectPrmtProductList(SV_PRDTINFVO sv_PRDTINFVO) {
		return svDAO.selectPrmtProductList(sv_PRDTINFVO);
	}

	@Override
	public String copyProduct(SV_PRDTINFVO sv_PRDTINFVO) throws Exception {
		// 상품 기본 정보 넣기(SELECT INSERT)
    	String newPrdtNum = svDAO.copyBySvPrdtInf(sv_PRDTINFVO);

    	// 상품 구분자 정보 넣기.(SELECT INSERT)
    	sv_PRDTINFVO.setNewPrdtNum(newPrdtNum);
    	svDAO.copyBySvDivInf(sv_PRDTINFVO);

    	// 상품 옵션 정보 넣기.
    	svDAO.copyBySvOptInf(sv_PRDTINFVO);

    	// 상품 이미지 넣기.
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());
    	imgVO.setNewLinkNum(newPrdtNum);
    	ossCmmService.insertPrdtimgCopy(imgVO);

    	// 상품 상세 이미지 정보 넣기.
    	CM_DTLIMGVO imgDtlVO = new CM_DTLIMGVO();
    	imgDtlVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());
    	imgDtlVO.setNewLinkNum(newPrdtNum);
    	ossCmmService.insertPrdtDtlimgCopy(imgDtlVO);

    	return newPrdtNum;
	}

	@Override
	public SV_CORPDLVAMTVO selectCorpDlvAmt(String corpId) {
		return svDAO.selectCorpDlvAmt(corpId);
	}

	@Override
	public void saveCorpDlvAmt(SV_CORPDLVAMTVO sv_CORPDLVAMTVO) {
		svDAO.saveCorpDlvAmt(sv_CORPDLVAMTVO);

		//  기존에 등록되어 있는 옵션 배송비 다시 설정.
		svDAO.updateOptinfDlvAmt(sv_CORPDLVAMTVO.getCorpId());
	}

	@Override
	public void updateSvTradeStatus(SV_PRDTINFVO sv_PRDTINFVO) {
		svDAO.updateSvPrdtInf(sv_PRDTINFVO);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:27:09
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Integer checkExsistPrdt(RSVSVO rsvSVO){
		return svDAO.checkExsistPrdt(rsvSVO);
	}

	@Override
	public SV_DFTINFVO selectBySvDftinf(SV_DFTINFVO spVO) {
		return svDAO.selectBySvDftinf(spVO);
	}

	@Override
	public String insertSvDftinf(SV_DFTINFVO spVO) {
		return svDAO.insertSvDftinf(spVO);
	}

	@Override
	public void updateSvDftinf(SV_DFTINFVO spVO) {
		svDAO.updateSvDftinf(spVO);
	}

}
