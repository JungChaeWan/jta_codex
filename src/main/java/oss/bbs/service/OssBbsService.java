package oss.bbs.service;

import java.util.Map;

import oss.bbs.vo.BBSGRPINFSVO;
import oss.bbs.vo.BBSGRPINFVO;
import oss.bbs.vo.BBSGRPSVO;
import oss.bbs.vo.BBSGRPVO;
import oss.bbs.vo.BBSSVO;
import oss.bbs.vo.BBSVO;


public interface OssBbsService {

	Map<String, Object> selectBbsList(BBSSVO bbsSV0);

	BBSVO selectByBbs(BBSSVO bbsSV0);
	
	void insertBbs(BBSVO bbsV0);
	void updateBbs(BBSVO bbsV0);
	void deleteBbs(BBSVO bbsV0);
	
	
	Map<String, Object> selectBbsGrpInfList(BBSGRPINFSVO bbsGrpInfSV0);
	BBSGRPINFVO selectByBbsGrpInf(BBSGRPINFSVO bbsGrpInfSV0);
	void insertBbsGrpInf(BBSGRPINFVO bbsGrpInfV0);
	void updateBbsGrpInf(BBSGRPINFVO bbsGrpInfV0);
	void deleteBbsGrpInf(BBSGRPINFVO bbsGrpInfV0);

	Map<String, Object> selectBbsGrpList(BBSGRPSVO bbsGrpSV0);
	Integer getCntByBbsInf(BBSGRPVO bbsGrpV0);
	void insertBbsGrp(BBSGRPVO bbsGrpV0);
	void deleteBbsGrp(BBSGRPVO bbsGrpV0);
	void deleteBbsGrpAll(BBSGRPVO bbsGrpV0);
	

}
