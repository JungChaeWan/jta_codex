
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />

<div class="prdt-wrap">
	<c:forEach items="${resultList}" var="result" varStatus="status">

		<c:if test="${!('Y' == totSch && status.index>=4)}"><%-- 통합검색에서 온거면 8개만 --%>

			<div class="goods-list">
				<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>">
					<div class="goods-image goods-image1">
						<p class="tag-wrap">
							<c:if test="${result.eventCnt > 0 }">
							<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
							</c:if>
							<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
							<img src="<c:url value='/images/mw/sub_common/sale.png'/>" alt="할인쿠폰">
							</c:if>
						</p>
						<ul class="view">
							<li><img src="${result.savePath}thumb/${result.saveFileNm}" alt=""></li>
						</ul>
						<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
		                <div class="bottom-info">
		                     <span class="date">
		                      <fmt:parseDate value='${result.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
		                    	<fmt:parseDate value='${result.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
		                    	<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
		                   </span>
		                </div>
						</c:if>

						 <c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP and result.exprDaynumYn eq Constant.FLAG_N }">
		                 <!-- 상품정보 -->
		                 <div class="bottom-info">
		                 	<%--<c:if test="${not empty result.useAbleTm and result.useAbleTm > 0 }">
		                 	<span class="info">${result.useAbleTm}시간 후 사용</span>
		                 	</c:if>
		                 	<c:if test="${empty result.useAbleTm or result.useAbleTm == 0 }">
		                 	<span class="info">바로사용</span>
		                 	</c:if>--%>
		                     <span class="date">
		                     	<fmt:parseDate value='${result.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
		                     	<fmt:parseDate value='${result.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
		                     	<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
		                     </span>
		                 </div>
		                 </c:if>

		                 <c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP and result.exprDaynumYn eq Constant.FLAG_Y }">
		                 <div class="bottom-info">
		                 	<c:if test="${not empty result.useAbleTm and result.useAbleTm > 0 }">
		                 	<span class="info">${result.useAbleTm}시간 후 사용</span>
		                 	</c:if>
		                 	<c:if test="${empty result.useAbleTm or result.useAbleTm == 0 }">
		                 	<span class="info">바로사용</span>
		                 	</c:if>
		                     <span class="date">구매 후 ${result.exprDaynum}일</span>
		                 </div>
		                 </c:if>
					</div>
					<p class="info">
						<span class="txt">
							<strong><c:out value='${result.prdtNm}' /></strong>
							<em><c:out value="${result.prdtInf}"/></em>

							<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
			                 <!-- 옵션추가 (상품구분 - 옵션명 기준) -->
				                <span class="product">
									<span>상품구분) </span> <span><c:out value="${result.prdtDivNm}" /> - <c:out value="${result.optNm}" /> 기준</span>
								</span>
			                </c:if>

							<span class="heart">
								<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
								<span class="ind_grade"><strong>${result.gpaAvg }</strong>/5</span>
							</span>
						</span>
						<span class="price">
							<c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
							<em class="t_price">탐나오가</em>
							<%-- <em><fmt:formatNumber value="${1 - (result.saleAmt / result.nmlAmt)}" type="percent"/></em>	 --%>
							<br>
							  <del><fmt:formatNumber value="${result.nmlAmt}" type="number"/>원</del> <img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt="">
							<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/></strong>원<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if>
							</c:if>
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
	<c:if test="${fn:length(resultList) > 0}">
	    <div class="pageNumber">
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_SpSearch" />
			</p>
		</div>
	</c:if>
</c:if>
