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

<validator:javascript formName="BBSGRPINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

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
var hrkCodeItem = [];

function fn_Udt(){
	// validation 체크
	if(!validateBBSGRPINFVO(document.BBSGRPINFVO)){
		return;
	}
	
	document.BBSGRPINFVO.action = "<c:url value='/oss/updateBbsGrp.do' />";
	document.BBSGRPINFVO.submit();
}



function fn_Del(){
	if(confirm("<spring:message code='common.delete.msg'/>"+"(연결된 게시판ID들도 같이 삭제됩니다.)")){
		document.BBSGRPINFVO.action = "<c:url value='/oss/deleteBbsGrp.do' />";
		document.BBSGRPINFVO.submit();
	}
}

function fn_List(){
	document.BBSGRPINFVO.action = "<c:url value='/oss/bbsGrpList.do' />";
	document.BBSGRPINFVO.submit();
}



function fn_InsGrp(){
	document.BBSGRPVO.action = "<c:url value='/oss/viewInsertBbsGrpRel.do' />";
	document.BBSGRPVO.submit();
}

function fn_DelGrp(bbsNum){
	if(confirm("<spring:message code='common.delete.msg'/>")){
		document.BBSGRPVO.bbsNum.value = bbsNum;
		document.BBSGRPVO.action = "<c:url value='/oss/deleteBbsGrpRel.do' />";
		document.BBSGRPVO.submit();
	}
}


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
			<div id="contents">
				<form:form commandName="BBSGRPINFVO" name="BBSGRPINFVO" method="post">
				<div class="register_area">
					<h4 class="title03">게시판 그룹 수정</h4>
					
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
	                    	<th>게시판 그룹 이름<span class="font02">*</span></th>
	                    	<td>
	                    		<form:input path="bbsGrpNm" id="bbsGrpNm" value="${bbsGrp.bbsGrpNm}" class="input_text20" placeholder="이름을 입력하세요." maxlength="20" />
	                    		<form:errors path="bbsGrpNm"  cssClass="error_text" />
	                    	</td>
	                    	
	                    </tr>
	                	
					</table>
				</div>
				</form:form>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_Udt()">수정</a>
					</li>
					<li class="btn_sty03">
						<a href="javascript:fn_Del()">삭제</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_List()">목록</a>
					</li>
				</ul>
				<!--//본문--> 
			
		
		
				<form:form commandName="BBSGRPVO" name="BBSGRPVO" method="post">
				<div class="register_area margin-top45"> 
					<h4 class="title03">그룹에 연결된 게시판 목록</h4>
					<input type="hidden" name="bbsGrpNum" id="bbsGrpNum" value="${bbsGrp.bbsGrpNum}"  />
					<input type="hidden" name="bbsNum" id="bbsNum" value=""  />
					
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>게시판ID</th>
								<th>게시판이름</th>
								<th>관리자툴</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="3" align="center">
										등록된 게시판이 없습니다.
									</td>
								</tr>
							</c:if>
							<c:forEach var="data" items="${resultList}" varStatus="status">
								<tr >
									<td class="align_ct">${data.bbsNum}</td>
									<td class="align_ct">${data.bbsNm}</td>
									<td class="align_ct"><div class="btn_sty07"><span><a href="javascript:fn_DelGrp('${data.bbsNum}')">삭제</a></span></div></td>
								</tr>						
							</c:forEach>
							
						</tbody>
					</table>
				</div>
				</form:form>
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_InsGrp()">그룹에 게시판 추가</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>