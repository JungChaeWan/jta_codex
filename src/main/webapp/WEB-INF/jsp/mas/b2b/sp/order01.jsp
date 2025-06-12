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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_useEmailHostChage(sltObj){
	$("#useEmail_host").val(sltObj);
}

function fn_revEmailHostChage(sltObj){
	$("#revEmail_host").val(sltObj);
}

function fn_updateRsvEmail(){
	if($("#revEmailH").val() == "" || $("#revEmail_host").val()==""){
		$("#rsvEmail").val("");
	}else{
		$("#rsvEmail").val( $("#revEmailH").val() + "@" + $("#revEmail_host").val() );
	}
}

function fn_updateUseEmail(){
	if($("#useEmailH").val() == "" || $("#useEmail_host").val()==""){
		$("#useEmail").val("");
	}else{
		$("#useEmail").val( $("#useEmailH").val() + "@" + $("#useEmail_host").val() );
	}
}

function fn_RsvConfirm(){
	
	fn_updateRsvEmail();
	fn_updateUseEmail();
	
	if(isNull($("#rsvNm").val())){
		alert("예약자 이름을 입력해주세요.");
		$("#rsvNm").focus();
		return;
	}
	if(isNull($("#rsvEmail").val())){
		alert("예약자 이메일을 입력해주세요.");
		//$("#rsvEmail").focus();
		$("#revEmailH").focus();
		return;
	}
	if(isNull($("#rsvTelnum").val())){
		alert("예약자 전화번호를 입력해주세요.");
		$("#rsvTelnum").focus();
		return;
	}
	if(isNull($("#useNm").val())){
		alert("사용자 이름을 입력해주세요.");
		$("#useNm").focus();
		return;
	}
	if("${orderDiv ne Constant.SV}" == "true" && isNull($("#useEmail").val())){
		alert("사용자 이메일을 입력해주세요.");
		$("#useEmail").focus();
		return;
	}
	if(isNull($("#useTelnum").val())){
		alert("사용자 전화번호를 입력해주세요.");
		$("#useTelnum").focus();
		return;
	}
	// 이메일 형식 체크
	if(!fn_is_email($("#rsvEmail").val())){
		alert("<spring:message code='errors.email' arguments='" + $("#rsvEmail").val() + "'/>");
		$("#rsvEmail").focus();
		return;
	}
	if("${orderDiv ne Constant.SV}" == "true" && !fn_is_email($("#useEmail").val())){
		alert("<spring:message code='errors.email' arguments='" + $("#useEmail").val() + "'/>");
		$("#useEmail").focus();
		return;
	}
	// 전화번호 체크
	if(!checkIsPhoneNum($("#rsvTelnum").val())){
		alert("<spring:message code='errors.phone'/>");
		$("#rsvTelnum").focus();
		return;
	}
	// 휴대폰번호 체크
	if(!checkIsHP($("#useTelnum").val())){
		alert("<spring:message code='errors.phone'/>");
		$("#useTelnum").focus();
		return;
	}
	
	if("${orderDiv eq Constant.SV}" == "true") {
		if(isNull($("#postNum").val()) || isNull($("#roadNmAddr").val())) {
			alert("배송지 주소를 입력해 주세요.");
			$("#roadNmAddr").focus();
			return ;
		}
		if(isNull($("#dtlAddr").val())) {
			alert("상세 주소를 입력해 주세요.");
			$("#dtlAddr").focus();
			return ;
		}
	}
	document.rsvInfo.action = "<c:url value='/mas/b2b/order02.do'/>";
	document.rsvInfo.submit();
}


$(document).ready(function() {
	var strRevEmail = '${userVO.corpEmail}';
	if(strRevEmail != ""){
		var arrEmail = strRevEmail.split("@");
		
		$("#revEmailH").val(arrEmail[0]);
		$("#revEmail_host").val(arrEmail[1]);
		
		for(var i=1; i<$("#revEmail_hostS option").size(); i++ ){
			//console.log( $("#revEmail_hostS option:eq("+i+")").val() );
			if( $("#revEmail_hostS option:eq("+i+")").val() == arrEmail[1]){
				$("#revEmail_hostS").val(arrEmail[1]);
				break;
			}
		}
	}
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="rsvInfo" id="rsvInfo" onSubmit="return false;">
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
				            	<c:set var="totalPrdtAmt" value="0" />
                                <c:forEach items="${orderList}" var="cart" varStatus="status">
                                	<input type="hidden" name="cartSn" value="${cart.cartSn}" >
                                	<c:set var="totalPrdtAmt" value="${totalPrdtAmt+cart.totalAmt}" />
                                	<c:choose>
                                		<c:when test="${Constant.ACCOMMODATION eq fn:substring(cart.prdtNum,0,2)}">
			                            	<tr>
			                            		<td>${cart.prdtDivNm}</td>
			                            		<td class="left">
			                            			<h5 class="product">[실시간예약] <span class="cProduct">${cart.corpNm}</span></h5>
			                            			<p class="infoText">
			                            				[<c:out value="${cart.prdtNm}"/>]
				                           				<fmt:parseDate value='${cart.startDt}' var='fromDttm' pattern="yyyy-MM-dd" scope="page"/>
														<fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd"/> 부터 ${cart.night}박
														| 성인 ${cart.adultCnt}명, 소아 ${cart.juniorCnt}명, 유아 ${cart.childCnt}명
			                                		</p>
			                                	</td>
			                                	<td>
			                                		<input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.ACCOMMODATION}">
			                                		<input type="hidden" name="cartTotalAmt" id="cartTotalAmt${cart.cartSn}" value="${cart.totalAmt}">
			                                		<input type="hidden" name="totalDisAmt" id="totalDisAmt${cart.cartSn}" value="0">
			                                		<p class="price"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber>원</p>
			                                	</td>
			                                </tr>                              			
			                            </c:when>
			                            <c:otherwise>
			                            	<tr>
			                            		<td>${cart.prdtDivNm}</td>
			                            		<td class="left">
			                            			<h5 class="product">[실시간예약] <span class="cProduct">${cart.corpNm} ${cart.prdtNm}</span></h5>
			                            			<p class="infoText">
				                           				<fmt:parseDate value='${cart.fromDt}${cart.fromTm}' var='fromDttm' pattern="yyyyMMddHHmm" scope="page"/>
				                           				<fmt:parseDate value='${cart.toDt}${cart.toTm}' var='toDttm' pattern="yyyyMMddHHmm" scope="page"/>
														<fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${toDttm}" pattern="yyyy-MM-dd HH:mm"/>
			                                		</p>
			                                	</td>
			                                	<td>
			                                		<input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.RENCAR}">
			                                		<input type="hidden" name="cartTotalAmt" id="cartTotalAmt${cart.cartSn}" value="${cart.totalAmt}">
			                                		<input type="hidden" name="totalDisAmt" id="totalDisAmt${cart.cartSn}" value="0">
			                                		<p class="price"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber>원</p>
			                                	</td>
			                                </tr>
			                            </c:otherwise>
                                	</c:choose>
                                </c:forEach>
				            </tbody>
				        </table>
				    </article>
				    
				    <div class="line2">
				        <article class="payArea userWrap1">
				            <h5 class="title">예약 업체 정보</h5>
				            <table class="commRow">
				                <tbody><tr>
				                    <th>업체</th>
				                    <td>
				                    	<input id="rsvNm" name="rsvNm" class="inpName" type="text" value="${userVO.corpNm}" />
				                    </td>
				                    </tr>
				                    <tr>
				                        <th>이메일</th>
				                        <td>
				                        	<input id="rsvEmail" name="rsvEmail" class="inpName" type="hidden" value="${userVO.corpEmail}" placeholder="이메일을 입력하세요">
                                         	<!-- <input id="rsvEmail" name="rsvEmail" class="inpName" type="text" value="${userVO.email}" placeholder="이메일을 입력하세요">-->
                                         	<div class="email-form">
                                                <input class="id" type="text" name="revEmailH" id="revEmailH">
                                                <span class="guide">@</span>
                                                <input class="email" type="text" placeholder="nate.com" name="revEmail_host" id="revEmail_host">
                                                <select class="select" title="E-mail 주소를 선택합니다" name="revEmail_hostS" id="revEmail_hostS" onchange="fn_revEmailHostChage(this.value)">
													<option value="" selected="selected">직접입력</option>
													<option value="naver.com">naver.com</option>
													<option value="daum.net">daum.net</option>
													<option value="gmail.com">gmail.com</option>
                                                </select>
                                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th>연락처</th>
				                        <td>
				                        	<input id="rsvTelnum" name="rsvTelnum" class="inpName" type="text" value="${userVO.rsvTelNum}" maxlength="20" />
				                        </td>
				                    </tr>
				                </tbody></table>                                        
				        </article>
				        <article class="payArea userWrap2">
				            <h5 class="title">사용자정보</h5>
				            <table class="commRow">
				                <tbody><tr>
				                    <th>이름</th>
				                    <td><input id="useNm" name="useNm" class="inpName" type="text"></td>
				                    </tr>
				                    <tr>
				                        <th>이메일</th>
				                        <td>
				                        	<input id="useEmail" name="useEmail" class="inpName" type="hidden">
				                            <div class="email-form">
				                                <input class="id" type="text" name="useEmailH" id="useEmailH">
				                                <span class="guide">@</span>
				                                <input class="email" type="text" placeholder="nate.com" name="useEmail_host" id="useEmail_host">
				                                <select class="select" title="E-mail 주소를 선택합니다" name="useEmail_hostS" id="useEmail_hostS" onchange="fn_useEmailHostChage(this.value)">
				                                    <option value="" selected="selected">직접입력</option>
													<option value="naver.com">naver.com</option>
													<option value="daum.net">daum.net</option>
													<option value="gmail.com">gmail.com</option>
				                                </select>
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th>휴대폰</th>
				                        <td>
				                            <input id="useTelnum" name="useTelnum" class="inpName" type="text" maxlength="20" />
				                        </td>
				                    </tr>
				                </tbody></table>
				            <!-- <p class="check"><input id="ordNm" type="checkbox"><label for="ordNm">사용자가 예약자와 동일한 경우 체크해주세요</label></p> -->
				        </article>
				    </div>
				    
				    <article class="payArea">
				        <h4 class="comm-title2">결제정보</h4>
				        <table class="commRow comm-payInfo">
				            <tbody>                                      
				                <tr>
				                    <th>최종결제금액</th>
				                    <td class="total-wrap pay-st">
				                        <strong class="comm-color1"><fmt:formatNumber>${totalPrdtAmt}</fmt:formatNumber></strong>원
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				    </article>
				    
				    <div class="btn-wrap1">
				    	<a href="javascript:fn_RsvConfirm();" class="btn blue big">예약확인</a>
				    </div>
			    
			    </div>
			</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>