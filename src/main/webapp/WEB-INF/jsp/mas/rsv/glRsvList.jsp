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
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/gl/rsvList.do'/>";
	document.frm.submit();
}

function fn_DetailRsv(glRsvNum){
	$("#glRsvNum").val(glRsvNum);
	document.frm.action = "<c:url value='/mas/gl/detailRsv.do'/>";
	document.frm.submit();
}

$(document).ready(function() {

	$("#sRentStartDtView").datepicker({
		dateFormat : "yy-mm-dd",
		minDate : "${today}",
		maxDate : '+1y'
	});
	
	$('#sRentStartDtView').change(function() {
		$('#sRentStartDt').val($('#sRentStartDtView').val().replace(/-/g, ''));
	});
	
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=rsv" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="glRsvNum" name="glRsvNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<p style="font-size: 12px; padding: 10px; font-weight: 700;">* 고객이 유선상으로 예약 취소 의사를 밝혔을 경우, 시스템 상 '취소처리' 진행이 꼭 필요합니다. </p>
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
									<col width="*" />
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
               							<th scope="row">예약일자</th>
               							<td colspan="3">
	               							<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt}"  title="검색시작일" readonly /> ~ 
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일"  readonly value="${searchVO.sEndDt}"/>
               							</td>
               						</tr>
               						<tr>
          								<th scope="row">이용일자</th>
          								<td colspan="3">
          									<input type="hidden" name="sRentStartDt" id="sRentStartDt" value="${searchVO.sRentStartDt}" />
          									<input type="text" id="sRentStartDtView" class="input_text6" name="sRentStartDtView" value="${searchVO.sRentStartDtView}" title="검색하실 대여일을 입력하세요." maxlength="10" />
          								</td>
       								</tr>
       								<tr>
          								<th scope="row">예&nbsp;약&nbsp;자</th>
          								<td><input type="text" id="sRsvNm" class="input_text13" name="sRsvNm" value="${searchVO.sRsvNm}" title="검색하실 예약자를 입력하세요." maxlength="20" /></td>
          								<th scope="row">전화번호</th>
          								<td><input type="text" id="sRsvTelnum" class="input_text6" name="sRsvTelnum" value="${searchVO.sRsvTelnum}" title="검색하실 전화번호를 입력하세요." maxlength="13" /></td>
       								</tr>
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
                    </div>
                </div>
                <p style="font-size: 12px; padding: 10px; font-weight: 700; position: relative; top: -40px; clear: both;">* 고객이 유선상으로 예약 취소 의사를 밝혔을 경우, 시스템 상 '취소처리' 진행이 꼭 필요합니다. </p>
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
                <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <col width="10%" />
                        <col width="8%" />
                        <col />
                        <col width="12%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="10%" /> 
                        <col width="10%" /> 
                        <col width="10%" />
                        <col width="5%" />
                    </colgroup>
					<thead>
						<tr>
							<%--<th>번호</th> --%>
							<th>예약번호</th>
							<th>예약상태</th>
							<th>이용일시</th>
							<th>인원</th>
							<th>예약자</th>
							<th>사용자</th>
							<th>판매금액</th>
							<th>취소수수료</th>
							<th class="font_red">예상정산액</th>
							<th>예약확인</th>
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
						<c:forEach var="rsvInfo" items="${resultList}" varStatus="status">
							<tr style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.glRsvNum}')">
								<%-- <td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>--%>
								<td class="align_ct">${rsvInfo.rsvNum}</td>
								<td class="align_ct">
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약대기</c:if>								
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">예약불가</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><span class="font02">취소요청</span></c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
								</td>
								<td class="align_ct">
									<fmt:parseDate value='${rsvInfo.useDt}${rsvInfo.useTm}' var='useDttm' pattern="yyyyMMddHH" scope="page"/>
									<fmt:formatDate value="${useDttm}" pattern="yyyy-MM-dd HH"/>시 대
								</td>
								<td class="align_ct">
									${rsvInfo.useMem}인 1조
								</td>
								<td class="align_ct">${rsvInfo.rsvNm} / ${rsvInfo.rsvTelnum}</td>
								<td class="align_ct"> ${rsvInfo.useNm} / ${rsvInfo.useTelnum }</td>
								
								<td class="align_ct">
									<fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct">
									<fmt:formatNumber>${rsvInfo.cmssAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct">
									<fmt:formatNumber>${rsvInfo.adjAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct">
									<c:if test="${rsvInfo.rsvIdtYn == 'Y'}">
										<img src="<c:url value='/images/oss/icon/check.png'/>"/>
									</c:if>
								</td>
								<!-- <td class="align_ct">${rsvInfo.modDttm}</td> -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<!-- <ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_InsPrdt()">등록</a>
					</li>
				</ul> -->
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>