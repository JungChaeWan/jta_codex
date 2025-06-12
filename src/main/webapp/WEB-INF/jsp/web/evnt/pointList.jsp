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
<jsp:include page="/web/includeJs.do">
	<jsp:param name="headTitle" value="제주도 특가 이벤트"/>
</jsp:include>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="canonical" href="https://www.tamnao.com/web/evnt/prmtPlanList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/evnt/prmtPlanList.do">

<script type="text/javascript">
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/web/evnt/prmtPlanList.do'/>";
	document.frm.submit();
}

function fn_Detail(prmtNum) {
	//document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/web/evnt/detailPromotion.do'/>?prmtDiv=PLAN&prmtNum="+prmtNum; //기획전 URL로 공유 시 해당 기획전으로 직접 접속을 위해 수정
	document.frm.submit();
}

</script>
</head>

<body>

<jsp:include page="/web/head.do"></jsp:include>

<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>포인트샵</span>
	    </div>
	</div>
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">	
	        <section class="product-slide-area">
	        	<div class="Fasten">
	        		<%--<h2 class="title-type2">탐나오 포인트 </h2>--%>
	        		<nav id="depth2_menu">
	        			<ul class="depth1">
	        				<li>
								<img src="/images/web/event/prmtPointImgW.jpg" width="100%">
							</li>
	        			</ul>
	        		</nav>
	        	</div>
	        </section>

			<div class="event-wrap event-list event-plan">
				<div class="bgWrap2">
					<div class="Fasten">
						<div id="tabs" class="mainTabMenu1">
							<div id="tabs-1" class="tabPanel">
								<div class="itemWrap">
									<c:forEach items="${resultList}" var="result">
										<c:if test="${!fn:contains(result.partnerCode, 'hdc') && !fn:contains(result.partnerCode, 'asset')}">
										<div class="item">
											<%--<a href="<c:url value='/web/evnt/detailPromotion.do?type=plan&prmtNum=${result.prmtNum}&prmtDiv=${Constant.PRMT_DIV_PLAN}&finishYn=${searchVO.finishYn}&winsYn=${searchVO.winsYn}'/>">--%>
											<a href="/web/viewLogin.do?partnerCode=${result.partnerCode}">
												<div class="photo">
													<img class="img" src="/data/coupon/${result.bannerThumb}" alt="${result.partnerNm}">
												</div>
												<article class="textWrap">
													<h5 class="title"><c:out value="${result.partnerNm}"/></h5>
													<p class="subTitle">
														<fmt:parseDate value="${result.aplStartDt}" var="startDt" pattern="yyyyMMdd" />
														<fmt:parseDate value="${result.aplEndDt}" var="endDt" pattern="yyyyMMdd" />
														<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
													</p>
												</article>
											</a>
										</div>
										</c:if>
									</c:forEach>

									<c:if test="${fn:length(resultList) == 0}">
										<div class="item-noContent">
											<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
											<p class="text">죄송합니다.<br>현재 진행중인 <span class="comm-color1">기획전</span>이 없습니다.</p>
										</div>
									</c:if>
								</div>
							</div>
						</div>
						<div class="point_img_area"><img src="/images/web/event/prmtPointManualW.jpg" width="100%"></div>
					</div>
				</div>
			</div>

			<c:if test="${fn:length(resultList) > 0}">
				<div class="pageNumber">
					<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" /></p>
				</div>
			</c:if>
		</div>
	</div>
</main>

<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>