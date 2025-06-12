package oss.otoinq.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import common.Constant;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.stereotype.Service;

import oss.cmm.service.OssMailService;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQ5VO;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.SMSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("ossOtoinqService")
public class OssOtoinqServiceImpl extends EgovAbstractServiceImpl implements OssOtoinqService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	/** UseepliDAO */
	@Resource(name = "otoinqDAO")
	private OtoinqDAO otoinqDAO;
	
	@Resource(name="smsService")
	protected SmsService smsService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;
	
	@Resource(name="ossCorpService")
    private OssCorpService ossCorpService;

	@Override
	public OTOINQVO selectByOtoinq(OTOINQVO otoinqVO) {
		return otoinqDAO.selectByOtoinq(otoinqVO);
	}

	@Override
	public Map<String, Object> selectOtoinqList(OTOINQSVO otoinqSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<OTOINQVO> resultList = otoinqDAO.selectOtoinqList(otoinqSVO);
		Integer totalCnt = otoinqDAO.getCntOtoinqlList(otoinqSVO);
						
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public Map<String, Object> selectOtoinqListWeb(OTOINQSVO otoinqSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<OTOINQVO> resultList = otoinqDAO.selectOtoinqListWeb(otoinqSVO);
		Integer totalCnt = otoinqDAO.getCntOtoinqlListWeb(otoinqSVO);
						
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectOtoinqListMas(OTOINQSVO otoinqSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<OTOINQVO> resultList = otoinqDAO.selectOtoinqListMas(otoinqSVO);
		Integer totalCnt = otoinqDAO.getCntOtoinqlListMas(otoinqSVO);
						
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	
	public int getCntOtoinqCnt(OTOINQSVO otoinqSVO){
		return (int)otoinqDAO.getCntOtoinqlListWeb(otoinqSVO);
	}

	@Override
	public void insertOtoinq(OTOINQVO otoinqVO) {
		otoinqDAO.insertOtoinq(otoinqVO);
	}

	@Override
	public void updateOtoinq(OTOINQVO otoinqVO) {
		otoinqDAO.updateOtoinq(otoinqVO);
	}

	@Override
	public void updateOtoinqByPrint(OTOINQVO otoinqVO) {
		otoinqDAO.updateOtoinqByPrint(otoinqVO);
	}

	@Override
	public void updateOtoinqByAnsFrst(OTOINQVO otoinqVO) {
		otoinqDAO.updateOtoinqByAnsFrst(otoinqVO);
	}

	@Override
	public void updateOtoinqByAns(OTOINQVO otoinqVO) {
		otoinqDAO.updateOtoinqByAns(otoinqVO);		
	}

	@Override
	public void deleteOtoinqByOtoinqNum(OTOINQVO otoinqVO) {
		otoinqDAO.deleteOtoinqByOtoinqNum(otoinqVO);
		
	}
	

	@Override
	public OTOINQ5VO geteOtoinqByCPName(OTOINQ5VO useepil5vo) {
		return otoinqDAO.geteOtoinqByCPName(useepil5vo);
	}

	@Override
	public int getCntOtoinqNotCmt(OTOINQVO otoinqVO) {
		return otoinqDAO.getCntOtoinqNotCmt(otoinqVO);
	}

	/**
	 * 1:1문의 등록 시 업체 담당자에게 SMS & 메일 발송
	 * Function : otoinqSnedSMSAll
	 * 작성일 : 2016. 11. 8. 오전 9:36:11
	 * 작성자 : 정동수
	 * @param otoinqVO
	 * @param request
	 */
	@Override
	public void otoinqSnedSMSAll(OTOINQVO otoinqVO, HttpServletRequest request) {
		// 업체
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(otoinqVO.getCorpId());		
		CORPVO corpRes = ossCorpService.selectByCorp(corpVO);
		if(corpRes == null){
			log.info("Not corpId");
			return;
		}
		log.info(">>>>[corp:"+ corpRes.getCorpId()+ "][" + corpRes.getAdmEmail()+ "][" + corpRes.getAdmMobile() +"]");

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

		// 담당자 SMS 발송
		SMSVO smsVO = new SMSVO();
		smsVO.setTrMsg("[탐나오]\n 1:1문의게시판에 새글이 등록되었습니다. 확인 후 답변주시기 바랍니다.("+corpRes.getCorpNm()+")");
		if("test".equals(CST_PLATFORM.trim())) {
			smsVO.setTrPhone(Constant.TAMNAO_TESTER1);
		}else{
			smsVO.setTrPhone(corpRes.getAdmMobile());
		}
		smsVO.setTrCallback(EgovProperties.getProperty("CS.PHONE"));
				
		try {
			smsService.sendSMS(smsVO);
		} catch (Exception e) {
			log.info("MMS Error");
		}

		// 담당자2 SMS 발송
		if(StringUtils.isNotEmpty(corpRes.getAdmMobile2())) {
			if ("test".equals(CST_PLATFORM.trim())) {
				smsVO.setTrPhone(Constant.TAMNAO_TESTER2);
			} else {
				smsVO.setTrPhone(corpRes.getAdmMobile2());
			}
			try {
				smsService.sendSMS(smsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}
		}

		// 담당자3 SMS 발송
		if(StringUtils.isNotEmpty(corpRes.getAdmMobile3())) {
			if ("test".equals(CST_PLATFORM.trim())) {
				smsVO.setTrPhone(Constant.TAMNAO_TESTER3);
			} else {
				smsVO.setTrPhone(corpRes.getAdmMobile3());
			}
			try {
				smsService.sendSMS(smsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}
		}

		//메일보내기 (메일 발송 안함)
//		ossMailService.sendOtoinqCorp(otoinqVO, corpRes.getAdmEmail(), request);
	}
}
