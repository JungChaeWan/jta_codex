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

<script type="text/javascript">
function fn_getMemCnt() {	
	$.ajax({
		type:"post", 
		url:"<c:url value='/oss/getMemCnt.ajax'/>",
		data:"sYear=" + $("#memYear").val() ,
		success:function(data){
			var trStr = "";
			var totalMemJoin = 0;
			var totalMemOut = 0;
			for (var i=0, end=data.memCnt.length; i<end; i++) {
				var mem = data.memCnt[i];
				trStr += "<tr>";
				trStr += "   <td class=\"center\">" + mem.dt + "</td>";
				trStr += "   <td class=\"right\">" + commaNum(mem.userJoin) + "</td>";
				trStr += "   <td class=\"right\">" + commaNum(mem.userOut) + "</td>";
				trStr += "</tr>";
				totalMemJoin += eval(mem.userJoin);
				totalMemOut += eval(mem.userOut);
			}
			
			$("#memCntId").html(trStr);
			$("#totalMemJoin").html(commaNum(totalMemJoin));
			$("#totalMemOut").html(commaNum(totalMemOut));
		},
		error : fn_AjaxError
	});
}

function fn_getSaveAnls() {	
	$.ajax({
		type:"post", 
		url:"<c:url value='/oss/getSaveAnls.ajax'/>",
		data:"sYear=" + $("#saveYear").val() + "&sMonth=" + $("#saveMonth").val() ,
		success:function(data){
			var trStr = "<tr>";
			trStr += "    <td class=\"center\">회원 유지율</td>";
			trStr += "    <td class=\"center\">" + (100 - data.userPer.qutPer) + "%</td>";
			trStr += "    <td>";
			trStr += "    	<div class=\"detail-count\"><p>회원 수</p><p><span>" + commaNum(data.userPer.totalCnt) + "</span> <small>명</small></p></div>";
			trStr += "    	<div class=\"detail-count\"><p>이탈 회원 수</p><p><span>" + commaNum(data.userPer.qutCnt) + "</span> <small>명</small></p></div>";
			trStr += "   </td>";
			trStr += "</tr>";
			trStr += "<tr>";
			trStr += "    <td class=\"center\">고객 전환율</td>";
			trStr += "    <td class=\"center\">" + data.userPer.rsvPer + "%</td>";
			trStr += "    <td>";
			trStr += "    	<div class=\"detail-count\"><p>회원 수</p><p><span>" + commaNum(data.userPer.totalCnt) + "</span> <small>명</small></p></div>";
			trStr += "   	<div class=\"detail-count\"><p>고객 수</p><p><span>" + commaNum(data.userPer.rsvCnt) + "</span> <small>명</small></p></div>";
			trStr += "    </td>";
			trStr += "</tr>";
			trStr += "<tr>";
			trStr += "    <td class=\"center\">복수 구매율</td>";
			trStr += "   <td class=\"center\">" + data.userPer.duplPer + "%</td>";
			trStr += "   <td>";
			trStr += "   	<div class=\"detail-count\"><p>고객 수</p><p><span>" + commaNum(data.userPer.rsvCnt) + "</span> <small>명</small></p></div>";
			trStr += "   	<div class=\"detail-count\"><p>복수구매 고객 수</p><p><span>" + commaNum(data.userPer.duplRsvCnt) + "</span> <small>명</small></p></div>";
			trStr += "   </td>";
			trStr += "</tr>";
			trStr += "<tr>";
			trStr += "    <td class=\"center\">재 구매자</td>";
			trStr += "   <td class=\"center\"><span>" + data.userPer.reRsvPer + "</span><small>%</small></td>";
			trStr += "   <td>";
			trStr += "   	<div class=\"detail-count\"><p>고객 수</p><p><span>" + commaNum(data.userPer.rsvCnt) + "</span> <small>명</small></p></div>";
			trStr += "  	<div class=\"detail-count\"><p>재구매 고객 수</p><p><span>" + commaNum(data.userPer.reRsvCnt) + "</span> <small>명</small></p></div>";
			trStr += "    </td>";
			trStr += "</tr>";			
			
			var totalMemJoin = 0;
			var totalMemOut = 0;
			if (data.userPer.rsvCnt != 0) {
				totalMemJoin = commaNum(Math.floor(data.saleAmtCnt.totalAmt / data.userPer.rsvCnt));
				totalMemOut = commaNum(Math.floor(data.saleAmtCnt.totalCnt / data.userPer.rsvCnt));
			}    	
			$("#saveMemId").html(trStr);
			$("#avgSaleAmt").html(totalMemJoin);
			$("#avgSaleCnt").html(totalMemOut);
		},
		error : fn_AjaxError
	});
}

//chart 관련
var lebels_bgcolors = ["#31c4b5", "#fa6a4f", "#e9ac21", "#4b5c6a", "#d79999", "#8784bd", "#82a670", "#9a8b0c", "#c368b5", "#672f48", "#006246", "#4a3e3e", "#543f26", "#afa85b", "#c03552", "#3dcffe", "#4d677d"];

var lebels_text = [<c:forEach items="${areaMemCusPer }" var="per">"${per.area}",</c:forEach>];
var area_mem_pers = [<c:forEach items="${areaMemCusPer }" var="per">${per.areaMemPer},</c:forEach>];
var area_cus_pers = [<c:forEach items="${areaMemCusPer }" var="per">${per.areaCusPer},</c:forEach>];

var mem_config = {
    type: 'pie',
    data: {
        datasets: [{
            data: area_mem_pers,
            backgroundColor: lebels_bgcolors,
        }],
        labels: lebels_text
    },
    options: {
        responsive: false,
        legend: {
        	display: false	
        }
    }
};

var cus_config = {
    type: 'pie',
    data: {
        datasets: [{
            data: area_cus_pers,
            backgroundColor: lebels_bgcolors,
        }],
        labels: lebels_text
    },
    options: {
        responsive: false,
        legend: {
        	display: false	
        }         
    }
};

window.onload = function() {	
    var mem = document.getElementById("chart-area_mem").getContext("2d");
    var cus = document.getElementById("chart-area_cus").getContext("2d");
    window.myPie = new Chart(mem, mem_config);
    window.myPie = new Chart(cus, cus_config);
};

$(function() {	
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
                <jsp:include page="/oss/left.do?menu=bis&sub=cusUse" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>        
        <div id="contents_area">
            <div id="contents">            	
            	<!-- change contents -->
            	<jsp:useBean id="now" class="java.util.Date" />
            	<h4 class="title08"><fmt:formatDate value="${now }" pattern="yyyy.MM.dd" />일 <fmt:formatDate value="${now }" pattern="E" />요일 <fmt:formatDate value="${now }" pattern="kk:mm" /> 기준 탐나오의 회원 현황 입니다.</h4>
            	
            	<div class="top-info">
            		<div class="inline">
            			<h5 class="title">회원</h5>
            			<div class="memo"><p>회원수</p><p class="count"><span><fmt:formatNumber value="${totalMap.totalMem }"/></span> <small>명</small></p></div>
            		</div>
            		<div class="inline">
            			<h5 class="title">고객</h5>
            			<div class="memo"><p>고객수</p><p class="count"><span><fmt:formatNumber value="${totalMap.totalCus }"/></span> <small>명</small></p></div>
            		</div>
            	</div>
            	
            	<div class="option-wrap">
            		<select name="sYear" id="memYear" title="년도 선택" onchange="fn_getMemCnt();">
            			<c:set var="searchLastYear"><fmt:formatDate value="${now }" pattern="yyyy" /></c:set>
            			<c:forEach var="year" begin="2015" end="${searchLastYear }">
            			<option value="${year }" <c:if test="${bisSVO.sYear eq year }">selected</c:if>>${year }</option>
            			</c:forEach>
            		</select>
            	</div>
                <table class="table01">
			        <colgroup>
			            <col>
			            <col style="width: 33%">
			            <col style="width: 33%">
			        </colgroup>
			        <thead>
			            <tr>
			                <th>년월</th>
			                <th>회원 가입 수</th>
			                <th>회원 탈퇴 수</th>
			            </tr>
			        </thead>
			        <tbody id="memCntId">
			        	<c:set var="totalMemJoin" value="0" />
			        	<c:set var="totalMemOut" value="0" />
			        	<c:forEach items="${memJoinOut }" var="mem">
			            <tr>
			            	<c:set var="totalMemJoin">${totalMemJoin + mem.userJoin }</c:set>
			            	<c:set var="totalMemOut">${totalMemOut + mem.userOut }</c:set>
			                <td class="center">${mem.dt }</td>
			                <td class="right"><fmt:formatNumber value="${mem.userJoin }"/></td>
			                <td class="right"><fmt:formatNumber value="${mem.userOut }"/></td>
			            </tr>
			            </c:forEach>
			        </tbody>
			        <tfoot>
			            <tr>
			                <td class="center">총계</td>
			                <td class="right" id="totalMemJoin"><fmt:formatNumber value="${totalMemJoin }"/></td>
			                <td class="right" id="totalMemOut"><fmt:formatNumber value="${totalMemOut }"/></td>
			            </tr>
		            </tfoot>
			    </table>
			    
			    <!-- 누적 통계 -->
			    <h4 class="title08">누적 고객 통계</h4>
			    <div class="option-wrap">
			    	<select name="sYear" id="saveYear" title="년도 선택" onchange="fn_getSaveAnls();">
            			<c:set var="searchLastYear"><fmt:formatDate value="${now }" pattern="yyyy" /></c:set>
            			<c:forEach var="year" begin="2015" end="${searchLastYear }">
            			<option value="${year }" <c:if test="${bisSVO.sYear eq year }">selected</c:if>>${year }</option>
            			</c:forEach>
            		</select>
            		<select name="sMonth" id="saveMonth" title="월 선택" onchange="fn_getSaveAnls();">
            			<c:forEach var="mon" begin="1" end="12">
            			  <c:set var="monStr"><fmt:formatNumber value="${mon }" minIntegerDigits="2" /></c:set>
            			<option value="${monStr }" <c:if test="${bisSVO.sMonth eq monStr }">selected</c:if>>${monStr }</option>
            			</c:forEach>
            		</select>            		
            	</div>
            	
            	<table class="table01">
			        <colgroup>
			            <col>
			            <col style="width: 33%">
			            <col style="width: 33%">
			        </colgroup>
			        <thead>
			            <tr>
			                <th>내용</th>
			                <th>퍼센트</th>
			                <th>상세내역</th>
			            </tr>
			        </thead>
			        <tbody id="saveMemId">
			            <tr>
			                <td class="center">회원 유지율</td>
			                <td class="center"><c:out value="${100 - userPer.qutPer}"/>%</td>
			                <td>
			                	<div class="detail-count"><p>회원 수</p><p><span><fmt:formatNumber value="${userPer.totalCnt}" /></span> <small>명</small></p></div>
			                	<div class="detail-count"><p>이탈 회원 수</p><p><span><fmt:formatNumber value="${userPer.qutCnt}" /></span> <small>명</small></p></div>
			                </td>
			            </tr>
			            <tr>
			                <td class="center">고객 전환율</td>
			                <td class="center"><c:out value="${userPer.rsvPer}"/>%</td>
			                <td>
			                	<div class="detail-count"><p>회원 수</p><p><span><fmt:formatNumber value="${userPer.totalCnt}" /></span> <small>명</small></p></div>
			                	<div class="detail-count"><p>고객 수</p><p><span><fmt:formatNumber value="${userPer.rsvCnt}" /></span> <small>명</small></p></div>
			                </td>
			            </tr>
			            <tr>
			                <td class="center">복수 구매율</td>
			                <td class="center"><c:out value="${userPer.duplPer}"/>%</td>
			                <td>
			                	<div class="detail-count"><p>고객 수</p><p><span><fmt:formatNumber value="${userPer.rsvCnt}" /></span> <small>명</small></p></div>
			                	<div class="detail-count"><p>복수구매 고객 수</p><p><span><fmt:formatNumber value="${userPer.duplRsvCnt}" /></span> <small>명</small></p></div>
			                </td>
			            </tr>
			            <tr>
			                <td class="center">재 구매자</td>
			                <td class="center"><span><c:out value="${userPer.reRsvPer}"/></span><small>%</small></td>
			                <td>
			                	<div class="detail-count"><p>고객 수</p><p><span><fmt:formatNumber value="${userPer.rsvCnt}" /></span> <small>명</small></p></div>
			                	<div class="detail-count"><p>재구매 고객 수</p><p><span><fmt:formatNumber value="${userPer.reRsvCnt}" /></span> <small>명</small></p></div>
			                </td>
			            </tr>
			        </tbody>
			    </table>
			    
			    <table class="table01" style="margin-top: 30px;">
			        <colgroup>
			            <col>
			            <col style="width: 50%">
			        </colgroup>
			        <thead>
			            <tr>
			                <th>개인 평균 매출 (구매단가)</th>
			                <th>개인별 구매 건수</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			            	<c:set var="avgSaleAmt" value="0"/>
			            	<c:set var="avgSaleCnt" value="0"/>
			            	<c:if test="${userPer.rsvCnt != 0 }">
			            		<c:set var="avgSaleAmt">${saleAmtCnt.totalAmt / userPer.rsvCnt }</c:set>
			            		<c:set var="avgSaleCnt">${saleAmtCnt.totalCnt / userPer.rsvCnt }</c:set>
			            	</c:if>
			                <td class="center"><span id="avgSaleAmt"><fmt:formatNumber value="${avgSaleAmt }" maxFractionDigits="0" /></span> <small>원</small></td>
			                <td class="center"><span id="avgSaleCnt"><fmt:formatNumber value="${avgSaleCnt }" maxFractionDigits="2" /></span> <small>건</small></td>
			            </tr>
			        </tbody>
			    </table>
			    
			    <!-- 거주지 비율 -->
			    <h4 class="title08">거주지 비율</h4>
			    <div class="chart-form">
			    	<div class="l-area">
			    		<h5 class="title">회원 거주지 비율</h5>
			    		<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-area_mem" width="350" height="350" style="margin: 0 auto;" /></div>
			    		</div>
			    		<ul class="chart-caption">
			    			<c:forEach items="${areaMemCusPer }" var="per" varStatus="num">
			    			<li class="area">
			    				<div class="bg"><span class="bg${num.count }"></span></div>
			    				<div class="text">${per.area }</div>
			    				<div class="percent"><span>${per.areaMemPer }%</span> <span>(<fmt:formatNumber value="${per.areaMemCnt }"/>명)</span></div>
			    			</li>
			    			</c:forEach>			    			
			    		</ul>			    		
			    	</div>
			    	<div class="r-area">
			    		<h5 class="title">고객 거주지 비율</h5>
			    		<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-area_cus" width="350" height="350" style="margin: 0 auto;" /></div>
			    		</div>
			    		<ul class="chart-caption">
			    			<c:forEach items="${areaMemCusPer }" var="per" varStatus="num">
			    			<li class="area">
			    				<div class="bg"><span class="bg${num.count }"></span></div>
			    				<div class="text">${per.area }</div>
			    				<div class="percent"><span>${per.areaCusPer }%</span> <span>(<fmt:formatNumber value="${per.areaCusCnt }"/>명)</span></div>
			    			</li>
			    			</c:forEach>			    			
			    		</ul>
			    	</div>
			    </div>
			    <!-- //change contents -->
			    
            </div>
        </div>
    </div>
    <!--//Contents 영역-->
</div>
</body>
</html>