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
 
<div class="prdt-wrap">
	<c:forEach items="${resultList}" var="result" varStatus="status">
	<div class="goods-list">
		<a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${result.prdtNum}'/>">
			<div class="goods-image goods-image1">
				<p class="tag-wrap">
					<c:if test="${result.eventCnt > 0 }">
					<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
					</c:if>
					<c:if test="${result.superbSvYn eq 'Y' }">
                    <img src="<c:url value='/images/mw/icon/speciality.png'/>" alt="우수관광기념품">
                    </c:if>
				</p>
				<ul class="view">
					<li><img src="${result.savePath}thumb/${result.saveFileNm}" alt=""></li>
				</ul>
				
			</div>
			<p class="info">
				<span class="txt">
					<strong><c:out value='${result.prdtNm}' /></strong>
					<em><c:out value="${result.prdtInf}"/></em>

					<span class="heart">
						<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
						<span class="ind_grade"><strong>${result.gpaAvg }</strong>/5</span>
					</span>
				</span>
				<span class="price">
					<c:if test="${result.saleAmt ne result.nmlAmt}">
						<em>
               			<fmt:formatNumber value="${1 - (result.saleAmt / result.nmlAmt)}" type="percent"/>
               			</em><br>
               		</c:if>
               		<c:if test="${result.saleAmt eq result.nmlAmt}">
               			<em class="t_price">
               			탐나오가
               			</em><br>
               		</c:if>
					
					<c:if test="${result.saleAmt ne result.nmlAmt}">
						<del><fmt:formatNumber value="${result.nmlAmt}" type="number"/>원</del>
						<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> 
					</c:if> 
					<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/></strong>원
				</span>
			</p>
		</a>
	</div>
	</c:forEach>
</div>
<c:if test="${fn:length(resultList) == 0}">
<div class="item-noContent">
	<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png' />" alt="경고"></p>
	<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
</div>
</c:if>
<c:if test="${fn:length(resultList) > 0}">
    <div class="pageNumber">
		<p class="list_pageing">
			<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_SvSearch" />
		</p>
	</div>
</c:if> 
