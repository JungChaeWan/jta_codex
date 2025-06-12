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
	if(!validatePRMTVO(document.PRMTVO)) {
		return ;
	} else if($("#prdtNumList").val() == "") {
		alert("상품을 선택해 주세요.")
		return ;
	}
	$("#startDt").val($('#startDt').val().replace(/-/g, ""));
	$("#endDt").val($('#endDt').val().replace(/-/g, ""));

	document.PRMTVO.action ="<c:url value='/mas/prmt/updatePromotion.do'/>";
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

			productList += '<li>';
			productList += $(this).parent().siblings(".prmtProductNm").text();
			productList += '<a href="#"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
			productList += '<input type="hidden" name="prdtNum" value="'+ $(this).val() + '"/>';
			productList += '</li>';
		}

	});

	$("#prdtNumList").val(prdtNumList.toString());
	$("#selectProduct ul").append(productList);

	close_popup($("#div_productList"));
}

function fn_approvalPromotion(statusCd) {
	$.ajax({
		url : "<c:url value='/mas/prmt/approvalPromotion.ajax'/>",
		data : "prmtNum=${prmtVO.prmtNum}&statusCd=" + statusCd,
		dataType:"json",
		success: function(data) {
			location.href="?prmtNum=${prmtVO.prmtNum }&pageIndex=${PRMTVO.pageIndex}";
		},
		error : fn_AjaxError
	});
}

//이미지 삭제.
function fn_DelImg(type) {
	$("#d_"+type + "Img").hide();
	$("#"+type +"ImgFile").show();
	$("#"+type+"Img").val('');
}

$(document).ready(function(){
	//파일 올리기 관련
	if("${10 - fn:length(prmtFileList)}" > 0) {
		var maxFileNum = ${10 - fn:length(prmtFileList)};
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	}
});

function fn_delFile(id){
	if(confirm("첨부파일은 바로 삭제 되어 복구 할수 없습니다.\n삭제 하시겠습니까?")){
		//document.frm.fileNum.value = id;
		document.PRMTVO.action = "<c:url value='/mas/prmt/promotionFileDel.do'/>?prmtFileNum=" + id;
		document.PRMTVO.submit();
	}
}

function fn_DownloadFile(Id){
	frmFileDown.location = "<c:url value='/mas/prmt/promotionFileDown.do'/>?prmtFileNum=" + Id ;
}

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

	// 값 셋팅.
	if($("#prdtNumList").val() == "" ) {
		var prdtNumList = [];
		$("input[name='prdtNum']").each(function () {
			prdtNumList.push($(this).val());
		});
		$("#prdtNumList").val(prdtNumList.toString());
	}
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
				<input type="hidden" name="prmtNum" value="${prmtVO.prmtNum }" />
				<input type="hidden" name="prdtViewDiv" value="1000" />

				<div id="contents">
					<h4 class="title03">프로모션 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">번호</th>
							<td colspan="3">${prmtVO.prmtNum}</td>
						</tr>
						<tr>
							<th>구분<span class="font_red">*</span></th>
							<td colspan="3">
								<c:forEach var="prmtDiv" items="${prmtCdList}" varStatus="status">
									<c:if test="${(prmtDiv.cdNum eq Constant.PRMT_DIV_EVNT) or (prmtDiv.cdNum eq Constant.PRMT_DIV_NOTI)}">
										<!-- 20.05.13   승인일 경우 구분 수정 불가_김지연 -->
										<c:choose>
											<c:when test="${prmtVO.statusCd eq Constant.TRADE_STATUS_APPR}">
												<label><input type="radio" name="prmtDiv" value="${prmtDiv.cdNum}"  onclick="return(false);" <c:if test="${prmtDiv.cdNum eq prmtVO.prmtDiv}">checked</c:if> /> ${prmtDiv.cdNm}</label>
											</c:when>
											<c:otherwise>
												<label><input type="radio" name="prmtDiv" value="${prmtDiv.cdNum}" <c:if test="${prmtDiv.cdNum eq prmtVO.prmtDiv}">checked</c:if> /> ${prmtDiv.cdNm}</label>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>프로모션명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="prmtNm" id="prmtNm" class="input_text_full" maxlength="20" value="${prmtVO.prmtNm}"/>
								<form:errors path="prmtNm" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>프로모션 내용</th>
							<td colspan="3">
								<textarea name="prmtExp" id="prmtExp" cols="70" rows="5" maxlength="1000"><c:out value="${prmtVO.prmtExp}" /></textarea>
								<form:errors path="prmtExp" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>시작일<span class="font_red">*</span></th>
							<td>
								<form:input path="startDt" id="startDt" class="input_text5" readonly="true"  value="${fn:substring(prmtVO.startDt,0,4)}-${fn:substring(prmtVO.startDt,4,6)}-${fn:substring(prmtVO.startDt,6,8)}" />
								<form:errors path="startDt" cssClass="error_text" />
							</td>
							<th>종료일<span class="font_red">*</span></th>
							<td>
								<form:input path="endDt" id="endDt" class="input_text5" readonly="true" value="${fn:substring(prmtVO.endDt,0,4)}-${fn:substring(prmtVO.endDt,4,6)}-${fn:substring(prmtVO.endDt,6,8)}" />
								<form:errors path="endDt" cssClass="error_text" />
							</td>
						</tr>
						<%-- <tr>
							<th>목록이미지</th>
							<td colspan="3">
								<c:if test="${not empty prmtVO.listImg }">
									<div id="d_listImg">
										<c:out value="${prmtVO.listImg}" />
										<div class="btn_sty09">
											<span><a href="javascript:fn_DelImg('list')">삭제</a></span>
										</div>
										<div class="btn_sty06">
											<span><a href="${prmtVO.listImg}" target="_blank">상세보기</a></span>
										</div>
									</div>
								</c:if>
								<input type="file" id="listImgFile" name="listImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty prmtVO.listImg}">display:none</c:if>" />
								<input type="hidden" id="listImg"  name="listImg" value="${prmtVO.listImg}" />
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<%--<input type="hidden" name="listImgFile" value="${prmtVO.listImg}" />--%>
						<%-- <tr>
							<th>상세이미지</th>
							<td colspan="3">
								<c:if test="${not empty prmtVO.dtlImg }">
									<div id="d_dtlImg">
										<c:out value="${prmtVO.dtlImg}" />
										<div class="btn_sty09">
											<span><a href="javascript:fn_DelImg('dtl')">삭제</a></span>
										</div>
										<div class="btn_sty06">
											<span><a href="${prmtVO.dtlImg}" target="_blank">상세보기</a></span>
										</div>
									</div>
								</c:if>
								<input type="file" id="dtlImgFile" name="dtlImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty prmtVO.dtlImg}">display:none</c:if>" " />
								<input type="hidden" id="dtlImg"  name="dtlImg" value="${prmtVO.dtlImg}" />
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<%--<input type="hidden" id="mobileDtlImg"  name="mobileDtlImg" value="${prmtVO.mobileDtlImg}" />
						<input type="hidden" id="mainImg"  name="mainImg" value="${prmtVO.mainImg}" />
						<input type="hidden" id="winsImg"  name="winsImg" value="${prmtVO.winsImg}" />--%>
						<%-- <tr>
							<th>모바일이미지</th>
							<td colspan="3">
								<c:if test="${not empty prmtVO.mobileDtlImg }">
									<div id="d_mobileDtlImg">
										<c:out value="${prmtVO.mobileDtlImg}" />
										<div class="btn_sty09">
											<span><a href="javascript:fn_DelImg('mobileDtl')">삭제</a></span>
										</div>
										<div class="btn_sty06">
											<span><a href="${prmtVO.mobileDtlImg}" target="_blank">상세보기</a></span>
										</div>
									</div>
								</c:if>
								<input type="file" id="mobileDtlImgFile" name="mobileDtlImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty prmtVO.mobileDtlImg}">display:none</c:if>" " />
								<input type="hidden" id="mobileDtlImg"  name="mobileDtlImg" value="${prmtVO.mobileDtlImg}" />
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<%-- <tr>
							<th>상품노출구분</th>
							<td colspan="3">
								<select name="prdtViewDiv" id="prdtViewDiv">
									<option value="1000" <c:if test="${prmtVO.prdtViewDiv == '1000'}">selected="selected"</c:if>>리스트형</option>
									<option value="2000" <c:if test="${prmtVO.prdtViewDiv == '2000'}">selected="selected"</c:if>>갤러리형</option>
								</select>
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
									<c:forEach  items="${prmtPrdtList}" var="product">
										<li>${product.prdtNm} <a href="#"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
											<input type="hidden" name="prdtNum" value="${product.prdtNum}"/>
										</li>
									</c:forEach>
								</ul>
							</div>
							</td>
						</tr>
						<tr style="visibility:hidden">
							<th>첨부파일</th>
							<td colspan="3">
								<c:forEach var="data" items="${prmtFileList}" varStatus="status">
									<img class="fileIcon" src="<c:url value='/images/web/board/file.jpg'/>" alt="첨부파일"> <span>${data.realFileNm }
									<div class="btn_sty09">
										<span><a href="javascript:fn_delFile('${data.prmtFileNum}')">삭제</a></span>
									</div>
									<div class="btn_sty06">
										<span><a href="javascript:fn_DownloadFile('${data.prmtFileNum}')">다운로드</a></span>
									</div>
									<br>
								</c:forEach>
								<br>
								<c:if test="${(10 - fn:length(prmtFileList)) > 0}">
									<div id="egovComFileList" class="text_input04"></div>
									<input type="file" id="egovComFileUploader" name="file" accept="*" class="full" />
									<br>
									<c:if test="${not empty fileError}">Error:<c:out value="${fileError}" /></c:if>
									<br>
									<span class="font_red">※ 특정파일의 경우 방화벽에서 차단될수 있습니다.</span>
								</c:if>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01 align_ct">
						<c:if test="${prmtVO.statusCd eq Constant.TRADE_STATUS_REG}">
							<li class="btn_sty01"><a href="javascript:fn_approvalPromotion('${Constant.TRADE_STATUS_APPR_REQ}')">승인요청</a></li>
						</c:if>
						<c:if test="${prmtVO.statusCd eq Constant.TRADE_STATUS_APPR_REQ}">
							<li class="btn_sty01"><a href="javascript:fn_approvalPromotion('${Constant.TRADE_STATUS_REG}')">승인취소</a></li>
						</c:if>
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
<div id="div_productList" class="lay_popup lay_ct"  style="display:none;">
<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_productList'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
<div id="div_productList_html"></div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>