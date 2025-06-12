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

function fn_Search(){
	document.frm.action = "<c:url value='/oss/bisSalePdfAll.do'/>";
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
						<li class="on"><a class="menu_depth3" href="/oss/bisSalePdfAll.do">전체 상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAv.do">항공</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAd.do">숙박</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfRc.do">렌터카</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpc.do">관광지/레저</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpf.do">맛집</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpt.do">여행사 상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSv.do">제주특산/기념품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpb.do">카시트/유모차</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfCp.do">하이제주</a></li>
					</ul>
				</div>
				
				<form name="frm" method="post" onSubmit="return false;">
				<div class="search_box">
			        <div class="search_form">
			            <div class="tb_form">
			                <table width="100%" border="0">
			                    <colgroup>
			                        <col style="widht: 100px" />
			                        <col />
			                    </colgroup>
			                    <tbody>
			                    	<%-- <tr>
							            <th scope="row">기준</th>
							            <td>
							            	<label class="lb"><input type="radio" id="sGubun0" name="sGubun"<c:if test="${searchVO.sGubun eq 'RSV' }" >checked="checked"</c:if> value="RSV" /> <span>예약일</span></label>
			                                <label class="lb"><input type="radio" id="sGubun1" name="sGubun"<c:if test="${searchVO.sGubun eq 'USE' }" >checked="checked"</c:if> value="USE" /> <span>사용일</span></label>
							            </td>
							        </tr> --%>
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
			                    </tbody>
			                </table>
			            </div>
			            <span class="btn"><input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search()" /></span>
			        </div>
			    </div>
			    </form>
			    
			    <div class="search-value2">
			    	<fmt:parseDate var="sStartDate" value="${searchVO.sStartDt }" pattern="yyyy-MM-dd" />
			    	<fmt:parseDate var="sEndDate" value="${searchVO.sEndDt }" pattern="yyyy-MM-dd" />
			    	<h4 class="title08">‘상품 전체’의 통계 결과 <small>(<fmt:formatDate value="${sStartDate }" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${sEndDate }" pattern="yyyy.MM.dd" /> 의 검색 결과 입니다.)</small></h4>
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
			    <h4 class="title08"><c:if test="${searchVO.sGubun eq 'RSV' }" >예약</c:if><c:if test="${searchVO.sGubun eq 'USE' }" >사용</c:if> 시간 통계<c:if test="${searchVO.sGubun eq 'USE' }" ><small> (숙박 정보 제외)</small></c:if></h4>
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
			                <th>예약 건수 </th>
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
                <!-- //change contents -->
                                           
            </div>
        </div>
    </div>
</div>
</body>
</html>        