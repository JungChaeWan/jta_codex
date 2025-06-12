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
								
                                <h5 class="listTitle1">전체상품</h5>
								<!-- item -->
                                <div class="itemWrap">
                                <c:forEach items="${resultList}" var="result">
                                	 <c:if test="${result.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
                                    <div class="item">
                                        <a onclick="fn_ShowOption('${result.prdtNum}','sp');">
                                            <p class="photo">
                                                <!--알림-->
                                                 <c:if test="${result.eventCnt > 0 }">
                                                <span class="nt ntTopL"><img src="<c:url value='/images/web/icon/event.png'/>" alt="이벤트"></span>
                                                </c:if>
                                                <!--photo-->
                                                <img class="img" src="${result.savePath}thumb/${result.saveFileNm}" alt="">
                                            </p>
                                            <article class="textWrap">
                                                <h5 class="title"><c:out value='${result.prdtNm}' /></h5>
                                                <p class="subTitle"><c:out value="${result.prdtInf}"/></p>
                                                <ul class="info">
                                                    <li class="saleWrap">
                                                        <p class="sale"><span class="t_price">탐나오가</span><%-- <fmt:formatNumber value="${1 - (result.saleAmt / result.nmlAmt)}" type="percent"/> --%></p>
                                                        <p class="won"><span class="won1"><fmt:formatNumber value="${result.nmlAmt}" type="number"/></span><span class="won2"><fmt:formatNumber value="${result.saleAmt }" type="number"/><c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if></span></p>
                                                    </li>
                                                    <li class="comment">
                                                        <p class="like">
                                                            <span><img src="<c:url value='/images/web/icon/heart.gif '/>" alt="하트"></span>
                                                            <span class="ind_grade"><strong><c:out value="${result.gpaAvg}"/></strong>/5</span>
                                                        </p>
                                                    </li>
                                                </ul>
                                            </article>
                                        </a>
                                    </div> <!-- //item -->
                                    </c:if>
                                    </c:forEach>
                                 <c:if test="${fn:length(resultList)==0}">
                                	<div class="item-noContent">
                                    <p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
                                    <p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
                                </div>
                                </c:if>
                                <c:if test="${fn:length(resultList) > 0}">                                
                                <div class="pageNumber">
	                                <p class="list_pageing">
										<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_SpSearch" />
									</p>
								</div>
								</c:if>   
                                 </div><!-- //itemWrap -->
                                 <c:forEach items="${cntCtgrPrdtList}" var="ctgr">
                                 <input type="hidden" name="sp_ctgr" id="${ctgr.ctgr}" value="${ctgr.prdtCount}" />
                                 </c:forEach>                                 