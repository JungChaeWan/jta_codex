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

function fn_Search(category){	
	if (category != '') {	
		document.frm.sCategory.value = category;
	}
	document.frm.action = "<c:url value='/oss/bisAdj.do'/>";
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

function fn_adjDtl(corpId) {
	$('input[name=sCorpId]').val(corpId);
	document.frm.action = "<c:url value='/oss/bisAdjDtl.do'/>";
	document.frm.submit();
}

function fn_Paging(pageIndex){	
	// form reset	
	$('form').each(function() {
		this.reset();
	});
	
	document.frm.pageIndex.value = pageIndex;
	
	var parameters = $("#frm").serialize();
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:'<c:url value="/oss/getAdjList.ajax" />',
		data: parameters,
		success:function(data){
			$("#adjListId").html(data);
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});	
}


//chart 관련
var lebels_bgcolors = ["#31c4b5", "#fa6a4f", "#e9ac21", "#4b5c6a", "#d79999", "#8784bd", "#82a670", "#9a8b0c", "#c368b5", "#672f48", "#006246", "#4a3e3e", "#543f26", "#afa85b", "#c03552", "#3dcffe", "#4d677d"];
var pay_config = {
    type: 'pie',
    data: {
        datasets: [{
            data: [<c:forEach items="${payDivPer }" var="per">${per.rsvCntPer},</c:forEach>],
            backgroundColor: lebels_bgcolors,
        }],
        labels: ['신용카드', '휴대폰', '실시간 계좌이체', '카카오페이']
    },
    options: {
        responsive: false,
        legend: {
        	display: false	
        }
    }
};

var member_config = {
	    type: 'pie',
	    data: {
	        datasets: [{
	            data: [${rsvMemberPer.rsvCntPer }, ${rsvMemberPer.otherRsvPer }],
	            backgroundColor: lebels_bgcolors,
	        }],
	        labels: ['회원', '비회원']
	    },
	    options: {
	        responsive: false,
	        legend: {
	        	display: false	
	        }
	    }
	};

window.onload = function() {	
    var adjPay = document.getElementById("chart-pay").getContext("2d");
    var adjMember = document.getElementById("chart-member").getContext("2d");
    window.myPie = new Chart(adjPay, pay_config);
    window.myPie = new Chart(adjMember, member_config);
};

$(document).ready(function() {
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/bisAdjExcel.do?"+ parameters +"'/>";
	
}

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
                <jsp:include page="/oss/left.do?menu=bis&sub=adj" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            
            <!-- change contents -->
                <!-- 3Depth menu -->
                <div id="menu_depth3">
					<ul>
						<li<c:if test="${searchVO.sCategory eq 'ALL' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('ALL')">전체</a></li>
					  <c:forEach items="${corpCdList }" var="corp">
					  	<li<c:if test="${searchVO.sCategory eq corp.cdNum }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('${corp.cdNum }');">${corp.cdNm }</a></li>
					  </c:forEach>
						<%-- <li<c:if test="${searchVO.sCategory eq 'AD' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('AD')">숙박</a></li>
						<li<c:if test="${searchVO.sCategory eq 'RC' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('RC')">렌터카</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPC' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('SPC')">관광지/레저</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPF' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('SPF')">맛집</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPT' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('SPT')">여행사 상품</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SV' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Search('SV')">제주특산/기념품</a></li> --%>
					</ul>
				</div>
				
				<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="sCategory" value="${searchVO.sCategory }" />
				<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" name="sCorpId" value=""/>
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
			            <span class="btn"><input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('')" /></span>
			        </div>
			    </div>
			    </form>
			    
			    <div class="search-value2">
			    	<fmt:parseDate var="sStartDate" value="${searchVO.sStartDt }" pattern="yyyy-MM-dd" />
			    	<fmt:parseDate var="sEndDate" value="${searchVO.sEndDt }" pattern="yyyy-MM-dd" />
			    	
			    	<c:set var="searchType" value="상품" />
			    	<c:choose>
			    	  <c:when test="${searchVO.sCategory eq 'AD' }">
			    	    <c:set var="searchType" value="숙소" />
			    	  </c:when>
			    	  <c:when test="${searchVO.sCategory eq 'RC' }">
			    	    <c:set var="searchType" value="렌터카" />
			    	  </c:when>
			    	  <c:when test="${searchVO.sCategory eq 'SPC' }">
			    	    <c:set var="searchType" value="관광지" />
			    	  </c:when>
			    	  <c:when test="${searchVO.sCategory eq 'SPT' }">
			    	    <c:set var="searchType" value="패키지" />
			    	  </c:when>
			    	  <c:otherwise>
			    	  </c:otherwise>
			    	</c:choose>
			    	
			    	<c:set var="searchCorp" value="전체" />
			    	<c:if test="${not empty searchVO.sCorpNm }">
			    	  <c:set var="searchCorp" value="${searchVO.sCorpNm }" />
			    	</c:if>
			    	
			    	<h4 class="title08">‘${searchType } ${searchCorp }’의 통계 결과 <small>(<fmt:formatDate value="${sStartDate }" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${sEndDate }" pattern="yyyy.MM.dd" /> 의 검색 결과 입니다.)</small></h4>
			    	<table class="table01">
				        <colgroup>
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				            <col width="10%" />
				        </colgroup>
				        <tbody>
				            <tr>
				                <th>총 매출액</th>
				                <td class="right"><fmt:formatNumber value="${totalAdj.totalRsvAmt }" /> 원</td>
				                <th>총 할인금액</th>
				                <td class="right"><fmt:formatNumber value="${totalAdj.totalDisAmt }" /> 원</td>
				                <th>총 취소 수수료</th>
				                <td class="right"><fmt:formatNumber value="${totalAdj.totalCmssAmt }" /> 원</td>
				                <th>총 판매수수료액</th>
				                <td class="right"><fmt:formatNumber value="${totalAdj.totalSaleCmss }" /> 원</td>
				                <th>총 정산대상금액</th>
				                <td class="right"><fmt:formatNumber value="${totalAdj.totalAdjAmt }" /> 원</td>
				            </tr>
				        </tbody>
				    </table>
			    </div>
			    
			    <h4 class="title08">정산 통계</h4>
			    <div id="adjListId">
				    <table class="table01 right">
				        <colgroup>
				        	<col width="5%" />
				            <col />
				            <col width="14%" />
				            <col width="14%" />
				            <col width="14%" />
				            <col width="14%" />
				            <col width="14%" />
				        </colgroup>
				        <thead>
				            <tr>
				            	<th>번호</th>
				                <th>업체명</th>
				                <th>총 판매금액</th>
				                <th>할인금액</th>
				                <th>취소 수수료</th>
				                <th>판매 수수료</th>
				                <th>정산대상금액</th>
				            </tr>
				        </thead>
				        <tbody>
				        	<c:forEach items="${adjList }" var="adj" varStatus="status">
				            <tr>
				            	<td class="center"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
				                <td class="center" style="cursor:pointer;" onclick="fn_adjDtl('${adj.corpId}')"><b>${adj.corpNm }</b></td>			                
				                <td><fmt:formatNumber value="${adj.saleAmt }" /></td>			                
				                <td><fmt:formatNumber value="${adj.cmssAmt }" /></td>
				                <td><fmt:formatNumber value="${adj.disAmt }" /></td>
				                <td><fmt:formatNumber value="${adj.saleCmssAmt }" /></td>
				                <td><fmt:formatNumber value="${adj.adjAmt }" /></td>
				            </tr>
				            </c:forEach>			            
				            <c:if test="${fn:length(adjList) == 0 }">
				            <tr>
				                <td colspan="7">
				                	<div class="not-content">검색된 결과가 없습니다.</div>
				                </td>
				            </tr>
				            </c:if>
				        </tbody>
				    </table>				
				    <p class="list_pageing">
				        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Paging" />
				    </p>
				    <ul class="btn_rt01">
						<li class="btn_sty02">
							<a href="javascript:fn_SaveExcel()">엑셀저장</a>
						</li>
					</ul>
			    </div>
			    
			    <!-- 차트 -->
			    <h4 class="title08">차트별 통계</h4>
			    <div class="chart-form">
			        <div class="item">
			        	<h5 class="title">결제 방법</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-pay" width="350" height="350" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
			                <li class="area">
			                    <div class="bg"><span class="bg1"></span></div>
			                    <div class="text">신용카드</div>
			                    <div class="percent"><span>${payDivPer[0].rsvCntPer }%</span> <span>(<fmt:formatNumber value="${payDivPer[0].rsvCnt }" />건)</span></div>
			                </li>
			                <li class="area">
			                    <div class="bg"><span class="bg2"></span></div>
			                    <div class="text">휴대폰</div>
			                    <div class="percent"><span>${payDivPer[1].rsvCntPer }%</span> <span>(<fmt:formatNumber value="${payDivPer[1].rsvCnt }" />건)</span></div>
			                </li>
			                <li class="area">
			                    <div class="bg"><span class="bg3"></span></div>
			                    <div class="text">실시간 계좌이체</div>
			                    <div class="percent"><span>${payDivPer[2].rsvCntPer }%</span> <span>(<fmt:formatNumber value="${payDivPer[2].rsvCnt }" />건)</span></div>
			                </li>
			                <li class="area">
			                    <div class="bg"><span class="bg4"></span></div>
			                    <div class="text">카카오페이</div>
			                    <div class="percent"><span>${payDivPer[3].rsvCntPer }%</span> <span>(<fmt:formatNumber value="${payDivPer[3].rsvCnt }" />건)</span></div>
			                </li>
			            </ul>
			        </div>
			        <div class="item">
			        	<h5 class="title">회원/비회원 결제 비율</h5>
            			<div class="chart">
			    			<div class="pd-wrap"><canvas id="chart-member" width="350" height="350" style="margin: 0 auto;" /></div>
			    		</div>
            			<ul class="chart-caption">
			                <li class="area">
			                    <div class="bg"><span class="bg1"></span></div>
			                    <div class="text">회원</div>
			                    <div class="percent"><span>${rsvMemberPer.rsvCntPer }%</span> <span>(<fmt:formatNumber value="${rsvMemberPer.rsvCnt }" />건)</span></div>
			                </li>
			                <li class="area">
			                    <div class="bg"><span class="bg2"></span></div>
			                    <div class="text">비회원</div>
			                    <div class="percent"><span>${rsvMemberPer.otherRsvPer }%</span> <span>(<fmt:formatNumber value="${rsvMemberPer.otherRsvCnt }" />건)</span></div>
			                </li>
			            </ul>
			        </div>
			    </div>
                <!-- //change contents -->
                                           
            </div>
        </div>
    </div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>        