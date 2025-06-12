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

<validator:javascript formName="AD_PRDINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
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

function fn_Ins(){
	
	// validation 체크
	if(!validateAD_PRDINFVO(document.AD_PRDINFVO)){
		return;
	}

	const pattern_spc = /[$"'%&<>?]/;
	if (pattern_spc.test($("#prdtNm").val())){
		alert(" 특수문자($\"%&'<>?)는 입력 할 수 없습니다.");
		$("#prdtNm").focus();
		return;
	}

	document.AD_PRDINFVO.action = "<c:url value='/mas/ad/insertPrdt.do' />";
	document.AD_PRDINFVO.submit();
}

function fn_Cancel(){
	document.AD_PRDINFVO.action = "<c:url value='/mas/ad/productList.do' />";
	document.AD_PRDINFVO.submit();
}


$(document).ready(function(){
	


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
			<div id="contents">
				<form:form commandName="AD_PRDINFVO" name="AD_PRDINFVO" method="post" enctype="multipart/form-data">
				<div class="register_area">
					<h4 class="title03">객실 추가<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="225" />
	                        <col width="*" />
	                        <col width="225" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<th>업체 아이디<span></span></th>
	                    	<td colspan="3">
	                    		<input type="hidden" id="corpId" name="corpId" value='<c:out value="${adPrdinf.corpId}" />' />
								<c:out value="${adPrdinf.corpId}" />
	                    	</td>
	                    </tr>
	                    <c:if test="${corpInfo.corpLinkYn=='Y'}">
							<tr>
								<th>연계번호<span></span></th>
								<td colspan="3">
									<form:input path="mappingNum" id="mappingNum" value="${adPrdinf.mappingNum}" class="input_text20" maxlength="40" />
		                    		<form:errors path="mappingNum"  cssClass="error_text" /> 
								</td>
							</tr>
						</c:if>
						<tr>
							<th>명칭<span class="font02">*</span></th>
							<td colspan="3">
								<form:input path="prdtNm" id="prdtNm" value="${adPrdinf.prdtNm}" class="input_text50" maxlength="40" />
	                    		<form:errors path="prdtNm"  cssClass="error_text" /> 
							</td>
						</tr>
						<tr>
							<th>기준인원<span class="font02">*</span></th>
							<td >
								<form:input path="stdMem" id="stdMem" value="${adPrdinf.stdMem}" class="input_text20" maxlength="10"  />
	                    		<form:errors path="stdMem"  cssClass="error_text" />
							</td>
							<th>최대인원<span class="font02">*</span></th>
							<td >
								<form:input path="maxiMem" id="maxiMem" value="${adPrdinf.maxiMem}" class="input_text20" maxlength="10"  />
	                    		<form:errors path="maxiMem"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>인원 추가가능 여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="memExcdAbleYn" <c:if test="${adPrdinf.memExcdAbleYn == 'Y'}">checked="checked"</c:if> value="Y" />허용</label>
								<label><input type="radio" name="memExcdAbleYn" <c:if test="${adPrdinf.memExcdAbleYn == 'N' || adPrdinf.memExcdAbleYn == null}">checked="checked"</c:if> value="N" />허용안함</label>
							</td>
							<th>추가인원 추가요금<span class="font02">*</span></th>
							
							<td>
								<label><input type="radio" name="addamtYn" <c:if test="${adPrdinf.addamtYn == 'Y' || adPrdinf.addamtYn == null}">checked="checked"</c:if> value="Y" />추가</label>
								<label><input type="radio" name="addamtYn" <c:if test="${adPrdinf.addamtYn == 'N' }">checked="checked"</c:if> value="N" />미추가</label>
							</td>
						</tr>
						
						<tr>
							<th>조식 포함 여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="breakfastYn" <c:if test="${adPrdinf.breakfastYn == 'Y'}">checked="checked"</c:if> value="Y" />포함</label>
								<label><input type="radio" name="breakfastYn" <c:if test="${adPrdinf.breakfastYn == 'N' || adPrdinf.breakfastYn == null}">checked="checked"</c:if> value="N" />미포함</label>		
							</td>
							<th>연박 할인</th>
							<td>
								<label><input type="radio" name="ctnAplYn" <c:if test="${adPrdinf.ctnAplYn == 'Y'}">checked="checked"</c:if> value="Y" />적용</label>
								<label><input type="radio" name="ctnAplYn" <c:if test="${adPrdinf.ctnAplYn == 'N' || adPrdinf.ctnAplYn == null}">checked="checked"</c:if> value="N" />미적용</label>		
							</td>
						</tr>
						
						<tr>
							<th>최소 예약 박수<span class="font02">*</span></th>
							<td >
								<form:input path="minRsvNight" id="minRsvNight" value="${adPrdinf.minRsvNight}" class="input_text20" maxlength="10"  />
	                    		<form:errors path="minRsvNight"  cssClass="error_text" />
							</td>
							<th>최대 예약 박수<span class="font02">*</span></th>
							<td >
								<form:input path="maxRsvNight" id="maxRsvNight" value="${adPrdinf.maxRsvNight}" class="input_text20" maxlength="10"  />
	                    		<form:errors path="maxRsvNight"  cssClass="error_text" />
							</td>
						</tr>
						
						<tr>
							<th>상품설명<span></span></th>
							<td colspan="3">
								<form:input path="prdtExp" id="prdtExp" value="${adPrdinf.prdtExp}" class="input_text50" maxlength="150" />
	                    		<form:errors path="prdtExp"  cssClass="error_text" /> 
							</td>
						</tr>
						<%-- 
						<tr>
							<th>출력 여부<span class="font02">*</span></th>
							<td colspan="3">
								<label><input type="radio" name="printYn" <c:if test="${adPrdinf.printYn == 'Y'|| adPrdinf.printYn == null}">checked="checked"</c:if> value="Y" />출력</label>
								<label><input type="radio" name="printYn" <c:if test="${adPrdinf.printYn == 'N'}">checked="checked"</c:if> value="N" />미출력</label>
							</td>
						</tr>
						--%>
						<input type="hidden" name="printYn" value="Y"/>
						<tr>
							<th scope="row">순번<span class="font02">*</span></th>
							<td colspan="3">
								<select style="width:70px" name="viewSn">
									<c:forEach var="cnt" begin="1" end="${totCnt+1}">
										<option value="${cnt}" <c:if test="${cnt == totCnt+1}">selected="selected"</c:if>>${cnt}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						
						
						
					</table>
					
				</div>
				</form:form>
				
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_Ins()">추가</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_Cancel()">취소</a>
					</li>
				</ul>
			</div>
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>