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
			<form name="rsvInfo" id="rsvInfo" onSubmit="return false;">
			<div id="contents">
			<!--검색-->
	            <div class="max-wrap">
                	<div class="pay-end">
                		<div class="title-box">
					        <p class="title">“감사합니다. 주문이 완료되었습니다”</p>
					    </div>
                	
					    <!-- 주문상품 -->
					    <article class="ct-wrap">
					        <h5 class="title">주문하신 상품</h5>
					        <table class="commCol product-info">
					            <thead>
					                <tr>
					                    <th class="title1">구분</th>
					                    <th class="title2">상품정보</th>
					                    <th class="title3">금액</th>
					                </tr>
					            </thead>
					            <tbody>
					                <c:forEach items="${orderList}" var="order" varStatus="status">
                                    	<tr>
                                    		<td>${order.prdtCdNm}</td>
                                    		<td class="left">
                                     			<h5 class="product"><span class="cProduct">[<c:out value="${order.corpNm}"/>] <c:out value="${order.prdtNm}"/></span></h5>
                                     			<p class="infoText"><c:out value="${order.prdtInf}"/></p>
                                    		</td>
                                    		<td class="money">
                                    			<fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber>
                                    		</td>
                                    	</tr>
                                    </c:forEach>
					            </tbody>
					        </table>
					    </article>
					    
					    <div class="btn-wrap1">
					    	<a href="<c:url value='/mas/home.do'/>" class="btn red big">홈으로</a>
					    </div>
				    </div> <!-- //pay-end -->
			    </div> <!-- //max-wrap -->
			</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>