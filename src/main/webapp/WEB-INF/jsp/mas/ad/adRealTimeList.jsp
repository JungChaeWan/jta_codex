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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
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
	document.frm.action = "<c:url value='/mas/ad/realTimeList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/mas/ad/viewInsertPrdt.do'/>";
	document.frm.submit();
}

function fn_Dtl(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/detailPrdt.do'/>";
	document.frm.submit();
}

function fn_PrdtImg(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/imgList.do'/>";
	document.frm.submit();
}

function fn_Amt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/amtList.do'/>";
	document.frm.submit();
}

function fn_Cnt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/cntList.do'/>";
	document.frm.submit();
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=realtime" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="corpId" name="corpId" value="${corpId}"/>
				<input type="hidden" id="prdtNum" name="prdtNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<h4 class="title03">객실 수량 관리</h4>
				<!--검색-->
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
          								<th scope="row"><span class="tb_search_title">명칭</span></th>
          								<td colspan="3"><input type="text" id="sPrdtNm" class="search_text_input01" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
       								</tr>
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
                    </div>
                </div>
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>상품번호</th>
							<th>명칭</th>
							<!-- <th>거래상태</th> -->
							<th>기준인원(최대)</th>
							<th>조식포함</th>
							<th>출력</th>
							<th>노출순번</th>
							<th></th>
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
						<c:forEach var="data" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct">${data.prdtNum}</td>
								<td class="align_ct">${data.prdtNm}</td>
								<!-- <td class="align_ct">${data.tradeStatus}</td> -->
								<td class="align_ct">${data.stdMem}(${data.maxiMem})</td>
								<td class="align_ct">${data.breakfastYn}</td>
								<td class="align_ct">${data.printYn}</td>
								<td class="align_ct">${data.viewSn}</td>
								<td class="align_ct">
									<!-- <div class="btn_sty06"><span><a href="javascript:fn_Dtl('${data.prdtNum}')">상세</a></span></div> -->
									<!-- <div class="btn_sty06"><span><a href="javascript:fn_Amt('${data.prdtNum}')">요금관리</a></span></div> -->
									<div class="btn_sty06"><span><a href="javascript:fn_Cnt('${data.prdtNum}')">수량관리</a></span></div>
									<!-- <div class="btn_sty06"><span><a href="javascript:fn_PrdtImg('${data.prdtNum}')">이미지관리</a></span></div> -->
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<!-- 
					<li class="btn_sty01">
						<a href="javascript:fn_Ins()">등록</a>
					</li>
					 -->
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>