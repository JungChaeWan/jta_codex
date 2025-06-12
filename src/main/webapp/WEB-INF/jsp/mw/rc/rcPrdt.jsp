<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<div class="prdt-wrap">
<c:forEach items="${resultList}" var="prdtInfo" varStatus="status">
	<div class="goods-list">
		<a href="javascript:fn_DetailPrdt('${prdtInfo.prdtNum}');">
			<div class="goods-image goods-image1">
				<p class="tag-wrap">
					<c:if test="${prdtInfo.useFuelDiv=='CF01'}"><img src="<c:url value='/images/mw/rent/oil1.gif'/>" alt="휘발유"></c:if>
					<c:if test="${prdtInfo.useFuelDiv=='CF02'}"><img src="<c:url value='/images/mw/rent/oil3.gif'/>" alt="디젤"></c:if>
					<c:if test="${prdtInfo.useFuelDiv=='CF03'}"><img src="<c:url value='/images/mw/rent/oil2.gif'/>" alt="LPG"></c:if>
					<c:if test="${prdtInfo.useFuelDiv=='CF04'}"><img src="<c:url value='/images/mw/rent/oil4.gif'/>" alt="전기"></c:if>
					<c:if test="${prdtInfo.eventCnt > 0}">
						<img src="<c:url value='/images/mw/sub_common/event.gif'/>" alt="이벤트">
					</c:if>
				</p>
				<ul class="view">
					<li><img src="${prdtInfo.savePath}thumb/${prdtInfo.saveFileNm}" alt=""></li>
				</ul>
				<p class="comm-like">
					<span class="like${fn:substring(prdtInfo.gpaAvg+((prdtInfo.gpaAvg%1>=0.5)?(1-(prdtInfo.gpaAvg%1))%1:-(prdtInfo.gpaAvg%1)),0,1)}"></span>
					<em>${prdtInfo.gpaAvg}/5</em>
				</p>
			</div>
			<p class="info">
				<span class="txt">
					<strong>
					<c:forEach items="${isrCdList}" var="isrCd" varStatus="status">
                   		<c:if test="${isrCd.cdNum eq prdtInfo.isrDiv}">
							<span class="text-red">[<c:out value="${isrCd.cdNm}"/>]</span>
						</c:if>
                   	</c:forEach>
					${prdtInfo.prdtNm}</strong>
					<em>${prdtInfo.corpNm}</em>
					<c:if test="${prdtInfo.ableYn=='Y'}">
						<span class="btn btn4">예약가능</span>
					</c:if>
					<c:if test="${prdtInfo.ableYn=='N'}">
						<span class="btn btn5">예약마감</span>
					</c:if>
				</span>
				<span class="price">					
					  <em>${prdtInfo.disPer}%</em><br>
					<c:if test="${prdtInfo.disPer ne 0}">
					  <del><fmt:formatNumber>${prdtInfo.nmlAmt}</fmt:formatNumber>원</del> 
					  <img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt="">
					</c:if> 
					<strong><fmt:formatNumber>${prdtInfo.saleAmt}</fmt:formatNumber></strong>원~
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
			<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_RcSearch" />
		</p>
	</div>
</c:if> 

