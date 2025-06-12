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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

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
	document.frm.action = "<c:url value='/oss/chckPrdtExpireList.do'/>";
	document.frm.submit();
}

function fn_LoginMas(corpId){
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				window.open("<c:url value='/mas/home.do'/>", '_blank');
			}else{
				alert("업체 로그인에 실패하였습니다.");
			}
		}
	});
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/chckPrdtExpireExcel.do?"+ parameters +"'/>";

}

function fn_SaveEndExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/chckPrdtEndExcel.do?"+ parameters +"'/>";

}

$(document).ready(function(){
	$("#sConfRequestStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfRequestEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sConfRequestEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfRequestStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
});
</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=chckPrdtExpire" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="prdtNum" name="prdtNum" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
			<!--검색-->
            <div class="search_box">
            	<div class="search_form">
                	<div class="tb_form">
						<table width="100%" border="0">
							<colgroup>
                                <col width="30" />
                                <col width="50" />
                                <col width="30" />
                                <col width="50" />
                            </colgroup>
             				<tbody>
               					<tr>
        							<th scope="row">상품구분</th>
        							<td>
        								<select name="sPrdtCd" id="sPrdtCd">
        									<option value="${Constant.ACCOMMODATION}" <c:if test="${searchVO.sPrdtCd eq Constant.ACCOMMODATION}">selected="selected"</c:if>>숙소</option>
        									<option value="${Constant.RENTCAR}" <c:if test="${searchVO.sPrdtCd eq Constant.RENTCAR}">selected="selected"</c:if>>렌터카</option>
        								</select>
        							</td>
        							<th scope="row">날짜선택</th>
        							<td>
        								<select name="sMonthEnd" id="sMonthEnd">
        									<option value="" <c:if test="${empty searchVO.sMonthEnd}">selected="selected"</c:if>> 전체</option>
        									<option value="1" <c:if test="${searchVO.sMonthEnd eq 1}">selected="selected"</c:if>> 1개월</option>
        									<option value="2" <c:if test="${searchVO.sMonthEnd eq 2}">selected="selected"</c:if>> 2개월</option>
        									<option value="3" <c:if test="${searchVO.sMonthEnd eq 3}">selected="selected"</c:if>> 3개월</option>
        									<option value="4" <c:if test="${searchVO.sMonthEnd eq 4}">selected="selected"</c:if>> 4개월</option>
        									<option value="5" <c:if test="${searchVO.sMonthEnd eq 5}">selected="selected"</c:if>> 5개월</option>
        									<option value="6" <c:if test="${searchVO.sMonthEnd eq 6}">selected="selected"</c:if>> 6개월</option>
        									<option value="7" <c:if test="${searchVO.sMonthEnd eq 7}">selected="selected"</c:if>> 7개월</option>
        									<option value="8" <c:if test="${searchVO.sMonthEnd eq 8}">selected="selected"</c:if>> 8개월</option>
        									<option value="9" <c:if test="${searchVO.sMonthEnd eq 9}">selected="selected"</c:if>> 9개월</option>
        									<option value="10" <c:if test="${searchVO.sMonthEnd eq 10}">selected="selected"</c:if>>10개월</option>
        									<option value="11" <c:if test="${searchVO.sMonthEnd eq 11}">selected="selected"</c:if>>11개월</option>
        									<option value="12" <c:if test="${searchVO.sMonthEnd eq 12}">selected="selected"</c:if>>12개월</option>
        								</select>
        							</td>
     							</tr>
     							<tr>
     								<th scope="row">업&nbsp;체&nbsp;명</th>
        							<td><input type="text" id="sCorpNm" class="input_text15" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명를 입력하세요." /></td>
     							</tr>
     						</tbody>
               			</table>
               		</div>
					<span class="btn">
						<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
					</span>
              	</div>
            </div>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				<thead>
					<tr>
						<th>숙소 승인업체수</th>
						<th>숙소 판매업체수</th>
						<th>숙소 판매가능업체수</th>
						<th>렌트카 승인업체수</th>
						<th>렌트카 판매업체수</th>
					</tr>
					
				</thead>
				<tbody>
					<!-- 데이터 없음 -->
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="6" class="align_ct">
								<spring:message code="common.nodata.msg" />
							</td>
						</tr>
					</c:if>
						<tr>
							<c:forEach var="stasticsCnt1" items="${stasticsCnt1}" varStatus="status">
							<td class="align_ct"><c:out value="${stasticsCnt1.adTotCnt}"/></td>
							<td class="align_ct"><c:out value="${stasticsCnt1.adSaleCnt}"/><br>(사용자화면 개수)</td>
							<td class="align_ct"><c:out value="${stasticsCnt1.adSaleCnt2}"/><br>(수량/금액적용 개수)</td>
							</c:forEach>
							<c:forEach var="stasticsCnt2" items="${stasticsCnt2}" varStatus="status">
							<td class="align_ct"><c:out value="${stasticsCnt2.rcTotCnt}"/></td>
							<td class="align_ct"><c:out value="${stasticsCnt2.rcSaleCnt}"/></td>
							</c:forEach>
						</tr>
				</tbody>
			</table>
			<div class="margin-top20"></div>
            <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				<thead>
					<tr>
						<th>번호</th>
						<th>업체명</th>
						<th>만료예정상품개수</th>
						<th>수량만료일</th>
						<th>금액만료일</th>
						<th width="320">기능툴</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 없음 -->
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="6" class="align_ct">
								<spring:message code="common.nodata.msg" />
							</td>
						</tr>
					</c:if>
					<c:forEach var="prdtInfo" items="${resultList}" varStatus="status">
						<tr>
							<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
							<td class="align_ct"><c:out value="${prdtInfo.corpNm}"/></td>
							<td class="align_ct"><c:out value="${prdtInfo.confCnt}"/></td>
							<fmt:parseDate value='${prdtInfo.cntAplDt}' var='cntAplDt' pattern="yyyymmdd"/>
							<td class="align_ct"><fmt:formatDate value="${cntAplDt}" pattern="yyyy-mm-dd"/></td>
							<fmt:parseDate value='${prdtInfo.amtAplDt}' var='amtAplDt' pattern="yyyymmdd"/>
							<td class="align_ct"><fmt:formatDate value="${amtAplDt}" pattern="yyyy-mm-dd"/></td>
							<td class="align_ct">
								<div class="btn_sty09"><span><a href="javascript:fn_LoginMas('${prdtInfo.corpId}');">업체관리자</a></span></div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			</p>
			<ul class="btn_rt01">
				<li class="btn_sty02">
					<a href="javascript:fn_SaveEndExcel()">숙소기간만료 엑셀저장</a>
				</li>
				<li class="btn_sty02">
					<a href="javascript:fn_SaveExcel()">엑셀저장</a>
				</li>
			</ul>
			</div>
		</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_ProductAppr" class="lay_popup lay_ct"  style="display:none;">
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>