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
           
<head>
<meta name="robots" content="noindex, nofollow">
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?bbsNum=NEWS&noticeNum=${notice.noticeNum}"/>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="${notice.subject}"/>
    <jsp:param name="description" value="제주여행 공공플랫폼 탐나오. 제주특별자치도관광협회 뉴스, ${notice.subject}"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="${notice.subject}">
<meta property="og:url" content="${strUrl}">
<meta property="og:description" content="제주여행 공공플랫폼 탐나오. 제주특별자치도관광협회 뉴스 ${notice.subject}">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">

function fn_DownloadFile(Id){
	frmFileDown.location = "<c:url value='/web/bbs/bbsFileDown.do?bbsNum=${notice.bbsNum}" + "&noticeNum=${notice.noticeNum}" + "&fileNum=" + Id +"'/>";
}

function fn_Udt(){
	if('${authModYn}'!='Y'){
		alert("권한이 없습니다.");
		return;
	}
	document.frm.action = "<c:url value='/web/bbs/bbsModView.do'/>";
	document.frm.submit();
}

function fn_Del(){
	
	if('${nBBSAuthDel}'=='N'){
		alert('권한이 없습니다.');	
		return;	
	}
		
	if('${notice.cmtCnt}'!='0'){
		alert('댓글이 있어서 삭제 할 수 없습니다.');
		return;	
	}
	
	if(confirm("게시글은 물론 관련 정보들도 같이 삭제됩니다.\n게시글을 삭제 하시겠습니까?")){
		document.frm.hrkNoticeNum.value = "";
		document.frm.ansNum.value = "";
		document.frm.ansSn.value = "";
		document.frm.action = "<c:url value='/web/bbs/bbsDel.do'/>";
		document.frm.submit();
	}
}



$(document).ready(function(){
	if('${authDtlYn}'!='Y'){
		alert("권한이 없습니다.");
		location.href = "<c:url value='/web/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
		
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
                <span>회사소개</span> <span class="gt">&gt;</span>
                <span>보도자료</span>
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
                        <div class="Fasten">
                            <div class="tbWrap">
                            	<aside id="sub-leftMenu" class="smON">
                                    <h4 class="title">회사소개</h4>
                                    <div class="pdWrap">
                                        <ul class="depth1">
                                            <li><a href="<c:url value='/web/etc/introduction.do'/>">회사소개</a></li>
                                            <li><a href="<c:url value='/web/etc/sccList.do'/>">홍보영상</a></li>
                                            <li><a href="<c:url value='/web/bbs/bbsList.do?bbsNum=NEWS'/>">보도자료</a></li>
                                        </ul>
                                        <div class="serviceCenter">
                                            <h5>고객센터</h5>
                                            <p class="tel">1522-3454</p>
                                            <p class="timeWrap">
                                                <span class="icon"><img src="<c:url value='/images/web/mypage/clock.gif'/>" alt="시계"></span>
                                                <span class="time">평일 09:00~18;00<br>점심 12:00~13:00<br>토,일 및 공휴일 휴무</span>
                                            </p>
                                        </div>
                                    </div>
                                </aside>
                            	
                                <div class="rContents smON">
                                    <h3 class="mainTitle">보도자료</h3>
                                    <div class="commBoard-wrap">
                                        <div class="board-view">
                                            <div class="view-head">
                                                <h5><span></span> <c:out value="${notice.subject}"/> </h5>
                                                <p><c:out value="${notice.writer}"/> <c:out value="${notice.frstRegDttm}"/></p>
                                            </div>

                                            <!-- 첨부파일 -->
                                            <div class="viewFile">
                                                <table summary="첨부파일을 다운로드 하는 곳입니다." border="1">
                                                    <caption class="tableCaption">첨부파일 다운로드</caption>
                                                    <colgroup>
                                                        <col width="10%">
                                                        <col width="90%">
                                                    </colgroup>
                                                    <c:if test="${fn:length(notiFileList) != 0}">
	                                                    <tbody>
	                                                        <tr>
	                                                            <th scope="row">첨부파일</th>
	                                                            <td>
	                                                                <ul class="viewFileList">
	                                                                	<c:forEach var="data" items="${notiFileList}" varStatus="status">
		                                                                    <li>
		                                                                        <img class="fileIcon" src="<c:url value='/images/web/board/file.jpg'/>" alt="첨부파일">
		                                                                        <span><a href="javascript:fn_DownloadFile('${data.fileNum}')" title="${data.realFileNm }">(붙임${status.index+1 }) <c:out value="${data.realFileNm }"/> </a></span>
		                                                                    </li>
		                                                                </c:forEach>
	                                                                </ul>
	                                                            </td>
	                                                        </tr>                                   
	                                                    </tbody>
                                                   	</c:if>
                                                </table>
                                            </div>

                                            <!-- 콘텐츠 -->
                                            <div class="view-content">
                                            	<c:forEach var="data" items="${notiImgList}" varStatus="status">
                                                	<img src="${data.savePath}${data.saveFileNm}.${data.ext}" alt="">
                                                </c:forEach>
                                                <c:out value='${notice.contents}' escapeXml='false' />
                                            </div>
                                            <!-- button -->
                                            <div class="boardBT">
                                                <a href="<c:url value='/web/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}">목록</a>
                                                <c:if test="${authModYn == 'Y' && (isLogin=='Y' && notice.userId == userInfo.userId)}">
                                                	<a href="javascript:fn_Udt()">수정</a>
                                                </c:if>
                                                <c:if test="${authDelYn == 'Y' && (isLogin=='Y' && notice.userId == userInfo.userId)}">
                                                	<a href="javascript:fn_Del()">삭제</a>
                                                </c:if>
                                            </div>
                                        </div> <!--//board-view-->
                                    </div> <!--//commBoard-wrap-->  
                                    
                                    
                                   	
                                   	<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
										<input name="sKey" type="hidden" value="<c:out value='${searchVO.sKey}'/>"/>
										<input name="sKeyOpt" type="hidden" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
										
										<input type="hidden" name="bbsNum" id="bbsNum" value="<c:out value='${notice.bbsNum}'/>"/>
										<input type="hidden" name="noticeNum" id="noticeNum" value="<c:out value='${notice.noticeNum}'/>"/>
										<input type="hidden" name="hrkNoticeNum" value="${notice.hrkNoticeNum}"/>
										<input type="hidden" name="ansNum" value="${notice.ansNum}"/>
										<input type="hidden" name="ansSn" value="${notice.ansSn}"/>
										
										<input name="fileNum" id="fileNum" type="hidden" value=""/>
	                            	</form>
	                            	
                                    
                                    
                                </div> <!--//rContents-->
								
                                
                                 
                                
                                
                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
        <iframe name="frmFileDown" style="display:none"></iframe>	
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>