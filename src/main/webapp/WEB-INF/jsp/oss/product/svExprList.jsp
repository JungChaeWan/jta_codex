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
	document.frm.pageIndex.value = 1;
	document.frm.action = "<c:url value='/oss/svPrdtList.do'/>";
	document.frm.submit();
}

function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/svExprProductList.do'/>";
	document.frm.submit();
}

function fn_viewProductAppr(prdtNum) {
	$.ajax({
		type:"post",
		url:"<c:url value='/oss/viewPrdtAppr.ajax'/>",
		data:"linkNum=" + prdtNum,
		success:function(data){
			$("#div_ProductAppr").html(data);
			show_popup($("#div_ProductAppr"));
		},
		error:fn_AjaxError
	});
}

function fn_InsertProductAppr() {
	if($("#superbSvYn").is(":checked")) {
		$("#superbSvYn").val("Y");
	}
	if($("#jqYn").is(":checked")) {
		$("#jqYn").val("Y");
	}
	var parameter = $("#CM_CONFHISTVO").serialize();

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/productAppr.ajax'/>",
		data:parameter,
		success:function(data){
			fn_Search($("#pageIndex").val());
		},
		error:fn_AjaxError
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
				window.open("/mas/sv/productList.do?sPrdtNm="+ prdtNm, '_blank');
			}else{
				alert("업체 로그인에 실패했습니다.");
			}
		}
	});
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/svExprListExcel.do?"+ parameters +"'/>";
}
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=sv" flush="false"></jsp:include>
		<div id="contents_area">
			<form id="frm" name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${svListSearchVO.pageIndex}"/>
				<input type="hidden" name="sTradeStatus" id="sTradeStatus" value="${svListSearchVO.sTradeStatus}" />
				<input type="hidden" id="sConfRequestStartDt" name="sConfRequestStartDt" value="${svListSearchVO.sConfRequestStartDt}" />
				<input type="hidden" id="sConfRequestEndDt" name="sConfRequestEndDt" value="${svListSearchVO.sConfRequestEndDt}"/>
				<input type="hidden" id="sSaleStartDt" name="sSaleStartDt" value="${svListSearchVO.sSaleStartDt}" />
				<input type="hidden" id="sSaleEndDt" name="sSaleEndDt"  value="${svListSearchVO.sSaleEndDt}" />
				<input type="hidden"" id="sCorpNm" name="sCorpNm" value="${svListSearchVO.sCorpNm}"/>
				<input type="hidden" id="sPrdtNm" name="sPrdtNm" value="${svListSearchVO.sPrdtNm}"/>
				<input type="hidden" id="sCtgr" name="sCtgr" value="${svListSearchVO.sCtgr}" />
				<input type="hidden" id="sSubCtgr" name="sSubCtgr" value="${svListSearchVO.sSubCtgr}" />
			</form>
		<div id="contents">	
       										
                 	
               	 <p class="search_list_ps title-btn">기간만료예정 상품목록[총 <strong><fmt:formatNumber value="${totalCnt}" type="number" /></strong>건]
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
							<th>판매기간</th>
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
						<c:forEach var="svPrdtInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct"><c:out value="${svPrdtInfo.prdtNum}"/></td>
								<td class="align_ct">
									<c:if test="${Constant.TRADE_STATUS_REG eq svPrdtInfo.tradeStatus}">
										등록중
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq svPrdtInfo.tradeStatus}">
										승인요청
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR eq svPrdtInfo.tradeStatus}">
										승인
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq svPrdtInfo.tradeStatus}">
										승인거절
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_STOP eq svPrdtInfo.tradeStatus}">
										판매중지
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_EDIT eq svPrdtInfo.tradeStatus}">
										수정요청
									</c:if>
								</td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_viewProductAppr('${svPrdtInfo.prdtNum}');">승인관리</a></span></div>
								</td>
								<td class="align_ct">${svPrdtInfo.ctgrNm}</td>
								<td class="align_ct"><a href="javascript:fn_layerDetailCorp('${svPrdtInfo.corpId}');"><c:out value="${svPrdtInfo.corpNm}" /></a>
									&nbsp;<div class="btn_sty06"><a href="javascript:fn_LoginMas('${svPrdtInfo.corpId}','${svPrdtInfo.prdtNm}');">이동</a></div>
								</td>
								<td class="align_ct"><c:out value="${svPrdtInfo.prdtNm}" /></td>
								<td class="align_ct">
									<fmt:parseDate value="${svPrdtInfo.saleStartDt}" var="saleStartDt" pattern="yyyyMMdd"/>
									<fmt:parseDate value="${svPrdtInfo.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<fmt:parseDate value="${svPrdtInfo.confRequestDttm}" var="confRequestDttm" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${confRequestDttm}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<fmt:parseDate value="${svPrdtInfo.confDttm}" var="confDttm" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${confDttm}" pattern="yyyy-MM-dd"/>
								</td>
								<%-- <td class="align_ct">
									<div class="btn_sty08"><span><a href="<c:url value='/oss/preview/spDetailProduct.do?prdtNum=${svPrdtInfo.prdtNum}&prdtDiv=${svPrdtInfo.prdtDiv}'/>" target="_blank">상세보기</a></span></div>
									<div class="btn_sty06"><span><a href="javascript:fn_viewProductAppr('${svPrdtInfo.prdtNum}');">승인관리</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_LoginMas('${svPrdtInfo.corpId}');">업체페이지</a></span></div>
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