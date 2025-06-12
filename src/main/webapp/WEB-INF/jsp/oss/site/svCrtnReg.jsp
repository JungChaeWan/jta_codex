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

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<validator:javascript formName="SVCRTNVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Reg() {
	if(!validateSVCRTNVO(document.SVCRTNVO)){
		return;
	}
	if($("#listImgFile").val() != "") {
		var fileName = $('#listImgFile').val().toLowerCase();//파일명
		var _fileLen = fileName.length;
		var _lastDot = fileName.lastIndexOf('.');
		var strSub = fileName.substring(_lastDot, _fileLen).toLowerCase();

		if(!(strSub.toLowerCase() == ".jpg" || strSub.toLowerCase() == ".gif" || strSub.toLowerCase() == ".png" )){
			alert("목록이미지는 이미지파일(jpg, gif, png) 파일만 등록이 가능합니다.");
			return false;
		}
	}

	if($("#prdtNumList").val() == "") {
		alert("상품을 선택해 주세요.")
		return ;
	}
	
	document.SVCRTNVO.action ="<c:url value='/oss/svCrtnReg.do'/>";
	document.SVCRTNVO.submit();
}

var prdtPopup;

function fn_viewSelectSvProduct() {
	prdtPopup = window.open("<c:url value='/oss/findSvPrdt.do'/>", "findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectProduct(prdtId, corpNm, prdtNm) {
	var isA = true;

	$("input[name='prdtNum']").each(function(){
		if($(this).val() == prdtId) {
			isA = false;
			return;
		}
	});

	if(isA == false) {
		prdtPopup.alert("<spring:message code='errors.common.exist' />");
		return;
	}
	var strHtml = "<li>";
	strHtml += "<input type='hidden' name='prdtNum' value='" + prdtId + "'/>";
	strHtml += "[" + prdtId + "][" + corpNm + "][" + prdtNm + "] ";
	strHtml += "<a href='javascript:void(0)'><span class='del'><img src='/images/web/icon/close5.gif' alt='삭제'></span></a>";
	strHtml += "</li>";

	$("#selectProduct ul").append(strHtml);
	
	var prdtNumList = [];
	$("input[name='prdtNum']").each(function () {
		prdtNumList.push($(this).val());
	});
	$("#prdtNumList").val(prdtNumList.toString());
}

$(document).ready(function(){

	$("#selectProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
		var prdtNumList = [];
		$("input[name='prdtNum']").each(function () {
			prdtNumList.push($(this).val());
		});
		$("#prdtNumList").val(prdtNumList.toString());
	});

	//파일 올리기 관련
	var maxFileNum = 10;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=curation" />
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<div id="contents">
				<form:form commandName="SVCRTNVO" name="SVCRTNVO" method="post" enctype="multipart/form-data">
					<input type="hidden" name="crtnNum" value="${crtnVO.crtnNum }" />
					<input type="hidden" name="crtnDiv" value="${Constant.PRMT_DIV_EVNT}" />

					<h4 class="title03">큐레이션 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th>큐레이션명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="crtnNm" id="crtnNm"  class="input_text_full" maxlength="30" value="${crtnVO.crtnNm}"/>
								<form:errors path="crtnNm"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>간략설명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="simpleExp" id="simpleExp"  class="input_text_full" value="${crtnVO.simpleExp}"/>
								<form:errors path="simpleExp"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>목록이미지</th>
							<td colspan="3">
								<input type="file" id="listImgFile" name="listImgFile" accept="image/*" style="width: 70%" /><span class="font_red">사이즈 : 640px*460px</span>
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr>
						<tr>
							<th>출력 여부</th>
							<td colspan="3">
								<select name="printYn" id="printYn">
									<option value="${Constant.FLAG_Y}" selected>출력</option>
									<option value="${Constant.FLAG_N}">미출력</option>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="2">관련상품<span class="font_red"></span></th>
							<td colspan="3">
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct();">상품검색</a></span>
								</div>
								<input type="hidden" name="prdtNumList" id="prdtNumList"/>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<div id="selectProduct">
									<ul>
									</ul>
								</div>
							</td>
						</tr>
					</table>
				</form:form>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:fn_Reg()">저장</a></li>
					<li class="btn_sty01"><a href="javascript:history.back();">뒤로</a></li>
				</ul>
			</div>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
</div>
</body>
</html>