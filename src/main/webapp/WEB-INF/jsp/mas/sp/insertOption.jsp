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

<validator:javascript formName="SP_OPTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

function fn_InsertSpOptInfo(){
	alert("fn_InsertSpOptInfo call");
	// validation 체크
	if(!validateSP_OPTINFVO(document.SP_OPTINFVO)){
		alert("validate error");
		return;
	}
	
	$("#aplDt").val($('#aplDt').val().replace(/-/g, ""));
	
	document.SP_OPTINFVO.action = "<c:url value='/mas/sp/insertSocialOption.do' />";
	document.SP_OPTINFVO.submit();
}

function fn_viewInsertProduct() {
	document.SP_OPTINFVO.action = "<c:url value='/mas/sp/viewInsertSocial.do' />";
	document.SP_OPTINFVO.submit();
}

$(function() {
	$("#aplDt").datepicker({
		dateFormat: "yy-mm-dd"
	});
});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="SP_OPTINFVO" name="SP_OPTINFVO" method="post">
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
			<div id="contents">
			<ul id="menu_depth3">
                    <li><a class="menu_depth3" href="javascript:fn_viewInsertProduct()">상품등록</a></li>
                    <li  class="on"><a class="menu_depth3" href="#" >옵션관리</a></li>
                </ul>
				<h4 class="title03">상품 옵션 등록</h4>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">소셜상품구분명<span class="font02">*</span></th>
						<td>
							<form:input path="spDivInfoVO.prdtDivNm" id="spDivInfoVO.prdtDivNm" value="" class="input_text20" maxlength="10" />
						</td>
						<th>구분노출순번<span class="font02">*</span></th>
						<td>
							<form:input path="spDivInfoVO.viewSn" id="spDivInfoVO.viewSn" value="" class="input_text20" maxlength="10" />
						</td>
					</tr>
					<tr>
						<th>옵션명<span class="font02">*</span></th>
						<td colspan="3">
							<form:input path="optNm" id="optNm" value="" class="input_text20" maxlength="20" />
						</td>
					</tr>
					<tr>
						<th>정상금액</th>
						<td>
							<form:input path="nmlAmt" id="nmlAmt" value="${corpInfo.nmlAmt}" class="input_text_full" maxlength="200" />
						</td>
						<th>판매금액</th>
						<td>
							<form:input path="saleAmt" id="saleAmt" value="${corpInfo.saleAmt}" class="input_text_full" maxlength="200" />
						</td>
					</tr>
					<tr>
						<th>노출순번</th>
						<td>
							<form:input path="viewSn" id="viewSn" value="${corpInfo.subExp}" class="input_text_full" maxlength="200" />
						</td>
						<th>적용일자</th>
						<td>
							<form:input path="aplDt" id="aplDt"  class="input_text5" value="${corpInfo.saleStartDt}" />
						</td>
					</tr>
					<tr>
						<th>상품수</th>
						<td>
							<form:input path="optPrdtNum" id="optPrdtNum"  class="input_text5" value="${corpInfo.saleStartDt}" />
						</td>
						<th>마감여부</th>
						<td>
							<select id="ddlYn" name="ddlYn">
								<option value="${Constant.FLAG_Y }">사용</option>
								<option value="${Constant.FLAG_N }">미사용</option>
							</select>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_InsertSpOptInfo()">저장</a>
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