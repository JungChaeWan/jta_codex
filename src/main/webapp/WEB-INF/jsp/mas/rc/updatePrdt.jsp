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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<un:useConstants var="Constant" className="common.Constant" />

<validator:javascript formName="RC_PRDTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_FindCardiv() {
	window.open("<c:url value='/mas/rc/findCardiv.do'/>","findUser", "width=800, height=600, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectCardiv(rcCardivNum, prdtNm, cardivExp, maxiNum, makerDiv, carDiv, useFuelDiv) {
	$("#rcCardivNum").val(rcCardivNum);
	$("#prdtNm").val(prdtNm);
	$("#maxiNum").val(maxiNum);
	$("#makerDiv").val(makerDiv);
	$("#carDiv").val(carDiv);
	$("#useFuelDiv").val(useFuelDiv);

	$("#prdtNmDp").text(prdtNm);
	$("#cardivExp").text(cardivExp);
}

function fn_UdtPrdt(){
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
		$("#generalIsrAmt").val($("#generalIsrAmt").val().replace(/,/g, ""));
		if($('#generalIsrRewardAmt').val().length > 66){
			alert("일반자차 보상한도 글자 수는 66자 이하로 입력하세요.");
			$('#generalIsrRewardAmt').focus();
			return;
		}
		if($('#generalIsrBurcha').val().length > 300){
			alert("일반자차 고객부담금 글자 수는 300자 이하로 입력하세요.");
			$('#generalIsrBurcha').focus();
			return;
		}
	}
	
	if (isrDiv != 'ID10' || (isrDiv == 'ID10' && isrType.val() == "${Constant.RC_ISR_TYPE_LUX}")) {
		$("#luxyIsrAmt").val($("#luxyIsrAmt").val().replace(/,/g, ""));
		if($('#luxyIsrRewardAmt').val().length > 300){
			alert("고급자차 보상한도 글자 수는 300자 이하로 입력하세요.");
			$('#luxyIsrRewardAmt').focus();
			return;
		}
		if($('#luxyIsrBurcha').val().length > 300){
			alert("고급자차 고객부담금 글자 수는 66자 이하로 입력하세요.");
			$('#luxyIsrBurcha').focus();
			return;
		}
	}
	
	$("#newSn").val($("#viewSn").val());

	document.prdtInf.action = "<c:url value='/mas/rc/updatePrdt.do'/>";
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
		linkMappingIsrNum : $("#linkMappingIsrNum").val(),
	};

	let data2 = {
		corpId : $("#corpId").val(),
		rcCardivNum : $("#rcCardivNum").val()
	};

	if("${corpInf.apiRentDiv}" == "G"){
		$.ajax({
		url: "/mas/rc/apiRcTest.ajax",
		data : data,
		success: function (d) {
				let resultMsg = d.result;
				let saletFee = 0;
				let isrFee = 0;
				if(d.result){
					if(d.model_id){
						resultMsg += "연동구분 : 그림" ;
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
	}else if("${corpInf.apiRentDiv}" == "I"){
		$.ajax({
		url: "/apiIns/carlist_r.ajax",
		data : data,
		success: function (d) {
				let resultMsg = d.R렌트회사;
				if(resultMsg){
					resultMsg += "\n연동구분 : 인스";
					resultMsg += "\n차량명 : " + d.R모델명 + " [차량ID:" + d.R모델번호 + "]" ;
					resultMsg += "\n모델번호 : " + d.R모델번호;
					resultMsg += "\n모델옵션 : " + d.R모델옵션;
					resultMsg += "\n연료타입 : " + d.R연료;
					resultMsg += "\n연식 : " + d.R연식;
					resultMsg += "\n가능연령 : " + d.R가능연령;
					resultMsg += "\n운전경력 : " + d.R운전경력;
					resultMsg += "\n변속기 : " + d.R변속기;
					resultMsg += "\n정원 : " + d.R승차인원;
					resultMsg += "\n구동방식 : " + d.R구동방식;
					console.log(resultMsg);
				}else{
					resultMsg = "차량정보를 찾을 수 없습니다."
				}
				alert(resultMsg);
			},
			error: function (xhr) {
				console.log('실패 - ' + xhr);
			}
		});
	}else if("${corpInf.apiRentDiv}" == "R"){
		$.ajax({
		url: "/apiRib/ribDetail.ajax",
		data : data2,
		success: function (d) {
				let result =  d.resultData;
				let resultMsg = "";
				if(result.linkMappingNum){
					resultMsg += "\n연동구분 : 리본";
					resultMsg += "\n차량명 : " + result.carDivNm+ " [차량ID:" + result.linkMappingNum + "]" ;
					resultMsg += "\n모델번호 : " + result.rcCardivNum;
					resultMsg += "\n연식 : " + result.modelYear;
					resultMsg += "\n가능연령 : " + result.rntQlfctAge;
					resultMsg += "\n운전경력 : " + result.rntQlfctCareer;
					resultMsg += "\n면허종류 : " + result.rntQlfctLicense;
					resultMsg += "\n변속기 : " + result.transDivNm;
					resultMsg += "\n옵션 : " + result.iconCds;
					console.log(resultMsg);
				}else{
					resultMsg = "차량정보를 찾을 수 없습니다."
				}
				alert(resultMsg);
			},
			error: function (xhr) {
				console.log('실패 - ' + xhr);
			}
		});
	}else if("${corpInf.apiRentDiv}" == "O"){
		$.ajax({
		url: "/apiOrc/vehicleModelDetail.ajax",
		data : data,
		success: function (d) {
				let result =  d.resultData;
				console.log(result);
				let resultMsg = "";
				if(result.linkMappingNum){
					resultMsg += "\n연동구분 : 오르카";
					resultMsg += "\n차량명 : " + result.rcNm+ " [차량ID:" + result.linkMappingNum + "]" ;
					resultMsg += "\n연식 : " + result.modelYear;
					resultMsg += "\n가능연령 : " + result.rntQlfctAge;
					resultMsg += "\n운전경력 : " + result.rntQlfctCareer;
					resultMsg += "\n면허종류 : " + result.rntQlfctLicense;
					resultMsg += "\n변속기 : " + result.transDivNm;
					resultMsg += "\n옵션 : " + result.iconCd;
					console.log(resultMsg);
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
}

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
		} else {			
			$('#isrType').hide();
			$('.isrAmtClass').show();
			$('input[name=isrTypeDiv]:checked').prop('checked', false);
			$('.general').removeClass('disabled').attr('readonly', false);
			$('.luxy').removeClass('disabled').attr('readonly', false);
			
			$('.general').each(function() {
				$(this).val($(this).attr('ovalue'));
			});
			
			$('.luxy').each(function() {
				$(this).val($(this).attr('ovalue'));
			});
		}		
	});
	
	// 일반 & 고급 자차 선택 시
	$('input[name=isrTypeDiv]').change(function() {
		var obj = $('input[name=isrTypeDiv]:checked'); 
		if (obj.val() == "${Constant.RC_ISR_TYPE_GEN}") {	// '일반 자차'일 경우
			$('.general').removeClass('disabled').attr('readonly', false);
			$('.luxy').addClass('disabled').attr('readonly', true).val('');
			
			$('.general').each(function() {
				$(this).val($(this).attr('ovalue'));
			});
		} else {
			$('.general').addClass('disabled').attr('readonly', true).val('');
			$('.luxy').removeClass('disabled').attr('readonly', false);
			
			$('.luxy').each(function() {
				$(this).val($(this).attr('ovalue'));
			});
		}
	});
	
	$('#isrDiv').change();
	
	<c:if test="${prdtInf.isrDiv eq 'ID10' }">
		$('input[name=isrTypeDiv]').change();
	</c:if>
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
				<input type="hidden" name="prdtNum" id="prdtNum" value="${prdtInf.prdtNum}" />
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sCarDivCd" value="${searchVO.sCarDivCd}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" name="rcCardivNum" id="rcCardivNum" value="${prdtInf.rcCardivNum}" />
				<input type="hidden" name="sRcCardivNum" value="${searchVO.sRcCardivNum}" />
				<input type="hidden" name="sIsrTypeDiv" value="${searchVO.sIsrTypeDiv}" />
				<input type="hidden" name="prdtExp" value="" />
				<input type="hidden" id="corpId" value="${prdtInf.corpId}" />

				<div id="contents">
					<h2 class="title08"><c:out value="${prdtInf.prdtNm}"/></h2>
					<ul id="menu_depth3">
						<li class="on"><a class="menu_depth3" href="<c:url value='/mas/rc/detailPrdt.do?prdtNum=${prdtInf.prdtNum}'/>">차량정보</a></li>
						<%-- <li><a class="menu_depth3" href="<c:url value='/mas/rc/imgList.do?prdtNum=${prdtInf.prdtNum}'/>">이미지관리</a></li> --%>
						<li><a class="menu_depth3" href="<c:url value='/mas/rc/amtList.do?prdtNum=${prdtInf.prdtNum}'/>">요금관리</a></li>
						<li><a class="menu_depth3" href="<c:url value='/mas/rc/disPerList.do?prdtNum=${prdtInf.prdtNum}'/>">할인율관리</a></li>
					</ul>

					<h4 class="title03">상품 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
					<table class="table02">
						<colgroup>
							<col class="width15" />
							<col class="width30" />
							<col class="width15" />
							<col />
						</colgroup>
						<tr>
							<th>상품번호</th>
							<td><c:out value='${prdtInf.prdtNum}'/></td>
							<th>차종코드</th>
							<td><c:out value='${prdtInf.rcCardivNum}'/></td>
						</tr>
						<tr>
							<th>상품명</th>
							<td>
								<input type="hidden" name="prdtNm" id="prdtNm" value="${prdtInf.prdtNm}" />
								<span id="prdtNmDp"><c:out value='${prdtInf.prdtNm}'/></span>
								<div class="btn_sty04">
									<span><a href="javascript:fn_FindCardiv();" >차종 검색</a></span>
								</div>
								<form:errors path="prdtNm" cssClass="error_text" />
							</td>
							<th>상품설명</th>
							<td>
								<span id="cardivExp">${cardiv.cardivExp}</span>
							</td>
						</tr>
						<tr>
							<th>제조사</th>
							<td>
								<select name="makerDiv" id="makerDiv" class="disabled" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
									<c:forEach var="maker" items="${makerDivCd}" varStatus="status">
										<option value="${maker.cdNum}" <c:if test="${maker.cdNum == prdtInf.makerDiv}">selected="selected"</c:if>>${maker.cdNm}</option>
									</c:forEach>
								</select>
							</td>
							<th>정원</th>
							<td>
								<form:input path="maxiNum" id="maxiNum" value="${prdtInf.maxiNum}" class="input_text2 disabled" readonly="true" />
								<form:errors path="maxiNum" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>차종</th>
							<td>
								<select name="carDiv" id="carDiv" class="disabled" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
									<c:forEach var="car" items="${carDivCd}" varStatus="status">
										<option value="${car.cdNum}" <c:if test="${car.cdNum == prdtInf.carDiv}">selected="selected"</c:if>>${car.cdNm}</option>
									</c:forEach>
								</select>
							</td>
							<th>연료</th>
							<td>
								<select name="useFuelDiv" id="useFuelDiv" class="disabled" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
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
									<input type="text" name="linkMappingNum" id="linkMappingNum" value="${prdtInf.linkMappingNum}" class="input_text5" maxlength="20" />
									<span style="font-size:10px;">해당ID는 API업체로 문의</span>
								</td>
								<th>보험연계 ID<span class="font02">*</span></th>
								<td>
									<input type="text" name="linkMappingIsrNum" id="linkMappingIsrNum" value="${prdtInf.linkMappingIsrNum}" class="input_text5" maxlength="20" />
									<span style="font-size:10px;">해당ID는 API업체로 문의</span>
								</td>
							</tr>
							<c:if test="${corpInf.corpLinkYn eq 'Y' }">
							<tr>
								<th>연동테스트</th>
								<td colspan="3">
									<c:if test="${corpInf.apiRentDiv eq 'G' }">
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
									</c:if>
										<a href="javascript:void(0);" onclick="fn_rcApiTest();">
										<span style="border-radius: 7px;border: 2px solid #b8baba; padding:5px;">
										연동테스트<img src="/images/oss/icon/go_icon01.gif" style="vertical-align:sub;" />
										</span>
										</a>
									</span>
								</td>
							</tr>
							</c:if>
						</c:if>
						<tr>
							<th>변속기</th>
							<td>
								<select name="transDiv" id="transDiv">
									<c:forEach var="trans" items="${transDivCd}" varStatus="status">
										<option value="${trans.cdNum}" <c:if test="${trans.cdNum == prdtInf.transDiv}">selected="selected"</c:if>>${trans.cdNm}</option>
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
								<c:forEach var="icon" items="${iconCdList}" varStatus="status">
									<c:if test="${((status.index % 4) == 0) && (status.index != 0)}">
										<br><br>
									</c:if>
									<label><input type="checkbox" name="iconCd" value="${icon.iconCd}" <c:if test="${icon.checkYn eq 'Y'}">checked</c:if>>${icon.iconCdNm}</label>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>대여조건<span class="font02">*</span></th>
							<td colspan="3">
								<b>나이 - </b>만 <form:input path="rntQlfctAge" class="input_text2" maxlength="2" value="${prdtInf.rntQlfctAge }" />세 이상 |
								<b>운전경력 - </b><form:input path="rntQlfctCareer" class="input_text2" maxlength="2" value="${prdtInf.rntQlfctCareer }" />년 이상 |
								<b>면허종류 - </b><form:input path="rntQlfctLicense" class="input_text2" maxlength="1" value="${prdtInf.rntQlfctLicense }" />종 보통 이상
							</td>
						</tr>
						<tr>
							<th>보험여부<span class="font02">*</span></th>
							<td colspan="3">
								<select id="isrDiv" name="isrDiv" <c:if test="${prdtInf.tradeStatus eq Constant.TRADE_STATUS_APPR}"> disabled="disabled"</c:if>>
									<option value="" <c:if test="${prdtInf.isrDiv == ''}">selected="selected"</c:if>>= 선택 =</option>
								  	<c:forEach var="isrDivCd" items="${isrCd}" varStatus="status">
										<option value="${isrDivCd.cdNum}" <c:if test="${isrDivCd.cdNum == prdtInf.isrDiv}">selected="selected"</c:if>>${isrDivCd.cdNm}</option>
								  	</c:forEach>
								</select>&nbsp;&nbsp;
								<c:if test="${prdtInf.tradeStatus eq Constant.TRADE_STATUS_APPR}">
									<input type="hidden" name="isrDiv" value="${prdtInf.isrDiv }" />
								</c:if>
								<span id="isrType"<c:if test="${prdtInf.isrDiv ne 'ID10' }"> style="display: none;"</c:if>>
									<label><input type="radio" name="isrTypeDiv" id="isrTypeDivG" value='${Constant.RC_ISR_TYPE_GEN}'<c:if test="${prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN }"> checked</c:if> <c:if test="${Constant.TRADE_STATUS_APPR eq prdtInf.tradeStatus }"> disabled="disabled"</c:if>> 일반자차</label>
									<label><input type="radio" name="isrTypeDiv" id="isrTypeDivL" value='${Constant.RC_ISR_TYPE_LUX}'<c:if test="${prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX }"> checked</c:if> <c:if test="${Constant.TRADE_STATUS_APPR eq prdtInf.tradeStatus }"> disabled="disabled"</c:if>> 고급자차</label>
								</span>
								<c:if test="${prdtInf.tradeStatus eq Constant.TRADE_STATUS_APPR}">
									<input type="hidden" name="isrTypeDiv" value="${prdtInf.isrTypeDiv }" />
								</c:if>
							</td>
						</tr>
						<tr>
							<th>일반자차<span class="font02">*</span></th>
							<td colspan="3">
								<p class="isrAmtClass"><b>요금 - </b>1일 <form:input path="generalIsrAmt" class="input_text5 text-right general" value="${prdtInf.generalIsrAmt }" ovalue="${prdtInf.generalIsrAmt }" /> 원</p>
								<p>
									<span><b>나이 - </b>만 <form:input path="generalIsrAge" class="input_text2 general" maxlength="2" value="${prdtInf.generalIsrAge }" ovalue="${prdtInf.generalIsrAge }" />세 이상 |</span>
									<span><b>운전경력 - </b><form:input path="generalIsrCareer" class="input_text2 general" maxlength="2" value="${prdtInf.generalIsrCareer }" ovalue="${prdtInf.generalIsrCareer }" />년 이상 |</span>
									<span><b>보상한도 - </b><form:input path="generalIsrRewardAmt" class="input_text15 general" value="${prdtInf.generalIsrRewardAmt }" ovalue="${prdtInf.generalIsrRewardAmt }" />(예. 300만원, 한도없음 등) |</span>
									<span><b>고객부담금 - </b><form:input path="generalIsrBurcha" class="input_text30 general" value="${prdtInf.generalIsrBurcha }" ovalue="${prdtInf.generalIsrBurcha }" /></span>
								</p>
							</td>
						</tr>
						<tr>
							<th>고급자차<span class="font02">*</span></th>
							<td colspan="3">
								<p class="isrAmtClass"><b>요금 - </b>1일 <form:input path="luxyIsrAmt" class="input_text5 text-right luxy" value="${prdtInf.luxyIsrAmt }" ovalue="${prdtInf.luxyIsrAmt }" /> 원</p>
								<p>
									<span><b>나이 - </b>만 <form:input path="luxyIsrAge" class="input_text2 luxy" maxlength="2" value="${prdtInf.luxyIsrAge }" ovalue="${prdtInf.luxyIsrAge }" />세 이상 | </span>
									<span><b>운전경력 - </b><form:input path="luxyIsrCareer" class="input_text2 luxy" maxlength="2" value="${prdtInf.luxyIsrCareer }" ovalue="${prdtInf.luxyIsrCareer }" />년 이상 | </span>
									<span><b>보상한도 - </b><form:input path="luxyIsrRewardAmt" class="input_text15 luxy" value="${prdtInf.luxyIsrRewardAmt }" ovalue="${prdtInf.luxyIsrRewardAmt }" />(예. 300만원, 한도없음 등) |</span>
									<span><b>고객부담금 - </b><form:input path="luxyIsrBurcha" class="input_text30 luxy" value="${prdtInf.luxyIsrBurcha }" ovalue="${prdtInf.luxyIsrBurcha }" /></span>
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
								<select style="width:70px" name="viewSn" id="viewSn">
									<c:forEach var="cnt" begin="1" end="${totalCnt}">
										<option value="${cnt}" <c:if test="${prdtInf.viewSn == cnt}">selected="selected"</c:if>>${cnt}</option>
									</c:forEach>
								</select>
							</td>
							<input type="hidden" name="newSn" id="newSn" value="0"/>
							<input type="hidden" name="oldSn" id="oldSn" value="${prdtInf.viewSn}"/>
						</tr>
					</table>

					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_UdtPrdt()">저장</a></li>
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