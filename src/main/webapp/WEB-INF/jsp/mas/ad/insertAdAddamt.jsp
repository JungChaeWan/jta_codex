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
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
	
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="AD_ADDAMTVO" staticJavascript="false" xhtml="true" cdata="true"/>


<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
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

<script type="text/javascript">
var hrkCodeItem = [];

function fn_Ins(){
	if($('#aplStartDt').val() == ""){
		alert("적용 시작 일자를 선택 하세요.");
		return;
	}
	
	// 콤마 제거
	delCommaFormat();
	
	// validation 체크
	if(!validateAD_ADDAMTVO(document.AD_ADDAMTVO)){
		return;
	}
	

	var adultAddAmt = document.AD_ADDAMTVO.adultAddAmt.value;
	if(adultAddAmt < 0){
		alert("성인 추가 요금은 음수를 입력 할 수 없습니다.");
		document.AD_ADDAMTVO.adultAddAmt.focus();
		return;
	}
	
	var juniorAddAmt = document.AD_ADDAMTVO.juniorAddAmt.value;
	if(juniorAddAmt < 0){
		alert("소아 추가 요금은 음수를 입력 할 수 없습니다.");
		document.AD_ADDAMTVO.juniorAddAmt.focus();
		return;
	}
	
	var childAddAmt = document.AD_ADDAMTVO.childAddAmt.value;
	if(childAddAmt < 0){
		alert("유아 추가 요금은 음수를 입력 할 수 없습니다.");
		document.AD_ADDAMTVO.childAddAmt.focus();
		return;
	}

	document.AD_ADDAMTVO.action = "<c:url value='/mas/ad/insertAdAddamt.do' />";
	document.AD_ADDAMTVO.submit();
}

function fn_Cancel(){
	document.AD_ADDAMTVO.action = "<c:url value='/mas/ad/adAddamtList.do' />";
	document.AD_ADDAMTVO.submit();
}


$(document).ready(function(){
	
	$("#aplStartDtView").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${today}",
		maxDate: '+1y'
	});
	
	$('#aplStartDtView').change(function() {
		$('#aplStartDt').val($('#aplStartDtView').val().replace(/-/g, ''));
	});

});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=corp"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			<div id="contents">
				<form:form commandName="AD_ADDAMTVO" name="AD_ADDAMTVO" method="post">
					<div class="register_area">
						<h4 class="title03">인원 추가요금(공통) 추가<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
						
						<table border="1" class="table02">
							<colgroup>
								<col width="200" />
								<col width="*" />
							</colgroup>
							<tr>
								<th>업체 아이디</th>
								<td colspan="3">
									<input type="hidden" id="corpId" name="corpId" value='<c:out value="${adAddamt.corpId}" />' />
									<c:out value="${adAddamt.corpId}" />
								</td>
							</tr>
							<tr>                    	
								<th>적용 시작 일자<span class="font02">*</span></th>
								<td colspan="3">
									<fmt:parseDate value='${adAddamt.aplStartDt}' var='aplStartDt' pattern="yyyymmdd" scope="page"/>
									<input type="text" id="aplStartDtView" name="aplStartDtView" class="input_text02" value="<fmt:formatDate value="${aplStartDt}" pattern="yyyy-mm-dd"/>" readonly="readonly"/>
									<input type="hidden" id="aplStartDt" name="aplStartDt" class="input_text02" value="${adAddamt.aplStartDt}" />
									${errmsg }
								</td>                    	
							</tr>
							<tr>
								<th>성인 추가 요금<span class="font02">*</span></th>
								<td colspan="3">
									<form:input path="adultAddAmt" id="adultAddAmt" value="${adAddamt.adultAddAmt}" class="input_text20 numFormat" placeholder="성인 추가 요금을 입력하세요." maxlength="20"  />
									<form:errors path="adultAddAmt"  cssClass="error_text" /> 
								</td>
							</tr>
							<tr>
								<th>소아 추가 요금<span class="font02">*</span></th>
								<td colspan="3">
									<form:input path="juniorAddAmt" id="juniorAddAmt" value="${adAddamt.juniorAddAmt}" class="input_text20 numFormat" placeholder="소아 추가 요금을 기준을 입력하세요." maxlength="20"  />
									<form:errors path="juniorAddAmt"  cssClass="error_text" />
								</td>
							</tr>
							<tr>
								<th>유아 추가 요금<span class="font02">*</span></th>
								<td colspan="3">
									<form:input path="childAddAmt" id="childAddAmt" value="${adAddamt.childAddAmt}" class="input_text20 numFormat" placeholder="유아 추가 요금을 입력하세요." maxlength="20"  />
									<form:errors path="childAddAmt"  cssClass="error_text" />
								</td>
							</tr>
						</table>
					</div>
				</form:form>

				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="javascript:fn_Ins()">추가</a></li>
					<li class="btn_sty01"><a href="javascript:fn_Cancel()">취소</a></li>
				</ul>
			</div>
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>