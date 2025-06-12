<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<%-- 상품 검색 리스트 --%>
<c:if test="${'Y' ne totSch}">
  	<c:forEach items="${resultList}" var="result" varStatus="status">
		<c:if test="${fn:contains(result.prdtNm, '제주투어패스') or fn:contains(result.prdtNm, '올패스')}">
		<li <c:if test="${paginationInfo.currentPageNo eq 1 and status.count eq 1}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if> data-corpid=${result.corpId}>
			<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>">
				<div class="social-photo">
					<%--<span class="like">
						<c:if test="${not empty pocketMap[result.prdtNum] }">
							<a href="javascript:void(0)">
								<img src="<c:url value='/images/mw/icon/product_like_on.png'/>" alt="찜하기">
							</a>
						</c:if>
						<c:if test="${empty pocketMap[result.prdtNum] }">
							<a href="javascript:void(0)" id="pocket${result.prdtNum }" onclick="fn_listAddPocket('${Constant.SOCIAL}', '${result.corpId }', '${result.prdtNum }')">
								<img src="<c:url value='/images/mw/icon/product_like_off.png'/>" alt="찜하기">
							</a>
						</c:if>
					</span>--%>
					<div class="bxLabel">
						<c:if test="${result.eventCnt > 0}">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${result.couponCnt > 0}">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${result.advRvYn eq Constant.FLAG_Y }">
							<span class="main_label pink">사전예약</span>
						</c:if>
						<c:if test="${result.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<!-- 20211214 탐나는전 label 추가 -->
						<c:if test="${result.tamnacardYn eq 'Y' }">
							<span class="main_label yellow">탐나는전</span>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${status.count < 10}">
							<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" alt="<c:out value='${result.prdtNm}' />" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" loading="lazy" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" loading="lazy" alt="<c:out value='${result.prdtNm}' />" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>	
						</c:otherwise>
					</c:choose>
					
				</div>
				<div class="text">
					<div class="title"><c:out value='${result.prdtNm}' /></div>
					<div class="info">
						<dl>
							<dt></dt>
							<dd>
								<c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
									<div class="price">
										<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/><span class="won">원</span></strong>
										<c:if test="${result.saleAmt ne result.nmlAmt}">
											<del><fmt:formatNumber value="${result.nmlAmt}" type="number"/>원</del>
										</c:if>
									</div>
								</c:if>
								<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
									<div class="price">
										<strong class="coup-price">쿠폰상품</strong>
									</div>
								</c:if>
							</dd>
						</dl>
					</div>
				</div>
			</a>
		</li>
		</c:if>
  	</c:forEach>

	<c:forEach items="${resultList}" var="result" varStatus="status">
		<c:if test="${!fn:contains(result.prdtNm, '제주투어패스') and !fn:contains(result.prdtNm, '올패스')}">
		<li <c:if test="${paginationInfo.currentPageNo eq 1 and status.count eq 1}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if> data-corpid=${result.corpId}>
			<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>">
				<div class="social-photo">
					<%--<span class="like">
						<c:if test="${not empty pocketMap[result.prdtNum] }">
							<a href="javascript:void(0)">
								<img src="<c:url value='/images/mw/icon/product_like_on.png'/>" alt="찜하기">
							</a>
						</c:if>
						<c:if test="${empty pocketMap[result.prdtNum] }">
							<a href="javascript:void(0)" id="pocket${result.prdtNum }" onclick="fn_listAddPocket('${Constant.SOCIAL}', '${result.corpId }', '${result.prdtNum }')">
								<img src="<c:url value='/images/mw/icon/product_like_off.png'/>" alt="찜하기">
							</a>
						</c:if>
					</span>--%>
					<div class="bxLabel">
						<c:if test="${result.eventCnt > 0}">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${result.couponCnt > 0}">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${result.advRvYn eq Constant.FLAG_Y }">
							<span class="main_label pink">사전예약</span>
						</c:if>
						<c:if test="${result.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<!-- 20211214 탐나는전 label 추가 -->
						<c:if test="${result.tamnacardYn eq 'Y' }">
							<span class="main_label yellow">탐나는전</span>
						</c:if>
					</div>
					<c:choose>
						<c:when test="${status.count < 10}">
							<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" alt="<c:out value='${result.prdtNm}' />" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" loading="lazy" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" loading="lazy" alt="<c:out value='${result.prdtNm}' />" onerror="this.src='/images/web/other/no-image.jpg'">
							</c:if>	
						</c:otherwise>
					</c:choose>
				</div>
				<div class="text">
					<div class="title"><c:out value='${result.prdtNm}' /></div>
					<div class="info">
						<dl>
							<dt></dt>
							<dd>
								<c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
									<div class="price">
										<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/><span class="won">원</span></strong>
										<c:if test="${result.saleAmt ne result.nmlAmt}">
											<del><fmt:formatNumber value="${result.nmlAmt}" type="number"/>원</del>
										</c:if>
									</div>
								</c:if>
								<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
									<div class="price">
										<strong class="coup-price">쿠폰상품</strong>
									</div>
								</c:if>
							</dd>
						</dl>
					</div>
				</div>
			</a>
		</li>
		</c:if>
  	</c:forEach>

  	<c:if test="${(fn:length(resultList) == 0) and (paginationInfo.currentPageNo eq 1)}">
		<div class="item-noContent">
			<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png' />" alt="경고"></p>
			<p class="text"> 죄송합니다.<span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다. </p>
		</div>
  	</c:if>
</c:if>
<%-- 통합검색 리스트 --%>
<c:if test="${'Y' eq totSch}">
	<div class="prdt-wrap">
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<c:if test="${!('Y' == totSch && status.index >= 4)}">
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
								<c:if test="${result.lsLinkYn eq 'Y' }">
									<li><img src="${result.savePath}" alt=""></li>
								</c:if>
								<c:if test="${result.lsLinkYn ne 'Y' }">
									<li><img src="${result.savePath}thumb/${result.saveFileNm}" alt=""></li>
								</c:if>
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
							 <%-- <c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP and result.exprDaynumYn eq Constant.FLAG_N }">
							 <!-- 상품정보 -->
							 <div class="bottom-info">
								<c:if test="${not empty result.useAbleTm and result.useAbleTm > 0 }">
								<span class="info">${result.useAbleTm}시간 후 사용</span>
								</c:if>
								<c:if test="${empty result.useAbleTm or result.useAbleTm == 0 }">
								<span class="info">바로사용</span>
								</c:if>
								 <span class="date">
									<fmt:parseDate value='${result.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:parseDate value='${result.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
								 </span>
							 </div>
							 </c:if> --%>

							 <%-- <c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP and result.exprDaynumYn eq Constant.FLAG_Y }">
							 <div class="bottom-info">
								<c:if test="${not empty result.useAbleTm and result.useAbleTm > 0 }">
								<span class="info">${result.useAbleTm}시간 후 사용</span>
								</c:if>
								<c:if test="${empty result.useAbleTm or result.useAbleTm == 0 }">
								<span class="info">바로사용</span>
								</c:if>
								 <span class="date">구매 후 ${result.exprDaynum}일</span>
							 </div>
							 </c:if> --%>
						</div>
						<p class="info">
							<span class="txt">
								<em><c:out value="${result.prdtInf}"/></em>
								<strong><c:out value='${result.prdtNm}' /></strong>
								<%-- <c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
								 <!-- 옵션추가 (상품구분 - 옵션명 기준) -->
									<span class="product">
										<span>상품구분) </span> <span><c:out value="${result.prdtDivNm}" /> - <c:out value="${result.optNm}" /> 기준</span>
									</span>
								</c:if>

								<span class="heart">
									<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
									<span class="ind_grade"><strong>${result.gpaAvg }</strong>/5</span>
								</span> --%>
							</span>
							<span class="price">
								<c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
									<%-- <em><fmt:formatNumber value="${1 - (result.saleAmt / result.nmlAmt)}" type="percent"/></em>	 --%>
									<%-- <br>
									  <del><fmt:formatNumber value="${result.nmlAmt}" type="number"/>원</del> <img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> --%>
									<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/>원</strong>
								</c:if>
								<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
									<strong>쿠폰상품</strong>
								</c:if>
							</span>
							<!-- 20220307 label 추가 -->
							<span class="bxLabel">
								<c:if test="${result.eventCnt > 0}">
									<span class="main_label eventblue">이벤트</span>
								</c:if>
								<c:if test="${result.couponCnt > 0}">
									<span class="main_label pink">할인쿠폰</span>
								</c:if>
								<c:if test="${result.advRvYn eq Constant.FLAG_Y }">
									<span class="main_label pink">사전예약</span>
								</c:if>
								<c:if test="${result.superbCorpYn == 'Y' }">
									<span class="main_label back-red">우수관광사업체</span>
								</c:if>
								<!-- 20211214 탐나는전 label 추가 -->
								<c:if test="${result.tamnacardYn eq 'Y' }">
									<span class="main_label yellow">탐나는전</span>
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
	<%-- 통합검색에서 온거 제외 --%>
  	<c:if test="${'Y' != totSch}">
		<c:if test="${fn:length(resultList) > 0}">
			<div class="pageNumber">
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_SpSearch" />
				</p>
			</div>
		</c:if>
  	</c:if>
</c:if>
