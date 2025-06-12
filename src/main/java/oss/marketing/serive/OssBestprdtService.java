package oss.marketing.serive;

import java.util.List;
import java.util.Map;

import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;

public interface OssBestprdtService {

	Map<String, Object> selectBestprdtList(BESTPRDTSVO bestprdtSVO);

	BESTPRDTVO selectBestprdt(BESTPRDTVO bestprdtVO);
	Integer getMaxCntBestprdtPos(BESTPRDTVO bestprdtVO);

	void insertBestprdt(BESTPRDTVO bestprdtVO);

	void updateBestprdt(BESTPRDTVO bestprdtVO);
	void addViewSn(BESTPRDTVO bestprdtVO);
	void minusViewSn(BESTPRDTVO bestprdtVO);

	void deleteBestprdt(BESTPRDTVO bestprdtVO);

	//항공 메인 출력
	List<BESTPRDTVO> selectBestprdtWebList(BESTPRDTSVO bestprdtSVO);

}
