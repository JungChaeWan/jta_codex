<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>          
<un:useConstants var="Constant" className="common.Constant" />

					<strong class="cal">
						<c:if test="${spCalendar.prevYn eq Constant.FLAG_Y }">
							<a href="javascript:prevCalendar();"><img src="<c:url  value='/images/mw/sub_common/ca_prev.png'/>" width="7" alt="이전"></a>
						</c:if>
						<span class="calY1">${spCalendar.iYear}</span>년 <span class="calM1">${spCalendar.iMonth}</span>월
						<c:if test="${spCalendar.nextYn eq Constant.FLAG_Y }">
							<a href="javascript:nextCalendar();"><img src="<c:url  value='/images/mw/sub_common/ca_next.png'/>" width="7" alt="다음"></a>
						</c:if>
					</strong>
					<fmt:parseDate var="toDay" value="${today}" pattern="yyyyMMdd"/>
					<table class="cal">
						<tr>
							<th>일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th>토</th>
						</tr>
						<tr>
							<c:forEach var="prevMonthDay"  varStatus="status"  begin="1" end="${spCalendar.iWeek-1}">
								<td></td>
							</c:forEach>
							<c:forEach var="calendar" items="${calendarList}" varStatus="status">
							<fmt:parseDate var="calFullDay" value="${calendar.fullDay}" pattern="yyyyMMdd" />
							<c:choose>
                               	<c:when test="${calFullDay >= toDay and calendar.saleYn eq Constant.FLAG_Y}">
                               		<c:if test="${calendar.ddlYn eq Constant.FLAG_Y}">
										<td class="off">${calendar.iDay}<br><em>마감</em></td>
                               		</c:if>
                               		<c:if test="${calendar.ddlYn eq Constant.FLAG_N}">
                               			<td class="on"><a  onClick="selectCalOption('${calendar.fullDay}', this); return false;">${calendar.iDay}<br><em>예약</em></a>
                               		</c:if>
                               	</c:when>
                               	<c:otherwise>
                               		<td>${calendar.iDay}</td> 
                               	</c:otherwise>
                           </c:choose>
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
						</table>
					
