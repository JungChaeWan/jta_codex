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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_SpList(){
	$("#sExprYn").val("");
	$("#sExprEndYn").val("");
	$("#sTradeStatus").val("");
	document.frm.pageIndex.value = 1;
	document.frm.action = "<c:url value='/oss/socialProductList.do'/>";
	document.frm.submit();
}

function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/socialExprProductList.do'/>";
	document.frm.submit();
}

function fn_viewProductAppr(prdtNum) {
	$.ajax({
		type:"post",
		url:"<c:url value='/oss/viewPrdtAppr.ajax'/>",
		data:"linkNum=" + prdtNum ,
		success:function(data){
			$("#div_ProductAppr").html(data);
			show_popup($("#div_ProductAppr"));
		},
		error : fn_AjaxError
	});
}

function fn_InsertProductAppr() {

	var parameter = $("#CM_CONFHISTVO").serialize();
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/productAppr.ajax'/>",
		data:parameter,
		success:function(data){
			fn_Search($("#pageIndex").val());
		},
		error : fn_AjaxError
	});
}

function fn_LoginMas(corpId,prdtNm){
	var parameters = "corpId=" + corpId;
	prdtNm = encodeURIComponent(prdtNm);

	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				window.open("/mas/sp/productList.do?sPrdtNm="+ prdtNm, '_blank');
			}else{
				alert("업체 로그인에 실패했습니다.");
			}
		}
	});
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/socialExprProductListExcel.do?"+ parameters +"'/>";
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=social" flush="false"></jsp:include>
		<div id="contents_area">
			<form id="frm" name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${spListSearchVO.pageIndex}"/>
				<input type="hidden" name="sTradeStatus" id="sTradeStatus" value="${spListSearchVO.sTradeStatus}" />
				<input type="hidden" id="sConfRequestStartDt" name="sConfRequestStartDt" value="${spListSearchVO.sConfRequestStartDt}" />
				<input type="hidden" id="sConfRequestEndDt" name="sConfRequestEndDt" value="${spListSearchVO.sConfRequestEndDt}"/>
				<input type="hidden" id="sSaleStartDt" name="sSaleStartDt" value="${spListSearchVO.sSaleStartDt}" />
				<input type="hidden" id="sSaleEndDt" name="sSaleEndDt"  value="${spListSearchVO.sSaleEndDt}" />
				<input type="hidden" id="sCorpNm" name="sCorpNm" value="${spListSearchVO.sCorpNm}"/>
				<input type="hidden" id="sPrdtNm" name="sPrdtNm" value="${spListSearchVO.sPrdtNm}"/>
				<input type="hidden" id="sCtgr" name="sCtgr" value="${spListSearchVO.sCtgr}" />
				<input type="hidden" id="sCorpSubCd" name="sCorpSubCd" value="${spListSearchVO.sCorpSubCd}" />
				<input type="hidden" id="sExprYn" name="sExprYn" value="${spListSearchVO.sExprYn}" />
				<input type="hidden" id="sExprEndYn" name="sExprEndYn" value="${spListSearchVO.sExprEndYn}" />
			</form>
			<!-- K 기간만료 상품 / B 유효기간 만료상품 -->
			<c:set var="exprType" value="K" />
			<c:if test="${spListSearchVO.sExprEndYn eq 'Y'}" >
			<c:set var="exprType" value="B" />
			</c:if>

		<div id="contents">
               	 <p class="search_list_ps title-btn"><c:if test="${exprType eq 'K'}">기간</c:if><c:if test="${exprType eq 'B'}">유효</c:if>만료예정 상품목록[총 <strong><fmt:formatNumber value="${totalCnt}" type="number" /></strong>건]
               	 <span class="side-wrap">
               	 	<a class="btn_sty01" href="javascript:fn_SpList();">뒤로</a>
               	 </span>
               	 </p>
               	  <!--리스트 검색 건수-->
				 <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">										
					<thead>
						<tr>
							<th width="75">번호</th>
							<th>상품번호</th>
							<th>상태</th>
							<th>승인관리</th>
							<th>형태</th>
							<th>업체명</th>							
							<th>상품명</th>
							<th><c:if test="${exprType eq 'K'}">판매</c:if> <c:if test="${exprType eq 'B'}">유효</c:if> 기간</th>
							<th>요청일</th>
							<th>승인일</th>
							<!-- <th width="210">기능틀</th> -->
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="10" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="spPrdtInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct"><c:out value="${spPrdtInfo.prdtNum}"/></td>
								<td class="align_ct">
									<c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInfo.tradeStatus}">
										등록중
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq spPrdtInfo.tradeStatus}">
										승인요청
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInfo.tradeStatus}">
										승인
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq spPrdtInfo.tradeStatus}">
										승인거절
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInfo.tradeStatus}">
										판매중지
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_EDIT eq spPrdtInfo.tradeStatus}">
										수정요청
									</c:if>
								</td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_viewProductAppr('${spPrdtInfo.prdtNum}');">승인관리</a></span></div>
								</td>
								<td class="align_ct">
									<c:if test="${Constant.SP_PRDT_DIV_TOUR eq spPrdtInfo.prdtDiv}">
									여행상품
									</c:if>
									<c:if test="${Constant.SP_PRDT_DIV_COUP eq spPrdtInfo.prdtDiv}">
									쿠폰상품
									</c:if>
									<c:if test="${Constant.SP_PRDT_DIV_FREE eq spPrdtInfo.prdtDiv}">
									무료쿠폰
									</c:if>
									<c:if test="${Constant.SP_PRDT_DIV_SHOP eq spPrdtInfo.prdtDiv}">
									쇼핑상품
									</c:if>
								</td>
								<td class="align_ct"><a href="javascript:fn_layerDetailCorp('${spPrdtInfo.corpId}');"><c:out value="${spPrdtInfo.corpNm}" /></a>
									&nbsp;<div class="btn_sty06"><a href="javascript:fn_LoginMas('${spPrdtInfo.corpId}','${spPrdtInfo.prdtNm}');">이동</a></div>
								</td>
								<td class="align_ct"><c:out value="${spPrdtInfo.prdtNm}" /></td>
								<c:if test="${exprType eq 'K'}">
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.saleStartDt}" var="saleStartDt" pattern="yyyyMMdd"/>
									<fmt:parseDate value="${spPrdtInfo.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd"/>
								</td>
								</c:if>
								<c:if test="${exprType eq 'B'}">
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd"/>
									<fmt:parseDate value="${spPrdtInfo.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
								</td>
								</c:if>
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.confRequestDttm}" var="confRequestDttm" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${confRequestDttm}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.confDttm}" var="confDttm" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${confDttm}" pattern="yyyy-MM-dd"/>
								</td>
								<%-- <td class="align_ct">
									<div class="btn_sty08"><span><a href="<c:url value='/oss/preview/spDetailProduct.do?prdtNum=${spPrdtInfo.prdtNum}&prdtDiv=${spPrdtInfo.prdtDiv}'/>" target="_blank">상세보기</a></span></div>
									<div class="btn_sty06"><span><a href="javascript:fn_viewProductAppr('${spPrdtInfo.prdtNum}');">승인관리</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_LoginMas('${spPrdtInfo.corpId}');">업체페이지</a></span></div>
								</td> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty02">
						<a href="javascript:fn_SaveExcel()">엑셀저장</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_ProductAppr" class="lay_popup lay_ct"  style="display:none;">
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>