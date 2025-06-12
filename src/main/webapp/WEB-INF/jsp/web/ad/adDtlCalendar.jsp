<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
$(document).ready(function(){
	if(${adErr}==1){
		console.log("파라메터 오류 입니다.");
		//alert("파라메터 오류 입니다.");
		//return;
	}
	
	if("${calendarVO.scriptVal}"=="CR"){
		changePrdtADCalendarUpdate( '<c:out value="${adPrdtInf.maxiMem}"/>', '${adPrdtInf.prdtNm}');
	}else if("${calendarVO.scriptVal}"=="SD"){
		//selectADCalendarUpdate('${adAddAmtCal.adultAddAmt}', '${adAddAmtCal.juniorAddAmt}', '${adAddAmtCal.childAddAmt}', '${adPrdtInf.addamtYn}' );
	}
	selectADCalendarUpdate('${adAddAmtCal.adultAddAmt}', '${adAddAmtCal.juniorAddAmt}', '${adAddAmtCal.childAddAmt}', '${adPrdtInf.addamtYn}' );

});
</script>

<!--<form commandName="adDtlCalendar" name="adDtlCalendar" method="post">-->
<form name="adDtlCalendar" id="adDtlCalendar" method="get" onSubmit="return false;">
	<input type="hidden" id="corpId" name="corpId" value='<c:out value="${calendarVO.corpId}" />' />
	<input type="hidden" id="prdtNum" name="prdtNum" value='<c:out value="${calendarVO.prdtNum}" />' />
	<input type="hidden" id="prdtNm" name="prdtNm" value='<c:out value="${adPrdtInf.prdtNm}" />' />
	<input type="hidden" id="sFromDt" name="sFromDt" value='<c:out value="${calendarVO.sFromDt}" />' />                       		
	<input type="hidden" id="iYear" name="iYear" value='<c:out value="${calendarVO.iYear}" />' />
	<input type="hidden" id="iMonth" name="iMonth" value='<c:out value="${calendarVO.iMonth}" />' />
	<input type="hidden" id="iNight" name="iNight" value='<c:out value="${calendarVO.iNight}" />' />
	<input type="hidden" id="iMonthLastDay" name="iMonthLastDay" value='<c:out value="${calendarVO.iMonthLastDay}" />' />
	<input type="hidden" id="sPrevNext" name="sPrevNext" value='' />
	<input type="hidden" id="scriptVal" name="scriptVal" value='' />

	<div class="calendar">
	    <div class="calHead">
	    	<c:if test="${calendarVO.prevYn=='Y'}">
	        	<a href="javascript:updateADCalendarPrevNext('prev');" class="calPrev"><img src="<c:url value='/images/web/icon/arrow4.gif'/>" alt="이전달" /></a>
	        </c:if>
	        <c:if test="${calendarVO.prevYn!='Y'}">
	        	<span class="calPrev"><img src="<c:url value='/images/web/icon/arrow4_hide.gif'/>" alt="이전달" /></span>
	        </c:if>	        
	        <span class="calY1">${calendarVO.iYear}. </span><span class="select calM1">${calendarVO.iMonth}</span>
	        <c:if test="${calendarVO.nextYn=='Y'}">
	        	<a href="javascript:updateADCalendarPrevNext('next');" class="calNext"><img src="<c:url value='/images/web/icon/arrow5.gif'/>" alt="다음달" /></a> <!-- arrow5_hide.gif  -->
	        </c:if>
	        <c:if test="${calendarVO.nextYn!='Y'}">
	        	<span class="calNext"><img src="<c:url value='/images/web/icon/arrow5_hide.gif'/>" alt="다음달" /></span>
	        </c:if>
	    </div>
	    <div class="calBody">
	        <table>
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
	            		<c:if test="${!(empty calendarVO.iWeek)}">
		            		<c:forEach var="i" begin="1" end="${calendarVO.iWeek-1}">
	                        	<td><p class="date">&nbsp;</p></td>
	                        </c:forEach>
                        </c:if>
	            		
	            		<c:forEach var="data" items="${calList}" varStatus="status" >
	            			<c:if test="${data.sHolidayYN == 'Y'}">
	            				<td class="sun">
	            			</c:if>
	            			<c:if test="${data.sHolidayYN == 'N'}">
	            				<c:if test="${data.iWeek == 1}">
				               		<td class="sun">
				               	</c:if>	
				               	<c:if test="${data.iWeek == 7}">
				               		<td class="sat">
				               	</c:if>	
				               	<c:if test="${!(data.iWeek == 1 || data.iWeek == 7)}">
				                	<td>
				               	</c:if>
	            			
	            			</c:if>
	            				
		                    	<a href="javascript:selectADCalendar('${data.sFromDt }')"
								   <c:if test="${data.selDayYn=='Y' }">class="select"</c:if>
								   <c:if test="${data.selDayYn=='O' }">class="select_checkout"</c:if>>
									<p class="date">${data.iDay}</p>
		                        	<p class="icon">
		                        		<c:if test="${data.status=='E'}">
		                        			<img src="<c:url value='/images/web/cart/calInfo1.png'/>" alt="예약">
		                        		</c:if>
		                        		<c:if test="${data.status=='D'}">
		                        			<img src="<c:url value='/images/web/cart/calInfo3.png'/>" alt="미정">
		                        		</c:if>
		                        		<c:if test="${data.status=='M'}">
		                        			<img src="<c:url value='/images/web/cart/calInfo2.png'/>" alt="마감">
		                        		</c:if>
		                        		
		                        		
		                        	</p>
		                        	<p class="price">${data.saleAmt}<!-- (${data.useRoomNum}/${data.totalRoomNum}) --></p>
		                        </a>
							</td>
							
							<c:if test="${data.iWeek == 7 && data.iDay!=calendarVO.iMonthLastDay}">
	                          	</tr>
	                          	<tr>
							</c:if>
							<c:set var="lastWeek" value="${data.iWeek}"/>
		            		
	            		</c:forEach>
	            		
	            		<c:forEach var="i" begin="${lastWeek+1}" end="7">
                        	<td><p class="date">&nbsp;</p></td>
                        </c:forEach>
 	
	            	</tr>
	            </tbody>
	        </table>
	    </div>
	</div>
	<ul class="calendar-info">
	    <li><img src="<c:url value='/images/web/cart/calInfo1.png'/>" alt="예약"> 현재 예약 가능한 객실</li>
	    <li><img src="<c:url value='/images/web/cart/calInfo2.png'/>" alt="마감"> 예약불가</li>
	    <li><img src="<c:url value='/images/web/cart/calInfo3.png'/>" alt="미정"> 객실 미확정</li>
	</ul>
</form>
<style>
	a.select_checkout {
		outline: 0;
		height: 64px;
		box-sizing: content-box;
		padding: 0;
		background: #ffe0e8;
		color: #fff;
	}
</style>