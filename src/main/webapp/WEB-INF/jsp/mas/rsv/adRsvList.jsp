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
	document.frm.action = "<c:url value='/mas/ad/rsvList.do'/>";
	document.frm.submit();
}


function fn_DetailRsv(adRsvNum){
	$("#adRsvNum").val(adRsvNum);
	document.frm.action = "<c:url value='/mas/ad/detailRsv.do'/>";
	document.frm.submit();
}

function fn_ExcelDown(){
	var parameters = $("#frm").serialize();	
	frmFileDown.location = "<c:url value='/mas/ad/rsvExcelDown.do?"+ parameters +"'/>";	
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

	$("#sRentEndDtView").datepicker({
		dateFormat : "yy-mm-dd",
		minDate : "${today}",
		maxDate : '+1y'
	});

	$('#sRentEndDtView').change(function() {
		$('#sRentEndDt').val($('#sRentEndDtView').val().replace(/-/g, ''));
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
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="adRsvNum" name="adRsvNum" />
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
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
               							<th scope="row">예약일자</th>
               							<td>
	               							<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt}"  title="검색시작일" readonly /> ~ 
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일"  readonly value="${searchVO.sEndDt}"/>
               							</td>
               							<th scope="row">예약상태</th>
               							<td>
               								<select name="sRsvStatusCd" style="width:100%">
               									<option value="">전체</option>
               									<%-- <option value="${Constant.RSV_STATUS_CD_READY}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_READY}">selected="selected"</c:if>>예약처리중</option> --%>
               									<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>예약</option>
               									<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
               									<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청</option>
               									<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>취소완료</option>
               									<%-- <option value="${Constant.RSV_STATUS_CD_SREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">selected="selected"</c:if>>부분환불요청</option>
               									<option value="${Constant.RSV_STATUS_CD_SCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">selected="selected"</c:if>>부분환불완료</option>
               									<option value="${Constant.RSV_STATUS_CD_ACC}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">selected="selected"</c:if>>자동취소</option> --%>
               									<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>사용완료</option>
               									<%-- <option value="${Constant.RSV_STATUS_CD_ECOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">selected="selected"</c:if>>기간만료</option> --%>
               								</select>
               							</td>
               						</tr>
               						<tr>
          								<th scope="row">상&nbsp;품&nbsp;명</th>
          								<td>
          									<select id="sPrdtNum" name="sPrdtNum">
          										<option value="">-전체-</option>
          										<c:forEach items="${prdtList}" var="prdt" varStatus="status">
          											<option value="${prdt.prdtNum}" <c:if test="${searchVO.sPrdtNum == prdt.prdtNum}">selected="selected"</c:if>>${prdt.prdtNm}</option>
          										</c:forEach>
          									</select>
          									<!-- <input type="text" id="sPrdtNm" class="input_text_full" name="sPrdtNm" value="" title="검색하실 상품명를 입력하세요." /> -->
          								</td>
          								<th scope="row">이용일자</th>
          								<td>
          									<input type="hidden" name="sRentStartDt" id="sRentStartDt" value="${searchVO.sRentStartDt}" />
          									<input type="text" id="sRentStartDtView" class="input_text6" name="sRentStartDtView" value="${searchVO.sRentStartDtView}" title="검색하실 대여일을 입력하세요." maxlength="10" /> ~
											<input type="hidden" name="sRentEndDt" id="sRentEndDt" value="${searchVO.sRentEndDt}" />
											<input type="text" id="sRentEndDtView" class="input_text6" name="sRentEndDtView" value="${searchVO.sRentEndDtView}" title="검색하실 대여일을 입력하세요." maxlength="10" />
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
                        <%-- <col width="5%" /> --%>
                        <col width="10%" />
                        <col width="6%" />
                        <col />                        
                        <col width="10%" />
                        <col width="4%" />
                        <col width="4%" />
                        <col width="4%" />
                        <col width="11%" />
                        <col width="11%" />
                        <col width="7%" />
                        <col width="7%" />
                        <col width="7%" />
                        <col width="5%" />
                        <%-- <col width="10%" /> --%>
                    </colgroup>
					<thead>
						<tr>
							<!-- <th rowspan='2'>번호</th> -->
							<th rowspan='2' style="padding:0">예약번호</th>
							<th rowspan='2' style="padding:0">예약상태</th>							
							<th rowspan='2' style="padding:0">상품명</th>							
							<th rowspan='2' style="padding:0">이용일자</th>
							<th colspan='3' style="padding:0">인원</th>
							<th rowspan='2' style="padding:0">예약자</th>
							<th rowspan='2' style="padding:0">사용자</th>
							<th rowspan='2' style="padding:0">판매금액</th>
							<th rowspan='2' style="padding:0">취소수수료</th>
							<th rowspan='2' style="padding:0" class="font_red">예상정산액</th>
							<th rowspan='2' style="padding:0">예약확인</th>							
							<!-- <th rowspan='2'>최종수정일시</th> -->
						</tr>
						<tr>
							<th style="padding:0">성인</th>
							<th style="padding:0">소인</th>
							<th style="padding:0">유아</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="12" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="rsvInfo" items="${resultList}" varStatus="status">
							<tr style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.adRsvNum}')">
								<%-- <td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td> --%>								
								<td class="align_ct">${rsvInfo.rsvNum}<br>(${rsvInfo.adRsvNum})</td>
								<td class="align_ct">
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약대기</c:if>								
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">예약불가</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><span class="font02">고객취소요청</span></c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">환불완료</c:if> 
								</td>								
								<td>${rsvInfo.prdtNm}</td>								
								<td class="align_ct">
									<fmt:parseDate value='${rsvInfo.useDt}' var='useDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:formatDate value="${useDt}" pattern="yyyy-MM-dd"/>~ ${rsvInfo.useNight}박
								</td>
								<td class="align_ct">${rsvInfo.adultNum}</td>
								<td class="align_ct">${rsvInfo.juniorNum}</td>
								<td class="align_ct">${rsvInfo.childNum}</td>
								<td class="align_ct">${rsvInfo.rsvNm} / ${rsvInfo.rsvTelnum}</td>
								<td class="align_ct">${rsvInfo.useNm} / ${rsvInfo.useTelnum}</td>								
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
								<!--<td class="align_ct">${rsvInfo.modDttm}</td> -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_ExcelDown();">엑셀다운로드</a>
					</li>
				</ul>
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
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>