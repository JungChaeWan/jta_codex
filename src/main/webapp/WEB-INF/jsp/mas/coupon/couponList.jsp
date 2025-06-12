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
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/couponList.do'/>";
	document.frm.submit();
}

/*
 * 쿠폰추가 이동
 */
function fn_viewInsertCoupon() {
	document.frm.action = "<c:url value='/mas/viewInsertCoupon.do'/>";
	document.frm.submit();
}

/*
 * 쿠폰 수정 이동.
 */
function fn_viewUpdateCoupon(cpId) {
	document.frm.cpId.value = cpId;
	document.frm.action="<c:url value='/mas/viewUpdateCoupon.do'/>";
	document.frm.submit();
}

/**
 * 쿠폰 상세
 */
function fn_viewCoupon(cpId) {
	document.frm.cpId.value = cpId;
	document.frm.action="<c:url value='/mas/detailCoupon.do'/>";
	document.frm.submit();
}

/**
 *  쿠폰 발행
 */
function fn_CompleteCoupon(cpId) {
	document.frm.cpId.value = cpId;
	document.frm.action="<c:url value='/mas/completeCoupon.do'/>";
	document.frm.submit();
}

/**
 * 쿠폰취소
 */
function fn_CancelCoupon(cpId) {
	document.frm.cpId.value = cpId;
	document.frm.action="<c:url value='/mas/cancelCoupon.do'/>";
	document.frm.submit();
}
/*
 * 쿠폰 삭제.
 */
function fn_deleteCoupon(cpId) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
			url: "<c:url value='/mas/deleteCoupon.ajax'/>",
			data : "cpId=" + cpId,
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
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">		
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
				<input type="hidden" id="cpId" name="cpId" />
			<div id="contents">
				 <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
				 <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>쿠폰번호</th>
								<th>상태</th>
								<th>쿠폰명</th>
								<th>적용기간</th>								
								<th>할인방식</th>								
								<th>이용수</th>
								<th>등록일</th>
								<th width="185">기능틀</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="10" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="cpInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${cpInfo.cpId}"/></td>
								<td class="align_ct">
									<c:if test="${Constant.STATUS_CD_READY eq cpInfo.statusCd}">발행대기</c:if>
									<c:if test="${Constant.STATUS_CD_COMPLETE eq cpInfo.statusCd}">발행완료</c:if>
									<c:if test="${Constant.STATUS_CD_CANCEL eq cpInfo.statusCd}">발행취소</c:if>
								</td>
								<td class="align_lt"><c:out value="${cpInfo.cpNm}" /></td>
								<td class="align_ct"><fmt:parseDate value="${cpInfo.aplStartDt}" var="aplStartDt" pattern="yyyyMMdd"/><fmt:parseDate value="${cpInfo.aplEndDt}" var="aplEndDt" pattern="yyyyMMdd"/>
								<fmt:formatDate value="${aplStartDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${aplEndDt}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_PRICE}">
					         		금액 : <fmt:formatNumber>${cpInfo.disAmt}</fmt:formatNumber> 원 
					         		</c:if>
					         		<c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE}">
					         		할인율 : <fmt:formatNumber>${cpInfo.disPct}</fmt:formatNumber> % 
					         		</c:if>
								</td>								
								<td class="align_ct"><c:out value="${cpInfo.useNum}" /></td>
								<td class="align_ct"><fmt:parseDate value="${cpInfo.regDttm}" var="regDttm" pattern="yyyy-MM-dd"/><fmt:formatDate value="${regDttm}" pattern="yyyy-MM-dd"/></td>
								<td class="align_ct">
									<c:if test="${Constant.STATUS_CD_READY eq cpInfo.statusCd}">
										<div class="btn_sty06"><span><a href="javascript:fn_viewUpdateCoupon('${cpInfo.cpId}');">수정</a></span></div>
										<div class="btn_sty06"><span><a href="javascript:fn_CompleteCoupon('${cpInfo.cpId}');">쿠폰발행</a></span></div>
									</c:if>
									<c:if test="${Constant.STATUS_CD_COMPLETE eq cpInfo.statusCd}">
										<div class="btn_sty06"><span><a href="javascript:fn_viewCoupon('${cpInfo.cpId}');">상세</a></span></div>
										<div class="btn_sty06"><span><a href="javascript:fn_CancelCoupon('${cpInfo.cpId}');">발행취소</a></span></div>
									</c:if>
									<c:if test="${Constant.STATUS_CD_CANCEL eq cpInfo.statusCd}">
										<div class="btn_sty06"><span><a href="javascript:fn_viewCoupon('${cpInfo.cpId}');">상세</a></span></div>
									</c:if>
									<c:if test="${cpInfo.useNum eq 0 }">
										<div class="btn_sty09"><span><a href="javascript:fn_deleteCoupon('${cpInfo.cpId}');">삭제</a></span></div>
									</c:if>
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
						href="javascript:fn_viewInsertCoupon()">쿠폰추가</a></li>
				</ul>
						
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>