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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="CORPSPADINFOVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

function fn_UdtCorp(){
	// validation 체크
	if(!validateCORPSPADINFOVO(document.CORPVO)){
		return;
	}

	if(!checkIsPhoneNum($("#rsvTelNum").val()) && !checkIsBizPhoneNum($("#rsvTelNum").val())){
		alert("<spring:message code='errors.bizphone'/>");
		$("#rsvTelNum").focus();
		return;
	}
	
	document.CORPVO.action = "<c:url value='/mas/updateSpAddInfo.do' />";
	document.CORPVO.submit();
}

function fn_DelImg() {
	$("#d_img").hide();
	$("#adtmImgFile").show();
	$("#adtmImg").val('');
}
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="CORPVO" name="CORPVO" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpId" name="corpId" value='<c:out value="${corpInfo.corpId}" />' />
			<div id="contents">
				<h4 class="title03">판매처관리</h4>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">상호명</th>
						<td><form:input path="shopNm" class="input_text_full" value="${corpInfo.shopNm}" maxlength="33"/></td>
					</tr>
					<tr>
						<th>한줄소개</th>
						<td>
							<form:input path="adtmSimpleExp" class="input_text_full" value="${corpInfo.adtmSimpleExp}" maxlength="60"/>
							<br /><span class="font_red">글자 수는 60자 제한입니다.</span>
						</td>
					</tr>
					<tr>
						<th>회사로고</th>
						<td>
							<c:if test="${not empty corpInfo.adtmImg }">
							<div id="d_img">
								<c:out value="${corpInfo.adtmImg}"/>
								<div class="btn_sty09">
									<span><a href="javascript:fn_DelImg()">삭제</a></span>
								</div>
								<div class="btn_sty06">
									<span><a href="${corpInfo.adtmImg}" target="_blank">상세보기</a></span>
								</div>
							</div>
							</c:if>
							<input type="file" id="adtmImgFile" name="adtmImgFile" accept="image/*" style="width: 70%;  <c:if test="${not empty corpInfo.adtmImg}">display:none</c:if>" />
							<br /><span class="font_red">가로 90 pixel * 세로 60 pixel 크기에 최적화 되었습니다.</span>
							<input type="hidden" id="adtmImg"  name="adtmImg" class="input_text5" value="${corpInfo.adtmImg}" />
		         		<c:if test="${not empty fileError}"><br/>Error:<c:out value="${fileError}"/></c:if>
						</td>
					</tr>
					<tr>
						<th>홈페이지</th>
						<td><form:input path="adtmUrl" class="input_text_full" value="${corpInfo.adtmUrl}" maxlength="100"/></td>
					</tr>
					<tr>
						<th>문의전화</th>
						<td><form:input path="rsvTelNum"  id="rsvTelNum" class="input_text20" value="${corpInfo.rsvTelNum}" maxlength="20"/></td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtCorp()">수정</a>
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