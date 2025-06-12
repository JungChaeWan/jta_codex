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

							<form id="spCalendarForm">
							<input type="hidden" id="iYear" name="iYear" value='0' />
                       		<input type="hidden" id="iMonth" name="iMonth" value='0' />
                       		<input type="hidden" id="sPrevNext" name="sPrevNext" value=""/>
                       		<input type="hidden" id="saleStartDt" name="saleStartDt" value="${prdtInfo.saleStartDt }" />
                       		<input type="hidden" id="saleEndDt" name="saleEndDt" value="${prdtInfo.saleEndDt}" />
                       		<input type="hidden" id="prdtNum" name="prdtNum" value="${prdtInfo.prdtNum}" />
                       		<input type="hidden" id="prdtDiv" name="prdtDiv" value="${prdtInfo.prdtDiv}" />
                       		<input type="hidden" id="ctgr" name="ctgr" value="${prdtInfo.ctgr}" />
                       		<input type="hidden" id="corpId" name="corpId" value="${prdtInfo.corpId}" />
                       		<input type="hidden" id="addOptAmt" id="addOptAmt" />
						    <input type="hidden" id="addOptNm" id="addOptNm" />
						    <input type="hidden" id="addOptListLength" id="addOptListLength" value="${fn:length(addOptList)}"/>
                      		</form> 
							<!-- 관광지 옵션변경 -->
	                        <div class="pack-option option-box">
                            <div class="info-head">
                                <h4 class="title">
                                    <c:out value="${prdtInfo.prdtNm}" />
                                    <a class="option-close"><img src="<c:url value='/images/web/cart/close.gif'/>" alt="닫기"></a>
                                </h4>
                                <div class="comm-select comm-select1 open">
                                    <a class="select-button" title="상품을 선택하세요.">상품을 선택하세요.</a>
                                    <ul class="select-list-option" id="firstOptionList" style="display:none">
                                    </ul>
                                </div>
                                <div class="comm-select comm-select2">
                                    <a class="select-button" title="옵션을 선택하세요.">옵션을 선택하세요.</a>
                                    <ul class="select-list-option" id="secondOptionList" style="display:none">
                                    </ul>
                                </div>
                                <c:if test="${fn:length(addOptList) > 0 }">
                                <div class="comm-select comm-select3">
                                    <a class="select-button">추가옵션을 선택하세요.</a>
                                    <ul class="select-list-option" id="addOptionList" style="display:none">
                                    </ul>
                                </div>
                                </c:if>
                            </div> <!--//info-head-->
                            <div class="info-text">
                                <div class="list-cell">
                                    <!--선택항목추가-->
                                    <div class="qtyWrap"  id="selectedItemWrapper" style="display:none">
                                        <ul></ul>
                                    </div>
                                    <div class="price-wrap">
                                        <p class="info4"><span class="plus">총합계</span> <strong id="totalProductAmt">0</strong><span>원</span></p>
                                    </div>
                                    <p class="comm-button2">
                                        <a class="color0" href="javascript:fn_addSp();">선택완료</a>
                                    </p>
                                </div>
                            </div> <!-- //info-text -->
                        </div> <!--//option-box(관광지)-->
