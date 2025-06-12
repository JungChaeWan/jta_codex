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
//function fn_Search(pageIndex) {
function fn_Search(pageIndex) {
	//document.frm.pageIndex.value = pageIndex;
	$("#sYYYYMM").val( $("#sYYYY").val() + $("#sMM").val()  );
	document.frm.action = "<c:url value='/oss/mkingHistList.do'/>";
	document.frm.submit();
}


function fn_Udt(mkingHistNum) {
	document.frm.mkingHistNum.value = mkingHistNum;
	document.frm.action = "<c:url value='/oss/mkingHistUdtView.do'/>";
	document.frm.submit();
}




function fn_Ins() {
	//document.frm.pageIndex.value = 0;
	document.frm.action = "<c:url value='/oss/mkingHistInsView.do'/>";
	document.frm.submit();
}


function fn_Del(mkingHistNum) {
	if(confirm("삭제 하시겠습까?")){
		//document.frm.pageIndex.value = 0;
		document.frm.mkingHistNum.value = mkingHistNum;
		document.frm.action = "<c:url value='/oss/mkingHistDel.do'/>";
		document.frm.submit();
	}
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/mkingHistExcel.do?"+ parameters +"'/>";

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
		<jsp:include page="/oss/left.do?menu=maketing&sub=mkingHistList" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<form name="frm" method="get" onSubmit="return false;">
						<input type="hidden" id="mkingHistNum" name="mkingHistNum" />
						<input type="hidden" id="sYYYYMM" name="sYYYYMM" value="${MKINGHISTVO.sYYYYMM}"/>

						<div class="search_box">
			            	<div class="search_form">
			                	<div class="tb_form">
									<table width="100%" border="0">
										<colgroup>
			                                <col width="100" />
			                                <col width="*" />
			                            </colgroup>
			             				<tbody>
			             					<tr>
			               						<th scope="row">월 선택</th>
			               						<td colspan="5">
			               							<select  name="sYYYY" id="sYYYY" >
			        									<c:forEach var="i" begin="2015" end="${maxYear }" step="1">
			        										<option value="${i}" <c:if test="${MKINGHISTVO.sYYYY == i}">selected="selected"</c:if>>${i}</option>
			        									</c:forEach>
			        								</select>
			        								년
			        								<select  name="sMM" id="sMM">
			        									<c:forEach var="i" begin="1" end="9" step="1">
			        										<option value="0${i}" <c:if test="${fn:substring(MKINGHISTVO.sMM,1, 2) == i}">selected="selected"</c:if>>${i}</option>
			        									</c:forEach>
			        									<c:forEach var="i" begin="10" end="12" step="1">
			        										<option value="${i}" <c:if test="${MKINGHISTVO.sMM == i}">selected="selected"</c:if>>${i}</option>
			        									</c:forEach>
			        								</select>
			        								월

			        								<li class="btn_sty04"><a href="javascript:fn_Search()">조회</a></li>

			               						</td>
			               					</tr>
			     						</tbody>
			               			</table>
			               		</div>

			               										<%--
								<span class="btn">
									<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="조회" onclick="javascript:fn_Search('1')" />
								</span>
								 --%>

			              	</div>
			            </div>

			            <p class="search_list_ps title03">[총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->

						<div class="list">

							<table width="100%" border="1" cellspacing="0" cellpadding="0"
								class="table01 list_tb">
								<thead>
									<tr>
										<th>업체명</th>
										<th>상품명</th>
										<th>홍보일자</th>
										<th>진행매체</th>
										<th>홍보비</th>
										<th>판매기준</th>
										<th>이전매출액</th>
										<th>판매금액</th>
										<th>판매횟수</th>
										<th>수익률</th>
										<th>비고</th>
										<th></th>
									</tr>
								</thead>

								<tbody>
									<!-- 데이터 없음 -->
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="15" class="align_ct"><spring:message code="common.nodata.msg" /></td>
										</tr>
									</c:if>
									<c:forEach var="data" items="${resultList}"	varStatus="status">
										<tr >
											<td class="align_ct"><c:out value="${data.corpNm}" /></td>
											<td class="align_ct"><c:out value="${data.prdtNm}" /></td>
											<td class="align_ct">${fn:substring(data.mkingDt,0,4)}-${fn:substring(data.mkingDt,4,6)}-${fn:substring(data.mkingDt,6,8)}</td>
											<td class="align_ct">
												<c:choose>
													<c:when test="${data.media == '1'}">키워드</c:when>
													<c:when test="${data.media == '2'}">DA</c:when>
													<c:when test="${data.media == '3'}">(탐)블로그</c:when>
													<c:when test="${data.media == '4'}">(탐)페이스북</c:when>
													<c:when test="${data.media == '5'}">(탐)인스타</c:when>
													<c:when test="${data.media == '6'}">(외)블로그</c:when>
													<c:when test="${data.media == '7'}">(외)SNS</c:when>
													<c:when test="${data.media == '8'}">기획전</c:when>
													<c:when test="${data.media == '9'}">이벤트</c:when>
													<c:when test="${data.media == '10'}">기타</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td class="align_ct"><fmt:formatNumber value="${data.adtmPay}"/></td>
											<td class="align_ct">
												${fn:substring(data.stdStartDttm,0,4)}-${fn:substring(data.stdStartDttm,4,6)}-${fn:substring(data.stdStartDttm,6,8)}
												~
												${fn:substring(data.stdEndDttm,0,4)}-${fn:substring(data.stdEndDttm,4,6)}-${fn:substring(data.stdEndDttm,6,8)}
											</td>
											<td class="align_ct"><fmt:formatNumber value="${data.sealesBf}"/></td>
											<td class="align_ct"><fmt:formatNumber value="${data.seales}"/></td>
											<td class="align_ct"><fmt:formatNumber value="${data.sealesCnt}"/></td>
											<td class="align_ct">
												<fmt:formatNumber value="${data.seales/data.adtmPay}" type="percent"/>												<%-- <fmt:formatNumber value="${data.sealesPnt}"/> --%>
											</td>
											<td class="align_ct"><c:out value="${data.memo}" /></td>
											<td class="align_ct">
												<div class="btn_sty06">
													<span><a href="javascript:fn_Udt('${data.mkingHistNum}')">수정</a></span>
												</div>
												<div class="btn_sty09">
													<span><a href="javascript:fn_Del('${data.mkingHistNum}')">삭제</a></span>
												</div>
											</td>
										</tr>

									</c:forEach>

									<tr>
										<th colspan="4">계</th>
										<th><fmt:formatNumber value="${mkSum.adtmPay}"/></th>
										<th> - </td>
										<th><fmt:formatNumber value="${mkSum.sealesBf}"/></th>
										<th><fmt:formatNumber value="${mkSum.seales}"/></th>
										<th><fmt:formatNumber value="${mkSum.sealesCnt}"/></th>
										<th class="align_ct">
											<fmt:formatNumber value="${mkSum.seales/mkSum.adtmPay}" type="percent"/>												<%-- <fmt:formatNumber value="${data.sealesPnt}"/> --%>
										</th>
										<th> - </th>
										<th> - </th>

									</tr>
								</tbody>

							</table>

						</div>


						<%--
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
						 --%>

						<ul class="btn_rt01">
							<li class="btn_sty02">
								<a href="javascript:fn_SaveExcel()">엑셀저장</a>
							</li>

							<li class="btn_sty04"><a href="javascript:fn_Ins()">등록</a></li>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>