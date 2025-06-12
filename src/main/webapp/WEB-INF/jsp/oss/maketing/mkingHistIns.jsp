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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Ins() {


	if($('#corpId').val().length == 0){
		alert("회사 또는 상품을 선택 하세요.");
		//$('#kwaNm').focus();
		return;
	}

	if($('#mkingDt').val().length == 0){
		alert("홍보일자을 선택 하세요.");
		$('#mkingDt').focus();
		return;
	}

	if(isNaN( $('#adtmPay').val() )){
		alert("홍보비는 숫자만 입력 하세요.(0입력 가능)");
		$('#adtmPay').focus();
		return;
	}

	if($('#adtmPay').val() < 0){
		alert("홍보비를 입력 하세요.(0입력 가능)");
		$('#adtmPay').focus();
		return;
	}

	if($('#stdStartDttm').val().length == 0){
		alert("판매기준을 선택 하세요.");
		$('#stdStartDttm').focus();
		return;
	}
	if($('#stdEndDttm').val().length == 0){
		alert("판매기준을 선택 하세요.");
		$('#stdEndDttm').focus();
		return;
	}

	$("#mkingDt").val($('#mkingDt').val().replace(/-/g, ""));
	$("#stdStartDttm").val($('#stdStartDttm').val().replace(/-/g, ""));
	$("#stdEndDttm").val($('#stdEndDttm').val().replace(/-/g, ""));


	document.frm.action ="<c:url value='/oss/mkingHistIns.do'/>";
	document.frm.submit();
}


function fn_Dummay(){

}

function fn_setLastTmEnd(){
	$("#endDttm").val("2200-12-31");
}


var g_strCd = "";
var g_strCdSub = "";

function fn_viewSelectProduct() {
	var retVal = window.open("<c:url value='/oss/findPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSoProduct() {
	var retVal = window.open("<c:url value='/oss/findSpPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSvProduct() {
	var retVal = window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_FindCorp(){
	var retVal = window.open("<c:url value='/oss/findCorpSMSMail.do'/>?type=Sel","findUser", "width=800, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectProduct(prdtId, corpNm, prdtNm, corpId) {

	$("#corpId").val(corpId);
	$("#corpNm").val(corpNm);
	$("#prdtNum").val(prdtId);
	$("#prdtNm").val(prdtNm);

}

function fn_selectCorp(corpNm, corpId) {
	$("#corpId").val(corpId);
	$("#corpNm").val(corpNm);
	$("#prdtNum").val('');
	$("#prdtNm").val('');
}


function fn_Dummay(){

}



$(document).ready(function(){

	var dt = new Date();
	$("#mkingDt").datepicker({
		dateFormat: "yy-mm-dd",
		//minDate : "${SVR_TODAY}",
		//changeYear: true,
		//yearRange: "c-100:c+200",
		//onClose : function(selectedDate) {
		//	$("#endDttm").datepicker("option", "minDate", selectedDate);
		//}
	});


	var dt = new Date();
	$("#stdStartDttm").datepicker({
		dateFormat: "yy-mm-dd",
		//minDate : "${SVR_TODAY}",
		//changeYear: true,
		//yearRange: "c-100:c+200",
		onClose : function(selectedDate) {
			$("#stdEndDttm").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#stdEndDttm").datepicker({
		dateFormat: "yy-mm-dd",
		//minDate : "${SVR_TODAY}",
		//changeYear: true,
		//yearRange: "c-100:c+200",
		onClose : function(selectedDate) {
			$("#stdStartDttm").datepicker("option", "maxDate", selectedDate);
		}
	});

	/*
	var arrPrt = ["AD", "RC", "SPC100", "SPC200", "SPC300", "SV"];
	var i;
	for(i=0; i<arrPrt.length; i++){
		$("#selectProduct"+arrPrt[i]).on("click", ".del", function(index) {
			$(this).parents("li").remove();
			var prdtNumList = [];
			$("input[name='prdtNum"+arrPrt[i]+"']").each(function () {
				prdtNumList.push($(this).val());
			});
			$("#prdtNumList").val(prdtNumList.toString());
		});
	}
	*/



});


</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=kwa" flush="false"></jsp:include>
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="frm" name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="mkingHistNum" value="${MKINGHISTVO.mkingHistNum }" />
				<input type="hidden" id="sYYYYMM" name="sYYYYMM" value="${MKINGHISTVO.sYYYYMM}"/>

				<div id="contents">
					<h4 class="title03">마케팅 이력 추가<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th>업체/상품 <span class="font_red">*</span></th>
							<td colspan="3">
								업체 검색:
								<div class="btn_sty04">
									<span><a href="javascript:fn_FindCorp();">업체 검색</a></span>
								</div>


								상품 검색:
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct();">리얼타임 상품검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct();">소셜 상품검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct();">기념품 상품검색</a></span>
								</div>

								<br/><br/>

								업체:<input type="text" name="corpId" id="corpId"  class="input_text5"  value="${MKINGHISTVO.corpId}" readonly="readonly"/>
								<input type="text" name="corpNm" id="corpNm"  class="input_text30"  value="${MKINGHISTVO.corpNm}" readonly="readonly"/>
								<br/>
								상품:<input type="text" name="prdtNum" id="prdtNum"  class="input_text5"  value="${MKINGHISTVO.prdtNum}" readonly="readonly"/>
								<input type="text" name="prdtNm" id="prdtNm"  class="input_text30"  value="${MKINGHISTVO.prdtNm}" readonly="readonly"/>

							</td>
						</tr>

						<tr>
							<th>홍보일자<span class="font_red">*</span></th>
							<td>
								<input type="text" name="mkingDt" id="mkingDt"  class="input_text5" readonly="true"  value="${MKINGHISTVO.mkingDt}" />
							</td>
							<th>진행매체</th>
							<td>
								<select id="media" name="media" >
									<option value="1" <c:if test="${MKINGHISTVO.media == '1'}">selected="selected"</c:if> >키워드</option>
									<option value="2" <c:if test="${MKINGHISTVO.media == '2'}">selected="selected"</c:if> >DA</option>
									<option value="3" <c:if test="${MKINGHISTVO.media == '3'}">selected="selected"</c:if> >(탐)블로그</option>
									<option value="4" <c:if test="${MKINGHISTVO.media == '4'}">selected="selected"</c:if> >(탐)페이스북</option>
									<option value="5" <c:if test="${MKINGHISTVO.media == '5'}">selected="selected"</c:if> >(탐)인스타</option>
									<option value="6" <c:if test="${MKINGHISTVO.media == '6'}">selected="selected"</c:if> >(외)블로그</option>
									<option value="7" <c:if test="${MKINGHISTVO.media == '7'}">selected="selected"</c:if> >(외)SNS</option>
									<option value="8" <c:if test="${MKINGHISTVO.media == '8'}">selected="selected"</c:if> >기획전</option>
									<option value="9" <c:if test="${MKINGHISTVO.media == '9'}">selected="selected"</c:if> >이벤트</option>
									<option value="10" <c:if test="${MKINGHISTVO.media == '10'}">selected="selected"</c:if> >기타</option>
								</select>
							</td>
						</tr>

						<tr>
							<th>홍보비 <span class="font_red">*</span></th>
							<td >
								<input type="text" name="adtmPay" id="adtmPay"  class="input_text5"  value="${MKINGHISTVO.adtmPay}"/>
							</td>
							<th>판매기준 <span class="font_red">*</span></th>
							<td >
								<input type="text" name="stdStartDttm" id="stdStartDttm"  class="input_text5" readonly="true"  value="${MKINGHISTVO.stdStartDttm}" />
								~
								<input type="text" name="stdEndDttm" id="stdEndDttm"  class="input_text5" readonly="true"  value="${MKINGHISTVO.stdEndDttm}" />
							</td>
						</tr>

						<tr>
							<th>비고<span class="font_red"></span></th>
							<td colspan="3">
								<input type="text" name="memo" id="memo"  class="input_text_full" maxlength="100" value="${MKINGHISTVO.memo}"/>
							</td>
						</tr>

					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_Ins()">저장</a>
						</li>
						<li class="btn_sty01">
							<a href="javascript:history.back();">뒤로</a>
						</li>
					</ul>
				</div>
			</form:form>
			<!--//상품등록-->
			<!--//본문-->
		</div>

	</div>
</div>
</body>
</html>