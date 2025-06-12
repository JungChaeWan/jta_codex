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
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 목록
 */
function fn_ListPrdt(){
	document.prdtInf.action = "<c:url value='/mas/rc/productList.do'/>";
	document.prdtInf.submit();
}

function fn_UdtPrdt(){
	document.prdtInf.action = "<c:url value='/mas/rc/viewUpdatePrdt.do'/>";
	document.prdtInf.submit();
}

/**
 * 상품 승인 요청
 */
function fn_ApprovalReqPrdt(){
	$.ajax({
		url : "<c:url value='/mas/rc/approvalPrdt.ajax'/>",
		dataType:"json",
		data : "prdtNum=${prdtInf.prdtNum}",
		success: function(data) {
			fn_ListPrdt();
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

/**
 * 상품 승인 취소 요청
 */
function fn_CancelApproval(){
	$.ajax({
		url : "<c:url value='/mas/rc/cancelApproval.ajax'/>",
		dataType:"json",
		data : "prdtNum=${prdtInf.prdtNum}",
		success: function(data) {
			
			fn_ListPrdt();
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

/**
 * 판매중지 요청 처리
 */
function fn_SaleStopPrdt(){
	document.prdtInf.action = "<c:url value='/mas/rc/saleStopPrdt.do' />";
	document.prdtInf.submit();
}

/**
 * 재 판매처리
 */
function fn_SaleStartPrdt(){
	document.prdtInf.action = "<c:url value='/mas/rc/saleStartPrdt.do' />";
	document.prdtInf.submit();
}

function fn_PrintN(){
    if(confirm("해당 상품은 더이상 관리자에서 보이지 않습니다. 진행하시겠습니까?")){
        document.prdtInf.action = "<c:url value='/mas/rc/salePrintN.do' />";
        document.prdtInf.submit();
	}

}

$(document).ready(function(){
	if('${errorCode}' == '1'){
		alert("상품 정보를 확인해 주세요.");
		location.href = "<c:url value='/mas/rc/productList.do' />";
	}
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="RC_PRDTINFVO" name="prdtInf" method="post">
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sCarDivCd" value="${searchVO.sCarDivCd}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" name="sRcCardivNum" value="${searchVO.sRcCardivNum}" />
				<input type="hidden" name="sIsrTypeDiv" value="${searchVO.sIsrTypeDiv}" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<h2 class="title08"><c:out value="${prdtInf.prdtNm}"/></h2>
					<div id="menu_depth3">
						<ul>
							<li class="on"><a class="menu_depth3" href="<c:url value='/mas/rc/detailPrdt.do?prdtNum=${prdtInf.prdtNum}'/>">차량정보</a></li>
							<%-- <li><a class="menu_depth3" href="<c:url value='/mas/rc/imgList.do?prdtNum=${prdtInf.prdtNum}'/>">이미지관리</a></li> --%>
							<li><a class="menu_depth3" href="<c:url value='/mas/rc/amtList.do?prdtNum=${prdtInf.prdtNum}'/>">요금관리</a></li>
							<li><a class="menu_depth3" href="<c:url value='/mas/rc/disPerList.do?prdtNum=${prdtInf.prdtNum}'/>">할인율관리</a></li>
						</ul>
						<div class="btn_rt01">
							<c:if test="${(prdtInf.tradeStatus eq Constant.TRADE_STATUS_REG) or (prdtInf.tradeStatus eq Constant.TRADE_STATUS_EDIT)}">
								<div class="btn_sty01"><a href="javascript:fn_ApprovalReqPrdt();">승인요청</a></div>
							</c:if>
							<c:if test="${prdtInf.tradeStatus eq Constant.TRADE_STATUS_APPR_REQ}">
								<div class="btn_sty01"><a href="javascript:fn_CancelApproval();">승인요청취소</a></div>
							</c:if>
						</div>
					</div>

					<c:if test="${not empty apprMsg}">
						<h4 class="title03">전달 사항</h4>
						<table class="table01 margin-btm15">
							<tr>
								<td><c:out value="${apprMsg}" escapeXml="false"/></td>
							</tr>
						</table>
					</c:if>

					<h4 class="title02">상품 상세정보</h4>
					<table class="table02">
						<colgroup>
							<col class="width15" />
							<col class="width30" />
							<col class="width15" />
							<col />
						</colgroup>
						<tr>
							<th>상품번호</th>
							<td colspan>
								<c:out value='${prdtInf.prdtNum}'/>
								<input type="hidden" name="prdtNum" id="prdtNum" value="${prdtInf.prdtNum}" />
							</td>
							<th>차종코드</th>
							<td colspan>
								<c:out value='${prdtInf.rcCardivNum}'/>
							</td>
						</tr>
						<tr>
							<th>상품명</th>
							<td><c:out value='${prdtInf.prdtNm}'/></td>
							<th>상품설명</th>
							<td><c:out value="${cardiv.cardivExp}" escapeXml="false" /></td>
						</tr>
						<tr>
							<th>제조사</th>
							<td>
								<c:forEach var="maker" items="${makerDivCd}" varStatus="status">
									<c:if test="${maker.cdNum == prdtInf.makerDiv}"><c:out value='${maker.cdNm}'/></c:if>
								</c:forEach>
							</td>
							<th>정원</th>
							<td><c:out value="${prdtInf.maxiNum}" />명</td>
						</tr>
						<tr>
							<th>차종</th>
							<td>
								<c:forEach var="car" items="${carDivCd}" varStatus="status">
									<c:if test="${car.cdNum == prdtInf.carDiv}"><c:out value='${car.cdNm}'/></c:if>
								</c:forEach>
							</td>
							<th>연료</th>
							<td>
								<c:forEach var="fuel" items="${fuelCd}" varStatus="status">
									<c:if test="${fuel.cdNum == prdtInf.useFuelDiv}"><c:out value='${fuel.cdNm}'/></c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>연계ID</th>
							<td>${prdtInf.linkMappingNum}</td>
							<th>연계보험ID</th>
							<td>${prdtInf.linkMappingIsrNum}</td>
						</tr>
						<tr>
							<th>변속기</th>
							<td>
								<c:forEach var="trans" items="${transDivCd}" varStatus="status">
									<c:if test="${trans.cdNum == prdtInf.transDiv}"><c:out value='${trans.cdNm}'/></c:if>
								</c:forEach>
							</td>
							<th>연식</th>
							<td><c:out value="${prdtInf.modelYear}" /></td>
						</tr>
						<tr>
							<th>주요정보</th>
							<td colspan="3">
								<c:forEach var="icon" items="${iconCdList}" varStatus="status">
									<c:if test="${icon.checkYn eq 'Y' }">
										<c:out value='${icon.iconCdNm}'/>,
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>대여조건</th>
							<td colspan="3">
								<b>나이 - </b>만 ${prdtInf.rntQlfctAge }세 이상 |
								<b>운전경력 - </b>${prdtInf.rntQlfctCareer }년 이상 |
								<b>면허종류 - </b>${prdtInf.rntQlfctLicense }종 보통 이상
							</td>
						</tr>
						<tr>
							<th>보험여부</th>
							<td colspan="3">
								<c:forEach var="isr" items="${isrCd}" varStatus="status">
									<c:if test="${isr.cdNum == prdtInf.isrDiv}"><c:out value='${isr.cdNm}'/></c:if>
								</c:forEach>
								<c:if test="${prdtInf.isrDiv eq 'ID10' }">
									(
									<c:if test="${prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN }">일반자차</c:if>
									<c:if test="${prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX }">고급자차</c:if>
									)
								</c:if>
							</td>
						</tr>
						<c:if test="${(prdtInf.isrDiv ne 'ID10') or ((prdtInf.isrDiv eq 'ID10') and (prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN))}">
							<tr>
								<th>일반자차</th>
								<td colspan="3">
								  	<c:if test="${prdtInf.isrDiv ne 'ID10' }">
										<b>요금 - </b>1일 <fmt:formatNumber value="${prdtInf.generalIsrAmt }"/> 원 |
								  	</c:if>
									<b>나이 - </b>만 ${prdtInf.generalIsrAge }세 이상 |
									<b>운전 경력 - </b>${prdtInf.generalIsrCareer }년 이상 |
									<b>보상한도 - </b>${prdtInf.generalIsrRewardAmt } |
									<b>고객부담금 - </b>${prdtInf.generalIsrBurcha }
								</td>
							</tr>
						</c:if>
						<c:if test="${(prdtInf.isrDiv ne 'ID10') or ((prdtInf.isrDiv eq 'ID10') and (prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX))}">
							<tr>
								<th>고급자차</th>
								<td colspan="3">
								  <c:if test="${prdtInf.isrDiv ne 'ID10' }">
									<b>요금 - </b>1일 <fmt:formatNumber value="${prdtInf.luxyIsrAmt }"/> 원 |
								  </c:if>
									<b>나이 - </b>만 ${prdtInf.luxyIsrAge }세 이상 |
									<b>운전 경력 - </b>${prdtInf.luxyIsrCareer }년 이상 |
									<b>보상한도 - </b>${prdtInf.luxyIsrRewardAmt } |
									<b>고객부담금 - </b>${prdtInf.luxyIsrBurcha }
								</td>
							</tr>
						</c:if>
						<tr>
							<th>보험요금안내</th>
							<td colspan="3"><c:out value="${prdtInf.isrAmtGuide}" escapeXml="false"/></td>
						</tr>
						<tr>
							<th>등록일시</th>
							<td><c:out value="${prdtInf.frstRegDttm}" /></td>
							<th>수정일시</th>
							<td><c:out value="${prdtInf.lastModDttm}" /></td>
						</tr>
					</table>

					<ul class="btn_rt01">
						<c:if test="${Constant.TRADE_STATUS_APPR eq prdtInf.tradeStatus }">
							<li class="btn_sty04"><a href="javascript:fn_SaleStopPrdt()">판매중지 요청</a></li>
						</c:if>
						<c:if test="${Constant.TRADE_STATUS_STOP eq prdtInf.tradeStatus }">
							<li class="btn_sty04 "><a href="javascript:fn_PrintN()">판매종료</a></li>
							<li class="btn_sty04"><a href="javascript:fn_SaleStartPrdt()">판매전환</a></li>
						</c:if>
						<li class="btn_sty04"><a href="javascript:fn_UdtPrdt()">수정</a></li>
						<li class="btn_sty01"><a href="javascript:fn_ListPrdt()">목록</a></li>
					</ul>
				</div>
			</form:form>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>