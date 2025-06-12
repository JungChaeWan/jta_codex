<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />

                                        <form id="spCalendarForm">
                                            <input type="hidden" name="iYear" id="iYear" value='0' />
                                            <input type="hidden" name="iMonth" id="iMonth" value='0' />
                                            <input type="hidden" name="sPrevNext" id="sPrevNext" value=""/>
                                            <input type="hidden" name="saleStartDt" id="saleStartDt" value="${prdtInfo.saleStartDt }" />
                                            <input type="hidden" name="saleEndDt" id="saleEndDt" value="${prdtInfo.saleEndDt}" />
                                            <input type="hidden" name="spDivSn" id="spDivSn" value="${cartInfo.spDivSn}" />
                                            <input type="hidden" name="spOptSn" id="spOptSn" value="${cartInfo.spOptSn}" />
                                            <input type="hidden" name="prdtNum" id="prdtNum" value="${prdtInfo.prdtNum}" />
                                            <input type="hidden" name="prdtDiv" id="prdtDiv" value="${prdtInfo.prdtDiv}" />
                                            <%--<input type="hidden" name="aplDt" id="aplDt" value="${cartInfo.aplDt}" />--%>
                                            <input type="hidden" name="addOptAmt" id="addOptAmt" value="${cartInfo.addOptAmt}" />
                                            <input type="hidden" name="addOptNm" id="addOptNm" value="${cartInfo.addOptNm}" />
                                            <input type="hidden" name="addOptListLength" id="addOptListLength" value="${fn:length(addOptList)}" />
                                        </form>
										<div class="pack-option option-box" style="display:block;">
                                            <h4 class="title">옵션변경하기 <a class="option-close"><img src="../images/web/cart/close.png" alt="닫기"></a></h4>
                                            <div class="info-head">
                                                <div class="info-title">
                                                    <p class="photoBox"><img src="${prdtInfo.savePath}thumb/${prdtInfo.saveFileNm}" alt="${prdtInfo.prdtNm}"></p>
                                                    <p class="text">
                                                        <span class="real_time">${prdtInfo.prdtNm}</span>
                                                        <span class="prd_name">${cartInfo.prdtDivNm}</span>
                                                        <c:if test="${not empty cartInfo.aplDt}">
                                                            <fmt:parseDate var='aplDt' value="${cartInfo.aplDt}" pattern="yyyyMMdd" scope="page"/>
                                                            <span><fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd "/></span>
                                                        </c:if>
                                                        <span>${cartInfo.optNm}</span>
                                                    </p>
                                                </div>
                                                <!--달력-->
                                                <c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR }">
                                                    <article class="opCal open">
                                                        <h4 class="opCal-title">날짜선택 <span>(<fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd "/>)</span></h4>
                                                        <div class="packCalendar">
                                                            <div class="calendar" >
                                                            </div>
                                                        </div>
                                                    </article>
                                                </c:if>
                                                <!--옵션선택-->
                                                <div class="comm-select comm-select2">
                                                    <a class="select-button" title="옵션을 선택하세요.">옵션을 선택하세요.</a>
                                                    <ul class="select-list-option" id="secondOptionList" style="display:none">
                                                    </ul>
                                                </div>
                                                <c:if test="${fn:length(addOptList) > 0}">
                                                    <div class="comm-select comm-select3">
                                                        <a class="select-button" title="추가옵션을 선택하세요.">
                                                            <c:if test="${empty cartInfo.addOptNm}">추가옵션을 선택하세요.</c:if>
                                                            <c:if test="${not empty cartInfo.addOptNm}"><c:out value="${cartInfo.addOptNm}" /></c:if>
                                                        </a>
                                                        <ul class="select-list-option" id="addOptionList" style="display:none">
                                                        </ul>
                                                    </div>
                                                </c:if>
                                            </div> <!--//info-head-->
                                            <div class="info-text">
                                                <div class="list-cell">
                                                    <!--선택항목추가-->
                                                    <div class="qtyWrap">
                                                        <ul>
                                                            <li>
                                                                <ol>
                                                                    <li class="list1"></li>
                                                                    <li class="list2">
                                                                        <input type="text" value="${cartInfo.qty}" id="qty">
                                                                        <button class="addition" onclick="addition(); return false;">+</button>
                                                                        <button class="subtract" onclick="substract(); return false;">-</button>
                                                                    </li>
                                                                  <!-- <li class="list3"><span class="price" id="optTotalAmt">99,999,999</span></li> -->
                                                                </ol>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="price-wrap">
                                                    <p class="info4"><span class="plus">총합계</span> <strong id="vTotalAmt"><fmt:formatNumber>${cartInfo.totalAmt}</fmt:formatNumber></strong><span>원</span></p>
                                                </div>
                                                <p class="comm-button2 complete-btn" onclick="changeOptionCart('${cartInfo.cartSn}'); return false;">
                                                   <a class="color0 style0" href="">변경완료</a>
                                                </p>
                                            </div>
                                        </div> <!--//option-box(패키지)-->


