<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/prmt/promotionList.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 상세보기
 */
function fn_detailPromotion(prmtNum) {
	document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/mas/prmt/detailPromotion.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 수정 화면 가기
 */
function fn_UdtPromotion(prmtNum) {
	document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/mas/prmt/viewUpdatePromotion.do'/>";
	document.frm.submit();
}

/* 프로모션 승인 요청 */
function fn_approvalPromotion(prmtNum) {
	$.ajax({
		url : "<c:url value='/mas/prmt/approvalPromotion.ajax'/>",
		data : "prmtNum=" + prmtNum + "&statusCd=TS02",
		dataType:"json",
		success: function(data) {
			location.reload();
		},
		error : fn_AjaxError
	});
}

/**
 * 프로모션 삭제하기
 */
function fn_DelPromotion(prmtNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
			url: "<c:url value='/mas/prmt/deletePromotion.ajax'/>",
			data : "prmtNum=" + prmtNum,
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
 * 프로모션 등록 화면 가기
 */
function fn_insertPromotion() {
	document.frm.action = "<c:url value='/mas/prmt/viewInsertPromotion.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 승인취소
 */
function fn_approvalCancelPromotion(prmtNum) {
	$.ajax({
		url : "<c:url value='/mas/prmt/approvalPromotion.ajax'/>",
		data : "prmtNum="+prmtNum+"&statusCd=${Constant.TRADE_STATUS_REG}",
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error : fn_AjaxError
	});
}

/**
 * 프로모션 판매중지
 */
function fn_SaleStopPromotion(prmtNum) {
	$.ajax({
		url : "<c:url value='/mas/prmt/approvalPromotion.ajax'/>",
		data : "prmtNum=" + prmtNum+"&statusCd=${Constant.TRADE_STATUS_STOP}",
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error : fn_AjaxError
	})
}

/**
 * 프로모션 판매전환
 */
function fn_SaleStartPromotion(prmtNum) {
	$.ajax({
		url : "<c:url value='/mas/prmt/approvalPromotion.ajax'/>",
		data : "prmtNum=" + prmtNum+"&statusCd=${Constant.TRADE_STATUS_APPR}",
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error : fn_AjaxError
	})
}

$(function() {

});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=promotion" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="get" onSubmit="return false;">
				<input type="hidden" name="prmtNum" id="prmtNum" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />

				<div id="contents">
					<p class="search_list_ps title03">프로모션 관리 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->

					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>번호</th>
									<th>구분</th>
									<th>프로모션명</th>
									<th>적용기간</th>
									<th>상태</th>
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
								<c:forEach var="prmt" items="${resultList}"	varStatus="status">
									<tr style="cursor: pointer;">
										<td class="align_ct">${prmt.prmtNum}</td>
										<td class="align_ct">${prmt.prmtDivNm}</td>
										<td>${prmt.prmtNm}</td>
										<td class="align_ct">
											<fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
											<fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_REG}">등록중</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR_REQ}">승인요청</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR}">승인</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR_REJECT}">승인거절</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_EDIT}">수정요청</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_STOP}">판매중지</c:if>
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${prmt.frstRegDttm}" var="frstRegDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<c:if test="${Constant.TRADE_STATUS_REG eq prmt.statusCd }">
												<div class="btn_sty06"><span><a href="javascript:fn_UdtPromotion('${prmt.prmtNum}')">수정</a></span></div>
												<div class="btn_sty06"><span><a href="javascript:fn_approvalPromotion('${prmt.prmtNum}')">승인요청</a></span></div>
												<div class="btn_sty09"><span><a href="javascript:fn_DelPromotion('${prmt.prmtNum}')">삭제</a></span></div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq prmt.statusCd }">
												<div class="btn_sty06"><span><a href="javascript:fn_UdtPromotion('${prmt.prmtNum}')">수정</a></span></div>
												<div class="btn_sty06"><span><a href="javascript:fn_approvalCancelPromotion('${prmt.prmtNum}')">요청취소</a></span></div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR eq prmt.statusCd }">
												<!-- 20.05.13 공지사항일 경우 승인일 경우에 수정버튼 활성화_김지연  -->
												<c:if test="${prmt.prmtDiv eq 'NOTI' }">
													<div class="btn_sty06"><span><a href="javascript:fn_UdtPromotion('${prmt.prmtNum}')">수정</a></span></div>
												</c:if>
												<div class="btn_sty06"><span><a href="javascript:fn_detailPromotion('${prmt.prmtNum}')">상세</a></span></div>
												<div class="btn_sty06"><span><a href="javascript:fn_SaleStopPromotion('${prmt.prmtNum}')">판매중지</a></span></div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_EDIT eq prmt.statusCd }">
												<div class="btn_sty06"><span><a href="javascript:fn_detailPromotion('${prmt.prmtNum}')">상세</a></span></div>
												<div class="btn_sty06"><span><a href="javascript:fn_UdtPromotion('${prmt.prmtNum}')">수정</a></span></div>
												<div class="btn_sty06"><span><a href="javascript:fn_approvalPromotion('${prmt.prmtNum}')">승인요청</a></span></div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_STOP eq prmt.statusCd }">
												<div class="btn_sty06"><span><a href="javascript:fn_detailPromotion('${prmt.prmtNum}')">상세</a></span></div>
												<div class="btn_sty06"><span><a href="javascript:fn_SaleStartPromotion('${prmt.prmtNum}')">판매전환</a></span></div>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>

					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_insertPromotion()">등록</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>