package web.order.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import web.product.vo.CARTVO;

public interface WebCartService {

	/**
	 * 장바구니 추가
	 * 파일명 : addCart
	 * 작성일 : 2018. 9. 18. 오후 3:53:54
	 * 작성자 : 최영철
	 * @param sessionCartList
	 */
	void addCart(List<CARTVO> sessionCartList);

	/**
	 * 장바구니 동기화
	 * 파일명 : syncCart
	 * 작성일 : 2018. 9. 18. 오후 8:11:42
	 * 작성자 : 최영철
	 */
	void syncCart(HttpServletRequest request);

}
