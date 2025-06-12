package web.product.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class CARTLISTVO extends pageDefaultVO {
	private List<CARTVO> cartList;

	public List<CARTVO> getCartList() {
		return cartList;
	}

	public void setCartList(List<CARTVO> cartList) {
		this.cartList = cartList;
	}

	public String localAreaYn;

	public String getLocalAreaYn() {
		return localAreaYn;
	}

	public void setLocalAreaYn(String localAreaYn) {
		this.localAreaYn = localAreaYn;
	}
}
