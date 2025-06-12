package web.order.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import web.product.vo.CARTVO2;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("webCartDAO")
public class WebCartDAO extends EgovAbstractDAO {

	/**
	 * 카트 등록
	 * 파일명 : insertCart
	 * 작성일 : 2018. 9. 18. 오후 5:38:19
	 * 작성자 : 최영철
	 * @param cartList
	 */
	public void insertCart(List<CARTVO2> cartList) {
		insert("CART_I_01", cartList);
	}

	public void insertCart(CARTVO2 cart) {
		insert("CART_I_00", cart);
	}

	/**
	 * 장바구니 삭제
	 * 파일명 : deleteCart
	 * 작성일 : 2018. 9. 18. 오후 5:38:58
	 * 작성자 : 최영철
	 * @param userId
	 */
	public void deleteCart(String userId) {
		delete("CART_D_01", userId);
	}

	/**
	 * 장바구니 리스트 조회
	 * 파일명 : selectCart
	 * 작성일 : 2018. 9. 18. 오후 8:21:39
	 * 작성자 : 최영철
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CARTVO2> selectCart(String userId) {
		return (List<CARTVO2>) list("CART_S_01", userId);
	}

}
