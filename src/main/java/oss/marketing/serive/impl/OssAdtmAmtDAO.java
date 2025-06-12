package oss.marketing.serive.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.marketing.vo.ADTMAMTVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("OssAdtmAmtDAO")
public class OssAdtmAmtDAO extends EgovAbstractDAO {
	
	/**
	 * 년월에 해당하는 광고비 리스트
	 * Function : selectAdtmAmtList
	 * 작성일 : 2016. 9. 27. 오전 11:42:04
	 * 작성자 : 정동수
	 * @param adtmAmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADTMAMTVO> selectAdtmAmtList(ADTMAMTVO adtmAmtVO) {
		return (List<ADTMAMTVO>) list("ADTM_AMT_S_00", adtmAmtVO);
	}
	
	/**
	 * 년월에 해당하는 매출액 리스트
	 * Function : selectSaleAmtList
	 * 작성일 : 2016. 9. 27. 오후 3:33:38
	 * 작성자 : 정동수
	 * @param adtmAmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADTMAMTVO> selectSaleAmtList(ADTMAMTVO adtmAmtVO) {
		return (List<ADTMAMTVO>) list("ADTM_AMT_S_01", adtmAmtVO);
	}
	
	/**
	 * 광고비 등록 / 수정
	 * Function : mergeAdtmAmt
	 * 작성일 : 2016. 9. 27. 오후 2:44:33
	 * 작성자 : 정동수
	 * @param adtmAmtVO
	 */
	public void mergeAdtmAmt(ADTMAMTVO adtmAmtVO) {
		update("ADTM_AMT_M_00", adtmAmtVO);
	}
}
