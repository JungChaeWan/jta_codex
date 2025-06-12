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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<style>
	/* 세로형 차트 */		
	.chart-height {width: 100%; border-spacing: 0px; border-collapse: collapse;}
	.chart-height tr td {text-align: center; border: 1px solid #ccc;}
	.chart-height tr.gride {height: 300px;}
	.chart-height tr.gride td {position: relative; padding: 0;}
	.chart-height tr.gride td > p {position: absolute; bottom: 0; left: 0; right: 0; width: 15px; margin: auto; background: #f7a35c;}		
	.chart-height tr.foot td {font-weight: bold; font-size: 14px; padding: 5px 0;}
</style>

<title></title>
<script type="text/javascript">

function fn_Search(){
	document.frm.action = "<c:url value='/oss/anls06.do'/>";
	document.frm.submit();
}

function fn_DtlAnls(dt){
	$("#sFromMonth").val(dt);
	document.frm.action = "<c:url value='/oss/anls04.do'/>";
	document.frm.submit();
}

$(document).ready(function() {

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=anls" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=anls&sub=anls06" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<!-- <div class="btn_rt01">
					<div class="btn_sty04">
						<a href="javascript:fn_ExcelDown();">엑셀다운로드</a>
					</div>
				</div> -->
				<div id="menu_depth3">
					<ul>
						<li class="on"><a class="menu_depth3" href="<c:url value='/oss/anls06.do'/>">매출통계</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/anls05.do'/>">고객통계</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/anls03.do'/>">일별현황</a></li>
					</ul>
				</div>
				<form name="frm" method="post">
					<input type="hidden" id="sFromMonth" name="sFromMonth" />
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
								<td><p style="height: ${anls.totalAmtPer * 3}px" title="<fmt:formatNumber>${anls.totalAmt}</fmt:formatNumber>원"></p></td>
							</c:forEach>
						</tr>
						<tr class="foot">
							<c:forEach var="anls" items="${anlsList}" varStatus="status">
								<td>${anls.dt}</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>	
				</div>
				<h4 class="title03">매출 현황</h4>
                <div class="list margin-top5 margin-btm15">
                	<table class="table01">
						<colgroup>
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<thead>
							<tr>
								<th>년월</th>
								<th>매출</th>
								<th>취소금액</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="anls" items="${anlsList}" varStatus="status">
								<tr>
									<td class="align_ct">
										<a href="javascript:fn_DtlAnls('${fn:substring(anls.dt, 5, 7)}')" style="text-decoration:underline;color:#4897dc;font-weight: bold;"><c:out value="${anls.dt}"/></a>
									</td>
									<td class="align_ct"><fmt:formatNumber><c:out value="${anls.saleAmt}"/></fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber><c:out value="${anls.cancelAmt}"/></fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber><c:out value="${anls.totalAmt}"/></fmt:formatNumber></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
                </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>