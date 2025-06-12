<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<c:forEach items="${resultList}" var="prdtInfo" varStatus="status">
<li <c:if test="${paginationInfo.currentPageNo eq 1 and status.count eq 1}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if>>
    <div class="photo">
        <a href="javascript:fn_DetailPrdt('${prdtInfo.prdtNum}');">
            <img src="<c:url value='${prdtInfo.saveFileNm}' />" alt="${prdtInfo.prdtNm}">
        </a>
    </div>
    <div class="text">
        <div class="title">${prdtInfo.prdtNm}</div>
        <div class="info">
            <dl>
                <dd>
                    <div class="price">
                    	<del><fmt:formatNumber>${prdtInfo.nmlAmt}</fmt:formatNumber>원</del>
                        <strong><fmt:formatNumber>${prdtInfo.saleAmt}</fmt:formatNumber>원</strong>
                    </div>                  
                    <div class="label-groupA">
                      <c:if test="${prdtInfo.eventCnt > 0 }">
                        <span class="comm-label blue">이벤트</span>
                      </c:if>
                      <c:if test="${prdtInfo.couponCnt > 0 }">
                        <span class="comm-label red">할인쿠폰</span>
                  	  </c:if>
                    </div>
                </dd>
            </dl>
            <div class="like">
            	<c:if test="${not empty pocketMap[prdtInfo.prdtNum] }">
		    	<a href="javascript:void(0)">
		            <img src="<c:url value='/images/mw/icon/product_like_on.png' />" alt="찜하기">
		        </a>
		  		</c:if>
		  		<c:if test="${empty pocketMap[prdtInfo.prdtNum] }">
		  		<a href="javascript:void(0)" id="pocket${prdtInfo.prdtNum }" onclick="fn_listAddPocket('${Constant.RENTCAR}', '${prdtInfo.corpId }', '${prdtInfo.prdtNum }')">
		            <img src="<c:url value='/images/mw/icon/product_like_off.png' />" alt="찜하기">
		        </a>
		  		</c:if>
            </div>
        </div>
    </div>
</li>
</c:forEach>
