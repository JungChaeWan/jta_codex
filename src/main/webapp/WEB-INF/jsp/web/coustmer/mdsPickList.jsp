<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 MD's Pick, 탐나오"/>
</jsp:include>
<meta property="og:title" content="제주여행 MD's Pick, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/web/coustmer/mdsPickList.do">
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주 항공권, 숙소, 렌터카, 관광지 추천 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="canonical" href="https://www.tamnao.com/web/coustmer/mdsPickList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/coustomer/mdsPickList.do">
<script type="text/javascript">
	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/web/coustmer/mdsPickList.do'/>";
		document.frm.submit();
	}
</script>
</head>
<body>
<jsp:include page="/web/head.do" flush="false"></jsp:include>
<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>기획전</span>
	    </div>
	</div>
	
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	
	        <!-- Change Contents -->
	        <section class="product-slide-area">
	        	<div class="Fasten">
	        		<h2 class="title-type2"><img src="/images/web/title/tamnao.png" alt="탐나오" class="icon"> 기획전</h2>
	        		<%--
	        		<nav id="depth2_menu" class="depth2-menu">
	        			<ul class="depth1">
	        				<li><a href="<c:url value='/web/evnt/prmtPlanList.do' />">상품기획전</a></li>
	        				<li class="active"><a href="<c:url value='/web/coustmer/mdsPickList.do' />">MD’s Pick</a></li>
	        			</ul>
	        		</nav>
	        		--%>
	        	</div>
	        </section>
	        
			<div class="event-wrap event-list event-pick">
				<div class="bgWrap2">
					<div class="Fasten">
						<div id="tabs" class="mainTabMenu1">
							<div id="tabs-1" class="tabPanel">
								<div class="itemWrap">
									<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
									</form>

									<c:forEach items="${resultList}" var="result">
										<div class="item">
											<a href="<c:url value='/web/coustmer/mdsPickDtl.do?rcmdNum=${result.rcmdNum}' />">
												<div class="photo">
													<img class="img" src="${result.listImgPath}" alt="${result.corpNm}">
												</div>
												<article class="textWrap">
													<h5 class="title"><c:out value="${result.corpNm}"/></h5>
													<p class="subTitle"><c:out value="${result.subject}"/></p>
												</article>
											</a>
										</div>
									</c:forEach>

									<c:if test="${fn:length(resultList) == 0}">
										<div class="item-noContent">
											<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
											<p class="text">죄송합니다.<br>현재 진행중인 <span class="comm-color1">MD's Pick</span>이 없습니다.</p>
										</div>
									</c:if>
								</div>
							</div>

							<c:if test="${fn:length(resultList) > 0}">
								<div class="pageNumber">
									<p class="list_pageing"> <ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" /> </p>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
	
	    </div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>