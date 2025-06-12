package web.product.service;

import common.LowerHashMap;
import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import oss.prmt.vo.GOVASVO;
import oss.prmt.vo.GOVAVO;

import java.util.List;
import java.util.Map;

public interface WebPrmtService {

	Map<String, Object> selectPromotionList(PRMTVO prmtVO);

	Map<String, Object> selectPointList();

	PRMTVO selectByPrmt(PRMTVO prmtVO);

	List<PRMTPRDTVO> selectPrmtPrdtList(PRMTVO prmtVO);
	List<PRMTPRDTVO> selectPrmtPrdtListOss(PRMTVO prmtVO);

	List<PRMTPRDTVO> selectPrmtPrdtList(String prmtNum);

	//기획전 뷰 카운트
	void updateViewCnt(String prmtNum);
	
	/**
	 * 프로모션의 댓글 리스트
	 * Function : selectPrmtCmtList
	 * 작성일 : 2016. 8. 19. 오후 3:00:22
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 * @return
	 */
	List<PRMTCMTVO> selectPrmtCmtList(PRMTCMTVO prmtCmtVO);

	List<PRMTCMTVO> selectPrmtCmtListNopage(PRMTCMTVO prmtCmtVO);

	/**
	 * 프로모션의 댓글 총 갯수
	 * Function : selectPrmtCmtTotalCnt
	 * 작성일 : 2016. 8. 22. 오후 2:01:33
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 * @return
	 */
	int selectPrmtCmtTotalCnt(PRMTCMTVO prmtCmtVO);

	/**
	 * 프로모션의 댓글 등록
	 * Function : insertPrmtCmt
	 * 작성일 : 2016. 8. 19. 오후 3:00:40
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 */
	void insertPrmtCmt(PRMTCMTVO prmtCmtVO);

	/**
	 * 프로모션의 댓글 출력여부 수정
	 * Function : updatePrmtCmt
	 * 작성일 : 2016. 8. 30. 오후 5:18:18
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 */
	void updatePrmtCmt(PRMTCMTVO prmtCmtVO);

	/**
	 * 프로모션의 댓글 삭제
	 * Function : deletePrmtCmt
	 * 작성일 : 2016. 8. 19. 오후 3:00:59
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 */
	void deletePrmtCmt(PRMTCMTVO prmtCmtVO);
	
	/**
	 * 각 카테고리 상품 상세의 프로모션 출력
	 * Function : selectDeteilPromotionList
	 * 작성일 : 2018. 1. 9. 오후 2:30:23
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 * @return
	 */
	List<PRMTVO> selectDeteilPromotionList(PRMTPRDTVO prmtPrdtVO);

	// 프로모션 이전글 다음글
	PRMTVO getPromotionPrevNext(PRMTVO prmtVO);

	PRMTVO selectAdBanner();

    List<LowerHashMap> govaList(GOVASVO govaSVO);

	void updateGovaMemo(GOVAVO govaVO);

	void updateGovaConfirmed(GOVAVO govaVO);

	List<LowerHashMap> selectAutoCompleteList();
}
