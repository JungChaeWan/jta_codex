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
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?rcmdNum=${mdsInfo.rcmdNum}"/>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 MD's 추천 ${mdsInfo.corpNm}, 탐나오"/>
</jsp:include>
<meta property="og:title" content="제주여행 MD's 추천 ${mdsInfo.corpNm}, 탐나오">
<meta property="og:url" content="https://${strURL}" />
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주 항공권, 숙소, 렌터카, 관광지 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<script type="text/javascript">
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
                <span>기획전</span> <span class="gt">&gt;</span>
                <span>MD's Pick</span>
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
                            	<%-- <jsp:include page="/web/coustmer/left.do?menu=otoinq" flush="false"></jsp:include> --%>
								<div class="rContents smON">
                                    <!-- <h3 class="mainTitle">MD’s Pick</h3> -->
                                    <div class="commBoard-wrap">
                                        <div class="board-view md-view"> <!-- class add -->
                                        	<div class="view-content photo">
                                                <img src="<c:out value='${mdsInfo.dtlImgPath }' />" alt="${mdsInfo.corpNm}" />
                                            </div>

                                            <%--<c:if test="${fn:length(prdtList) != 0 }">
												<div class="product-wrap">
													<h5 class="listTitle1"></h5>
													<ul class="product-list">
														<c:forEach var="prdt" items="${prdtList}">
														<li>
															<div class="cell cell1">
																<p class="photo">
																	<img class="img" src="<c:out value="${prdt.listImgPath}" />" alt="${prdt.prdtNm}">
																</p>
															</div>
															<div class="cell cell2">
																<h5 class="title">${prdt.prdtNm}</h5>
																<p class="subTitle">${prdt.prdtExp}</p>
															</div>
															<div class="cell cell3">
																<div class="saleWrap">
																	<p class="sale">${prdt.disPer}%</p>
																	<p class="won">
																		&lt;%&ndash;<span class="won1"><fmt:formatNumber value="${prdt.nmlAmt}" /></span>&ndash;%&gt;
																		<span class="won2"><fmt:formatNumber value="${prdt.saleAmt}" />원</span>
																	</p>
																</div>
															</div>
															<div class="cell cell4">
																<c:choose>
																  	<c:when test="${mdsInfo.corpCd eq Constant.ACCOMMODATION}">
																		<c:set var="prdtUrl">/web/ad/detailPrdt.do?sPrdtNum=${prdt.prdtNum}&sFromDtView=${SVR_START_DT}&sFromDt=${fn:replace(SVR_START_DT, '-', '')}&sNights=1&vNights=1</c:set>
																  	</c:when>
																  	<c:when test="${mdsInfo.corpCd eq Constant.RENTCAR}">
																		<c:set var="prdtUrl">/web/rentcar/car-detail.do?prdtNum=${prdt.prdtNum}&sFromDtView=${SVR_START_DT}&sFromDt=${fn:replace(SVR_START_DT, '-', '')}&sFromTm=1200&vFromTm=1200&sToDtView=${SVR_END_DT}&sToDt=${fn:replace(SVR_END_DT, '-', '')}&sToTm=1200&vToTm=1200</c:set>
																  	</c:when>
																  	<c:when test="${mdsInfo.corpCd eq Constant.SOCIAL}">
																		<c:set var="prdtUrl">/web/sp/detailPrdt.do?prdtNum=${prdt.prdtNum}</c:set>
																  	</c:when>
																  	<c:when test="${mdsInfo.corpCd eq Constant.SV}">
																		<c:set var="prdtUrl">/web/sv/detailPrdt.do?prdtNum=${prdt.prdtNum}</c:set>
																  	</c:when>
																</c:choose>
																<a href="<c:url value="${prdtUrl}" />">바로가기</a>
															</div>
														</li>
														</c:forEach>
													</ul>
												</div>
									        </c:if>
--%>
									        <div class="btn-wrap right">
					                    		<a href="javascript:history.back();" class="comm-btn black typeB">목록</a>
					                    	</div>
                                        </div> <!--//board-view-->
                                    </div> <!--//commBoard-wrap-->                                    
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