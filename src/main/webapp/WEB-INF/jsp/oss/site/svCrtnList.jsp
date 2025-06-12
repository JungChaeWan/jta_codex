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
	document.frm.action = "<c:url value='/oss/svCrtnList.do'/>";
	document.frm.submit();
}

/**
 * 큐레이션 상세보기
 */
function fn_detailCuration(crtnNum) {
	document.frm.crtnNum.value = crtnNum;
	document.frm.action = "<c:url value='/oss/svCrtnDtl.do'/>";
	document.frm.submit();
}

/**
 * 큐레이션 수정 화면 가기
 */
function fn_UdtCuration(crtnNum) {
	document.frm.crtnNum.value = crtnNum;
	document.frm.action = "<c:url value='/oss/svCrtnModView.do'/>";
	document.frm.submit();
}

/**
 * 큐레이션 삭제하기
 */
function fn_DelCuration(crtnNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
			url: "<c:url value='/oss/svCrtnDel.ajax'/>",
			data : "crtnNum=" + crtnNum,
			dataType: "json",
			success: function(data) {
				if(data.resultCode == '${Constant.JSON_SUCCESS}')
					fn_Search(document.frm.pageIndex.value);
				else if(data.resultCode == '${Constant.JSON_FAIL}')
					alert("<spring:message code='fail.common.delete'/>");
			},
			error : fn_AjaxError
		});
	}
}

/**
 * 큐레이션 등록 화면 가기
 */
function fn_insertCuration() {
	document.frm.action = "<c:url value='/oss/svCrtnRegView.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=curation" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<form name="frm" method="get" onSubmit="return false;">
						<input type="hidden" id="crtnNum" name="crtnNum" /> 
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />
						
						<p class="search_list_ps title03">제주특산/기념품 큐레이션 관리 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
						 <div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="table01 list_tb">
							<thead>
								<tr>
									<th>No</th>
									<th>큐레이션번호</th>
									<th>큐레이션명</th>									
									<th>상품수</th>
									<th>출력여부</th>
									<th>등록일</th>
									<th style="width: 200px">관리자툴</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="7" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="crtn" items="${resultList}"	varStatus="status">
									<tr >
										<td class="align_ct">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count }</td>
										<td class="align_ct"><c:out value="${crtn.crtnNum}" /></td>
										<td><c:out value="${crtn.crtnNm}"/></td>
										<td class="align_ct"><c:out value="${crtn.prdtCnt}"/></td>
										<td class="align_ct">
											<c:if test="${Constant.FLAG_Y eq crtn.printYn}">출력</c:if>
											<c:if test="${Constant.FLAG_N eq crtn.printYn}">미출력</c:if>
										</td>
										<td class="align_ct"><fmt:parseDate value="${crtn.frstRegDttm}" var="frstRegDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd" /></td>										
										<td class="align_ct">
											<div class="btn_sty06">
												<span><a href="javascript:fn_detailCuration('${crtn.crtnNum}')">상세</a></span>
											</div>
											<div class="btn_sty06">
												<span><a href="javascript:fn_UdtCuration('${crtn.crtnNum}')">수정</a></span>
											</div>
											<div class="btn_sty09">
												<span><a href="javascript:fn_DelCuration('${crtn.crtnNum}')">삭제</a></span>
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
							<li class="btn_sty04"><a
								href="javascript:fn_insertCuration()">등록</a></li>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>