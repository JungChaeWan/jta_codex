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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>

<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/refundRsvList.do'/>";
	document.frm.submit();
}

function fn_RefundInfo(prdtRsvNum, userId) {
	$("#prdtRsvNum").val(prdtRsvNum);
	$("#userId").val(userId);
	$("#bankNm").val("");
	$("#accNum").val("");
	$("#depositorNm").val("");
	
	var parameters = "sPrdtRsvNum=" + prdtRsvNum;
	parameters += "&sUserId=" + userId;
	parameters += "&firstIndex=" + 0;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/selectByPrdtRsvInfo.ajax'/>",
		data:parameters,
		success:function(data){
			var addHtml = "";
			if(data.refundInfo == null) {
				addHtml = "입력된 환불 계좌 정보가 없습니다.";
			} else {
				addHtml += "<p>은행: " + data.refundInfo.bankNm + "</p>";
				addHtml += "<p>계좌번호: " + data.refundInfo.accNum + "</p>";
				addHtml += "<p>예금주: " + data.refundInfo.depositorNm + "</p>";
				addHtml += "<div class=\"btn_rt01 btn_sty06\"><span><a href=\"javascript:fn_InsertInfo('" + data.refundInfo.bankCode + "', '" + data.refundInfo.accNum + "', '" + data.refundInfo.depositorNm + "')\">정보입력</a></span></div>";
			}
			$("#userAccInfo").html(addHtml);
			
			$("#bankCode").val(data.orderVO.refundBankCode);
			$("#accNum").val(data.orderVO.refundAccNum);
			$("#depositorNm").val(data.orderVO.refundDepositor);

			show_popup($("#lay_popup"));
		},
		error:fn_AjaxError
	});
}

function fn_InsertInfo(bankCode, accNum, depositor) {
	$("#bankCode").val(bankCode);
	$("#accNum").val(accNum);
	$("#depositorNm").val(depositor);
}

function fn_InsRefundInfo() {
	var parameters = "prdtRsvNum=" + $("#prdtRsvNum").val();
	parameters += "&refundBankCode=" + $("#bankCode").val();
	parameters += "&refundAccNum=" + $("#accNum").val();
	parameters += "&refundDepositor=" + $("#depositorNm").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/updateRefundInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			document.frm.action = "<c:url value='/oss/refundRsvList.do'/>";
			document.frm.submit();
		}
	});
}

function fn_RefundOk(rsvNum, prdtRsvNum) {
	if(!confirm("환불 완료 처리하시겠습니까?")) {
		return;
	}
	var parameters = "rsvNum=" + rsvNum;
	parameters += "&prdtRsvNum=" + prdtRsvNum;

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/refundComplete.ajax'/>",
		data:parameters,
		beforeSend:function(){
			if(prdtRsvNum.length == 0){
				alert("선택된 예약 건이 없습니다.");
				return false;
			}
		},
		success:function(data){
			alert("환불 완료가 정상적으로 처리됐습니다.");
			fn_Search('1');
		},
		error:fn_AjaxError
	});
}

function fn_ExcelDown() {
	var parameters = $("#frm").serialize();
	
	frmFileDown.location = "<c:url value='/oss/refundExcelDown1.do' />?"+ parameters;
}

function fn_RefundRsn(prdtCd, prdtRsvNum, refundRsn) {
	if(prdtCd.indexOf("C") == 0) {
		prdtCd = "SP";
	} else if(prdtCd.indexOf("S") == 0) {
		prdtCd = "SV";
	}
	$("#prdtCd").val(prdtCd);
	$("#prdtRsvNum").val(prdtRsvNum);
	$("#refundRsn").val(refundRsn);

	show_popup($("#refundRsnPopup"));
}

function fn_InsRefundRsn() {
	var refundRsn = $("#refundRsn").val().trim();
	if(refundRsn == "") {
		alert("<spring:message code="errors.required2" arguments="사유" />");
	} else {
		var parameters = "prdtCd=" + $("#prdtCd").val();
		parameters += "&prdtRsvNum=" + $("#prdtRsvNum").val();
		parameters += "&refundRsn=" + refundRsn;

		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/oss/updateRefundRsn.ajax'/>",
			data:parameters,
			success:function(data){
				document.frm.action = "<c:url value='/oss/refundRsvList.do'/>";
				document.frm.submit();
			}
		});
	}
}

$(document).ready(function(){

});

</script>
</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=rsv" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=rsv&sub=refund" />

		<div id="contents_area">
			<div id="contents">
				<form name="frm" id="frm" method="post" onSubmit="return false;">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
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
											<th scope="row">예&nbsp;약&nbsp;자</th>
											<td><input type="text" name="sRsvNm" id="sRsvNm" class="input_text13" value="${searchVO.sRsvNm}" title="검색하실 예약자를 입력하세요." maxlength="20" /></td>
											<th scope="row">전화번호</th>
											<td><input type="text" name="sRsvTelnum" id="sRsvTelnum" class="input_text13" value="${searchVO.sRsvTelnum}" title="검색하실 전화번호를 입력하세요." maxlength="13" /></td>
										</tr>
										<tr>
											<th scope="row">결제구분</th>
											<td>
												<input type="checkbox" name="sPayDiv" id="sPayDiv1" value="L100" <c:if test="${fn:contains(searchVO.sPayDiv , 'L100')}">checked="checked"</c:if>>
												<label for="sPayDiv1">카드결제</label>
												<input type="checkbox" name="sPayDiv" id="sPayDiv2" value="L200" <c:if test="${fn:contains(searchVO.sPayDiv , 'L200')}">checked="checked"</c:if>>
												<label for="sPayDiv2">휴대폰결제</label>
												<input type="checkbox" name="sPayDiv" id="sPayDiv3" value="L300" <c:if test="${fn:contains(searchVO.sPayDiv , 'L300')}">checked="checked"</c:if>>
												<label for="sPayDiv3">계좌이체</label>
												<br>
												<input type="checkbox" name="sPayDiv" id="sPayDiv4" value="L700" <c:if test="${fn:contains(searchVO.sPayDiv , 'L700')}">checked="checked"</c:if>>
												<label for="sPayDiv4">무통장입금</label>
												<input type="checkbox" name="sPayDiv" id="sPayDiv5" value="L800" <c:if test="${fn:contains(searchVO.sPayDiv , 'L800')}">checked="checked"</c:if>>
												<label for="sPayDiv5">탐나는전(PC)</label>
												<input type="checkbox" name="sPayDiv" id="sPayDiv6" value="L810" <c:if test="${fn:contains(searchVO.sPayDiv , 'L810')}">checked="checked"</c:if>>
												<label for="sPayDiv6">탐나는전(모바일)</label>
											</td>
											<th scope="row">진행상태</th>
											<td>
												<select name="sRsvDiv" id="sRsvDiv">
													<option value="sRsvDivAll" <c:if test="${searchVO.sRsvDiv eq 'sRsvDivAll'}">selected="selected"</c:if>>전체</option>
													<option value="sRsvDiv1" <c:if test="${searchVO.sRsvDiv eq 'sRsvDiv1'}">selected="selected"</c:if>>환불진행</option>
													<option value="sRsvDiv2" <c:if test="${searchVO.sRsvDiv eq 'sRsvDiv2'}">selected="selected"</c:if>>환불완료</option>
												</select>
											</td>											
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1');" />
							</span>
						</div>
					</div>
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<colgroup>
								<col width="100" />
								<col width="80" />
								<col width="80" />
								<col width="70" />
								<col width="90" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="110" />
								<col width="70" />
								<col width="90" />
								<col width="70" />
								<col width="100" />
								<col width="150" />
							</colgroup>
							<thead>
								<tr>
									<th>예약번호</th>
									<th>예약일</th>
									<th>취소요청일</th>
									<th>예약자명</th>
									<th>전화번호</th>
									<th>판매금액</th>
									<th>환불금액</th>
									<th>결제수단</th>
									<th>비고</th>
									<th>기능툴</th>
									<th>은행</th>
									<th>계좌번호</th>
									<th>예금주</th>
									<th>업체명</th>
									<th>상품정보</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${fn:length(orderList) == 0}">
									<tr>
										<td colspan="15" class="align_ct">
											<spring:message code="common.nodata.msg" />
										</td>
									</tr>
								</c:if>
								<c:forEach var="rsvInfo" items="${orderList}" varStatus="status">
									<tr>
										<td class="align_ct">${rsvInfo.rsvNum}<br>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불진행</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">환불완료</c:if>
										</td>
										<td class="align_ct">${rsvInfo.regDttm}</td>
										<td class="align_ct">${rsvInfo.cancelRequestDttm}</td>
										<td class="align_ct">${rsvInfo.rsvNm}</td>
										<td class="align_ct">${rsvInfo.rsvTelnum}</td>
										<td class="align_rt"><fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber></td>
										<td class="align_rt font_red"><fmt:formatNumber>${rsvInfo.cancelAmt}</fmt:formatNumber></td>
										<td class="align_ct">
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_MI}">무통장입금</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_EMI}">무통장입금(에스크로)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_LI}">L.Point결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_SI}">스마트스토어</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI}">탐나는전<br>(PC)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_MI}">탐나는전<br>(모바일)</c:if>
										</td>
										<td>${rsvInfo.refundRsn}</td>
										<td class="align_ct">
											<div class="btn_sty09"><span><a href="javascript:fn_RefundOk('${rsvInfo.rsvNum}','${rsvInfo.prdtRsvNum}');">환불완료</a></span></div>
											<div class="btn_sty06"><span><a href="javascript:fn_RefundInfo('${rsvInfo.prdtRsvNum}', '${rsvInfo.userId}')">환불계좌관리</a></span></div>
											<div class="btn_sty06"><span><a href="javascript:fn_RefundRsn('${rsvInfo.prdtCd}', '${rsvInfo.prdtRsvNum}', '${rsvInfo.refundRsn}')">비고</a></span></div>
										</td>
										<td class="align_ct">${rsvInfo.refundBankNm}</td>
										<td class="align_ct">${rsvInfo.refundAccNum}</td>
										<td class="align_ct">${rsvInfo.refundDepositor}</td>
										<td class="align_ct">${rsvInfo.corpNm}</td>
										<td><b>${rsvInfo.prdtNm}</b><br>${rsvInfo.prdtInf}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>

				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close">
		<a href="javascript:void(0)" onclick="close_popup($('#lay_popup'));" title="창닫기">
		<img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a>
	</span>
    <form name="refundFrm">
    	<input type="hidden" name="rsvNum" id="rsvNum" />
    	<input type="hidden" name="prdtRsvNum" id="prdtRsvNum" />
    	<input type="hidden" name="gubun" id="gubun" />

		<ul class="form_area">
			<li>
				<table border="1" class="table02">
					<caption class="tb01_title">환불정보관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>사용자환불계좌정보<!-- <span class="font02">*</span> --></th>
						<td id="userAccInfo">
						</td>
					</tr>
					<tr>
						<th>은행</th>
						<td>
							<select name="bankCode" id="bankCode">
								<c:forEach var="code" items="${cdRfac}" varStatus="status">
									<option value="${code.cdNum}" <c:if test="${code.cdNum eq refundAccInf.bankCode}">selected="selected"</c:if>> ${code.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>
							<input type="text" name="accNum" id="accNum" class="input_text20" maxlength="20" />
						</td>
					</tr>
					<tr>
						<th>예금주</th>
						<td>
							<input type="text" name="depositorNm" id="depositorNm" class="input_text20" maxlength="30" />
						</td>
					</tr>
				</table>
			</li>
       </ul>
	</form>

    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_InsRefundInfo()">저장</a></span>
    </div>
</div>

<div id="refundRsnPopup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct-->
	<span class="popup_close">
		<a href="javascript:void(0)" onclick="close_popup($('#refundRsnPopup'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a>
	</span>
	<input type="hidden" name="prdtCd" id="prdtCd" />
	<ul class="form_area">
		<li>
			<table border="1" class="table02">
				<caption class="tb01_title">비고</caption>
				<colgroup>
					<col width="10" />
					<col width="*" />
				</colgroup>
				<tr>
					<th></th>
					<td><input type="text" name="refundRsn" id="refundRsn" class="width100" /></td>
				</tr>
			</table>
		</li>
	</ul>

	<div class="btn_rt01">
		<span class="btn_sty04"><a href="javascript:fn_InsRefundRsn()">저장</a></span>
	</div>
</div>

<iframe name="frmFileDown" style="display:none"></iframe>

</body>
</html>