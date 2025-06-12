<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"	uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/evntInfList.do'/>";
	document.frm.submit();
}

function fn_UdtEvnt(evntCd) {
	document.frm.evntCd.value = evntCd;
	document.frm.action = "<c:url value='/oss/updateEvntInfView.do'/>";
	document.frm.submit();
}

function fn_DelEvnt(evntCd){
	document.frm.evntCd.value = evntCd;
	document.frm.action = "<c:url value='/oss/deleteEvntInf.do'/>";
	document.frm.submit();
}

function fn_insertMdsPick() {
	document.frm.action = "<c:url value='/oss/insertEvntView.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=evnt" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<form name="frm" method="get" onSubmit="return false;">
						<input type="hidden" id="evntCd" name="evntCd" /> 
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />
						
						<p class="search_list_ps title03">이벤트 정보 관리 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
						 <div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="table01 list_tb">
							<thead>
								<tr>
									<th>이벤트 코드</th>
									<th>대상 업체명</th>
									<th>유효 시작 일자</th>
									<th>유효 종료 일자</th>
									<th>설명</th>
									<th>등록일</th>
									<th>관리자툴</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="7" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="result" items="${resultList}"	varStatus="status">
									<tr >
										<td class="align_ct"><c:out value="${result.evntCd}" /></td>
										<td class="align_ct"><c:out value="${result.tgtCorpNm}"/></td>
										<td class="align_ct">
											<fmt:parseDate value="${result.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${result.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct"><c:out value="${result.evntExp}"/></td>
										<td class="align_ct"><fmt:parseDate value="${result.regDttm}" var="regDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${regDttm}" pattern="yyyy-MM-dd" /></td>
										<td class="align_ct">
											<div class="btn_sty06">
												<span><a href="javascript:fn_UdtEvnt('${result.evntCd}')">수정</a></span>
											</div>
											<div class="btn_sty09">
												<span><a href="javascript:fn_DelEvnt('${result.evntCd}')">삭제</a></span>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
						<ul class="btn_rt01">
							<li class="btn_sty04"><a href="javascript:fn_insertMdsPick()">등록</a></li>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>