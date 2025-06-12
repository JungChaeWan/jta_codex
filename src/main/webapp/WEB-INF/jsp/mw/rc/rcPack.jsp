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
		<a href="javascript:fn_DetailRcPack('${prdtInfo.prdtNum}');">
			<div class="goods-image goods-image1">
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
					<strong>${prdtInfo.prdtNm}</strong>
					<em>${prdtInfo.corpNm}</em>
				</span>
				<span class="price">
					<em>
						<c:if test="${prdtInfo.nmlAmt>0 }">
                    		<fmt:formatNumber value='${1-prdtInfo.saleAmt/prdtInfo.nmlAmt }' type="percent" />
                    	</c:if>
                      	<c:if test="${!(prdtInfo.nmlAmt>0) }">
                      		0%
                      	</c:if>
					</em><br>
					<del><fmt:formatNumber>${prdtInfo.nmlAmt}</fmt:formatNumber>원</del> 
					<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber>${prdtInfo.saleAmt}</fmt:formatNumber></strong>원~
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
			<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_RcPackSearch" />
		</p>
	</div>
</c:if> 

