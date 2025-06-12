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
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

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
	
	if(document.frm.writer.value.length >= 80){
		alert("작성자의 길이는 80자 이하 입니다.");
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
	
	document.frm.action = "<c:url value='/mas/bbs/bbsReg.do'/>";
	document.frm.submit();
}


$(document).ready(function(){

	if('${authRegYn}'!='Y'){
		alert("권한이 없습니다.");
		location.href = "<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
		return;
	}
	
	if("${bbs.atcFileNum}" != "0"){
		//파일 올리기 관련
		var maxFileNum = ${bbs.atcFileNum};
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	}

});


</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=help" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		
		<div id="contents_area"> 
			<!--본문-->
			<div id="contents">
			<form name="frm" id="frm" method="post" enctype="multipart/form-data" onSubmit="return false;" >
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input name="sKey" type="hidden" value="<c:out value='${searchVO.sKey}'/>"/>
				<input name="sKeyOpt" type="hidden" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
				
				<input type="hidden" name="hrkNoticeNum" value="${notice.noticeNum}"></input>
				<input type="hidden" name="ansNum" value="${notice.ansNum}"></input>
				<input type="hidden" name="ansSn" value="${notice.ansSn}"></input>

				<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}" />
				<input type="hidden" id="noticeNum" name="noticeNum" value="${notice.noticeNum}" />
				<input type="hidden" id="email" name="email" value="${userInfo.email}" />
				<input type="hidden" id="brtagYn" name="brtagYn" value="Y" />
				<input type="hidden" id="htmlYn" name="htmlYn" value="N" />
										
				<div class="register_area">
					<h4 class="title03">
						<c:if test="${empty notice.noticeNum}"><%//글쓰기모드%>
							글쓰기
						</c:if>
						<c:if test="${!(empty notice.noticeNum)}">
							답변 쓰기
						</c:if>
						<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</h4>
					

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
	                    
	                    <tr>
	                    	<th>제목<span class="font_red">*</span></th>
	                    	<td colspan="3">
	                    		<input id="subject" name="subject" value="${notice.subject}" type="text" placeholder="최대 50자 까지 자유롭게 입력가능하십니다." class="input_text30">
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th>작성자<span class="font_red">*</span></th>
	                    	<td colspan="3">
	                    		<input id="writer" name="writer" value="${notice.writer}" type="text" class="input_text20" >
	                    		
	                    		<c:if test="${bbs.anmUseYn == 'Y' && (userInfo.authNm == 'ADMIN')}">
	                            	<lable><input type="checkbox" id="anmYn_chk" name="anmYn_chk" style="width: auto; margin-left: 5px;']" <c:if test="${notice.anmYn=='Y'}"> checked="checked" </c:if> >공지사항</lable>
	                            	<input type="hidden" id="anmYn" name="anmYn" value="" />
	                        	</c:if>
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th>내용<span class="font_red">*</span></th>
	                    	<td colspan="3">
	                    		<textarea placeholder="한글 10000자까지 자유롭게 입장가능하십니다." id="contents" name="contents" cols="70" rows="30" style="padding: 0">${notice.contents}</textarea>
	                    	</td>
	                    </tr>
	                    
	                    <c:if test="${bbs.atcFileNum!='0'}">
	                    	<tr>
		                    	<th>첨부파일</th>
		                    	<td colspan="3">
		                    		<div id="egovComFileList" class="text_input04"></div>
									<input type="file" id="egovComFileUploader" name="file" accept="*" class="full"/>
									<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
		                    	</td>
		                    </tr>
	                    </c:if>
	                	
					</table>
					
				</div>
			</form>
				
			<ul class="btn_rt01">
				<li class="btn_sty04">
					<a href="javascript:fn_Ins()">등록</a>
				</li>
				<li class="btn_sty01">
					<a href="<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}">취소</a>
				</li>
			</ul>

			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>