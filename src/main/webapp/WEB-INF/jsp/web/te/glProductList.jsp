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
								
	<h5 class="listTitle1">검색결과<span class="subText">${searchVO.sFromDtView} 실시간 예약이 가능한 골프장입니다.</span></h5>
	
	<c:if test="${fn:length(resultList)!=0}">
	    <!-- item -->
	    <div class="itemWrap golf-itemWrap">
	    	<c:forEach var="data" items="${resultList}" varStatus="status">
	    
		        <div class="item">
		            <a onclick="fn_ShowOption('${data.prdtNum}', 'gl');">
		                <p class="photo">
		                    <!--알림-->
		                    <c:if test="${data.eventCnt>0}"> 
				            	<img src="<c:url value='/images/web/icon/event.png'/>" alt="이벤트">
				          	</c:if>                                                    
		                    <!-- <span class="nt ntReservation">예약가능</span> -->
		                    <!--photo-->
		                    <c:if test="${!(empty data.saveFileNm)}">
					            <img class="img" src="${data.savePath}thumb/${data.saveFileNm}" alt="">	
					         </c:if>
					         <c:if test="${empty data.saveFileNm}">
					           	<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="">
					         </c:if>
		                </p>
		                <article class="textWrap">
		                    <h5 class="title"><span>[<c:out value='${data.glAreaNm}'/>]</span> <c:out value="${data.prdtNm}"/></h5>
		                    <p class="subTitle"><c:out value='${data.simpleExp}'/></p>
		                    <ul class="info">
		                        <li class="saleWrap">
		                            <p class="sale">
		                            	<span class="t_price">탐나오가</span>
		                            	<%-- <c:if test="${data.nmlAmt>0 }">
				                    		<fmt:formatNumber value='${1-data.saleAmt/data.nmlAmt }' type="percent" />
				                    	</c:if>
				                      	<c:if test="${!(data.nmlAmt>0) }">
				                      		0%
				                      	</c:if> --%>
		                            </p>
		                            <p class="won"><span class="won1"><fmt:formatNumber>${data.nmlAmt}</fmt:formatNumber></span><span class="won2"><fmt:formatNumber>${data.saleAmt}</fmt:formatNumber></span></p>
		                        </li>
		                        <li class="comment">
		                            <p class="like">
		                                <span><img src="<c:url value='/images/web/icon/heart.gif'/>" alt="하트"></span></span>
		                                <span class="ind_grade"><strong>${data.gpaAvg}</strong>/5</span>
		                            </p>
		                        </li>
		                    </ul>
		                </article>
		                <div class="golf-overInfo">
		                    <h3 class="title"><c:out value="${data.prdtNm}"/></h3>
		                    <ul class="infoBox">
		                    	<c:forEach var="dataD" items="${data.glWList}" varStatus="status">
			                        <li>
			                            <ol>
			                                <li class="list1">${fn:substring(dataD.aplDt,4,6)}/${fn:substring(dataD.aplDt,6,8)}</li>
			                              	<c:if test="${dataD.rsv > 0}">
								        		<li class="list2">${dataD.rsv}개조</li>
								        		<li class="list3"><span class="on">예약가능</span></li>
								        	</c:if>
								        	<c:if test="${!(dataD.rsv > 0)}">
								        		<li class="list2">0개조</li>
								        		<li class="list3"><span class="off">예약불가</span></li>
								        	</c:if>
			                            </ol>
			                        </li>
			                    </c:forEach>
		                    </ul>
		                </div>
		            </a>
		        </div> <!-- //item -->
		   	</c:forEach>
	        <%--
	        <div class="item">
	            <a onclick="show_popup('.option-wrap');">
	                <p class="photo">
	                    <!--알림-->                                                    
	                    <span class="nt ntTopL"><img src="../images/web/icon/event.png" alt="이벤트"></span>
	                    <span class="nt ntDisabled">예약불가</span>
	                    <!--photo-->
	                    <img class="img" src="../images/web/golf/01.jpg" alt="">
	                </p>
	                <article class="textWrap">
	                    <h5 class="title"><span>[제주시권]</span> 아이브리조트, 자연속힐링</h5>
	                    <p class="subTitle">9월객실 업그레이드 이벤트</p>
	                    <ul class="info">
	                        <li class="saleWrap">
	                            <p class="sale">45%</p>
	                            <p class="won"><span class="won1">200,000</span><span class="won2">59,900</span></p>
	                        </li>
	                        <li class="comment">
	                            <p class="like">
	                                <span><img src="../images/web/icon/heart.gif" alt="하트"></span>
	                                <span class="ind_grade"><strong>4.8</strong>/5</span>
	                            </p>
	                        </li>
	                    </ul>
	                </article>
	                <div class="golf-overInfo">
	                    <h3 class="title">핀크스CC</h3>
	                    <ul class="infoBox">
	                        <li>
	                            <ol>
	                                <li class="list1">9/13</li>
	                                <li class="list2">4개조</li>
	                                <li class="list3"><span class="on">예약가능</span></li>
	                            </ol>
	                        </li>
	                        <li>
	                            <ol>
	                                <li class="list1">9/14</li>
	                                <li class="list2">4개조</li>
	                                <li class="list3"><span class="on">예약가능</span></li>
	                            </ol>
	                        </li>
	                        <li>
	                            <ol>
	                                <li class="list1">9/15</li>
	                                <li class="list2">4개조</li>
	                                <li class="list3"><span class="off">예약불가</span></li>
	                            </ol>
	                        </li>
	                    </ul>
	                </div>
	            </a>
	        </div> <!-- //item -->
	         --%>
	        
	        <div class="pageNumber">
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_GlSearch" />
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
                                 