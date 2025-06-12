<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_ChangeLogo(){
	if(confirm("로고를 적용하시겠습니까?")){
		if($("#logoImgFile").val() == "") {
			alert("로고를 선택해 주세요.");
			return ;
		}
		
		document.frm.action = "<c:url value='/oss/changeLogo.do'/>";
		document.frm.submit();
	}
}

function fn_ChangeMLogo(){
	if(confirm("로고를 적용하시겠습니까?")){
		if($("#mlogoImgFile").val() == "") {
			alert("로고를 선택해 주세요.");
			return ;
		}
		
		document.frm.action = "<c:url value='/oss/changeMLogo.do'/>";
		document.frm.submit();
	}
}

$(document).ready(function(){
	<c:if test="${not empty fileError}">
	alert("Error : <c:out value='${fileError}'/>");
	</c:if>
});
</script>

</head>
<body>
	<div id="wrapper">
		<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
		<!--Contents 영역-->
		<div id="contents_wrapper">
			<jsp:include page="/oss/left.do?menu=setting&sub=logo" flush="false"></jsp:include>
			<div id="contents_area">
				<form:form commandName="frm"  name="frm" method="post" enctype="multipart/form-data">
				<div id="contents">
					<h4 class="title03">WEB 로고 설정</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
                        	<col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">현재 WEB 로고</th>
							<td>
								<img src="<c:url value='/data/logo.gif'/>" alt="탐나오">
							</td>
						</tr>
						<tr>
							<th>로고 변경</th>
							<td>
								<input type="file" id="logoImgFile" name="logoImgFile" accept="image/gif" style="width: 60%" />
								<br /><span class="font_red">사이즈 : 210px * 90px, gif 파일만 가능</span>
							</td>
						</tr>
					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_ChangeLogo();">적용</a>
						</li>
					</ul>
					
					<h4 class="title03 margin-top45">Mobile 로고 설정</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
                        	<col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">현재 Mobile 로고</th>
							<td>
								<img src="<c:url value='/data/mlogo.gif'/>" alt="탐나오">
							</td>
						</tr>
						<tr>
							<th>로고 변경</th>
							<td>
								<input type="file" id="mlogoImgFile" name="mlogoImgFile" accept="image/gif" style="width: 60%" />
								<br /><span class="font_red">사이즈 : 153px * 53px, gif 파일만 가능</span>
							</td>
						</tr>
					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_ChangeMLogo();">적용</a>
						</li>
					</ul>
			</div>
			</form:form>
		</div>
	</div>
</div>
</body>
</html>