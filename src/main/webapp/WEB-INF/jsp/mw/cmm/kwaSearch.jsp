<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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
	<meta name="robots" content="noindex, nofollow">
	<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_hotel.css'/>">
</head>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
<body>

<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->

<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>키워드 광고</h2>
	</div>
	<div class="sub-content">

		<%-- <!--검색결과 없을 시-->
		<c:if test="${adCnt + rcCnt + glCnt + packageCnt + tourCnt + foodCnt + svCnt == 0 }">
		<div class="item-noContent">
			<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png'/>" alt="경고"></p>
			<p class="text">죄송합니다.<br><strong class="comm-color1">"<c:out value='${search}'/>"</strong>에 대한 검색결과가 없습니다.</p>
		</div>
		</c:if> --%>

		<!--검색결과 존재할 시-->
		<div class="on-ct">
			<h3 class="search-result">
				<strong class="comm-color1">"<c:out value="${KWAVO.kwaNm}" />"</strong>에 대한 <strong class="count"><c:out value="${prdtSum}"/></strong>건의 검색결과입니다.
			</h3>
			<div class="search-item keyword-result">
				<c:if test="${fn:length(kwaprdtListAD) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">숙박</h4>
						<c:forEach items="${kwaprdtListAD}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/ad/detailPrdt.do?sPrdtNum=${data.prdtNum}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<c:if test="${data.eventCnt > 0}">
												<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
											<c:if test="${data.daypriceYn == 'Y'}">
												<img src="<c:url value='/images/mw/sub_common/dday.gif'/>" alt="당일특가">
											</c:if>
											<%-- <c:if test="${data.daypriceYn != 'Y'}">
												<c:if test="${data.hotdallYn == 'Y'}">
													<img src="<c:url value='/images/mw/sub_common/hot.gif'/>" alt="핫딜">
												</c:if>
											</c:if> --%>
										</p>
										<ul class="view">
											<li><img src="${data.savePath}thumb/${data.saveFileNm}" alt=""></li>
										</ul>
										<p class="comm-like">
											<span class="like${fn:substring(data.gpaAvg+((data.gpaAvg%1>=0.5)?(1-(data.gpaAvg%1))%1:-(data.gpaAvg%1)),0,1)}"></span>
											<em>${data.gpaAvg}/5</em>
										</p>
									</div>
									<p class="info">
										<span class="txt">
											<span class="city">[${data.adAreaNm}] <strong><c:out value="${data.adNm}"/></strong></span>
											<em><c:out value="${data.adAreaNm}"/></em>
										</span>
										<span class="price">
											<em><fmt:formatNumber value='${1-data.saleAmt/data.nmlAmt }' type="percent" /></em><br>
											<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
											<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt="">
											<strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원~
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${fn:length(kwaprdtListRC) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">렌터카</h4>
						<c:forEach items="${kwaprdtListRC}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/rentcar/car-detail.do?prdtNum=${data.prdtNum}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<%-- <c:if test="${data.useFuelDiv=='CF01'}"><img src="<c:url value='/images/mw/rent/oil1.gif'/>" alt="휘발유"></c:if>
											<c:if test="${data.useFuelDiv=='CF02'}"><img src="<c:url value='/images/mw/rent/oil3.gif'/>" alt="디젤"></c:if>
											<c:if test="${data.useFuelDiv=='CF03'}"><img src="<c:url value='/images/mw/rent/oil2.gif'/>" alt="LPG"></c:if>
											<c:if test="${data.useFuelDiv=='CF04'}"><img src="<c:url value='/images/mw/rent/oil4.gif'/>" alt="전기"></c:if> --%>
											<c:if test="${data.eventCnt > 0}">
												<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
										</p>
										<ul class="view">
											<li><img src="${data.saveFileNm}" alt=""></li>
										</ul>
										<%-- <p class="comm-like">
											<span class="like${fn:substring(data.gpaAvg+((data.gpaAvg%1>=0.5)?(1-(data.gpaAvg%1))%1:-(data.gpaAvg%1)),0,1)}"></span>
											<em>${data.gpaAvg}/5</em>
										</p> --%>
									</div>
									<p class="info">
										<span class="txt">
											<em><c:out value="${data.rcNm}"/></em>
											<strong><c:out value="${data.prdtNm}"/></strong>
											<%-- <c:if test="${data.ableYn == 'Y' }">
												<span class="btn btn4">예약가능</span>
											</c:if>
											<c:if test="${data.ableYn == 'N' }">
												<span class="btn btn5">예약마감</span>
											</c:if> --%>
										</span>
										<span class="price">
											<%-- <em>${data.disPer}%</em><br>
											<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
											<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> --%>
											<strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원 ~
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${fn:length(kwaprdtListSPC100) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">여행사 상품</h4>
						<c:forEach items="${kwaprdtListSPC100}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${data.prdtNum}&prdtDiv=${data.prdtDiv}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<c:if test="${data.eventCnt > 0 }">
											<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
											<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
											<img src="<c:url value='/images/mw/sub_common/sale.png'/>" alt="할인쿠폰">
											</c:if>
										</p>
										<ul class="view">
											<li><img src="${data.savePath}thumb/${data.saveFileNm}" alt=""></li>
										</ul>

										<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
											<div class="bottom-info">
												<span class="date">
												  	<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
											   	</span>
											</div>
										</c:if>

									 	<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_N }">
											<!-- 상품정보 -->
											<div class="bottom-info">
												<<%--c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
												</span>
											</div>
									 	</c:if>

									 	<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_Y }">
									 		<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">구매 후 ${data.exprDaynum}일</span>
									 		</div>
									 	</c:if>
									</div>
									<p class="info">
										<span class="txt">
											<strong><c:out value="${data.prdtNm}"/></strong>
											<em><c:out value="${data.prdtInf}"/></em>

											<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
											 <!-- 옵션추가 (상품구분 - 옵션명 기준) -->
												<span class="product">
													<span>상품구분) </span> <span><c:out value="${result.prdtDivNm}" /> - <c:out value="${result.optNm}" /> 기준</span>
												</span>
											</c:if>

											<span class="heart">
												<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
												<span class="ind_grade"><strong>${data.gpaAvg }</strong>/5</span>
											</span>
										</span>
										<span class="price">
											<c:if test="${data.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
												<em><fmt:formatNumber value="${1 - (data.saleAmt / data.nmlAmt)}" type="percent"/></em><br>
												<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
												<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if>
											</c:if>
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${fn:length(kwaprdtListSPC200) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">관광지/레저</h4>
						<c:forEach items="${kwaprdtListSPC200}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${data.prdtNum}&prdtDiv=${data.prdtDiv}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<c:if test="${data.eventCnt > 0 }">
												<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
											<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
												<img src="<c:url value='/images/mw/sub_common/sale.png'/>" alt="할인쿠폰">
											</c:if>
										</p>
										<ul class="view">
											<li><img src="${data.savePath}thumb/${data.saveFileNm}" alt=""></li>
										</ul>

										<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
											<div class="bottom-info">
												<span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
											   	</span>
											</div>
										</c:if>

									 	<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_N }">
											<!-- 상품정보 -->
											<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
												</span>
											</div>
					                 	</c:if>

					                 	<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_Y }">
											<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">구매 후 ${data.exprDaynum}일</span>
											</div>
					                 	</c:if>
									</div>
									<p class="info">
										<span class="txt">
											<strong><c:out value="${data.prdtNm}"/></strong>
											<em><c:out value="${data.prdtInf}"/></em>

											<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
							                 <!-- 옵션추가 (상품구분 - 옵션명 기준) -->
								                <span class="product">
													<span>상품구분) </span> <span><c:out value="${result.prdtDivNm}" /> - <c:out value="${result.optNm}" /> 기준</span>
												</span>
							                </c:if>

							                <span class="heart">
												<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
												<span class="ind_grade"><strong>${data.gpaAvg }</strong>/5</span>
											</span>
										</span>
										<span class="price">
											<c:if test="${data.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
												<em><fmt:formatNumber value="${1 - (data.saleAmt / data.nmlAmt)}" type="percent"/></em><br>
												<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
												<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if>
											</c:if>
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${fn:length(kwaprdtListSPC300) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">맛집</h4>
						<c:forEach items="${kwaprdtListSPC300}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${data.prdtNum}&prdtDiv=${data.prdtDiv}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<c:if test="${data.eventCnt > 0 }">
												<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
											<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
												<img src="<c:url value='/images/mw/sub_common/sale.png'/>" alt="할인쿠폰">
											</c:if>
										</p>
										<ul class="view">
											<li><img src="${data.savePath}thumb/${data.saveFileNm}" alt=""></li>
										</ul>

										<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
											<div class="bottom-info">
												<span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
											   </span>
											</div>
										</c:if>

										<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_N }">
											<!-- 상품정보 -->
											<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												 <span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
												 </span>
											</div>
					                 	</c:if>

					                 	<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_Y }">
											<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">구매 후 ${data.exprDaynum}일</span>
											</div>
					                 	</c:if>
									</div>
									<p class="info">
										<span class="txt">
											<strong><c:out value="${data.prdtNm}"/></strong>
											<em><c:out value="${data.prdtInf}"/></em>

											<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
							                 <!-- 옵션추가 (상품구분 - 옵션명 기준) -->
								                <span class="product">
													<span>상품구분) </span> <span><c:out value="${result.prdtDivNm}" /> - <c:out value="${result.optNm}" /> 기준</span>
												</span>
							                </c:if>

							                <span class="heart">
												<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
												<span class="ind_grade"><strong>${data.gpaAvg }</strong>/5</span>
											</span>
										</span>
										<span class="price">
											<c:if test="${data.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
												<em><fmt:formatNumber value="${1 - (data.saleAmt / data.nmlAmt)}" type="percent"/></em><br>
												<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
												<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if>
											</c:if>
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${fn:length(kwaprdtListSPC500) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">카시트/유모차</h4>
						<c:forEach items="${kwaprdtListSPC500}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${data.prdtNum}&prdtDiv=${data.prdtDiv}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<c:if test="${data.eventCnt > 0 }">
											<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
											<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
											<img src="<c:url value='/images/mw/sub_common/sale.png'/>" alt="할인쿠폰">
											</c:if>
										</p>
										<ul class="view">
											<li><img src="${data.savePath}thumb/${data.saveFileNm}" alt=""></li>
										</ul>

										<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
											<div class="bottom-info">
												<span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
											   </span>
											</div>
										</c:if>

										<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_N }">
											<!-- 상품정보 -->
											<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">
													<fmt:parseDate value='${data.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:parseDate value='${data.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
													<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
												</span>
											</div>
					                 	</c:if>

					                 	<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP and data.exprDaynumYn eq Constant.FLAG_Y }">
											<div class="bottom-info">
												<%--<c:if test="${not empty data.useAbleTm and data.useAbleTm > 0 }">
													<span class="info">${data.useAbleTm}시간 후 사용</span>
												</c:if>
												<c:if test="${empty data.useAbleTm or data.useAbleTm == 0 }">
													<span class="info">바로사용</span>
												</c:if>--%>
												<span class="date">구매 후 ${data.exprDaynum}일</span>
											</div>
					                 	</c:if>
									</div>
									<p class="info">
										<span class="txt">
											<strong><c:out value="${data.prdtNm}"/></strong>
											<em><c:out value="${data.prdtInf}"/></em>

											<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
							                 	<!-- 옵션추가 (상품구분 - 옵션명 기준) -->
								                <span class="product">
													<span>상품구분) </span> <span><c:out value="${result.prdtDivNm}" /> - <c:out value="${result.optNm}" /> 기준</span>
												</span>
							                </c:if>

							                <span class="heart">
												<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
												<span class="ind_grade"><strong>${data.gpaAvg }</strong>/5</span>
											</span>
										</span>
										<span class="price">
											<c:if test="${data.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
											<em><fmt:formatNumber value="${1 - (data.saleAmt / data.nmlAmt)}" type="percent"/></em><br>
											<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
											<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원<c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if>
											</c:if>
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${fn:length(kwaprdtListSV) != 0}">
					<div class="item-wrap">
						<h4 class="comm-title1">제주특산/기념품</h4>
						<c:forEach items="${kwaprdtListSV}" var="data">
							<div class="goods-list">
								<a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${data.prdtNum}'/>">
									<div class="goods-image goods-image1">
										<p class="tag-wrap">
											<c:if test="${data.eventCnt > 0 }">
											<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
											</c:if>
										</p>
										<ul class="view">
											<li><img src="${data.savePath}thumb/${data.saveFileNm}" alt=""></li>
										</ul>

									</div>
									<p class="info">
										<span class="txt">
											<strong><c:out value="${data.prdtNm}"/></strong>
											<em><c:out value="${data.prdtInf}"/></em>
							                <span class="heart">
												<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
												<span class="ind_grade"><strong>${data.gpaAvg }</strong>/5</span>
											</span>
										</span>
										<span class="price">
											<%-- <em><fmt:formatNumber value="${1 - (data.saleAmt / data.nmlAmt)}" type="percent"/></em><br> --%>
											<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
											<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원
										</span>
									</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div> <!-- //item-wrap -->
		</div> <!--//keyword-result-->
	</div> <!--//on-ct-->
</section>


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>



<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 쇼핑몰에서 검색을 이용한 제품찾기 페이지 -->
<script language='javascript'>
   var m_skey='<c:out value='${search}'/>';
</script>

<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

</body>
</html>

