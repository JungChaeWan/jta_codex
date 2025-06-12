package oss.corp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.b2b.service.impl.B2bDAO;
import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CORPCONFVO;
import mas.b2b.vo.B2B_CTRTSVO;
import mas.b2b.vo.B2B_CTRTVO;
import mas.corp.vo.DLVCORPVO;
import mas.rc.service.impl.RcDAO;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.bis.vo.BISSVO;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.impl.CmssDAO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.*;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("ossCorpService")
public class OssCorpServiceImpl extends EgovAbstractServiceImpl implements OssCorpService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(OssCorpServiceImpl.class);

	/** CorpDAO */
	@Resource(name = "corpDAO")
	private CorpDAO corpDAO;

	/** RcDAO */
	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	/*@Resource(name="hiTourDAO")
	private HiTourDAO hiTourDAO;*/

	@Resource(name = "cmssDAO")
	private CmssDAO cmssDAO;

	@Resource(name = "b2bDAO")
	private B2bDAO b2bDAO;

	@Override
	public void insertCorp(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String corpId = corpDAO.insertCorp(corpVO);

		// 입점신청서류 업로드
		String savePath = EgovProperties.getProperty("CORP.PNS.REQUEST.SAVEDFILE");

		ossFileUtilService.uploadCorpPnsRequestFile(multiRequest, savePath, corpVO.getCorpId());

		// B2C 수수료 승인내역 등록
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

		// 업체 담당자가 지정이 된 경우
		if(corpVO.getManagerId() != null && !corpVO.getManagerId().isEmpty()) {
			CORPADMVO corpAdmVO = new CORPADMVO();
			corpAdmVO.setCorpId(corpId);
			corpAdmVO.setUserId(corpVO.getManagerId());

			corpDAO.mergeCorpAdm(corpAdmVO);
		}

	}

	@Override
	public Map<String, Object> selectCorpList(CORPSVO corpSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CORPVO> resultList = corpDAO.selectCorpList(corpSVO);
		Integer totalCnt = corpDAO.getCntCorpList(corpSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public int getCountCorp(CORPSVO corpsvo) {
		return corpDAO.getCntCorpList(corpsvo);
	}

	@Override
	public Map<String, Object> selectCorpListSMSMail(CORPSVO corpSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CORPVO> resultList = corpDAO.selectCorpListSMSMail(corpSVO);
		Integer totalCnt = corpDAO.getCntCorpListSMSMail(corpSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}


	@Override
	public CORPVO selectByCorp(CORPVO corpSVO){
		return corpDAO.selectByCorp(corpSVO);
	}

	@Override
	public CORPVO selectByCorpVisitJeju(CORPVO corpSVO){
		return corpDAO.selectByCorpVisitJeju(corpSVO);
	}

	@Override
	public void updateCorp(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception {
		CORPVO corpSVO = new CORPVO();
		corpSVO.setCorpId(corpVO.getCorpId());

		CORPVO oCorpVO = corpDAO.selectByCorp(corpSVO);

		corpDAO.updateCorp(corpVO);

		//업체의 거래상태를 '거래중지' 상태로 변경 시 상품들을 '판매중지' 상태로 변경
		if("TS07".equals(corpVO.getTradeStatusCd())){
			corpDAO.updatePrdtInfo(oCorpVO);
		}

		// 입점신청서류 업로드
		String savePath = EgovProperties.getProperty("CORP.PNS.REQUEST.SAVEDFILE");

		ossFileUtilService.uploadCorpPnsRequestFile(multiRequest, savePath, corpVO.getCorpId());

		if(!corpVO.getCmssNum().equals(oCorpVO.getCmssNum())) {
			// 수수료 승인내역 등록
			CMSSVO cmssVO = new CMSSVO();
			cmssVO.setCmssNum(corpVO.getCmssNum());

			cmssVO = cmssDAO.selectByCmss(cmssVO);

			cmssVO.setCorpId(corpVO.getCorpId());
			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
			cmssVO.setRegId(corpInfo.getUserId());
			cmssVO.setConfDiv("UDT");

			cmssDAO.insertCmssConfHist(cmssVO);
		}

		if(!corpVO.getB2bCmssNum().equals(oCorpVO.getB2bCmssNum())) {
			// B2B 수수료 승인내역 등록
			CMSSVO cmssVO = new CMSSVO();
			cmssVO.setCmssNum(corpVO.getB2bCmssNum());

			cmssVO = cmssDAO.selectByCmss(cmssVO);

			cmssVO.setCorpId(corpVO.getCorpId());
			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
			cmssVO.setRegId(corpInfo.getUserId());
			cmssVO.setConfDiv("UDT");

			cmssDAO.insertCmssConfHist(cmssVO);
		}

		// 업체 담당자가 지정이 된 경우
		if(corpVO.getManagerId() != null && !corpVO.getManagerId().isEmpty()) {
			CORPADMVO corpAdmVO = new CORPADMVO();
			corpAdmVO.setCorpId(corpVO.getCorpId());
			corpAdmVO.setUserId(corpVO.getManagerId());

			corpDAO.mergeCorpAdm(corpAdmVO);
		} else {
			CORPADMVO corpAdmVO = new CORPADMVO();
			corpAdmVO.setCorpId(corpVO.getCorpId());

			corpDAO.deleteCorpAdm(corpAdmVO);
		}
	}

	/**
	 * 렌터카 업체 전체 조회
	 * 파일명 : selectRcCorpList
	 * 작성일 : 2015. 10. 22. 오후 4:37:46
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	@Override
	public List<CORPVO> selectRcCorpList(CORPVO corpVO){
		return corpDAO.selectRcCorpList(corpVO);
	}

	@Override
	public CORPVO selectByCorpSpAddInfo(CORPVO corpVO) {
		return corpDAO.selectByCorpSpAddInfo(corpVO);
	}

	@Override
	public void updateCorpBySpAddInfo(CORPVO corpVO,
			MultipartHttpServletRequest multiRequest) throws Exception  {
		String savePath = EgovProperties.getProperty("CORP.ADTM.SAVEDFILE");

		MultipartFile adtmImgFile = multiRequest.getFile("adtmImgFile") ;
		if(!adtmImgFile.isEmpty()) {
			String newFileName = corpVO.getCorpId() + "." + FilenameUtils.getExtension(multiRequest.getFile("adtmImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(adtmImgFile, newFileName, savePath);
			corpVO.setAdtmImg(savePath + newFileName);
		}


		corpDAO.updateCouponBySpAddInfo(corpVO);

	}

	/**
	 * <pre>
	 * 파일명 : updateMasCorp
	 * 작성일 : 2015. 12. 14. 오후 9:54:08
	 * 작성자 : 함경태
	 * @param corpVO
	 */
	public void updateMasCorp(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception {
		corpDAO.updateMasCorp(corpVO);

		// 입점신청서류 업로드
		String savePath = EgovProperties.getProperty("CORP.PNS.REQUEST.SAVEDFILE");

		ossFileUtilService.uploadCorpPnsRequestFile(multiRequest, savePath, corpVO.getCorpId());
	}

	@Override
	public List<CORPVO> selectCorpDistList(CORPVO corpVO) {
		return corpDAO.selectCorpDistList(corpVO);
	}

	@Override
	public boolean isDupCoRegNum(CORPSVO corpSVO) {

		Integer cnt = corpDAO.getCntCorpList(corpSVO);
		if(cnt > 0 ) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public CORPVO selectCorpByCorpId(CORPVO corpVO) {
		return corpDAO.selectCorpByCorpId(corpVO);
	}

	@Override
	public List<CORPADMVO> selectCorpAdmList(CORPADMVO corpAdmVO) {
		return corpDAO.selectCorpAdmList(corpAdmVO);
	}

	@Override
	public List<CORPVO> selectCorpListSMSMail(CORPVO corpVO) {
		return corpDAO.selectCorpListSMSMail(corpVO);
	}

	@Override
	public List<CORPVO> selectCorpListExcel(CORPSVO corpSVO) {
		return corpDAO.selectCorpListExcel(corpSVO);
	}

	/**
	 * Visit제주 매핑 해제
	 * Function : updateNonVisitMapping
	 * 작성일 : 2018. 2. 2. 오전 12:05:59
	 * 작성자 : 정동수
	 * @param corpVO
	 */
	@Override
	public void updateNonVisitMapping(CORPVO corpVO){		
		corpDAO.updateNonVisitMapping(corpVO);
	}

	/**
	 * B2B 승인 리스트 조회
	 * 파일명 : selectB2bCorpList
	 * 작성일 : 2016. 9. 6. 오후 4:47:36
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectB2bCorpList(B2B_CORPCONFSVO corpConfSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<B2B_CORPCONFVO> resultList = b2bDAO.selectCorpConfList(corpConfSVO);
		Integer totalCnt = b2bDAO.getCntCorpConfList(corpConfSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * B2B 계약 리스트 조회
	 * 파일명 : selectCtrtCorpList
	 * 작성일 : 2016. 9. 23. 오후 3:07:44
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectCtrtCorpList(B2B_CTRTSVO ctrtSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<B2B_CTRTVO> resultList = b2bDAO.selectOssCtrtCorpList(ctrtSVO);
		Integer totalCnt = b2bDAO.selectOssCtrtCorpListCnt(ctrtSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public List<DLVCORPVO> selectDlvCorpList(CORPVO corpVO) {
		return corpDAO.selectDlvCorpList(corpVO);
	}

	@Override
	public List<DLVCORPVO> selectDlvCorpListByCorp(CORPVO corpVO) {
		return corpDAO.selectDlvCorpListByCorp(corpVO);
	}

	@Override
	public void updateDlvCorp(DLVCORPVO dlvCorpVO) {
		corpDAO.deleteDlvCorpMng(dlvCorpVO);

		corpDAO.insertDlvCorpMng(dlvCorpVO);
	}

	/**
	 * LINK 상품 사용 여부 리턴
	 * 파일명 : selectLinkPrdtUseYn
	 * 작성일 : 2016. 11. 24. 오후 4:50:09
	 * 작성자 : 최영철
	 * @return
	 */
	public String selectLinkPrdtUseYn(){
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(corpInfo.getCorpId());

		// 업체 기본정보 조회
		CORPVO resultVO = corpDAO.selectByCorp(corpVO);

		return resultVO.getLinkPrdtUseYn();
	}

	/**
	 * 업체 광고 정보 조회
	 * 파일명 : selectCorpAdtmMng
	 * 작성일 : 2017. 2. 24. 오후 4:09:55
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	@Override
	public CORPADTMMNGVO selectCorpAdtmMng(CORPVO corpVO){
		return corpDAO.selectCorpAdtmMng(corpVO);
	}

	/**
	 * 업체 광고 정보 수정
	 * 파일명 : updateCorpAdtm
	 * 작성일 : 2017. 2. 28. 오전 10:55:59
	 * 작성자 : 최영철
	 * @param corpAdtmMngVO
	 * @param multiRequest
	 * @throws Exception
	 */
	@Override
	public void updateCorpAdtm(CORPADTMMNGVO corpAdtmMngVO,
			MultipartHttpServletRequest multiRequest) throws Exception{

		String savePath = EgovProperties.getProperty("CORP.ADTM.SAVEDFILE2");



		MultipartFile adtmImgFile = multiRequest.getFile("adtmImgFile") ;
		if(!adtmImgFile.isEmpty()) {
			String newFileName = corpAdtmMngVO.getCorpId() + "." + FilenameUtils.getExtension(multiRequest.getFile("adtmImgFile").getOriginalFilename());

			ossFileUtilService.uploadFile(adtmImgFile, newFileName, savePath);

			corpAdtmMngVO.setCorpRptImgFileNm(newFileName);
			corpAdtmMngVO.setCorpRptImgPath(savePath);
		}

		corpDAO.updateCorpAdtm(corpAdtmMngVO);

	}

	/**
	 * 업체 지수 리스트 출력
	 * 파일명 : selectCorpLevel
	 * 작성일 : 2017. 9. 28. 오전 10:40:18
	 * 작성자 : 정동수
	 * @param bisSVO 
	 */
	@Override
	public List<CORPLEVELVO> selectCorpLevel(BISSVO bisSVO) {
		return corpDAO.selectCorpLevel(bisSVO);
	}
	
	/**
	 * 업체 지수 정보 출력
	 * 파일명 : selectCorpInfo
	 * 작성일 : 2017. 10. 10. 오전 10:48:45
	 * 작성자 : 정동수
	 * @param corpId 
	 */
	@Override
	public CORPLEVELVO selectCorpInfo(String corpId) {
		return corpDAO.selectCorpLevelInfo(corpId);
	}
	
	/**
	 * 업체 지수 정보 수정
	 * 파일명 : updateLevelModInfo
	 * 작성일 : 2017. 10. 10. 오전 11:30:22
	 * 작성자 : 정동수
	 * @param corpLevelVO 
	 */
	@Override
	public void updateLevelModInfo(CORPLEVELVO corpLevelVO) {
		corpDAO.updateLevelModInfo(corpLevelVO);
	}
	
	@Override
	public List<CORPRCMDVO> selectCorpRcmdList(CORPRCMDVO corpRcmdVO) {		
		return corpDAO.selectCorpRcmdList(corpRcmdVO);
	}

	@Override
	public void insertCorpRcmd(CORPRCMDVO corpRcmdVO) {
		corpDAO.insertCorpRcmd(corpRcmdVO);
	}

	@Override
	public void deleteCorpRcmd() {
		corpDAO.deleteCorpRcmd();
	}

	@Override
	public void updateTamnacardMng(TAMNACARDSVO tamnacardsvo) {
		corpDAO.updateTamnacardMng(tamnacardsvo);
	}
}
