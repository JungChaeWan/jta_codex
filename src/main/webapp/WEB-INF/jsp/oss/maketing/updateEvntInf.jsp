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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_UdtEvntInf() {
	
	document.frm.action ="<c:url value='/oss/updateEvntInf.do'/>";
	document.frm.submit();
}



$(document).ready(function(){
	$("#exprStartDt").datepicker({
		dateFormat: "yymmdd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			$("#exprEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#exprEndDt").datepicker({
		dateFormat: "yymmdd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			$("#exprStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
});


</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=evnt" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<!--MD's Pick 등록-->
			<form id="frm"  name="frm" method="post">
			<div id="contents">
					
				<h4 class="title03 margin-top45">이벤트 정보 등록</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">이벤트코드</th>
						<td>
							<input type="hidden" name="evntCd" id="evntCd" value="${evntInfVO.evntCd}" />
							<c:out value="${evntInfVO.evntCd}" />
						</td>
					</tr>
					<tr>
						<th scope="row">대상업체명</th>
						<td>
							<input type="text" name="tgtCorpNm" id="tgtCorpNm" class="input_text10" maxlength="30" value="${evntInfVO.tgtCorpNm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">유효시작일자</th>
						<td>
							<fmt:parseDate value="${evntInfVO.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd" />
							<input type="text" name="exprStartDt" id="exprStartDt" class="input_text10" value="<fmt:formatDate value="${exprStartDt}" pattern="yyyyMMdd"/>" />
						</td>
					</tr>
					<tr>
						<th scope="row">유효종료일자</th>
						<td>
							<fmt:parseDate value="${evntInfVO.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd" />
							<input type="text" name="exprEndDt" id="exprEndDt" class="input_text10" value="<fmt:formatDate value="${exprEndDt}" pattern="yyyyMMdd"/>" />
						</td>
					</tr>
					<tr>
						<th scope="row">이벤트 설명</th>
						<td>
							<input type="text" name="evntExp" id="evntExp" class="input_text20" maxlength="50" value="${evntInfVO.evntExp}" />
						</td>
					</tr>
				</table>
				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtEvntInf()">수정</a>
					</li>
				</ul>
						
			</div>
			</form>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>

	</div>
</div>
</body>
</html>