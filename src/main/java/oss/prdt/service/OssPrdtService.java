package oss.prdt.service;

import oss.cmm.vo.CM_CONFHISTVO;
import oss.prdt.vo.PRDTSVO;
import oss.prdt.vo.PRDTVO;

import java.util.List;
import java.util.Map;



public interface OssPrdtService {

	/**
	 * 협회관리자 상품 리스트 조회
	 * 파일명 : selectPrdtList
	 * 작성일 : 2015. 10. 19. 오전 9:43:13
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	Map<String, Object> selectPrdtList(PRDTSVO prdtSVO);

	/**
	 * 상품 승인 관리
	 * 파일명 : productAppr
	 * 작성일 : 2015. 10. 19. 오후 1:14:20
	 * 작성자 : 최영철
	 * @param cm_CONFHISTVO
	 */
	void productAppr(CM_CONFHISTVO cm_CONFHISTVO);

	/**
	 * 상품 승인 관리 정보
	 * @param cm_CONFHISTVO
	 * @return
	 */
	CM_CONFHISTVO selectPrdtApprInfo(CM_CONFHISTVO cm_CONFHISTVO);

	Integer getCntRTPrdtMain(PRDTVO prdtVO);
	Integer getCntSPPrdtMain(PRDTVO prdtVO);
	Integer getCntSVPrdtMain(PRDTVO prdtVO);
	Integer getCntRfAcc(PRDTVO prdtVO);

	List<PRDTVO> chckPrdtExpireList(PRDTSVO prdtSVO);
	List<PRDTVO> chckPrdtEndList(PRDTSVO prdtSVO);
	Integer chckPrdtExpireListCnt(PRDTSVO prdtSVO);
	List<PRDTVO> chckPrdtStasticsCnt1(PRDTSVO prdtSVO);
	List<PRDTVO> chckPrdtStasticsCnt2(PRDTSVO prdtSVO);
	Map<String, Object> selectPrdtAllList(PRDTSVO prdtSVO);
	void updateTamnacardPrdtYn(PRDTSVO prdtSVO);
}
