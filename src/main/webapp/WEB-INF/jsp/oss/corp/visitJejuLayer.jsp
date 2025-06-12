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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
function fn_VisitJejuList(page) {
	location.href='/oss/getVisitJejuList.do?page=' + page;
}
</script>
<body>
<!-- 팝업 -->
<table class="commCol">
    <thead>
        <tr>
            <th class="title11">No</th>
            <th class="title12">업체명</th>
            <th class="title13">등록일</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${visitJejuList}" var="visit" varStatus="status">
	    	<tr>
	            <td><c:out value="${(visitVO.page-1) * pageSize + status.count}"/></td>
	            <td>	            	
	            	<c:out value="${visit.title}" />
	            </td>
	            <td> 
	            	<c:out value="${visit.createdDate}" />
	            </td>
	        </tr>
    	</c:forEach>                                                                                    
    </tbody>
</table>
<p class="list_pageing">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_VisitJejuList" />
</p>
</body>
</html>
