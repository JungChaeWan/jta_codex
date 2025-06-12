<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_Search(){
	document.frm.action = "<c:url value='/mas/adjList.do'/>";
	document.frm.submit();
}

function fn_DtlAdjList(adjDt){
	$("#sAdjDt").val(adjDt);
	document.frm.action = "<c:url value='/mas/dtlAdjList.do'/>";
	document.frm.submit();
}

function printDiv()
{
	var initBody = document.body.innerHTML;
	    window.onbeforeprint = function(){
	        document.body.innerHTML = document.getElementById('contents').innerHTML;
			var form = document.querySelector("form");
			var printArea = document.querySelector(".printArea");
			/*var textArea = document.querySelector(".title03");*/
			var body = document.body;	// 그 엘리먼트의 부모 객체
			body.getElementsByClassName("title03")[0].innerHTML = "탐나오 정산데이터"
			body.removeChild(form);
			body.removeChild(printArea);
	    }

	    window.onafterprint = function(){

	        document.body.innerHTML = initBody;
	    }
	    window.print();

}

$(document).ready(function() {
	$("#sStartDt, #sEndDt").datepicker({
		dateFormat : "yy-mm-dd",
		maxDate : '+1m'
	});
});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=adj" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
				</div>
            	<h4 class="title03">정산</h4>
            	<form name="frm" method="post">
            		<input type="hidden" name="sAdjDt" id="sAdjDt" value="${searchVO.sAdjDt}" />
					
					<div>
						<input type="text" name="sStartDt" id="sStartDt" class="input_text4 center" value="${searchVO.sStartDt}" title="검색시작일" /> ~ 
						<input type="text" name="sEndDt" id="sEndDt" class="input_text4 center" title="검색종료일" value="${searchVO.sEndDt}" />	               	
						<li class="btn_sty04"><a href="javascript:javascript:fn_Search();">검색</a></li>
					</div>
                </form>
                <div class="list margin-top5 margin-btm15">
					<table class="table01 list_tb" id="tableList">
						<thead>
							<tr>
								<th>정산지급예정일</th>
								<th>총 판매금액</th>
								<th>취소 수수료</th>
								<th>판매 수수료</th>
								<th>정산대상금액</th>
								<th>정산상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="6" class="align_ct">정산 결과가 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:set var="totalSaleAmt">${totalSaleAmt + result.saleAmt }</c:set>
								<c:set var="totalCmssAmt">${totalCmssAmt + result.cmssAmt }</c:set>
								<c:set var="totalSaleCmss">${totalSaleCmss + result.saleCmss + ((result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100) - (result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100)%10) + (result.supportedPointAmt * (result.adjAplPct / 100)  - result.supportedPointAmt * (result.adjAplPct / 100)%10) }</c:set>
								<c:set var="totalAdjAmt">${totalAdjAmt + (result.saleAmt + result.cmssAmt) - (result.saleCmss + ((result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100)) - ((result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100))%10) - (result.supportedPointAmt * (result.adjAplPct / 100)  - result.supportedPointAmt * (result.adjAplPct / 100)%10) - result.corpDisAmt}</c:set>

								<tr style="cursor:pointer;" onclick="fn_DtlAdjList('${fn:substring(result.adjDt, 0, 10)}')">
									<td class="align_ct"><strong>${fn:substring(result.adjItdDt, 0, 10)}</strong></td>
									<td class="align_ct"><fmt:formatNumber>${result.saleAmt}</fmt:formatNumber>원</td>
									<td class="align_ct"><fmt:formatNumber>${result.cmssAmt}</fmt:formatNumber>원</td>
									<td class="align_ct"><fmt:formatNumber>${result.saleCmss + ((result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100)  - (result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100)%10) + (result.supportedPointAmt * (result.adjAplPct / 100)  - result.supportedPointAmt * (result.adjAplPct / 100)%10)}</fmt:formatNumber>원</td>
									<td class="align_ct font_red"><fmt:formatNumber>${(result.saleAmt + result.cmssAmt) - (result.saleCmss + ((result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100)) - ((result.supportDisAmt-result.corpDisAmt) * (result.adjAplPct / 100))%10) - (result.supportedPointAmt * (result.adjAplPct / 100)  - result.supportedPointAmt * (result.adjAplPct / 100)%10) - result.corpDisAmt}</fmt:formatNumber>원</td>
									<td class="align_ct">
										<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_READY}">정산대기</c:if>
										<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_COM}">정산완료<%--(${fn:substring(result.adjCmplDt, 0, 10)})--%></c:if>
									</td>
								</tr>
							</c:forEach>
							<tfoot>
								<tr>
									<td class="align_ct"><strong>합  계</strong></td>
									<td class="align_ct"><fmt:formatNumber>${totalSaleAmt}</fmt:formatNumber>원</td>
									<td class="align_ct"><fmt:formatNumber>${totalCmssAmt}</fmt:formatNumber>원</td>
									<td class="align_ct"><fmt:formatNumber>${totalSaleCmss}</fmt:formatNumber>원</td>
									<td class="align_ct"><fmt:formatNumber>${totalAdjAmt}</fmt:formatNumber>원</td>
									<td class="align_ct"></td>
								</tr>
							</tfoot>
						</tbody>
					</table>
				</div>
				<div class="printArea" align="right">
					<li class="btn_sty04"><a href="javascript:printDiv();" >출력하기</a></li>
				</div>
            </div>
		</div>
	</div>
</div>
</body>
</html>