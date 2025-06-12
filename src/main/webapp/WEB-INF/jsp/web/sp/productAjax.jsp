<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />

<%-- <c:set var="targetStr"> target="_blank"</c:set> --%>
<c:if test="${searchVO.sCtgr eq 'C200' or searchVO.sCtgr eq 'C300' }">
	<c:set var="targetStr" value="" />
</c:if>
    
<c:if test="${'Y' ne totSch}">	<%-- 상품 검색 리스트 --%>  

		<c:forEach items="${resultList}" var="result" varStatus="status">
		<c:if test="${fn:contains(result.prdtNm, '제주투어패스') or fn:contains(result.prdtNm, '올패스')}">
		<li class="list-item" <c:if test="${paginationInfo.currentPageNo eq 1 and status.count eq 1}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if> data-corpid=${result.corpId}>
			<a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>" onclick="$('#pageIndex').val(1);" ${targetStr } target="_self" class="link__item">
	            <c:if test="${result.advRvYn eq Constant.FLAG_Y }">
					<span class="thumLabel">사전예약</span>
	            </c:if>
                <div class="box__image">
                	<c:choose>
                		<c:when test="${status.count < 9}">
                			<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" width="270" height="270">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" width="270" height="270">
							</c:if>
                		</c:when>
                		<c:otherwise>
                			<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy" width="270" height="270">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy" width="270" height="270">
							</c:if>
                		</c:otherwise>
                	</c:choose>
					
                </div>
                <div class="box__information">
					<%--<c:if test="${not empty result.useAbleTm and result.useAbleTm > 0 }">
						<strong class="bx_label _green">${result.useAbleTm}시간 후 사용</strong>
					</c:if>
					<c:if test="${empty result.useAbleTm or result.useAbleTm == 0 }">
						<strong class="bx_label _green">바로사용</strong>
					</c:if>--%>
                    <div class="bxTitle"><c:out value='${result.prdtNm}' /></div>
                    <div class="bxEvent"><c:out value="${result.prdtInf}" default="　"/></div>
                    <div class="bxPrice">
	                    <c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
							<c:if test="${result.nmlAmt ne result.saleAmt}">
							<span class="per_sale">
							<c:if test="${result.nmlAmt ne 0}">
								<fmt:parseNumber var="percent" value="${(result.nmlAmt - result.saleAmt) / result.nmlAmt * 100}" integerOnly="true"/>
								<c:if test = "${percent > 0}">${percent}<small>%</small></c:if>
							</c:if>
							</span>
							</c:if>
							<span class="text__price"><fmt:formatNumber value="${result.saleAmt}"/></span><span class="text__unit">원</span>
	                        <%--<span class="text__price"><fmt:formatNumber value="${result.saleAmt}"/></span><span class="text__unit">원~</span>--%>
		                </c:if>
						<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
	                        <span class="text__price"></span><span class="text__unit"></span>
							<span class="single">쿠폰상품</span>
		                </c:if>
	                </div>
					<!-- 20211216 클래스명 추가 -->
					<div class="bxLabel sp-box-area">
						<!-- //20211216 클래스명 추가 -->
						<c:if test="${result.eventCnt > 0 }">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${result.couponCnt > 0 }">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${result.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<c:if test="${result.tamnacardYn eq 'Y' }">
							<span class="main_label yellow">탐나는전</span>
						</c:if>
					</div>
                </div>
    		</a>
		</li>
		</c:if>
 		</c:forEach>
		<c:forEach items="${resultList}" var="result" varStatus="status">
		<c:if test="${!fn:contains(result.prdtNm, '제주투어패스') and !fn:contains(result.prdtNm, '올패스')}">
		<li class="list-item" <c:if test="${paginationInfo.currentPageNo eq 1 and status.count eq 1}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if> data-corpid=${result.corpId}>
			<a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>" onclick="$('#pageIndex').val(1);" ${targetStr } target="_self" class="link__item">
	            <c:if test="${result.advRvYn eq Constant.FLAG_Y }">
					<span class="thumLabel">사전예약</span>
	            </c:if>
                <div class="box__image">
                	<c:choose>
                		<c:when test="${status.count < 9}">
                			<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" width="270" height="270">
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" width="270" height="270">
							</c:if>
                		</c:when>
                		<c:otherwise>
                			<c:if test="${result.lsLinkYn eq 'Y' }">
								<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy" width="270" height="270" >
							</c:if>
							<c:if test="${result.lsLinkYn ne 'Y' }">
								<img src="${result.savePath}thumb/${result.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy" width="270" height="270" >
							</c:if>
                		</c:otherwise>
                	</c:choose>
                </div>
                <div class="box__information">
					<%--<c:if test="${not empty result.useAbleTm and result.useAbleTm > 0 }">
						<strong class="bx_label _green">${result.useAbleTm}시간 후 사용</strong>
					</c:if>
					<c:if test="${empty result.useAbleTm or result.useAbleTm == 0 }">
						<strong class="bx_label _green">바로사용</strong>
					</c:if>--%>
                    <div class="bxTitle"><c:out value='${result.prdtNm}' /></div>
                    <div class="bxEvent"><c:out value="${result.prdtInf}" default="　"/></div>
                    <div class="bxPrice">
	                    <c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
							<c:if test="${result.nmlAmt ne result.saleAmt}">
							<span class="per_sale">
							<c:if test="${result.nmlAmt ne 0}">
								<fmt:parseNumber var="percent" value="${(result.nmlAmt - result.saleAmt) / result.nmlAmt * 100}" integerOnly="true"/>
								<c:if test = "${percent > 0}">${percent}<small>%</small></c:if>
							</c:if>
							</span>
							</c:if>
							<span class="text__price"><fmt:formatNumber value="${result.saleAmt}"/></span><span class="text__unit">원</span>
	                        <%--<span class="text__price"><fmt:formatNumber value="${result.saleAmt}"/></span><span class="text__unit">원~</span>--%>
		                </c:if>
						<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
	                        <span class="text__price"></span><span class="text__unit"></span>
							<span class="single">쿠폰상품</span>
		                </c:if>
	                </div>
					<!-- 20211216 클래스명 추가 -->
					<div class="bxLabel sp-box-area">
						<!-- //20211216 클래스명 추가 -->
						<c:if test="${result.eventCnt > 0 }">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${result.couponCnt > 0 }">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${result.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<c:if test="${result.tamnacardYn eq 'Y' }">
							<span class="main_label yellow">탐나는전</span>
						</c:if>
					</div>
                </div>
    		</a>
		</li>
		</c:if>
 		</c:forEach>
  	<c:if test="${fn:length(resultList)==0}">
		<div class="item-noContent" id="pageInfoCnt" totalCnt="0" totalPageCnt="0">
			<p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
			<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
		</div>
  	</c:if>  
</c:if>

<%-- 통합검색 --%>
<!-- 20.05.26 통합검색 리뉴얼 TOBE -->
<c:if test="${'Y' eq totSch}">
	<ul class="col5">
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<li class="list-item <c:if test="${status.index >= 10}">off</c:if>">
	    		<a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>" ${targetStr } target="_self">
					<div class="box__image">
						<c:if test="${result.lsLinkYn eq 'Y' }">
							<img src="${result.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
						</c:if>
						<c:if test="${result.lsLinkYn ne 'Y' }">
							<img src="${result.savePath}thumb/${result.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
						</c:if>
						<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
							<div class="bottom-info">
								<span class="date">
									<fmt:parseDate value='${result.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:parseDate value='${result.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
								</span>
							</div>
						</c:if>
					</div>
					<div class="box__information">
						<div class="bxTitle"><c:out value='${result.prdtNm}' /></div>
						<div class="bxEvent"><c:out value="${result.prdtInf}" default="　"/></div>							
						<div class="bxPrice">
							<span class="text__price"><fmt:formatNumber value="${result.saleAmt}"/></span><span class="text__unit">원</span>
						</div>
						<!-- 20211216 클래스명 추가 -->
						<div class="bxLabel search-box-area">
							<!-- //20211216 클래스명 추가 -->
							<c:if test="${result.eventCnt > 0 }">
								<span class="main_label eventblue">이벤트</span>
							</c:if>
							<c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
								<span class="main_label pink">할인쿠폰</span>
							</c:if>
							<c:if test="${result.superbCorpYn == 'Y' }">
								<span class="main_label back-red">우수관광사업체</span>
							</c:if>
							<c:if test="${result.tamnacardYn eq 'Y' }">
								<span class="main_label yellow">탐나는전</span>
							</c:if>
						</div>				
					</div>
				</a>
			</li>
		</c:forEach>
		
		<c:if test="${fn:length(resultList)==0}">
			<div class="item-noContent">
				<p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
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
	</ul>
</c:if>