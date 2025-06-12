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

	<div class="option-change option-change3">
		<p class="btn-close"><a href="#"><img src="<c:url value='/images/mw/sub_common/close2.png'/>" width="23" alt="닫기"></a></p>
		<p class="goods-info">
			<c:if test="${fn:length(imgList) == 0}">
				<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="상품이미지"  width="95">
			</c:if>
			<c:if test="${fn:length(imgList) != 0}">
           		<img src="${imgList[0].savePath}${imgList[0].saveFileNm}" alt="상품이미지"  width="95">
           	</c:if>
			
			<strong>골프장명 골프장명</strong>
			서브설명 문구들어감
		</p>
		<div id="glDtlCanendar">
			<!-- 달력 -->
		</div>
		
		<form name="glDtlInput" id="glDtlInput" method="get" onSubmit="return false;">
       		<input type="hidden" id="EndVal" name="EndVal" value='' />
       		
       		<c:forEach var="cnt" begin="6" end="15">
           		<input type="hidden" id="cntDay${cnt}" name="cntDay${cnt}" value='' />
           	</c:forEach>
		 
			<div class="option3-result">
				<!--<div class="form1 form1-5">
					<input type="text" value="날짜 선택" readonly="readonly">
					<select>
						<option value="오전">오전</option>
					</select>
					<select>
						<option value="시간">시간</option>
					</select>
					<select>
						<option value="시간">인원</option>
					</select>
				</div>-->
				<div class="area">
					<label>ㆍ날짜</label>
					<input class="date" type="text" id='glCalDate' name='glCalDate' readonly="readonly" value="${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}">
					<label>ㆍ인원</label>
					<select class="person" id="personnel" onchange="updateGLCalendar_end()">
	                    <c:forEach var="cnt" begin="${prdtVO.miniMem}" end="${prdtVO.maxiMem }">
                           	<option value="${cnt}">성인${cnt}인</option>
                           </c:forEach>
	                </select>
				</div>
				<div class="area">
					<label>ㆍ시간</label>
					<select id="half" onchange="changeGLCalendarTmHalfSel(this)">
	                    <option value="am">오전</option>
	                    <option value="pm">오후</option>
	                </select>
					<select id="hour" onchange="updateGLCalendar_end()">
	                    <option value="">08:00</option>
	                </select>
				</div>
			</div>
			<p class="price">합계 : <strong id="glNowPrice">920,000원</strong></p>
			<p class="btn-right">
				<span id="glPrdtBtn1"><a class="btn btn1" onclick="changeOptionCartGL(${cart.cartSn})">변경완료</a></span>
				<span id="glPrdtBtn2" style="display: none;"></span>
			</p>
			
			<p class="warning" id="glBtnErrInfo">대여일의 범위가 올바르지 않습니다.</p>
		</form>

	</div>

                        
