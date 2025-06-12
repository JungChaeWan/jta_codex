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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.timepicker.min.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>


<validator:javascript formName="RC_DFTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery.timepicker.min.css'/>" />

<title></title>
<style>
	.ui-timepicker-select{
		width:100px
	}
</style>

<script type="text/javascript">

/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
            // document.getElementById('post1').value = data.postcode1;
            // document.getElementById('post2').value = data.postcode2;
            // 2015.08.01 부터 우편번호 5자리 실행
            // document.getElementById('postNum').value = data.zonecode;
            document.getElementById('tkovRoadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('tkovDtlAddr').focus();
			fn_FindLocation();
        }
    }).open();
}

/**
 * 주소에 따른 경도 위도 구하기
 */
function fn_FindLocation(){
	var addr = $("#tkovRoadNmAddr").val();

	if(isNull(addr)){
		alert("주소를 입력해주세요.");
		$("#tkovDtlAddr").focus();
		return;
	}
	var geocoder = new daum.maps.services.Geocoder();

    var callback = function(result, status) {
	    if(status === daum.maps.services.Status.OK){
            var lat = result[0].y
            var lng = result[0].x

	    	$("#tkovLon").val(lng);
			$("#tkovLat").val(lat);
	    }else{
	    	if(status === daum.maps.services.Status.ZERO_RESULT){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else if(status === daum.maps.services.Status.RESULT_NOT_FOUND){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else{
	    		alert("API 응답불가, 관리자에게 문의하세요.");
				return;
	    	}
	    }
	};
    geocoder.addressSearch(addr, callback);
}


function openDaumPostcode1() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
            // document.getElementById('post1').value = data.postcode1;
            // document.getElementById('post2').value = data.postcode2;
            // 2015.08.01 부터 우편번호 5자리 실행
            // document.getElementById('postNum').value = data.zonecode;
            document.getElementById('tkovRoadNmAddr1').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('tkovDtlAddr1').focus();
        }
    }).open();
}

function fn_UdtRentCar(){
	// validation 체크
	if(!validateRC_DFTINFVO(document.dftInf)){
		return;
	}
	
	// 주말 할인율 적용 요일 체크
	var wkdDisNum = 0;
	$('input[name=wkdDisPerAplWeek]:checked').each(function() {
		wkdDisNum++;
	});
	if (wkdDisNum == 0) {
		alert("주말 할인율 적용 요일을 선택해주세요.");		
		return;
	}

	if($("input:radio[name=rsvMaxiTmAplYn]:checked").val() == "Y"){
		if(isNull($("#rsvMaxiTm").val())){
			alert("예약최대시간을 입력해주세요.");
			$("#rsvMaxiTm").focus();
			return;
		}else{
			if(!isNumber($("#rsvMaxiTm").val())){
				alert("숫자만 입력 가능합니다.");
				$("#rsvMaxiTm").focus();
				return;
			}
		}
	}

	//인수시간, 반납시간 set value 및 validate 2022.03.30 chaewan.jung
	$('#tkovMinTm').val($('#tkovMinTm').val().replace(':',''));
	$('#tkovMaxTm').val($('#tkovMaxTm').val().replace(':',''));
	$('#rtnMinTm').val($('#rtnMinTm').val().replace(':',''));
	$('#rtnMaxTm').val($('#rtnMaxTm').val().replace(':',''));

	if ($('#tkovMinTm').val() > $('#tkovMaxTm').val()){
		alert('인수 최대시간 보다 최소시간이 큽니다.\n인수시간을 확인 후 등록 바랍니다.');
		return;
	}
	if ($('#rtnMinTm').val() > $('#rtnMaxTm').val()){
		alert('반납 최대시간 보다 최소시간이 큽니다.\n인수시간을 확인 후 등록 바랍니다.');
		return;
	}

	if (DEXT5.getBodyValueExLikeDiv('editor1').replace(/(<([^>]+)>)/gi, "").replace('&nbsp;', '').trim() == '') {
		alert("취소/환불 규정을 입력하세요.");
		return;
	}
	
	if(confirm("<spring:message code='common.save.msg'/>")){
		if($("#wkdDisPerAplYn_chk").is(":checked")){
			$("#wkdDisPerAplYn").val("Y");
		}else{
			$("#wkdDisPerAplYn").val("N");
		}
		if($("#addUseDisPerAplYn_chk").is(":checked")){
			$("#addUseDisPerAplYn").val("Y");
		}else{
			$("#addUseDisPerAplYn").val("N");
		}

		$("#cancelGuide").val(DEXT5.getBodyValueExLikeDiv('editor1'));
		$("#nti").val(DEXT5.getBodyValueExLikeDiv('editor2'));


		document.dftInf.action = "<c:url value='/mas/rc/updateRentCarInfo.do'/>";
		document.dftInf.submit();
	}
}

function dext_editor_loaded_event() {
	//숨겨진 textarea에서 html 소스를 가져옵니다.
	var html_source = document.getElementById('cancelGuide').value; //에디터가 로드 되고 난 후 에디터에 내용을 입력합니다.
	DEXT5.setBodyValueExLikeDiv(html_source, 'editor1');

	var html_source2 = document.getElementById('nti').value; //에디터가 로드 되고 난 후 에디터에 내용을 입력합니다.
	DEXT5.setBodyValueExLikeDiv(html_source2, 'editor2');
}

$(document).ready(function(){
	if("${existYn}" == "N"){
		alert("기본설정은 필수 입력 사항입니다.");
	}
		
	$('input[name=dayRsvUnableYn]').click(function() {
		
		if ($(this).val() == 'N') {				
			$('select[name=dayRsvUnableTm]').prop('disabled', true);
		} else {
			$('select[name=dayRsvUnableTm]').prop('disabled', false);
		}
	});

	//인수시간, 반납시간 setting
	$('#tkovMinTm').timepicker({
		'timeFormat': 'H:i',
		'minTime' : '07:00',
		'maxTime' : '22:00',
		'useSelect' : true
	});
	$('#tkovMaxTm').timepicker({
		'timeFormat': 'H:i',
		'minTime' : '07:00',
		'maxTime' : '22:00',
		'useSelect' : true
	});
	$('#rtnMinTm').timepicker({
		'timeFormat': 'H:i',
		'minTime' : '07:00',
		'maxTime' : '22:00',
		'useSelect' : true
	});
	$('#rtnMaxTm').timepicker({
		'timeFormat': 'H:i',
		'minTime' : '07:00',
		'maxTime' : '22:00',
		'useSelect' : true
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--입력 폼-->
			<form:form commandName="RC_DFTINFVO" name="dftInf" method="post">
			<input type="hidden" name="rcSimpleExp" value="" />
			<input type="hidden" name="rcInf" value="" />
			<div id="contents">
				<h4 class="title03">렌터카 판매정책<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">업체아이디</th>
						<td>
							<input type="hidden" id="corpId" name="corpId" value='<c:out value="${rentCarInfo.corpId}" />' />
							<c:out value="${rentCarInfo.corpId}" />
						</td>
						<th>렌터카명<span class="font02">*</span></th>
						<td>
							<c:if test="${prdtCnt==0}">
								<form:input path="rcNm" id="rcNm" value="${rentCarInfo.rcNm}" class="input_text20" maxlength="20" />
								<form:errors path="rcNm"  cssClass="error_text" />
							</c:if>
							<c:if test="${prdtCnt>0}">
								<c:out value="${rentCarInfo.rcNm}"></c:out>
								<input type="hidden" name="rcNm" id="rcNm" value="${rentCarInfo.rcNm}"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>주말 할인율 적용 여부<span class="font02">*</span></th>
						<td>
							<input type="hidden" id="wkdDisPerAplYn" name="wkdDisPerAplYn" value="${rentCarInfo.wkdDisPerAplYn}" />
							<input type="checkbox" id="wkdDisPerAplYn_chk" name="wkdDisPerAplYn_chk" <c:if test="${rentCarInfo.wkdDisPerAplYn=='Y'}">checked="checked"</c:if>/>
							<label for="wkdDisPerAplYn_chk">적용</label>
						</td>
						<th>주말 할인율 적용 요일<span class="font02">*</span></th>
						<td>
							<input type="checkbox" name="wkdDisPerAplWeek" class="required" id="wday_0" value="0" title="적용요일을 선택하세요." <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,0) != -1}">checked="checked"</c:if> />
                            <label for="wday_0" style="color:red">일요일</label>
                            <input type="checkbox" name="wkdDisPerAplWeek" id="wday_1" value="1" <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,1) != -1}">checked="checked"</c:if> />
                            <label for="wday_1">월요일</label>
                            <input type="checkbox" name="wkdDisPerAplWeek" id="wday_2" value="2" <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,2) != -1}">checked="checked"</c:if> />
                            <label for="wday_2">화요일</label>
                            <input type="checkbox" name="wkdDisPerAplWeek" id="wday_3" value="3" <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,3) != -1}">checked="checked"</c:if> />
                            <label for="wday_3">수요일</label>
                            <br />
                            <input type="checkbox" name="wkdDisPerAplWeek" id="wday_4" value="4" <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,4) != -1}">checked="checked"</c:if> />
                            <label for="wday_4">목요일</label>
                            <input type="checkbox" name="wkdDisPerAplWeek" id="wday_5" value="5" <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,5) != -1}">checked="checked"</c:if> />
                            <label for="wday_5">금요일</label>
                            <input type="checkbox" name="wkdDisPerAplWeek" id="wday_6" value="6" <c:if test="${fn:indexOf(rentCarInfo.wkdDisPerAplWeek,6) != -1}">checked="checked"</c:if> />
                            <label for="wday_6" style="color:blue">토요일</label>
						</td>
					</tr>
					<tr>
						<th>추가이용 적용기준<span class="font02">*</span></th>
						<td>
							<select name="addUseAbleTm" id="addUseAbleTm">
								<option value="1" <c:if test="${rentCarInfo.addUseAbleTm=='1'}">selected="selected"</c:if>>24시간</option>
								<option value="2" <c:if test="${rentCarInfo.addUseAbleTm=='2'}">selected="selected"</c:if>>기준시간</option>
							</select>
							<form:errors path="addUseAbleTm"  cssClass="error_text" />
						</td>
						<th>추가이용 최대시간<span class="font02">*</span></th>
						<td>
							<select name="addUseMaxiTm" id="addUseMaxiTm">
								<c:forEach begin="1" step="1" end="5" varStatus="status">
									<option value="${status.index}" <c:if test="${rentCarInfo.addUseMaxiTm==status.index}">selected="selected"</c:if>>${status.index}시간</option>
								</c:forEach>
							</select>
							<form:errors path="addUseMaxiTm"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>추가이용 적용시간<span class="font02">*</span></th>
						<td>
							<select name="addUseAplTm" id="addUseAplTm">
								<c:forEach begin="1" step="1" end="5" varStatus="status">
									<option value="${status.index}" <c:if test="${rentCarInfo.addUseAplTm==status.index}">selected="selected"</c:if>>${status.index}시간</option>
								</c:forEach>
							</select>
							<form:errors path="addUseAplTm"  cssClass="error_text" />
						</td>
						<th>예약가능 최소시간<span class="font02">*</span></th>
						<td>
							<form:input path="rsvAbleMiniTm" id="rsvAbleMiniTm" value="${rentCarInfo.rsvAbleMiniTm}" class="input_text2" maxlength="4" /> 시간
							<form:errors path="rsvAbleMiniTm"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>할인적용 최소시간<span class="font02">*</span></th>
						<td>
							<form:input path="disPerAplTm" id="disPerAplTm" value="${rentCarInfo.disPerAplTm}" class="input_text2" maxlength="4" /> 시간
							<form:errors path="disPerAplTm"  cssClass="error_text" />
						</td>
						<th>추가 이용 할인율 적용 여부<span class="font02">*</span></th>
						<td>
							<input type="hidden" id="addUseDisPerAplYn" name="addUseDisPerAplYn" value="${rentCarInfo.addUseDisPerAplYn}" />
							<input type="checkbox" id="addUseDisPerAplYn_chk" name="addUseDisPerAplYn_chk" <c:if test="${rentCarInfo.addUseDisPerAplYn=='Y'}">checked="checked"</c:if>/>
							<label for="addUseDisPerAplYn_chk">적용</label>
						</td>
					</tr>
					<tr>
						<th>당일예약불가설정<span class="font02">*</span></th>
						<td>
							<label><input type="radio" name="dayRsvUnableYn" <c:if test="${rentCarInfo.dayRsvUnableYn == 'Y'}">checked="checked"</c:if> value="Y" />사용</label>
							<label><input type="radio" name="dayRsvUnableYn" <c:if test="${rentCarInfo.dayRsvUnableYn == 'N'|| rentCarInfo.dayRsvUnableYn == null}">checked="checked"</c:if> value="N" />미사용</label>
						</td>
						<th>당일예약불가시간<span class="font02">*</span></th>
						<td>
							<select name="dayRsvUnableTm" <c:if test="${rentCarInfo.dayRsvUnableYn == 'N'|| rentCarInfo.dayRsvUnableYn == null}">disabled</c:if>>
								<c:forEach begin="1" end="23" step="1" var="tm">
                                   	<c:if test='${tm < 10}'>
                                   		<c:set var="tm_v" value="0${tm}" />
                                   		<c:set var="tm_t" value="0${tm}" />
                                   	</c:if>
                                   	<c:if test='${tm > 9}'>
                                   		<c:set var="tm_v" value="${tm}" />
                                   		<c:set var="tm_t" value="${tm}" />
                                   	</c:if>
                                    <option value="${tm_v}" <c:if test="${rentCarInfo.dayRsvUnableTm == tm_v}">selected="selected"</c:if>>${tm_t}</option>
                                </c:forEach>
							</select>시 이후 예약불가
						</td>
					</tr>
					<tr>
						<th>예약최대시간 적용여부<span class="font02">*</span></th>
						<td>
							<label><input type="radio" name="rsvMaxiTmAplYn" <c:if test="${rentCarInfo.rsvMaxiTmAplYn == 'Y'}">checked="checked"</c:if> value="Y" />사용</label>
							<label><input type="radio" name="rsvMaxiTmAplYn" <c:if test="${rentCarInfo.rsvMaxiTmAplYn == 'N'|| rentCarInfo.rsvMaxiTmAplYn == null}">checked="checked"</c:if> value="N" />미사용</label>
						</td>
						<th>예약최대시간<span class="font02">*</span></th>
						<td>
							<input name="rsvMaxiTm" id="rsvMaxiTm" value="${rentCarInfo.rsvMaxiTm}" class="input_text2" maxlength="4" /> 시간까지 가능
						</td>
					</tr>
					<tr>
						<th>예약가능시간<span class="font02">*</span></th>
						<td>
							<input name="cancelAbleTm" id="cancelAbleTm" value="${rentCarInfo.cancelAbleTm}" class="input_text2" maxlength="4" /> 시간 이후 예약가능
						</td>
						<th>판매가/입금가 선택<span class="font02">*</span></th>
						<td>
							<label><input type="radio" name="sellLink" <c:if test="${rentCarInfo.sellLink == 'Y'}">checked="checked"</c:if> value="Y" />판매가</label>
							<label><input type="radio" name="sellLink" <c:if test="${rentCarInfo.sellLink == 'N'}">checked="checked"</c:if> value="N" />입금가</label>
						</td>
					</tr>
					<%-- <tr>
						<th>보험 공통 안내</th>
						<td colspan="3">
							<textarea name="isrCmGuide" id="isrCmGuide" value="${rentCarInfo.isrCmGuide}" cols="70" rows="7" ><c:out value="${rentCarInfo.isrCmGuide}" escapeXml="false" /></textarea>
						</td>
					</tr>
					<tr>
						<th>대여 기준 정보</th>
						<td colspan="3">
							<textarea name="rntStdInf" id="rntStdInf" cols="70" rows="7" ><c:out value="${rentCarInfo.rntStdInf}" escapeXml="false" /></textarea>
						</td>
					</tr>
					<tr>
						<th>차량 인수 정보</th>
						<td colspan="3">
							<textarea name="carTkovInf" id="carTkovInf" cols="70" rows="7" ><c:out value="${rentCarInfo.carTkovInf}" escapeXml="false" /></textarea>
							<!-- <br /><span class="font02">※ 셔틀 탑승 관련 내용 필수 (셔틀 탑승위치, 배차간격, 배차시간 등)</span> -->
						</td>
					</tr> --%>

					<tr>
						<th>셔틀이용안내<br/>-셔틀 타는 곳<span class="font_red">*</span></th>
						<td colspan="3">
							제주공항 도착(1층) → 5 GATE → 건널목 건너 우측 이동 → 렌터카하우스
							<select name="shutZone1" id="shutZone1">

								<c:forEach var="i" begin="1" end="10" step="1" >
									<option <c:if test="${rentCarInfo.shutZone1==i}"> selected="selected"</c:if> value="${i}" >${i}</option>
								</c:forEach>
							</select>구역
							<select name="shutZone2" id="shutZone2">
								<c:forEach var="i" begin="1" end="20" step="1" >
									<option <c:if test="${rentCarInfo.shutZone2==i}"> selected="selected"</c:if> value="${i}">${i}</option>
								</c:forEach>
							</select>번

						</td>
					</tr>
					<tr>
						<th>셔틀이용안내<br/>-운행시간<span class="font_red">*</span></th>
						<td colspan="3">
							<input name="shutRunTm" id="shutRunTm" value="${rentCarInfo.shutRunTm}" /> (예. '08:00~22:00')
						</td>
					</tr>
					<tr>
						<th>셔틀이용안내<br/>-운행간격<span class="font_red">*</span></th>
						<td colspan="1">
							<input name="shutRunInter" id="shutRunInter" value="${rentCarInfo.shutRunInter}" maxlength="10" />
						</td>
						<th>셔틀이용안내<br/>-소요시간<span class="font_red">*</span></th>
						<td colspan="1">
							<input name="shutCostTm" id="shutCostTm" value="${rentCarInfo.shutCostTm}" />분 (예. 10)
						</td>
					</tr>
					<tr>
						<th>반납/인수 위치<span class="font_red">*</span></th>
						<td colspan="3">
							주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소:
							<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
							<input name="tkovRoadNmAddr" id="tkovRoadNmAddr"  class="input_text30" readonly="readonly" value="${rentCarInfo.tkovRoadNmAddr}" />
							<input name="tkovDtlAddr" id="tkovDtlAddr"  class="input_text15" value="${rentCarInfo.tkovDtlAddr}" maxlength="100" />
							<br/>
							위도/경도:
							<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
							위도 : <input name="tkovLon" id="tkovLon" value="${rentCarInfo.tkovLon}" readonly="readonly" />
							경도 : <input name="tkovLat" id="tkovLat" value="${rentCarInfo.tkovLat}" readonly="readonly" />
						</td>
					</tr>

					<tr>
						<th>인수시간</th>
						<td colspan="1">
							<input name="tkovMinTm" id="tkovMinTm" value="${rentCarInfo.tkovMinTm}" /> ~ <input name="tkovMaxTm" id="tkovMaxTm" value="${rentCarInfo.tkovMaxTm}" />
						</td>
						<th>반납시간</th>
						<td colspan="1">
							<input name="rtnMinTm" id="rtnMinTm" value="${rentCarInfo.rtnMinTm}" /> ~ <input name="rtnMaxTm" id="rtnMaxTm" value="${rentCarInfo.rtnMaxTm}" />
						</td>
					</tr>
					<tr>
						<th>홍보영상</th>
						<td colspan="3">
							<input name="sccUrl" id="sccUrl" value="${rentCarInfo.sccUrl}" class="input_text_full" maxlength="200" />
							<br /><span class="font02">※ YouTube 동영상의 경로를 넣으시면 됩니다. ( https://www.youtube.com/embed/유튜브영상고유번호 )</span>
						</td>
					</tr>

					<tr>
						<th>참고사항</th>
						<td colspan="3">
							<script type="text/javascript">
								var editor2 = new Dext5editor('editor2');
							</script>
							<textarea name="nti" id="nti" cols="70" rows="7" style="display:none"><c:out value="${rentCarInfo.nti}" escapeXml="false" /></textarea>
<%--							<textarea name="nti" id="nti" cols="70" rows="7" ><c:out value="${rentCarInfo.nti}" escapeXml="false" /></textarea>--%>
						</td>
					</tr>
					<tr>
						<th>취소/환불 규정</th>
						<td colspan="3">
							<script type="text/javascript">
							 var editor1 = new Dext5editor('editor1');
							</script>
							<textarea name="cancelGuide" id="cancelGuide" cols="70" rows="7" style="display:none"><c:out value="${rentCarInfo.cancelGuide}" escapeXml="false" /></textarea>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtRentCar()">저장</a>
					</li>
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