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
<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<script type="text/javascript">

function fn_Search(corpNm){	
	if (corpNm != undefined) {
		document.frm.sCorpNm.value = corpNm;
	}	
	document.frm.action = "<c:url value='/oss/bisSalePdfAd.do'/>";
	document.frm.submit();
}

function fn_changeDate(term) {
	var searchDate = new Date();

	$('#sEndDt').val(searchDate.getFullYear() + "-" + ("0" + (searchDate.getMonth() + 1)).slice(-2) + "-" + ("0" + searchDate.getDate()).slice(-2));	
	
	if (term == 0 || term >= 7)
		searchDate.setDate(searchDate.getDate() - term);
	else
		searchDate.setMonth(searchDate.getMonth() - term);
	
	$('#sStartDt').val(searchDate.getFullYear() + "-" + ("0" + (searchDate.getMonth() + 1)).slice(-2) + "-" + ("0" + searchDate.getDate()).slice(-2));	
}

function fn_SearchCorpNm(pageIndex){	
	// form reset	
	$('form').each(function() {
		this.reset();
	});
	
	if ($("input[name=sCorpNm]").val() == '')
		return false;
	
	document.frm.pageIndex.value = pageIndex;
	
	var parameters = $("#frm").serialize();
	$.ajax({
		type:"post", 
		url:'<c:url value="/oss/getSearchCorpTool.ajax" />',
		data: parameters,
		success:function(data){
			$("#searchCorpTool").html(data);
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});	
}

//chart 관련
var lebels_bgcolors = ["#31c4b5", "#fa6a4f", "#e9ac21", "#4b5c6a", "#d79999", "#8784bd", "#82a670", "#9a8b0c", "#c368b5", "#672f48", "#006246", "#4a3e3e", "#543f26", "#afa85b", "#c03552", "#3dcffe", "#4d677d"];
var type_config = {
    type: 'pie',
    data: {
        datasets: [{
            data: [<c:forEach items="${adTypePer }" var="per">${per.rsvCntPer},</c:forEach>],
            backgroundColor: lebels_bgcolors,
        }],
        labels: [<c:forEach items="${adTypePer }" var="per">"${per.prdtNm}",</c:forEach>]
    },
    options: {
        responsive: false,
        legend: {
        	display: false	
        }
    }
};

var period_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [<c:forEach items="${adPeriodPer }" var="per">${per.rsvCntPer},</c:forEach>],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: [<c:forEach items="${adPeriodPer }" var="per">
			        <c:set var="titelStr">${per.prdtNm }박 ${per.prdtNm + 1 }일</c:set>
			      	  <c:if test="${per.prdtNm eq '0' }">
			      	    <c:set var="titelStr">당일</c:set>
			      	  </c:if>
		  			"${titelStr}",
		  	</c:forEach>]
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};

var price_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [<c:forEach items="${adPricePer }" var="per">${per.rsvCntPer},</c:forEach>],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: [<c:forEach items="${adPricePer }" var="per">"${per.prdtNm}",</c:forEach>]
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};
	
var area_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [<c:forEach items="${adAreaPer }" var="per">${per.rsvCntPer},</c:forEach>],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: [<c:forEach items="${adAreaPer }" var="per">"${per.prdtNm}",</c:forEach>]
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};
	
var cur_rsv_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [${adCurRsvPer.otherRsvPer }, ${adCurRsvPer.rsvCntPer }],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: ['사전예약', ' 당일']
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};

var cancel_rsv_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [<c:forEach items="${adCancelRsvPer }" var="per">${per.rsvCntPer},</c:forEach>],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: [<c:forEach items="${adCancelRsvPer }" var="per">"${per.prdtNm}",</c:forEach>]
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};

var cancel_use_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [<c:forEach items="${adCancelUsePer }" var="per">${per.rsvCntPer},</c:forEach>],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: [<c:forEach items="${adCancelUsePer }" var="per">"${per.prdtNm}",</c:forEach>]
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};


window.onload = function() {	
    var adType = document.getElementById("chart-type").getContext("2d");
    var adPeriod = document.getElementById("chart-period").getContext("2d");
    var adPrice = document.getElementById("chart-price").getContext("2d");
    var adArea = document.getElementById("chart-area").getContext("2d");
    var adCurRsv = document.getElementById("chart-cur_rsv").getContext("2d");
    var adCancelRsv = document.getElementById("chart-cancel_rsv").getContext("2d");
    var adCancelUse = document.getElementById("chart-cancel_use").getContext("2d");
    window.myPie = new Chart(adType, type_config);
    window.myPie = new Chart(adPeriod, period_config);
    window.myPie = new Chart(adPrice, price_config);
    window.myPie = new Chart(adArea, area_config);
    window.myPie = new Chart(adCurRsv, cur_rsv_config);
    window.myPie = new Chart(adCancelRsv, cancel_rsv_config);
    window.myPie = new Chart(adCancelUse, cancel_use_config);
    
    // 업체명 검색 리스트
    fn_SearchCorpNm(1);
};

$(document).ready(function() {
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
	<jsp:include page="/oss/head.do?menu=bis" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
        <div id="side_area"> 
            <!--사이드메뉴-->
            <div class="side_menu">
                <jsp:include page="/oss/left.do?menu=bis&sub=sale" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            
            <!-- change contents -->
                <!-- 3Depth menu -->
                <div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3" href="/oss/bisSaleYear.do">월간매출통계</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAll.do">전체 상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAv.do">항공</a></li>
						<li class="on"><a class="menu_depth3" href="/oss/bisSalePdfAd.do">숙소</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfRc.do">렌터카</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpc.do">관광지/레저</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpf.do">맛집</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpt.do">여행사 상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSv.do">제주특산/기념품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpb.do">카시트/유모차</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfCp.do">하이제주</a></li>
					</ul>
				</div>
				
				<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="sCategory" value="AD" />
				<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
				<div class="search_box">
			        <div class="search_form">
			            <div class="tb_form">
			                <table width="100%" border="0">
			                    <colgroup>
			                        <col style="widht: 100px" />
			                        <col />
			                    </colgroup>
			                    <tbody>
			                    	<tr>
							            <th scope="row">유형</th>
							            <td>
							            	<label class="lb"><input type="radio" id="sType0" name="sType"<c:if test="${empty searchVO.sType }" >checked="checked"</c:if> value="" /> <span>전체</span></label>
			                                <c:forEach var="data" items="${categoryList}" varStatus="status">
                                            	<label class="lb"><input id="sType${status.index+1}" type="radio" name="sType" value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">checked="checked"</c:if>><label for="sType${status.index+1}">${data.cdNm }</label></label>
                                            </c:forEach>
							            </td>
							        </tr>
			                        <tr>
			                            <th scope="row">기간</th>
			                            <td class="date-wrap">
			                            	<button type="button" onclick="fn_changeDate('0');">오늘</button>
			                            	<button type="button" onclick="fn_changeDate('7');">7일</button>
			                            	<button type="button" onclick="fn_changeDate('15');">15일</button>
			                            	<button type="button" onclick="fn_changeDate('1');">1개월</button>
			                            	<button type="button" onclick="fn_changeDate('3');">3개월</button>
			                            	<button type="button" onclick="fn_changeDate('6');">6개월</button>
			                            	
			                                <input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt }" title="검색시작일" /> ~ 
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt" value="${searchVO.sEndDt }"  title="검색종료일" />
			                            </td>
			                        </tr>
			                        <tr>
							            <th scope="row">업체명</th>
							            <td>
							                <input type="text" name="sCorpNm" placeholder="업체명을 입력해주세요." style="width: 245px" value="${searchVO.sCorpNm }">
							            </td>
							        </tr>
			                    </tbody>
			                </table>
			            </div>
			            <span class="btn"><input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search()" /></span>
			        </div>
			    </div>
			    </form>
			    
			    <div id="searchCorpTool"></div>
			    
			    <div class="search-value2">
			    	<fmt:parseDate var="sStartDate" value="${searchVO.sStartDt }" pattern="yyyy-MM-dd" />
			    	<fmt:parseDate var="sEndDate" value="${searchVO.sEndDt }" pattern="yyyy-MM-dd" />
			    	
			    	<c:set var="searchType" value="숙소" />
			    	<c:forEach var="data" items="${categoryList}">
			    	  <c:if test="${data.cdNum eq searchVO.sType }">
			    	    <c:set var="searchType" value="${data.cdNm }" />
			    	  </c:if>
			    	</c:forEach>
			    	
			    	<c:set var="searchCorp" value="전체" />
			    	<c:if test="${not empty searchVO.sCorpNm }">
			    	  <c:set var="searchCorp" value="${searchVO.sCorpNm }" />
			    	</c:if>
			    	
			    	<h4 class="title08">‘${searchType } ${searchCorp }’의 통계 결과 <small>(<fmt:formatDate value="${sStartDate }" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${sEndDate }" pattern="yyyy.MM.dd" /> 의 검색 결과 입니다.)</small></h4>
			    	<table class="table01">
				        <colgroup>
				            <col width="16%" />
				            <col width="17%" />
				            <col width="16%" />
				            <col width="17%" />
				            <col width="17%" />
				            <col width="17%" />
				        </colgroup>
				        <tbody>
				            <tr>
				                <th>총 매출액</th>
				                <td class="right"><fmt:formatNumber value="${prdtRsvCancelAmt.totalRsvAmt }" /> 원</td>
				                <th>총 취소금액</th>
				                <td class="right"><fmt:formatNumber value="${prdtRsvCancelAmt.totalCancelAmt }" /> 원</td>
				                <th>합계</th>
				                <td class="right"><fmt:formatNumber value="${prdtRsvCancelAmt.totalRsvAmt - prdtRsvCancelAmt.totalCancelAmt }" /> 원</td>
				            </tr>
				        </tbody>
				    </table>
			    </div>
			    
			    <h4 class="title08">예약 시간 통계</h4>
			    <table class="table01 center">
			        <colgroup>
			            <col />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			        </colgroup>
			        <thead>
			            <tr>
			                <th></th>
			                <th>일</th>
			                <th>월</th>
			                <th>화</th>
			                <th>수</th>
			                <th>목</th>
			                <th>금</th>
			                <th>토</th>
			                <th>총계</th>
			            </tr>
			        </thead>
			        <tbody>
			        	  <c:set var="totalRsvCnt" value="0" />
			        	<c:forEach var="info" items="${prdtRsvTimeCnt }">
			        	  <c:if test="${info.key != 'totalWeek' }">
			            <tr>
			                <th>${info.key }</th>
			                  <c:set var="totalCateCnt" value="0" />
			                  <c:forEach var="week" items="${info.value }">
			                    <c:set var="totalRsvCnt" value="${totalRsvCnt + week.value }" />
			                    <c:set var="totalCateCnt" value="${totalCateCnt + week.value }" />
			                    <td><fmt:formatNumber value="${week.value }" /></td>
			                  </c:forEach>
			                <td><fmt:formatNumber value="${totalCateCnt }" /></td>
			            </tr>
			              </c:if>
			            </c:forEach>
			        </tbody>
			        <tfoot>
			        	<tr>
			                <th>예약 건수</th>
			                <c:forEach var="total" items="${prdtRsvTimeCnt['totalWeek'] }" >
			                <td><fmt:formatNumber value="${total.value }" /></td>
			                </c:forEach>
			                <th class="total">
			                	<p class="text">총 예약건수</p>
			                	<p class="count"><fmt:formatNumber value="${totalRsvCnt }" /></p>
			                </th>
			            </tr>
			        </tfoot>
			    </table>
			    
			    <h4 class="title06" style="margin-top: 20px;">기간 내 예약된 예약 건수에 대한 취소건수를 실시간으로 반영한 것으로, 수치는 지속 변경될 수 있음 (매출통계의 취소 기준과 다름)</h4>
			    <table class="table01 center tMargin">
			        <colgroup>
			            <col />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			        </colgroup>
			        <tbody>
			        	<tr>
			                <th rowspan="2">예약 취소 건수</th>
			                <th>일</th>
			                <th>월</th>
			                <th>화</th>
			                <th>수</th>
			                <th>목</th>
			                <th>금</th>
			                <th>토</th>			                
			                <c:set var="totalCancelCnt" value="0" />
			                <c:forEach var="cancel" items="${prdtCancelCnt }">
			                  <c:set var="totalCancelCnt" value="${totalCancelCnt + cancel.cancelCnt }" />
			                </c:forEach>
			                <th rowspan="2" class="total">
			                	<p class="text">총 예약취소 건수</p>
			                	<p class="count"><fmt:formatNumber value="${totalCancelCnt }" /></p>
			                </th>
			            </tr>
			            <tr>
			            	<c:forEach var="cancel" items="${prdtCancelCnt }">
			                <td><fmt:formatNumber value="${cancel.cancelCnt }" /></td>
			                </c:forEach>
			            </tr>
			        </tbody>
			    </table>
			    
			    <table class="table01 center tMargin">
			        <colgroup>
			            <col />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			        </colgroup>
			        <thead>
			        	<tr>
			                <th></th>
			                <th>일</th>
			                <th>월</th>
			                <th>화</th>
			                <th>수</th>
			                <th>목</th>
			                <th>금</th>
			                <th>토</th>			                
			                <th>총계</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			            	<td>입실 건수</td>
			            	  <c:set var="totalWeekCnt" value="0" />
			            	<c:forEach var="info" items="${adCheckInCnt }">
			            	  <c:set var="totalWeekCnt" value="${totalWeekCnt + info.rsvCnt }" />
			                <td><fmt:formatNumber value="${info.rsvCnt }" /></td>
			                </c:forEach>
			                <td><fmt:formatNumber value="${totalWeekCnt }" /></td>
			            </tr>
			            <tr>
			            	<td>퇴실 건수</td>
			            	  <c:set var="totalWeekCnt" value="0" />
			            	<c:forEach var="info" items="${adCheckOutCnt }">
			            	  <c:set var="totalWeekCnt" value="${totalWeekCnt + info.rsvCnt }" />
			                <td><fmt:formatNumber value="${info.rsvCnt }" /></td>
			                </c:forEach>			                
			                <td><fmt:formatNumber value="${totalWeekCnt }" /></td>
			            </tr>
			        </tbody>
			    </table>
			    
			    <!-- 차트 -->
			    <h4 class="title08">차트별 통계</h4>
			    <div class="chart-form">
			        <div class="item">
			        	<h5 class="title">숙소 유형</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-type" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
            				<c:forEach var="info" items="${adTypePer }" varStatus="state">
			                <li class="area">
			                    <div class="bg"><span class="bg${state.count }"></span></div>
			                    <div class="text">${info.prdtNm }</div>
			                    <div class="percent"><span>${info.rsvCntPer } %</span> <span>(${info.rsvCnt }건)</span></div>
			                </li>
			                </c:forEach>
			            </ul>
			        </div>
			        <div class="item">
			        	<h5 class="title">숙박 기간</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-period" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
            				<c:forEach var="info" items="${adPeriodPer }" varStatus="state">
			                <li class="area">
			                	  <c:set var="titelStr">${info.prdtNm }박 ${info.prdtNm + 1 }일</c:set>
			                	  <c:if test="${info.prdtNm eq '0' }">
			                	    <c:set var="titelStr">당일</c:set>
			                	  </c:if>
			                    <div class="bg"><span class="bg${state.count }"></span></div>
			                    <div class="text">${titelStr }<c:if test="${info.prdtNm eq '5' }"> 이상</c:if></div>
			                    <div class="percent"><span>${info.rsvCntPer } %</span> <span>(${info.rsvCnt }건)</span></div>
			                </li>
			                </c:forEach>
			            </ul>
			        </div>
			        <div class="item">
			        	<h5 class="title">숙박 가격</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-price" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
            				<c:forEach var="info" items="${adPricePer }" varStatus="state">
			                <li class="area">
			                    <div class="bg"><span class="bg${state.count }"></span></div>
			                    <div class="text">${info.prdtNm }</div>
			                    <div class="percent"><span>${info.rsvCntPer } %</span> <span>(${info.rsvCnt }건)</span></div>
			                </li>
			                </c:forEach>			                
			            </ul>
			        </div>
			        <div class="item">
			        	<h5 class="title">숙박 지역<small> (단품 미포함)</small></h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-area" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
            				<c:forEach var="info" items="${adAreaPer }" varStatus="state">
			                <li class="area">
			                    <div class="bg"><span class="bg${state.count }"></span></div>
			                    <div class="text">${info.prdtNm }</div>
			                    <div class="percent"><span>${info.rsvCntPer } %</span> <span>(${info.rsvCnt }건)</span></div>
			                </li>
			                </c:forEach>
			            </ul>
			        </div>
			        <div class="item">
			        	<h5 class="title">당일 예약 비율</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-cur_rsv" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
			                <li class="area">
			                    <div class="bg"><span class="bg1"></span></div>
			                    <div class="text">사전예약</div>
			                    <div class="percent"><span>${adCurRsvPer.otherRsvPer } %</span> <span>(${adCurRsvPer.otherRsvCnt }건)</span></div>
			                </li>
			                <li class="area">
			                    <div class="bg"><span class="bg2"></span></div>
			                    <div class="text">당일</div>
			                    <div class="percent"><span>${adCurRsvPer.rsvCntPer } %</span> <span>(${adCurRsvPer.rsvCnt }건)</span></div>
			                </li>
			            </ul>
			        </div>
			        <div class="item">
			        	<h5 class="title">예약취소 주기 (예약일 기준)</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-cancel_rsv" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
            				<c:forEach var="info" items="${adCancelRsvPer }" varStatus="state">
			                <li class="area">
			                    <div class="bg"><span class="bg${state.count }"></span></div>
			                    <div class="text">${info.prdtNm }</div>
			                    <div class="percent"><span>${info.rsvCntPer } %</span> <span>(${info.rsvCnt }건)</span></div>
			                </li>
			                </c:forEach>
			            </ul>
			        </div>
			        <div class="item">
				        <h5 class="title">예약취소 주기 (사용일 기준)</h5>
				        <div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-cancel_use" width="250" height="200" style="margin: 0 auto;" /></div>
			    		</div>
				        <ul class="chart-caption">
				        	<c:forEach var="info" items="${adCancelUsePer }" varStatus="state">
				            <li class="area">
				                <div class="bg"><span class="bg${state.count }"></span></div>
				                <div class="text">${info.prdtNm }</div>
				                <div class="percent"><span>${info.rsvCntPer } %</span> <span>(${info.rsvCnt }건)</span></div>
				            </li>
				            </c:forEach>
				        </ul>
				    </div>
			    </div>
                <!-- //change contents -->
                                           
            </div>
        </div>
    </div>
</div>
</body>
</html>        