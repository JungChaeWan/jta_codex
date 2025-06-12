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
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 공지사항"/>
    <jsp:param name="description" value="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 관련 공지사항. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 공지사항">
<meta property="og:url" content="https://www.tamnao.com/web/bbs/bbsList.do?bbsNum=NOTICE">
<meta property="og:description" content="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 관련 공지사항. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />--%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<script type="text/javascript">

	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex){
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/web/bbs/bbsList.do'/>";
		document.frm.submit();
	}
	
	function fn_Ins(){
		document.frm.action = "<c:url value='/web/bbs/bbsRegView.do'/>";
		document.frm.submit();
	}
	
	
	function fn_dtl(nIdx){
		document.frm.noticeNum.value = nIdx;
		document.frm.action = "<c:url value='/web/bbs/bbsDtl.do'/>";
		document.frm.submit();
	}

	$(document).ready(function(){
		if('${authListYn}'!='Y'){
			alert("권한이 없습니다.");
			history.back();
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
                <span>공지사항</span>
            </div>
        </div>
        <!-- quick banner -->

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

                                   	<form name="frm" id="frm" method="get" onSubmit="return false;">
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
										<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}"/>
										<input type="hidden" id="noticeNum" name="noticeNum" value=""/>
										<input type="hidden" id="menuIndex" name="menuIndex" value="3"/>

                                   		<div class="commBoard-wrap">
	                                        <div class="board-list">
	                                            <div class="bdSearch">
	                                                <p class="cmTitle cmInfo">총 <span>${totalCnt }</span>개의 게시물이 있습니다.</p>
	                                                <div class="searchForm">
	                                                    <select id="sKeyOpt" class="sKeyOpt" name="sKeyOpt">

	                                                        <option value="2" <c:if test="${searchVO.sKeyOpt == 2 }">selected="selected"</c:if> >작성자</option>
	                                                        <option value="1" <c:if test="${searchVO.sKeyOpt == null || searchVO.sKeyOpt == 1 }">selected="selected"</c:if> >제목</option>
	                                                        <%-- <option value="">내용</option> --%>
	                                                    </select>
	                                                    <input class="int" type="text" id="sKey" name="sKey" value="<c:out value='${searchVO.sKey}'/>">
	                                                    <input class="button" type="image" src="<c:url value='/images/web/board/search.png'/>" alt="검색" onclick="fn_Search(1);">
	                                                </div>
	                                            </div>
	                                            <div class="bdList">
	                                                <table class="commCol notice-list">
	                                                    <thead>
	                                                        <tr>
	                                                            <th class="title1">번호</th>
	                                                            <th class="title2">제목</th>
	                                                            <th class="title3">작성자</th>
	                                                            <th class="title4">등록일</th>
	                                                        </tr>
	                                                    </thead>
	                                                    <tbody>
	                                                    	<c:if test="${fn:length(resultList) == 0}">
	                                                    		<tr>
		                                                            <td colspan="4" class="no-content">검색결과가 존재하지 않습니다.</td>
		                                                        </tr>
	                                                    	</c:if>
	                                                    	<c:forEach var="data" items="${resultList}" varStatus="status">
		                                                        <tr>
		                                                            <td><c:out value="${ totalCnt - (status.count + searchVO.pageSize*(searchVO.pageIndex-1) )  +1 }"/></td>
																		<td class="left">
				                                                            <c:if test="${ authDtlYn=='Y' || (isLogin=='Y' && data.userId == userInfo.userId)}"><%--글읽기 권한 있는사용자만 --%>
				                                                            	<a class="reduction" href="javascript:fn_dtl(${data.noticeNum})"/>
				                                                            </c:if>
				                                                            <c:if test="${ !(authDtlYn=='Y' || (isLogin=='Y' && data.userId == userInfo.userId) ) }"><%--글읽기 권한 없는 사람 --%>
				                                                            	<a class="reduction" href="javascript:alert('권한이 없습니다.')">
				                                                            </c:if>
				                                                            <c:if test="${data.anmYn == 'Y' }"><span>[공지]</span></c:if>
				                                                            <c:out value="${data.subject}"/></a>
				                                                    	</td>
		                                                            <td><c:out value="${data.writer}"/></td>
		                                                            <td>${fn:substring(data.frstRegDttm,0,10)}</td>
		                                                        </tr>
															</c:forEach>
	                                                    </tbody>
	                                                </table>
	                                            </div> <!--//bdList-->

	                                            <c:if test="${ authRegYn=='Y' }"><%--글쓰기 권한 있는사용자만 --%>
	                                            	<div class="boardBT">
	                                            		<a href="javascript:fn_Ins();">글쓰기</a>
	                                            	</div>
	                                            </c:if>
	                                        </div> <!--//board-list-->
	                                    </div> <!--//commBoard-wrap-->

	                                    <c:if test="${fn:length(resultList) != 0}">
			                            	<div class="pageNumber">
												<p class="list_pageing">
													<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
												</p>
											</div>
		                            	</c:if>
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