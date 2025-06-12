package web.product.service;

import web.product.vo.PRDTINQVO;

public interface WebPrdtInqService {
	/**
	 * 상품의 view click & SNS 공유 수 등록
	 * Function : insertPrdtInq
	 * 작성일 : 2016. 9. 13. 오전 11:37:43
	 * 작성자 : 정동수
	 * @param prdtInqVO
	 */
	void insertPrdtInq(PRDTINQVO prdtInqVO);
}
