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
	<h5 class="listTitle1">검색결과<span class="subText">${searchVO.sFromDtView}부터 ${fn:substring(searchVO.sFromTm,0,2)}:00시 실시간 예약이 가능한 렌터카입니다.</span></h5>
	
	<c:if test="${fn:length(resultList)!=0}">
	
	    <!-- item -->
	    <div class="itemWrap">
	    	<c:forEach items="${resultList}" var="prdtInfo" varStatus="status">
	
		        <div class="item">
		            <a onclick="fn_ShowOption('${prdtInfo.prdtNum}', 'rc');">
		                <p class="photo">
		                    <!--알림-->
		                    <span class="nt ntTopL">
		                     	<c:if test="${prdtInfo.useFuelDiv=='CF01'}"><img src="<c:url value='/images/web/rent/oil1.gif'/>" alt="휘발유"></c:if>
		                     	<c:if test="${prdtInfo.useFuelDiv=='CF02'}"><img src="<c:url value='/images/web/rent/oil3.gif'/>" alt="디젤"></c:if>
		                     	<c:if test="${prdtInfo.useFuelDiv=='CF03'}"><img src="<c:url value='/images/web/rent/oil2.gif'/>" alt="LPG"></c:if>
		                     	<c:if test="${prdtInfo.useFuelDiv=='CF04'}"><img src="<c:url value='/images/web/rent/oil4.gif'/>" alt="전기"></c:if>
								
								<!-- <img src="../images/web/icon/event.png" alt="이벤트"> -->
							</span>
		                	<c:if test="${prdtInfo.ableYn=='Y'}">
		                     	<span class="nt ntReservation">예약가능</span>
		                    </c:if>
		                    <c:if test="${prdtInfo.ableYn!='Y'}">
		                    	<span class="nt ntDisabled">예약마감</span>
		                    </c:if>
		                    <!--photo-->
		                    <img class="img" src="${prdtInfo.savePath}thumb/${prdtInfo.saveFileNm}" alt="">
		                </p>
		                <article class="textWrap">
		                    <h5 class="title"><c:out value="${prdtInfo.prdtNm}"/></h5>
		                    <p class="subTitle"><c:out value="${prdtInfo.corpNm}"/></p>
		                    <ul class="info">
		                        <li class="saleWrap">
		                            <p class="sale"><span class="t_price">탐나오가</span><%-- ${prdtInfo.disPer}% --%></p>
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
		        </div> <!-- //item -->
		    </c:forEach>
	  
	        <div class="pageNumber">
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_RcSearch" />
				</p>
			</div>  
	        
	    </div> <!-- //itemWrap -->
	
	</c:if>
	
	<c:if test="${fn:length(resultList)==0}">
	    <!--item 없을 시 출력-->
	    <div class="item-noContent">
	        <p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
	        <p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
	    </div>
   	</c:if>
    
                                 