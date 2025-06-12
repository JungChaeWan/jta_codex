<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
	
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/ad/adAddamtList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/mas/ad/viewInsertAdAddamt.do'/>";
	document.frm.submit();
}

function fn_Udt(aplStartDt){
	document.frm.aplStartDt.value = aplStartDt;
	document.frm.action = "<c:url value='/mas/ad/viewUpdateAdAddamt.do'/>";
	document.frm.submit();
}

function fn_UdtBkAmt(){
	// 콤마 제거
	delCommaFormat();

	var adultAddAmt = $("#adultAmt").val();
	if($("#adultAmt").val() != ""){
		if(adultAddAmt < 0){
			alert("성인 요금은 음수를 입력 할 수 없습니다.");
			$("#adultAmt").focus();
			return;
		}
	}

	var juniorAmt = $("#juniorAmt").val();
	if($("#juniorAmt").val() != ""){
		if(juniorAmt < 0){
			alert("소아 요금은 음수를 입력 할 수 없습니다.");
			$("#juniorAmt").focus();
			return;
		}
	}

	var childAmt = $("#childAmt").val();
	if($("#childAmt").val() != ""){
		if(childAmt < 0){
			alert("소아 요금은 음수를 입력 할 수 없습니다.");
			$("#childAmt").focus();
			return;
		}
	}

	document.frm.action = "<c:url value='/mas/ad/updateAdBreakfastAmt.do'/>";
	document.frm.submit();
}


$(document).ready(function(){
	if('${errorCode}' == '1'){
		alert("숙소 정보 먼저 등록 하세요.");
		//history.back();
		document.frm.action = "<c:url value='/mas/ad/adInfo.do' />";
		document.frm.submit();

	}
});


</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="corpId" name="corpId" value="${corpId}"/>
				<input type="hidden" id="aplStartDt" name="aplStartDt" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<h4 class="title03">인원추가요금(공통)</h4>
					<div class="tip">
						<ul>
							<li><p>현재 페이지에서 <strong>"인원추가요금"</strong>을 등록하시면, 전체 객실에 일괄적으로 적용됩니다.</p>
								<p>객실별로 <strong>"인원추가요금"</strong>을 달리 적용 하시려면, 탐나오 메뉴 > 상품관리 > 객실관리 > 인원추가요금(버튼)에서 추가요금을 등록하세요.</p>
								<p>객실별로 <strong>"인원추가요금"</strong>을 등록 하셨으면, 현재 페이지에 <strong>"인원추가요금"</strong>은 적용되지 않습니다.</p>
							</li>
						</ul>
					</div>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>적용 시작 일자</th>
								<th>성인 추가 요금</th>
								<th>소아 추가 요금</th>
								<th>유아 추가 요금</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="4" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="data" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;" onclick="fn_Udt('${data.aplStartDt}')">
									<td class="align_ct">${fn:substring(data.aplStartDt,0,4)}-${fn:substring(data.aplStartDt,4,6)}-${fn:substring(data.aplStartDt,6,8)}</td>
									<td class="align_ct"><fmt:formatNumber value="${data.adultAddAmt}"></fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber value="${data.juniorAddAmt}"></fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber value="${data.childAddAmt}"></fmt:formatNumber></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
					<ul class="btn_rt01">
						<li class="btn_sty01"><a href="javascript:fn_Ins()">등록</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>