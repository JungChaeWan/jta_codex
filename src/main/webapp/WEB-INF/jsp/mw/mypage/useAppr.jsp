<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
	
<script type="text/javascript">

/**
 * 사용처리 레이어
 */
function fn_viewUseAppr(prdtRsvNum) {
	$("#prdtRsvNum").val(prdtRsvNum);

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/mw/mypage/validateUseAbleDttm.ajax'/>",
		data: $("#useApprForm").serialize() ,
		success:function(data){
			if(data.exprOut == "Y"){
				alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
				return ;
			} else if(data.useAbleOut == "Y") {
				alert(data.useAbleDttm + " 이후 사용가능합니다.");
				return ;
			} else if(data.password == "Y") {
				alert("비밀번호가 맞지 않습니다.");
				return ;
			}
			else {
				if(data.success == '${Constant.JSON_SUCCESS}'){
					$('.pop-seller, #cover').fadeToggle();
				}
			}
		},
		error : fn_AjaxError
	});
}

function fn_spUseAppr() {
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/mw/mypage/spUseAppr.ajax'/>",
		data: $("#useApprForm").serialize() ,
		success:function(data){
			if(data.exprOut == "Y"){
				alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
				return ;
			} else if(data.useAbleOut == "Y") {
				alert(data.useAbleDttm + " 이후 사용가능합니다.");
				return ;
			} else if(data.password == "Y") {
				alert("비밀번호가 맞지 않습니다.");
				return ;
			}
			else {
				if(data.success == '${Constant.JSON_SUCCESS}'){
					alert("사용처리가 정상적으로 처리 되었습니다.");
					location.href="<c:url value='/mw/viewUseAppr.do?prdtRsvNum=${resultVO.prdtRsvNum}'/>";
				}
			}
		},
		error : fn_AjaxError
	});
}

</script>

</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<h2>나의 예약/구매 내역</h2>
	</div>
	
	<div class="sub-content">
		<div class="mypage">
			<!--상품정보-->
			<article class="payArea">
				<h4>상품정보</h4>
				<ul>
						<li>
							<table>
								<tr>
									<td colspan="2" class="product-wrap">
										<ul class="product-list">
											<li>
												<h5 class="product">[${resultVO.prdtCdNm}] <span class="cProduct">${resultVO.corpNm} ${resultVO.prdtNm}</span></h5>
												<p class="infoText">${resultVO.prdtInf}</p>
											</li>
										</ul>						
									</td>
								</tr>
								<tr>
									<th>금액</th>
									<td class="price-wrap">
										<p>
											<span class="text">상품금액</span>
											<span class="price"><span><fmt:formatNumber>${resultVO.nmlAmt}</fmt:formatNumber></span>원</span>
										</p>
										<p>
											<span class="text">(-)쿠폰할인</span>
											<span class="price"><span><fmt:formatNumber>${resultVO.disAmt}</fmt:formatNumber></span>원</span>
										</p>
										<p class="total">
											<span class="text"><strong>결제금액</strong></span>
											<span class="price">
												<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
													<strong>예약마감</strong>
												</c:if>
												<c:if test="${resultVO.rsvStatusCd != Constant.RSV_STATUS_CD_EXP}">
													<strong><fmt:formatNumber>${resultVO.saleAmt}</fmt:formatNumber></strong>원
												</c:if>
											</span>
										</p>
									</td>
								</tr>
								<tr>
									<th>비고</th>
									<td class="remark">
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
		                                   	<c:if test="${empty resultVO.useDttm and Constant.SP_PRDT_DIV_COUP eq resultVO.prdtDiv}">
		                                   		<a class="btn btn4" href="javascript:fn_viewUseAppr('${resultVO.prdtRsvNum}');" >사용</a>
		                                   	</c:if>
		                                </c:if>
		                                <c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">
		                                  	취소처리중
		                                </c:if>
		                                <c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
                                        <c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
                                        <c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
									</td>
								</tr>
							</table>
						</li>
				</ul>				
			</article>
			
			
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 셀러정보 팝업s -->
<div class="pop-seller pop-seller_ticket">
	<a class="btn-close"><img src="<c:url value='/images/mw/sub_common/delete.png'/>" width="10" alt="닫기"></a>
	<form name="useApprForm" id="useApprForm">
	<input type="hidden" name="prdtRsvNum" id="prdtRsvNum" />
	<div class="pw-form">
		<h5 class="title"><img src="<c:url value='/images/mw/sub/ticket.png'/>" alt="ticket"> 해당 상품을 사용하시겠습니까?</h5>
		<p class="sub_title">관광지 매표소 직원에게 보여주세요!</p>
		
		<p class="pw"><input class="full" type="password" name="usePwd"  id="usePwd" placeholder="관리자 비밀번호를 입력해 주세요"></p>
		<p class="sub_text">주의) 비밀번호 입력 시 사용처리 됩니다.</p>
		
		<div class="button">
			<a class="btn btn1" href="javascript:fn_spUseAppr();">확인</a>
			<a class="btn btn2">취소</a>
		</div>
	</div>
	</form>
</div>
<!-- 셀러정보 팝업e -->


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>
