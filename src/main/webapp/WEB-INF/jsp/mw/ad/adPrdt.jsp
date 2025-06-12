<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>


	<div class="prdt-wrap">

	<c:forEach var="data" items="${resultList}" varStatus="status">

		<c:if test="${!('Y' == totSch && status.index>=4)}"><%-- 통합검색에서 온거면 8개만 --%>

			<div class="goods-list">
				<a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}')">
			 	<%--<a href='<c:url value="/mw/ad/detailPrdt.do"/>?sPrdtNum=${data.prdtNum}')"> --%>
					<div class="goods-image goods-image1">
						<p class="tag-wrap">
							<c:if test="${data.eventCnt > 0}">
								<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
							</c:if>
							<c:if test="${data.daypriceYn == 'Y'}">
								<img src="<c:url value='/images/mw/sub_common/dday.gif'/>" alt="당일특가">
							</c:if>
							<!-- 핫딜을 연박 할인 으로 교체 (2017-06-29, By JDongS) -->
							<%-- <c:if test="${data.daypriceYn != 'Y'}">
			            		<c:if test="${data.hotdallYn == 'Y'}">
									<img src="<c:url value='/images/mw/sub_common/hot.gif'/>" alt="핫딜">
								</c:if>
							</c:if> --%>
							<c:if test="${data.daypriceYn != 'Y'}">
			            		<c:if test="${data.continueNightYn == 'Y'}">
									<img src="<c:url value='/images/mw/sub_common/accomSale.gif'/>" alt="연박할인">
								</c:if>
							</c:if>
						</p>

						<ul class="view">
							<li>
								<c:if test="${!(empty data.saveFileNm)}">
									<img class="img" src="${data.savePath}thumb/${data.saveFileNm}" alt="">
								</c:if>
								<c:if test="${empty data.saveFileNm}">
									<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="">
								</c:if>
							</li>
						</ul>
						<p class="comm-like">
							<span class="like${fn:substring(data.gpaAvg+((data.gpaAvg%1>=0.5)?(1-(data.gpaAvg%1))%1:-(data.gpaAvg%1)),0,1)}"></span>
							<em>${data.gpaAvg}/5</em>
						</p>
					</div>
					<p class="info">
						<span class="txt">

							<span class="city">[${data.adAreaNm}] <strong><c:out value="${data.adNm}"/></strong></span>

							<em>${data.adSimpleExp}</em>

							<%--<c:if test="${data.rsvAbleYn == 'Y' }"> --%>
							<%-- <c:if test="${!(data.ddlYn == 'Y' || data.totalRoomNum <= data.useRoomNum) }">
								<span class="btn btn4">예약가능</span>
							</c:if> --%>
							<%--<c:if test="${data.rsvAbleYn == 'N' }"> --%>
							<%-- <c:if test="${data.ddlYn == 'Y' || data.totalRoomNum <= data.useRoomNum }">
								<span class="btn btn5">예약마감</span>
							</c:if> --%>

						</span>
						<span class="price">
							<!-- <em>${data.salePent}%</em><br> -->
							<em><span class="t_price">탐나오가</span></em>
							<%-- <em><fmt:formatNumber value='${1-data.saleAmt/data.nmlAmt }' type="percent" /></em> --%>
							<br>
							  <del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
							  <img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt="">
							<strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원
						</span>
					</p>
				</a>
			</div>

		</c:if>
	</c:forEach>

	</div>

	<c:if test="${fn:length(resultList) == 0}">
	<div class="item-noContent">
		<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png' />" alt="경고"></p>
		<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
	</div>
	</c:if>

	<c:if test="${'Y' != totSch}"><%-- 통합검색에서 온거 제외 --%>
		<c:if test="${fn:length(resultList)!=0}">
			<div class="pageNumber">
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_AdSearch" />
				</p>
			</div>
		</c:if>
	</c:if>




