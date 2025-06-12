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
	
	$("#glDtlInput").find('#EndVal').val('cart');
		
	$("#glDtlInput").find('#personnel').val('${cart.memCnt}');
	changeGLCalendarTmHalf_tm('${cart.tm}');
	
	g_GL_getContextPath = "${pageContext.request.contextPath}";
	InitGLCalendar(  "${searchVO.sPrdtNum}"
					,"${searchVO.sFromDt}");
});
</script>

<!-- 상품 리스트 -->
    <div class="golf-option option-box">
       <h4 class="title">옵션변경하기 <a class="option-close"><img src="<c:url value='/images/web/cart/close.gif'/>" alt="닫기"></a></h4>
       <div class="info-head">
           <div class="info-title">
               <p class="photoBox">
               		<!-- <img src="../images/web/cart/main.jpg" alt=""> -->
               		
               		<c:if test="${fn:length(imgList) == 0}">
                    	<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="">
                    </c:if>
                    <c:if test="${fn:length(imgList) != 0}">
                 		<img src="${imgList[0].savePath}${imgList[0].saveFileNm}" alt="1">
                 	</c:if>
               </p>
               <p class="text">
                   <span>[실시간 예약]</span>
                   <span>${prdtVO.prdtNm }</span>
                   <span>${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)} ${cart.tm}:00 ${cart.memCnt}명 1조</span>
               </p>
           </div>
           <!--달력-->
           <div class="lodgeCalendar">
               <div class="calendar" id="glDtlCanendar">
               
               </div> <!--//calendar-->
           </div> <!--//lodgeCalendar-->
       </div> <!--//info-head-->
       <div class="info-text">
       	<form name="glDtlInput" id="glDtlInput" method="get" onSubmit="return false;">
       		<input type="hidden" id="EndVal" name="EndVal" value='' />
       		
       		<c:forEach var="cnt" begin="6" end="15">
           		<input type="hidden" id="cntDay${cnt}" name="cntDay${cnt}" value='' />
           	</c:forEach>
       
			<div class="list-cell">
			    <ul class="gf_option">
			        <li class="dateWrap">
			            <div class="area1">사용일</div>
			            <div class="area2">
			                <input class="cal" type="text" id='glCalDate' name='glCalDate' readonly="readonly" value="${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}">
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
        
           	<div class="price-wrap">
               <p class="text" id="glPrdtText">2015/10/20 / 오전 10대 /  4인  1조</p>
               <p class="info4"><span class="plus">총합계</span> <strong id="glNowPrice">99,999,000</strong><span>원</span></p>
           	</div>
           	<%-- <p class="bt">
           		<span id="glPrdtBtn1"><input type="image" src="<c:url value='/images/web/cart/change.gif'/>" alt="변경완료" onclick="changeOptionCartGL(${cart.cartSn})"></span>
           		<span id="glPrdtBtn2" style="display: none;">[변경 불가]</span>
           		<br/><span id="glBtnErrInfo" ></span>
           	</p> --%>
           	
           	<div class="comm-offMs">
	           	<p class="bt" id="glPrdtBtn1">
	           		<span>
	           			<input type="image" src="<c:url value='/images/web/cart/change.gif'/>" alt="변경완료" onclick="changeOptionCartGL(${cart.cartSn})">
           			</span>
	           	</p>
	           	
	           	<p class="not-ms" id="glPrdtBtn2" style="display: none;">
	           		<img src="<c:url value='/images/web/icon/warning.png'/>" alt="경고">  <span id="glBtnErrInfo" ></span>
	           	</p>
           	</div>
           
         </form>
       </div>
   </div>                             
