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


<script type="text/javascript">




$(document).ready(function(){


});
</script>

	<div class="btn-wrap right">
		<c:if test="${ userInfo.authNm=='ADMIN'}">
			<button type="button" class="comm-btn" onclick="window.open('/web/cmm/insBLOG.do?prdtNum=${BLOGLINKVO.prdtNum}&corpCd=${BLOGLINKVO.corpCd}', 'insblog', 'width=600,height=700');">블로그 리뷰 추가</button>
		</c:if>
	</div>


	<div class="blog-list-area">
		<h6 class="top-title">리뷰 <span class="text-red">${blogListTotalCnt}</span></h6>
		<ul>

			<form name="blogFrm" id="blogFrm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" name="prdtnum" id="prdtnum" value="${BLOGLINKVO.prdtNum}" />
				<input type="hidden" name="corpCd" id="corpCd" value="${BLOGLINKVO.corpCd}" />
			</form>

			<c:forEach var="data" items="${blogList}" varStatus="status">
				<li>
					<a href="${data.blogUrl}" target="_balnk">
						<c:if test="${empty data.blogImage}">
							<div class="photo" style="background-image: url('/images/web/other/no-image.jpg')"></div>
						</c:if>
						<c:if test="${!(empty data.blogImage)}">
							<div class="photo" style="background-image: url('${data.blogImage}')"></div>
						</c:if>
						<div class="text-area">
							<div class="title"><c:out value="${data.blogTitle}"/></div>
							<div class="memo"><c:out value="${data.blogDescription}"/><br></div>
							<div class="info">
								<strong class="name"><c:out value="${data.blogSitename}"/></strong>
								<span class="date">${fn:substring(data.blogDate,0,4)}.${fn:substring(data.blogDate,4,6)}.${fn:substring(data.blogDate,6,8)}</span>
							</div>
						</div>
					</a>

					<c:if test="${ userInfo.authNm=='ADMIN'}">
						<div class="btn-wrap">
							<button type="button" class="comm-btn" onclick="window.open('/web/cmm/edtBLOG.do?prdtNum=${BLOGLINKVO.prdtNum}&corpCd=${BLOGLINKVO.corpCd}&blogLinkNum=${data.blogLinkNum}', 'insblog', 'width=600,height=700')">수정</button>
							<button type="button" class="comm-btn red" onclick="fn_blogLinkDel('${data.blogLinkNum}', '${BLOGLINKVO.prdtNum}', '${BLOGLINKVO.corpCd}')">삭제</button>
						</div>
					</c:if>

				</li>
			</c:forEach>

		</ul>

		<div class="pageNumber">
			<p class="list_pageing">
				<ui:pagination paginationInfo="${blogPaginationInfo}" type="web" jsFunction="fn_blogSearch" />
			</p>
		</div>

	</div>


