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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="BBSGRPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>

<script type="text/javascript">
//var hrkCodeItem = [];

function fn_Ins(){
	// validation 체크
	if(!validateBBSGRPVO(document.BBSGRPVO)){
		return;
	}
	
	document.BBSGRPVO.action = "<c:url value='/oss/insertBbsGrpRel.do' />";
	document.BBSGRPVO.submit();
}


function fn_List(){
	document.BBSGRPVO.action = "<c:url value='/oss/viewUpdateBbsGrp.do' />";
	document.BBSGRPVO.submit();
}




$(document).ready(function(){

});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=bbsgrp" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			
				

			<form:form commandName="BBSGRPVO" name="BBSGRPVO" method="post">
			
			<div id="contents">
				<div class="register_area">
					<h4 class="title03">그룹에 게시판 추가</h4>
					
					<table border="1" class="table02">
						<colgroup>
	                        <col width="210" />
                        	<col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<th>게시판 그룹 ID<span></span></th>
	                    	<td>
	                    		<input type="hidden" name="bbsGrpNum" id="bbsGrpNum" value="${bbsGrp.bbsGrpNum}"  />
	                    		<c:out value="${bbsGrp.bbsGrpNum}"/>
	                    	</td>
	                    	
	                    </tr>
	                    <tr>
		                    <th>게시판 그룹 이름<span></span></th>
		                    	<td>
		                    		<c:out value="${bbsGrp.bbsGrpNm}"/>
		                    	</td>
		                    
		                    </tr>
					</table>
					<br/>
					
					
					<table border="1" class="table02">
						<colgroup>
	                        <col width="210" />
                        	<col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<th>게시판ID<span class="font02">*</span></th>
	                    	<td>
	                    		<form:input path="bbsNum" id="bbsNum" value="${bbsGrpRel.bbsNum}" class="input_text10" placeholder="게시판 ID를 입력하세요." maxlength="10"  />
	                    		<form:errors path="bbsNum"  cssClass="error_text" />
	                    	</td>
	                    </tr>
	
					</table>
				</div>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_Ins()">저장</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_List()">뒤로</a>
					</li>
				</ul>
			</div>	
			</form:form>
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>