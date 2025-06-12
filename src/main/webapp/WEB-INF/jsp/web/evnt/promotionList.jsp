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
	<jsp:param name="title" value="제주여행 특가 이벤트, 탐나오"/>
</jsp:include>
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>"> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/evnt/promotionList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/evnt/promotionList.do">
<script>

	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/web/evnt/promotionList.do'/>";
		document.frm.submit();
	}
	
	function fn_Detail(prmtNum) {
		//document.frm.prmtNum.value = prmtNum;
		document.frm.action = "<c:url value='/web/evnt/detailPromotion.do'/>?prmtDiv=EVNT&prmtNum="+prmtNum; //이벤트 URL로 공유 시 해당 이벤트로 직접 접속을 위해 수정
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
	        <span>이벤트</span>
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
	        				<li>
								<a href="/web/evnt/prmtPlanList.do">기획전</a>
							</li>
	        				<li<c:if test="${(searchVO.winsYn eq Constant.FLAG_N) and (searchVO.finishYn eq Constant.FLAG_N)}"> class="active"</c:if>>
								<a href="<c:url value='/web/evnt/promotionList.do?finishYn=${Constant.FLAG_N}&winsYn=${Constant.FLAG_N}' />">진행중인 이벤트</a>
							</li>
							<li<c:if test="${(searchVO.winsYn eq Constant.FLAG_N) and (searchVO.finishYn ne Constant.FLAG_N)}"> class="active"</c:if>>
								<a href="<c:url value='/web/evnt/promotionList.do?finishYn=${Constant.FLAG_Y}&winsYn=${Constant.FLAG_N}' />">종료된 이벤트</a>
							</li>
							<li<c:if test="${searchVO.winsYn eq Constant.FLAG_Y}"> class="active"</c:if>>
								<a href="<c:url value='/web/evnt/promotionList.do?finishYn=${Constant.FLAG_Y}&winsYn=${Constant.FLAG_Y}' />">당첨자 발표</a>
							</li>
							<li>
								<a href="/web/evnt/prmtPlanList.do?sPrmtDiv=GOVA">공고 신청</a>
							</li>
	        			</ul>
	        		</nav>
	        	</div>
	        </section>

	        <div class="event-wrap event-list">
		        <div class="bgWrap2">
		            <div class="Fasten">
		                <div id="tabs" class="mainTabMenu1"> 
		                    <div id="tabs-1" class="tabPanel">
		                        <div class="itemWrap">
									<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
										<input type="hidden" name="finishYn" value="${searchVO.finishYn}">
										<input type="hidden" name="winsYn" value="${searchVO.winsYn}">
										<input type="hidden" name="prmtDiv" value="${Constant.PRMT_DIV_EVNT}">
									</form>

									<c:forEach items="${resultList}" var="result">
										<div class="item">
											<%-- <a href="javascript:void(0)" onclick="fn_Detail('${result.prmtNum}');"> --%>
											<span onclick="fn_Detail('${result.prmtNum}');" style="cursor: pointer;">
												<div class="photo">
													<img class="img img2" src="${result.listImg}" alt="${result.prmtNm}">
												</div>
												<article class="textWrap">
													<h3 class="title"><c:out value="${result.prmtNm}"/></h3>
													<p class="subTitle">
													  <fmt:parseDate value="${result.startDt}" var="startDt" pattern="yyyyMMdd" />
													  <fmt:parseDate value="${result.endDt}" var="endDt" pattern="yyyyMMdd" />
													  <fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
													</p>
												</article>
												<jsp:useBean id="now" class="java.util.Date" />
												<fmt:parseNumber value="${now.time / (3600*24*1000)}" integerOnly="true" var="nowTime" scope="request" />
												<fmt:parseNumber value="${endDt.time / (3600*24*1000)}" integerOnly="true" var="endTime" scope="request" />
												<fmt:parseNumber value="${endTime - nowTime + 1}" var="dayNum" scope="request" />
												<c:if test="${(result.ddayViewYn eq Constant.FLAG_Y) and (dayNum > 0) and (dayNum < 8)}">
													<div class="d-day2">
														<span>D-</span><span>${dayNum}</span>
													</div>
												</c:if>
											</span>
										</div>
		                            </c:forEach>

		                            <c:if test="${fn:length(resultList) eq 0}">
							    		<div class="item-noContent">
											<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
											<c:if test="${searchVO.winsYn eq Constant.FLAG_Y}">
												<p class="text">죄송합니다.<br>당첨자가 발표된 <span class="comm-color1">이벤트</span>가 없습니다.</p>
											</c:if>
											<c:if test="${searchVO.winsYn eq Constant.FLAG_N}">
												<p class="text">죄송합니다.<br>현재 진행중인 <span class="comm-color1">이벤트</span>가 없습니다.</p>
											</c:if>
										</div>
							    	</c:if>
		                        </div>
		                    </div>

						  	<c:if test="${fn:length(resultList) > 0}">
								<div class="pageNumber">
									<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" /></p>
								</div>
		                  	</c:if>
		                </div>
		            </div>
		        </div>
		    </div>
	    </div>
	</div>
</main>

<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>