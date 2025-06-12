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
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_DtlAdjList(adjDt){
	$("#sAdjDt").val(adjDt);
	document.frm.action = "<c:url value='/oss/dtlAdjList.do'/>";
	document.frm.submit();
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/bisAdjDtlExcel.do?"+ parameters +"'/>";
	
}
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=bis" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=bis&sub=adj" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">				
            	<h4 class="title03">정산리스트<small> [${corpInfo.corpNm } : ${searchVO.sStartDt } ~ ${searchVO.sEndDt }]</small></h4>
            	<form name="frm" method="get">
            		<input type="hidden" name="sAdjDt" id="sAdjDt" value="" />                
                </form>
                <div class="list margin-top5 margin-btm15">
				<table class="table01 list_tb">
					<colgroup>
						<col width="18%" />
						<col width="18%" />
						<col width="*" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>							
							<th>정산지급일자</th>
							<th>총 판매금액</th>
							<th>취소 수수료</th>
                            <th>판매 수수료</th>
                            <th>총 할인 금액</th>
							<th>정산대상금액</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${fn:length(adjList) == 0}">
						<tr>
							<td colspan="6" class="align_ct">
								정산 결과가 없습니다.
							</td>
						</tr>
						</c:if>
						<c:set var="totalSaleAmt" value="0" />
						<c:set var="totalCmssAmt" value="0" />
						<c:set var="totalSaleCmss" value="0" />
						<c:set var="totalDisAmt" value="0" />
						<c:set var="totalAdjAmt" value="0" />
						<c:forEach items="${adjList}" var="result" varStatus="status">
							<c:set var="totalSaleAmt" value="${totalSaleAmt + result.saleAmt }" />
							<c:set var="totalCmssAmt" value="${totalCmssAmt + result.cmssAmt }" />
							<c:set var="totalSaleCmss" value="${totalSaleCmss + result.saleCmss }" />
							<c:set var="totalDisAmt" value="${totalDisAmt + result.disAmt }" />
							<c:set var="totalAdjAmt" value="${totalAdjAmt + result.adjAmt }" />
							<tr ><%-- style="cursor:pointer;" onclick="fn_DtlAdjList('${fn:substring(result.adjDt,0, 10)}')" --%>								
								<td class="align_ct"><strong>${result.adjItdDt}</strong></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${result.saleAmt}"/></fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${result.cmssAmt}"/></fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${result.saleCmss}"/></fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${result.disAmt}"/></fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${result.adjAmt}"/></fmt:formatNumber>원</td>
							</tr>
						</c:forEach>
							<tr>								
								<td class="align_ct"><strong>합계</strong></td>
								<td class="align_ct"><strong><fmt:formatNumber><c:out value="${totalSaleAmt}"/></fmt:formatNumber> 원</strong></td>
								<td class="align_ct"><strong><fmt:formatNumber><c:out value="${totalCmssAmt}"/></fmt:formatNumber> 원</strong></td>
								<td class="align_ct"><strong><fmt:formatNumber><c:out value="${totalSaleCmss}"/></fmt:formatNumber> 원</strong></td>
								<td class="align_ct"><strong><fmt:formatNumber><c:out value="${totalDisAmt}"/></fmt:formatNumber> 원</strong></td>
								<td class="align_ct"><strong><fmt:formatNumber><c:out value="${totalAdjAmt}"/></fmt:formatNumber> 원</strong></td>
							</tr>
					</tbody>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty02">
						<a href="javascript:fn_SaveExcel()">엑셀저장</a>
					</li>
				</ul>
				</div>
            </div>
		</div>
	</div>
</div>
<!--  Excel 출력을 위한 form -->
<form name="frm" id="frm" method="post" onSubmit="return false;">
<input type="hidden" name="sCategory" value="${searchVO.sCategory }" />
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
<input type="hidden" name="sCorpId" value="${searchVO.sCorpId}"/>
<input type="hidden" name="sStartDt" value="${searchVO.sStartDt }" /> 
<input type="hidden" name="sEndDt" value="${searchVO.sEndDt }" />
<input type="hidden" name="sCorpNm" value="${searchVO.sCorpNm }">
</form>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>