<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

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
	document.frm.action = "<c:url value='/oss/eventList.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 상세보기
 */
function fn_detailPromotion(prmtNum) {
	document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/oss/eventDtl.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 수정 화면 가기
 */
function fn_UdtPromotion(prmtNum) {
	document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/oss/eventModView.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 삭제하기
 */
function fn_DelPromotion(prmtNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
			url: "<c:url value='/oss/eventDel.ajax'/>",
			data: "prmtNum=" + prmtNum,
			dataType: "json",
			success: function(data) {
				if(data.resultCode == '${Constant.JSON_SUCCESS}') {
					fn_Search(document.frm.pageIndex.value);
				} else if(data.resultCode == '${Constant.JSON_FAIL}') {
					alert("<spring:message code='fail.common.delete'/>");
				}
			},
			error: fn_AjaxError
		});
	}
}

/**
 * 프로모션 등록 화면 가기
 */
function fn_insertPromotion() {
	document.frm.action = "<c:url value='/oss/eventRegView.do'/>";
	document.frm.submit();
}

/**
 * 프로모션 판매중지
 */
function fn_SaleStopPromotion(prmtNum) {
	$.ajax({
		url: "<c:url value='/oss/eventApproval.ajax'/>",
		data: "prmtNum=" + prmtNum + "&statusCd=${Constant.TRADE_STATUS_STOP}",
		dataType: "json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error: fn_AjaxError
	})
}

/**
 * 프로모션 판매전환
 */
function fn_SaleStartPromotion(prmtNum) {
	$.ajax({
		url: "<c:url value='/oss/eventApproval.ajax'/>",
		data: "prmtNum=" + prmtNum + "&statusCd=${Constant.TRADE_STATUS_APPR}",
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error: fn_AjaxError
	})
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/eventListExcel.do' />?"+ parameters;
}

//엔터키 눌렸을때 처리
function enterkey() {
	if (window.event.keyCode == 13) {
		fn_Search(1);
	}
}

$(document).ready(function(){
	
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=event" />

		<div id="contents_area">
			<div id="contents">
				<form name="frm" method="get" onSubmit="return false;">
					<input type="hidden" name="prmtNum" id="prmtNum" />
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />

					<div id="menu_depth3">
						<ul>
							<li class="on"><a class="menu_depth3" href="<c:url value='/oss/eventList.do'/>">프로모션</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/eventSNList.do'/>">메인 프로모션</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/eventSvList.do'/>">제주특산/기념품 프로모션</a></li>
						</ul>
					</div>

					<p class="search_list_ps title03">
						<span>프로모션 [총 <strong>${totalCnt}</strong>건]</span>&nbsp;
						<select name="sPrmtDiv" onchange="fn_Search(1)">
						  	<option value=''>= 전 체 =</option>
							<c:forEach var="prmtDiv" items="${prmtCdList}">
								<option value="${prmtDiv.cdNum}" <c:if test="${prmtDiv.cdNum eq searchVO.sPrmtDiv}">selected</c:if>>${prmtDiv.cdNm}</option>
							</c:forEach>
						</select>
					</p>
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>번호</th>
									<th>구분</th>
									<th>프로모션명</th>
									<th>적용기간</th>
									<th>댓글사용</th>
									<th>Dday출력</th>
									<th>상태</th>
									<th>등록일</th>
									<th>조회수</th>
									<th>기능툴</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="10" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="prmt" items="${resultList}"	varStatus="status">
									<tr>
										<td class="align_ct">${prmt.prmtNum}</td>
										<td class="align_ct">${prmt.prmtDivNm}</td>
										<td>${prmt.prmtNm}</td>
										<td class="align_ct">
											<fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
											<fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<c:if test="${prmt.cmtYn eq 'Y'}">사용</c:if>
											<c:if test="${prmt.cmtYn eq 'N'}">사용안함</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${prmt.ddayViewYn eq 'Y'}">사용</c:if>
											<c:if test="${prmt.ddayViewYn eq 'N'}">사용안함</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_REG}">등록중</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR_REQ}">승인요청</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR}">승인</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR_REJECT}">승인거절</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_STOP}">판매중지</c:if>
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${prmt.frstRegDttm}" var="frstRegDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">${prmt.viewCnt}</td>
										<td class="align_ct">
											<div class="btn_sty06"><span><a href="javascript:fn_detailPromotion('${prmt.prmtNum}')">상세</a></span></div>
											<div class="btn_sty06"><span><a href="javascript:fn_UdtPromotion('${prmt.prmtNum}')">수정</a></span></div>
											<div class="btn_sty09"><span><a href="javascript:fn_DelPromotion('${prmt.prmtNum}')">삭제</a></span></div>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_APPR}">
												<div class="btn_sty06"><span><a href="javascript:fn_SaleStopPromotion('${prmt.prmtNum}')">판매중지</a></span></div>
											</c:if>
											<c:if test="${prmt.statusCd eq Constant.TRADE_STATUS_STOP}">
												<div class="btn_sty06"><span><a href="javascript:fn_SaleStartPromotion('${prmt.prmtNum}')">판매전환</a></span></div>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div style="text-align: center;height: 30px;padding-top: 5px">
							<select>
								<option value=''>프로모션명</option>
							</select>
							<input type="text" name="prmtNm" id="prmtNm" style="width: 300px" value="${searchVO.prmtNm}"  onkeyup="enterkey()">
							<span  class="btn_sty04"><a href="javascript:fn_Search(1)">검색</a></span>
						</div>
					</div>
					<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>
					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_insertPromotion()">등록</a></li>
						<li class="btn_sty02"><a href="javascript:fn_SaveExcel()">엑셀저장</a></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>