<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<head>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/toastr.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel='stylesheet' type="text/css" href="<c:url value='/css/common/toastr.min.css'/>"/>

<title></title>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>

<script type="text/javascript">
var hrkCodeItem = [];

function fn_Udt(){
	document.AD_PRDINFVO.action = "<c:url value='/mas/ad/viewUpdatePrdt.do' />";
	document.AD_PRDINFVO.submit();
}

function fn_List(){
	document.AD_PRDINFVO.action = "<c:url value='/mas/ad/productList.do' />";
	document.AD_PRDINFVO.submit();
}


function fn_SaleStopPrdt(){
	document.AD_PRDINFVO.action = "<c:url value='/mas/ad/saleStopPrdt.do' />";
	document.AD_PRDINFVO.submit();
}

function fn_SaleStartPrdt(){
	document.AD_PRDINFVO.action = "<c:url value='/mas/ad/saleStartPrdt.do' />";
	document.AD_PRDINFVO.submit();
}

//판매종료
function fn_PrintN(){
    if(confirm("해당 상품은 더이상 관리자에서 보이지 않습니다. 진행하시겠습니까?")){
        document.AD_PRDINFVO.action = "<c:url value='/mas/ad/salePrintN.do' />";
        document.AD_PRDINFVO.submit();
	}	
}

/**
 * 상품 승인 요청
 */
function fn_ApprovalReqPrdt(){
	$.ajax({
		url: "<c:url value='/mas/ad/approvalPrdt.ajax'/>",
		dataType: "json",
		data: "prdtNum=${adPrdinf.prdtNum}",
		success: function(data) {
			//location.reload(true);
			location.href = "<c:url value='/mas/ad/detailPrdt.do'/>?prdtNum=${adPrdinf.prdtNum}";
		},
		error: fn_AjaxError
	});
}

/**
 * 상품 승인 취소 요청
 */
function fn_CancelApproval(){
	$.ajax({
		url: "<c:url value='/mas/ad/cancelApproval.ajax'/>",
		dataType:"json",
		data: "prdtNum=${adPrdinf.prdtNum}",
		success: function(data) {
			//location.reload(true);
			location.href = "<c:url value='/mas/ad/detailPrdt.do'/>?prdtNum=${adPrdinf.prdtNum}";
		},
		error: fn_AjaxError
	});
}

$(document).ready(function(){

});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<div id="contents">
				<h2 class="title08"><c:out value="${adPrdinf.prdtNm}"/></h2>

				<form:form commandName="AD_PRDINFVO" name="AD_PRDINFVO" method="post" enctype="multipart/form-data">
					<div id="menu_depth3">
						<ul>
				            <li class="on"><a class="menu_depth3" href="<c:url value='/mas/ad/detailPrdt.do?prdtNum=${adPrdinf.prdtNum}'/>">객실정보</a></li>
			              	<%--<li><a class="menu_depth3" href="<c:url value='/mas/ad/cntList.do?prdtNum=${adPrdinf.prdtNum}'/>">수량관리</a></li>--%>
			              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/imgList.do?prdtNum=${adPrdinf.prdtNum}'/>">객실이미지</a></li>
			              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/amtList.do?prdtNum=${adPrdinf.prdtNum}'/>">요금관리</a></li>
			              	<c:if test="${adPrdinf.ctnAplYn == 'Y'}">
			              		<li><a class="menu_depth3" href="<c:url value='/mas/ad/continueNight.do?prdtNum=${adPrdinf.prdtNum}'/>">연박 요금관리</a></li>
			              	</c:if>
			              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/adAddamtPrdtList.do?prdtNum=${adPrdinf.prdtNum}'/>">인원추가요금</a></li>
		                </ul>
		                <div class="btn_rt01">
		                	<c:if test="${(adPrdinf.tradeStatus == Constant.TRADE_STATUS_REG) || (adPrdinf.tradeStatus == Constant.TRADE_STATUS_EDIT)}">
		                		<div class="btn_sty01"><a href="javascript:fn_ApprovalReqPrdt();">승인요청</a></div>
		                	</c:if>
		                	<c:if test="${adPrdinf.tradeStatus == Constant.TRADE_STATUS_APPR_REQ}">
		                		<div class="btn_sty01"><a href="javascript:fn_CancelApproval();">승인요청취소</a></div>
		                	</c:if>
		                </div>
		            </div>

					<div class="register_area">
						<c:if test="${not empty apprMsg}">
							<h4 class="title03">전달 사항</h4>
							<table border="1" class="table01 margin-btm15">
								<colgroup>
									<col width="*" />
								</colgroup>
								<tr>
									<td><c:out value="${apprMsg}" escapeXml="false"/></td>
								</tr>
							</table>
						</c:if>

						<h4 class="title03">객실 상세</h4>
						<table border="1" class="table02">
							<colgroup>
								<col width="225" />
								<col width="*" />
								<col width="225" />
								<col width="*" />
							</colgroup>
							<tr>
								<th>상품번호</th>
								<td>
									<input type="hidden" id="prdtNum" name="prdtNum" value='<c:out value="${adPrdinf.prdtNum}" />' />
									<c:out value="${adPrdinf.prdtNum}" />
								</td>
								<th>업체 아이디</th>
								<td>
									<input type="hidden" id="corpId" name="corpId" value='<c:out value="${adPrdinf.corpId}" />' />
									<c:out value="${adPrdinf.corpId}" />
								</td>
							</tr>
							<c:if test="${corpInfo.corpLinkYn == 'Y'}">
								<tr>
									<th>연계번호</th>
									<td colspan="3"><c:out value="${adPrdinf.mappingNum}" /></td>
								</tr>
							</c:if>
							<tr>
								<th>명칭</th>
								<td colspan="3"><c:out value="${adPrdinf.prdtNm}" /></td>
							</tr>
							<tr>
								<th>기준인원</th>
								<td><c:out value="${adPrdinf.stdMem}" /></td>
								<th>최대인원</th>
								<td><c:out value="${adPrdinf.maxiMem}" /></td>
							</tr>
							<tr>
								<th>인원 추가가능 여부</th>
								<td>
									<c:if test="${adPrdinf.memExcdAbleYn == 'Y'}">허용</c:if>
									<c:if test="${adPrdinf.memExcdAbleYn == 'N'}">허용안함</c:if>
								</td>
								<th>추가요금 여부</th>
								<td colspan="3">
									<c:if test="${adPrdinf.addamtYn == 'Y' }">추가</c:if>
									<c:if test="${adPrdinf.addamtYn == 'N' }">미추가</c:if>
								</td>
							</tr>
							<tr>
								<th>조식 포함 여부</th>
								<td>
									<c:if test="${adPrdinf.breakfastYn == 'Y'}">포함</c:if>
									<c:if test="${adPrdinf.breakfastYn == 'N'}">미포함</c:if>
								</td>
								<th>연박 할인</th>
								<td>
									<c:if test="${adPrdinf.ctnAplYn == 'Y'}">적용</c:if>
									<c:if test="${adPrdinf.ctnAplYn == 'N'}">미적용</c:if>
								</td>
							</tr>
							<tr>
								<th>최소 예약 박수</th>
								<td><c:out value="${adPrdinf.minRsvNight}" /></td>
								<th>최대 예약 박수</th>
								<td><c:out value="${adPrdinf.maxRsvNight}" /></td>
							</tr>
							<tr>
								<th>상품설명</th>
								<td colspan="3">
									<c:out value="${adPrdinf.prdtExp}" />
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td colspan="3">
									<c:if test="${Constant.TRADE_STATUS_REG eq adPrdinf.tradeStatus }">등록중</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq adPrdinf.tradeStatus }">승인요청</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR eq adPrdinf.tradeStatus }">승인</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq adPrdinf.tradeStatus }">승인거절</c:if>
									<c:if test="${Constant.TRADE_STATUS_STOP eq adPrdinf.tradeStatus }">판매중지</c:if>
								</td>
							</tr>
							<%--<tr>
								<th>출력 여부</th>
								<td colspan="3">
									<c:if test="${adPrdinf.printYn == 'Y'}">출력</c:if>
									<c:if test="${adPrdinf.printYn == 'N'}">미출력</c:if>
								</td>
							</tr>--%>
							<tr>
								<th>순번</th>
								<td><c:out value="${adPrdinf.viewSn}" /></td>
								<th>판매량</th>
								<td><c:out value="${adPrdinf.buyNum}" /></td>
							</tr>
						</table>
					</div>
				</form:form>

				<ul class="btn_rt01">
					<c:if test="${Constant.TRADE_STATUS_APPR eq adPrdinf.tradeStatus }">
						<li class="btn_sty04"><a href="javascript:fn_SaleStopPrdt()">판매중지 요청</a></li>
					</c:if>
					<c:if test="${Constant.TRADE_STATUS_STOP eq adPrdinf.tradeStatus }">
						<li class="btn_sty04 "><a href="javascript:fn_PrintN()">판매종료</a></li>
						<li class="btn_sty04"><a href="javascript:fn_SaleStartPrdt()">판매전환</a></li>
					</c:if>
					<li class="btn_sty04"><a href="javascript:fn_Udt()">수정</a></li>
					<li class="btn_sty01"><a href="javascript:fn_List()">목록</a></li>
				</ul>
			</div>
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>