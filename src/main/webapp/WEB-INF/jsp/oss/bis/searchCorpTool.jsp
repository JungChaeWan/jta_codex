<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<c:if test="${fn:length(corpList) ne 0 }">
<div class="search-list">	
   	<div class="pd-wrap">
    	<h4 class="title">‘<strong>${bisSVO.sCorpNm }</strong>’의 검색 결과 <span>(<strong><fmt:formatNumber value="${corpTotalCnt }" /></strong> 건)</span></h4>
    	<ul>
    		<c:forEach items="${corpList }" var="corp">
    		  <c:set var="corpStr" value="<strong>${bisSVO.sCorpNm }</strong>" />
    		<li><a href="javascript:fn_Search('${corp.corpNm }')">${fn:replace(corp.corpNm, bisSVO.sCorpNm, corpStr) }</a></li>
    		</c:forEach>
    	</ul>
    	<p class="list_pageing">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_SearchCorpNm" />&nbsp;
	    </p>
    </div>
</div>
</c:if>

<c:if test="${fn:length(corpList) eq 0 }">
<div class="search-list">
    <div class="not-content">검색된 결과가 없습니다.</div>
</div>
</c:if>
