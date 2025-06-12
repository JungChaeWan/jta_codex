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
<head>

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>

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
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/rsvAvList.do'/>";
	document.frm.submit();
}

function fn_AvRsvExcelUpload(){
	if ($('#rsvAvExel').val() != '') {		
		if ($('#rsvAvExel').val().indexOf('.xlsx')) {
			document.frm.action = "<c:url value='/oss/rsvAvExcelUpload.do'/>";
			document.frm.submit();
			
			$('#rsvAvState').html("처리 중 ...");
		}			
		else
			alert('첨부파일을 "파일 형식 > Excel 통합 문서(.xlsx)" 로 변환 후 진행해 주세요.');
		
	} else {
		alert('항공 예약 excel 파일을 확인 하세요.');
		return false;
	}
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
	<jsp:include page="/oss/head.do?menu=rsv" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=rsv&sub=rsvAv" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="rsvFrm" method="post" enctype="multipart/form-data" onSubmit="return false;">
				<input type="hidden" id="rsvNum" name="rsvNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
									<col width="*" />
									<col width="130" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
               							<th scope="row">판매업체</th>
               							<td>
	               							<select name="sSaleCorp" id="sSaleCorp">
	               								<option value="ALL" <c:if test="${searchVO.sSaleCorp == 'ALL'}">selected="selected"</c:if>>전체</option>
          										<option value="${Constant.AIR_SALE_CORP_DC }" <c:if test="${searchVO.sSaleCorp == Constant.AIR_SALE_CORP_DC}">selected="selected"</c:if>>제주닷컴</option>
          										<option value="${Constant.AIR_SALE_CORP_JL }" <c:if test="${searchVO.sSaleCorp == Constant.AIR_SALE_CORP_JL}">selected="selected"</c:if>>제이엘항공</option>
          									</select>
               							</td>
               							<th scope="row">예약현황</th>
          								<td>
          									<select name="sRsvStatus" id="sRsvStatus">
          										<option value="ALL" <c:if test="${searchVO.sRsvStatus == 'ALL'}">selected="selected"</c:if>>전체</option>
          										<option value="${Constant.RSV_STATUS_CD_COM }" <c:if test="${searchVO.sRsvStatus == Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>결제완료</option>
          										<option value="${Constant.RSV_STATUS_CD_READY }" <c:if test="${searchVO.sRsvStatus == Constant.RSV_STATUS_CD_READY}">selected="selected"</c:if>>예약</option>
          										<option value="${Constant.RSV_STATUS_CD_CCOM }" <c:if test="${searchVO.sRsvStatus == Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>예약취소</option>          										
          									</select>
          								</td>
               						</tr>
               						<tr>
               							<th scope="row">예약일자</th>
               							<td>
	               							<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt}"  title="검색시작일" /> ~
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일"   value="${searchVO.sEndDt}"/>
               							</td>
               							<th scope="row">예&nbsp;약&nbsp;자</th>
          								<td><input type="text" id="sRsvNm" class="input_text13" name="sRsvNm" value="${searchVO.sRsvNm}" title="검색하실 예약자를 입력하세요." maxlength="20" /></td>
               						</tr>
               						<tr>
               							<th scope="row">출발일자</th>
               							<td colspan="3">
	               							<input type="text" id="sUsedStartDt" class="input_text4 center" name="sUsedStartDt" value="${searchVO.sStartDt}"  title="출발시작일" /> ~
	               							<input type="text" id="sUsedEndDt" class="input_text4 center" name="sUsedEndDt"  title="출발종료일"   value="${searchVO.sEndDt}"/>
               							</td>
               						</tr>
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
                    </div>
                </div>
                <p class="search_list_ps title-btn">[총 <strong>${totalCnt}</strong>건] <span class="side-wrap">예약 Excel : <input type="file" name="rsvAvExel"  id="rsvAvExel" /><span id="rsvAvState"><input type="button" value="업로드" onclick="fn_AvRsvExcelUpload();" /></span></span> </p>
                <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <col width="7%" />
                        <col />
                        <col width="7%" />
                        <col width="9%" />
                        <col width="7%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="9%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="10%" />
                    </colgroup>
					<thead>
						<tr>
							<th>판매업체</th>
							<th>예약번호</th>
                            <th>예약자</th>
                            <th>예약일시</th>
                            <th>항공사</th>
                            <th>출발도시</th>
                            <th>도착도시</th>
                            <th>출발일시</th>
                            <th>인원</th>
                            <th>판매금액</th>
                            <th>예약현황</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="11" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach items="${resultList}" var="rsvInfo" varStatus="stauts">
	                		<tr style="cursor:pointer;">
	                			<td class="align_ct">
	                				<c:if test="${rsvInfo.saleCorpDiv eq Constant.AIR_SALE_CORP_DC}">제주닷컴</c:if>
                                  	<c:if test="${rsvInfo.saleCorpDiv eq Constant.AIR_SALE_CORP_JL}">제이엘항공</c:if>
	                			</td>
	                			<td class="align_ct">${rsvInfo.rsvNum}</td>
	                			<td class="align_ct">${rsvInfo.rsvNm}</td>
	                			<td class="align_ct"><fmt:formatDate value="${rsvInfo.rsvDttm}" pattern="yyyy-MM-dd HH:mm" /></td>
	                			<td class="align_ct">${airCorpMap[rsvInfo.avCorpDiv]}</td>
	                			<td class="align_ct">${airLineMap[rsvInfo.startCourseDiv]}</td>
	                			<td class="align_ct">${airLineMap[rsvInfo.endCourseDiv]}</td>
	                			<td class="align_ct"><fmt:formatDate value="${rsvInfo.useDttm}" pattern="yyyy-MM-dd HH:mm" /> </td>
	                			<td class="align_ct">${rsvInfo.mem}</td>
	                			<td class="align_rt">
	                				<span><fmt:formatNumber>${rsvInfo.saleAmt}</fmt:formatNumber></span>
	                			</td>
	                			<td class="align_ct">
                                  	<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">결제완료</c:if>
                                  	<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약</c:if>
                                  	<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">예약취소</c:if>
								</td>
	                		</tr>
	                	</c:forEach>
					</tbody>
				</table>
				</div>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>				
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>