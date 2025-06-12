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

<validator:javascript formName="PRMTVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title>탐나오 관리자 시스템 > 프로모션</title>

<script type="text/javascript">

function fn_PromotionList() {
	location.href="<c:url value='/mas/prmt/promotionList.do'/>?pageIndex=${PRMTVO.pageIndex}";
}

function fn_savePromotion() {
	if(!validatePRMTVO(document.PRMTVO)){
		return;
	} else if($("#prdtNumList").val() == "") {
		alert("상품을 선택해 주세요.")
		return ;
	}
	$("#startDt").val($('#startDt').val().replace(/-/g, ""));
	$("#endDt").val($('#endDt').val().replace(/-/g, ""));

	document.PRMTVO.action ="<c:url value='/mas/prmt/insertPromotion.do'/>";
	document.PRMTVO.submit();
}

function fn_viewSelectProduct() {

	$.ajax({
		url : "<c:url value='/mas/prmt/viewSelectProduct.ajax'/>",
		data : "",
		success : function(data) {
			$("#div_productList_html").html(data);
			show_popup($("#div_productList"));
		},
		error :fn_AjaxError
	});

}

function fn_selectProduct() {
	var productList = "";
	var prdtNumList = $("#prdtNumList").val().split(',');
	$("input[name='prdt_check']:checked").each(function() {
		if($.inArray($(this).val(), prdtNumList) == -1) {
			prdtNumList.push($(this).val());
			productList +="<li>"+
							$(this).parent().siblings(".prmtProductNm").text()+
							' <a href="#"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>' +
							'<input type="hidden" name="prdtNum" value="'+ $(this).val() + '"/>'+
							'</li>';

		}

	});
	$("#prdtNumList").val(prdtNumList.toString());
	$("#selectProduct ul").append(productList);
	close_popup($("#div_productList"));
}

$(document).ready(function(){
	//파일 올리기 관련
	var maxFileNum = 10;
	var multi_selector = new MultiSelector(document.getElementById('egovComFileList'), maxFileNum);
	multi_selector.addElement(document.getElementById('egovComFileUploader'));
});

$(function() {
	$("#startDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			$("#endDt").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#endDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+3y",
		onClose : function(selectedDate) {
			$("#startDt").datepicker("option", "maxDate", selectedDate);
		}
	});

	$("#selectProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
		var prdtNumList = [];
		$("input[name='prdtNum']").each(function () {
			prdtNumList.push($(this).val());
		});
		$("#prdtNumList").val(prdtNumList.toString());
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=promotion" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="PRMTVO" name="PRMTVO" method="post" enctype="multipart/form-data">
				<input type="hidden" name="prdtViewDiv" value="1000" />

				<div id="contents">
					<h4 class="title03">프로모션 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>구분<span class="font_red">*</span></th>
							<td colspan="3">
								<c:forEach var="prmtDiv" items="${prmtCdList}" varStatus="status">
									<c:if test="${(prmtDiv.cdNum eq Constant.PRMT_DIV_EVNT) or (prmtDiv.cdNum eq Constant.PRMT_DIV_NOTI)}">
										<label><input type="radio" name="prmtDiv" value="${prmtDiv.cdNum}" <c:if test="${prmtDiv.cdNum eq Constant.PRMT_DIV_EVNT}">checked</c:if> /> ${prmtDiv.cdNm}</label>
									</c:if>
								</c:forEach>
								<span class="font_red">※요금 할인 프로모션 등록 시, [요금관리] 탭에서 할인 가격 설정 필수</span>
							</td>
						</tr>
						<tr>
							<th>프로모션명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="prmtNm" id="prmtNm" class="input_text_full" maxlength="30" />
								<form:errors path="prmtNm" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>프로모션 내용</th>
							<td colspan="3">
								<textarea name="prmtExp" id="prmtExp" cols="70" rows="5" maxlength="1000"></textarea>
								<form:errors path="prmtExp" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>시작일<span class="font_red">*</span></th>
							<td>
								<form:input path="startDt" id="startDt" class="input_text5" readonly="true" value="${prmtVO.startDt}" />
								<form:errors path="startDt" cssClass="error_text" />
							</td>
							<th>종료일<span class="font_red">*</span></th>
							<td>
								<form:input path="endDt" id="endDt" class="input_text5" readonly="true" value="${prmtVO.endDt}" />
								<form:errors path="endDt" cssClass="error_text" />
							</td>
						</tr>
						<input type="hidden" name="listImgFile" value="" />
						<%-- <tr>
							<th>목록이미지</th>
							<td colspan="3">
								<input type="file" id="listImgFile" name="listImgFile" accept="image/*" style="width: 70%" /><span class="font_red">사이즈 : 640px*460px</span>
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<%-- <tr>
							<th>상세이미지</th>
							<td colspan="3">
								<input type="file" id="detailImgFile" name="detailImgFile" accept="image/*" style="width: 70%" /><span class="font_red">사이즈 : 가로 980px</span>
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<%--<input type="hidden" name="mobileImgFile" value="" />
						<input type="hidden" name="mainImgFile" value="" />
						<input type="hidden" name="winsImgFile" value="" />--%>
						<%-- <tr>
							<th>모바일이미지</th>
							<td colspan="3">
								<input type="file" id="mobileImgFile" name="mobileImgFile" accept="image/*" style="width: 70%" /><span class="font_red">사이즈 : 가로 720px</span>
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<tr>
							<th rowspan="2">적용상품<span class="font_red">*</span></th>
							<td colspan="3">
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct();">상품선택</a></span>
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
						<tr style="visibility:hidden">
							<th>첨부파일</th>
							<td colspan="3">
								<div id="egovComFileList" class="text_input04"></div>
								<input type="file" name="file" id="egovComFileUploader" accept="*" class="full"/>
								<br>
								<c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
								<br>
								<span class="font_red">※ 특정파일의 경우 방화벽에서 차단될수 있습니다.</span>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04"><a href="javascript:fn_savePromotion()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:fn_PromotionList()">목록</a></li>
					</ul>
				</div>
			</form:form>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
<div class="blackBg"></div>
<div id="div_productList" class="lay_popup lay_ct" style="display:none;">
<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_productList'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a></span>
<div id="div_productList_html"></div>
</div>
</body>
</html>