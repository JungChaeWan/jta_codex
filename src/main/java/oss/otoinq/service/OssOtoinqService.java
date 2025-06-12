package oss.otoinq.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import oss.otoinq.vo.OTOINQ5VO;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;



public interface OssOtoinqService {
	
	OTOINQVO selectByOtoinq(OTOINQVO otoinqVO);
	Map<String, Object> selectOtoinqList(OTOINQSVO otoinqSVO);
	Map<String, Object> selectOtoinqListWeb(OTOINQSVO otoinqSVO);
	Map<String, Object> selectOtoinqListMas(OTOINQSVO otoinqSVO);
	int getCntOtoinqCnt(OTOINQSVO otoinqSVO);
	int getCntOtoinqNotCmt(OTOINQVO otoinqVO);
	
	void insertOtoinq(OTOINQVO otoinqVO);
	void updateOtoinq(OTOINQVO otoinqVO);
	void updateOtoinqByPrint(OTOINQVO otoinqVO);
	void updateOtoinqByAnsFrst(OTOINQVO otoinqVO);
	void updateOtoinqByAns(OTOINQVO otoinqVO);
	void deleteOtoinqByOtoinqNum(OTOINQVO otoinqVO);	
	void otoinqSnedSMSAll(OTOINQVO otoinqVO, HttpServletRequest request);
	
	OTOINQ5VO geteOtoinqByCPName(OTOINQ5VO useepil5vo);

}
