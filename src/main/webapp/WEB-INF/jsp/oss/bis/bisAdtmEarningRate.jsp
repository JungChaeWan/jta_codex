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

function fn_ChangeYear(){
	var optHtml = "";
	var chkMonth = 13;
	  <c:if test="${searchVO.sCategory == 'MONTH' }">
	if($("#sYear").val() == "${nowYear}"){
		chkMonth = parseInt("${nowMonth}");
	}
	for(var i=1;i<chkMonth;i++){
		optHtml += "<option value=\"" + i + "\">" + i + "월</option>";
	}
	$("#sMonth").html(optHtml);
	  </c:if>
	fn_Search();
}

function fn_Search(){
	document.frm.action = "<c:url value='/oss/bisAdtmEarningRate.do'/>";
	document.frm.submit();
}

function fn_MonthDft(sMonth){
	document.frm.sCategory.value = "MONTH";
	document.frm.sMonth.value = sMonth;
	document.frm.action = "<c:url value='/oss/bisAdtmEarningRate.do'/>";
	document.frm.submit();
}

var adtm_config = {
	    type: 'line',
	    data: {
	        datasets: [	        	          
	        {
	        	label: "광고수익률",
	            fill: false,
	            lineTension: 0,
	            backgroundColor: "rgba(91,155,213,0.4)",
	            borderColor: "rgba(91,155,213,1)",
	            borderCapStyle: 'butt',
	            spanGaps: false,
	            data: [<c:forEach var="adtm" items="${adtmList }">${adtm.roasPer},</c:forEach>],
	            
	        }],
	        labels: [<c:forEach var="adtm" items="${adtmList }">'${adtm.rsvDt}',</c:forEach>]
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: true	
	        }         
	    }
	};
	
window.onload = function() {
    var adtm = document.getElementById("chart-adtm").getContext("2d");
    window.myPie = new Chart(adtm, adtm_config);
};

$(document).ready(function() {

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
                <jsp:include page="/oss/left.do?menu=bis&sub=adtm" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            
            <!-- change contents -->
            	<div class="chart-form2">
			        <h4 class="title">광고수익률 통계</h4>
			        <form name="frm" method="post">
			        <input type="hidden" name="sCategory" value="${sCategory }" />
			          <c:if test="${searchVO.sCategory == 'YEAR' }">
			        <input type="hidden" name="sMonth" value="" />
			          </c:if>
			        <ul class="btn_lt01">
						<li>
							<select id="sYear" name="sYear" class="option-wrap" style="width:60px; height: 26px;" onchange="fn_Search();" title="년도 선택">
		                    	<c:forEach begin="2016" end="${nowYear}" step="1" var="vYear">
		                   			<option value="${vYear}" <c:if test="${vYear eq searchVO.sYear}">selected="selected"</c:if>>${vYear}</option>
		                    	</c:forEach>
		                    </select>
		                      <c:if test="${searchVO.sCategory == 'MONTH' }">
		                    <select id="sMonth" name="sMonth" class="option-wrap" style="width:60px; height: 26px;" onchange="fn_MonthDft(this.value);" title="월 선택">
		                    	<c:forEach begin="1" end="12" step="1" var="vMonth">
		                    		<c:if test="${vMonth < 10}">
		                    			<c:set var="month_v" value="0${vMonth}" />
		                    		</c:if>
		                    		<c:if test="${vMonth >= 10}">
		                    			<c:set var="month_v" value="${vMonth}" />
		                    		</c:if>
		                   			<option value="${month_v}" <c:if test="${month_v == searchVO.sMonth}">selected="selected"</c:if>>${vMonth}월</option>
		                    	</c:forEach>
		                    </select>                    
                      </c:if>
						</li>
					
						<li class="btn_sty01">
							<a href="/oss/adtmAmtForm.do">광고비 입력</a>
						</li>
					</ul>			        
	            	</form>	            	
			        <div class="chart" style="height: 300px">
						<div class="pd-wrap"><canvas id="chart-adtm" width="1400" height="300" style="margin: 0 auto;" /></div>
					</div>
			    </div>
			    
			    <!-- 월별 현황 -->
			    <h4 class="title08"><c:if test="${searchVO.sCategory == 'YEAR' }">월별</c:if><c:if test="${searchVO.sCategory == 'MONTH' }">일별</c:if> 현황 <span class="side-wrap">(단위:원)</span></h4>
                <table class="table01">
			        <colgroup>
			            <col width="20%" />
			            <col width="20%" />
			            <col width="20%" />
			            <col width="20%" />
			            <col />
			        </colgroup>
			        <thead>
			            <tr>
			                <th>일자</th>
			                <th>판매</th>
			                <th>지출</th>
			                <th>광고수익률(ROAS)</th>
			                <th>구매전환비용(CPA)</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<c:forEach var="adtm" items="${adtmList }">
			            <tr>
			                <td class="center"><c:if test="${searchVO.sCategory == 'YEAR' }"><a href="javascript:fn_MonthDft('${fn:substring(adtm.rsvDt, 5, 7) }');" class="link"></c:if>${adtm.rsvDt }<c:if test="${searchVO.sCategory == 'YEAR' }"></a></c:if></td>
			                <td class="right"><fmt:formatNumber value="${adtm.totalRsvAmt }" /> </td>
			                <td class="right"><fmt:formatNumber value="${adtm.adtmAmt }" /></td>
			                <td class="right"><fmt:formatNumber value="${adtm.roasPer }" />%</td>
			                <td class="right"><fmt:formatNumber value="${adtm.cpaAmt }" /></td>
			            </tr>
			            </c:forEach>
			        </tbody>
			    </table>
			    <!-- //change contents -->
                                           
            </div>
        </div>
    </div>
</div>
</body>
</html>        