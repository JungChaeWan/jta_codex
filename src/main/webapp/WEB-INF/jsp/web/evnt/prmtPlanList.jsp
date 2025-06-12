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
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주여행 특가 이벤트 기획전"/>
</jsp:include>
<meta property="og:title" content="제주여행 특가 이벤트 기획전">
<meta property="og:url" content="https://www.tamnao.com/web/evnt/prmtPlanList.do">
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주 항공권, 숙소, 렌터카, 관광지 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Thin.woff2" type="font/woff2" crossorigin="anonymous"/>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/evnt/prmtPlanList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/evnt/prmtPlanList.do">
<script>

	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/web/evnt/prmtPlanList.do'/>";
		document.frm.submit();
	}
	
	function fn_Detail(prmtNum, prmtDiv) {
		if (prmtDiv == "GOVA"){ //공고 신청
			document.frm.action = "<c:url value='/web/evnt/detailGovAnnouncement.do'/>?prmtDiv=GOVA&prmtNum="+prmtNum;
		} else{
			document.frm.action = "<c:url value='/web/evnt/detailPromotion.do'/>?prmtDiv=PLAN&prmtNum="+prmtNum; //기획전 URL로 공유 시 해당 기획전으로 직접 접속을 위해 수정
		}
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
	        <span>기획전</span>
	    </div>
	</div>
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">	
	        <section class="product-slide-area">
	        	<div class="Fasten">
	        		<h2 class="title-type2">기획전/이벤트</h2>
	        		<nav id="depth2_menu" class="depth2-menu">
						<ul class="depth1">
							<li<c:if test="${searchVO.sPrmtDiv == null}"> class="active"</c:if>>
								<a href="/web/evnt/prmtPlanList.do">기획전</a>
							</li>
	        				<li>
								<a href="<c:url value='/web/evnt/promotionList.do?finishYn=${Constant.FLAG_N}&winsYn=${Constant.FLAG_N}' />">진행중인 이벤트</a>
							</li>
							<li>
								<a href="<c:url value='/web/evnt/promotionList.do?finishYn=${Constant.FLAG_Y}&winsYn=${Constant.FLAG_N}' />">종료된 이벤트</a>
							</li>
							<li>
								<a href="<c:url value='/web/evnt/promotionList.do?finishYn=${Constant.FLAG_Y}&winsYn=${Constant.FLAG_Y}' />">당첨자 발표</a>
							</li>

							<li<c:if test="${searchVO.sPrmtDiv eq 'GOVA'}"> class="active"</c:if>>
								<a href="/web/evnt/prmtPlanList.do?sPrmtDiv=GOVA">공고 신청</a>
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
									<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
                                        <input type="hidden" name="finishYn" value="${searchVO.finishYn}">
                                        <input type="hidden" name="winsYn" value="${searchVO.winsYn}">
										<input type="hidden" name="type" value="plan">
										<input type="hidden" name="prmtDiv" value="${Constant.PRMT_DIV_PLAN}">
									</form>

									<c:forEach items="${resultList}" var="result">
										<div class="item">
											<span onclick="fn_Detail('${result.prmtNum}', '${searchVO.sPrmtDiv}');" style="cursor: pointer;">
												<div class="photo">
													<img class="img" src="${result.listImg}" alt="${result.prmtNm}" width="383" height="276">
												</div>
												<article class="textWrap">
													<h3 class="title"><c:out value="${result.prmtNm}"/></h3>
													<p class="subTitle">
														<fmt:parseDate value="${result.startDt}" var="startDt" pattern="yyyyMMdd" />
														<fmt:parseDate value="${result.endDt}" var="endDt" pattern="yyyyMMdd" />
														<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
													</p>
												</article>
											</span>
										</div>
									</c:forEach>

									<c:if test="${fn:length(resultList) == 0}">
										<div class="item-noContent">
											<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
											<p class="text">죄송합니다.<br>현재 진행중인
												<c:if test="${searchVO.sPrmtDiv ne 'GOVA'}"><span class="comm-color1">기획전</span>이 </c:if>
												<c:if test="${searchVO.sPrmtDiv eq 'GOVA'}"><span class="comm-color1">공고</span>가 </c:if>
												없습니다.
											</p>
										</div>
									</c:if>
								</div>
							</div>
						</div>
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