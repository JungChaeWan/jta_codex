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

        /**
         * 조회 & 페이징
         */
        function fn_Search(pageIndex){
            document.frm.pageIndex.value = pageIndex;
            document.frm.action = "<c:url value='/web/mypage/useepilList.do'/>";
            document.frm.submit();
        }

        function fn_deleteUseepil(useEpilNum){
            if(!confirm("삭제 하시겠습니까?")){
                return;
            }
            document.frm.useEpilNum.value = useEpilNum;
            document.frm.action = "<c:url value='/web/coustmer/deleteUseepil.do'/>";
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
            <span>이용후기 내역</span>
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
                            <jsp:include page="/web/mypage/left.do?menu=useepil" flush="false"></jsp:include>

                            <div class="rContents smON">
                                <h3 class="mainTitle">
                                    <span>이용후기 내역</span>
                                    <span class="comm-btWrap">
                                       	<a class="writeBT" href="<c:url value='/web/coustmer/viewInsertUseepil.do'/>">이용후기 작성
                                           	<img src="/images/web/button/write.png" alt="이용후기 작성">
                                       	</a>
                                   	</span>
                                </h3>

                                <form name="frm" id="frm" method="post" onSubmit="return false;">
                                    <input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
                                    <input type="hidden" id="useEpilNum" name="useEpilNum" value=""/>

                                    <ul class="order_lst">
                                        <li class="commCo2 list_tb myPoint2">
                                            <div class="in-td myPoin3__col1">번호</div>
                                            <div class="in-td myPoin3__col2">내용</div>
                                            <div class="in-td myPoin3__col3">작성일</div>
                                        </li>
                                        <c:if test="${fn:length(useepilList) != 0}">
                                        <c:forEach var="data" items="${useepilList}" varStatus="status">
                                        <li class="commCo2 list_tb tbOption">
                                            <div class="goods_brand" >
                                                <div class="goods_row">
                                                    <div class="in-td myPoin3__col1 table-heght3 number"><c:out value="${ totalCnt - (status.count + searchVO.pageSize*(searchVO.pageIndex-1) )  +1 }"/></div>
                                                    <div class="in-td myPoin3__col2 table-heght3">
                                                        <div class="memoWrap2">
                                                            <div class="memoWrap--img2">
                                                                <p class="product">[<c:out value="${data.subjectHeder}"/>]</p>
                                                                <p class="title user-title"><c:out value="${data.subject}"/></p>
                                                                <p class="user-info">
                                                                        <span class="heart">
                                                                        <c:if test="${data.gpa >= 1 }"><img src="/images/web/icon/star_on.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa < 1 }"><img src="/images/web/icon/star_off.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa >= 2 }"><img src="/images/web/icon/star_on.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa < 2 }"><img src="/images/web/icon/star_off.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa >= 3 }"><img src="/images/web/icon/star_on.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa < 3 }"><img src="/images/web/icon/star_off.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa >= 4 }"><img src="/images/web/icon/star_on.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa < 4 }"><img src="/images/web/icon/star_off.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa >= 5 }"><img src="/images/web/icon/star_on.png" alt="좋아요"></c:if>
                                                                        <c:if test="${data.gpa < 5 }"><img src="/images/web/icon/star_off.png" alt="좋아요"></c:if>
                                                                        </span>
                                                                </p>
                                                            </div>
                                                            <p class="memo user-memo">
                                                                <c:out value="${data.contents}" escapeXml="false"/>
                                                                <c:choose>
                                                                    <c:when test="${data.coCd == 'AD'}">
                                                                        <a href="<c:url value='/web/${fn:toLowerCase(data.coCd)}/detailPrdt.do?sPrdtNum=${data.prdtnum}#tabs-5'/>"><span class="comment-count">(${data.cmtCnt}) 답글보기</span></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="<c:url value='/web/${fn:toLowerCase(data.coCd)}/detailPrdt.do?prdtNum=${data.prdtnum}#tabs-5'/>"><span class="comment-count">(${data.cmtCnt}) 답글보기</span></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="in-td myPoin3__col3 table-heght3">
                                                        <div class="progress">
                                                            <p class="date">${data.frstRegDttm}</p>
                                                            <a href="<c:url value='/web/coustmer/viewUdateUseepil.do'/>?useEpilNum=${data.useEpilNum}">수정</a>
                                                            <a href="javascript:fn_deleteUseepil('${data.useEpilNum}')">삭제</a>
                                                        </div>
                                                    </div>
                                                    </c:forEach>
                                                </div>
                                           </div>
                                        </li>
                                    </c:if>
                                    </ul>

                                    <!--콘텐츠 없을 시-->
                                    <c:if test="${fn:length(useepilList) == 0}">
                                        <p class="no-content">이용후기 내역이 없습니다.</p>
                                    </c:if>
                                </form>
                                <div class="pageNumber">
                                    <p class="list_pageing">
                                        <ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
                                    </p>
                                </div>
                            </div> <!--//rContents-->
                        </div> <!--//tbWrap-->
                    </div> <!--//inner-->
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