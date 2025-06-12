<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?rcmdNum=${mdsInfo.rcmdNum}"/>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주여행 MD's 추천 ${mdsInfo.corpNm}, 탐나오"/>
</jsp:include>
<meta property="og:title" content="제주여행 MD's 추천 ${mdsInfo.corpNm}, 탐나오">
<meta property="og:url" content="https://${strURL}" />
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주 항공권, 숙소, 렌터카, 관광지 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>">
<script type="text/javascript">
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mw/coustomer/mdsPickList.do'/>";
	document.frm.submit();
}
</script>
</head>

<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>MD’s Pick</h2>
	</div>

	<div class="sub-content not-padding mw-event">
		<div class="event">
			<ul class="event-list">
				<li>
					<div class="pr-img">
						<c:set var="dtlImgUrl" value="${mdsInfo.dtlImgPath}" />

						<c:if test="${not empty mdsInfo.dtlMobileImgPath}">
							<c:set var="dtlImgUrl" value="${mdsInfo.dtlMobileImgPath}" />
						</c:if>
						<img src="${dtlImgUrl}" alt="${mdsInfo.corpNm}">
					</div>
				</li>
			</ul>

			<%--<section class="mw-event-list">
				<div class="prdtList">
					<c:forEach var="product" items="${prdtList}" varStatus="status">
						<div class="event-group">
							<div class="product-area">
								<c:choose>
									<c:when test="${mdsInfo.corpCd eq Constant.ACCOMMODATION}">
										<c:set var="paramStr" value="sPrdtNum" />
									</c:when>
									<c:otherwise>
										<c:set var="paramStr" value="prdtNum" />
									</c:otherwise>
								</c:choose>

								<a href="<c:url value='/mw/${fn:toLowerCase(mdsInfo.corpCd)}/detailPrdt.do?${paramStr}=${product.prdtNum}&searchYn=N&sSearchYn=N'/>">
									<div class="social-photo">
										<img src="${product.listImgPath}" alt="${product.prdtNm}">
									</div>
									<div class="text">
										<h2>${product.prdtNm}</h2>
										<p>${product.prdtExp}</p>
										<div class="info">
											<dl>
												<dd>
													<div class="price">
														<b>${product.disPer}%</b>
														<strong><fmt:formatNumber value='${product.saleAmt}'/></strong>원~
													</div>
												</dd>
											</dl>
										</div>
									</div>
								</a>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>--%>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>