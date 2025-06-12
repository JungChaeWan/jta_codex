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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

function fn_ListPointJoin(){
	document.EVNTPOINTMNGVO.action = "<c:url value='/oss/event/pointJoinList2018.do'/>";
	document.EVNTPOINTMNGVO.submit();
}

function fn_FindUser(){
	var retVal = window.open("<c:url value='/oss/findUser.do'/>","findUser", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectUer(userId, userNm, telNum){
	$("#userNm").val(userNm);
	$("#userId").val(userId);
	$("#telNum").val(telNum);
}

function fn_InsPointJoin(){
	document.EVNTPOINTMNGVO.action = "<c:url value='/oss/event/insertPointJoin2018.do'/>";
	document.EVNTPOINTMNGVO.submit();
}

$(document).ready(function(){

});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=grandSale2018" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<div id="contents">
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3" href="<c:url value='/oss/event/voucherMng.do'/>">탐나오상품권</a></li>
						<li class="on"><a class="menu_depth3" href="<c:url value='/oss/event/pointJoinList2018.do'/>">상품권대상관리</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/event/pointList2018.do'/>">상품권현황</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/event/grandSaleJoinList2018.do'/>">참여현황</a></li>

	                </ul>
	            </div>
				<form id="EVNTPOINTMNGVO" name="EVNTPOINTMNGVO" method="post">
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" id="sUserNm" name="sUserNm" value="${searchVO.sUserNm}"/>
				
					<h4 class="title03">포인트 대상 등록</h4>	
					<!-- 업체 일반정보 -->		
					<table border="1" class="table02">
						<colgroup>
	                        <col width="300px" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">상품권명</th>
							<td>
								<select name="vcCd" id="vcCd" style="width:148px">
									<c:forEach var="data" items="${resultList}"	varStatus="status">
										<option value="${data.vcCd}">${data.vcNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
	                    <tr>
	                    	<th scope="row">사용자명
	                    		<div class="btn_sty04" style="position: relative; left: 100px;">
									<span><a href="javascript:fn_FindUser();">사용자 검색</a></span>								
								</div>
	                    	</th>
	                    	<td>
	                    		<input type="text" class="input_text10" name="userNm" id="userNm" />
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th scope="row">사용자아이디</th>
	                    	<td>
	                    		<input type="text" class="input_text10" name="userId" id="userId" />
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th scope="row">전화번호</th>
	                    	<td>
	                    		<input type="text" class="input_text10" name="telNum" id="telNum" />
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th scope="row">적용포인트</th>
	                    	<td>
	                    		<input type="text" class="input_text10" name="aplPoint" id="aplPoint" />
	                    	</td>
	                    </tr>
					</table>
					
					
					<ul class="btn_rt01">
						<li class="btn_sty04">
							<a href="javascript:fn_InsPointJoin()">저장</a>
						</li>
						<li class="btn_sty01">
							<a href="javascript:fn_ListPointJoin()">목록</a>
						</li>
					</ul>			
				</form>
			<!--//업체등록-->
			</div> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>