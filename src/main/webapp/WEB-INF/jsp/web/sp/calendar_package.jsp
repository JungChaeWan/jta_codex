<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>          
<un:useConstants var="Constant" className="common.Constant" />
														
														<div class="calHead">
															<div class="cal-top">
																	<c:if test="${spCalendar.prevYn eq Constant.FLAG_Y }">
                                                                    <a href="javascript:prevCalendar();" class="calPrev"><img src="<c:url value='/images/web/icon/arrow4.gif'/>" alt="이전달" /></a>
                                                                    </c:if>
                                                                    <span class="calY1">${spCalendar.iYear}. </span><span class="select calM1">${spCalendar.iMonth}</span>
                                                                    <c:if test="${spCalendar.nextYn eq Constant.FLAG_Y }">
                                                                    <a href="javascript:nextCalendar();" class="calNext"><img src="<c:url value='/images/web/icon/arrow5.gif'/>" alt="다음달" /></a>
                                                                    </c:if>
                                                                </div>
                                                                <fmt:parseDate var="toDay" value="${today}" pattern="yyyyMMdd"/>
                                                                 <div class="cal-info">
                                                                    <%--<p class="info1"><span class="colorBG"></span> <span>선택 날짜</span></p>--%>
                                                                    <%--<p class="info2"><span class="colorBG"></span> <span>판매종료/매진</span></p>--%>
                                                                </div>
                                                                
                                                         </div>
                                                         <div class="calBody">
                                                             <table class="cal">
                                                                 <thead>
                                                                     <tr class="cal_title_tr">
                                                                         <th scope="col" class="sun">일</th>
                                                                         <th scope="col">월</th>
                                                                         <th scope="col">화</th>
                                                                         <th scope="col">수</th>
                                                                         <th scope="col">목</th>
                                                                         <th scope="col">금</th>
                                                                         <th scope="col" class="sat">토</th>
                                                                     </tr>
                                                                 </thead>
                                                                 <tbody>
                                                                     <tr>
                                                                     	<c:forEach var="prevMonthDay"  varStatus="status"  begin="1" end="${spCalendar.iWeek-1}">
                                                                         <td <c:if test="${status.first}"> class="sun"</c:if>>
                                                                         </td>
                                                                         </c:forEach>
                                                                         <c:forEach var="calendar" items="${calendarList}" varStatus="status">
                                                                         
                                                                         <td <c:if test="${calendar.iWeek == 1}">class="sun"</c:if> <c:if test="${calendar.iWeek == 7}">class="sat"</c:if>>
                                                                         	<fmt:parseDate var="calFullDay" value="${calendar.fullDay}" pattern="yyyyMMdd" />
                                                                         	<c:choose>
                                                                         	<c:when test="${calFullDay >= toDay and calendar.saleYn eq Constant.FLAG_Y}">
                                                                         		<c:if test="${calendar.ddlYn eq Constant.FLAG_Y}">
                                                                         			<div class="end" onClick="return false;">${calendar.iDay}<br><em>마감</em></div>
                                                                         		</c:if>
                                                                         		<c:if test="${calendar.ddlYn eq Constant.FLAG_N}">
                                                                         			<a class="reser" onClick="selectCalOption('${calendar.fullDay}', this); return false;">${calendar.iDay}<br><em>예약</em></a>
                                                                            </c:if>
                                                                         	</c:when>
                                                                         	<c:otherwise>
                                                                         		${calendar.iDay} 
                                                                         	</c:otherwise>
                                                                         	</c:choose>
                                                                         </td>
                                                                     <c:if test="${calendar.iWeek == 7 && calendar.iDay!=spCalendar.iMonthLastDay}">
                                                                     </tr>
                                                                     <tr>
                                                                     </c:if>
                                                                     		<c:set var="lastWeek" value="${calendar.iWeek}"/>
                                                                         </c:forEach>
                                                                    	<c:forEach varStatus="status" begin="${lastWeek+1}" end="7">
									                                    	<td></td>
									                                    </c:forEach>
                                                                     </tr>
                                                                 </tbody>
                                                             </table>
                                                         </div>