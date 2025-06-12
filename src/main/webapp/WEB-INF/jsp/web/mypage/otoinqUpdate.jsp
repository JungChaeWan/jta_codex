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
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">

function fn_Mod(){
	//입력 검사
	
	
	if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
	//if($("#contents").val().length == 0){
	if(document.frm.contents.value.length==0){
		alert("내용을 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.frm.contents.value.length >= 500){
		alert("내용의 길이는 500자 이하 입니다.");
		document.frm.contents.focus();
		return;
	}
	
	document.frm.action = "<c:url value='/web/mypage/otoinqUpdate.do'/>";
	document.frm.submit();
		
}

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
                <span>마이페이지</span> <span class="gt">&gt;</span>
                <span>나의 게시글 모음</span> <span class="gt">&gt;</span>
                <span>1:1문의</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="mypage sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                            	<jsp:include page="/web/mypage/left.do?menu=otoinq" flush="false"></jsp:include>
                            	
                                <div class="rContents smON">
                                    <h3 class="mainTitle">1:1 문의내역</h3>
                                    <!--콘텐츠 없을 시-->
                                    
                                    <form name="frm" method="post" onSubmit="return false;">
                                    <input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
                                    <input type="hidden" id=otoinqNum name="otoinqNum" value="${otoinq.otoinqNum}"/>
                                    <input type="hidden" id="corpId" name="corpId" value="${otoinq.corpId}"/>
                                    <input type="hidden" id="prdtNum" name="prdtNum" value="${otoinq.prdtNum}"/>
                                    
                                   	<div class="commBoard-wrap">
                                        <p class="cmTitle">* 주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</p>
                                        <div class="board-write">                                            
                                            <table class="commRow">
                                                <tbody>
                                                    <tr>
                                                        <th>제목</th>
                                                        <td class="title">
                                                            <input type="text" id="subject" name="subject" placeholder="최대 50자 까지 자유롭게 입력가능하십니다." maxlength="50" value="${otoinq.subject}">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>내용</th>
                                                        <td class="memo">
                                                            <textarea placeholder="한글 500자까지 자유롭게 입력가능하십니다." id="contents" name="contents" maxlength="500">${otoinq.contents}</textarea>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div class="comm-button2">
	                                        	<a class="color1" href="javascript:fn_Mod()">수정</a>
	                                        	<a class="color0" href="javascript:history.back();">취소</a>
	                                        </div>
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