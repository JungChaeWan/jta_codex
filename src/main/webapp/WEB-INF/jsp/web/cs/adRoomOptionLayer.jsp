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
	$("#adDtlInput").find('#EndVal').val('cart');
	$("#adDtlInput").find('#adCalMen1').val('${searchVO.sAdultCnt}');
	$("#adDtlInput").find('#adCalMen2').val('${searchVO.sChildCnt}');
	$("#adDtlInput").find('#adCalMen3').val('${searchVO.sBabyCnt}');
	
	g_AD_getContextPath = "${pageContext.request.contextPath}";
	InitADCalendar(  "${prdtVO.corpId}"
					,"${prdtVO.prdtNum}"
					,"${searchVO.sFromDt}"
					,"${searchVO.sNights}");
	
});

function fn_adCalendarCart(){
    var cart = [];
    cart.push({
        prdtNum 	: "${prdtVO.prdtNum}",
        prdtNm 		: "${prdtVO.prdtNm}",
        corpId 		: "<c:out value='${webdtl.corpId}'/>",
        corpNm 		: "<c:out value='${webdtl.adNm }'/>",
        prdtDivNm 	: "숙박",
        startDt		: $("#adCalDate").val().replace(/-/gi,""),
        night 		: $("#adDtlCalendar").children('#iNight').val(),
        adultCnt 	: $("#adCalMen1").val(),
        juniorCnt 	: $("#adCalMen2").val(),
        childCnt 	: $("#adCalMen3").val(),
        imgPath     : "${imgList[0].savePath}${imgList[0].saveFileNm}"
    });
    fn_AddCart(cart);
}

function fn_adCalendarAddSale(){
    var cart = [];
    cart.push({
        prdtNum 	: "${prdtVO.prdtNum}",
        prdtNm 		: "${prdtVO.prdtNm}",
        corpId 		: "<c:out value='${webdtl.corpId}'/>",
        corpNm 		: "<c:out value='${webdtl.adNm }'/>",
        prdtDivNm 	: "숙박",
        startDt		: $("#adCalDate").val().replace(/-/gi,""),
        night 		: $("#adDtlCalendar").children('#iNight').val(),
        adultCnt 	: $("#adCalMen1").val(),
        juniorCnt 	: $("#adCalMen2").val(),
        childCnt 	: $("#adCalMen3").val()
    });
    fn_InstantBuy(cart);
}

</script>

<!--1230 예약일 확인(datepicker) content 수정-->
<!-- 상품 리스트 -->
<div class="room-option option-box">
   <h4 class="title"><c:out value="${webdtl.adNm }"/> - ${prdtVO.prdtNm } <a class="option-close"><img src="/images/web/cart/close.png" alt="닫기"></a></h4>
   <div class="info-head">
       <!--달력-->
       <div class="lodgeCalendar">
           <div class="calendar"  id="adDtlCanendar">
           </div> <!--//calendar-->
       </div> <!--//lodgeCalendar-->
       <!--//달력-->
   </div> <!--//info-head-->
   <div class="info-text">
   <form name="glDtlInput" id="adDtlInput" method="get" onSubmit="return false;">
       <input type="hidden" id="EndVal" name="EndVal" value='' />

       <div class="list-cell list-cell2">
           <ul class="bt_option">
               <li class="dateWrap">
                   <div class="area1">투숙일자</div>
                   <div class="area2 line-break1">
                       <input id="adCalDate" class="cal" type="text" readonly value="${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}">
                       <select id="adCalNight" onchange="selectADCalendarNight(this);">
                            <option value="1" <c:if test="${searchVO.sNights=='1' }">selected="selected"</c:if> >1박2일</option>
                            <option value="2" <c:if test="${searchVO.sNights=='2' }">selected="selected"</c:if> >2박3일</option>
                            <option value="3" <c:if test="${searchVO.sNights=='3' }">selected="selected"</c:if> >3박4일</option>
                            <option value="4" <c:if test="${searchVO.sNights=='4' }">selected="selected"</c:if> >4박5일</option>
                            <option value="5" <c:if test="${searchVO.sNights=='5' }">selected="selected"</c:if> >5박6일</option>
                        </select>
                   </div>
               </li>
               <li class="persWrap">
                   <div class="area1">
                       <span class="number-people">인원(기준 ${prdtVO.stdMem}인/최대 ${prdtVO.maxiMem}인)</span>
                   </div>
                   <div class="area2 line-break2">
                       <table>
                           <tr>
                               <td>
                                   <select id="adCalMen1" onchange="updateADCalendar_end();">
                                    <c:forEach var="i" begin="0" end="${prdtVO.maxiMem}">
                                        <option value="${i}">성인${i}인</option>
                                       </c:forEach>
                                   </select>
                               </td>
                               <td>
                                    <c:if test="${webdtl.juniorAbleYn != 'Y'}">
                                        <span class="not">소아접수불가</span>
                                        <select id="adCalMen2" onchange="updateADCalendar_end();" style="display: none;">
                                            <option value="0">소아0인</option>
                                       </select>
                                    </c:if>
                                    <c:if test="${webdtl.juniorAbleYn == 'Y'}">
                                       <select id="adCalMen2" onchange="updateADCalendar_end();">
                                        <c:forEach var="i" begin="0" end="${prdtVO.maxiMem}">
                                            <option value="${i}">소아${i}인</option>
                                           </c:forEach>
                                       </select>
                                    </c:if>
                               </td>
                               <td>
                                    <c:if test="${webdtl.childAbleYn != 'Y'}">
                                        <span class="not">유아접수불가</span>
                                        <select id="adCalMen3" onchange="updateADCalendar_end();" style="display: none;">
                                            <option value="0">유아0인</option>
                                        </select>
                                    </c:if>
                                    <c:if test="${webdtl.childAbleYn == 'Y'}">
                                        <select id="adCalMen3" onchange="updateADCalendar_end();">
                                        <c:forEach var="i" begin="0" end="${prdtVO.maxiMem}">
                                            <option value="${i}">유아${i}인</option>
                                           </c:forEach>
                                       </select>
                                    </c:if>
                               </td>
                           </tr>
                           <tr>
                               <td>${webdtl.adultAgeStd}</td>
                               <td>${webdtl.juniorAgeStd}</td>
                               <td>${webdtl.childAgeStd}</td>
                           </tr>
                       </table>
                   </div>
               </li>
           </ul>
       </div>
       <div class="priceInfo">
           <p class="text">
           <!-- 0106 추가요금(1일 1인 추가요금) -->
           <div class="detail-price">
               <dl class="base-price">
                   <dt>최초요금 <span class="room-number" id="jBaseDay"></span></dt>
                   <dd>
                       <del class="crossed-out-rate">
                           <strong class="amount" id="jBasePrice">0원</strong>
                       </del>
                   </dd>
               </dl>
               <dl class="description">
                   <dt class="adult">성인추가요금</dt>
                   <dd>
                       <del class="crossed-out-rate">
                           <span class="amount" id="jAdultAddAmt">＋0원</span>
                       </del>
                   </dd>
                   <dt>소아추가요금</dt>
                   <dd>
                       <del class="crossed-out-rate">
                           <span class="amount" id="jChildAddAmt">＋0원</span>
                       </del>
                   </dd>
                   <dt>유아추가요금</dt>
                   <dd>
                       <del class="crossed-out-rate">
                           <span class="amount" id="jJuniorAddAmt">＋0원</span>
                       </del>
                   </dd>
                   <dl class="consecutive-night">
                       <dt>연박할인</dt>
                       <dd>
                           <del class="crossed-out-rate">
                               <span class="amount" id="jCtnAmt">-0원</span>
                           </del>
                       </dd>
                   </dl>
               </dl>
           </div>
           </p>
       </div>
       <div class="price-wrap control">
            <p class="info4"><span class="plus">총합계</span> <strong id="adNowPrice">1,000 </strong><span> 원</span></p>
       </div>
       <div class="comm-offMs">
           <div  id="adBtnPrdt1">
               <p class="bt cart-cta"  onclick="fn_adCalendarCart();">
                   <button type="button">
                       <span>장바구니</span>
                   </button>
               </p>
                <p class="bt" onclick="fn_adCalendarAddSale()">
                    <button>
                        <span>
                            바로예약
                        </span>
                    </button>
                </p>
           </div>
            <p class="not-ms" id="adBtnPrdt2" style="display: none;">
                    <img src="<c:url value='/images/web/cart/exclamation.png'/>" alt="경고">  <span id="adBtnErrInfo">투숙 날짜중에 마감/미정이 있습니다</span>
            </p>
       </div>
   </form>
   </div>
</div>
<!--//option-box(숙박)-->
<!--//1230 예약일 확인(datepicker) content 수정-->
