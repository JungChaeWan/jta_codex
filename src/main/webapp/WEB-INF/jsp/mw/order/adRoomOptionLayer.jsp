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
})

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
	AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
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
	AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
}
</script>
	<div class="option-change option-change1">
		<p class="btn-close"><a href="#"><img src="../../images/mw/sub_common/ad_close.png" width="23" alt="닫기"></a></p>
		<p class="goods-info">
			<strong><c:out value="${webdtl.adNm }"/> <c:out value="${prdtVO.prdtNm }"/></strong>
		</p>
		<div id="adDtlCanendar">
		<!-- 달력 -->
		</div>
		<form name="adDtlInput" id="adDtlInput" method="get" onSubmit="return false;">
			<input type="hidden" id="EndVal" name="EndVal" value='' />

			<!-- 날짜별 객실요금 상세 -->
			<div class="select-info">
				<div class="area1">투숙일자</div>
				<div class="form1 form1-2">
					<input id="adCalDate" class="cal" type="text" readonly value="${fn:substring(searchVO.sFromDt,0,4)}-${fn:substring(searchVO.sFromDt,4,6)}-${fn:substring(searchVO.sFromDt,6,8)}">
					<span class="icoArrow">
                         <img class="img_width13" src="../../images/mw/icon/basic/night.png" alt="박수">
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
	                	<span class="not child">유아접수불가</span>
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
				<div class="detail-price">
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
			</div><!-- //날짜별 객실요금 상세 -->
			<!-- 장바구니 btn 추가 -->
			<div class="fix-cta">
				<button class="btn-left" onclick="fn_adCalendarCart()">
						<span id="adBtnPrdt3">
						</span>
				</button>
				<!-- 예약하기 btn 코드 -->
				<p class="btn-right">
					<span id="adBtnPrdt1">
						<a class="btn btn1" onclick="fn_adCalendarAddSale()">
							<span class="booking-price">
								<span id="adNowPrice">총 0원</span>
								<span class="btn-text"> 예약하기</span>
							</span>

							<!-- 0829 프로모션 CTA 삽입 -->
							<%--<span class="promotion-coupon">* 예약단계에서 쿠폰 적용시 <em>~20% 추가할인</em> 가능</span>--%>
						</a>
					</span>
					<span id="adBtnPrdt2" style="display: none;"></span>
				</p>
				<p class="warning" id="adBtnErrInfo">대여일의 범위가 올바르지 않습니다.</p>
			</div><!-- //장바구니 btn 추가 -->
		</form>
	</div>