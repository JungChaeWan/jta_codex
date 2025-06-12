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

<validator:javascript formName="ADMRCMDVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Mod() {
	/* if(!validatePRMTVO(document.PRMTVO)) {
		return ;
	} */
	if ($.trim($("#corpId").val()) == "") {
		alert("업체를 선택해 주세요.");
		return ;
	}
	if($("#subject").val() == "") {
		alert("제목을 입력해 주세요.");
		return ;
	}
	if($("#listImgFile").val() == "" && $("#listImg").val() == "") {
		alert("목록이미지를 선택해 주세요.");
		return ;
	}
	if($("#dtlImgFile").val() == "" && $("#dtlImg").val() == "") {
		alert("상세이미지를 선택해 주세요.");
		return ;
	}
	if($("#dtlMobileImgFile").val() == "" && $("#dtlMobileImg").val() == "") {
		alert("모바일이미지를 선택해 주세요.");
		return ;
	}
	if($("#bannerImgFile").val() == "" && $("#bannerImg").val() == "") {
		alert("배너이미지를 선택해 주세요.");
		return ;
	}
	document.ADMRCMDVO.action ="<c:url value='/oss/mdsPickMod.do'/>";
	document.ADMRCMDVO.submit();
}

//이미지 삭제.
function fn_DelImg(type) {
	$("#d_"+type + "Img").hide();
	$("#"+type +"ImgFile").show();
	$("#"+type+"Img").val('');
}

// 업체 리스트
function fn_corp_list(corpCd) {
	$.ajax({
		url: "<c:url value='/oss/getCorpList.ajax'/>",
		data: "corpModCd=" + corpCd,
		dataType: "json",
		success: function(data) {					
			for (var i=0, end=data['corpList'].length; i<end; i++) {
				var selected_str = data['corpList'][i].corpId == '${admRcmdVO.corpId}' ? " selected" : '';
				$('#corpId').append("<option value='" + data['corpList'][i].corpId + "'" + selected_str + ">" + data['corpList'][i].corpNm + "</option>");
			}
		},
		error: fn_AjaxError
	});
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
			fn_corp_list($(this).val());
		}
	});
//	fn_corp_list('${admRcmdVO.corpCd }');
	fn_corp_list($('#corpCdId').val());
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
			<form:form commandName="ADMRCMDVO" name="ADMRCMDVO" method="post" enctype="multipart/form-data">
				<input type="hidden" name="rcmdNum" value="${admRcmdVO.rcmdNum}" />

				<div id="contents">
					<h4 class="title03">MD's Pick 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">추천번호</th>
							<td colspan="3">
								<c:out value="${admRcmdVO.rcmdNum}"/>
							</td>
						</tr>
						<tr>
							<th>업체<span class="font_red">*</span></th>
							<td colspan="3">
								<select id='corpCdId'>
								  	<c:forEach items="${corpCdList}" var="cd">
								  		<option value="${cd.cdNum}"<c:if test="${cd.cdNum eq admRcmdVO.corpCd}"> selected</c:if>>${cd.cdNm}</option>
								  	</c:forEach>
								</select> -
								<form:select path="corpId">
								</form:select>
							</td>
						</tr>
						<tr>
							<th>제목<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="subject" id="subject" class="input_text_full" maxlength="30" value="${admRcmdVO.subject}"/>
								<form:errors path="subject" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>목록이미지</th>
							<td colspan="3">
								<c:if test="${not empty admRcmdVO.listImgFileNm}">
									<div id="d_listImg">
										<c:out value="${admRcmdVO.listImgFileNm}" />
										<div class="btn_sty09"><span><a href="javascript:fn_DelImg('list')">삭제</a></span></div>
										<div class="btn_sty06"><span><a href="${admRcmdVO.listImgPath}" target="_blank">상세보기</a></span></div>
									</div>
								</c:if>
								<input type="hidden" id="listImg" name="listImg" value="${admRcmdVO.listImgFileNm}" />
								<input type="file" id="listImgFile" name="listImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty admRcmdVO.listImgFileNm}">display:none</c:if>" />
								<span class="font_red">크기: 700 * 700</span>
							</td>
						</tr>
						<tr>
							<th>상세이미지</th>
							<td colspan="3">
								<h4>[PC]<span class="font_red">*</span></h4>
								<c:if test="${not empty admRcmdVO.dtlImgFileNm}">
									<div id="d_detailImg">
										<c:out value="${admRcmdVO.dtlImgFileNm}" />
										<div class="btn_sty09"><span><a href="javascript:fn_DelImg('detail')">삭제</a></span></div>
										<div class="btn_sty06"><span><a href="${admRcmdVO.dtlImgPath}" target="_blank">상세보기</a></span></div>
									</div>
								</c:if>
								<input type="hidden" id="detailImg" name="detailImg" value="${admRcmdVO.dtlImgFileNm}" />
								<input type="file" id="detailImgFile" name="detailImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty admRcmdVO.dtlImgFileNm}">display:none</c:if>" />
								<span class="font_red">크기: 가로 980px</span>
								<br>
								<h4>[Mobile]</h4>
								<c:if test="${not empty admRcmdVO.dtlMobileImgFileNm }">
									<div id="d_dtlMobileImg">
										<c:out value="${admRcmdVO.dtlMobileImgFileNm}" />
										<div class="btn_sty09"><span><a href="javascript:fn_DelImg('dtlMobile')">삭제</a></span></div>
										<div class="btn_sty06"><span><a href="${admRcmdVO.dtlMobileImgPath}" target="_blank">상세보기</a></span></div>
									</div>
								</c:if>
								<input type="hidden" id="dtlMobileImg" name="dtlMobileImg" value="${admRcmdVO.dtlMobileImgFileNm}" />
								<input type="file" id="dtlMobileImgFile" name="dtlMobileImgFile" accept="image/*" style="width: 70%;" />
								<span class="font_red">크기: 가로 980px</span>
							</td>
						</tr>
						<tr>
							<th>배너이미지</th>
							<td colspan="3">
								<c:if test="${not empty admRcmdVO.bannerImgFileNm}">
									<div id="d_bannerImg">
										<c:out value="${admRcmdVO.bannerImgFileNm}"/>
										<div class="btn_sty09"><span><a href="javascript:fn_DelImg('banner')">삭제</a></span></div>
										<div class="btn_sty06"><span><a href="${admRcmdVO.bannerImgPath}" target="_blank">상세보기</a></span></div>
									</div>
								</c:if>
								<input type="hidden" id="bannerImg" name="bannerImg" value="${admRcmdVO.bannerImgFileNm}" />
								<input type="file" id="bannerImgFile" name="bannerImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty admRcmdVO.bannerImgFileNm}">display:none</c:if>" />
								<span class="font_red">크기: 가로 230px</span>
							</td>
						</tr>
						<tr>
							<th>노출 여부</th>
							<td colspan="3">
								<select id="viewYn" name="viewYn">
									<option value="Y" <c:if test="${admRcmsVO.viewYn eq 'Y'}">selected=-"selected"</c:if>>노출</option>
									<option value="N" <c:if test="${admRcmsVO.viewYn eq 'N'}">selected=-"selected"</c:if>>노출하지 않음</option>
								</select>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04"><a href="javascript:fn_Mod()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:history.back();">목록</a></li>
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