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
	document.frm.action = "<c:url value='/mas/ad/adAddamtPrdtList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/mas/ad/viewInsertAdAddamtPrdt.do'/>";
	document.frm.submit();
}

function fn_Udt(aplStartDt){
	document.frm.aplStartDt.value = aplStartDt;
	document.frm.action = "<c:url value='/mas/ad/viewUpdateAdAddamtPrdt.do'/>";
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
	<jsp:include page="/mas/head.do?menu=product"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="corpId" name="corpId" value="${adPrdinf.prdtNum}"/>
				<input type="hidden" id="prdtNum" name="prdtNum" value="${adPrdinf.prdtNum}"/>
				<input type="hidden" id="aplStartDt" name="aplStartDt" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<h2 class="title08"><c:out value="${adPrdinf.prdtNm}"/></h2>

					<div id="menu_depth3">
						<ul>
							<li ><a class="menu_depth3" href="<c:url value='/mas/ad/detailPrdt.do?prdtNum=${adPrdinf.prdtNum}'/>">객실정보</a></li>
							<!-- <li><a class="menu_depth3" href="<c:url value='/mas/ad/cntList.do?prdtNum=${adPrdinf.prdtNum}'/>">수량관리</a></li> -->
							<li><a class="menu_depth3" href="<c:url value='/mas/ad/imgList.do?prdtNum=${adPrdinf.prdtNum}'/>">객실이미지</a></li>
							<li><a class="menu_depth3" href="<c:url value='/mas/ad/amtList.do?prdtNum=${adPrdinf.prdtNum}'/>">요금관리</a></li>
							<c:if test="${adPrdinf.ctnAplYn == 'Y'}">
								<li><a class="menu_depth3" href="<c:url value='/mas/ad/continueNight.do?prdtNum=${adPrdinf.prdtNum}'/>">연박 요금관리</a></li>
							</c:if>
							<li class="on"><a class="menu_depth3" href="<c:url value='/mas/ad/adAddamtPrdtList.do?prdtNum=${adPrdinf.prdtNum}'/>">인원추가요금</a></li>
						</ul>
					</div>
					<div class="tip">
						<ul>
							<li>
								<p>현재 페이지에서 <strong>"인원추가요금"</strong>을 등록하시면, 현재 선택된 객실에만 "인원추가요금" 이 적용됩니다.</p>
								<strong>"인원추가요금"</strong>을 등록하셨으면, 현재선택된메뉴의 가장 왼쪽메뉴 <strong>"객실정보"</strong>에서 추가요금 여부가 <strong>"추가"</strong>로 되어있는지 다시 한번 확인해주세요.</p>
								<p><strong>"전체객실"</strong>에 공통적으로 <strong>"인원추가요금"</strong>을 설정하시려면 탐나오 메뉴 > 업체정보 > 인원추가요금(공통)에서 추가요금을 등록하세요.</p>

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
									<td class="align_ct">
										${fn:substring(data.aplStartDt,0,4)}-${fn:substring(data.aplStartDt,4,6)}-${fn:substring(data.aplStartDt,6,8)}
									</td>
									<td class="align_ct">
										<fmt:formatNumber value="${data.adultAddAmt}" />
									</td>
									<td class="align_ct">
										<fmt:formatNumber value="${data.juniorAddAmt}" />
									</td>
									<td class="align_ct">
										<fmt:formatNumber value="${data.childAddAmt}" />
									</td>
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