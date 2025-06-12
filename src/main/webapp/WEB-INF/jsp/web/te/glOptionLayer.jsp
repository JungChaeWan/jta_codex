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

	<script type="text/javascript">
	g_GL_getContextPath = "${pageContext.request.contextPath}";
	InitGLCalendar(  "${searchVO.sPrdtNum}"
					,"${searchVO.sFromDt}");
	</script>

	<!-- 골프 옵션변경 -->
    <div class="golf-option option-box">
        <div class="info-head">
            <h4 class="title">
                <c:out value="${prdtVO.prdtNm }"/>
                <a class="option-close" onclick="close_popup('.option-wrap');"><img src="<c:url value='/images/web/cart/close.gif'/>" alt="닫기"></a>
            </h4>
            <h5 class="sub-title"><img src="<c:out value='/images/web/travel/sb.gif'/>" alt="말풍선"> 사용일 선택</h5>
            <!--달력-->
            <div class="lodgeCalendar" id="glDtlCanendar">

            </div> <!--//lodgeCalendar-->
            <!--//달력-->
        </div> <!--//info-head-->
        
        <form name="glDtlInput" id="glDtlInput" method="get" onSubmit="return false;">
       		<input type="hidden" name="EndVal" value='' />
       		<input type="hidden" name="prdtNm" value="<c:out value='${prdtVO.prdtNm }'/>" />
       		<input type="hidden" name="areaNm" value="<c:out value='${areaNm }'/>" />
       		<input type="hidden" name="corpId" value="<c:out value='${corpVO.corpId }'/>" />
       		<input type="hidden" name="corpNm" value="<c:out value='${corpVO.corpNm }'/>" />
       		
       		
       		<c:forEach var="cnt" begin="6" end="15">
           		<input type="hidden" id="cntDay${cnt}" name="cntDay${cnt}" value='' />
           	</c:forEach>
        
	        <div class="info-text">                                
	            <div class="list-cell">
	                <ul class="gf_option">
	                    <li class="dateWrap">
	                        <div class="area1">사용일</div>
	                        <div class="area2">
	                        	<input class="cal datepicker" type="text" id='glCalDate' name='glCalDate' readonly="readonly" value="${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}">
	                        </div>
	                    </li>
	                    <li class="dateWrap">
	                        <div class="area1">시간선택</div>
	                        <div class="area2">
	                            <select id="half" onchange="changeGLCalendarTmHalfSel(this)">
				                    <option value="am">오전</option>
				                    <option value="pm">오후</option>
				                </select>
				                <select id="hour" onchange="updateGLCalendar_end()">
				                    <option value="">08:00</option>
				                </select>
	                        </div>
	                    </li>
	                    <li class="persWrap">
	                        <div class="area1">인원</div>
	                        <div class="area2">
	                            <select id="personnel" onchange="updateGLCalendar_end()">
				                    <c:forEach var="cnt" begin="${prdtVO.miniMem}" end="${prdtVO.maxiMem }">
		                            	<option value="${cnt}">성인${cnt}인</option>
		                            </c:forEach>
				                </select>
	                        </div>
	                    </li>
	                </ul>
	            </div>
	            <!-- 선택추가 -->
	            <!-- 
	            <div class="select-add">
	                <table>
	                    <tr>
	                        <td class="info">15/10/20|2박|성인9/소아9/유아9</td>
	                        <td class="price"><strong>99,156,000</strong>원</td>
	                    </tr>
	                    <tr>
	                        <td class="text">선택불가 시 출력 텍스트 출력</td>
	                        <td class="button">
	                            <a href="" class="add-content2"><img src="../images/web/travel/plus.png" alt=""> 날짜추가</a>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            -->
	            <!-- 추가 -->
	            <div class="gfPrice-wrap">
	                <ul class="price-list">
	                    <li>
	                        <!-- <p class="date">2015-10-20 / 오전 10대 / 4인 1조</p> -->
	                        <p class="price"><strong id="glNowPrice">99,999,000</strong>원 </p>
	                    </li>
	                    <!-- <li>
	                        <p class="date">2015-10-20 / 오전 10대 / 4인 1조</p>
	                        <p class="price"><strong>99,999,000원</strong> <a class="del"><img src="../images/web/icon/close5.gif" alt="삭제"></a></p>
	                    </li> -->
	                </ul>
	            </div>
	            <p class="comm-button2">
	                <a id="glBtnPrdt1" class="color0" href="javascript:fn_addGl();">선택완료</a>
					<span id="glBtnPrdt2" style="display: none;"></span>
	            </p>
	            <p class="warning" id="glBtnErrInfo" style="display: none;">대여일의 범위가 올바르지 않습니다.</p>
	        </div>
		</form>
		
    </div> <!--//option-box(골프)-->
	

	
                                 