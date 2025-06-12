package oss.bis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import oss.bis.vo.BISSVO;
import oss.bis.vo.BISVO;

import com.ibatis.sqlmap.client.SqlMapClient;

@SuppressWarnings("deprecation")
@Repository("ossBisHiDAO")
public class OssBisHiDAO extends SqlMapClientDaoSupport {
	@Resource(name="mtsSqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient){
		super.setSqlMapClient(sqlMapClient);
	}
	
	/**
	 * 하이제주의 관광지 입장권 예약 전체 매출 금액
	 * Function : selectCouponRsvAmt
	 * 작성일 : 2016. 12. 7. 오전 10:58:11
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectCouponRsvAmt(BISSVO bisSVO) {
		return (BISVO) getSqlMapClientTemplate().queryForObject("BISHI_S_00", bisSVO);
	}
	
	/**
	 * 하이제주의 관광지 입장권 예약 시간 건수 통계 (요일 & 시간별)
	 * Function : selectCouponRsvTimeCnt
	 * 작성일 : 2016. 12. 7. 오후 4:05:33
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectCouponRsvTimeCnt(BISSVO bisSVO) {
		return (List<BISVO>) getSqlMapClientTemplate().queryForList("BISHI_S_01", bisSVO);
	}
	
	/**
	 * 하이제주의 관광지 입장권 구매 개수 통계 (그래프)
	 * Function : selectCouponBuyCntPer
	 * 작성일 : 2016. 12. 7. 오후 4:54:57
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectCouponBuyCntPer(BISSVO bisSVO) {
		return (List<BISVO>) getSqlMapClientTemplate().queryForList("BISHI_S_02", bisSVO);
	}
	
	/**
	 * 하이제주의 관광지 입장권 일일현황
	 * Function : selectCouponDayPresentCondition
	 * 작성일 : 2016. 12. 9. 오전 10:11:58
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectCouponDayPresentCondition(BISSVO bisSVO) {
		return (BISVO) getSqlMapClientTemplate().queryForObject("BISHI_S_03", bisSVO);
	}
}
