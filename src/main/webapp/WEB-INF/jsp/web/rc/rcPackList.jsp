<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 상품 리스트 -->
    <div class="itemWrap">
    	<c:forEach items="${resultList}" var="prdtInfo" varStatus="status">
    		<div class="item">
             <a href="javascript:fn_DetailRcPack('${prdtInfo.prdtNum}');">                                                
                 <p class="photo">
                     <!--알림-->
					<c:if test="${mYn != 'Y'}">
                     <c:if test="${prdtInfo.ableYn=='Y'}">
                     	<span class="nt ntReservation">예약가능</span>
                     </c:if>
                     <c:if test="${prdtInfo.ableYn!='Y'}">
                     	<span class="nt ntDisabled">예약마감</span>
                     </c:if>
                     </c:if>
                     <!--photo-->
                     <img class="img" src="${prdtInfo.savePath}thumb/${prdtInfo.saveFileNm}" alt="">
                 </p>
                 <article class="textWrap">
                     <h5 class="title">${prdtInfo.prdtNm}</h5>
                     <p class="subTitle">${prdtInfo.rcNm}</p>
                     <ul class="info">
                         <li class="saleWrap">
                             <p class="sale">
                             	<span class="t_price">탐나오가</span>
                             	<%-- <c:if test="${prdtInfo.nmlAmt>0 }">
		                    		<fmt:formatNumber value='${1-prdtInfo.saleAmt/prdtInfo.nmlAmt }' type="percent" />
		                    	</c:if>
		                      	<c:if test="${!(prdtInfo.nmlAmt>0) }">
		                      		0%
		                      	</c:if> --%>
                             </p>
                             <p class="won"><span class="won1"><fmt:formatNumber>${prdtInfo.nmlAmt}</fmt:formatNumber></span><span class="won2"><fmt:formatNumber>${prdtInfo.saleAmt}</fmt:formatNumber></span></p>
                         </li>
                         <li class="comment">
                             <p class="like">
                                 <span><img src="<c:url value='/images/web/icon/heart.gif'/>" alt="하트"></span>
                                 <span class="ind_grade"><strong>${prdtInfo.gpaAvg}</strong>/5</span>
                             </p>
                         </li>
                     </ul>
                 </article>
             </a>
         </div>
    	</c:forEach>
    	<c:if test="${fn:length(resultList)==0}">
			<div class="item-noContent">
				<p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
				<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
			</div>
    	</c:if>
    </div> <!-- //itemWrap -->
    <c:if test="${fn:length(resultList) > 0}">
	    <div class="pageNumber">
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_RcPackSearch" />
			</p>
		</div>
	</c:if> 
