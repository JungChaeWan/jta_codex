<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Buy(){
	var parameters = $("#rsvFrm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mas/b2b/orderChk.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "N"){
				alert("기결제된 예약건이거나 예약정보가 올바르지 않습니다.");
				return;
			}else{
				if(fn_AppCheck() != "PC"){
					alert("올바르지 않은 유입 경로입니다.\nPC에서 결제를 진행해주시기 바랍니다.");
					return;
				}
				
				if("${order.saleAmt}" == "0"){
					alert("결제할 금액이 없습니다.");
					return;
				}
				
				if(!$("#agree5").is(":checked")){
					alert("결제동의에 동의하셔야 합니다.");
					return;
				}
			
				$("#CST_MID").val($("#CST_MID_CO").val());
				$("#LGD_HASHDATA").val($("#LGD_HASHDATA_CO").val());
				$("#LGD_MID").val($("#LGD_MID_CO").val());
						
				$("#LGD_CUSTOM_USABLEPAY").val($(":radio[name=payWay]:checked").val());
				if(fn_AppCheck() == "PC"){
					lgdwin = openXpay(document.getElementById('rsvFrm'), $("#CST_PLATFORM").val(), "iframe", null, "", "");
				}else{
					alert("올바르지 않은 유입 경로입니다.\nPC에서 결제를 진행해주시기 바랍니다.");
					
					return;
					
				}
				
			}
		},
		error:fn_AjaxError
	});
	
}

/**
 * App 체크
 * AA : 안드로이드 앱, AW : 안드로이드 웹, IA : IOS 앱, IW : IOS 웹
 */
function fn_AppCheck(){
	var headInfo = ("${header['User-Agent']}").toLowerCase();
	
	var mobile = (/iphone|ipad|ipod|android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i.test(headInfo));
	
	if(mobile){
		// 안드로이드
		if((/android/.test(headInfo))){
			// 안드로이드 앱
			if(/webview_android/.test(headInfo)){
				return "AA";
			}
			// 안드로이드 웹
			else{
				return "AW";
			}
		}
		// IOS
		else if((/iphone|ipad|/.test(headInfo))){
			if(!(/safari/.test(headInfo))){
				return "IA";
			}else{
				return "IW";
			}
		}
	}else{
		return "PC";
	}
}

/*
 * 인증결과 처리
 */
function payment_return() {
	var fDoc;
	
	fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
		var payKey = fDoc.document.getElementById("LGD_PAYKEY").value;
		$("#LGD_PAYKEY").val(payKey);
		// document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById("LGD_PAYKEY").value;
		$("#PayMethod").val("LG");
		document.rsvFrm.target = "_self";
		document.rsvFrm.action = "<c:url value='/mas/b2b/order05.do'/>";
		document.rsvFrm.submit();
		
			
			// document.getElementById("LGD_PAYINFO").target = "_self";
			// document.getElementById("LGD_PAYINFO").action = "payres.jsp";
			// document.getElementById("LGD_PAYINFO").submit();
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}

$(document).ready(function() {
	
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
			<!--검색-->
	            <div class="max-wrap">
	                <article class="payArea">
				        <h5 class="title">상품 정보</h5>
				        <table class="commCol product-info">
				        	<colgroup>
				        		<col width="25%" />
				        		<col />
				        		<col width="25%" />
				        	</colgroup>
				            <thead>
				                <tr>
				                    <th class="title1">구분</th>
				                    <th class="title2">상품정보</th>
				                    <th class="title3">결제금액</th>
				                </tr>
				            </thead>
				            <tbody>
				                <c:forEach items="${orderList}" var="order" varStatus="status">
									<tr>
										<td>
											<c:out value="${order.prdtCdNm}"/>
										</td>
										<td class="left">
											<h5 class="product"><span class="cProduct">[<c:out value="${order.corpNm}"/>]<c:out value="${order.prdtNm}"/></span></h5>
											<p class="infoText"><c:out value="${order.prdtInf}"/></p>
										</td>
										<td class="money">
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
												<fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber>
											</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
												<span class="nt">예약마감</span>
											</c:if>
										</td>
									</tr>
								</c:forEach>
				            </tbody>
				        </table>
				    </article>
				    
				    <article class="payArea payInfoWrap">
				        <h5 class="title">결제정보 선택</h5>
				        <table class="commRow">
				            <tbody><tr>
				                <th>결제방법</th>
				                <td>
				                    <div class="paySelect">
				                        <input id="payWay1" type="radio" name="payWay" value="SC0010" checked><label for="payWay1">&nbsp;신용카드</label>
				                    </div>
				                </td>
				                </tr>                                            
				            </tbody></table>
				    </article>
				    
				    <article class="payArea">
				    	<form name="rsvFrm" id="rsvFrm" method="post">
							<input type="hidden" name="rsvNum" 					id="rsvNum" 					value="${LGD_OID}" />
							<input type="hidden" name="payWay" 					id="payWay" 					value="SC0010" />
							<input type="hidden" name="CST_PLATFORM" 			id="CST_PLATFORM" 				value="${CST_PLATFORM}" />	<!-- 테스트, 서비스 구분 -->
							<input type="hidden" name="CST_MID" 				id="CST_MID" 					value="${CST_MID}" />	<!-- 상점아이디 -->
							<input type="hidden" name="CST_MID_HP" 				id="CST_MID_HP" 				value="${CST_MID_HP}" />	<!-- 상점아이디 -->
							<input type="hidden" name="CST_MID_CO" 				id="CST_MID_CO" 				value="${CST_MID}" />	<!-- 상점아이디 -->
							<input type="hidden" name="CST_WINDOW_TYPE" 		id="CST_WINDOW_TYPE" 			value="submit" />
							<input type="hidden" name="LGD_MID" 				id="LGD_MID" 					value="${LGD_MID}" />	<!-- 상점아이디 -->
							<input type="hidden" name="LGD_MID_HP" 				id="LGD_MID_HP" 				value="${LGD_MID_HP}" />	<!-- 상점아이디 -->
							<input type="hidden" name="LGD_MID_CO" 				id="LGD_MID_CO" 				value="${LGD_MID}" />	<!-- 상점아이디 -->
							<input type="hidden" name="LGD_RETURNURL" 			id="LGD_RETURNURL" 				value="${LGD_RETURNURL}" />	<!-- 응답수신페이지 -->
							
							<input type="hidden" name="LGD_OID" 				id="LGD_OID" 					value="${LGD_OID}" />	<!-- 주문번호 -->
							<input type="hidden" name="LGD_BUYER" 				id="LGD_BUYER" 					value="${rsvInfo.rsvNm}" />	<!-- 구매자 -->
							<input type="hidden" name="LGD_PRODUCTINFO" 		id="LGD_PRODUCTINFO" 			value="탐나오 관광상품" />	<!-- 상품정보 -->
							<input type="hidden" name="LGD_AMOUNT" 				id="LGD_AMOUNT" 				value="${rsvInfo.totalSaleAmt}" />	<!-- 결제금액 -->
							<input type="hidden" name="LGD_BUYEREMAIL" 			id="LGD_BUYEREMAIL" 			value="${rsvInfo.rsvEmail}" />	<!-- 구매자 이메일 -->
							<input type="hidden" name="LGD_CUSTOM_SKIN" 		id="LGD_CUSTOM_SKIN" 			value="red" />	<!-- 결제창 SKIN -->
							<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE" 	id="LGD_CUSTOM_PROCESSTYPE" 	value="TWOTR" />	<!-- 트랜잭션 처리방식 -->
							<input type="hidden" name="LGD_TIMESTAMP" 			id="LGD_TIMESTAMP" 				value="${timeStamp}" />	<!-- 타임스탬프 -->
							<input type="hidden" name="LGD_HASHDATA" 			id="LGD_HASHDATA" 				value="${LGD_HASHDATA}" />	<!-- MD5 해쉬암호값 -->
							<input type="hidden" name="LGD_HASHDATA_HP" 		id="LGD_HASHDATA_HP" 			value="${LGD_HASHDATA_HP}" />	<!-- MD5 해쉬암호값-휴대폰 -->
							<input type="hidden" name="LGD_HASHDATA_CO" 		id="LGD_HASHDATA_CO" 			value="${LGD_HASHDATA}" />	<!-- MD5 해쉬암호값-다른 결제수단 -->
							
							<input type="hidden" name="LGD_VERSION" 			id="LGD_VERSION" 				value="JSP_SmartXPay_1.0" />	<!-- 버전정보 (삭제하지 마세요) -->
							<input type="hidden" name="LGD_WINDOW_VER" 			id="LGD_WINDOW_VER" 			value="2.5" />	<!-- 버전정보 (삭제하지 마세요) -->
							<input type="hidden" name="LGD_CUSTOM_USABLEPAY" 	id="LGD_CUSTOM_USABLEPAY" 		value="" />	<!-- 디폴트 결제수단 -->
							<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" 	value="SUBMIT" />	<!-- 신용카드 카드사 인증 페이지 연동 방식 -->
							<input type="hidden" name="LGD_ENCODING" 			id="LGD_ENCODING" 				value="UTF-8" />
							<input type="hidden" name="LGD_ENCODING_NOTEURL" 	id="LGD_ENCODING_NOTEURL" 		value="UTF-8" />
							<input type="hidden" name="LGD_ENCODING_RETURNURL" 	id="LGD_ENCODING_RETURNURL" 	value="UTF-8" />
							<input type="hidden" name="LGD_PAYKEY" 				id="LGD_PAYKEY" 				value="">
				        <h4 class="comm-title2">결제정보</h4>
				        <table class="commRow comm-payInfo">
				            <tbody>                                      
				                <tr>
				                    <th>최종결제금액</th>
				                    <td class="total-wrap pay-st">
				                        <strong class="comm-color1"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber></strong>원
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				    </article>
				    
				    <ul class="commList1">
				        <li>숙박, 렌터카 상품은 실시간 상품으로 결제와 동시에 예약이 확정됩니다.</li>
				        <li>모든 상품의 취소환불규정을 숙지바랍니다.</li>
				    </ul>
				    
				    <div class="comm-agree1">
				        <p class="memo">구매내역 등을 최종 확인하였으며, 구매에 동의하시겠습니까?</p>
				        <p class="agree">
				            <input id="agree5" type="checkbox"> 
				            <label for="agree5"><strong class="big">동의합니다.</strong></label> <span>(전자금융거래법 제8조 제 2항)</span>
				        </p>
				    </div>
				    
				    <div class="btn-wrap1">
				    	<a href="javascript:fn_Buy();" class="btn red big">결제하기</a>
				    </div>
			    
			    </div>
			</div>
		</div>
	</div>
</div>

</body>
</html>