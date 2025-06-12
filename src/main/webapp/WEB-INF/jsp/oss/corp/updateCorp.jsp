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

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>
<script type="text/javascript" src="<c:url value='/js/toastr.min.js'/>"></script>

<validator:javascript formName="CORPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel='stylesheet' type="text/css" href="<c:url value='/css/common/toastr.min.css'/>"/>

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

<title></title>
<script type="text/javascript">
/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('roadNmAddr').value = data.address;
            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

/**
 * 주소에 따른 경도 위도 구하기
 */
function fn_FindLocation() {
	var addr = $("#roadNmAddr").val();
	
	if(isNull(addr)) {
		alert("주소를 입력해주세요.");
		$("#dtlAddr").focus();
		return;
	}
	var geocoder = new daum.maps.services.Geocoder();

    var callback = function(result, status){
	    if(status == daum.maps.services.Status.OK) {
            var lat = result[0].y
            var lng = result[0].x
	    	
	    	$("#lon").val(lng);
			$("#lat").val(lat);
	    } else {
	    	if(status == daum.maps.services.Status.ZERO_RESULT) {
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	} else if(status == daum.maps.services.Status.RESULT_NOT_FOUND) {
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	} else {
	    		alert("API 응답불가, 관리자에게 문의하세요.");
				return;
	    	}
	    }
	};
    geocoder.addressSearch(addr, callback);
}

function fn_UdtCorp() {
	// 현재 거래 상태가 'TS07'이 아니고, 선택된 값이 'TS07'인 경우 확인
	if ("${corpInfo.tradeStatusCd}" != "TS07" && $("#tradeStatusCd").val() == "TS07") {
		if (!confirm("정말로 거래중지 상태로 변경하시겠습니까?")) {
			return;
		}
	}

	// validation 체크
	if(!validateCORPVO(document.CORPVO)) {
		return;
	}
	if($("#corpLinkYn_chk").is(":checked")) {
		$("#corpLinkYn").val("Y");
	} else {
		$("#corpLinkYn").val("N");
	}
	if($("#corpLinkIsrYn_chk").is(":checked")) {
		$("#corpLinkIsrYn").val("Y");
	} else {
		$("#corpLinkIsrYn").val("N");
	}
	if($("#superbCorpYn_chk").is(":checked")) {
		$("#superbCorpYn").val("Y");
	} else {
		$("#superbCorpYn").val("N");
	}

	document.CORPVO.action = "<c:url value='/oss/updateCorp.do' />";
	document.CORPVO.submit();
}

function fn_FindUser() {
	window.open("<c:url value='/oss/findUser.do'/>","findUser", "width=580, height=600, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectUer(userId, userNm, telNum){
	$("#managerId").val(userId);
	$("#managerNm").val(userNm);
}

// 파일 삭제
function fn_deleteFile(docId, fileNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		var parameters = "docId=" + docId + "&fileNum=" + fileNum;

		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/oss/deleteCorpPnsRequestFile.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.result == "success") {
					alert("<spring:message code='success.common.delete' />");
					$("#divFile" + fileNum).hide();
					$("#divInputFile" + fileNum).show();
				} else {
					alert("<spring:message code='fail.common.delete' />");
				}
			},
			error:fn_AjaxError
		});
	}
}

/**
 * 목록
 */
function fn_ListCorp() {
	document.frm.action = "<c:url value='/oss/corpList.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	$("#corpModCd").change(function(){
		$("#corpCd").val($(this).val().substring(1, 3));
				
		if($("#corpCd").val() == '${Constant.SOCIAL}') {
			$("#posUseYn").css('display', 'inline-block');
		} else {
			$("#posUseYn").css('display', 'none');
		}
	});

	if("${corpInfo.corpCd}" == "${Constant.SOCIAL}") {
		$("#posUseYn").show();
	}
	
	$("#visitNm").bind("keydown", function(event){
		if(event.keyCode == $.ui.keyCode.TAB && $(this).data("ui-autocomplete").menu.active) {
			event.preventDefault();
		}      
	}).autocomplete({
		minLength: 1,
		source: function(request, response) {
			var parameters = "title=" + $('#visitNm').val();
			var visitJEJU = [];

			$.ajax({
				type:"post", 
				dataType:"json",
				async:false,
				url:"<c:url value='/oss/getVisitJeju.ajax'/>",
				data:parameters,
				success:function(data){
					// 코드 배열
					var arrayItem = [];
					jQuery.each(data.visitJejuList, function(index, onerow) {
						if(onerow["contentsid"] != null && onerow["contentsid"] != '') {
							var subStr = onerow["title"] + " [" + onerow["address"] + "]"
							visitJEJU[index] = {label:subStr, value:onerow["contentsid"]};
						}
					});
				
					if(visitJEJU.length == 0) {
						visitJEJU[0] = {label:'데이터가 없습니다.', value:'0000'};
					}
					response(visitJEJU);
				}
			});
		},        
		focus: function() {
			return false;        
		},        
		select: function(event, ui) {
			if (ui.item.value != "0000") {
				this.value = ui.item.label.substring(0, ui.item.label.indexOf("[", 0)).trim();
				$("#visitMappingId").val(ui.item.value);
				$("#visitMappingNm").val(this.value);
			}
			return false;
		}      
	}).blur(function(){			
		var strVal = this.value;
		if(strVal.substr(strVal.length - 1, strVal.length) == ",") {
			strVal = strVal.substr(0, strVal.length - 1);
			this.value = strVal;
		} 
	});
});

function syncRibRentcarInfo(totalInterlock){

	/** totalInterlock {Y : 전체연동, N : 추가연동  */
	let confirmMsg;
	if(totalInterlock == "Y"){
		confirmMsg = "[차량정보모두연동]\r미등록 차량:생성\r등록된 차량:업데이트\r렌터카 상태:등록중\r*진행하시겠습니까?*"
	}else{
		confirmMsg = "[차량정보추가연동]\r미등록 차량:생성\r렌터카 상태:추가등록된차량만 승인요청\r*진행하시겠습니까?*"
	}
	if(confirm(confirmMsg)){
		let parameters = {};
		parameters["corpId"] = "${corpInfo.corpId}";
		parameters["insIsrDiv0"] = $("#insIsrDiv0").val();
		parameters["insIsrDiv1"] = $("#insIsrDiv1").val();
		parameters["insIsrDiv2"] = $("#insIsrDiv2").val();
		parameters["totalInterlock"] = totalInterlock;
		$.ajax({
			type:"post",
			dataType:"json",
			url: "/apiRib/carModelInfo.ajax",
			data:parameters ,
			success:function(data){
				if(totalInterlock == "Y"){
					alert(data.resultCnt1+"개의 차량생성\r" + data.resultCnt2+"개의 차량업데이트");
				}else{
					alert(data.resultCnt1+"개의 차량생성");
				}
			},
			error : fn_AjaxError
		});
	}
}

function syncOrcRentcarInfo(totalInterlock){

	/** totalInterlock {Y : 전체연동, N : 추가연동  */
	let confirmMsg;
	if(totalInterlock == "Y"){
		confirmMsg = "[차량정보모두연동]\r미등록 차량:생성\r등록된 차량:업데이트\r렌터카 상태:등록중\r*진행하시겠습니까?*"
	}else{
		confirmMsg = "[차량정보추가연동]\r미등록 차량:생성\r렌터카 상태:추가등록된차량만 승인요청\r*진행하시겠습니까?*"
	}
	if(confirm(confirmMsg)){
		let parameters = {};
		parameters["corpId"] = "${corpInfo.corpId}";
		parameters["insIsrDiv0"] = $("#insIsrDiv0").val();
		parameters["insIsrDiv1"] = $("#insIsrDiv1").val();
		parameters["insIsrDiv2"] = $("#insIsrDiv2").val();
		parameters["totalInterlock"] = totalInterlock;
		$.ajax({
			type:"post",
			dataType:"json",
			url: "/apiOrc/vehicleModels.ajax",
			data:parameters ,
			success:function(data){
				if(totalInterlock == "Y"){
					alert(data.resultCnt1+"개의 차량생성\r" + data.resultCnt2+"개의 차량업데이트");
				}else{
					alert(data.resultCnt1+"개의 차량생성");
				}
			},
			error : fn_AjaxError
		});
	}
}

let time = 60;
let sec = 0;
let x = setInterval(function(){
	sec += parseInt(1);
},1000);

function syncInsRentcarInfo(totalInterlock){
	if(time > sec){
		alert(time-sec + "초 후에 추가연동 가능합니다.");
		return;
	}

	/** totalInterlock {Y : 전체연동, N : 추가연동  */
	let confirmMsg;
	if(totalInterlock == "Y"){
		confirmMsg = "[차량정보모두연동]\r미등록 차량:생성\r등록된 차량:업데이트\r렌터카 상태:등록중\r*진행하시겠습니까?*"
	}else{
		confirmMsg = "[차량정보추가연동]\r미등록 차량:생성\r렌터카 상태:추가등록된차량만 승인요청\r*진행하시겠습니까?*"
	}
	if(confirm(confirmMsg)){
		let parameters = {};
		parameters["corpId"] = "${corpInfo.corpId}";
		parameters["insIsrDiv0"] = $("#insIsrDiv0").val();
		parameters["insIsrDiv1"] = $("#insIsrDiv1").val();
		parameters["insIsrDiv2"] = $("#insIsrDiv2").val();
		parameters["totalInterlock"] = totalInterlock;
		$.ajax({
			type:"post",
			dataType:"json",
			url: "/apiIns/inslist.ajax",
			data:parameters ,
			success:function(data){
				if(totalInterlock == "Y"){
					alert(data.resultCnt1+"개의 차량생성\r" + data.resultCnt2+"개의 차량업데이트");
					toastr.info("<pre>"+JSON.stringify(data.모델목록 , null, 4)+"<pre>");
					toastr.success("<pre>"+JSON.stringify(data.보험목록 , null, 4)+"<pre>");
				}else{
					alert(data.resultCnt1+"개의 차량생성");
				}
			},
			error : fn_AjaxError
		});
	}
}
function corpRentcarInfo(){
	let parameters = {};
	parameters["corpId"] = "${corpInfo.corpId}";
	$.ajax({
		type:"post",
		dataType:"json",
		url: "/apiIns/carlist_r.ajax",
		data:parameters ,
		success:function(data){
			toastr.info("<pre>"+JSON.stringify(data.모델목록 , null, 4)+"<pre>");

		},
		error : fn_AjaxError
	});
}
function updateCarSaleStart(){
	if(confirm("[차량상품승인]\r상태변경:등록중->승인\r*진행하시겠습니까?*")){
		let parameters = {};
		parameters["corpId"] = "${corpInfo.corpId}";
		$.ajax({
			type:"post",
			dataType:"json",
			url: "/apiIns/updateCarSaleStart.ajax",
			data:parameters ,
			success:function(data){
				alert("승인으로 변경되었습니다.");
			},
			error : fn_AjaxError
		});
	}
}



$(document).ready(function() {
	toastr.options = {
		"closeButton": true,
		"positionClass" : "toast-bottom-full-width",
		"tapToDismiss" : false,
		"timeOut" : 0,
		"extendedTimeOut" : 0
}});



</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corp" flush="false"></jsp:include>
		<div id="contents_area">
			<!--본문-->
			<div id="contents">
				<form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="sCorpCd" id="sCorpCd" value="${searchVO.sCorpCd}"/>
					<input type="hidden" name="sTradeStatusCd" id="sTradeStatusCd" value="${searchVO.sTradeStatusCd}"/>
					<input type="hidden" name="sCorpNm" id="sCorpNm" value="${searchVO.sCorpNm}"/>
					<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}"/>
					<input type="hidden" name="sAsctMemYn" id="sAsctMemYn" value="${searchVO.sAsctMemYn}"/>
					<input type="hidden" name="sSuperbCorpYn" id="sSuperbCorpYn" value="${searchVO.sSuperbCorpYn}"/>
					<input type="hidden" name="sCorpLinkYn" id="sCorpLinkYn" value="${searchVO.sCorpLinkYn}"/>
				</form>
			
				<!--업체정보수정-->
				<form:form commandName="CORPVO" name="CORPVO" method="post" enctype="multipart/form-data">
					<!-- 업체 일반 정보 -->
					<h4 class="title03">업체 정보 수정</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th scope="row">업체아이디</th>
							<td>
								<input type="hidden" name="corpId" value="${corpInfo.corpId}" />
								<c:out value="${corpInfo.corpId}" />
							</td>
							<th>거래상태<span class="font02">*</span></th>
							<td>
								<select name="tradeStatusCd" id="tradeStatusCd">
									<option value="${Constant.TRADE_STATUS_APPR}" <c:if test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_APPR}">selected="selected"</c:if>>승인</option>
									<option value="${Constant.TRADE_STATUS_STOP}" <c:if test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_STOP}">selected="selected"</c:if>>판매중지</option>
									<option value="${Constant.TRADE_STATUS_REJECT}" <c:if test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_REJECT}">selected="selected"</c:if>>거래중지</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>업체명<span class="font02">*</span></th>
							<td>
								<form:input path="corpNm" id="corpNm" value="${corpInfo.corpNm}" class="input_text20" maxlength="30" />
								<form:errors path="corpNm"  cssClass="error_text" />
							</td>
							<th>회사유형<span class="font02">*</span></th>
							<td>
								<input type="radio" name="corpType"  id="corpType1" value="${Constant.CORP_TYPE_CORP }"<c:if test="${corpInfo.corpType == Constant.CORP_TYPE_CORP}"> checked="checked"</c:if> /><label for="corpType1">법인</label>
								<input type="radio" name="corpType" id="corpType2" value="${Constant.CORP_TYPE_INDI }"<c:if test="${corpInfo.corpType == Constant.CORP_TYPE_INDI}"> checked="checked"</c:if> /><label for="corpType2">개인</label>
								<input type="radio" name="corpType" id="corpType3" value="${Constant.CORP_TYPE_SIMP }"<c:if test="${corpInfo.corpType == Constant.CORP_TYPE_SIMP}"> checked="checked"</c:if> /><label for="corpType3">간이</label>
							</td>
						</tr>
						<tr>
							<th>사업자등록번호<span class="font02">*</span></th>
							<td>
								<form:input path="coRegNum" id="coRegNum" class="input_text10" value="${corpInfo.coRegNum}" maxlength="20" />
								<form:errors path="coRegNum" cssClass="error_text" />
							</td>
							<th>업체구분<span class="font02">*</span></th>
							<td>
								<form:select path="corpModCd">
									<c:forEach var="code" items="${corpModCd}" varStatus="status">
										<option value="${code.cdNum}" <c:if test="${corpInfo.corpModCd eq code.cdNum}">selected</c:if>>${code.cdNm}</option>
									</c:forEach>
								</form:select>
								<form:hidden path="corpCd" value="${corpInfo.corpCd}" />
								<form:select path="posUseYn" style="display:none">
									<option value="${Constant.FLAG_Y}" <c:if test="${corpInfo.posUseYn eq Constant.FLAG_Y}">selected</c:if>>POS 사용</option>
									<option value="${Constant.FLAG_N}" <c:if test="${corpInfo.posUseYn eq Constant.FLAG_N}">selected</c:if>>POS 미사용</option>
								</form:select>
								<form:errors path="corpCd" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>예약전화번호<span class="font02">*</span></th>
							<td>
								<form:input path="rsvTelNum" id="rsvTelNum" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.rsvTelNum}" />
								<form:errors path="rsvTelNum" cssClass="error_text" />
							</td>
							<th>팩스번호</th>
							<td>
								<form:input path="faxNum" id="faxNum" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.faxNum}" />
								<form:errors path="faxNum" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>홈페이지주소</th>
							<td>
								<form:input path="hmpgAddr" id="hmpgAddr" class="input_text20" value="${corpInfo.hmpgAddr}" />
								<form:errors path="hmpgAddr" cssClass="error_text" />
							</td>
							<th>협회소속분과</th>
							<td>
								<form:input path="branchNm" id="branchNm" class="input_text20" value="${corpInfo.branchNm}" />
								<form:errors path="branchNm" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>업태</th>
							<td>
								<form:input path="bsncon" id="bsncon" class="input_text20" value="${corpInfo.bsncon}" />
								<form:errors path="bsncon" cssClass="error_text" />
							</td>
							<th>업종</th>
							<td>
								<form:input path="bsntyp" id="bsntyp" class="input_text20" value="${corpInfo.bsntyp}" />
								<form:errors path="bsntyp" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>업체이메일</th>
							<td>
								<form:input path="corpEmail" id="corpEmail" class="input_text20" value="${corpInfo.corpEmail}" />
								<form:errors path="corpEmail" cssClass="error_text" />
							</td>
							<th>우수관광사업체</th>
							<td>
								<input type="hidden" id="superbCorpYn" name="superbCorpYn" />
								<input type="checkbox" id="superbCorpYn_chk" name="superbCorpYn_chk" <c:if test="${corpInfo.superbCorpYn == 'Y'}">checked="checked"</c:if>/>
							</td>
						</tr>
						<tr>
							<th>계좌정보</th>
							<td>
								<form:input path="bankNm" id="bankNm" class="input_text5" value="${corpInfo.bankNm}" placeholder="계좌은행" />
								<form:input path="accNum" id="accNum" class="input_text10" value="${corpInfo.accNum}" placeholder="계좌번호"  />
								<form:errors path="bankNm" cssClass="error_text" />
								<form:errors path="accNum" cssClass="error_text" />
							</td>
							<th>예금주</th>
							<td>
								<form:input path="depositor" id="depositor" class="input_text20" value="${corpInfo.depositor}" />
								<form:errors path="depositor" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>B2C 수수료율</th>
							<td>
								<select id="cmssNum" name="cmssNum">
									<c:forEach var="cmss" items="${cmssList}" varStatus="status">
										<option value="${cmss.cmssNum}" <c:if test="${corpInfo.cmssNum eq cmss.cmssNum}">selected="selected"</c:if>>${cmss.cmssNm}(${cmss.adjAplPct}%)</option>
									</c:forEach>
								</select>
							</td>
							<th>B2B 수수료율</th>
							<td>
								<select id="b2bCmssNum" name="b2bCmssNum">
									<c:forEach var="b2bCmss" items="${b2bCmssList}" varStatus="status">
										<option value="${b2bCmss.cmssNum}" <c:if test="${corpInfo.b2bCmssNum eq b2bCmss.cmssNum}">selected="selected"</c:if>>${b2bCmss.cmssNm}(${b2bCmss.adjAplPct}%)</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>렌터카 실시간 <br></br>연계관리</th>
							<td>
								<select name="apiRentDiv" id="apiRentDiv">
									<option value="N" <c:if test="${corpInfo.tradeStatusCd eq 'N'}">selected="selected"</c:if>>없음</option>
									<option value="${Constant.RC_RENTCAR_COMPANY_GRI}" <c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_GRI}">selected="selected"</c:if>>그림</option>
									<option value="${Constant.RC_RENTCAR_COMPANY_INS}" <c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_INS}">selected="selected"</c:if>>인스</option>
									<option value="${Constant.RC_RENTCAR_COMPANY_RIB}" <c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_RIB}">selected="selected"</c:if>>리본</option>
									<option value="${Constant.RC_RENTCAR_COMPANY_ORC}" <c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_ORC}">selected="selected"</c:if>>오르카</option>
								</select>
								<input type="hidden" id="corpLinkYn" name="corpLinkYn" value="${corpInfo.corpLinkYn}" />
								<input type="checkbox" id="corpLinkYn_chk" name="corpLinkYn_chk"<c:if test="${corpInfo.corpLinkYn=='Y'}">checked="checked"</c:if> style="vertical-align: baseline" /> <label for="corpLinkYn_chk">렌터카연동여부</label>
								<c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_INS or corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_RIB or corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_ORC}">
									<br><br>
									자차자율
									<select id="insIsrDiv0" name="insIsrDiv0"/>
										<option value="1" selected>미생성</option>
										<option value="2">생성</option>
									</select>
									일반자차순위
									<select id="insIsrDiv1" name="insIsrDiv1"/>
										<option value="" >없음</option>
										<option value="1" selected>1</option>
										<option value="2">2</option>
									</select>
									고급자차순위
									<select id="insIsrDiv2" name="insIsrDiv2"/>
										<option value="" >없음</option>
										<option value="1">1</option>
										<option value="2" selected>2</option>
									</select>
									<br><br>
								<c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_INS}">
									<div class="btn_sty07"><span><a href="javascript:syncInsRentcarInfo('N')">추가연동</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:syncInsRentcarInfo('Y')">전체연동</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:updateCarSaleStart()">전체승인</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:corpRentcarInfo()">업체차량정보</a></span></div>
									</c:if>
								</c:if>
								<c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_RIB}">
									<div class="btn_sty07"><span><a href="javascript:syncRibRentcarInfo('N')">추가연동</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:syncRibRentcarInfo('Y')">전체연동</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:updateCarSaleStart()">전체승인</a></span></div>
								</c:if>
								<c:if test="${corpInfo.apiRentDiv eq Constant.RC_RENTCAR_COMPANY_ORC}">
									<div class="btn_sty07"><span><a href="javascript:syncOrcRentcarInfo('N')">추가연동</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:syncOrcRentcarInfo('Y')">전체연동</a></span></div>
									<div class="btn_sty07"><span><a href="javascript:updateCarSaleStart()">전체승인</a></span></div>
								</c:if>
							</td>
							<th>LINK상품 사용 여부</th>
							<td>
								<select name="linkPrdtUseYn" id="linkPrdtUseYn">
									<option value="${Constant.FLAG_N}" <c:if test="${corpInfo.linkPrdtUseYn eq Constant.FLAG_N}">selected="selected"</c:if>>사용안함</option>
									<option value="${Constant.FLAG_Y}" <c:if test="${corpInfo.linkPrdtUseYn eq Constant.FLAG_Y}">selected="selected"</c:if>>사용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>숙박 API 연동</th>
							<td colspan="3">
								<input type="radio" name="adApiLinkNm"  id="adApiN" value="" <c:if test="${corpInfo.adApiLinkNm eq '' || empty corpInfo.adApiLinkNm}">checked="checked"</c:if> /><label for="adApiN">없음</label>
								<input type="radio" name="adApiLinkNm" id="adApiTLL" value="TLL" <c:if test="${corpInfo.adApiLinkNm eq 'TLL'}">checked="checked"</c:if> /><label for="adApiTLL">TL 린칸</label>
							</td>
						</tr>
						<tr>
							<th>업체주소</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
								<form:input path="roadNmAddr" id="roadNmAddr" class="input_text30" readonly="readonly" value="${corpInfo.roadNmAddr}" />
								<form:input path="dtlAddr" id="dtlAddr" class="input_text15" value="${corpInfo.dtlAddr}" />
								<form:errors path="roadNmAddr" cssClass="error_text" />
								<form:errors path="dtlAddr" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>위도/경도</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
								위도 : <form:input path="lat" id="lat" value="${corpInfo.lat}" readonly="readonly" />
								경도 : <form:input path="lon" id="lon" value="${corpInfo.lon}" readonly="readonly" />
								<form:errors path="lat" cssClass="error_text" />
								<form:errors path="lon" cssClass="error_text" />
							</td>
						</tr>
					</table>

					<!--대표자 정보-->
					<h4 class="title03 margin-top25">대표자 정보</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>대표자 성명</th>
							<td colspan="3">
								<form:input path="ceoNm" id="ceoNm" class="input_text10" value="${corpInfo.ceoNm}" />
								<form:errors path="ceoNm" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>
								<form:input path="ceoTelNum" id="ceoTelNum" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.ceoTelNum}" />
								<form:errors path="ceoTelNum" cssClass="error_text" />
							</td>
							<th>생년월일</th>
							<td>
								<form:input path="ceoBth" id="ceoBth" class="input_text10" value="${corpInfo.ceoBth}" /> ex) 19770417
								<form:errors path="ceoBth" cssClass="error_text" />
							</td>
						</tr>
					</table>
					<!--//대표자 정보-->

					<!-- 담당자 정보 -->
					<h4 class="title03 margin-top25">담당자 정보</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>담당자 성명</th>
							<td>
								<form:input path="admNm" id="admNm" class="input_text10" value="${corpInfo.admNm}" />
								<form:errors path="admNm" cssClass="error_text" />
							</td>
							<th>이메일</th>
							<td>
								<form:input path="admEmail" id="admEmail" class="input_text20" value="${corpInfo.admEmail}" />
								<form:errors path="admEmail" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td>
								<form:input path="admMobile" id="admMobile" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.admMobile}" />
								<form:errors path="admMobile" cssClass="error_text" />
							</td>
							<th>일반전화</th>
							<td>
								<form:input path="admTelnum" id="admTelnum" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.admTelnum}" />
								<form:errors path="admTelnum" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>부서</th>
							<td>
								<form:input path="admDep" id="admDep" class="input_text10" value="${corpInfo.admDep}" />
								<form:errors path="admDep" cssClass="error_text" />
							</td>
							<th>직위</th>
							<td>
								<form:input path="admOfcpos" id="admOfcpos" class="input_text10" value="${corpInfo.admOfcpos}" />
								<form:errors path="admOfcpos" cssClass="error_text" />
							</td>
						</tr>
					</table>
					<!-- //담당자 정보 -->

					<!-- 관리자 설정 -->
					<h4 class="title03 margin-top25">관리자 설정</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>관리자</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:fn_FindUser()">담당자검색</a></span></div>
								<input type="text" name="managerId" id="managerId" value="${corpInfo.managerId}" readonly="readonly" />
								<input type="text" name="managerNm" id="managerNm" value="${corpInfo.managerNm}" readonly="readonly" />
							</td>
						</tr>
					</table>

					<!-- VISIT제주 연계 -->
					<h4 class="title03 margin-top25">VISIT제주연계</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>연계</th>
							<td colspan="3">
								<c:if test="${not empty corpInfo.visitMappingId}">
									연계중 (<c:out value="${corpInfo.visitMappingId}"/>)
								</c:if>
								<input type="text" name="visitNm" id="visitNm" value="${corpInfo.visitMappingNm}"/>
								<input type="hidden" name="visitMappingId" id="visitMappingId" value="${corpInfo.visitMappingId}" />
								<input type="hidden" name="visitMappingNm" id="visitMappingNm" value="${corpInfo.visitMappingNm}" />
							</td>
						</tr>
					</table>

					<h4 class="title03 margin-top25">입점 서류</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
                        <c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
                        <tr>
							<th scope="row">사업자등록증<span class="font02">*</span></th>
							<td>
								<div id="divFile1" <c:if test="${empty cprfMap['1']}">style="display:none;"</c:if>>
									${cprfMap['1'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['1'].savePath}${cprfMap['1'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['1'].requestNum}', '${cprfMap['1'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile1" <c:if test="${!empty cprfMap['1']}">style="display:none;"</c:if>>
									<input type="file" name="businessLicense" id="businessLicense" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
							<th scope="row">통장<span class="font02">*</span></th>
							<td>
								<div id="divFile2" <c:if test="${empty cprfMap['2']}">style="display:none;"</c:if>>
									${cprfMap['2'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['2'].savePath}${cprfMap['2'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['2'].requestNum}', '${cprfMap['2'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile2" <c:if test="${!empty cprfMap['2']}">style="display:none;"</c:if>>
									<input type="file" name="passbook" id="passbook" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">영업신고증 및 <br>각종 허가증<span class="font02">*</span></th>
							<td>
								<div id="divFile3" <c:if test="${empty cprfMap['3']}">style="display:none;"</c:if>>
									${cprfMap['3'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['3'].savePath}${cprfMap['3'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['3'].requestNum}', '${cprfMap['3'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile3" <c:if test="${!empty cprfMap['3']}">style="display:none;"</c:if>>
									<input type="file" name="businessCard" id="businessCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
							<th scope="row">통신판매업신고증</th>
							<td>
								<div id="divFile4" <c:if test="${empty cprfMap['4']}">style="display:none;"</c:if>>
									${cprfMap['4'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['4'].savePath}${cprfMap['4'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['4'].requestNum}', '${cprfMap['4'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile4" <c:if test="${!empty cprfMap['4']}">style="display:none;"</c:if>>
									<input type="file" name="salesCard" id="salesCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">계약서1</th>
							<td>
								<div id="divFile5" <c:if test="${empty cprfMap['5']}">style="display:none;"</c:if>>
										${cprfMap['5'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['5'].savePath}${cprfMap['5'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['5'].requestNum}', '${cprfMap['5'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile5" <c:if test="${!empty cprfMap['5']}">style="display:none;"</c:if>>
									<input type="file" name="contract1" id="contract1" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>

							<th scope="row">계약서2</th>
							<td>
								<div id="divFile6" <c:if test="${empty cprfMap['6']}">style="display:none;"</c:if>>
										${cprfMap['6'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['6'].savePath}${cprfMap['6'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['6'].requestNum}', '${cprfMap['6'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile6" <c:if test="${!empty cprfMap['6']}">style="display:none;"</c:if>>
									<input type="file" name="contract2" id="contract2" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>

						</tr>

					</table>
					<p class="text-right"><span class="font02">* 등록가능 파일: ${Constant.FILE_CHECK_SIZE}MB 이하의 ${fn:toUpperCase(fn:replace(acceptExt, ".", ""))} 파일</span></p>

					<!-- 업체 comment -->
					<h4 class="title03 margin-top25">업체 comment</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="85%" />
						</colgroup>
						<tr>
							<th>내용</th>
							<td colspan="3">
								<textarea name="corpComment" id="corpComment" rows="10"  style="width:97%" placeholder="ex) 김00 / 2022-06-10 / 6월19일에 요금 등록 해준다고 함">${corpInfo.corpComment}</textarea>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_UdtCorp()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:fn_ListCorp()">목록</a></li>
					</ul>
				</form:form>
				<!--//업체 정보 수정-->
			</div>
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>