<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
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
	if($("#sUsedStartDt").val()){
		if(!$("#sUsedEndDt").val()) {
			var d = new Date();
			$("#sUsedEndDt").val(d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2));
		}
	}

	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/bisProductAnls.do'/>";
	document.frm.submit();
}

function fn_DetailRsv(rsvNum) {
	$("#rsvNum").val(rsvNum);
	document.frm.action = "<c:url value='/oss/detailRsv.do'/>";
	document.frm.submit();
}

function fn_ExcelDown() {
	if(!$("#sStartDt").val() || !$("#sEndDt").val()){
		alert("날짜범위를 지정해주세요. 6개월 이내");
		$('#sStartDt').focus();
		return;
	}
	var strSDate = $("#sStartDt").val();
	var strEDate = $("#sEndDt").val();
	
	var arraySDate = strSDate.split("-");
	var arrayEDate = strEDate.split("-");
	
	var sDate = new Date(arraySDate[0], arraySDate[1], arraySDate[2]);
	var eDate = new Date(arrayEDate[0], arrayEDate[1], arrayEDate[2]);
	
	var diff = eDate - sDate;
	var currDay = 24 * 60 * 60 * 1000;
	
	if(parseInt(diff / currDay) > 180){
		alert("날짜범위를 지정해주세요. 6개월 이내");
		$('#sStartDt').focus();
		return;
	}
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/bisProductAnlsExcel.do?' />"+ parameters;
}

$(document).ready(function() {
	$("#sStartDt, #sEndDt, #sUsedStartDt, #sUsedEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=bis" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=bis&sub=prdtSale" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="rsvNum" name="rsvNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="85" />
										<col width="300" />
										<col width="85" />
										<col width="300" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">예약일자</th>
											<td>
												<input type="text" id="sStartDt" class="input_text5 center" name="sStartDt" value="${searchVO.sStartDt}" title="예약일자 시작" /> ~
												<input type="text" id="sEndDt" class="input_text5 center" name="sEndDt"  title="예약일자 종료" value="${searchVO.sEndDt}"/>
											</td>
										</tr>
										<tr>
											<th scope="row">카테고리</th>
											<td>
												<select name="sCorpCd">
													<option value="">전체</option>
													<c:forEach var="corpCd" items="${corpCdList}">
														<option value="${corpCd.cdNum}" <c:if test="${searchVO.sCorpCd eq corpCd.cdNum}">selected="true"</c:if>><c:out value="${corpCd.cdNm}" /></option>
													</c:forEach>
												</select>
											</td>
										</tr>
                                        <tr>
                                            <th scope="row">상&nbsp;품&nbsp;명</th>
                                            <td>
                                                <input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="상품명을 입력하세요." maxlength="20" />
                                            </td>
                                            <th scope="row">업&nbsp;체&nbsp;명</th>
                                            <td>
                                                <input type="text" id="sCorpNm" class="input_text13" name="sCorpNm" value="${searchVO.sCorpNm}" title="업체명을 입력하세요." maxlength="20" />
                                            </td>
                                        </tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>
					<%--<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>--%>
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<colgroup>
                                <col width="50" />
								<col width="100" />
								<col />
								<col />
								<col width="100" />
								<col width="150" />
								<col width="100" />
								<col width="150" />
								<col width="100" />
								<col width="150" />
							</colgroup>
							<thead>
								<tr>
                                    <th>순번</th>
									<th>카테고리</th>
									<th>업체명</th>
									<th>상품명</th>
									<th>순매출건수</th>
									<th>순매출액</th>
									<th>매출건수</th>
									<th>매출액</th>
									<th>취소건수</th>
									<th>취소금</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="10" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach items="${resultList}" var="resultList" varStatus="stauts">
									<tr style="cursor:pointer;">
                                        <td class="align_ct">${resultList.rn}</td>
										<td class="align_ct">${resultList.cdNm}</td>
										<td class="align_ct">${resultList.corpNm}</td>
										<td class="align_ct">${resultList.prdtNm}</td>
										<td class="align_ct">${resultList.rSaleCnt}</td>
										<td class="align_rt"><fmt:formatNumber>${resultList.rSaleAmt}</fmt:formatNumber></td>
										<td class="align_ct">${resultList.saleCnt}</td>
										<td class="align_rt"><fmt:formatNumber>${resultList.saleAmt}</fmt:formatNumber></td>
										<td class="align_ct">${resultList.cancelCnt}</td>
										<td class="align_rt"><fmt:formatNumber>${resultList.cancelAmt}</fmt:formatNumber></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>