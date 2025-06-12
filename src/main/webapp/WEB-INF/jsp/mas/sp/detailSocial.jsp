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
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

function fn_ListSocial(){
	document.tabForm.action = "<c:url value='/mas/sp/productList.do'/>";
	document.tabForm.submit();
}

function fn_SaleStopSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/saleStopSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum }",
		success: function(data) {
			 fn_goTap("PRODUCT");
		},
		error : fn_AjaxError
	});
}

function fn_SaleStartSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/saleStartSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum}",
		success: function(data) {
			 fn_goTap("PRODUCT");
		},
		error :fn_AjaxError
	});
}
//탭 이동
function fn_goTap(menu) {
	if(menu == "PRODUCT") {
		document.tabForm.action="<c:url value='/mas/sp/viewUpdateSocial.do' />";
	} else if( menu == "IMG") {
		document.tabForm.action="<c:url value='/mas/sp/imgList.do' />";
	} else if(menu == "IMG_DETAIL") {
		document.tabForm.action="<c:url value='/mas/sp/dtlImgList.do' />";
	} else if(menu == "OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewOption.do' />";
	} else if(menu == "DTLINF") {
		document.tabForm.action="<c:url value='/mas/sp/dtlinfList.do' />";
	}

	document.tabForm.submit();
}
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form name="social" method="post">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="prdtNum" name="prdtNum" value="${spPrdtInf.prdtNum}" />
			<div id="contents">

				<h2 class="title08"><c:out value="${spPrdtInf.prdtNm}"/></h2>

				<ul id="menu_depth3">
                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('DTLINF');" >상세정보</a></li>
	                    <c:if test="${spPrdtInf.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
	                   </c:if>
                </ul>

                <c:if test="${not empty apprMsg}">
				<h4 class="title03">전달 사항</h4>
				<table border="1" class="table01 margin-btm15">
					<colgroup>
                        <col width="*" />
                    </colgroup>
                    <tr>
						<td>
							<c:out value="${apprMsg}"  escapeXml="false"/>
						</td>
					</tr>
				</table>
				</c:if>

				<h4 class="title03">상품정보</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">상품 ID</th>
						<td><c:out value="${spPrdtInf.prdtNum}" /></td>
						<th>거래상태</th>
						<td>
							<c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInf.tradeStatus }">
                    			등록중
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq spPrdtInf.tradeStatus }">
                    			승인요청
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInf.tradeStatus }">
                    			승인
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq spPrdtInf.tradeStatus }">
                    			승인거절
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInf.tradeStatus }">
                    			판매중지
                    		</c:if>
						</td>
					</tr>
					<tr>
						<th>상품카테고리</th>
						<td colspan="3"><c:out value="${spPrdtInf.ctgrNm}" /></td>
					</tr>
					<tr>
						<th>상품명</th>
						<td colspan="3"><c:out value="${spPrdtInf.prdtNm}" /></td>
					</tr>
					<tr>
						<th>상품구분</th>
						<td colspan="3">
							<c:if test="${Constant.SP_PRDT_DIV_TOUR eq spPrdtInf.prdtDiv}">여행상품 : 날짜별 요금을 적용하는 상품</c:if>
							<c:if test="${Constant.SP_PRDT_DIV_COUP eq spPrdtInf.prdtDiv}">쿠폰상품 : 옵션별 요금과 유효기간을 적용하는 상품</c:if>
							<c:if test="${Constant.SP_PRDT_DIV_SHOP eq spPrdtInf.prdtDiv}"></c:if>
							<c:if test="${Constant.SP_PRDT_DIV_FREE eq spPrdtInf.prdtDiv}">무료쿠폰 : 구매 없이 이용가능한 무료할인쿠폰</c:if>
						</td>
					</tr>
					<tr>
						<th>상품정보</th>
						<td colspan="3"><c:out value="${spPrdtInf.prdtInf}" /></td>
					</tr>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<c:if test="${spPrdtInf.srchWord1 != null}">#<c:out value="${spPrdtInf.srchWord1}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord2 != null}">#<c:out value="${spPrdtInf.srchWord2}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord3 != null}">#<c:out value="${spPrdtInf.srchWord3}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord4 != null}">#<c:out value="${spPrdtInf.srchWord4}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord5 != null}">#<c:out value="${spPrdtInf.srchWord5}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord6 != null}">#<c:out value="${spPrdtInf.srchWord6}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord7 != null}">#<c:out value="${spPrdtInf.srchWord7}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord8 != null}">#<c:out value="${spPrdtInf.srchWord8}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord9 != null}">#<c:out value="${spPrdtInf.srchWord9}" />&nbsp;</c:if>
							<c:if test="${spPrdtInf.srchWord10 != null}">#<c:out value="${spPrdtInf.srchWord10}" />&nbsp;</c:if>
						</td>
					</tr>
					<tr>
						<th>판매시작일</th>
						<td><fmt:parseDate value="${spPrdtInf.saleStartDt}" var="saleStartDt" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd"/>
						<th>판매종료일</th>
						<td><fmt:parseDate value="${spPrdtInf.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd"/>
						 </td>
					</tr>
					<c:if test="${Constant.SP_PRDT_DIV_COUP eq spPrdtInf.prdtDiv}">
					<tr>
						<th>유효구분</th>
						<td>
							<c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_N}" > 유효기간 : 유효기간 내에 사용</c:if>
							<c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_Y}" >유효일자 : 구매일로 부터 유효일자 내에 사용</c:if>
						</td>
						<th>이용가능시간</th>
						<td>
							<c:out value="${spPrdtInf.useAbleTm}"/> 시간
						</td>
					</tr>
					<c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_N}">
					<tr>
						<th>유효기간</th>
						<td colspan="3">
							<fmt:parseDate value="${spPrdtInf.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd"/><fmt:parseDate value="${spPrdtInf.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd"/>
								<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_Y}">
						<th>유효일수</th>
						<td colspan="3">
							<c:out value="${spPrdtInf.exprDaynum}"/> 일
						</td>
					</c:if>
					</c:if>
					<c:if test="${Constant.SP_PRDT_DIV_FREE eq spPrdtInf.prdtDiv}">
					<tr>
						<th>유효기간</th>
						<td colspan="3">
							<fmt:parseDate value="${spPrdtInf.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd"/><fmt:parseDate value="${spPrdtInf.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd"/>
								<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${Constant.SP_PRDT_DIV_FREE eq spPrdtInf.prdtDiv}">
					<tr>
						<th>할인정보</th>
						<td colspan='3"'><c:out value="${spPrdtInf.disInf}" /></td>
					</tr>
					</c:if>
					<%-- <tr>
						<th>상품상세이미지</th>
						<td colspan="3">
							<c:out value="${spPrdtInf.prdtDtlImg}" />
						</td>
					</tr> --%>
					<tr>
						<th>사용조건</th>
						<td colspan="3">
							<c:out value="${spPrdtInf.useQlfct}"  escapeXml="false"/>
						</td>
					</tr>
					<tr>
						<th>취소안내</th>
						<td colspan="3">
							<c:out value="${spPrdtInf.cancelGuide}"  escapeXml="false"/>
						</td>
					</tr>
					<tr>
						<th>등록시간</th>
						<td>${spPrdtInf.frstRegDttm} (${spPrdtInf.frstRegId})</td>
						<th>수정시간</th>
						<td>${spPrdtInf.lastModDttm} (${spPrdtInf.lastModId})</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInf.tradeStatus }">
					<li class="btn_sty04"><a href="javascript:fn_SaleStopSocial()">판매중지</a></li>
					</c:if>
					<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInf.tradeStatus }">
					<li class="btn_sty04"><a href="javascript:fn_SaleStartSocial()">판매전환</a></li>
					</c:if>
					<li class="btn_sty01">
						<a href="javascript:fn_ListSocial()">목록</a>
					</li>
				</ul>

			</div>

			</form>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
<form name="tabForm">
	<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
	<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
	<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
</form>
</body>
</html>