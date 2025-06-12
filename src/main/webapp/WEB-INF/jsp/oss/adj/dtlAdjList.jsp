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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/align_tablesorter.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">
function fn_ChkAdjustAppr(){
	var corpId = [];
	$("input:checkbox[name=chk]").each(function(index){
		if($(this).is(":checked")){
			corpId.push($("input[name=corpId]").eq(index).val());
		}
	});

	if(corpId.length == 0){
		alert("선택된 업체가 없습니다.");
		return;
	}
	fn_AdjustComplete(corpId);
}

function fn_AdjustComplete(corpId){
	if(!confirm("해당 업체에 대해 정산완료를 처리하시겠습니까?")){
		return;
	}
	var parameters = "corpList=" + corpId;
	parameters += "&sAdjDt=${searchVO.sAdjDt}";

	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/oss/adjustComplete.ajax'/>",
		data:parameters,
		beforeSend:function(){
			if(corpId.length == 0){
				alert("선택된 업체가 없습니다.");
				return false;
			}
		},
		success:function(data){
			alert("해당업체에 대해 정산완료가 처리됐습니다.");
			location.reload(true);
		},
		error:fn_AjaxError
	});
}

function fn_AdjDtlInf(sCorpId){
	$("#sCorpId").val(sCorpId);

	document.frm.action = "<c:url value='/oss/dtlAdjInfList.do'/>";
	document.frm.submit();
}

function fn_AdjList(){
	document.frm.action = "<c:url value='/oss/adjList.do'/>";
	document.frm.submit();
}

// 정렬 기준
var order;
var direction;
var currentSort = [[9,1]];

function fn_SortInfo() {
	order = currentSort[0][0];
	direction = currentSort[0][1];

	if(order == 1) {
		order = "CORP_NM";
	} else if(order == 2) {
		order = "ADJ_STATUS_CD";
	} else {
		order = "ADJ_AMT";
	}
	if(direction == 1) {
		direction = "DESC";
	} else {
		direction = "ASC";
	}
}

function fn_ExcelDown(){
	fn_SortInfo();

	var parameters = "sAdjDt=${searchVO.sAdjDt}";
	parameters += "&sOrder=" + order + "&sDirection=" + direction;

	frmFileDown.location = "<c:url value='/oss/adjustExcelDown1.do' />?" + parameters;
}

// 상세목록다운
function fn_DtlExcelDown(){
	var parameters = "sAdjDt=${searchVO.sAdjDt}";

	frmFileDown.location = "<c:url value='/oss/adjustExcelDown2.do' />?"+ parameters;
}

$(document).ready(function(){
	$("#allChk").click(function(){
		if($(this).is(":checked")){
			$("input:checkbox[name=chk]").each(function(){
				if($(this).prop("disabled") == false){
					$(this).prop("checked", true);
				}
			});
			// $("input:checkbox[name=chk]").prop("checked", true);
		}else{
			$("input:checkbox[name=chk]").prop("checked", false);
		}
	});

	// 테이블 정렬
	$(".tableSorter").tablesorter({
		headers: {
			9: {sorter: 'currency'},
			0: {sorter: false}, 3: {sorter: false}, 4: {sorter: false}, 5: {sorter: false}, 6: {sorter: false}, 7: {sorter: false}, 8: {sorter: false},
			10: {sorter: false}, 11: {sorter: false}, 12: {sorter: false}, 13: {sorter: false}/*, 14: {sorter: false}*/
		},
	}).bind("sortEnd", function (sorter) {
		currentSort = sorter.target.config.sortList;
	});

});

function fn_CouponAdj() {
	const _width = '600';
	const _height = '400';
	const _left = Math.ceil(( window.screen.width - _width )/2);
	const _top = Math.ceil(( window.screen.height - _height )/2);
	window.open('/oss/couponAdjExcelPop.do?sAdjDt='+${searchVO.sAdjDt}, 'couponAdj', 'width='+ _width +', height='+ _height +', scrollbars=yes, status=no, toolbar=no, left=' + _left + ', top='+ _top);
}

function fn_PointAdj() {
	const _width = '600';
	const _height = '400';
	const _left = Math.ceil(( window.screen.width - _width )/2);
	const _top = Math.ceil(( window.screen.height - _height )/2);
	window.open('/oss/pointAdjExcelPop.do?sAdjDt='+${searchVO.sAdjDt}, 'couponAdj', 'width='+ _width +', height='+ _height +', scrollbars=yes, status=no, toolbar=no, left=' + _left + ', top='+ _top);
}

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=adj" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=adjust&sub=adj" />
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_PointAdj();">포인트정산</a></div>
						<div class="btn_sty04"><a href="javascript:fn_CouponAdj();">쿠폰정산</a></div>
						<div class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드(업체별)</a></div>
						<div class="btn_sty04"><a href="javascript:fn_DtlExcelDown();">엑셀다운로드(건별)</a></div>
						<div class="btn_sty04"><a href="javascript:fn_ChkAdjustAppr();">선택정산완료</a></div>
						<div class="btn_sty01"><a href="javascript:fn_AdjList();">뒤로</a></div>
					</div>
				</div>
            	<h4 class="title03">정산상세</h4>
            	<form name="frm" method="post">
            		<input type="hidden" name="sAdjDt" id="sAdjDt" value="${searchVO.sAdjDt}" />
            		<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" />
            		<input type="hidden" name="sFromYear" id="sFromYear" value="${searchVO.sFromYear}" />
            		<input type="hidden" name="sFromMonth" id="sFromMonth" value="${searchVO.sFromMonth}" />
                </form>
                <div class="list margin-top5 margin-btm15">
					<table class="table01 list_tb tableSorter">
						<colgroup>
							<col width="30" />
							<col width="*" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="100" />
							<%--<col width="80" />--%>
							<col width="100" />
							<col width="120" />
							<col width="*" />
							<col width="110" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="allChk" /></th>
								<th>업체명 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>정산상태 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>판매금액</th>
								<th>지원<br>할인금액</th>
								<th>미지원<br>할인금액</th>
								<th>지원<br>포인트금액</th>
								<th>미지원<br>포인트금액</th>
								<th>취소<br>수수료</th>
								<th>판매<br>수수료</th>
								<th>정산대상금액 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<%--<th>PG사<br>수수료</th>--%>
								<th>은행</th>
								<th>계좌번호</th>
								<th>예금주</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="15" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach items="${resultList}" var="result" varStatus="status">
								<input type="hidden" name="corpId" id="corpId" value="${result.corpId}" />

								<tr <c:if test="${result.modCnt > 0}">class="error"</c:if>>
									<td class="align_ct">
										<input type="checkbox" name="chk" <c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_COM}">disabled="disabled"</c:if> />
									</td>
									<td><strong>${result.corpNm}</strong></td>
									<td class="align_ct">
										<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_READY}">정산대기</c:if>
										<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_COM}">정산완료</c:if>
									</td>
									<td class="align_rt"><fmt:formatNumber>${result.saleAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.supportDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.unsupportedDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.supportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.unsupportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.cmssAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.saleCmss}</fmt:formatNumber>원</td>
									<td class="align_rt font_red"><strong><fmt:formatNumber>${result.adjAmt}</fmt:formatNumber>원</strong></td>
									<%--<td class="align_rt"><fmt:formatNumber>${result.pgCmss}</fmt:formatNumber>원</td>--%>
									<td class="align_ct">${result.bankNm}</td>
									<td class="align_ct">${result.accNum}</td>
									<td>${result.depositor}</td>
									<td class="align_ct">
										<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_READY}">
											<div class="btn_sty09"><span><a href="javascript:fn_AdjustComplete('${result.corpId}');">정산완료처리</a></span></div>
										</c:if>
										<c:if test="${result.adjAmt > 0}">
											<div class="btn_sty06"><span><a href="javascript:fn_AdjDtlInf('${result.corpId}');">상세리스트</a></span></div>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
            </div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>