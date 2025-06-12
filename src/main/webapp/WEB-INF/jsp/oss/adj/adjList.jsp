<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">

function fn_GetAdjust(){
	var parameters = "";

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/getAdjust.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.success == "N"){
				alert(data.rtnMsg);
			}else{
				alert("정산건이 추출됐습니다.");
				document.frm.action = "<c:url value='/oss/adjList.do'/>";
				document.frm.submit();
			}
		},
		error:fn_AjaxError
	});
}

function fn_Search(){
	document.frm.action = "<c:url value='/oss/adjList.do'/>";
	document.frm.submit();
}


function fn_Search2() {
	var parameters = "sFromYear=" + $("#sYear").val() + "&sFromMonth=" + $("#sMonth").val();

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/getAdjListYM.ajax' />",
		data:parameters,
		success:function(data){
			var addHtml = "";

			if(data.list.length == 0) {
				addHtml += "<tr>";
				addHtml += "<td colspan=\"8\" class=\"align_ct\"><spring:message code='common.nodata.msg' /></td>";
				addHtml += "</tr>";
			}

			$.each(data.list, function(){
				addHtml += "<tr>";
				var adjItdDt = this.adjItdDt;
				addHtml += "<td class=\"align_ct\"><b>" + adjItdDt.substring(0, 4) + "-" + adjItdDt.substring(4, 6) + "</b></td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.saleAmt) + "원</td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.cmssAmt) + "원</td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.saleCmss) + "원</td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.supportDisAmt) + "원</td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.unsupportedDisAmt) + "원</td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.supportedPointAmt) + "원</td>";
				addHtml += "<td class=\"align_rt\">" + commaNum(this.unsupportedPointAmt) + "원</td>";
				addHtml += "<td class=\"align_rt font_red\"><b>" + commaNum(this.adjAmt) + "원</b></td>";
				addHtml += "</tr>";
			});

			$("#adjList").html(addHtml);
		},
		error:fn_AjaxError
	});
}

function fn_DtlAdjList(adjDt){
	$("#sAdjDt").val(adjDt);

	document.frm.action = "<c:url value='/oss/dtlAdjList.do'/>";
	document.frm.submit();
}

function fn_ExcelDown(){
	var parameters = "sFromYear=" + $("#sYear").val() + "&sFromMonth=" + $("#sMonth").val();
	frmFileDown.location = "<c:url value='/oss/adjustExcelDown1.do' />?" + parameters;
}

function fn_ExcelTamnacardDown(){
	var parameters = "sStartDt=" + $("#sTradeStartDt").val() + "&sEndDt=" + $("#sTradeEndDt").val();
	frmFileDown.location = "<c:url value='/oss/adjustExcelDown5.do' />?" + parameters;
}

function fn_ExcelPointDown(){
	var parameters = "sFromYear=" + $("#sYear").val() + "&sFromMonth=" + $("#sMonth").val();
	frmFileDown.location = "<c:url value='/oss/adjustExcelDown6.do' />?" + parameters;
}

$(document).ready(function() {
	$("#sStartDt, #sEndDt").datepicker({
		dateFormat : "yy-mm-dd",
		maxDate : '+1m'
	});

	var endDt = $("#sEndDt").val();
	$("#sYear").val(endDt.substring(0, 4));
	$("#sMonth").val(parseInt(endDt.substring(5, 7)));

});

function fn_CouponAdj() {
	const _width = '600';
	const _height = '400';
	const _left = Math.ceil(( window.screen.width - _width )/2);
	const _top = Math.ceil(( window.screen.height - _height )/2);
	const parameters = "sFromYear=" + $("#sYear").val() + "&sFromMonth=" + $("#sMonth").val();
	window.open('/oss/couponAdjExcelPop.do?'+parameters, 'couponAdj', 'width='+ _width +', height='+ _height +', scrollbars=yes, status=no, toolbar=no, left=' + _left + ', top='+ _top);
}

function fn_PointAdj() {
	const _width = '600';
	const _height = '400';
	const _left = Math.ceil(( window.screen.width - _width )/2);
	const _top = Math.ceil(( window.screen.height - _height )/2);
	const parameters = "sFromYear=" + $("#sYear").val() + "&sFromMonth=" + $("#sMonth").val();
	window.open('/oss/pointAdjExcelPop.do?'+parameters, 'couponAdj', 'width='+ _width +', height='+ _height +', scrollbars=yes, status=no, toolbar=no, left=' + _left + ', top='+ _top);
}
</script>
</head>
<body>
<div id="wrapper" class="container-fluid">
	<jsp:include page="/oss/head.do?menu=adj" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=adjust&sub=adj" />

		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
					<div class="btn_rt01">
						<label>자동정산이 안된경우 눌러주세요 >> <div class="btn_sty01"><a href="javascript:void(0)" onclick="fn_GetAdjust();">수동정산추출</a></div></label>
					</div>
				</div>
            	<h4 class="title03">정산</h4>
            	<form name="frm" method="get">
            		<input type="hidden" name="sAdjDt" id="sAdjDt" value="${searchVO.sAdjDt}" />

					<div>
						정산 지급일
                                            <input type="text" name="sStartDt" id="sStartDt" class="form-control d-inline-block w-auto text-center" title="검색시작일" value="${searchVO.sStartDt}" />
                                            ~
                                            <input type="text" name="sEndDt" id="sEndDt" class="form-control d-inline-block w-auto text-center" title="검색종료일" value="${searchVO.sEndDt}" />

                                            <button type="button" class="btn btn-primary ms-2" onclick="fn_Search();">검색</button>
					</div>
                </form>
                <div class="table-responsive margin-top5 margin-btm35">
                                        <table class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>정산추출일자</th>
								<th>정산지급일자</th>
								<th>판매금액</th>
								<th>취소수수료</th>
								<th>판매수수료</th>
								<th>지원할인금액</th>
								<th>미지원할인금액</th>
								<th>지원포인트금액</th>
								<th>미지원포인트금액</th>
								<th>정산대상금액</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="9" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:set var="totalSaleAmt">${totalSaleAmt + result.saleAmt}</c:set>
								<c:set var="totalCmssAmt">${totalCmssAmt + result.cmssAmt}</c:set>
								<c:set var="totalSaleCmss">${totalSaleCmss + result.saleCmss}</c:set>
								<c:set var="totalDisAmt">${totalDisAmt + result.disAmt}</c:set>
								<c:set var="totalSupportDisAmt">${totalSupportDisAmt + result.supportDisAmt}</c:set>
								<c:set var="totalUnsupportedDisAmt">${totalUnsupportedDisAmt + result.unsupportedDisAmt}</c:set>
								<c:set var="totalSupportedPointAmt">${totalSupportedPointAmt + result.supportedPointAmt}</c:set>
								<c:set var="totalUnsupportedPointAmt">${totalUnsupportedPointAmt + result.unsupportedPointAmt}</c:set>
								<c:set var="totalAdjAmt">${totalAdjAmt + result.adjAmt}</c:set>

								<tr style="cursor:pointer;" onclick="fn_DtlAdjList('${fn:substring(result.adjDt, 0, 10)}')">
									<td class="align_ct"><strong>${fn:substring(result.adjDt, 0, 10)}</strong></td>
									<td class="align_ct"><strong>${fn:substring(result.adjItdDt, 0, 10)}</strong></td>
									<td class="align_rt"><fmt:formatNumber>${result.saleAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.cmssAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.saleCmss}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.supportDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.unsupportedDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.supportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.unsupportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt font_red"><strong><fmt:formatNumber>${result.adjAmt}</fmt:formatNumber>원</strong></td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td class="align_ct" colspan="2">합 계</td>
								<td class="align_ct"><fmt:formatNumber>${totalSaleAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalCmssAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalSaleCmss}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalSupportDisAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalUnsupportedDisAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalSupportedPointAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalUnsupportedPointAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${totalAdjAmt}</fmt:formatNumber>원</td>
							</tr>
						</tfoot>
					</table>
				</div>

				<div>
					정산 지급월
                                        <select name="sFromYear" id="sYear" class="form-select d-inline-block w-auto me-1">
						<c:forEach var="vYear" begin="2016" end="${fn:substring(searchVO.sEndDt, 0, 4)}" step="1">
							<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}년</option>
						</c:forEach>
                                        </select>

                                        <select name="sFromMonth" id="sMonth" class="form-select d-inline-block w-auto me-1">
						<c:forEach var="vMonth" begin="1" end="12" step="1">
							<option value="${vMonth}" <c:if test="${vMonth eq searchVO.sFromMonth}">selected="selected"</c:if>>${vMonth}월</option>
						</c:forEach>
                                        </select>
                                        <button type="button" class="btn btn-primary ms-1" onclick="fn_Search2();">검색</button>
				</div>

                                <div class="table-responsive margin-top5 margin-btm15">
                                        <table class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>정산지급월</th>
								<th>판매금액</th>
								<th>취소수수료</th>
								<th>판매수수료</th>
								<th>지원할인금액</th>
								<th>미지원할인금액</th>
								<th>지원포인트금액</th>
								<th>미지원포인트금액</th>
								<th>정산대상금액</th>
							</tr>
						</thead>
						<tbody id="adjList">
							<c:if test="${fn:length(resultList2) == 0}">
								<tr>
									<td colspan="8" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result2" items="${resultList2}" varStatus="status">
								<tr>
									<td class="align_ct"><b>${fn:substring(result2.adjItdDt, 0, 4)}-${fn:substring(result2.adjItdDt, 4, 6)}</b></td>
									<td class="align_rt"><fmt:formatNumber>${result2.saleAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result2.cmssAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result2.saleCmss}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result2.supportDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result2.unsupportedDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result2.supportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result2.unsupportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt font_red"><b><fmt:formatNumber>${result2.adjAmt}</fmt:formatNumber>원</b></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
                                        <div class="btn_rt01">
                                                <button type="button" class="btn btn-secondary me-1" onclick="fn_PointAdj();">포인트정산</button>
                                                <button type="button" class="btn btn-secondary me-1" onclick="fn_CouponAdj();">쿠폰정산</button>
                                                <button type="button" class="btn btn-outline-secondary" onclick="fn_ExcelDown();">엑셀다운로드(업체별)</button>
                                        </div>
				</div>

				<div style="border-bottom: solid 3px #8c8b89;margin-top: 40px;margin-bottom: 10px"> </div>
					<h4 class="title03">탐나는전 정산</h4>
                                <div  style="margin-top:55px">
                                        거래일시
                                        <input type="text" name="sTradeStartDt" id="sTradeStartDt" class="form-control d-inline-block w-auto text-center" title="검색시작일" value="${searchVO.sStartDt}" />
                                        ~
                                        <input type="text" name="sTradeEndDt" id="sTradeEndDt" class="form-control d-inline-block w-auto text-center" title="검색종료일" value="${searchVO.sEndDt}" />

                                        <button type="button" class="btn btn-outline-secondary ms-2" onclick="fn_ExcelTamnacardDown();">엑셀다운로드</button>
                                </div>

			</div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>