package oss.marketing.serive;

import java.util.List;
import java.util.Map;

import oss.marketing.vo.ADTMAMTVO;

public interface OssAdtmAmtService {
	/**
	 * 년월에 해당하는 광고비 리스트
	 * Function : selectAdtmAmtList
	 * 작성일 : 2016. 9. 27. 오전 11:28:07
	 * 작성자 : 정동수
	 * @param adtmAmtVO
	 * @return
	 */
	List<ADTMAMTVO > selectAdtmAmtList(ADTMAMTVO adtmAmtVO);
	
	/**
	 * 년월에 해당하는 매출액 리스트
	 * Function : selectSaleAmtList
	 * 작성일 : 2016. 9. 27. 오후 3:16:12
	 * 작성자 : 정동수
	 * @param adtmAmtVO
	 * @return
	 */
	Map<String, String> selectSaleAmtList(ADTMAMTVO adtmAmtVO);
	
	/**
	 * 일자에 해당하는 광고비 리스트 등록
	 * Function : insertAdtmAmtList
	 * 작성일 : 2016. 9. 27. 오후 2:35:43
	 * 작성자 : 정동수
	 * @param amtList
	 */
	void mergeAdtmAmtList(List<ADTMAMTVO> amtList);
}
