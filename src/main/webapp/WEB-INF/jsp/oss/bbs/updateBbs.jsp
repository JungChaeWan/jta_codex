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

<validator:javascript formName="BBSVO" staticJavascript="false" xhtml="true" cdata="true"/>

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
	if(!validateBBSVO(document.BBSVO)){
		return;
	}
	
	document.BBSVO.action = "<c:url value='/oss/updateBbs.do' />";
	document.BBSVO.submit();
}



function fn_Del(){
	if(confirm("<spring:message code='common.delete.msg'/>")){
		document.BBSVO.action = "<c:url value='/oss/deleteBbs.do' />";
		document.BBSVO.submit();
	}
}

function fn_List(){
	document.BBSVO.action = "<c:url value='/oss/bbsList.do' />";
	document.BBSVO.submit();
}

function fn_onLoadComplete(){
	//$('#bth').datepicker();

	//기존에 선택된거 선택하기
	
	if("<c:out value='${bbs.noticeRnum}'/>" != ""){
		document.BBSVO.noticeRnum.value = "<c:out value='${bbs.noticeRnum}'/>"; 
	}
	
	if("<c:out value='${bbs.bbsDiv}'/>" != ""){
		document.BBSVO.bbsDiv.value = "<c:out value='${bbs.bbsDiv}'/>"; 
	}
	
	
	if("<c:out value='${bbs.listAuth}'/>" != ""){
		document.BBSVO.listAuth.value = "<c:out value='${bbs.listAuth}'/>"; 
	}else{
		document.BBSVO.listAuth.value = "0";
	}
	
	if("<c:out value='${bbs.dtlAuth}'/>" != ""){
		document.BBSVO.dtlAuth.value = "<c:out value='${bbs.dtlAuth}'/>"; 
	}else{
		document.BBSVO.dtlAuth.value = "0";
	}
	
	if("<c:out value='${bbs.regAuth}'/>" != ""){
		document.BBSVO.regAuth.value = "<c:out value='${bbs.regAuth}'/>"; 
	}else{
		document.BBSVO.regAuth.value = "7";
	}
	
	if("<c:out value='${bbs.modAuth}'/>" != ""){
		document.BBSVO.modAuth.value = "<c:out value='${bbs.modAuth}'/>"; 
	}else{
		document.BBSVO.modAuth.value = "7";
	}
	
	if("<c:out value='${bbs.delAuth}'/>" != ""){
		document.BBSVO.delAuth.value = "<c:out value='${bbs.delAuth}'/>"; 
	}else{
		document.BBSVO.delAuth.value = "7";
	}
	
	if("<c:out value='${bbs.ansAuth}'/>" != ""){
		document.BBSVO.ansAuth.value = "<c:out value='${bbs.ansAuth}'/>"; 
	}else{
		document.BBSVO.ansAuth.value = "7";
	}
		
	if("<c:out value='${bbs.cmtAuth}'/>" != ""){
		document.BBSVO.cmtAuth.value = "<c:out value='${bbs.cmtAuth}'/>"; 
	}else{
		document.BBSVO.cmtAuth.value = "7";
	}
	
	if("<c:out value='${bbs.atcFileNum}'/>" != ""){
		document.BBSVO.atcFileNum.value = "<c:out value='${bbs.atcFileNum}'/>"; 
	}else{
		document.BBSVO.atcFileNum.value = "0";
	}
				
}

$(document).ready(function(){
	fn_onLoadComplete();
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=bbs" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<form:form commandName="BBSVO" name="BBSVO" method="post">
			<div id="contents"> 
				<div class="register_area">
					<h4 class="title03">게시판 수정</h4>
					
					<table border="1" class="table02">
						<colgroup>
	                        <col width="210" />
	                        <col width="*" />
	                        <col width="210" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<th>ID<span></span></th>
	                    	<td colspan="3">
	                    		<input name="bbsNum" id="bbsNum" type="hidden" value="${bbs.bbsNum}" />
	                    		<c:out value="${bbs.bbsNum}"/>
	                    	</td>
	                    </tr>
	                   	<tr>                    	
	                    	<th>이름<span class="font02">*</span></th>
	                    	<td colspan="3">
	                    		<form:input path="bbsNm" id="bbsNm" value="${bbs.bbsNm}" class="input_text20" placeholder="이름을 입력하세요." maxlength="20"  />
	                    		<form:errors path="bbsNm"  cssClass="error_text" />
	                    	</td>
	                    	
	                    </tr>
	                    <tr>
							<th scope="row" >구분<span class="font02">*</span></th>
							<td>
								<select name="bbsDiv" style="width:200px" >
									<option value="0" selected="selected">List</option>
									<option value="1" >Grid</option>
								</select>
								</td> 
							<th scope="row" >관리자ID<span class="font02">*</span></th>
							<td><form:input path="admId" class="input_text02" value="${bbs.admId}" /><br /><form:errors path="admId" /></td>
						</tr>
						<tr>
							<th scope="row">답변여부<span class="font02">*</span></th>
							<td>					
								<label><input type="radio" name="ansYn" <c:if test="${bbs.ansYn == 'Y'}">checked="checked"</c:if> value="Y" /> 사용</label>
								<label><input type="radio" name="ansYn" <c:if test="${bbs.ansYn == 'N' || bbs.ansYn == null}">checked="checked"</c:if> value="N" /> 사용안함</label>
							</td>
							<th scope="row">답변 삭제 여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="ansDelYn" <c:if test="${bbs.ansDelYn == 'Y' || bbs.ansDelYn == null}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="ansDelYn" <c:if test="${bbs.ansDelYn == 'N'}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
						</tr>
						
						<tr>
							<th scope="row">댓글여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="cmtYn" <c:if test="${bbs.cmtYn == 'Y'}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="cmtYn" <c:if test="${bbs.cmtYn == 'N' || bbs.ansDelYn == null}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
							<th scope="row">댓글 삭제 여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="cmtDelYn" <c:if test="${bbs.cmtDelYn == 'Y' || bbs.ansDelYn == null}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="cmtDelYn" <c:if test="${bbs.cmtDelYn == 'N'}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
						</tr>
						
						<tr>
							<th scope="row">에디트 사용<span class="font02">*</span></th>
							<td colspan="3">
								<label><input type="radio" name="edtYn" <c:if test="${bbs.edtYn == 'Y'}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="edtYn" <c:if test="${bbs.edtYn == 'N'|| bbs.edtYn == null}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
						</tr>
						
						<tr>
							<th scope="row">첨부파일 수<span class="font02">*</span></th>
							<td>
								<select name="atcFileNum" style="width:200px" >
									<option value="0" selected="selected">첨부파일 사용안함</option>
									<option value="1" >1</option>
									<option value="2" >2</option>
									<option value="3" >3</option>
									<option value="4" >4</option>
									<option value="5" >5</option>
									<option value="6" >6</option>
									<option value="7" >7</option>
									<option value="8" >8</option>
									<option value="9" >9</option>
									<option value="10" >10</option>
								</select>
							</td>
							<th scope="row">첨부파일 확장자</th>
							<td><input type="text" name="atcFileExt" class="input_text02" value="<c:out value='${bbs.atcFileExt}'/>" />('|'로구분, '*'/''이면 모든 파일)</td>
						</tr>
						
						<tr>
							<th scope="row" >공지글 사용 여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="anmUseYn" <c:if test="${bbs.anmUseYn == 'Y' || bbs.anmUseYn == null}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="anmUseYn" <c:if test="${bbs.anmUseYn == 'N'}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
							<th scope="row" >익명글 여부<span class="font02">*</span></th>
							<td>
								<label><input type="radio" name="annmYn" <c:if test="${bbs.annmYn == 'Y'}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="annmYn" <c:if test="${bbs.annmYn == 'N' || bbs.annmYn == null}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
						</tr>
						<tr>
							<th scope="row" >평점 사용 여부<span class="font02">*</span></th>
							<td colspan="3">
								<label><input type="radio" name="gpaUseYn" <c:if test="${bbs.gpaUseYn == 'Y'}">checked="checked"</c:if> value="Y"/> 사용</label>
								<label><input type="radio" name="gpaUseYn" <c:if test="${bbs.gpaUseYn == 'N' || bbs.gpaUseYn == null}">checked="checked"</c:if> value="N"/> 사용안함</label>
							</td>
						</tr>
						<tr style="display: none">
							<th scope="row" >게시물 행수<span class="font02">*</span></th>
							<td colspan="3">
								<select name="noticeRnum" style="width:200px" >
									<option value="10" >10</option>
									<option value="20" >20</option>
									<option value="30" >30</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<th scope="row" >목록권한<span class="font02">*</span></th>
							<td >
								<select name="listAuth" style="width:200px" >
									<option value="0" >익명사용자</option>
									<option value="1" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
							<th scope="row" >상세권한<span class="font02">*</span></th>
							<td >
								<select name="dtlAuth" style="width:200px" >
									<option value="0" >익명사용자</option>
									<option value="1" selected="selected" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<th scope="row" >등록권한<span class="font02">*</span></th>
							<td >
								<select name="regAuth" style="width:200px" >
									<option value="0" >익명사용자</option>
									<option value="1" selected="selected" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
							<th scope="row" >수정권한<span class="font02">*</span></th>
							<td >
								<select name="modAuth" style="width:200px" >
									<option value="0" >익명사용자</option>
									<option value="1" selected="selected" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<th scope="row" >삭제권한<span class="font02">*</span></th>
							<td >
								<select name="delAuth" style="width:200px" >
									<option value="0" >익명사용자</option>
									<option value="1" selected="selected" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
							<th scope="row" >답변권한<span class="font02">*</span></th>
							<td >
								<select name="ansAuth" style="width:200px" >
									<option value="0" >익명사용자</option>
									<option value="1" selected="selected" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<th scope="row" >댓글권한<span class="font02">*</span></th>
							<td colspan="3">
								<select name="cmtAuth" style="width:200px" >
									<!--<option value="0" >익명사용자</option>-->
									<option value="1" selected="selected" >일반사용자</option>
									<option value="5" >업체</option>
									<option value="7" >관리자</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<th scope="row" >등록ID<span></span></th>
							<td >
								${bbs.frstRegId}
							</td>
							<th scope="row" >등록시간<span></span></th>
							<td >
								${bbs.frstRegDttm}
							</td>
						</tr>
						<tr>
							<th scope="row" >수정ID<span></span></th>
							<td >
								${bbs.lastModId}
							</td>
							<th scope="row" >수정시간<span></span></th>
							<td >
								${bbs.lastModDttm}
							</td>
						</tr>
						
					</table>
					
				</div>
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