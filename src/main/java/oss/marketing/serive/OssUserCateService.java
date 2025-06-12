package oss.marketing.serive;

import java.util.List;
import java.util.Map;

import mas.prmt.vo.PRMTPRDTVO;
import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;
import oss.marketing.vo.USERCATEVO;
import oss.user.vo.USERVO;

public interface OssUserCateService {

	//사용자 페이지
	List<USERVO> selectUserCate(USERCATEVO userCateVO);



}
