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

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<validator:javascript formName="ADMRCMDVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Reg() {
	/* if(!validatePRMTVO(document.PRMTVO)){
		return;
	} */
	if ($.trim($("#corpId").val()) == "") {
		alert("업체를 선택해 주세요.");
		return;
	}
	if($("#subject").val() == "") {
		alert("제목을 입력해 주세요.");
		return;
	}
	if($("#listImgFile").val() == "") {
		alert("목록이미지를 선택해 주세요.");
		return;
	}
	if($("#dtlImgFile").val() == "") {
		alert("상세이미지를 선택해 주세요.");
		return;
	}
	if($("#dtlMobileImgFile").val() == "") {
		alert("모바일이미지를 선택해 주세요.");
		return;
	}
	if($("#bannerImgFile").val() == "") {
		alert("배너이미지를 선택해 주세요.");
		return;
	}
	document.ADMRCMDVO.action ="<c:url value='/oss/mdsPickReg.do'/>";
	document.ADMRCMDVO.submit();
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

$(document).ready(function(){
	
	$("#corpCdId").change(function() {
		$('select[name=corpId] option').remove();	// 초기화
		
		if ($.trim($(this).val()) != '') {
			$.ajax({
				url: "<c:url value='/oss/getCorpList.ajax'/>",
				data: "corpModCd=" + $(this).val(),
				dataType: "json",
				success: function(data) {					
					for(var i = 0, end = data['corpList'].length; i < end; i++) {
						$('#corpId').append("<option value='" + data['corpList'][i].corpId + "'>" + data['corpList'][i].corpNm + "</option>");
					}
				},
				error: fn_AjaxError
			});
		}
	});
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
			<!--MD's Pick 등록-->
			<form:form commandName="ADMRCMDVO" name="ADMRCMDVO" method="post" enctype="multipart/form-data">
				<div id="contents">
					<h4 class="title03">MD's Pick 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
					
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
							<th>업체<span class="font_red">*</span></th>
							<td colspan="3">
								<select id='corpCdId'>
								  	<option value=''>= 카테고리 =</option>
								  	<c:forEach items="${corpCdList }" var="cd">
								  		<option value="${cd.cdNum }">${cd.cdNm }</option>
								  	</c:forEach>
								</select> - 
								<form:select path="corpId">
								  	<form:option value="">= 카테고리 선택 =</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th>제목<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="subject" id="subject"  class="input_text_full" maxlength="30" value="${admRcmdVO.subject}"/>
								<form:errors path="subject"  cssClass="error_text" />
							</td>
						</tr>						
						<tr>
							<th>목록이미지</th>
							<td colspan="3">
								<input type="file" id="listImgFile" name="listImgFile" accept="image/*" style="width: 70%" />
								<span class="font_red">크기: 700 * 700</span>
							</td>
						</tr>
						<tr>
							<th>상세이미지</th>
							<td colspan="3">
								<h4>[PC]<span class="font_red">*</span></h4>
								<input type="file" name="dtlImgFile" id="dtlImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 가로 980px</span>
								<br>
								<h4>[Mobile]</h4>
								<input type="file" name="dtlMobileImgFile" id="dtlMobileImgFile" accept=".png,.jpg,.jpeg,.gif" onchange="checkFile(this)" style="width: 70%" />
								<span class="font_red">크기: 가로 980px</span>
							</td>
						</tr>
						<tr>
							<th>배너이미지</th>
							<td colspan="3">
								<input type="file" id="bannerImgFile" name="bannerImgFile" accept="image/*" style="width: 70%" />
								<span class="font_red">크기: 가로 230px</span>
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