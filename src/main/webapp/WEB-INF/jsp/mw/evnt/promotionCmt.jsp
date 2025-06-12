<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>


<ul class="comment-list">
	<c:forEach var="cmt" items="${rmtCmtList}">
		<li>
			<div class="user-info">
				<c:set var="emailId" value="${fn:split(cmt.email, '@')[0]}" />
				<c:if test="${fn:length(emailId) < 4}">
				  <c:set var="emailIdStr">${fn:substring(emailId, 0, 1)}**</c:set>
				</c:if>
				<c:if test="${fn:length(emailId) >= 4}">
				  <c:set var="emailIdStr">${fn:substring(emailId, 0, fn:length(emailId) - 3)}***</c:set>
				</c:if>
				<span class="user">${emailIdStr}</span><span class="date">${cmt.frstRegDttm}</span>
				<c:if test="${userId eq cmt.userId}">
					<a href="javascript:fn_prmtCmtDelete('${cmt.cmtSn}')" class="cm-del">삭제</a>
				</c:if>
			</div>
			<div class="memo">
				<c:out escapeXml="false" value="${fn:replace(cmt.contents, LF, '<br>')}"></c:out>
			</div>
		</li>
    </c:forEach>
</ul>

<c:if test="${fn:length(rmtCmtList) > 0}">          
	<div class="pageNumber">
		<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" /></p>
	</div> <!--//pageNumber-->
</c:if>