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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Reg() {
	if(!validatePRMTVO(document.PRMTVO)){
		return false;
	}
	if($("#listImgFile").val() == "" && $("#listImg").val() == "") {
		alert("목록이미지를 선택해 주세요.");
		return false;
	}
	if($("#dtlImgFile").val() == "" && $("#dtlImg").val() == "") {
		alert("상세이미지를 선택해 주세요.");
		return false;
	}
	$("#startDt").val($('#startDt').val().replace(/-/g, ""));
	$("#endDt").val($('#endDt').val().replace(/-/g, ""));

	if($("#dtlNwdYnV").is(":checked") == true) {
		$("#dtlNwdYn").val("Y");

		fn_addNewOpen();
	} else {
		$("#dtlNwdYn").val("N");
	}
	document.PRMTVO.action ="<c:url value='/oss/eventReg.do'/>";
	document.PRMTVO.submit();
}

// 파일 체크
function checkFile(el){
	var file = el.files;
	var fileName = file[0].name;
	// 파일 확장자 체크
	var ext = "png,jpg,jpeg,gif";
	var str = ext.split(",");
	var extName = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
	var check;

	for(var i=0; i < str.length; i++) {
		if(extName == $.trim(str[i])) {
			check = true;
			break;
		} else {
			check = false;
		}
	}
	if(!check) {
		alert("<spring:message code='errors.file.upload' />");
	} else {
		return;
	}
	el.outerHTML = el.outerHTML;
}

// App에서 새창열기
function fn_addNewOpen() {
	var mobileUrl = $("#dtlUrlMobile").val();
	if($.trim(mobileUrl) == "") {
		mobileUrl = $("#dtlUrl").val();
	}
	var addParameter = "?newopen=yes"

	if(mobileUrl.indexOf("newopen=yes") < 0) {
		if(mobileUrl.indexOf("?") > 0) {
			addParameter = addParameter.replace("?", "&");
		}
		$("#dtlUrlMobile").val(mobileUrl + addParameter);
	}
}

var prdtPopup;

function fn_viewSelectProduct() {
	prdtPopup = window.open("<c:url value='/oss/findPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSoProduct() {
	prdtPopup = window.open("<c:url value='/oss/findSpPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSvProduct() {
	prdtPopup = window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectProduct(prdtId, corpNm, prdtNm, corpId) {
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
	strHtml += "<input type='hidden' name='prdtNum' value='" + prdtId + "' />";
	strHtml += "<label><a href='javascript:void(0);'><span class='del'><img src='/images/web/icon/close5.gif' alt='삭제'></span></a></label>";
	strHtml += "<span><b>[" + prdtId + "] [" + corpNm + "] [" + prdtNm + "]</b></span>";
	strHtml += "<br>";
	strHtml += "<span> - 설명(20자이내) </span>";
	strHtml += "<input type='text' name='notes' class='width25' maxlength='25' />";
	strHtml += "<span> - 라벨(이미지) </span>";
	strHtml += "<select name='label1' id='label1'>";
	strHtml += "<option value=''></option>";

	<c:forEach var='plbl' items='${plblCdList}' varStatus='status'>
		<c:if test="${(plbl.cdNum eq 'LB01') or (plbl.cdNum eq 'LB02') or (plbl.cdNum eq 'LB08')}">
			strHtml += "<option value='${plbl.cdNum}'>${plbl.cdNm}</option>";
		</c:if>
	</c:forEach>

	strHtml += "</select> ";
	strHtml += "<span> - 라벨(텍스트) </span>";
	strHtml += "<select name='label2' id='label2'>";
	strHtml += "<option value=''></option>";

	<c:forEach var="plbl" items="${plblCdList}" varStatus="status">
		strHtml += "<option value='${plbl.cdNum}'>${plbl.cdNm}</option>";
	</c:forEach>

	strHtml += "</select>";
	strHtml += "<select name='label3' id='label3'>";
	strHtml += "<option value=''></option>";

	<c:forEach var="plbl" items="${plblCdList}" varStatus="status">
		strHtml += "<option value='${plbl.cdNum}'>${plbl.cdNm}</option>";
	</c:forEach>

	strHtml += "</select>";
	strHtml += "</li>";

	$("#selectProduct ul").append(strHtml);
}

$(document).ready(function(){

	$("#startDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "+1y",
		onClose: function(selectedDate) {
			$("#endDt").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#endDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "+2y",
		onClose: function(selectedDate) {
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
	//파일 올리기 관련
	var maxFileNum = 10;
	var multi_selector = new MultiSelector(document.getElementById('egovComFileList'), maxFileNum);
	multi_selector.addElement(document.getElementById('egovComFileUploader'));
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=event" flush="false"></jsp:include>
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="PRMTVO" name="PRMTVO" method="post" enctype="multipart/form-data">
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
									<label><input type="radio" name="prmtDiv" value="${prmtDiv.cdNum}" <c:if test="${status.count == 1}">checked</c:if> /> ${prmtDiv.cdNm}</label>
								</c:forEach>
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
							<th>시작일<span class="font_red">*</span></th>
							<td>
								<form:input path="startDt" id="startDt" class="input_text5" readonly="true" />
								<form:errors path="startDt" cssClass="error_text" />
							</td>
							<th>종료일<span class="font_red">*</span></th>
							<td>
								<form:input path="endDt" id="endDt" class="input_text5" readonly="true" />
								<form:errors path="endDt" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>메인 배너</th>
							<td colspan="3">
								<h4>[PC]</h4>
								<input type="file" name="mainImgFile" id="mainImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 1920 * 430</span>
								<h4>[Mobile]</h4>
								<input type="file" name="mobileMainImgFile" id="mobileMainImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 980 * 430</span>
							</td>
						</tr>
						<tr>
							<th>메인 배경 색상</th>
							<td colspan="3">
								#<input type="text" id="bgColorNum" name="bgColorNum" class="input_text5" />
							</td>
						</tr>
						<tr>
							<th>목록 이미지<span class="font_red">*</span></th>
							<td colspan="3">
								<input type="file" id="listImgFile" name="listImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 700 * 350(기획전) / 700 * 504(이벤트)</span>
							</td>
						</tr>
						<tr>
							<th>상세 이미지<span class="font_red">*</span></th>
							<td colspan="3">
								<h4>[PC]<span class="font_red">*</span></h4>
								<input type="file" name="detailImgFile" id="detailImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 가로 1920px</span>
								<h4>[Mobile]</h4>
								<input type="file" name="mobileDtlImgFile" id="mobileDtlImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 가로 1024px</span>
							</td>
						</tr>
						<tr>
							<th>상세 배경 이미지</th>
							<td colspan="3">
								<h4>[PC]<span class="font_red">*</span></h4>
								<input type="file" name="dtlBgImgFile" id="dtlBgImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width:70%;<c:if test="${not empty prmtVO.dtlImg}">display:none;</c:if>" />
								<span class="font_red">크기: 가로 1920px</span>
								<h4>[Mobile]</h4>
								<input type="file" name="mobileDtlBgImgFile" id="mobileDtlBgImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 가로 1024px</span>
							</td>
						</tr>
						<tr>
							<th>상세 배경 색상</th>
							<td colspan="3">
								#<input type="text" name="dtlBgColor" id="dtlBgColor" class="input_text5" />
							</td>
						</tr>
						<tr>
							<th>당첨자 이미지</th>
							<td colspan="3">
								<input type="file" id="winsImgFile" name="winsImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
                                <span class="font_red">크기: 가로 980px</span>
							</td>
						</tr>
						<tr>
							<th>연결 URL<span class="font_red"></span></th>
							<td colspan="3">
								<input type="hidden" name="dtlNwdYn" id="dtlNwdYn" />
								<p>
									<label><input type="checkbox" name="dtlNwdYnV" id="dtlNwdYnV" />새창으로 </label>
									<span class="font_red">※ 체크시 모바일 URL에 '?newopen=yes'가 추가되서 저장됩니다.</span>
								</p>
								<h4>[PC]</h4>
								<form:input path="dtlUrl" id="dtlUrl" class="input_text_full" maxlength="100" />
								<form:errors path="dtlUrl" cssClass="error_text" />
								<br>
								<h4>[Mobile]</h4>
								<form:input path="dtlUrlMobile" id="dtlUrlMobile" class="input_text_full" maxlength="100" />
								<form:errors path="dtlUrlMobile" cssClass="error_text" />
								<p class="font_red">※ 'https://'(또는 'http://')를 꼭 붙여주세요.</p>
							</td>
						</tr>
						<tr>
							<th>상품노출 구분</th>
							<td colspan="3">
								<select name="prdtViewDiv" id="prdtViewDiv">
									<option value="1000" selected="selected">리스트형</option>
									<option value="2000">갤러리형</option>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="2">관련 상품<span class="font_red"></span></th>
							<td colspan="3">
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct();">실시간상품 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct();">소셜상품 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct();">특산기념품 검색</a></span>
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
						<tr>
							<th>댓글 사용</th>
							<td colspan="3">
								<label><input type="radio" name="cmtYn" value="Y" /> 사용</label>
								<label><input type="radio" name="cmtYn" value="N" checked /> 사용안함</label>
							</td>
						</tr>
						<tr>
							<th>Dday 출력</th>
							<td colspan="3">
								<label><input type="radio" name="ddayViewYn" value="Y" /> 사용</label>
								<label><input type="radio" name="ddayViewYn" value="N" checked /> 사용안함</label>
							</td>
						</tr>
						<tr>
							<th>숙소배너 출력</th>
							<td colspan="3">
								<label><input type="radio" name="adbannerViewYn" value="Y" /> 사용</label>
								<label><input type="radio" name="adbannerViewYn" value="N" checked /> 사용안함</label>
							</td>
						</tr>
						<tr>
	                    	<th>첨부파일</th>
	                    	<td colspan="3">
	                    		<div id="egovComFileList" class="text_input04"></div>
								<input type="file" name="file" id="egovComFileUploader" accept="*" class="full" />
								<br>
								<p class="font_red">※ 특정 파일의 경우 방화벽에서 차단될 수 있습니다.</p>
	                    	</td>
	                    </tr>
					</table>

					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04"><a href="javascript:fn_Reg()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:history.back();">뒤로</a></li>
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