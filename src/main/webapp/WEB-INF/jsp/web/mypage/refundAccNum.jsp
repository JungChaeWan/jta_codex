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
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />


<script type="text/javascript">

function fn_InsAccNum(){
	$(".refund2").show();
}

function fn_UdtAccNum(){
	var parameters = "";
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url: "<c:url value='/web/mypage/selectAccNum.ajax'/>",
		data: parameters,
		success:function(data) {
			$("#depositorNm").val(data.refundAccInf.depositorNm);
			$("#bankNm").val(data.refundAccInf.bankNm);
			$("#accNum").val(data.refundAccInf.accNum);
			
			$(".refund2").show();
		},
		error : fn_AjaxError
	});	
}

function fn_CloseAccNum(){
	$(".refund2").hide();
}

function fn_Commit(){
	if(!$("#agree1").is(":checked")){
		alert("수집/설정에 동의 하셔야 합니다.");
		return;
	}
	if(isNull($("#depositorNm").val())){
		alert("예금주명이 입력되지 않았습니다.");
		$("#depositorNm").focus();
		return;
	}
	if(isNull($("#bankCode").val())){
		alert("은행이 입력되지 않았습니다.");
		$("#bankCode").focus();
		return;
	}
	if(isNull($("#accNum").val())){
		alert("계좌번호가 입력되지 않았습니다.");
		$("#accNum").focus();
		return;
	}
	var parameters = "depositorNm=" + $("#depositorNm").val();
	parameters += "&bankCode=" + $("#bankCode").val();
	parameters += "&accNum=" + $("#accNum").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url: "<c:url value='/web/mypage/mergeAccNum.ajax'/>",
		data: parameters,
		success:function(data) {
			alert("환불계좌가 등록되었습니다.");
			if("${param.rtnUrl}"){
                location.href = "${param.rtnUrl}";
            }else{
                location.href = "<c:url value='/web/mypage/viewRefundAccNum.do'/>";
            }

		},
		error : fn_AjaxError
	});	
}
</script>


</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>마이페이지</span> <span class="gt">&gt;</span>
                <span>나의 정보</span> <span class="gt">&gt;</span>
                <span>환불계좌관리</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="mypage sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                                <jsp:include page="/web/mypage/left.do?menu=refund" flush="false"></jsp:include>
                                <div class="rContents smON">
                                    <h3 class="mainTitle">환불계좌관리</h3>

                                    <article class="payArea refund">
                                        <h4 class="comm-title2">무통장 환불계좌</h4>
                                        <table class="commRow">
                                            <colgroup>
                                                <col width="20%" />
                                                <col />
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="handl--size">환불계좌</th>
                                                    <td>
                                                    	<c:if test="${empty refundAccInf}">
	                                                        <span class="refund-account">등록된 계좌정보가 없습니다. 환불 받으실 계좌번호를 입력해주세요.</span>
	                                                        <a href="javascript:fn_InsAccNum();" class="comm-sideBT2">입력하기</a>
		                                                </c:if>
		                                                <c:if test="${not empty refundAccInf}">
		                                                	<span class="refund-account">
                                                                <c:forEach items="${cdRfac}" var="code" varStatus="status">
                                                                    <c:if test="${code.cdNum eq refundAccInf.bankCode}">
                                                                        ${code.cdNm} /
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:out value="${refundAccInf.accNum}"/> (예금주 : <c:out value="${refundAccInf.depositorNm}"/>)
                                                            </span>
                                                        	<a href="javascript:fn_UdtAccNum();" class="comm-sideBT2">계좌변경</a>
                                                		</c:if>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </article>

                                    <!-- 환불계좌 입력 -->
                                    <article class="payArea refund2" style="display:none;">
                                        <h4 class="comm-title2">무통장 환불계좌 입력</h4>
                                        <table class="commRow">
                                            <colgroup>
                                                <col width="20%" />
                                                <col />
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="handl--size">은행</th>
                                                    <td>
                                                        <select class="bank" name="bankCode" id="bankCode">
                                                            <c:forEach items="${cdRfac}" var="code" varStatus="status">
                                                                <option value="${code.cdNum}" <c:if test="${code.cdNum eq refundAccInf.bankCode}">selected="selected"</c:if>> ${code.cdNm}</option>
                                                            </c:forEach>
                                                        </select>
														<%--<input type="text" name="bankNm" id="bankNm" class="passbook" maxlength="30">--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="handl--size">계좌번호</th>
                                                    <td>
                                                        <input type="text" name="accNum" id="accNum" class="passbook" maxlength="20" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자만가능합니다.">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="handl--size">예금주</th>
                                                    <td><input type="text" name="depositorNm" id="depositorNm" class="passbook" maxlength="30" placeholder="예금주가 정확해야 합니다."></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <div class="comm-agree1 auto-cancel">
											<input id="agree1" type="checkbox">
											<label for="agree1" class="box-dec">입력한 정보를 환불계좌로 수집/설정하는데 동의합니다.</label>
                                            <button href="" class="link_terms-view" onclick="show_popup('#collection-agreement');">내용보기
                                                <img src="../../../images/web/icon/basic/arrow.png" alt="내용보기">
                                            </button>
										</div>

                                        <!-- 1123 개인정보 처리실태 모니터링 점검 -->
                                        <!-- 개인정보 수집 및 이용동의 layer-popup -->
                                        <div id="collection-agreement" class="agreement_memo comm-layer-popup_fixed">
                                            <div class="content-wrap">
                                                <div class="content">
                                                    <div class="head">
                                                        <h3 class="title">개인정보 수집 및 이용동의</h3>
                                                    </div>

                                                    <div class="sign_rules-wrap">
                                                        <dl class="comm-rule">
                                                            <dt>선택정보 수집 및 이용동의</dt>
                                                            <dd>
                                                                <table class="commCol">
                                                                    <colgroup>
                                                                        <col style="width: 34%">
                                                                        <col style="width: 33%">
                                                                        <col style="width: 33%">
                                                                    </colgroup>
                                                                    <thead>
                                                                    <tr>
                                                                        <th>목적</th>
                                                                        <th>항목</th>
                                                                        <th>보유기간</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <tr>
                                                                        <td>고객환불</td>
                                                                        <td>은행계좌정보</td>
                                                                        <td>탈퇴시 즉시</td>
                                                                    </tr>
                                                                    </tbody>
                                                                </table>
                                                            </dd>
                                                        </dl>
                                                    </div>
                                                </div>
                                                <button type="button" class="close step_btn-confirm" onclick="close_popup('#collection-agreement')">확인</button>
                                            </div>
                                        </div> <!-- //개인정보 수집 및 이용동의 layer-popup -->
                                        <!-- //1123 개인정보 처리실태 모니터링 점검 -->

                                        <div class="comm-button2">
                                            <a class="color1" href="javascript:fn_Commit();">확인</a>
                                            <a class="color0" href="javascript:fn_CloseAccNum();">취소</a>
                                        </div>

                                    </article>
                                </div> <!--//rContents-->
                            </div> <!--//tbWrap-->
                        </div> <!--//inner-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage1 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>