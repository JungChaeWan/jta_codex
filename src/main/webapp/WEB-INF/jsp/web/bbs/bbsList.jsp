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
<meta name="robots" content="noindex">


<jsp:include page="/web/includeJs.do"></jsp:include>



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/web/coustomer/useepilList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/web/coustomer/viewInsertUseepil.do'/>";
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
                <span>고객센터</span> <span class="gt">&gt;</span>
                <span>이용후기</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="service-center sideON">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <div class="tbWrap">
                            	<jsp:include page="/web/coustmer/left.do?menu=notice"></jsp:include>

                                <div class="rContents smON">
                                    <h3 class="mainTitle">공지사항</h3>

                                   	<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>


	                            	</form>

	                            	잘못된 접근 입니다.


                                </div> <!--//rContents-->





                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>

<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>