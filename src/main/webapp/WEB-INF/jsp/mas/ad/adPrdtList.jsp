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

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/ad/productList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/mas/ad/viewInsertPrdt.do'/>";
	document.frm.submit();
}

function fn_Dtl(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/detailPrdt.do'/>";
	document.frm.submit();
}

function fn_PrdtImg(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/imgList.do'/>";
	document.frm.submit();
}

function fn_Amt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/amtList.do'/>";
	document.frm.submit();
}

function fn_Ctn(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/continueNight.do'/>";
	document.frm.submit();
}

function fn_Cnt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/ad/cntList.do'/>";
	document.frm.submit();
}

function fn_AddAmt(prdtNum){
	$("#prdtNum").val(prdtNum);
    $("#pageIndex").val(1);

	console.log($("#prdtNum").val());

	document.frm.action = "<c:url value='/mas/ad/adAddamtPrdtList.do'/>";
	document.frm.submit();
}

function fn_PrdtDel(prdtNum, viewSn){
	$.ajax({
		url : "<c:url value='/mas/ad/checkExsistPrdt.ajax'/>",
		dataType:"json",
		data : "sPrdtNum=" + prdtNum,
		success: function(data) {
			if(data.chkInt > 0){
				alert("판매되었던 상품은 삭제할 수 없습니다.");
				return;
			}else{
				if(confirm("<spring:message code='common.delete.msg'/>")){
					$("#viewSn").val(viewSn);
					$("#prdtNum").val(prdtNum);
					document.frm.action = "<c:url value='/mas/ad/deletePrdt.do' />";
					document.frm.submit();
				}
			}
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});

}

function fn_viewProduct(prdtNum){
	//alert(prdtNum);
	//var code = prdtNum.substring(0,2);
	window.open("<c:url value='/mas/preview/adPrdt.do'/>?sPrdtNum="+prdtNum, '_blank');
}

$(document).ready(function(){
	if('${errorCode}' == '1'){
		alert("숙소 정보 먼저 등록 하세요.");
		//history.back();
		document.frm.action = "<c:url value='/mas/ad/adInfo.do' />";
		document.frm.submit();

	}
	setTimeout(function() {  
		checkAmtCnt();	
	}, 1000)
});

function checkAmtCnt(){
	${data.cntAplDt}
	<c:set var="diffCnt" value="0" />

	<c:forEach var="data" items="${resultList}" varStatus="status">
		<c:if test="${data.tradeStatus eq 'TS03'}">
			<c:if test="${data.cntAplDt ne data.amtAplDt}">
			  <c:set var="diffCnt" value="${diffCnt + 1 }"/>
			</c:if>
		</c:if>
	</c:forEach>

	if("${diffCnt}" > 0 && sessionStorage.getItem("openKey") != "N" ){
		alert("요금만료일과 수량만료일이 일치하지않습니다. 판매를 원하시는 날짜에 요금과 수량을 입력하셔야 상품이 노출됩니다. ");
		sessionStorage.setItem("openKey", "N");
	}
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="corpId" name="corpId" value="${corpId}"/>
				<input type="hidden" id="prdtNum" name="prdtNum" />
				<input type="hidden" id="viewSn" name="viewSn" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<h4 class="title03">객실관리</h4>
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="55" />
										<col width="*" />
										<col width="100" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">상&nbsp;품&nbsp;명</th>
											<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
											<th scope="row">거래상태</th>
											<td>
												<select name="sTradeStatus">
													<option value="">전체</option>
													<c:forEach items="${tsCd}" var="code" varStatus="status">
														<option value="${code.cdNum}" <c:if test="${code.cdNum eq searchVO.sTradeStatus}">selected="selected"</c:if>>${code.cdNm}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search(${searchVO.pageIndex})" />
							</span>
						</div>
					</div>
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>상품번호</th>
								<th>명칭</th>
								<!-- <th>거래상태</th> -->
								<th>기준인원(최대)</th>
								<th>조식포함</th>
								<!-- <th>출력</th> -->
								<th>노출순번</th>
								<th>상태</th>
								<th>연박 할인</th>
								<th class="font_red">요금만료일</th>
								<th class="font_red">수량만료일</th>
								<th width="550"></th>
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

							<c:forEach var="data" items="${resultList}" varStatus="status">
								<tr>
									<td class="align_ct">${data.prdtNum}</td>
									<td class="align_ct">${data.prdtNm}</td>
									<td class="align_ct">${data.stdMem}(${data.maxiMem})</td>
									<td class="align_ct">${data.breakfastYn}</td>
									<%-- <td class="align_ct">${data.printYn}</td> --%>
									<td class="align_ct">${data.viewSn}</td>
									<td class="align_ct">
										<c:choose>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_REG}">등록</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_APPR_REQ}">승인요청</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_APPR}">승인</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_APPR_REJECT}">판매거절</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_STOP}">판매중지</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_EDIT}">수정요청</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_REJECT}">거래중지</c:when>
											<c:when test="${data.tradeStatus==Constant.TRADE_STATUS_STOP_REQ}">판매중지요청</c:when>
											<c:otherwise>알수없음</c:otherwise>
										</c:choose>
									</td>
									<td class="align_ct">
										<c:if test="${data.ctnAplYn eq Constant.FLAG_Y}">적용</c:if>
										<c:if test="${data.ctnAplYn eq Constant.FLAG_N}">미적용</c:if>
									</td>
									<fmt:parseDate value='${data.amtAplDt}' var='amtAplDt' pattern="yyyymmdd"/>
									<c:choose>
										<c:when test="${data.amtAplDt ne data.cntAplDt and data.tradeStatus eq 'TS03' }">
											<td class="align_ct font_red"><fmt:formatDate value="${amtAplDt}" pattern="yyyy-mm-dd"/></td>
										</c:when>
										<c:otherwise>
											<td class="align_ct"><fmt:formatDate value="${amtAplDt}" pattern="yyyy-mm-dd"/></td>
										</c:otherwise>
									</c:choose>
									<fmt:parseDate value='${data.cntAplDt}' var='cntAplDt' pattern="yyyymmdd"/>
									<c:choose>
										<c:when test="${data.amtAplDt ne data.cntAplDt and data.tradeStatus eq 'TS03' }">
											<td class="align_ct font_red"><fmt:formatDate value="${cntAplDt}" pattern="yyyy-mm-dd"/></td>
										</c:when>
										<c:otherwise>
											<td class="align_ct"><fmt:formatDate value="${cntAplDt}" pattern="yyyy-mm-dd"/></td>
										</c:otherwise>
									</c:choose>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="javascript:fn_Dtl('${data.prdtNum}')">상세</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_Amt('${data.prdtNum}')">요금관리</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_Cnt('${data.prdtNum}')">수량관리</a></span></div>
										<c:if test="${data.ctnAplYn eq Constant.FLAG_Y}">
											<div class="btn_sty06"><span><a href="javascript:fn_Ctn('${data.prdtNum}')">연박 요금관리</a></span></div>
										</c:if>
										<!-- <div class="btn_sty06"><span><a href="javascript:fn_Cnt('${data.prdtNum}')">수량관리</a></span></div> -->
										<div class="btn_sty06"><span><a href="javascript:fn_PrdtImg('${data.prdtNum}')">이미지관리</a></span></div>
										<c:if test="${data.tradeStatus==Constant.TRADE_STATUS_REG || data.tradeStatus==Constant.TRADE_STATUS_APPR_REQ}">
											<div class="btn_sty09"><span><a href="javascript:fn_PrdtDel('${data.prdtNum}', '${data.viewSn}')">삭제</a></span></div>
										</c:if>
										<div class="btn_sty06"><span><a href="javascript:fn_AddAmt('${data.prdtNum}');">인원추가요금</a></span></div>
										<div class="btn_sty06"><span><a href="javascript:fn_viewProduct('${data.prdtNum}');">미리보기</a></span></div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
					<ul class="btn_rt01">
						<li class="btn_sty01">
							<a href="javascript:fn_Ins()">등록</a>
						</li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>