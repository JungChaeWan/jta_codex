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
	document.frm.action = "<c:url value='/oss/bisSaleYear.do'/>";
	document.frm.submit();
}

function fn_DtlAnls(dt){
	$("#sFromMonth").val(dt);
	document.frm.action = "<c:url value='/oss/bisSaleMonth.do'/>";
	document.frm.submit();
}

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
						<li class="on"><a class="menu_depth3" href="/oss/bisSaleYear.do">월간매출통계</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAll.do">전체 상품</a></li>
						<%-- <c:forEach items="${corpCdList }" var="corp">
					  	<li><a class="menu_depth3"href="/oss/bisSalePdf${corp.cdNum }.do">${corp.cdNm }</a></li>
					  </c:forEach> --%>
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
				
				<!-- 기존코드 그대로 -->
				<form name="frm" method="post">
			        <input type="hidden" id="sFromMonth" name="sFromMonth">
			        <div>
			            <select id="sFromYear" name="sFromYear" style="width:60px;" onchange="fn_Search();">
                    		<c:forEach begin="2016" end="${nowYear}" step="1" var="vYear">
                   			<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}</option>
                    		</c:forEach>
                    	</select>
			        </div>
			    </form>
				<div class="list margin-top5 margin-btm15">
			        <table class="chart-height">
			            <colgroup>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			                <col>
			            </colgroup>
			            <tbody>
			                <tr class="gride">
			                	<c:forEach var="anls" items="${anlsList}" varStatus="status">
			                	  <c:if test="${fn:substring(anls.dt, 0, 4) eq searchVO.sFromYear }">
			                    <td><p style="height: ${anls.totalAmtPer * 3}px" title="<fmt:formatNumber>${anls.totalAmt}</fmt:formatNumber>원"></p></td>
			                      </c:if>
			                    </c:forEach>			                    
			                </tr>
			                <tr class="foot">
			                	<c:forEach var="anls" items="${anlsList}" varStatus="status">
			                	  <c:if test="${fn:substring(anls.dt, 0, 4) eq searchVO.sFromYear }">
			                    <td>${anls.dt}</td>
			                      </c:if>
			                    </c:forEach>
			                </tr>
			            </tbody>
			        </table>	
			    </div>
			    
			    <!-- 클래스 변경 -->
			    <h4 class="title08">매출 현황</h4>			    
			    <div class="list">
			        <table class="table01 center">
			            <colgroup>
			                <col width="20%">
			                <col width="20%">
			                <col width="20%">
			                <col width="20%">
			                <col width="20%">
			            </colgroup>
			            <thead>
			                <tr>
			                    <th>년월</th>
			                    <th>매출</th>
			                    <th>취소금액</th>
			                    <th>합계</th>
			                    <th>매출성장률</th>
			                </tr>
			            </thead>
			            <tbody>
			            	<c:forEach var="anls" items="${anlsList}" varStatus="status">
			            	  <c:if test="${fn:substring(anls.dt, 0, 4) eq searchVO.sFromYear }">
			            	  	<c:set var="growthRate" value="0" />
			            	  	<c:if test="${prevMonthAmt eq 0 && anls.totalAmt != 0 }">
			            	  	  <c:set var="growthRate" value="100" />
			            	  	</c:if>
			            	  	<c:if test="${prevMonthAmt != 0 }">
			            	  	  <c:set var="growthRate">${(anls.totalAmt - prevMonthAmt) / prevMonthAmt * 100 }</c:set>	
			            	  	</c:if>
			                <tr>
			                    <td><a href="javascript:fn_DtlAnls('${fn:substring(anls.dt, 5, 7)}')" class="link"><c:out value="${anls.dt}"/></a></td>
			                    <td><fmt:formatNumber><c:out value="${anls.saleAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${anls.cancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${anls.totalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber value="${growthRate }" maxFractionDigits="1" />%</td>
			                </tr>
			                  </c:if>
			                  <c:set var="prevMonthAmt" value="${anls.totalAmt}" />
			                </c:forEach>			                
			            </tbody>
			        </table>
			    </div>
                <!-- //change contents -->                
            </div>
        </div>
    </div>
</div>
</body>
</html>        
        