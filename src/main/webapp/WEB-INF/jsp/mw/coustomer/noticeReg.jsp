<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />

<head>
	<meta name="robots" content="noindex, nofollow">
	<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css'/>">
<script type="text/javascript">

</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>

<script type="text/javascript">


function fn_Ins(){
	
	if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 50){
		alert("제목의 길이는 50자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.writer.value.length==0){
		alert("작성자을 입력 하세요.");
		document.frm.writer.focus();
		return;
	}
	
	if(document.frm.writer.value.length >= 10){
		alert("작성자의 길이는 10자 이하 입니다.");
		document.frm.writer.focus();
		return;
	}
	
	
	if(document.frm.contents.value.length==0){
		alert("내용을 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	
	if(document.frm.contents.value.length >= 10000){
		alert("내용의 길이는 10000자 이하 입니다.");
		document.frm.contents.focus();
		return;
	}
	
	if(${bbs.anmUseYn == 'Y' && (userInfo.authNm == 'ADMIN')} == true){
		if(document.frm.anmYn_chk.checked  == true)
			document.frm.anmYn.value = "Y";
		else
			document.frm.anmYn.value = "N";
	}
	
	document.frm.action = "<c:url value='/mw/bbs/bbsReg.do'/>";
	document.frm.submit();
}


$(document).ready(function(){

	if('${authRegYn}'!='Y'){
		alert("권한이 없습니다.");
		location.href = "<c:url value='/mw/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
		return;
	}
	/*
	if("${bbs.atcFileNum}" != "0"){
		//파일 올리기 관련
		var maxFileNum = ${bbs.atcFileNum};
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	}
	*/

});


</script>


</header>
<!-- 헤더 e -->


<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>공지사항</h2>
	</div>
	<div class="sub-content">

		<div class="board">
			<!-- 
			<dl class="txt-box">
				<dt>공지사항</dt>
			</dl>
			 -->
			<form name="frm" id="frm" method="post" enctype="multipart/form-data" onSubmit="return false;" >
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input name="sKey" type="hidden" value="<c:out value='${searchVO.sKey}'/>"/>
				<input name="sKeyOpt" type="hidden" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
				
				
				<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}" />
				<input type="hidden" id="noticeNum" name="noticeNum" value="${notice.noticeNum}" />
				<input type="hidden" id="email" name="email" value="${userInfo.email}" />
				<input type="hidden" id="brtagYn" name="brtagYn" value="Y" />
				<input type="hidden" id="htmlYn" name="htmlYn" value="N" />
			
				<table class="write bt-none">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<!-- 
					<tr>
						<th>작성자</th>
						<td>00000</td>
					</tr>
					<tr>
						<th><label for="email">이메일</label></th>
						<td class="email">
							<input type="text" id="email">
							@
							<input type="text" id="email2">
							<select name="email" id="email3">
								<option value="직접입력">직접입력</option>
							</select>
						</td>
					</tr>
					-->
					<tr>
						<th><label for="product">제목</label></th>
						<td class="full">
							<input id="subject" name="subject" value="${notice.subject}" type="text" placeholder="최대 50자 까지 자유롭게 입력가능하십니다.">
						</td>
					</tr>
					<tr>
						<th><label for="product">작성자</label></th>
						<td class="cate">
							<input id="writer" name="writer" value="${notice.writer}" type="text" >
	                                                            
                            <c:if test="${bbs.anmUseYn == 'Y' && (userInfo.authNm == 'ADMIN')}">
                            	<lable><input type="checkbox" id="anmYn_chk" name="anmYn_chk" style="width: auto; margin: 5px;']" <c:if test="${notice.anmYn=='Y'}"> checked="checked" </c:if> >공지사항</lable>
                            	<input type="hidden" id="anmYn" name="anmYn" value="" />
                            </c:if>
						</td>
					</tr>
					<tr>
						<th><label for="con">내용</label></th>
						<td><textarea id="con" cols="45" rows="5" id="contents" name="contents" maxlength="500">${notice.contents}</textarea></td>
					</tr>
				</table>
				<div class="file-comment">※ 첨부파일은 PC에서 업로드 할 수 있습니다.</div>
				<p class="btn-list">
					<a href="#" onclick="fn_Ins()" class="btn btn1">저장</a> 
					<a href="javascript:history.back();" class="btn btn2">취소</a>
				</p>
				
			</form>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->



<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>
