<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(document).ready(function(){
	/*if(${adErr}==1){
		console.log("파라메터 오류 입니다.");
		//alert("파라메터 오류 입니다.");
		//return;
	}*/

	
	if("${calendarVO.scriptVal}"=="CR"){
		changePrdtADCalendarUpdate( '<c:out value="${adPrdtInf.maxiMem}"/>', '${adPrdtInf.prdtNm}' );
	}else if("${calendarVO.scriptVal}"=="SD"){
		//selectADCalendarUpdate('${adAddAmtCal.adultAddAmt}', '${adAddAmtCal.juniorAddAmt}', '${adAddAmtCal.childAddAmt}' );
	}
	selectADCalendarUpdate('${adAddAmtCal.adultAddAmt}', '${adAddAmtCal.juniorAddAmt}', '${adAddAmtCal.childAddAmt}', '${adPrdtInf.addamtYn}' );
});

</script>

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


	<!-- 0119 datepicker 수정-->
	<dl class="view-select">
		<dt>투숙일자 선택해주세요.</dt>
		<dd>
			<strong class="cal date-of">
				<c:if test="${calendarVO.prevYn=='Y'}">
					<a href="javascript:updateADCalendarPrevNext('prev');"><img src="<c:url value='/images/mw/sub_common/ca_prev.png'/>" width="8" alt="이전"></a>
				</c:if>
				<span>
				<c:if test="${calendarVO.prevYn!='Y'}">
					<img src="<c:url value='/images/mw/sub_common/ca_prev_off.png'/>" width="8" alt="이전">
				</c:if>
				</span>
				 
				${calendarVO.iYear}년 ${calendarVO.iMonth}월
				<c:if test="${calendarVO.nextYn=='Y'}">
					<a href="javascript:updateADCalendarPrevNext('next');"><img src="<c:url value='/images/mw/sub_common/ca_next.png'/>" width="7" alt="다음"></a>
				</c:if>
				<c:if test="${calendarVO.nextYn!='Y'}">
					<img src="<c:url value='/images/mw/sub_common/ca_next_off.png'/>" width="8" alt="다음">
				</c:if>
			</strong>
			<table class="cal">
				<tr>
					<th class="sunday">일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th class="saturday">토</th>
				</tr>
				<tr>
					<c:if test="${!(empty calendarVO.iWeek)}">
						<c:forEach var="i" begin="1" end="${calendarVO.iWeek-1}">
							<td>&nbsp;</td>
						</c:forEach>
					</c:if>
					<c:forEach var="data" items="${calList}" varStatus="status" >
                       	<td class="	<c:if test="${data.selDayYn=='Y' }"> today</c:if>
                       				<c:if test="${data.selDayYn=='O' }"> checkout</c:if>
									<c:if test="${data.status=='E'}"> on</c:if>
									<c:if test="${data.status=='D'}"> off</c:if>
									<c:if test="${data.status=='M'}"> no</c:if>">
                       		<a href="javascript:selectADCalendar('${data.sFromDt }')">
                       			<p>${data.iDay}</p>
                       			<c:if test="${data.status=='E'}">
                       				<em>예약</em>
                       			</c:if>
                       			<c:if test="${data.status=='D'}">
                       				<em>마감</em>
                       			</c:if>
                       			<c:if test="${data.status=='M'}">
                       				<em>마감</em>
                       			</c:if>
                       		</a>
                       	</td>
                       	<c:if test="${data.iWeek == 7 && data.iDay!=calendarVO.iMonthLastDay}">
                          	</tr>
                          	<tr>
						</c:if>
                       	<c:set var="lastWeek" value="${data.iWeek}"/>
					</c:forEach>
					<c:forEach var="i" begin="${lastWeek+1}" end="7">
						<td>&nbsp;</td>
					</c:forEach>
				</tr>
			</table>
		</dd>
	</dl><!-- //0119 datepicker 수정-->
</form>
      

