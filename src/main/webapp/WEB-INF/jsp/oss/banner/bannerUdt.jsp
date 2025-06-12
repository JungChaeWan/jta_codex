<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_Back(){
	$('#bannerNum').val("");
	document.frm.action = "<c:url value='/oss/bannerList.do' />?location=${BANNERVO.location}";
	document.frm.submit();
}

function fn_Udt(){
	if($('#bannerNm').val().length == 0){
		alert("제목을 입력하세요.");
		$('#bannerNm').focus();
		return;
	}

	<c:if test="${not empty BANNERVO.imgFileNm}">
		if($('#egovComFileUploader').val().length > 0){
			var fileName = $('#egovComFileUploader').val().toLowerCase();//파일명
			var _fileLen = fileName.length;
			var _lastDot = fileName.lastIndexOf('.');
			var strSub = fileName.substring(_lastDot, _fileLen).toLowerCase();
			if(!(strSub.toLowerCase() == ".jpg" || strSub.toLowerCase() == ".gif" || strSub.toLowerCase() == ".png" )){
				alert("jpg, gif, png 파일만 등록이 가능합니다.");
				return false;
			}
		}
	</c:if>

	if($('#startDttm').val().length == 0){
		alert("시작일을 입력하세요.");
		$('#startDttm').focus();
		return;
	}

	if($('#endDttm').val().length == 0){
		alert("종료을 입력하세요.");
		$('#endDttm').focus();
		return;
	}

	$("#startDttm").val($('#startDttm').val().replace(/-/g, ""));
	$("#endDttm").val($('#endDttm').val().replace(/-/g, ""));

	document.frm.action = "<c:url value='/oss/bannerUdt.do' />";
	document.frm.submit();
}

function fn_setLastTmEnd(){
	$("#endDttm").val("2200-12-31");
}

$(document).ready(function(){
	//파일 올리기 관련
	var maxFileNum = 1;
	var multi_selector = new MultiSelector(document.getElementById('egovComFileList'), maxFileNum );
	multi_selector.addElement(document.getElementById('egovComFileUploader'));

	$("#startDttm").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		changeYear: true,
		yearRange: "c-100:c+200",
		onClose : function(selectedDate) {
			$("#endDttm").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#endDttm").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		changeYear: true,
		yearRange: "c-100:c+200",
		onClose : function(selectedDate) {
			$("#startDttm").datepicker("option", "maxDate", selectedDate);
		}
	});

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=banner" />

		<div id="contents_area">
			<div id="contents">
				<h4 class="title03">배너 수정 (${cdVO.cdNm})</h4>

				<form name="frm" method="post"	enctype="multipart/form-data" onSubmit="return false;">
					<input type="hidden" name="bannerNum" id="bannerNum" value="${BANNERVO.bannerNum}" />
					<input type="hidden" name="location" value="${BANNERVO.location}" />

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tbody>
							<c:if test="${empty BANNERVO.imgFileNm}">
								<tr>
									<th scope="row">텍스트형 작성안내</th>
									<td colspan="3">
										<p class="info font_blue">※ 제목이 배너에 보여집니다.</p>
										<p class="info font_blue">※ 강조하고 싶은 문구는 <span class="info font_red"><c:out value='<em class="bar-em"></em>' /></span> 태그를 사용해주세요.(기본 글자는 흰색, 강조 글자는 노란색)</p>
										<br>
										<p class="info">ex) 지금! 제주여행 <c:out value='<em class="bar-em">' />2만원 즉시할인<c:out value='</em>' /> 받기!!</p>
									</td>
								</tr>
							</c:if>
							<tr>
								<th scope="row">제목<span class="font02">*</span></th>
								<td colspan="3">
									<input type="text" name="bannerNm" id="bannerNm" class="width100" value="<c:out value="${BANNERVO.bannerNm}" />" placeholder="" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row">순번</th>
								<td colspan="3">
									<select name="printSn" id="printSn">
										<c:forEach var="i" begin="1" end="${maxPos}">
											<option value="${i}" <c:if test="${i == BANNERVO.printSn}">selected="selected"</c:if>>${i}</option>
										</c:forEach>
									</select>

								</td>
							</tr>
							<tr>
								<th scope="row">사용여부</th>
								<td colspan="3">
									<input type="radio" name="printYn" id="printYn1" value="Y" <c:if test="${BANNERVO.printYn == 'Y' or empty BANNERVO.printYn}">checked="checked"</c:if> /> <label for="printYn1">사용</label>
									<input type="radio" name="printYn" id="printYn2" value="N" <c:if test="${BANNERVO.printYn == 'N'}">checked="checked"</c:if> /> <label for="printYn2">미사용</label>

								</td>
							</tr>
							<tr>
								<th scope="row">연결주소</th>
								<td colspan="3">
									<input type="text" name="url" class="width100" value="${BANNERVO.url}" placeholder="" maxlength="250" />
									<span class="info font_blue">※ 주소는 http:// 또는 https:// 부터 입력해 주세요</span>
								</td>
							</tr>
							<tr>
								<th scope="row">열리는창</th>
								<td colspan="3">
									<input type="radio" name="nwd" id="nwd2" value="N" <c:if test="${BANNERVO.nwd == 'N' or empty BANNERVO.nwd}">checked="checked"</c:if> /> <label for="nwd2">같은창</label>
									<input type="radio" name="nwd" id="nwd1" value="Y" <c:if test="${BANNERVO.nwd == 'Y'}">checked="checked"</c:if> /> <label for="nwd1">새창</label>
								</td>
							</tr>
							<tr <c:if test="${empty BANNERVO.imgFileNm}">style="display: none;"</c:if>>
								<th scope="row">이미지<span class="font02">*</span></th>
								<td colspan="3">
									<p>${BANNERVO.imgPath}${BANNERVO.imgFileNm}</p>
									<input type="file" name="file" id="egovComFileUploader" accept="*" class="full" style="border: 1px solid #ccc; width: 280px;" />
									<span class="info font_blue">
										※ jpg, gif, png 파일만 등록 가능하며, 이미지 사이즈는
										<c:if test="${BANNERVO.location == 'BN01'}">980p * 50p</c:if>
										<c:if test="${BANNERVO.location == 'BN02'}">154p * 50p</c:if>
										<c:if test="${BANNERVO.location == 'BN03'}">가로 120p</c:if>
										<c:if test="${BANNERVO.location == 'BN04'}">가로 580p</c:if>
										입니다.
									</span>
									<div id="egovComFileList"></div>
								</td>
							</tr>

							<c:if test="${BANNERVO.location == 'BN01'}">
								<tr>
									<th scope="row">배경색</th>
									<td colspan="3">
										#<input type="text" name="bgColor" value="${BANNERVO.bgColor}" maxlength="6" />
										<span class="info font_blue">※ 배경색은 RGB 16진수 6자리 값입니다.(입력하지 않으면 흰색 적용)</span>
									</td>
								</tr>
							</c:if>
							<c:if test="${BANNERVO.location != 'BN01'}">
								<input type="hidden" name="bgColor" value="${BANNERVO.bgColor}" />
							</c:if>

							<tr>
								<th>시작일<span class="font_red">*</span></th>
								<td>
									<input type="text" name="startDttm" id="startDttm" class="input_text5" readonly="true"  value="${fn:substring(BANNERVO.startDttm,0,4)}-${fn:substring(BANNERVO.startDttm,4,6)}-${fn:substring(BANNERVO.startDttm,6,8)}" />
								</td>
								<th>종료일<span class="font_red">*</span></th>
								<td>
									<input type="text" name="endDttm" id="endDttm" class="input_text5" readonly="true" value="${fn:substring(BANNERVO.endDttm,0,4)}-${fn:substring(BANNERVO.endDttm,4,6)}-${fn:substring(BANNERVO.endDttm,6,8)}" />
									<div class="btn_sty04">
										<span><a href="javascript:fn_setLastTmEnd();">2200년까지</a></span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_rt01">
					<button type="button" class="btn blue" onclick="fn_Udt();">수정</button>
					<button type="button" class="btn " onclick="fn_Back();">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>