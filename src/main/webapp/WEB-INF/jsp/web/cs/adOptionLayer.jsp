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
	
	$("#adDtlInput").find('#adCalMen1').val('${cart.adultCnt}');
	$("#adDtlInput").find('#adCalMen2').val('${cart.juniorCnt}');
	$("#adDtlInput").find('#adCalMen3').val('${cart.childCnt}');
	
	g_AD_getContextPath = "${pageContext.request.contextPath}";
	InitADCalendar(  "${prdtVO.corpId}"
					,"${cart.prdtNum}"
					,"${searchVO.sFromDt}"
					,"${searchVO.sNights}");
	
	
});
</script>

<!-- 0208 옵션변경 - 예약일 확인(datepicker) content 수정-->
<!-- 상품 리스트 -->
    <div class="room-option option-box">
        <h4 class="title"><c:out value="${webdtl.adNm }"/> - ${prdtVO.prdtNm } <a class="option-close"><img src="/images/web/cart/close.png" alt="닫기"></a></h4>
       <div class="info-head">

           <!-- room-img view(숨김) -->

<%--           <div class="info-title">--%>
<%--               <p class="photoBox">--%>
<%--               		<!-- <img src="../images/web/cart/main.jpg" alt=""> -->--%>
<%--               		<c:if test="${fn:length(imgList) == 0}">--%>
<%--                    	<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="">--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${fn:length(imgList) != 0}">--%>
<%--                 		<img src="${imgList[0].savePath}${imgList[0].saveFileNm}" alt="1">--%>
<%--                 	</c:if>--%>
<%--               </p>--%>
<%--               <p class="text">--%>
<%--                   <span class="real_time">[실시간 예약]</span>--%>
<%--                   <span class="prd_name"><c:out value="${webdtl.adNm }"/> - ${prdtVO.prdtNm }</span>--%>
<%--                   <span>${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}일부터 ${searchVO.sNights}박 | 성인 ${cart.adultCnt}명, 소아 ${cart.juniorCnt}명, 유아 ${cart.childCnt}명 | </span>--%>
<%--               </p>--%>
<%--           </div>--%>
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
                       <div class="area1">인원</div>
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

            <!-- 추가요금(1일 1인 추가요금) - 기존 -->
<%--            <div class="priceInfo">--%>
<%--                <p class="title">＊ 추가요금(1일 1인 추가요금)</p>--%>
<%--                <p class="text">--%>
<%--                <ul>--%>
<%--                    <li>- 성인 : ${adAddAmt.adultAddAmt}원</li>--%>
<%--                    <li>- 소아 : ${adAddAmt.juniorAddAmt}원</li>--%>
<%--                    <li>- 유아 : ${adAddAmt.childAddAmt}원</li>--%>
<%--                </ul>--%>
<%--                </p>--%>
<%--            </div>--%>
            <div class="priceInfo">
                <p class="text">

                <!-- 추가요금(1일 1인 추가요금) - 변경 -->
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
           		<p class="info4"><span class="plus">총합계</span> <strong id="adNowPrice">0 </strong><span> 원</span></p>
           </div>
           <%-- <p class="bt">
           		<!-- <input type="image" src="../images/web/cart/change.gif" alt="변경완료"> -->
           		<span id="adBtnPrdt1"><input type="image" src="<c:url value='/images/web/cart/change.gif'/>" alt="변경완료" onclick="changeOptionCartAD(${cart.cartSn})"></span>
           		<span id="adBtnPrdt2" style="display: none;">[변경 불가]</span>
           		<br/><span id="adBtnErrInfo" ></span>
           </p> --%>
           <div class="comm-offMs">
				<p class="bt" id="adBtnPrdt1"  onclick="changeOptionCartAD(${cart.cartSn})">
                    <button>
                        <span>
                            변경완료
                        </span>
                    </button>
				</p>
				<p class="not-ms" id="adBtnPrdt2" style="display: none;">
                    <img src="<c:url value='/images/web/cart/exclamation.png'/>" alt="경고">
                    <span id="adBtnErrInfo" >투숙 날짜중에 마감/미정이 있습니다</span>
				</p>
           </div>
          </form>
       </div>
   </div> <!--//option-box(숙박)-->
<!-- //0208 옵션변경 - 예약일 확인(datepicker) content 수정-->