package web.order.service.impl;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import oss.user.vo.USERVO;
import web.order.service.WebCartService;
import web.product.vo.CARTVO;
import web.product.vo.CARTVO2;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service("webCartService")
public class WebCartServiceImpl extends EgovAbstractServiceImpl implements WebCartService{

	@Resource(name = "webCartDAO")
	private WebCartDAO webCartDAO;
	
	/**
	 * 장바구니 추가
	 * 파일명 : addCart
	 * 작성일 : 2018. 9. 18. 오후 3:53:54
	 * 작성자 : 최영철
	 * @param sessionCartList
	 */
	@Override
	public void addCart(List<CARTVO> sessionCartList){
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		webCartDAO.deleteCart(userVO.getUserId());

//		List<CARTVO2> cartList = new ArrayList<CARTVO2>();
		
		for(CARTVO cart:sessionCartList){
			String category = cart.getPrdtNum().substring(0,2).toUpperCase();

			CARTVO2 cartVO2 = new CARTVO2();
			cartVO2.setUserId(userVO.getUserId());
			cartVO2.setCartSn(String.valueOf(cart.getCartSn()));
			cartVO2.setPrdtNum(cart.getPrdtNum());
			cartVO2.setPrdtNm(cart.getPrdtNm());
			cartVO2.setCorpId(cart.getCorpId());
			cartVO2.setCorpNm(cart.getCorpNm());
			cartVO2.setPrdtDivNm(cart.getPrdtDivNm());
			cartVO2.setImgPath(cart.getImgPath());
			
			if(Constant.ACCOMMODATION.equals(category)){
				cartVO2.setStartDt(cart.getStartDt());
				cartVO2.setNight(cart.getNight());
				cartVO2.setAdultCnt(cart.getAdultCnt());
				cartVO2.setJuniorCnt(cart.getJuniorCnt());
				cartVO2.setChildCnt(cart.getChildCnt());
				cartVO2.setAdAddAmt(cart.getAdOverAmt());

			}else if(Constant.RENTCAR.equals(category)){
				cartVO2.setStartDt(cart.getFromDt());
				cartVO2.setStartTm(cart.getFromTm());
				cartVO2.setEndDt(cart.getToDt());
				cartVO2.setEndTm(cart.getToTm());
				cartVO2.setTotalAmt(cart.getTotalAmt());
				cartVO2.setNmlAmt(cart.getNmlAmt());
				cartVO2.setAddOptAmt(cart.getAddAmt());
				cartVO2.setIsrDiv(cart.getInsureDiv());

			}else if(Constant.SOCIAL.equals(category)){
				cartVO2.setNmlAmt(cart.getNmlAmt());
				cartVO2.setCnt(cart.getQty());
				cartVO2.setOptSn(cart.getSpOptSn());
				cartVO2.setDivSn(cart.getSpDivSn());
				cartVO2.setAddOptNm(cart.getAddOptNm());
				cartVO2.setAddOptAmt(cart.getAddOptAmt());

			}else if(Constant.SV.equals(category)){
				cartVO2.setNmlAmt(cart.getNmlAmt());
				cartVO2.setCnt(cart.getQty());
				cartVO2.setOptSn(cart.getSvOptSn());
				cartVO2.setDivSn(cart.getSvDivSn());
				cartVO2.setAddOptNm(cart.getAddOptNm());
				cartVO2.setAddOptAmt(cart.getAddOptAmt());
				cartVO2.setDirectRecvYn(cart.getDirectRecvYn());
			}
//			cartList.add(cartVO2);
			webCartDAO.insertCart(cartVO2);
		}
		/*if(cartList.size() > 0){
			webCartDAO.insertCart(cartList);
		}*/
	}
	
	/**
	 * 장바구니 동기화
	 * 파일명 : syncCart
	 * 작성일 : 2018. 9. 18. 오후 8:11:42
	 * 작성자 : 최영철
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void syncCart(HttpServletRequest request){
		List<CARTVO> sessionCartList = new ArrayList<CARTVO>();
		
		Integer cartSn = 1;
		/** 비로그인 상태일 때 카트에 담은 상품이 없을경우*/
		boolean nLoginCart = false;
		
		if(request.getSession().getAttribute("cartList") != null){
			sessionCartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
			
			Integer maxCartSn = 0;
    		for(CARTVO cart:sessionCartList){
    			if(cart.getCartSn() > maxCartSn){
    				maxCartSn = cart.getCartSn();
    			}
    		}
    		cartSn = maxCartSn + 1;
    		nLoginCart = true;
		}
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		List<CARTVO2> dbCartList = webCartDAO.selectCart(userVO.getUserId());
		
		for(CARTVO2 cartVO2 : dbCartList){
			CARTVO cartVO = new CARTVO();
			// 장바구니 순번
			cartVO.setCartSn(cartSn);
			// 상품 번호
			cartVO.setPrdtNum(cartVO2.getPrdtNum());
			// 상품 명
			cartVO.setPrdtNm(cartVO2.getPrdtNm());
			// 업체 아이디
			cartVO.setCorpId(cartVO2.getCorpId());
			// 업체 명
			cartVO.setCorpNm(cartVO2.getCorpNm());
			// 상품 구분 명
			cartVO.setPrdtDivNm(cartVO2.getPrdtDivNm());
			//상품 이미지
			cartVO.setImgPath(cartVO2.getImgPath());

			String category = cartVO2.getPrdtNum().substring(0,2).toUpperCase();
			
			if(Constant.ACCOMMODATION.equals(category)){
				// 시작일자
				cartVO.setStartDt(cartVO2.getStartDt());
				// 박수
				cartVO.setNight(cartVO2.getNight());
				// 성인 수량
				cartVO.setAdultCnt(cartVO2.getAdultCnt());
				// 소인 수량
				cartVO.setJuniorCnt(cartVO2.getJuniorCnt());
				// 유아 수량
				cartVO.setChildCnt(cartVO2.getChildCnt());
				// 추가 금액
				cartVO.setAdOverAmt(cartVO2.getAdAddAmt());
			}else if(Constant.RENTCAR.equals(category)){
				// 시작일자
				cartVO.setFromDt(cartVO2.getStartDt());
				// 시작시간
				cartVO.setFromTm(cartVO2.getStartTm());
				// 종료일자
				cartVO.setToDt(cartVO2.getEndDt());
				// 종료시간
				cartVO.setToTm(cartVO2.getEndTm());
				// 총금액
				cartVO.setTotalAmt(cartVO2.getTotalAmt());
				// 기본금액
				cartVO.setNmlAmt(cartVO2.getNmlAmt());
				// 추가 금액
				cartVO.setAddAmt(cartVO2.getAddOptAmt());
				// 보험 구분
				cartVO.setInsureDiv(cartVO2.getIsrDiv());
			}else if(Constant.SOCIAL.equals(category)){
				// 기본금액
				cartVO.setNmlAmt(cartVO2.getNmlAmt());
				// 수량
				cartVO.setQty(cartVO2.getCnt());
				// 옵션 순번
				cartVO.setSpOptSn(cartVO2.getOptSn());
				// 구분 순번
				cartVO.setSpDivSn(cartVO2.getDivSn());
				// 추가 옵션 명
				cartVO.setAddOptNm(cartVO2.getAddOptNm());
				// 추가 옵션 금액
				cartVO.setAddOptAmt(cartVO2.getAddOptAmt());
			}else if(Constant.SV.equals(category)){
				// 기본금액
				cartVO.setNmlAmt(cartVO2.getNmlAmt());
				// 수량
				cartVO.setQty(cartVO2.getCnt());
				// 옵션 순번
				cartVO.setSvOptSn(cartVO2.getOptSn());
				// 구분 순번
				cartVO.setSvDivSn(cartVO2.getDivSn());
				// 추가 옵션 명
				cartVO.setAddOptNm(cartVO2.getAddOptNm());
				// 직접수령여부
				cartVO.setDirectRecvYn(cartVO2.getDirectRecvYn());
				// 추가 옵션 금액
				cartVO.setAddOptAmt(cartVO2.getAddOptAmt());
			}
			sessionCartList.add(cartVO);
			cartSn++;
		}
		request.getSession().setAttribute("cartList", sessionCartList);

		if(nLoginCart) {
			addCart(sessionCartList);
		}
	}
}
