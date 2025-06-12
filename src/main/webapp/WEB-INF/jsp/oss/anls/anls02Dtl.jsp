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

<title></title>
<script type="text/javascript">

function fn_ChangeYear(){
	var optHtml = "";
	var chkMonth = 13;
	if($("#sFromYear").val() == "${nowYear}"){
		chkMonth = parseInt("${nowMonth}");
	}
	for(var i=1;i<chkMonth;i++){
		optHtml += "<option value=\"" + i + "\">" + i + "월</option>";
	}
	$("#sFromMonth").html(optHtml);
	fn_Search();
}

function fn_ExcelDown(){
	var parameters = "sFromYear=" + $("#sFromYear").val();
	parameters += "&sFromMonth=" + $("#sFromMonth").val();
	
	frmFileDown.location = "<c:url value='/oss/anlsDtlExcelDown1.do?"+ parameters +"'/>";
}

function fn_Search(){
	document.frm.action = "<c:url value='/oss/anls02Dtl.do'/>";
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
		<jsp:include page="/oss/left.do?menu=anls&sub=anls02" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<div class="btn_rt01">
					<div class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></div>
				</div>
				<div id="menu_depth3">
					<ul>
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/oss/anls02.do'/>">매출통계</a></li>
						<li><a class="menu_depth3"
							href="<c:url value='/oss/anls03.do'/>">일별현황</a></li>
					</ul>
				</div>
				<form name="frm" method="post">
					<input type="hidden" id="sToDt" name="sToDt" />
                <div>
                    <select id="sFromYear" name="sFromYear" style="width:60px;" onchange="fn_Search();">
                    	<c:forEach begin="2015" end="${nowYear}" step="1" var="vYear">
                   			<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}</option>
                    	</c:forEach>
                    </select>
                    <select id="sFromMonth" name="sFromMonth" style="width:60px;" onchange="fn_Search();">
                    	<c:forEach begin="1" end="12" step="1" var="vMonth">
                   			<option value="${vMonth}" <c:if test="${vMonth eq searchVO.sFromMonth}">selected="selected"</c:if>>${vMonth}월</option>
                    	</c:forEach>
                    </select>
                </div>
                </form>
                <div class="list margin-top5 margin-btm15">
				<table class="table01">
					<colgroup>
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th>일자</th>
							<th>총 예약건수</th>
							<th>총 판매금액</th>
							<th>취소건수</th>
							<th>총 취소수수료</th>
							<th>실매출액<br />
								(취소수수료포함)
                            </th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList}" var="anls" varStatus="status">
							<tr>
								<td class="align_ct">${anls.dt}</td>
								<td class="align_ct"><fmt:formatNumber>${anls.rsvCnt}</fmt:formatNumber></td>
								<td class="align_rt"><fmt:formatNumber>${anls.nmlAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${anls.cancelCnt}</fmt:formatNumber></td>
								<td class="align_rt"><fmt:formatNumber>${anls.cmssAmt}</fmt:formatNumber>원</td>
								<td class="align_rt">
									<%-- <table class="chart">
										<tr>
											<td class="grid"><p style="width: 45%"></p></td>
											<td class="text align_rt">
												<fmt:formatNumber><c:out value="${anls.cmssAmt + anls.nmlAmt}" /></fmt:formatNumber>
											</td>
										</tr>
									</table> --%>
								<fmt:formatNumber>${anls.cmssAmt + anls.nmlAmt}</fmt:formatNumber>원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
				</div>
                
                <%-- <div>
                    <select id="" name="" style="width:60px;">
                        <option value="">2015</option>
                    </select>
                    
                    <select id="" name="" style="width:60px;">
                        <option value="">1월</option>
                    </select>
                </div>
                <div class="list margin-top5">
				<table class="table01 list_tb">
					<colgroup>
						<col width="*" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
					</colgroup>
					<thead>
						<tr>
							<th>일</th>
							<th>총 예약건수</th>
							<th>총 판매금액</th>
							<th>취소건수</th>
                            <th>총 환불금액</th>
							<th>총 취소수수료</th>
							<th>실매출액<br />
								(취소수수료포함)
                            </th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td class="align_ct">1일</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
							</tr>
                            <tr>
								<td class="align_ct">2일</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
							</tr>
                            <tr>
								<td class="align_ct">3일</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
							</tr>
					</tbody>
				</table>	
				</div> --%>
			</div>
		</div>
	</div>
</div>
</body>
</html>