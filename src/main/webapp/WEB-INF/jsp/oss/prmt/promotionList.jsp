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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/promotionList.do'/>";
	document.frm.submit();
}

function fn_clearProductAppr() {
	$("#CM_CONFHISTVO input[name=prdtNum]").val('');
	$("#CM_CONFHISTVO input[name=msg]").val('');
	$("#span_divProductAppr_corpNm").html('');
	$("#span_divProductAppr_prdtNm").html('');
	$("#CM_CONFHISTVO select[name=tradeStatus] option:first").attr("selected", "selected");
}

function fn_viewPromotionAppr(prmtNum, corpNm, prmtNm, statusCd) {
	fn_clearProductAppr();

	$("#CM_CONFHISTVO input[name=linkNum]").val(prmtNum);
	$("#CM_CONFHISTVO select[name=tradeStatus]").val(statusCd);

	if($("#CM_CONFHISTVO select[name=tradeStatus]").val() == null) {
		$("#CM_CONFHISTVO select[name=tradeStatus]").val("${Constant.TRADE_STATUS_APPR}");
	}
	$("#span_divProductAppr_corpNm").html(corpNm);
	$("#span_divProductAppr_prdtNm").html(prmtNm);

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/viewPrmtAppr.ajax'/>",
		data:"prmtNum=" + prmtNum ,
		success:function(data){
			$("#msg").val(data.msg);
			show_popup($("#div_spProductAppr"));
		},
		error : fn_AjaxError
	});
}

function fn_InsertPromotionAppr() {
	document.CM_CONFHISTVO.action = "<c:url value='/oss/promotionAppr.do'/>";
	document.CM_CONFHISTVO.submit();
}

function fn_LoginMasPrmt(corpId, prmtNum){
	var parameters = "corpId=" + corpId;

	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"/oss/masLogin.ajax",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				//window.open("/mas/home.do", '_blank');
				window.open("/mas/prmt/viewUpdatePromotion.do?prmtNum="+prmtNum, '_blank');
			}else{
				alert("업체 로그인에 실패하였습니다.");
			}
		}
	});
}

$(function() {
	$("#sStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sEndDt").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#sEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});

	$("#sConfRequestStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfRequestEndDt").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#sConfRequestEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfRequestStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=prmt" />
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="prmtNum" name="prmtNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>

				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="85" />
										<col width="300" />
										<col width="85" />
										<col width="300" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">처리상태</th>
											<td colspan="3">
												<input type="radio" name="sTradeStatus" value=""   <c:if test='${empty searchVO.sTradeStatus}'>checked</c:if>> 전체</input>&nbsp;
												<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REQ}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REQ}'>checked</c:if>> 승인요청</input>&nbsp;
												<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR}'>checked</c:if>> 승인</input>&nbsp;
												<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REJECT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REJECT}'>checked</c:if>> 승인거절</input>&nbsp;
												<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_EDIT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_EDIT}'>checked</c:if>> 수정요청</input>&nbsp;
												<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_STOP}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_STOP}'>checked</c:if>> 판매중지</input>&nbsp;
											</td>
										</tr>
										<tr>
											<th scope="row">신청일</th>
											<td>
												<input type="text" id="sConfRequestStartDt" class="input_text5 center" name="sConfRequestStartDt" value="${searchVO.sConfRequestStartDt}" title="신청시작일" />
												~ <input type="text" id="sConfRequestEndDt" class="input_text5 center" name="sConfRequestEndDt" title="신청종료일" value="${searchVO.sConfRequestEndDt}"/>
											</td>
											<th scope="row">적용일</th>
											<td>
												<input type="text" id="sStartDt" class="input_text5 center" name="sStartDt" value="${searchVO.sStartDt}" title="적용시작일" />
												~ <input type="text" id="sEndDt" class="input_text5 center" name="sEndDt" value="${searchVO.sEndDt}" title="적용종료일" />
											</td>
										</tr>
										<tr>
											<th scope="row">업체명</th>
											<td><input type="text" id="sCorpNm" name="sCorpNm" class="input_text20" value="${searchVO.sCorpNm}"/></td>
											<th scope="row">프로모션명</th>
											<td><input type="text" id="sPrmtNm" name="sPrmtNm" class="input_text20" value="${searchVO.sPrmtNm}"/></td>
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>번호</th>
									<th>업체명</th>
									<th>구분</th>
									<th>프로모션명</th>
									<th>상태</th>
									<th>적용기간</th>
									<th>요청일</th>
									<th>처리일</th>
									<th>기능틀</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="SQUOT">'</c:set>
								<c:set var="DQUOT">"</c:set>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="9" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="align_ct">${result.prmtNum}</td>
										<td class="align_ct"><a href="javascript:fn_layerDetailCorp('${result.corpId}');">${result.corpNm}</a></td>
										<td class="align_ct">${result.prmtDivNm}</td>
										<td>${result.prmtNm}</td>
										<td class="align_ct">
											<c:if test="${result.statusCd eq Constant.TRADE_STATUS_REG}">등록중</c:if>
											<c:if test="${result.statusCd eq Constant.TRADE_STATUS_APPR_REQ}">승인요청</c:if>
											<c:if test="${result.statusCd eq Constant.TRADE_STATUS_APPR}">승인</c:if>
											<c:if test="${result.statusCd eq Constant.TRADE_STATUS_APPR_REJECT}">승인거절</c:if>
											<c:if test="${result.statusCd eq Constant.TRADE_STATUS_EDIT}">수정요청</c:if>
											<c:if test="${result.statusCd eq Constant.TRADE_STATUS_STOP}">판매중지</c:if>
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${result.startDt}" var="startDt" pattern="yyyyMMdd"/>
											<fmt:parseDate value="${result.endDt}" var="endDt" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd"/>
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${result.confRequestDttm}" var="confRequestDttm" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${confRequestDttm}" pattern="yyyy-MM-dd"/>
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${result.confDttm}" var="confDttm" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${confDttm}" pattern="yyyy-MM-dd"/>
										</td>
										<td class="align_ct">
											<%-- <div class="btn_sty06"><span><a href="<c:url value='/oss/preview/detailPromotion.do?prmtNum=${promotion.prmtNum}'/>" target="_blank">상세보기</a></span></div> --%>
											<c:set var="prdtName" value="${fn:replace(fn:replace(result.prmtNm, SQUOT, '’'), DQUOT, '’')}"/>
											<div class="btn_sty06"><span><a href="javascript:fn_viewPromotionAppr('${result.prmtNum}','${result.corpNm}', '${prdtName}', '${result.statusCd}');">승인관리</a></span></div>
											<div class="btn_sty09"><span><a href="javascript:fn_LoginMasPrmt('${result.corpId}','${result.prmtNum}' );">업체관리자</a></span></div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_spProductAppr" class="lay_popup lay_ct"  style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_spProductAppr'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a></span>
	<ul class="form_area">
		<li>
           	<form:form commandName="CM_CONFHISTVO"  name="CM_CONFHISTVO" method="post">
				<input type="hidden" name="linkNum" />

				<h5 class="title06">프로모션 승인</h5>
				<table border="1" cellpadding="0" cellspacing="0" class="table02">
					<colgroup>
						 <col width="125" />
						 <col width="*" />
					</colgroup>
					<tr>
						<th>업체명</th>
						<td><span id="span_divProductAppr_corpNm"></span></td>
					</tr>
					<tr>
						<th>프로모션명</th>
						<td><span id="span_divProductAppr_prdtNm"></span></td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<form:select path="tradeStatus">
								<option value="${Constant.TRADE_STATUS_APPR }">승인</option>
								<option value="${Constant.TRADE_STATUS_APPR_REJECT }">승인거절</option>
								<option value="${Constant.TRADE_STATUS_EDIT }">수정요청</option>
								<option value="${Constant.TRADE_STATUS_STOP }">판매중지</option>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>전달사항</th>
						<td><textarea name="msg" id="msg" rows="10"  style="width:97%"></textarea></td>
					</tr>
				</table>
			</form:form>
		</li>
	</ul>
	<div class="btn_ct01"><span class="btn_sty04"><a href="javascript:fn_InsertPromotionAppr();">적용</a></span></div>
</div>

</body>
</html>