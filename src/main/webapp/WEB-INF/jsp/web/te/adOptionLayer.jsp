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
		g_AD_getContextPath = "${pageContext.request.contextPath}";
		InitADCalendar(  "${webdtl.corpId}"
						,"${searchVO.sPrdtNum}"
						,"${searchVO.sFromDt}"
						,"${searchVO.sNights}");
	</script>
								
	<!-- 숙박 옵션변경 -->
     <div class="room-option option-box">
         <div class="info-head">
             <h4 class="title">
                 <c:out value="${webdtl.adNm }"/>
                 <a class="option-close" onclick="close_popup('.option-wrap');"><img src="<c:url value='/images/web/cart/close.gif'/>" alt="닫기"></a>
             </h4>
             <h5 class="sub-title"><img src="<c:url value='/images/web/travel/sb.gif'/>" alt="말풍선"> 아래에서 원하시는 객실을 선택해 주세요.</h5>
             <!-- 객실선택 -->
             <table class="commCol">
                 <thead>
                     <tr>
                         <th class="title1">선택</th>
                         <th class="title2">객실정보</th>
                         <th class="title3">기준/최대 인원</th>
                         <th class="title4">조식여부</th>
                         <th class="title5">판매가격</th>
                     </tr>
                 </thead>
                 <tbody>
                 	<c:forEach var="result" items="${prdtList}" varStatus="status">
	                   	<tr>
	                         <td><input type="radio" name="room" value="" onchange="changePrdtADCalendar('${result.prdtNum }')"  <c:if test='${result.prdtNum == searchVO.sPrdtNum}'>checked="checked"</c:if> ></td>
	                         <td class="left">
	                         	<c:out value="${result.prdtNm}"/>
	                           	<c:if test="${result.eventCnt>0}">
	                           		<img src="<c:url value='/images/web/icon/tb_event.gif'/>" alt="이벤트">
	                           	</c:if>
	                           	<c:if test="${result.daypriceYn == 'Y'}">
	                           		<img src="<c:url value='/images/web/icon/tb_dday.gif'/>" alt="당일특가">
	                           	</c:if>
	                           	<%-- <c:if test="${result.daypriceYn != 'Y'}">
	                           		<c:if test="${result.hotdallYn == 'Y'}">
	                           			<img src="<c:url value='/images/web/icon/tb_hot.gif'/>" alt="핫딜">
	                           		</c:if>
	                           	</c:if> --%>
	                         </td>
	                         <td>
	                         	<c:if test="${result.memExcdAbleYn=='Y'}">
                             		${result.stdMem }인 / ${result.maxiMem }인
                             	</c:if>
                             	<c:if test="${result.memExcdAbleYn!='Y'}">
                             		${result.stdMem }인 / ${result.stdMem }인
                             	</c:if>
	                         </td>
	                         <td>
	                         	<c:if test="${result.breakfastYn =='Y' }">
                              		<img src="<c:url value='/images/web/icon/tb_breakfast.gif'/>" alt="조식"> 포함
                              	</c:if>
                              	<c:if test="${result.breakfastYn =='N' }">
                              		-
                              	</c:if>
	                         </td>
	                         <td class="price">
	                         	<c:if test="${empty result.saleAmt }">미정</c:if>
								<c:if test="${!(empty result.saleAmt) }"> <fmt:formatNumber value='${result.saleAmt }'/> 원</c:if>
	                         </td>
	                     </tr>
	                 </c:forEach>
                 </tbody>
             </table>
             <!--달력-->
             <div class="lodgeCalendar" id="adDtlCanendar">
                 
             </div> <!--//lodgeCalendar-->
             <!--//달력-->
         </div> <!--//info-head-->
         
         <form name="adDtlInput" id="adDtlInput" method="get" onSubmit="return false;">
			<input type="hidden" name="EndVal" value='' />
			<input type="hidden" name="adNm" value="<c:out value='${webdtl.adNm }'/>" />
			<input type="hidden" name="adAreaNm" value="<c:out value='${webdtl.adAreaNm }'/>" />
			<input type="hidden" name="corpId" value="<c:out value='${webdtl.corpId }'/>" />
			
         
	         <div class="info-text">
	             <div class="list-cell list-cell2">
	                 <ul class="bt_option">
	                     <li class="dateWrap">
	                         <div class="area1">투숙일자</div>
	                         <div class="area2">
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
	                         <div class="area2">
	                             <table>
	                                 <tr>
	                                     <td>
	                                          <select id="adCalMen1" onchange="updateADCalendar_end();">
	                                          	<c:forEach var="i" begin="0" end="${adPtdt.maxiMem}">
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
	                                          		<c:forEach var="i" begin="0" end="${adPtdt.maxiMem}">
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
		                                          	<c:forEach var="i" begin="0" end="${adPtdt.maxiMem}">
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
	                 <p class="title">＊ 추가요금(1일 1인 추가요금)</p>
	                 <p class="text" id="adCalPriceInfo">
	                     - 성인 : ${adAddAmt.adultAddAmt}원<br>
	                     - 소아 : ${adAddAmt.juniorAddAmt}원<br>
	                     - 유아 : ${adAddAmt.childAddAmt}원
	                 </p>
	             </div>
	             <div class="price-wrap">
	             	<p class="info4"><span class="plus">총합계</span> <strong id="adNowPrice">0</strong><span>원</span></p>
	             </div>
	             <p class="comm-button2">
	                <a id="adBtnPrdt1" class="color0" href="javascript:fn_addAd();">선택완료</a>
					<span id="adBtnPrdt2" style="display: none;"></span>
	             </p>
	             <p class="warning" id="adBtnErrInfo" style="display: none;">대여일의 범위가 올바르지 않습니다.</p>
	         </div>
	 	</form>
     </div> <!--//option-box(숙박)-->
                                 