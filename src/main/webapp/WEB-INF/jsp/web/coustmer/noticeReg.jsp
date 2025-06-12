<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
 


<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


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
	
	document.frm.action = "<c:url value='/web/bbs/bbsReg.do'/>";
	document.frm.submit();
}


$(document).ready(function(){

	if('${authRegYn}'!='Y'){
		alert("권한이 없습니다.");
		location.href = "<c:url value='/web/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
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
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>고객센터</span> <span class="gt">&gt;</span>
                <span>이용후기</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="service-center sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                            	<jsp:include page="/web/coustmer/left.do?menu=notice" flush="false"></jsp:include>
                            	
                                <div class="rContents smON">
                                    <h3 class="mainTitle">공지사항</h3>
                                   
                                   	
                                   	<form name="frm" id="frm" method="post" enctype="multipart/form-data" onSubmit="return false;" >
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
										<input name="sKey" type="hidden" value="<c:out value='${searchVO.sKey}'/>"/>
										<input name="sKeyOpt" type="hidden" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
										
										
										<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}" />
										<input type="hidden" id="noticeNum" name="noticeNum" value="${notice.noticeNum}" />
										<input type="hidden" id="email" name="email" value="${userInfo.email}" />
										<input type="hidden" id="brtagYn" name="brtagYn" value="Y" />
										<input type="hidden" id="htmlYn" name="htmlYn" value="N" />
										
										<div class="commBoard-wrap">
	                                        <p class="cmTitle">주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</p>
	                                        <div class="board-write">                                            
	                                            <table class="commRow">
	                                                <tbody>                                                    
	                                                    <tr>
	                                                        <th>제목</th>
	                                                        <td class="title">
	                                                            <input id="subject" name="subject" value="${notice.subject}" type="text" placeholder="최대 50자 까지 자유롭게 입력가능하십니다.">
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <th>작성자</th>
	                                                        <td class="title">
	                                                            <input id="writer" name="writer" value="${notice.writer}" type="text" style="width: 200px" >
	                                                            
	                                                            <c:if test="${bbs.anmUseYn == 'Y' && (userInfo.authNm == 'ADMIN')}">
	                                                            	<lable><input type="checkbox" id="anmYn_chk" name="anmYn_chk" style="width: auto; margin-left: 5px;']" <c:if test="${notice.anmYn=='Y'}"> checked="checked" </c:if> >공지사항</lable>
	                                                            	<input type="hidden" id="anmYn" name="anmYn" value="" />
	                                                            </c:if>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <th>내용</th>
	                                                        <td class="memo">
	                                                            <textarea placeholder="한글 10000자까지 자유롭게 입장가능하십니다." id="contents" name="contents">${notice.contents}</textarea>
	                                                        </td>
	                                                    </tr>
	                                                    <c:if test="${bbs.atcFileNum!='0'}">
		                                                    <tr>
		                                                        <th>첨부파일</th>
		                                                        <td>
		                                                            <div id="egovComFileList" class="text_input04"></div>
																	<input type="file" id="egovComFileUploader" name="file" accept="*" class="full"/>
																	<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
		                                                        </td>
		                                                    </tr>
	                                                   	</c:if>
	                                                </tbody>
	                                            </table>
	                                            <div class="comm-button2">
	                                                <a class="color1" href="javascript:fn_Ins()">등록</a>
	                                                <a class="color0" href="<c:url value='/web/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}">취소</a>
	                                            </div>
	                                            <!-- 
	                                            <div class="boardBT2">
	                                                <input type="image" src="<c:url value='/images/web/board/enrollment.gif'/>" alt="등록" onclick="fn_Ins();">
	                                                <a href="<c:url value='/web/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}">
	                                                	<img src="<c:url value='/images/web/board/cancel.gif'/>" alt="취소">
	                                                </a>
	                                            </div>
	                                             -->
	                                        </div> <!--//board-write-->
	                                    </div> <!--//commBoard-wrap-->
										
										
	                            	</form>
	                            	
                                    
                                    
                                </div> <!--//rContents-->
								
                                
                                 
                                
                                
                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>