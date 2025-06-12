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

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5upload/js/dext5upload.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBh0Ju395u0pT0bl9w7H-Ux0jVglA-wzdc&sensor=false"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>

<validator:javascript formName="SP_PRDTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title>탐나오 관리자 시스템 > 상품관리 > 상품등록</title>

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
            document.getElementById('roadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

/**
 * 주소에 따른 경도 위도 구하기
 */
function fn_FindLocation(){
	var addr = $("#roadNmAddr").val();

	if(isNull(addr)){
		alert("주소를 입력해주세요.");
		$("#dtlAddr").focus();
		return;
	}

var geocoder = new daum.maps.services.Geocoder();

    var callback = function(result, status) {
	    if(status === daum.maps.services.Status.OK){
            var lat = result[0].y
            var lng = result[0].x

	    	$("#lon").val(lng);
			$("#lat").val(lat);
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

function fn_InsertSpPrdtInfo(){
	// validation 체크
	if($("#ctgr").val() == '') {
		alert("카테고리를 선택해 주세요.");
		return ;
	}

	if(!validateSP_PRDTINFVO(document.SP_PRDTINFVO)){
		return;
	}

	if($(":radio[name=prdtDiv]:checked").val() != "TOUR") {

		if($(":radio[name=exprDaynumYn]:checked").val() == "Y") {
			if($("#exprDaynum").val() == "" ) {
				alert("유효일수를 입력해 주세요.");
				$("#exprDaynum").focus();
				return ;
			}
		} else {
			if($("#exprStartDt").val() == '' || $("#exprEndDt").val() == '' ) {
				alert("유효기간을 입력해 주세요.");
				return ;
			}
		}
		if($(":radio[name=prdtDiv]:checked").val() != "FREE") {
			if(isNull($("#useAbleTm").val())) {
				alert("이용가능시간을 입력해 주세요.");
				$("#useAbleTm").focus();
				return ;
			}
		}
	}

	if($("#select_ctgr_1depth").val() == "${Constant.CATEGORY_ADRC}"){
		if($(":radio[name=prdtDiv]:checked").val() != "TOUR") {
			alert("특가상품은 여행상품(날짜별 요금을 적용하는 상품)만 선택이 가능합니다.");
			return;
		}
	}

	if($("#useAbleTm").val() != "" && (Number($("#useAbleTm").val()) > 72 || !isNumber($("#useAbleTm").val()))) {
		alert("이용가능시간이 잘못 입력되었습니다. 1~72 중에 입력하실 수 있습니다.");
		return ;
	}

	if($("#linkPrdtYn").val() == "${Constant.FLAG_Y}"){
		if(isNull($("#linkUrl").val())){
			alert("LINK URL을 입력해주세요");
			$("#linkUrl").focus();
			return;
		}
	}

	$("#saleStartDt").val($('#saleStartDt').val().replace(/-/g, ""));
	$("#saleEndDt").val($('#saleEndDt').val().replace(/-/g, ""));
	$("#exprStartDt").val($('#exprStartDt').val().replace(/-/g, ""));
	$("#exprEndDt").val($('#exprEndDt').val().replace(/-/g, ""));

	$("#useQlfct").val(DEXT5.getBodyValueExLikeDiv('editor1'));
	$("#cancelGuide").val(DEXT5.getBodyValueExLikeDiv('editor2'));

	DEXT5UPLOAD.Transfer("upload1");

	//document.SP_PRDTINFVO.action = "<c:url value='/mas/sp/insertSocialProductInfo.do' />";
	//document.SP_PRDTINFVO.submit();
}

function DEXT5UPLOAD_OnTransfer_Complete() {
	 if (DEXT5UPLOAD.GetNewUploadListForText()) {
		 var jsonFileList = DEXT5UPLOAD.GetNewUploadListForJson("upload1");
		 document.getElementById("fileList").value = jsonFileList.uploadPath;
	 }
    document.SP_PRDTINFVO.action = "<c:url value='/mas/sp/insertSocialProductInfo.do' />";
	document.SP_PRDTINFVO.submit();
}

/**
 * 목록
 */
function fn_socialProductList() {
	document.SP_PRDTINFVO.action = "<c:url value='/mas/sp/productList.do' />";
	document.SP_PRDTINFVO.submit();
}

function loadSubCategory(cdNum) {
	$("#select_ctgr_2depth option:eq(0)").nextAll().remove();
	$.ajax({
		url: "<c:url value='/getCodeList.ajax'/>",
		data: "cdNum="+cdNum,
		success:function(data) {
			var cdList = data.cdList;
			var dataArr = [];
			var inx = 0;
			if( cdList == "")
				$("#ctgr").val($("#select_ctgr_1depth option:selected").val());
			else {
				$(cdList).each( function() {
					dataArr[inx++] = "<option value=" + this.cdNum + ">" + this.cdNm + "</option> ";
				});

				$("#select_ctgr_2depth").append(dataArr);
			}
		},
		error : fn_AjaxError
	})
}

$(function() {
	$("#saleStartDt").datepicker({
			dateFormat: "yy-mm-dd",
			minDate : "${SVR_TODAY}",
			maxDate : "+1y",
			onClose : function(selectedDate) {
				if($('#saleEndDt').val() != "9999-01-01") {
					$("#saleEndDt").datepicker("option", "minDate", selectedDate);
				}
				$("#exprStartDt").datepicker('option', 'minDate', selectedDate);
			}
	});
	$("#saleEndDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			$("#saleStartDt").datepicker("option", "maxDate", selectedDate);
			if($('#saleEndDt').val() == "9999-01-01"){
				$("#saleStartDt").datepicker("option", "maxDate", "9999-01-01");
			}
			$("#exprEndDt").datepicker('option', 'minDate', selectedDate);
		},
		beforeShow : function() {
			$('#saleEndDt').css('color','');
			$('#saleEndDt').css('background-color','');
			$('#saleEndDt').val($("#saleStartDt").val());

		}
	});
	$("#exprStartDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			//$("#exprEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#exprEndDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate :"${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			$("#exprStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
	$("#select_ctgr_1depth").change(function() {
		loadSubCategory($("#select_ctgr_1depth option:selected").val());
		$("#tr_ad").hide();
		$("#tr_ad2").hide();
	});

	$("#select_ctgr_2depth").change(function() {
		$("#ctgr").val($("#select_ctgr_2depth option:selected").val());
		if($(this).val() == "${Constant.CATEGORY_PACK_AD}"){
			$("#tr_ad").show();
			$("#tr_ad2").show();
		}else{
			$("#tr_ad").hide();
			$("#tr_ad2").hide();
		}

	});

	$("input[name=prdtDiv]").change(function() {
		if("${Constant.SP_PRDT_DIV_COUP}" == $(this).val()) {
			$("#tr_exprDiv").show();
			$(":radio[name='exprDaynumYn']:radio[value='N']").prop("checked",true);
			$("#tr_exprDt").show();
			$("#tr_exprDay").hide();
			$("#tr_cancelGuide").show();
			$("#tr_disInf").hide();
			$("#disInf").val('');
		} else if("${Constant.SP_PRDT_DIV_FREE}" == $(this).val()) {
			$("#tr_exprDiv").hide();
			$("#tr_disInf").show();
			$("#tr_cancelGuide").hide();
			$("#tr_exprDt").show();
			$("#tr_exprDay").hide();
		} else {
			$("#tr_disInf").hide();
			$("#tr_cancelGuide").show();
			$("#tr_exprDt").hide();
			$("#tr_exprDay").hide();
			$("#disInf").val('');
			$("#tr_exprDiv").hide();
		}
	});

	$("input[name=exprDaynumYn]").change(function() {
		if($(this).val() == "${Constant.FLAG_Y}") {
			$("#tr_exprDt").hide();
			$("#tr_exprDay").show();
			$("#exprStartDt").val('');
			$("#exprEndDt").val('');
		} else {
			$("#tr_exprDt").show();
			$("#tr_exprDay").hide();
			$("#exprDaynum").val(0);
		}
	});
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="SP_PRDTINFVO" name="SP_PRDTINFVO" method="post">
				<input type="hidden" name="prdtNum" value="${SP_PRDTINFVO.prdtNum}" />
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<h4 class="title03">상품 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<c:if test="${lsLinkYn eq Constant.FLAG_Y || lsLinkYn eq 'J' || lsLinkYn eq 'V'}" >
					<tr>
						<th>
							<c:if test="${lsLinkYn eq 'Y'}">
								LS컴퍼니 상품번호
							</c:if>
							<c:if test="${lsLinkYn eq 'J'}">
								야놀자 상품번호
							</c:if>
							<c:if test="${lsLinkYn eq 'V'}">
								브이패스 상품번호
							</c:if>
							<span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="lsLinkPrdtNum" id="lsLinkPrdtNum"  class="input_text10" maxlength="30"/>
							<form:errors path="lsLinkPrdtNum"  cssClass="error_text" />
						</td>
					</tr>
					</c:if>
					<tr>
						<th scope="row">상품카테고리<span class="font_red">*</span></th>
						<td colspan="3">
							<select id="select_ctgr_1depth" name="select_ctgr_1depth">
								<option value="">대분류 선택</option>
								<c:forEach var="categoryList" items="${categoryList}">
								<option value="${categoryList.cdNum}">${categoryList.cdNm}</option>
								</c:forEach>
							</select>
							<select id="select_ctgr_2depth" name="select_ctgr_2depth">
								<option value="">소분류 선택</option>
							</select>
							<input type="hidden"  id="ctgr" name="ctgr" />
							<form:errors path="ctgr"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>상품명<span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="prdtNm" id="prdtNm"  class="input_text50" maxlength="30" value="${spPrdtInf.prdtNm}"/>
							<form:errors path="prdtNm"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>상품구분<span class="font_red">*</span></th>
						<td  colspan="3">
							<input type="radio" name="prdtDiv" id="prdtDiv1" value="${Constant.SP_PRDT_DIV_TOUR}"> <label for="prdtDiv1">여행상품 : 날짜별 요금을 적용하는 상품</label></input><br />
							<input type="radio" name="prdtDiv" id="prdtDiv2" value="${Constant.SP_PRDT_DIV_COUP}"> <label for="prdtDiv2">쿠폰상품 : 유효기간 내에 사용하는 상품</label></input><br />
							<input type="radio" name="prdtDiv" id="prdtDiv3" value="${Constant.SP_PRDT_DIV_FREE}"> <label for="prdtDiv3">무료쿠폰 : 구매 없이 이용가능한 무료할인쿠폰</label></input>
							<form:errors path="prdtDiv"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>상품정보</th>
						<td colspan="3">
							<form:input path="prdtInf" id="prdtInf" value="${spPrdtInf.prdtInf}" class="input_text_full" maxlength="66" />
							<form:errors path="prdtInf"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<p>
								<input type="text" name="srchWord1" id="srchWord1" maxlength="30" value="${spPrdtInf.srchWord1}" />
								<input type="text" name="srchWord2" id="srchWord2" maxlength="30" value="${spPrdtInf.srchWord2}" />
								<input type="text" name="srchWord3" id="srchWord3" maxlength="30" value="${spPrdtInf.srchWord3}" />
								<input type="text" name="srchWord4" id="srchWord4" maxlength="30" value="${spPrdtInf.srchWord4}" />
								<input type="text" name="srchWord5" id="srchWord5" maxlength="30" value="${spPrdtInf.srchWord5}" />
							</p>
							<p>
								<input type="text" name="srchWord6" id="srchWord6" maxlength="30" value="${spPrdtInf.srchWord6}" />
								<input type="text" name="srchWord7" id="srchWord7" maxlength="30" value="${spPrdtInf.srchWord7}" />
								<input type="text" name="srchWord8" id="srchWord8" maxlength="30" value="${spPrdtInf.srchWord8}" />
								<input type="text" name="srchWord9" id="srchWord9" maxlength="30" value="${spPrdtInf.srchWord9}" />
								<input type="text" name="srchWord10" id="srchWord10" maxlength="30" value="${spPrdtInf.srchWord10}" />
							</p>
							<br /><span class="font02">※ 상품의 주요 특징을 적어주세요 (사용자의 통합 검색 시 검색되는 검색어 입니다)</span>
						</td>
					</tr>
					<tr>
						<th>판매시작일 <span class="font_red">*</span></th>
						<td>
							<form:input path="saleStartDt" id="saleStartDt"  class="input_text5" readonly="true"  value="${spPrdtInf.saleStartDt}" />
							<form:errors path="saleStartDt"  cssClass="error_text" />
						</td>
						<th>판매종료일 <span class="font_red">*</span></th>
						<td>
							<form:input path="saleEndDt" id="saleEndDt"  class="input_text5" readonly="true" value="${spPrdtInf.saleEndDt}" />
							<form:errors path="saleEndDt"  cssClass="error_text" />
							<div class="btn_sty07" style="margin-left:5px;"><span><a href="javascript:$('#saleEndDt').val('9999-01-01');$('#saleEndDt').css('color','#eeeeee');$('#saleEndDt').css('background-color','#eeeeee');$('#saleStartDt').datepicker('option', 'maxDate', '9999-01-01');">종료일없음</a></span></div>
						</td>
					</tr>
					<tr id="tr_ad" style="display:none">
						<th>숙소 지역 <span class="font_red">*</span></th>
						<td>
							<select name="adArea" >
								<c:forEach var="data" items="${cdAdar}" varStatus="status">
									<option value="${data.cdNum}">${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>숙소 구분 <span class="font_red">*</span></th>
						<td>
							<select name="adDiv" >
								<c:forEach var="data" items="${cdAddv}" varStatus="status">
									<option value="${data.cdNum}">${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="tr_ad2" style="display:none">
						<th>주요정보</th>
						<td colspan="3">
							<c:forEach var="icon" items="${iconCd}">
								<input type="checkbox" name="iconCd" value="${icon.cdNum}">${icon.cdNm}</input>
							</c:forEach>
						</td>
					</tr>
					<tr id="tr_ad3">
						<th>업체주소</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
							<form:input path="roadNmAddr" id="roadNmAddr"  class="input_text15" readonly="readonly" />
							<form:input path="dtlAddr" id="dtlAddr"  class="input_text15" maxlength="100" />
							<form:errors path="roadNmAddr"  cssClass="error_text" />
							<form:errors path="dtlAddr"  cssClass="error_text" />
						</td>
					</tr>
					<tr id="tr_ad4">
						<th>위도/경도</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
							위도 : <form:input path="lat" id="lat" readonly="readonly" />
							경도 : <form:input path="lon" id="lon" readonly="readonly" />
							<form:errors path="lat"  cssClass="error_text" />
							<form:errors path="lon"  cssClass="error_text" />
						</td>
					</tr>
					<c:if test="${linkPrdtUseYn eq Constant.FLAG_Y}">
					<tr>
						<th>LINK 상품 여부 <span class="font_red">*</span></th>
						<td>
							<select name="linkPrdtYn" id="linkPrdtYn">
								<option value="${Constant.FLAG_N}">사용안함</option>
								<option value="${Constant.FLAG_Y}">사용</option>
							</select>
						</td>
						<th>LINK URL</th>
						<td>
							<input type="text" name="linkUrl" id="linkUrl" class="input_text30" maxlength="300" />
							<span class="font02">'http://','https://'등을 반드시 입력 하세요.</span>
						</td>
					</tr>
					</c:if>
					<tr id="tr_exprDiv" style="display:none">
						<th>유효구분 <span class="font_red">*</span></th>
						<td>
							<input type="radio" name="exprDaynumYn" id="exprDaynumYn1" value="${Constant.FLAG_N}" checked="checked"> <label for="exprDaynumYn1">유효기간 : 유효기간 내에 사용</label></input><br />
							<input type="radio" name="exprDaynumYn" id="exprDaynumY2" value="${Constant.FLAG_Y}"> <label for="exprDaynumY2">유효일자 : 구매일로 부터 유효일자 내에 사용</label></input><br />
						</td>
						<th>이용가능시간 <span class="font_red">*</span></th>
						<td>
							<form:input path="useAbleTm" id="useAbleTm"  class="input_text10" value="${spPrdtInf.useAbleTm}" placeholder="0~72" /> 시간
							<br /><span class="font_red">즉시이용 가능하면 0 / 구매후 3시간 이후 가능이면 3 (72까지 입력가능)</span>
						</td>
					</tr>
					<tr id="tr_exprDt" style="display:none">
						<th>유효기간 <span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="exprStartDt" id="exprStartDt" class="input_text5" readonly="true" value="${spPrdtInf.exprStartDt}"/> ~ <form:input path="exprEndDt" id="exprEndDt" class="input_text5" readonly="true" value="${spPrdtInf.exprEndDt}"/>
							<form:errors path="exprStartDt"  cssClass="error_text" /><form:errors path="exprEndDt"  cssClass="error_text" />
						</td>
					</tr>
					<tr id="tr_exprDay" style="display:none">
						<th>유효일수 <span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="exprDaynum" id="exprDaynum" class="input_text10"  maxlength="10" value="${spPrdtInf.exprDaynum}"/> 일
						</td>
					</tr>
					<tr id="tr_disInf" style="display:none">
						<th>할인정보</th>
						<td colspan="3">
							<form:input path="disInf" id="disInf" class="input_text_full"  maxlength="13" value="${spPrdtInf.disInf}"/>
							<form:errors path="disInf"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>상품목록 이미지<br><span class="font02">(등록 사이즈 : 600*400)</span></th>
						<td colspan="3">
							<script type="text/javascript">
								DEXT5UPLOAD.config.HandlerUrl = "<c:url value='/mas/dext/uploadHandler.dext'/>";
								//DEXT5UPLOAD.config.Security.EncryptParam = '0';
								DEXT5UPLOAD.config.Views = 'thumbs';
								var upload1 = new Dext5Upload("upload1");
							</script>
							<input type="hidden" id="fileList" name="fileList" value="" />
						</td>
					</tr>

					<tr>
						<th>홍보영상</th>
						<td colspan="3">
							<input name="adMov" id="adMov" value="${spPrdtInf.adMov}" class="input_text_full" maxlength="300" />

							<br /><span class="font02">※ YouTube 동영상의 경로를 넣으시면 됩니다. ( https://www.youtube.com/embed/유튜브영상고유번호 )</span>

						</td>
					</tr>
					
					<tr>
						<th>사전예약</th>
						<td  colspan="3">
							<input type="radio" name="advRvYn"  value="${Constant.FLAG_Y}" >&nbsp;Y</input>&nbsp;
							<input type="radio" name="advRvYn"  value="${Constant.FLAG_N}" checked>&nbsp;N </input>&nbsp;
						</td>
					</tr>	

					<tr>
						<th>사용조건</th>
						<td colspan="3">
							<script type="text/javascript">
							 var editor1 = new Dext5editor('editor1');
							</script>
							<input type="hidden" name="useQlfct" id="useQlfct" value="${spPrdtInf.useQlfct}" />
							<form:errors path="useQlfct"  cssClass="error_text" />
						</td>
					</tr>
					<tr id="tr_cancelGuide">
						<th>취소안내</th>
						<td colspan="3">
							<div>
							<script type="text/javascript">

							 DEXT5.config.SkinName = 'blue';
							 var editor2 = new Dext5editor('editor2');
							</script>
							</div>
							<input type="hidden"  name="cancelGuide" id="cancelGuide" value="${spPrdtInf.cancelGuide}" />
							<form:errors path="cancelGuide"  cssClass="error_text" />
						</td>
					</tr>

					<tr>
						<th>지역<span class="font02"></span></th>
						<td colspan="3">
							<select name="area" >
								<option value="">-없음-</option>
								<c:forEach var="data" items="${cdAdar}" varStatus="status">
									<option value="${data.cdNum}" <c:if test="${data.cdNum==fn:trim(spPrdtInf.area)}">selected="selected"</c:if> >${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04">
						<a href="javascript:fn_InsertSpPrdtInfo()">저장</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_socialProductList()">목록</a>
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