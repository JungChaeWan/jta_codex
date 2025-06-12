
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

})

</script>

	<div class="option-change option-change1 daterangepicker show-calendar opensright">
		<p class="btn-close"><a href="#"><img src="../../images/mw/icon/close/dark-gray.png" alt="닫기"></a></p>
<%--		<p class="goods-info">--%>
<%--			<!-- <img src="../../images/mw/sub_common/img_thum.jpg" width="95" alt="상품이미지"> -->--%>
<%--			<c:if test="${fn:length(imgList) == 0}">--%>
<%--            	<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="" width="95">--%>
<%--            </c:if>--%>
<%--            <c:if test="${fn:length(imgList) != 0}">--%>
<%--            	<img src="${imgList[0].savePath}${imgList[0].saveFileNm}" alt="1" width="95">--%>
<%--            </c:if>--%>

<%--			<strong><c:out value="${webdtl.adNm }"/></strong>--%>
<%--			<c:out value="${prdtVO.prdtNm }"/>--%>
<%--		</p>--%>
		<div id="adDtlCanendar">
			<!-- 달력 -->
		</div>
		
		<form name="adDtlInput" id="adDtlInput" method="get" onSubmit="return false;">
			<input type="hidden" id="EndVal" name="EndVal" value='' />

			<!-- 0126 날짜별 객실요금 상세 -->
			<div class="select-info">
				<div class="area1">투숙일자</div>
				<div class="form1 form1-2">
					<input id="adCalDate" class="cal" type="text" readonly value="${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}">
					<span class="icoArrow">
                         <img src="../../images/mw/icon/basic/night.png" alt="박수">
					</span>
					<select id="adCalNight" onchange="selectADCalendarNight(this);">
                         <option value="1" <c:if test="${searchVO.sNights=='1' }">selected="selected"</c:if> >1박2일</option>
                         <option value="2" <c:if test="${searchVO.sNights=='2' }">selected="selected"</c:if> >2박3일</option>
                         <option value="3" <c:if test="${searchVO.sNights=='3' }">selected="selected"</c:if> >3박4일</option>
                         <option value="4" <c:if test="${searchVO.sNights=='4' }">selected="selected"</c:if> >4박5일</option>
                         <option value="5" <c:if test="${searchVO.sNights=='5' }">selected="selected"</c:if> >5박6일</option>
                     </select>
				</div>
				<div class="form1">

					<!-- title(인원) 추가 -->
					<div class="area1">인원<span class="number-people"> (기준 ${prdtVO.stdMem}인/최대 ${prdtVO.maxiMem}인)</span></div>
					<select id="adCalMen1" onchange="updateADCalendar_end();">
                    	<c:forEach var="i" begin="0" end="${prdtVO.maxiMem}">
                        	<option value="${i}">성인${i}인</option>
                    	</c:forEach>
               		</select>
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
				</div>
				<div>
					<ul class="limit-info">
						<li>${webdtl.adultAgeStd}</li>
						<li>${webdtl.juniorAgeStd}</li>
						<li>${webdtl.childAgeStd}</li>
					</ul>
				</div>
				<div class="detail-price receipt">
					<dl class="base-price">
						<dt>최초요금
							<span class="room-number" id="jBaseDay"></span>
						</dt>
						<dd>
							<del class="crossed-out-rate" id="jBasePrice">
								0원
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
				</div><!-- //detail-price -->
			</div><!-- //0126 날짜별 객실요금 상세 -->

			<!-- 0126 옵션변경 / 변경완료 btn 추가 -->
			<div class="unfix-cta">
				<p class="btn-right">
						<span id="adBtnPrdt1">
							<a class="btn btn1" onclick="changeOptionCartAD(${cart.cartSn})">
								<span id="adNowPrice">총 0원</span>원
								변경하기
							</a>
						</span>
					<span id="adBtnPrdt2" style="display: none;"></span>
				</p>
				<p class="warning" id="adBtnErrInfo">대여일의 범위가 올바르지 않습니다.</p>
			</div><!-- //0126 옵션변경 / 변경완료 btn 추가 -->
		</form>
	</div>