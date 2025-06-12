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
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<script type="text/javascript">

function fn_Search(){
	document.frm.action = "<c:url value='/oss/bisDayDayAnls.do'/>";
	document.frm.submit();
}

function fn_Update(){
	delCommaFormat();
	
	document.dayFrm.action = "<c:url value='/oss/updateDayDayAnls.do'/>";
	document.dayFrm.submit();
}


$(document).ready(function() {
	var cateArr = ['rsvCnt', 'saleAmt', 'prevRsvCnt', 'prevSaleAmt', 'month3RsvCnt', 'month3SaleAmt', 'month2RsvCnt', 'month2SaleAmt', 'month1RsvCnt', 'month1SaleAmt', 'yearRsvCnt', 'yearSaleAmt', 'totalRsvCnt', 'totalSaleAmt'];
	
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	cateArr.forEach(function (k, v) {
		var sumNumber = 0;
		$('.' + k).each(function() {
			var chkNum = $(this).html().trim() == "" ? $(this).val() : $(this).html();
			sumNumber += eval(chkNum.replace(/(,)/g, ""));
		});
		$("#" + k + "Sum").html(commaNum(sumNumber));		
	});
	
	$("#cYearSaleAmtSum").html($("#saleAmtSum").html());
	$("#cPyearSaleAmtSum").html($("#prevSaleAmtSum").html());
	
	var cYearSaleAmtPer = $("#cPyearSaleAmtSum").html() != 0 ? parseInt($("#cYearSaleAmtSum").html().replace(/(,)/g, "") / eval($("#cPyearSaleAmtSum").html().replace(/(,)/g, "")) * 1000) / 10 : 0;
	$('#cYearSaleAmtPer').html(cYearSaleAmtPer + ' %');
	
	var cMonth3SaleAmtPer = "${dayPrevInfo.prevMonth3SaleAmt }" != 0 ? parseInt($("#month3SaleAmtSum").html().replace(/(,)/g, "") / eval("${dayPrevInfo.prevMonth3SaleAmt }") * 1000) / 10 : 0;	
	$("#cMonth3SaleAmtPer").html(cMonth3SaleAmtPer + ' %');
	
	var cMonth2SaleAmtPer = "${dayPrevInfo.prevMonth2SaleAmt }" != 0 ? parseInt($("#month2SaleAmtSum").html().replace(/(,)/g, "") / eval("${dayPrevInfo.prevMonth2SaleAmt }") * 1000) / 10 : 0;	
	$("#cMonth2SaleAmtPer").html(cMonth2SaleAmtPer + ' %');
	
	var cMonth1SaleAmtPer = "${dayPrevInfo.prevMonth1SaleAmt }" != 0 ? parseInt($("#month1SaleAmtSum").html().replace(/(,)/g, "") / eval("${dayPrevInfo.prevMonth1SaleAmt }") * 1000) / 10 : 0;	
	$("#cMonth1SaleAmtPer").html(cMonth1SaleAmtPer + ' %');
	
	var roasPer = "${adtmAmt }" != 0 ? parseInt($("#saleAmtSum").html().replace(/(,)/g, "") / eval("${adtmAmt }") * 1000) / 10 : 0;
	$("#roasPer").html(roasPer + ' %');
	
	var cvrPer = "${dayAnls.visitorNum }" != 0 ? parseInt($("#rsvCntSum").html().replace(/(,)/g, "") / eval("${dayAnls.visitorNum }") * 1000) / 10 : 0;
	$("#cvrPer").html(cvrPer + ' %');
	
	
});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=bis" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
        <div id="side_area"> 
            <!--사이드메뉴-->
            <div class="side_menu">
                <jsp:include page="/oss/left.do?menu=bis&sub=dayDay" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            
            <!-- change contents -->				
				<form name="frm" method="post" onSubmit="return false;">
	            <div class="tb_form">
	            	<ul class="btn_lt01">
						<li>
							<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt }" title="검색일" onchange="fn_Search();" />
						</li>
					
						<li class="btn_sty01">
							<a href="javascript:fn_Update();">정보 저장</a>
						</li>
					</ul>
	            </div>
			    </form>
			    <form name="dayFrm" method="post" onSubmit="return false;">
			    <input type="hidden" name="anlsDt" value="${searchVO.sStartDt }" />
			    <table class="table01 center">
			        <colgroup>
			            <col width="133" />
			            <col width="71" />
			            <col width="115" />
			            <col width="121" />
			            <col width="141" span="3" />
			            <col width="95" />
			            <col width="131" />
			            <col width="67" />
			            <col width="136" />
			        </colgroup>			        
			        <thead>
			            <tr>			            	
			            	<fmt:parseDate var="toDay" value="${searchVO.sStartDt }" pattern="yyyy-MM-dd"/>
			            	<c:set var="currentYear"><fmt:formatDate value="${toDay }" pattern="yyyy" /></c:set>
			                <th rowspan="2">구분</th>
			                <th colspan="3">일일 매출 (<fmt:formatDate value="${toDay }" pattern="MM/dd" />, <fmt:formatDate value="${toDay }" pattern="E" />)<br />
			                    * 실시간 취소에 따라 변동될 수 있음</th>
			                <th colspan="3">　</th>
			                <th colspan="2">${currentYear }년 계</th>
			                <th colspan="2">총 누계<br />
			                    (2016~<fmt:formatDate value="${toDay }" pattern="yyyy" />)</th>
			            </tr>
			            <tr>
			                <th>건수</th>
			                <th>매출액</th>
			                <th>전년    동일<br />			                
			                <c:set var="prevDate">${currentYear-1 }.<fmt:formatDate value="${toDay }" pattern="MM.dd" /></c:set>
			                <fmt:parseDate var="prevDateInfo" value="${prevDate }" pattern="yyyy.MM.dd"/>
			                  ${prevDate } (<fmt:formatDate value="${prevDateInfo }" pattern="E" />)</th>
			                <th>${prev3Month }월</th> 
			                <th>${prev2Month }월</th>
			                <th>${prev1Month }월</th>
			                <th>건수</th>
			                <th>매출액</th>
			                <th>건수</th>
			                <th>매출액</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td rowspan="2">항공 (제이엘)</td>
			                <td rowspan="2"><input type="text" name="avJlCnt" value="${dayAnls.avJlCnt }" class="numFormat rsvCnt" style="width: 50px; text-align: center;" /></td> 
			                <td rowspan="2"><input type="text" name="avJlSaleamt" value="${dayAnls.avJlSaleamt }" class="numFormat saleAmt" style="width: 90px; text-align: center;" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${dayAvInfo.prevAvJlCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${dayAvInfo.month3AvJlCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${dayAvInfo.month2AvJlCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${dayAvInfo.month1AvJlCnt }" /></td>
			                <td rowspan="4" class='yearRsvCnt'><fmt:formatNumber value="${dayAvInfo.yearAvJlCnt + dayAvInfo.yearAvJcCnt }" /></td>
			                <td rowspan="4" class='yearSaleAmt'><fmt:formatNumber value="${dayAvInfo.yearAvJlSaleamt + dayAvInfo.yearAvJcSaleamt }" /></td>
			                <td rowspan="4" class='totalRsvCnt'><fmt:formatNumber value="${dayAvInfo.totalAvJlCnt + dayAvInfo.totalAvJcCnt }" /></td>
			                <td rowspan="4" class='totalSaleAmt'><fmt:formatNumber value="${dayAvInfo.totalAvJlSaleamt + dayAvInfo.totalAvJcSaleamt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${dayAvInfo.prevAvJlSaleamt }" /></td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${dayAvInfo.month3AvJlSaleamt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${dayAvInfo.month2AvJlSaleamt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${dayAvInfo.month1AvJlSaleamt }" /></td>
			            </tr>			            
			            <tr>
			                <td rowspan="2">항공 (제주닷컴)</td>
			                <td rowspan="2"><input type="text" name="avJcCnt" value="${dayAnls.avJcCnt }" class="numFormat rsvCnt" style="width: 50px; text-align: center;" /></td>
			                <td rowspan="2"><input type="text" name="avJcSaleamt" value="${dayAnls.avJcSaleamt }" class="numFormat saleAmt" style="width: 90px; text-align: center;" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${dayAvInfo.prevAvJcCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${dayAvInfo.month3AvJcCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${dayAvInfo.month2AvJcCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${dayAvInfo.month1AvJcCnt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${dayAvInfo.prevAvJcSaleamt }" /></td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${dayAvInfo.month3AvJcSaleamt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${dayAvInfo.month2AvJcSaleamt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${dayAvInfo.month1AvJcSaleamt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">숙박(+단품숙박)</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.AD.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.AD.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.AD.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.AD.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.AD.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.AD.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.AD.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.AD.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.AD.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.AD.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.AD.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.AD.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.AD.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.AD.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">렌터카(+단품렌터카)</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.RC.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.RC.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.RC.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.RC.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.RC.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.RC.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.RC.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.RC.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.RC.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.RC.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.RC.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.RC.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.RC.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.RC.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">관광지/레저</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.C200.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.C200.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.C200.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.C200.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.C200.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.C200.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.C200.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.C200.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.C200.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.C200.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.C200.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.C200.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.C200.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.C200.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">맛집</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.C300.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.C300.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.C300.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.C300.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.C300.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.C300.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.C300.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.C300.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.C300.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.C300.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.C300.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.C300.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.C300.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.C300.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">버스/택시관광</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.C160.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.C160.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.C160.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.C160.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.C160.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.C160.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.C160.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.C160.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.C160.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.C160.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.C160.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.C160.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.C160.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.C160.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">골프패키지</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.C170.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.C170.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.C170.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.C170.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.C170.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.C170.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.C170.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.C170.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.C170.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.C170.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.C170.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.C170.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.C170.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.C170.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">카텔/에어카텔</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.C120.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.C120.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.C120.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.C120.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.C120.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.C120.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.C120.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.C120.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.C120.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.C120.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.C120.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.C120.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.C120.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.C120.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">제주특산/기념품</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.SV.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.SV.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.SV.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.SV.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.SV.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.SV.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.SV.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.SV.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.SV.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.SV.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.SV.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.SV.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.SV.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.SV.month1SaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td rowspan="2">카시트/유모차 대여</td>
			                <td rowspan="2" class='rsvCnt'><fmt:formatNumber value="${rsvInfo.C500.rsvCnt }" /></td>
			                <td rowspan="2" class='saleAmt'><fmt:formatNumber value="${rsvInfo.C500.saleAmt }" /></td>
			                <td class='prevRsvCnt'><fmt:formatNumber value="${rsvInfo.C500.prevRsvCnt }" /></td>
			                <td class='month3RsvCnt'><fmt:formatNumber value="${rsvInfo.C500.month3RsvCnt }" /></td>
			                <td class='month2RsvCnt'><fmt:formatNumber value="${rsvInfo.C500.month2RsvCnt }" /></td>
			                <td class='month1RsvCnt'><fmt:formatNumber value="${rsvInfo.C500.month1RsvCnt }" /></td>
			                <td rowspan="2" class='yearRsvCnt'><fmt:formatNumber value="${rsvInfo.C500.yearRsvCnt }" /></td>
			                <td rowspan="2" class='yearSaleAmt'><fmt:formatNumber value="${rsvInfo.C500.yearSaleAmt }" /></td>
			                <td rowspan="2" class='totalRsvCnt'><fmt:formatNumber value="${rsvInfo.C500.totalRsvCnt }" /></td>
			                <td rowspan="2" class='totalSaleAmt'><fmt:formatNumber value="${rsvInfo.C500.totalSaleAmt }" /></td>
			            </tr>
			            <tr>
			                <td class='prevSaleAmt'><fmt:formatNumber value="${rsvInfo.C500.prevSaleAmt }" /> </td>
			                <td class='month3SaleAmt'><fmt:formatNumber value="${rsvInfo.C500.month3SaleAmt }" /></td>
			                <td class='month2SaleAmt'><fmt:formatNumber value="${rsvInfo.C500.month2SaleAmt }" /></td>
			                <td class='month1SaleAmt'><fmt:formatNumber value="${rsvInfo.C500.month1SaleAmt }" /></td>
			            </tr>			            
			            <tr>
			                <th rowspan="2">매출 총계</th>
			                <th rowspan="2" id="rsvCntSum">0</th>
			                <th rowspan="2" id="saleAmtSum">0</th>
			                <th id="prevRsvCntSum">0</th>
			                <th id="month3RsvCntSum">0</th>
			                <th id="month2RsvCntSum">0</th>
			                <th id="month1RsvCntSum">0</th>
			                <th rowspan="2" id="yearRsvCntSum">0</th>
			                <th rowspan="2" id="yearSaleAmtSum">0</th>
			                <th rowspan="2" id="totalRsvCntSum">0 </th>
			                <th rowspan="2" id="totalSaleAmtSum">0</th>
			            </tr>
			            <tr>
			            	<th id="prevSaleAmtSum">0</th>
			                <th id="month3SaleAmtSum">0</th>
			                <th id="month2SaleAmtSum">0</th>
			                <th id="month1SaleAmtSum">0</th>
			            </tr>
			            <tr>
			                <td>전년도동월매출</td>
			                <td rowspan="2">동일비교</td>
			                <td id="cYearSaleAmtSum">0</td>
			                <td id="cPyearSaleAmtSum">0</td>
			                <td><fmt:formatNumber value="${dayPrevInfo.prevMonth3SaleAmt }" /></td>
			                <td><fmt:formatNumber value="${dayPrevInfo.prevMonth2SaleAmt }" /></td>
			                <td><fmt:formatNumber value="${dayPrevInfo.prevMonth1SaleAmt }" /></td>
			                <td colspan="4" width="429"><!-- &nbsp;* 참조사항 --></td>
			            </tr>
			            <tr>
			                <td>(성장율)</td>
			                <td id="cYearSaleAmtPer">0%</td>
			                <td></td>
			                <td id="cMonth3SaleAmtPer">0%</td>
			                <td id="cMonth2SaleAmtPer">0%</td>
			                <td id="cMonth1SaleAmtPer">0%</td>
			                <td colspan="4" width="429">　</td>
			            </tr>			            
			            <tr>
			                <td>회원가입 수(명)</td>
			                <td colspan="3"><fmt:formatNumber value="${dayMember.nowJoinCnt }" />명</td>
			                <td align="right"><fmt:formatNumber value="${dayMember.month3JoinCnt }" /></td>
			                <td align="right"><fmt:formatNumber value="${dayMember.month2JoinCnt }" /></td>
			                <td align="right"><fmt:formatNumber value="${dayMember.month1JoinCnt }" /></td>
			                <td>회원누적수</td>
			                <td><fmt:formatNumber value="${dayMember.userJoinCnt }" /></td>
			                <td colspan="2">(탈퇴회원 제외시 <fmt:formatNumber value="${dayMember.userJoinCnt - dayMember.allQutCnt }" />명)</td>
			            </tr>
			            <tr>
			                <td>방문자수</td>
			                <td colspan="3"><input type="text" name="visitorNum" value="${dayAnls.visitorNum }" class="numFormat" style="width: 100px; text-align: center;" /></td>
			                <td align="right"><fmt:formatNumber value="${visitorInfo.month3VisitorCnt }" /></td>
			                <td align="right"><fmt:formatNumber value="${visitorInfo.month2VisitorCnt }" /></td>
			                <td align="right"><fmt:formatNumber value="${visitorInfo.month1VisitorCnt }" /></td>
			                <td><fmt:formatDate value="${toDay }" pattern="yyyy" />년 방문수</td>
			                <td><fmt:formatNumber value="${visitorInfo.yearVisitorCnt }" /></td>
			                <td colspan="2">　</td>
			            </tr>
			            <!-- <tr>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			                <td>　</td>
			            </tr> -->
			            <tr>
			                <td colspan="2">* 당일 직접광고 지출액</td>
			                <td colspan="2"><fmt:formatNumber value="${adtmAmt }" /></td>
			                <td colspan="2">* ROAS (광고수익률=판매/광고비)</td>
			                <td align="right" id="roasPer">0 %</td>
			                <td colspan="2">* CVR (전환율)<br />
			                    (구매건수/방문자수)</td>
			                <td colspan="2" id="cvrPer">0 %</td>
			            </tr>
			        </tbody>
			    </table>
			    </form>
			    <div class="tb_form">
	                <b>일일매출 (당일매출, 전년동일매출) 데이터는 취소건 반영 기준에 따라 수치가 달라질 수 있음<br>
	                (전년동일매출 : 일일매출과의 비교를 위해 당일취소 건 반영, 당일 이후 취소건 미반영)</b>
	            </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>        