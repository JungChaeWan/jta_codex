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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<un:useConstants var="Constant" className="common.Constant" />

<validator:javascript formName="RC_PRDTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_FindCardiv(){
	window.open("<c:url value='/mas/rc/findCardiv.do'/>","findUser", "width=800, height=600, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectCardiv(rcCardivNum, prdtNm, cardivExp, maxiNum, makerDiv, carDiv, useFuelDiv){
	$("#rcCardivNum").val(rcCardivNum);
	$("#prdtNm").val(prdtNm);
	//$("#prdtExp").val(cardivExp);
	$("#maxiNum").val(maxiNum);
	$("#makerDiv").val(makerDiv);
	$("#carDiv").val(carDiv);	
	$("#useFuelDiv").val(useFuelDiv);

	$("#cardivExp").text(cardivExp);
	$("#prdtNm").show();
}

function fn_InsPrdt(){
	// validation 체크
	if(!validateRC_PRDTINFVO(document.prdtInf)){
		return;
	}

	/* if($('#modelYear').val().length == 0){
		alert("연식을 선택하세요.");
		$('#modelYear').focus();
		return;
	} */
	
	<c:if test="${corpInf.corpLinkYn eq 'Y' }">
		if($('#linkMappingNum').val() == ''){
			alert("실시간 연계 ID를 입력하세요.");
			$('#linkMappingNum').focus();
			return;
		}
	</c:if>
	
	// 주요정보 확인
	var iconCnt = 0;
	$('input[name=iconCd]:checked').each(function() {	
		iconCnt++;
	});

	if (iconCnt == 0) {
		alert("주요정보를 선택하세요.");
		return;
	}
	var isrDiv = $('#isrDiv option:selected').val();
	var isrType = $('input[name=isrTypeDiv]:checked');

	if (isrDiv == 'ID10' && isrType.is(":checked") == false) {
		alert("보험 종류를 선택하세요.");
		return;
	}
	if (isrDiv != 'ID10' || (isrDiv == 'ID10' && isrType.val() == "${Constant.RC_ISR_TYPE_GEN}")) {
		if(isrDiv != 'ID10' && $('#generalIsrAmt').val().length == 0){
			alert("일반자차 요금을 입력하세요.");
			$('#generalIsrAmt').focus();
			return;
		} else {
			$("#generalIsrAmt").val($("#generalIsrAmt").val().replace(/,/g, ""));
		}
		if($('#generalIsrAge').val().length == 0){
			alert("일반자차 나이를 입력하세요.");
			$('#generalIsrAge').focus();
			return;
		}
		if($('#generalIsrCareer').val().length == 0){
			alert("일반자차 운전 경력을 입력하세요.");
			$('#generalIsrCareer').focus();
			return;
		}
		if($('#generalIsrRewardAmt').val().length == 0){
			alert("일반자차 보상한도를 입력하세요.");
			$('#generalIsrRewardAmt').focus();
			return;
		}
		if($('#generalIsrBurcha').val().length == 0){
			alert("일반자차 고객부담금을 입력하세요.");
			$('#generalIsrBurcha').focus();
			return;
		}
		if($('#generalIsrRewardAmt').val().length > 30){
			alert("일반자차 보상한도 글자 수는 30자 이하로 입력하세요.");
			$('#generalIsrRewardAmt').focus();
			return;
		}
		if($('#generalIsrBurcha').val().length > 66){
			alert("일반자차 고객부담금 글자 수는 66자 이하로 입력하세요.");
			$('#generalIsrBurcha').focus();
			return;
		}
	}
	
	if (isrDiv != 'ID10' || (isrDiv == 'ID10' && isrType.val() == "${Constant.RC_ISR_TYPE_LUX}")) {
		if(isrDiv != 'ID10' && $('#luxyIsrAmt').val().length == 0){
			alert("고급자차 요금을 입력하세요.");
			$('#luxyIsrAmt').focus();
			return;
		} else {
			$("#luxyIsrAmt").val($("#luxyIsrAmt").val().replace(/,/g, ""));
		}
		if($('#luxyIsrAge').val().length == 0){
			alert("고급자차 나이를 입력하세요.");
			$('#luxyIsrAge').focus();
			return;
		}
		if($('#luxyIsrCareer').val().length == 0){
			alert("고급자차 운전 경력을 입력하세요.");
			$('#luxyIsrCareer').focus();
			return;
		}
		if($('#luxyIsrRewardAmt').val().length == 0){
			alert("고급자차 보상한도를 입력하세요.");
			$('#luxyIsrRewardAmt').focus();
			return;
		}
		if($('#luxyIsrBurcha').val().length == 0){
			alert("고급자차 고객부담금을 입력하세요.");
			$('#luxyIsrBurcha').focus();
			return;
		}
		if($('#luxyIsrRewardAmt').val().length == 0){
			alert("고급자차 보상한도 글자 수는 30자 이하로 입력하세요.");
			$('#luxyIsrRewardAmt').focus();
			return;
		}
		if($('#luxyIsrBurcha').val().length == 0){
			alert("고급자차 고객부담금 글자 수는 66자 이하로 입력하세요.");
			$('#luxyIsrBurcha').focus();
			return;
		}
	}
	document.prdtInf.action = "<c:url value='/mas/rc/insertPrdt.do'/>";
	document.prdtInf.submit();
}
/**
 * 목록
 */
function fn_ListPrdt(){
	document.prdtInf.action = "<c:url value='/mas/rc/productList.do'/>";
	document.prdtInf.submit();
}

function fn_rcApiTest(){
	let st = $("#apiStartDt").val() + $("#apiStartTm").val() + "00";
	let et = $("#apiEndDt").val() + $("#apiEndTm").val() + "00";

	let data = {
		st : st,
		et : et,
		corpId : $("#corpId").val(),
		linkMappingNum : $("#linkMappingNum").val(),
		linkMappingIsrNum : $("#linkMappingIsrNum").val()
	};
	$.ajax({
		url: "/mas/rc/apiRcTest.ajax",
		data : data,
		success: function (d) {
				let resultMsg = d.result;
				let saletFee = 0;
				let isrFee = 0;
				if(d.result){
					if(d.model_id){
						resultMsg += "\n차량명 : " + d.model_name + " [차량ID:" + d.model_id + "]" ;
						resultMsg += "\n정   가 : " + commaNum(d.model_defaultfee);
						resultMsg += "\n대여료 : " + commaNum(d.model_salefee);
						resultMsg += "\n할인율 : " + d.model_rate + "%";
						if($("#linkMappingIsrNum").val()){
							resultMsg += "\n보험명 : " + d.insurance_name + " [보험ID:" + d.insurance_id + "]" ;
							resultMsg += "\n보험료 : " + commaNum(d.insurance_salefee);
						}
						if(d.model_salefee){
							saletFee = d.model_salefee;
						}
						if(d.insurance_salefee){
							isrFee = d.insurance_salefee;
						}
						resultMsg += "\n\n탐나오 판매가 : " + commaNum(Number(saletFee) + Number(isrFee));
					}
				}else{
					resultMsg = "차량정보를 찾을 수 없습니다."
				}
				alert(resultMsg);
		},
		error: function (xhr) {
			console.log('실패 - ' + xhr);
		}
	});
}

/**
 * file init
 */
/* function makeFileAttachment(){
	 var maxFileNum = 5;
	 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
} */

$(document).ready(function(){
	let apiDate = new Date();
	apiDate.setDate(apiDate.getDate() + 1);

	$("#apiStartDt").datepicker({
		dateFormat : "yymmdd",
		onClose : function(selectedDate) {
			$("#apiEndDt").datepicker("option", "minDate", selectedDate);
		}
	}).datepicker("setDate", apiDate );

	apiDate.setDate(apiDate.getDate() + 1);
	$("#apiEndDt").datepicker({
		dateFormat : "yymmdd",
		onClose : function(selectedDate) {
			$("#apiStartDt").datepicker("option", "maxDate", selectedDate);
		}
	}).datepicker("setDate", apiDate );
	
	// 보험여부 선택 시
	$('#isrDiv').change(function() {
		if ($(this).val() == 'ID10') {	// 자차포함 이면
			$('#isrType').show();
			$('.isrAmtClass').hide();

			$("#isrTypeDivG").prop("checked", true);
			$('input[name=isrTypeDiv]').change();
		} else {			
			$('#isrType').hide();
			$('.isrAmtClass').show();
			$('input[name=isrTypeDiv]:checked').prop('checked', false);
			$('.general').removeClass('disabled').attr('readonly', false);
			$('.luxy').removeClass('disabled').attr('readonly', false);
		}		
	});
	
	// 일반 & 고급 자차 선택 시
	$('input[name=isrTypeDiv]').change(function() {
		var obj = $('input[name=isrTypeDiv]:checked'); 
		if (obj.val() == "${Constant.RC_ISR_TYPE_GEN}") {	// '일반 자차'일 경우
			$('.general').removeClass('disabled').attr('readonly', false);
			$('.luxy').addClass('disabled').attr('readonly', true);
		} else {
			$('.general').addClass('disabled').attr('readonly', true);
			$('.luxy').removeClass('disabled').attr('readonly', false);
		}
	});
	
	$('#isrDiv').change();
	$('input[name=isrTypeDiv]').change();

	$("#prdtNm").hide();
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
			<form:form commandName="RC_PRDTINFVO" name="prdtInf" method="post" enctype="multipart/form-data">
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sCarDivCd" value="${searchVO.sCarDivCd}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" name="rcCardivNum" id="rcCardivNum" value="${prdtInf.rcCardivNum}" />
				<input type="hidden" name="prdtExp" value="" />

				<div id="contents">
					<h4 class="title03">상품 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="400" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>상품명<span class="font02">*</span></th>
							<td>
								<form:input path="prdtNm" id="prdtNm" value="${prdtInf.prdtNm}" class="input_text20" readonly="true" />
								<div class="btn_sty04">
									<span><a href="javascript:fn_FindCardiv();" >차종검색</a></span>
								</div>
								<form:errors path="prdtNm"  cssClass="error_text" />
							</td>
							<th>상품설명</th>
							<td>
								<span id="cardivExp"></span>
							</td>
						</tr>
						<tr>
							<th>제조사</th>
							<td>
								<select id="makerDiv" name="makerDiv" class="disabled" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;' >
									<option value="">=제조사 선택=</option>
									<c:forEach var="maker" items="${makerDivCd}" varStatus="status">
										<option value="${maker.cdNum}" <c:if test="${maker.cdNum == prdtInf.makerDiv}">selected="selected"</c:if>>${maker.cdNm}</option>
									</c:forEach>
								</select>
							</td>
							<th>정원</th>
							<td>
								<form:input path="maxiNum" id="maxiNum" value="${prdtInf.maxiNum}" class="input_text2 disabled" readonly="true" />
								<form:errors path="maxiNum"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>차종</th>
							<td>
								<select id="carDiv" name="carDiv" class="disabled" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
										<option value="">=차종 선택=</option>
									<c:forEach var="car" items="${carDivCd}" varStatus="status">
										<option value="${car.cdNum}" <c:if test="${car.cdNum == prdtInf.carDiv}">selected="selected"</c:if>>${car.cdNm}</option>
									</c:forEach>
								</select>
							</td>
							<th>연료</th>
							<td>
								<select id="useFuelDiv" name="useFuelDiv" class="disabled" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
										<option value="">=연료 선택=</option>
									<c:forEach var="fuel" items="${fuelCd}" varStatus="status">
										<option value="${fuel.cdNum}" <c:if test="${fuel.cdNum == prdtInf.useFuelDiv}">selected="selected"</c:if>>${fuel.cdNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<c:if test="${corpInf.corpLinkYn eq 'Y' }">
							<tr>
								<th>차량연계 ID<span class="font02">*</span></th>
								<td>
									<input type="text" name="linkMappingNum" id="linkMappingNum" class="input_text5" maxlength="20" />
									<span style="font-size:10px;">해당ID는 API업체로 문의</span>
								</td>
								<th>보험연계 ID<span class="font02">*</span></th>
								<td>
									<input type="text" name="linkMappingIsrNum" id="linkMappingIsrNum" class="input_text5" maxlength="20" />
									<span style="font-size:10px;">해당ID는 API업체로 문의</span>
								</td>
							</tr>
							<tr>
							<th>연계테스트</th>
							<td colspan="3">
								<span>
								<input type="text" id="apiStartDt" class="input_text4 center" name="apiStartDt" value=""  style="margin-bottom:2px;height:21px;" /> 대여시작일
								<select style="width:50px" name="apiStartTm" id="apiStartTm">
								<c:forEach var="tm" begin="8" end="20" >
									<c:if test='${tm < 10}'>
										<c:set var="tm_v" value="0${tm}" />
										<c:set var="tm_t" value="0${tm}" />
									</c:if>
									<c:if test='${tm > 9}'>
										<c:set var="tm_v" value="${tm}" />
										<c:set var="tm_t" value="${tm}" />
									</c:if>
									<option value="${tm_v}" <c:if test='${tm eq 12}'> selected </c:if>>${tm_t}</option>
								</c:forEach>
								</select>시간
								</span>~
								<span>
								<input type="text" id="apiEndDt" class="input_text4 center" name="apiEndDt"  title="요청종료일" value="" style="margin-bottom:2px;height:21px;"/> 대여종료일
								<select style="width:50px" name="apiEndTm" id="apiEndTm">
								<c:forEach var="tm" begin="8" end="20" >
									<c:if test='${tm < 10}'>
										<c:set var="tm_v" value="0${tm}" />
										<c:set var="tm_t" value="0${tm}" />
									</c:if>
									<c:if test='${tm > 9}'>
										<c:set var="tm_v" value="${tm}" />
										<c:set var="tm_t" value="${tm}" />
									</c:if>
									<option value="${tm_v}" <c:if test='${tm eq 12}'> selected </c:if>>${tm_t}</option>
								</c:forEach>
								</select>시간
									<a href="javascript:void(0);" onclick="fn_rcApiTest();">
									<span style="border-radius: 7px;border: 2px solid #b8baba; padding:5px;">
									연계테스트<img src="/images/oss/icon/go_icon01.gif" style="vertical-align:sub;" />
									</span>
									</a>
								</span>
							</td>
						</tr>
						</c:if>
						<tr>
							<th>변속기</th>
							<td>
								<select name="transDiv" id="transDiv">
									<c:forEach var="trans" items="${transDivCd}" varStatus="status">
										<option value="${trans.cdNum}">${trans.cdNm}</option>
									</c:forEach>
								</select>
							</td>
							<th>연식<span class="font02">*</span></th>
							<td>
								<select id="modelYear" name="modelYear">
									<option value="">= 선 택 =</option>
									<option value="2016~2017" <c:if test="${prdtInf.modelYear eq '2016~2017'}">selected="selected"</c:if>>2016~17년</option>
									<option value="2017~2018" <c:if test="${prdtInf.modelYear eq '2017~2018'}">selected="selected"</c:if>>2017~18년</option>
									<option value="2018~2019" <c:if test="${prdtInf.modelYear eq '2018~2019'}">selected="selected"</c:if>>2018~19년</option>
									<option value="2019~2020" <c:if test="${prdtInf.modelYear eq '2019~2020'}">selected="selected"</c:if>>2019~20년</option>
									<option value="2020~2021" <c:if test="${prdtInf.modelYear eq '2020~2021'}">selected="selected"</c:if>>2020~21년</option>
									<option value="2021~2022" <c:if test="${prdtInf.modelYear eq '2021~2022'}">selected="selected"</c:if>>2021~22년</option>
									<option value="2022~2023" <c:if test="${prdtInf.modelYear eq '2022~2023'}">selected="selected"</c:if>>2022~23년</option>
									<option value="2023~2024" <c:if test="${prdtInf.modelYear eq '2023~2024'}">selected="selected"</c:if>>2023~24년</option>
									<option value="2024~2025" <c:if test="${prdtInf.modelYear eq '2024~2025'}">selected="selected"</c:if>>2024~25년</option>
									<option value="2025~2026" <c:if test="${prdtInf.modelYear eq '2025~2026'}">selected="selected"</c:if>>2025~26년</option>
								</select>
								<%-- <input type="text" name="modelYear" id="modelYear" value="${prdtInf.modelYear}" class="input_text20" maxlength="20" /> --%>
							</td>
						</tr>
						<tr>
							<th>주요정보<span class="font02">*</span></th>
							<td colspan="3">
								<c:forEach var="icon" items="${iconCd}" varStatus="status">
									<c:if test="${((status.index % 6) == 0) && (status.index != 0)}">
										<br><br>
									</c:if>
									<label><input type="checkbox" name="iconCd" value="${icon.cdNum}">${icon.cdNm}</label>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>대여조건<span class="font02">*</span></th>
							<td colspan="3">
								<span><b>나이 - </b>만 <form:input path="rntQlfctAge" class="input_text2" maxlength="2" />세 이상 |</span>
								<span><b>운전경력 - </b><form:input path="rntQlfctCareer" class="input_text2" maxlength="2" />년 이상 |</span>
								<span><b>면허종류 - </b><form:input path="rntQlfctLicense" class="input_text2" maxlength="1" />종 보통 이상</span>
							</td>
						</tr>
						<tr>
							<th>보험여부<span class="font02">*</span></th>
							<td colspan="3">
								<select id="isrDiv" name="isrDiv">
									<c:forEach var="isrDivCd" items="${isrCd}" varStatus="status">
										<option value="${isrDivCd.cdNum}" <c:if test="${isrDivCd.cdNum == 'ID10'}">selected="selected"</c:if>>${isrDivCd.cdNm}</option>
									</c:forEach>
								</select>&nbsp;&nbsp;
								<span id="isrType">
								  	<label><input type="radio" name="isrTypeDiv" id="isrTypeDivG" value='${Constant.RC_ISR_TYPE_GEN}' checked>일반자차</label>
									<label><input type="radio" name="isrTypeDiv" id="isrTypeDivL" value='${Constant.RC_ISR_TYPE_LUX}'>고급자차</label>
								</span>
							</td>
						</tr>
						<tr>
							<th>일반자차<span class="font02">*</span></th>
							<td colspan="3">
								<p class="isrAmtClass"><b>요금 - </b>1일 <form:input path="generalIsrAmt" class="input_text5 text-right general" /> 원</p>
								<p>
									<span><b>나이 - </b>만 <form:input path="generalIsrAge" class="input_text2 general" maxlength="2" />세 이상 |</span>
									<span><b>운전경력 - </b><form:input path="generalIsrCareer" class="input_text2 general" maxlength="2" />년 이상 |</span>
									<span><b>보상한도 - </b><form:input path="generalIsrRewardAmt" class="input_text15 general" />(예. 300만원, 한도없음 등) |</span>
									<span><b>고객부담금 - </b><form:input path="generalIsrBurcha" class="input_text30 general" /></span>
								</p>
							</td>
						</tr>
						<tr>
							<th>고급자차<span class="font02">*</span></th>
							<td colspan="3">
								<p class="isrAmtClass"><b>요금 - </b>1일 <form:input path="luxyIsrAmt" class="input_text5 text-right luxy" /> 원</p>
								<p>
									<span><b>나이 - </b>만 <form:input path="luxyIsrAge" class="input_text2 luxy" maxlength="2" />세 이상 |</span>
									<span><b>운전경력 - </b><form:input path="luxyIsrCareer" class="input_text2 luxy" maxlength="2" />년 이상 |</span>
									<span><b>보상한도 - </b><form:input path="luxyIsrRewardAmt" class="input_text15 luxy" />(예. 300만원, 한도없음 등) |</span>
									<span><b>고객부담금 - </b><form:input path="luxyIsrBurcha" class="input_text30 luxy" /></span>
								</p>
							</td>
						</tr>
						<tr>
							<th>보험요금안내<span></span></th>
							<td colspan="3">
								<textarea name="isrAmtGuide" id="isrAmtGuide" cols="70" rows="7"><c:out value="${prdtInf.isrAmtGuide}" escapeXml="false" /></textarea>
							</td>
						</tr>
						<tr>
							<th>순번<span class="font02">*</span></th>
							<td colspan="3">
								<select style="width:70px" name="viewSn">
									<c:forEach var="cnt" begin="1" end="${totalCnt + 1}">
										<option value="${cnt}" <c:if test="${(totalCnt + 1) == cnt}">selected="selected"</c:if>>${cnt}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_InsPrdt()">저장</a></li>
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