<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<head>
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 홍보영상"/>
    <jsp:param name="description" value="제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영 홍보영상"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 홍보영상">
<meta property="og:url" content="https://www.tamnao.com/web/etc/sccList.do">
<meta property="og:description" content="제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영 홍보영상">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<script type="text/javascript">
	
	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex){
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/web/etc/sccList.do'/>";
		document.frm.submit();
	}
	
	function fn_DtlScc(noticeNum){
		$("#noticeNum").val(noticeNum);
		document.frm.action = "<c:url value='/web/etc/detailScc.do'/>";
		document.frm.submit();
	}
</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do"></jsp:include>
</header>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>회사소개</span> <span class="gt">&gt;</span>
            <span>홍보영상</span>
        </div>
    </div>
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents">
            <!-- new contents -->
            <div class="service-center sideON">
                <div class="bgWrap2">
                    <div class="inner">
                        <div class="tbWrap">
                            <jsp:include page="/web/introLeft.do?menu=otoinq" flush="false"></jsp:include>
                            <div class="rContents smON">
                                <h3 class="mainTitle">홍보영상</h3>
                                <div class="commBoard-wrap">
                                    <div class="board-list">
                                        <form name="frm" id="frm">
                                            <input type="hidden" name="noticeNum" id="noticeNum" />
                                            <input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
                                            <input type="hidden" name="totalCnt" value="${paginationInfo.totalRecordCount}" />
                                            <input type="hidden" name="totalPageCnt" value="${paginationInfo.totalPageCount}" />
                                            <input type="hidden" name="pageUnit" value="9" />
                                            <input type="hidden" name="pageSize" value="9" />
                                            <input type="hidden" name="menuIndex" value="2" />
                                        <div class="bdSearch">
                                            <p class="cmTitle cmInfo">총 <span>${totalCnt}</span>개의 게시물이 있습니다.</p>
                                            <div class="searchForm">
                                                <input class="int" type="text" name="sSubject" id="sSubject" value="${searchVO.sSubject}" >
                                                <input class="button" src="<c:url value='/images/web/board/search.png'/>" alt="검색" type="image" onclick="javascript:fn_Search('1')">
                                            </div>
                                        </div> <!--//bdSearch-->
                                        </form>

                                        <div class="bdList">
                                            <c:if test="${fn:length(resultList) == 0}">
                                                <div class="board-not">
                                                    <img src="<c:url value='/images/web/board/not.png'/>" alt="">
                                                    <p>등록 된 홍보영상 게시물이 없습니다.</p>
                                                </div> <!--//board-not-->
                                            </c:if>
                                            <ul class="video-list">
                                            <c:forEach items="${resultList}" var="result" varStatus="status">
                                                <li>
                                                    <a href="javascript:fn_DtlScc('${result.noticeNum}');">
                                                        <p class="photo"><img src="https://i.ytimg.com/vi/${result.youtubeId}/hqdefault.jpg?custom=true&amp;w=196&amp;h=110&amp;stc=true&amp;jpg444=true&amp;jpgq=90&amp;sp=68&amp;sigh=Bpb6hHtTQ5raB-zO7uitKuEEkdI" alt=""></p>
                                                        <div class="text-wrap">
                                                            <p class="title">${result.subject}</p>
                                                            <p class="memo">${result.simpleExp}</p>
                                                        </div>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                            </ul>
                                        </div> <!--//bdList-->
                                    </div> <!--//board-list-->

                                    <div class="pageNumber">
                                        <p class="list_pageing">
                                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
                                        </p>
                                    </div> <!--//pageNumber-->
                                </div> <!--//commBoard-wrap-->

                            </div> <!--//rContents-->
                        </div> <!--//tbWrap-->
                    </div>
                </div>
            </div>
        </div>  <!-- //new contents -->
    </div> <!-- //subContainer -->
</main>
	
<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>