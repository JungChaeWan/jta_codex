package web.product.service.impl;

import org.springframework.stereotype.Repository;

import web.product.vo.PRDTINQVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("WebPrdtInqDAO")
public class WebPrdtInqDAO extends EgovAbstractDAO {
	/**
	 * 조회 정보 출력
	 * Function : selectPrdtInq
	 * 작성일 : 2016. 9. 13. 오전 11:48:25
	 * 작성자 : 정동수
	 * @param prdtInqVO
	 * @return
	 */
	public PRDTINQVO selectPrdtInq(PRDTINQVO prdtInqVO) {
		return (PRDTINQVO) select("prdtInq_S_00", prdtInqVO);
	}
	
	/**
	 * 상품 조회 수 등록
	 * Function : insertPrdtInq
	 * 작성일 : 2016. 9. 13. 오전 11:45:15
	 * 작성자 : 정동수
	 * @param prdtInqVO
	 */
	public void insertPrdtInq(PRDTINQVO prdtInqVO) {
		insert("prdtInq_I_00", prdtInqVO);
	}
		
	/**
	 * 상품 조회 수 수정
	 * Function : updatePrdtInq
	 * 작성일 : 2016. 9. 13. 오전 11:45:35
	 * 작성자 : 정동수
	 * @param prdtInqVO
	 */
	public void updatePrdtInq(PRDTINQVO prdtInqVO) {
		update("prdtInq_U_00", prdtInqVO);
	}
}
