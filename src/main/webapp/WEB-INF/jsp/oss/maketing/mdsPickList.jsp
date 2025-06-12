<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

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
	document.frm.action = "<c:url value='/oss/mdsPickList.do'/>";
	document.frm.submit();
}

/**
 * MD's Pick 상세보기
 */
function fn_detailMdsPick(rcmdNum) {
	document.frm.rcmdNum.value = rcmdNum;
	document.frm.action = "<c:url value='/oss/mdsPickDtl.do'/>";
	document.frm.submit();
}

/**
 * MD's Pick 수정 화면 가기
 */
function fn_UdtMdsPick(rcmdNum) {
	document.frm.rcmdNum.value = rcmdNum;
	document.frm.action = "<c:url value='/oss/mdsPickModView.do'/>";
	document.frm.submit();
}

/**
 * MD's Pick 삭제하기
 */
function fn_DelMdsPick(rcmdNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
			url: "<c:url value='/oss/mdsPickDel.ajax'/>",
			data : "rcmdNum=" + rcmdNum,
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
 * MD's Pick 등록 화면 가기
 */
function fn_insertMdsPick() {
	document.frm.action = "<c:url value='/oss/mdsPickRegView.do'/>";
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
		<jsp:include page="/oss/left.do?menu=site&sub=pick" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<form name="frm" method="get" onSubmit="return false;">
					<input type="hidden" id="rcmdNum" name="rcmdNum" />
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

					<p class="search_list_ps title03">MD's Pick 관리 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->

				 	<div class="list">
						<table class="table01 list_tb" width="100%" border="1" cellspacing="0" cellpadding="0">
							<thead>
								<tr>
									<th>번호</th>
									<th>MD's Pick 제목</th>
									<th>구분</th>
									<th>업체명</th>
									<th>노출 여부</th>
									<th>등록일</th>
									<th>관리자툴</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="7" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>

								<c:forEach var="pick" items="${resultList}"	varStatus="status">
									<tr>
										<td class="align_ct"><c:out value="${pick.rcmdNum}" /></td>
										<td><c:out value="${pick.subject}"/></td>
										<td class="align_ct"><c:out value="${pick.corpGubun}"/></td>
										<td class="align_ct"><c:out value="${pick.corpNm}"/></td>
										<td class="align_ct"><c:out value="${pick.viewYn}"/></td>
										<td class="align_ct">
											<fmt:parseDate value="${pick.regDttm}" var="regDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${regDttm}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<div class="btn_sty06">
												<span><a href="javascript:fn_detailMdsPick('${pick.rcmdNum}')">상세</a></span>
											</div>
											<div class="btn_sty06">
												<span><a href="javascript:fn_UdtMdsPick('${pick.rcmdNum}')">수정</a></span>
											</div>
											<div class="btn_sty09">
												<span><a href="javascript:fn_DelMdsPick('${pick.rcmdNum}')">삭제</a></span>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>

					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_insertMdsPick()">등록</a></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>