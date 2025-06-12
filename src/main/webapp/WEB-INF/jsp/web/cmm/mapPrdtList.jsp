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
							
							<%--<h5 class="listTitle2" id="h_corpNm"></h5>--%>
                            <ul class="product-list">
                            	<c:forEach items="${product}" var="product">
                            	<c:if test="${corpCd eq Constant.ACCOMMODATION}">
                                    <div class="stay_list">
                                        <div class="stay-list">
                                            <div class="itemPrdt">
                                                    <a href="/web/ad/detailPrdt.do?corpId=${product.corpId}" target="_blank" class="bt_stay">
                                    					<div class="i-photo">
                                    						<c:if test="${!(empty product.saveFileNm)}">
                                    						<img class="product" src="${product.savePath}thumb/${product.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
                                    						</c:if>
                                    						<c:if test="${empty product.saveFileNm}">
                                    						<img class="product" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="product">
                                    						</c:if>
                                    					</div>
                                    					<div class="inner-info">
                                    						<h3>${product.adNm}</h3>
                                    						<span class="star">
                                    							<c:forEach begin="1" end="5" varStatus="status">
                                    							<c:choose>
                                    								<c:when test = "${product.gpaAvg < status.current}">
                                    								<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:rgb(202,202,202)">
                                    								<path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
                                    								</svg>
                                    								</c:when>
                                    								<c:otherwise>
                                    								<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:currentColor">
                                    								<path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
                                    								</svg>
                                    								</c:otherwise>
                                    							</c:choose>
                                    							</c:forEach>
                                    							<span class="star-num">
                                    							<c:if test="${product.gpaCnt ne 0}">
                                    								(${product.gpaCnt})
                                    							</c:if>
                                    							</span>
                                    						</span>
                                    						<%--<div class="loc"><img src="/images/web/icon/icon_location02.png" alt="위치">${data.adAreaNm}</div>--%>
                                    						<div class="label-group">
                                    							<c:if test="${product.eventCnt > 0}">
                                    								<span class="comm-label eventblue">이벤트</span>
                                    							</c:if>
                                    							<c:if test="${product.couponCnt > 0}">
                                    								<span class="comm-label purple">할인쿠폰</span>
                                    							</c:if>
                                    							<c:if test="${product.daypriceYn == 'Y'}">
                                    								<span class="comm-label pink">당일특가</span>
                                    							</c:if>
                                    							<c:if test="${product.continueNightYn == 'Y'}">
                                    								<span class="comm-label fullpink">연박할인</span>
                                    							</c:if>
                                    						</div>
                                    						<span class="info_memo">${product.adSimpleExp}</span>
                                    					</div>
                                    					<div class="inner-price">
                                    						<%--<em>${sNights}박기준</em>--%>
                                    						<c:if test="${data.nmlAmt ne product.saleAmt}">
                                    						<span class="per_sale"><fmt:parseNumber var="percent" value="${(product.nmlAmt - product.saleAmt) / product.nmlAmt * 100 }" integerOnly="true"/>${percent}<small>%</small>
                                    						</span>
                                    						</c:if>
                                    						<%--<del><c:if test="${data.nmlAmt ne data.saleAmt}"><fmt:formatNumber value="${data.nmlAmt}"/></c:if></del>--%>
                                    						<strong><fmt:formatNumber value="${product.saleAmt}"/><span class="won">원</span></strong>
                                    					</div>
                                    				</a>
                                    			</div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${corpCd eq Constant.SOCIAL}">
                   				<li>
                                	<div class="cell cell1">
                                    	<p class="photo">
	                                         <img class="img" src="${product.savePath}thumb/${product.saveFileNm}"" alt="">
	                                         <c:if test="${product.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
						                     	<span class="nt ntSale">할인쿠폰</span>
						                     </c:if>
                                        </p>
                                    </div>
                                    <div class="cell cell2">
                                    	<h5 class="title"><c:out value="${product.prdtNm}"/></h5>
                                    	<p class="subTitle"><c:out value="${product.prdtInf}"/></p>
                                   </div>
                                   <div class="cell cell3">
	                                   <div class="saleWrap">
	                                   		<c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
	                                   			<p class="sale"><fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/></p>
	                                   			<p class="won"><span class="won1"><fmt:formatNumber>${product.nmlAmt}</fmt:formatNumber></span><span class="won2"><fmt:formatNumber>${product.saleAmt}</fmt:formatNumber><c:if test="${product.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if></span></p>
	                                   			 <c:if test="${product.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
	                                   			<div class="product"><span>상품구분) </span> <span><c:out value="${product.prdtDivNm}" /> - <c:out value="${product.optNm}" /></span></div>
	                                   			</c:if>
	                                   		</c:if>
	                                    </div>
                                    </div>
                                    <div class="cell cell4">
                                        <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>" target="_blank">바로가기</a>
                                    </div>
                                 </li>
                                 </c:if>
                                 </c:forEach>
                            </ul>