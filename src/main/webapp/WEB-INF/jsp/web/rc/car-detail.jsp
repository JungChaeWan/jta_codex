<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex">
<c:if test="${fn:length(imgList) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>

<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtVO.prdtNum}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${prdtVO.carImg}"/>

<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="${prdtVO.prdtNm} - ${prdtVO.corpNm}"/>
	<jsp:param name="keywordsLinkNum" value="${prdtVO.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtVO.prdtNm}"/>
	<jsp:param name="keywordAdd2" value="${prdtVO.corpNm}"/>
	<jsp:param name="description" value="[${prdtVO.corpNm}] ${prdtVO.prdtNm} : ${prdtVO.carDivNm}, ${prdtVO.modelYear}년식, ${prdtVO.transDivNm}, ${prdtVO.useFuelDivNm}, 승차인원 ${prdtVO.maxiNum}명 "/>
	<jsp:param name="imagePath" value="${seoImage}"/>
	<jsp:param name="headTitle" value="${prdtVO.prdtNm}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtVO.prdtNm}'/>" />
<meta property="og:url" content="${strUrl}" />
<meta id="metaDesc" name="metaDesc" property="og:description" content="<c:out value='${prdtVO.prdtNm} ${prdtVO.prdtExp}(${prdtVO.corpNm})'/>" />
<c:if test="${fn:length(imgList) != 0}">
<meta property="og:image" content="${imgUrl}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/rc.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/lite-yt-embed.css?version=${nowDate}'/>" />

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>렌터카 가격비교</span>
	    </div>
	</div>

	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	        <div class="rent2 new-detail"> <!-- add Class (new-detail) -->
			    <div class="bgWrap2">
			        <div class="Fasten">
			            <!-- 차량정보 -->
			            <div class="detail">
			                <div class="detailL">
			                    <div class="detail-slider rent">
								    <div class="title-box">
								        <h2 class="title"><c:out value="${prdtVO.prdtNm}"/></h2>
								    </div>
								    <div id="detail_slider" class="swiper-container">
								        <div class="swiper-wrapper">
								            <div class="swiper-slide">
								                <img id="imgPath" src="${prdtVO.carImg}" alt="차종">
								            </div>
								        </div>
								    </div>
								    <div class="bottom-info">
										<p>해당 이미지는 이해를 돕기 위한 예시로, 실제 배차되는 차량의 색상이나 버전이 다를 수 있습니다.</p>
								        <ul>
								            <li>
								                <img src="/images/web/rent/kind.png" width="43" height="25" alt="차종">
								                <span><c:out value="${prdtVO.carDivNm}"/></span>
								            </li>
								            <li>
								                <img src="/images/web/rent/people.png" width="24" height="25" alt="인원정원">
								                <span><c:out value="${prdtVO.maxiNum}"/>명</span>
								            </li>
								            <li>
												<img src="/images/web/rent/oil.png" width="25" height="30" alt="인원정원">
								                <span><c:out value="${prdtVO.useFuelDivNm}"/></span>
								            </li>
								        </ul>
								    </div>
								</div> <!-- //detail-slider -->
			                </div>
			                <div class="detailR">
			                    <div class="pdWrap">
			                    	<div class="title-box">
			                    		<div class="title"><c:out value="${prdtVO.corpNm}"/></div>
			                    		<div class="grade-area">
											<div class="score-area">
												<span class="score" id="ind_grade">평점 <strong class="text-red">0</strong>/5</span>
												<span class="icon" id="useepil_uiTopHearts"></span>
											</div>
										    <div class="bxLabel">
												<c:if test="${prdtVO.eventCnt > 0 }">
													<span class="main_label eventblue">이벤트</span>
												</c:if>
												<c:if test="${prdtVO.couponCnt eq '1' }">
													<span class="main_label pink">할인쿠폰</span>
												</c:if>
												<c:if test="${prdtVO.superbCorpYn eq 'Y'}">
													<span class="main_label back-red">우수관광업체</span>
												</c:if>
												<c:if test="${prdtVO.tamnacardYn eq 'Y'}">
													<span class="main_label yellow">탐나는전</span>
												</c:if>
										    </div>
										    <%-- <div class="icon-group">
										    	<button type="button" onclick="itemSingleShow('#sns_popup');">
										    		<img src="/images/web/icon/sns.png" alt="sns">
										    	</button>
										    	<c:if test="${pocketCnt eq 0 }">
										    	<button type="button" onclick="javascript:fn_RcAddPocket();" id="pocketBtnId">
										    		<img src="/images/web/icon/product_like_off2.png" alt="찜하기">
										    	</button>
										    	</c:if>
										    	<c:if test="${pocketCnt ne 0 }">
										    	<button type="button">
										    		<img src="/images/web/icon/product_like_on2.png" alt="찜하기">
										    	</button>
										    	</c:if>
										    </div> --%>
										</div>
										<div id="sns_popup" class="sns-popup">
											<button type="button" class="close" onclick="itemSingleHide('#sns_popup');">
												<img src="/images/web/icon/close/white.png" alt="닫기">
											</button>
											<div class="sns-area">
											    <a href="javascript:shareFacebook('${strURL}'); snsCount('${prdtVO.prdtNum}', 'PC' , 'FACEBOOK');"><img src="/images/web/icon/sns/facebook.png" loading="lazy" alt="페이스북"></a>
											    <a href="javascript:shareStory('${strURL}'); snsCount('${prdtVO.prdtNum}', 'PC' , 'KAKAO');"><img src="/images/web/icon/sns/kakaostory.png" loading="lazy" alt="카카오스토리"></a>
											    <a href="javascript:shareBand('${strURL}'); snsCount('${prdtVO.prdtNum}', 'PC' , 'BAND');"><img src="/images/web/icon/sns/band.png" loading="lazy" alt="밴드"></a>
											</div>
										</div>
			                    	</div> <!-- //title-box -->

			                    	<div class="detail-info">
			                    		<div class="rent-info">
			                    			<div class="title">대여기준</div>
                                            <table class="tableRent">
                                                <thead>
                                                    <tr>
                                                        <th>나이</th>
                                                        <th>운전경력</th>
                                                        <th>면허종류</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
	                                                <tr>
	                                                    <td id="popRentAge">만 ${prdtVO.rntQlfctAge}세 이상</td>
	                                                    <td id="popRentCareer">${prdtVO.rntQlfctCareer}년 이상</td>
	                                                    <td>${prdtVO.rntQlfctLicense}종보통 이상</td>
	                                                </tr>
                                                </tbody>
                                            </table>
										    <div class="table-memo">*대여기준이 모두 일치해야 합니다.</div>
										</div>
										<div class="rent-info">
											<div class="question-area">
											    <div class="title">자차보험 여부
	                                                <div class="btnPack">
	                                                    <div class="insurance_btn">
															<a href="javascript:show_popup('#insurance_info');">자차보험 안내</a>
	                                                    </div>
	                                                </div>
											    </div>
											</div>
											<dl class="block">
											  <c:if test="${prdtVO.isrDiv eq 'ID00'}">
										        <dt>자차자율 상품</dt>
										        <dd>*본 상품은 <strong class="text-red">인수현장에서 자차보험</strong>을
                                                    <strong class="text-red">자율적</strong>으로 <strong class="text-red">선택</strong>하여 이용하는 상품
                                                </dd>
										      </c:if>
											  <c:if test="${prdtVO.isrDiv eq 'ID10'}">
												<dt>자차포함 상품</dt>
												<dd>*본 상품은
													<c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">
														<strong class="text-red">일반자차<div class="checkIsrDivGen"></div> 보험 포함</strong>된 상품
													</c:if>
													<c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">
														<strong class="text-red">고급자차<div class="checkIsrDivLux"></div> 보험 포함</strong>된 상품
													</c:if>
												</dd>
											  </c:if>
                                         	  <c:if test="${prdtVO.isrDiv eq 'ID20'}">
                                         	  <dt>자차필수 상품</dt>
									          <dd>*본 상품은 <strong class="text-red">인수현장에서 자차보험</strong>을 <strong class="text-red">필수</strong>로 <strong class="text-red">결제</strong>해야 하는 상품</dd>
                                         	  </c:if>
										    </dl>
										</div>
									</div><!-- detail-info  -->

				                    <div class="purchasing-info">
				                    	<div class="total-area">
						                   	<%-- <div class="tybe-A">
						                   		<span class="text"><span class="usedHourStr">0시간</span> 대여료<c:if test="${prdtVO.isrDiv eq 'ID10'}">+자차 포함</c:if></span>
						                   		<span class="money"><strong id="vCarSaleAmt">0</strong>원</span>
						                   	</div>
						                   	<c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
										    <div class="caption-typeC">
										    	<strong class="text-red">아직 날짜를 검색하지 않았습니다.</strong>
										    	날짜 검색 시 금액이 달라질 수 있습니다.
										    </div>
										    </c:if> --%>
										</div>
				                    	<div class="point-area">
											<c:if test="${!empty loginVO && fn:length(couponList) > 0}">
											<div class="row" id="useAbleCoupon">
												<span class="col1">
													<c:forEach items="${couponList}" var="coupon" varStatus="status">
														<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>
														<span class="block" id="cpTitle${status.count}" showKey="${status.count}">
															<c:if test="${!empty userCp}">
																<c:if test="${userCp.useYn == 'N'}">
																	할인쿠폰
																</c:if>
																<c:if test="${empty userCp.useYn}">
																	<button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:goCouponCode();">코드등록</button>
																</c:if>
															</c:if>
															<c:if test="${empty userCp}">
																<c:if test="${empty coupon.cpCode}">
																	<button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:fn_couponDownload('${coupon.cpId}', ${status.count});">쿠폰받기</button>
																</c:if>
																<c:if test="${!empty coupon.cpCode}">
																	<button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:goCouponCode();">코드등록</button>
																</c:if>
															</c:if>
														</span>
													</c:forEach>
												</span>
												<span class="col2">
													<c:forEach items="${couponList}" var="coupon" varStatus="status">
														<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>
														<span class="block" id="useCouponAmt_${status.count}">
															<c:if test="${coupon.disDiv eq Constant.CP_DIS_DIV_PRICE}">
																<fmt:formatNumber value="${coupon.disAmt}"/>원
															</c:if>
															<c:if test="${coupon.disDiv eq Constant.CP_DIS_DIV_RATE}">
																${coupon.disPct}%
															</c:if>
															<c:if test="${coupon.disDiv eq Constant.CP_DIS_DIV_FREE}">
																무료
															</c:if>
														</span>
													</c:forEach>
												</span>
												<span class="col3">
													<c:forEach items="${couponList}" var="coupon" varStatus="status">
														<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>
														<span class="block useCouponList" id="useCouponNm_${status.count}" minAmt="${coupon.buyMiniAmt}" showKey="${status.count}" title="${coupon.cpNm}">
															${coupon.cpNm}
														</span>
													</c:forEach>
												</span>
											</div>
											</c:if>
				                    		<div class="row">
				                    			<span class="col1">L.POINT 적립금</span>
				                    			<span class="col2" id="lpointSavePoint">0원</span>
				                    			<span class="col3"></span>
				                    		</div>
				                    	</div>
                                        <!-- 0613 구매 전 확인 필수 레이어팝업(리뉴얼) -->
										<!--팝업콘텐츠 (타겟 ID동일)-->
										<div id="purchase_popup" class="comm-layer-popup_fixed">
										    <div class="content-wrap">
										        <div class="content">
										            <div class="head">
										                <h3 class="title">구매 전 확인 필수</h3>
										                <button type="button" class="close" onclick="close_popup('#purchase_popup');">
                                                            <img src="/images/web/icon/close/white.png" alt="닫기">
                                                        </button>
										            </div>

										            <div class="main">
										            	<div>
											                <ul class="list-disc type-B">
																<li>
																	<strong class="title">대여조건</strong>
																	<div class="blinking"><strong class="text-red"><span id="id00rentAge"></span>, 운전경력 <span id="id00rentCaree"></span></strong> </div>
																	<div> ※ 대여 조건에 부합하지 않으면 현장에서 차량 대여가 불가하며, 이에 따라 발생하는 수수료는 예약자 본인 부담입니다.</div>
																</li>

															    <li>
															        <strong class="title">대여기간</strong>
															        <fmt:parseDate var="fromDT" value="${searchVO.sFromDt}${searchVO.sFromTm}" pattern="yyyyMMddHHmm" />
															        <fmt:parseDate var="toDT" value="${searchVO.sToDt}${searchVO.sToTm}" pattern="yyyyMMddHHmm" />
															        <div><fmt:formatDate value="${fromDT }" pattern="yyyy년 MM월 dd일 HH시"/> ~ <fmt:formatDate value="${toDT }" pattern="yyyy년 MM월 dd일 HH시"/> </div>
															    </li>
															    <li>
															        <strong class="title">총 대여시간</strong>
															        <div class="usedHourStr">0시간</div>
															    </li>
															    <li>
															        <strong class="title">자차보험</strong>
															        <div>
															        	<c:if test="${prdtVO.isrDiv eq 'ID00'}">
															            <p>자차자율 상품</p>
															            <p>(본 상품은 <span class="text-red">인수현장</span>에서 <span class="text-red">자차보험</span>을 <span class="text-red">자율적</span>으로 <span class="text-yellow">선택</span> 가능한 상품)</p>
															            </c:if>
															            <c:if test="${prdtVO.isrDiv eq 'ID10'}">
															            <p>자차포함 상품</p>
															            <p>(대여기간 동안의 <span class="text-red">
															          	  <c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">
																			  <strong class="text-red">일반자차<div class="checkIsrDivGen"></div> 보험 포함</strong>된 상품
																      	  </c:if>
																      	  <c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">
																			  <strong class="text-red">고급자차<div class="checkIsrDivLux"></div> 보험 포함</strong>된 상품
																      	  </c:if>
															             금액이 포함</span>된 상품)</p>
															            </c:if>
															        	<c:if test="${prdtVO.isrDiv eq 'ID20'}">
															            <p>자차필수 상품</p>
															            <p>(본 상품은 <span class="text-red">인수현장</span>에서 <span class="text-red">자차보험</span>을 필수로 결제해야 하는 상품)</p>
															            </c:if>
															        </div>
															    </li>
															    <li>
															    	<div id="hcOneCardTxt"></div>
															    </li>
															    <li>
															        <strong class="title">취소/환불</strong>
															        <div>상품페이지 취소/환불 규정 참조</div>
															    </li>
															    <li>
															    	<strong class="title">당일예약 및 하루 전 예약</strong>
															    	<div>필히 당일예약 및 하루 전 예약은 업체로 연락하여 수량 및 셔틀버스 유무를 확인하여 예약을 진행하여주시기 바랍니다.</div>
															    </li>
															</ul>
															<div class="type-body3">
															    <p>08:00~20:00 외 차량 대여 / 반납은 일부 업체만
															        가능하며, 추가요금이 발생하거나 완전자차 보험가입이
															        필요할 수 있습니다.</p>
															    <p>기타 문의사항은 해당업체로 연락바랍니다.</p>
															    <p><c:out value="${prdtVO.corpNm}"/> : <c:out value="${prdtVO.rsvTelNum}"/></p>
															</div>
														</div>
														<div class="purchase-btn-group">
															<button type="button" class="comm-btn" onclick="javascript:fn_RcInstantBuy();">확인</button>
														</div>
										            </div> <!-- //main -->
										        </div><!-- content -->
										    </div>
										</div> <!--//layer-popup-->
                                        <!-- //0613 구매 전 확인 필수 레이어팝업(리뉴얼) -->
				                    </div> <!-- //purchasing-info -->
			                    </div><!-- pdWrap -->
			                </div> <!-- detailR -->
			            </div> <!-- detail -->


						<div class="rc-detail-area">
			            	<!-- 렌터가 상세설명 -->
			            	<div class="rc-detail-info">
			            		
			            		<!-- 현대캐피탈 one-card 이벤트 -->
			            		<c:if test="${prdtVO.useFuelDiv eq 'CF04'}">
			            			<section class="hd-capital">
                                        <h2>현대캐피탈 EV 충전카드 안내</h2>
                                        <div class="hd-article-wrap">
                                            <ul>
                                                <li>· 현대캐피탈 EV 충전카드 하나로 제주도 내 모든 충전기를 자유롭게 이용</li>
                                                <li>· 렌터카 예약을 완료하고, 발송되는 링크를 통해 회원 가입 즉시 이용할 수 있는 충전 크레딧 지급(3,000P)</li>
                                            </ul>
                                        </div>
                                        <div class="ev-select">
                                            <ul>
                                                <li>
                                                    <input type="radio" name="hcOneCardYn" id="hcOneCardY" value="Y" class="application" onclick="show_popup('#application_popup');"/>
                                                    <label for="hcOneCardY">신청</label>
                                                </li>
                                                <li>
                                                    <input type="radio" name="hcOneCardYn" id="hcOneCardN" value="N" class="Not-applied" checked="checked"/>
                                                    <label for="hcOneCardN">미신청</label>
                                                </li>
                                            </ul>
                                        </div>
                                    </section>
                                    
                                    <div id="application_popup" class="comm-layer-popup_fixed">
                                        <div class="content-wrap">
                                            <div class="content">
                                                <div class="head">
                                                    <h3 class="title">현대캐피탈 EV 충전카드 이용안내</h3>
                                                    <button class="close" type="button" onclick="close_popup('#application_popup');">
                                                        <img src="/images/web/icon/close/white.png" alt="닫기">
                                                    </button>
                                                    <div class="main">
                                                        <div>
                                                            <ul class="list-disc type-B">
                                                                <li>1. 현대캐피탈 EV 충전카드 ‘신청’ 선택</li>
                                                                <li>2. 렌터카 예약을 완료하고, 발송되는 링크를 통해 회원 가입</li>
                                                                <li>3. 제주공항 도착 후 1층 제주관광협회 종합안내센터에서 카드 수령</li>
                                                                <li>4. 카드 사용 등록하고 제주도 내 모든 충전기를 자유롭게 이용(등록 방법 별도 안내 예정)</li>
																<li>* 한 번 사용 등록한 충전카드는 다음 제주 방문 때 또 다시 사용가능</li>
                                                            </ul>
                                                        </div>
                                                        	유의사항
                                                        <div>
                                                            <ul class="list-disc type-B">
                                                                <li>- 현대캐피탈 EV 충전카드는 현대캐피탈과 제휴한 충전 사업자를 통해 제공됩니다.</li>
                                                                <li>- 현대캐피탈 EV 충전카드는 서비스 제공업체의 책임하에 운영되므로 서비스와 관련된 모든 법적 책임은 해당 업체에 있습니다. </li>
                                                                <li>- 충전기 고장 등 서비스 이용 중에 발생하는 사항은 현대캐피탈과 무관함을 알려드립니다.</li>
                                                            </ul>
                                                        </div>
                                                        
                                                        <div class="purchase-btn-group">
                                                            <button type="button" class="comm-btn" onclick="javascript:close_popup('#application_popup');">확인</button>
                                                        </div>
                                                    </div>
                                                </div>
                                             </div>
                                        </div>
                                    </div>
			            		</c:if>
			            		
								<c:if test="${fn:length(prmtList) > 0 }">
									<c:forEach items="${prmtList }" var="prmt">
										<section class="rc-event">
											<div class="evnt_label">
												<span>
													<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:14px; width:14px; fill:currentColor">
		                                              <path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
													</svg>
												</span>
												Event & Issue
											</div>
											<div class="evnt_tx">
												<div class="evnt_title"><c:url value="${prmt.prmtNm }" /></div>
												<div class="evnt_date">
		                                           	<fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
													<fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
													<fmt:formatDate value="${startDt}" pattern="yyyy년 MM월 dd일" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy년 MM월 dd일" />
												</div>
												<c:if test="${not empty prmt.prmtExp}">
	                                            <div class="evnt_memo">
	                                                <c:out value="${prmt.prmtExp}" escapeXml="false" />
	                                            </div>
												</c:if>
											</div>
										</section>
									</c:forEach>
								</c:if>
								<section class="rc_insurance">
									<div class="rc-info-title">보험요금 안내</div>
									<div class="rc-info-con">
										<%--<div class="insurance_info">
										<c:if test="${prdtVO.isrDiv eq 'ID00'}">
											<div class="insure_type">자차자율 : </div>
							        		<div class="insure_memo">*본 상품은 <b>인수현장에서 자차보험을 자율적으로 선택</b>하여 이용하는 상품
							        		</div>
										</c:if>
										<c:if test="${prdtVO.isrDiv eq 'ID10'}">
											<div class="insure_type">자차포함 : </div>
										    <div class="insure_memo">*본 상품은 <b>자차 보험
										<c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">
											(일반자차)
										</c:if>
										<c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">
									    	(고급자차)
										</c:if>
											포함 </b>된 상품</div>
										</c:if>
										&lt;%&ndash;<c:if test="${prdtVO.isrDiv eq 'ID20'}">
											<div class="insure_type">자차필수 : </div>
										    <div class="insure_memo">*본 상품은 <b>인수현장에서 자차보험</b>을 필수로 결제해야 하는 상품</div>
										</c:if>&ndash;%&gt;
										</div>--%>
										<div class="inline-group">
											<c:if test="${(prdtVO.isrDiv eq 'ID10' and prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN) }">
											<div class="type">
												<h5>일반자차</h5>
												<table>
	                                            <colgroup>
	                                                <col width="">
	                                                <col width="">
	                                                <col width="">
	                                            </colgroup>
									        	<tbody>
									        	<%--<c:if test="${prdtVO.isrDiv ne 'ID10' }">
									        	<tr>
	                                                <th>요금</th>
	                                                <td>1일 <fmt:formatNumber value="${prdtVO.generalIsrAmt}" />원</td>
	                                            </tr>
	                                            </c:if>--%>
	                                            <tr>
	                                                <th>나이</th>
	                                                <td class="isrAge">만 ${prdtVO.generalIsrAge}세 이상</td>
	                                            </tr>
	                                            <tr>
	                                                <th>운전경력</th>
	                                                <td class="isrCareer">${prdtVO.generalIsrCareer}년 이상</td>
	                                            </tr>
	                                            <tr>
	                                                <th>보상한도</th>
	                                                <td class="isrRewardAmt">
														<c:if test="${prdtVO.generalIsrRewardAmt eq '0'}">무제한</c:if>
														<c:if test="${prdtVO.generalIsrRewardAmt ne '0'}">${prdtVO.generalIsrRewardAmt}</c:if>
													</td>
	                                            </tr>
	                                            <tr>
	                                                <th>고객부담금</th>
	                                                <td class="isrBurcha">${prdtVO.generalIsrBurcha}
													</td>
	                                            </tr>
									        	</tbody>
												</table>
											</div>
											</c:if>
										    <c:if test="${(prdtVO.isrDiv eq 'ID10' and prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX) }">
										    <div class="type">
										        <h2>고급자차</h2>
										        <table>
	                                            <colgroup>
	                                                <col width="">
	                                                <col width="">
	                                                <col width="">
	                                            </colgroup>
	                                            <tbody>
	                                            <%--<c:if test="${prdtVO.isrDiv ne 'ID10' }">
	                                            <tr>
	                                                <th>요금</th>
	                                                <td>1일 <fmt:formatNumber value="${prdtVO.luxyIsrAmt}" />원</td>
	                                            </tr>
	                                            </c:if>--%>
	                                            <tr>
	                                                <th>나이</th>
	                                                <td class="isrAge">만 ${prdtVO.luxyIsrAge}세 이상</td>
	                                            </tr>
	                                            <tr>
	                                                <th>운전경력</th>
	                                                <td class="isrCareer">${prdtVO.luxyIsrCareer}년 이상</td>
	                                            </tr>
	                                            <tr>
	                                                <th>보상한도</th>
	                                                <td class="isrRewardAmt">
													<c:if test="${prdtVO.luxyIsrRewardAmt eq '0'}">무제한</c:if>
													<c:if test="${prdtVO.luxyIsrRewardAmt ne '0'}">${prdtVO.luxyIsrRewardAmt}</c:if>
													</td>
	                                            </tr>
	                                            <tr>
	                                                <th>고객부담금</th>
	                                                <td class="isrBurcha">${prdtVO.luxyIsrBurcha}</td>
	                                            </tr>
	                                            </tbody>
										        </table>
										    </div>
										    </c:if>
										</div>
									    <c:if test="${prdtVO.isrDiv eq 'ID10'}">
									    <div class="memo">
	                                          	<div class="memo-title">보험안내</div>
									        <div class="memo-con">
									        	<p class="_inDetail">
									        		${prdtVO.isrAmtGuide}
									        	</p>
												<div class="grayspace"></div>
												<div class="show-more">
												   <span class="show-more seq0" onclick>더 보기</span>
												</div>
									    	</div>
									    </div>
									    </c:if>
									</div>
								</section> <!-- rc_insurance -->
								<section class="rc_info">
		                            <!--상품설명-->
		                            <div class="rc-info-title">차량 옵션</div>
		                            <div class="sub-section">
		                                <div class="sub-section-left">
		                                    <div class="line_seperator"></div>
		                                    <h2 class="sub-section-header"> 연식 </h2>
		                                </div>
	                                    <div class="sub-section-right">
	                                        <div class="line_seperator"></div>
	                                        <div class="collapsed">
	                                            <div>
	                                                <p class="ad-tip">
	                                                    <c:out value="${prdtVO.modelYear}"/>년
	                                                </p>
	                                            </div>
	                                        </div>
	                                    </div>
		                            </div>
	                                <div class="sub-section">
	                                    <div class="sub-section-left">
	                                        <div class="line_seperator"></div>
	                                        <h2 class="sub-section-header"> 변속기 </h2>
	                                    </div>
	                                    <div class="sub-section-right">
	                                        <div class="line_seperator"></div>
	                                        <div class="collapsed">
	                                            <div>
	                                                <p class="ad-tip">
	                                                    <c:out value="${prdtVO.transDivNm}"/>
	                                                </p>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="sub-section">
										<div class="sub-section-left">
											<div class="line_seperator"></div>
	                                        <h2 class="sub-section-header"> 차량옵션 </h2>
	                                    </div>
	                                    <div class="sub-section-right">
	                                        <div class="line_seperator"></div>
	                                        <div class="collapsed">
												<div class="text-info-typeA">
													<ul>
													<c:forEach var="icon" items="${iconCdList}">
														<c:set var="optFlag" value="off" />
														<c:if test="${icon.checkYn eq Constant.FLAG_Y }">
															<c:set var="optFlag" value="on" />
														</c:if>
														<li class="${optFlag }">${icon.iconCdNm }</li>
													</c:forEach>
													</ul>
												</div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <c:if test="${not empty prdtVO.nti}">
	                                <div class="sub-section">
	                                    <div class="sub-section-left">
	                                        <div class="line_seperator"></div>
	                                        <h2 class="sub-section-header">참고사항</h2>
	                                    </div>
                                        <div class="sub-section-right">
                                            <div class="line_seperator"></div>
                                            <div class="collapsed">
                                                <p class="">
                                                    <c:out value="${fn:replace(prdtVO.nti, newLineChar, '<br/>')}" escapeXml="FALSE" />
                                                </p>
                                            </div>
                                        </div>
	                                </div>
	                                </c:if>
	                                <div class="sub-section">
	                                    <div class="sub-section-left">
	                                        <div class="line_seperator"></div>
	                                        <h2 class="sub-section-header">취소/환불</h2>
	                                    </div>
	                                    <div class="sub-section-right">
	                                        <div class="line_seperator"></div>
	                                        <div class="collapsed">
	                                            <p>
	                                                <c:out value="${prdtVO.cancelGuide}" escapeXml="FALSE" />
	                                            </p>
	                                        </div>
	                                    </div>
	                                </div>
	                                <c:if test="${prdtVO.useFuelDiv eq 'CF04' }">
	                                <div class="sub-section elect">
										<div class="sub-section-left">
	                                        <div class="line_seperator"></div>
	                                        <h2 class="sub-section-header">전기차 충전소 안내</h2>
	                                    </div>
	                                    <div class="sub-section-right">
	                                    	<div class="line_seperator"></div>
	                                    	<div class="collapsed">
			        							<dl class="typeC">
			        								<dt>환경부 전기차 충전소 홈페이지</dt>
			        								<dd>
			        									<a href="https://www.ev.or.kr/portal/main" target="_blank" class="link">https://www.ev.or.kr/portal/main</a>
			        								</dd>
			            						</dl>
			            						<dl class="typeC">
			            							<dt>모바일 앱다운로드</dt>
			            							<dd>
			            								<div class="rent-app">
				            								<div class="icon">
				                    							<img src="/images/mw/rent/app-electric.png" alt="제주충전소앱">
					                						</div>
					                						<div class="text">
					                    						<p>‘제주 전기차 충전소’ 검색해 보세요.</p>
					                    						<div class="app">
					                        						<a href="https://play.google.com/store/apps/details?id=com.client.ev.activities&hl=ko" target="_blank" title="새창">
					                            						<span><img src="/images/mw/rent/app-google.png" alt="안드로이드"> 안드로이드</span>
					                        						</a>
					                        						<a href="https://apps.apple.com/kr/app/ev-infra/id1206679515" target="_blank" title="새창">
					                            						<span><img src="/images/mw/rent/app-ios.png" alt="iOS"> iOS</span>
					                        						</a>
					                    						</div>
					                						</div>
				                						</div>
			            							</dd>
			            						</dl>
	                                    	</div>
	                                    </div>
		    						</div>
	                                </c:if>
								</section> <!-- rc_info -->
								<section class="rc_map">
		                           	<div class="rc-info-title">셔틀 탑승/차량 인수/반납 위치</div>
		                           	<div class="map-area rent" id="sighMap"></div>
						            <script type="text/javascript">
									//동적 지도 ( 움직이는 지도.)
									var container2 = document.getElementById('sighMap');
									var options2 = {
										center: new daum.maps.LatLng('${rcDftInfo.tkovLat}', '${rcDftInfo.tkovLon}'),
										//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
										level: 4
									};

									var map2 = new daum.maps.Map(container2, options2);

									// 현재 위치.
									//마커가 표시될 위치입니다
									var c_markerPosition  = new daum.maps.LatLng('${rcDftInfo.tkovLat}', '${rcDftInfo.tkovLon}');
									//var c_markerPosition  = new daum.maps.LatLng(33.4888341, 126.49807970000006);
									var c_imageSrc = "<c:url value='/images/web/icon/location_my.png'/>";
									var c_imageSize = new daum.maps.Size(24, 35);
									var c_markerImage = new daum.maps.MarkerImage(c_imageSrc, c_imageSize);
									// 마커를 생성합니다
									var marker = new daum.maps.Marker({
										map : map2,
										position: c_markerPosition,
										image : c_markerImage,
										clickable: true
									});


									var c_content = '<p class="point-info">' +
													'<strong>${prdtVO.corpNm}</strong>'+
													'<span class="addr">${rcDftInfo.tkovRoadNmAddr} ${rcDftInfo.tkovDtlAddr}</span>' +
													'<a href="javascript:c_closeOverlay();" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" height="12" alt="닫기" /></a>' +
													'</p>';
									var overlay = new daum.maps.CustomOverlay({
										content:c_content,
										position:c_markerPosition,
										map : map2
									});

									daum.maps.event.addListener(marker, 'click', function() {
										overlay.setMap(map2);
									});

									function c_closeOverlay() {
										overlay.setMap(null);
									}
									</script>
									<div class="map-text-info">
										<h3><c:out value="${prdtVO.corpNm}"/></h3>
										<div class="rc_bus">
		                                    <dl>
		                                        <dt>셔틀버스 타는 곳</dt>
		                                        <dd>제주공항 도착 게이트 5번 건너편 (구)렌트카하우스 <strong class="text-red"><c:out value="${rcDftInfo.shutZone1}"/>구역 <c:out value="${rcDftInfo.shutZone2}"/>번</strong></dd>
		                                    </dl>
		                                    <dl>
		                                        <dt>운행시간</dt>
		                                        <dd><c:out value="${rcDftInfo.shutRunTm}"/></dd>
		                                    </dl>
		                                    <dl class="half">
		                                        <dt>운행간격</dt>
		                                        <dd><c:out value="${rcDftInfo.shutRunInter}"/>분</dd>
		                                    </dl>
		                                    <dl class="half">
		                                        <dt>소요시간</dt>
		                                        <dd><c:out value="${rcDftInfo.shutCostTm}"/>분</dd>
		                                    </dl>
										</div>
	                                    <dl>
	                                        <dt>주소</dt>
	                                        <dd><c:out value="${rcDftInfo.tkovRoadNmAddr}"/> <c:out value="${rcDftInfo.tkovDtlAddr}"/></dd>
	                                    </dl>
	                                    <dl>
	                                        <dt>전화번호</dt>
	                                        <dd><c:out value="${prdtVO.rsvTelNum}"/></dd>
	                                    </dl>
									</div>
									<c:if test="${not empty rcDftInfo.sccUrl}">
									<div class="video-area">
										<lite-youtube videoid="${fn:replace(rcDftInfo.sccUrl, 'https://www.youtube.com/embed/', '')}" playlabel="렌터카 유튜브영상"></lite-youtube>
									</div>
									<%--<div class="video-area">
										<iframe title="렌트카 유튜브영상" width="800" height="350" src="${rcDftInfo.sccUrl}" allowfullscreen></iframe>
									</div>--%>
									</c:if>
								</section> <!-- rc_map -->
                                <div class="nav-tabs2">
                                    <div id="tabs-5" class="tabPanel"></div>
                                    <div id="tabs-6" class="tabPanel"></div>
                                </div>
			            	</div> <!-- rc-detail-info -->
                            <!-- 임시로 주석 처리 !!!  -->
                            <c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">
                              <c:set var="form_url" value="/web/rentcar/car-detail.do" />
                            </c:if>
                            <c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
                              <c:set var="form_url" value="/web/rentcar/car-detail.do" />
                            </c:if>

                            <div class="rc_purchase">
                                <form name="frm" id="frm" method="get" action="<c:url value='${form_url }' />">
                                    <input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
                                    <input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
                                    <input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
                                    <input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
                                    <input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
                                    <input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_Y}" />
                                    <input type="hidden" name="prdtNum" id="prdtNum" value="${prdtVO.prdtNum}" />
                                    <input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />	<!-- 보험여부 -->
                                    <input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" /> <!-- 렌터카회사 -->
                                    <input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" /> <!-- 차량 유형 검색 -->
                                    <input type="hidden" id="chkRsvFlag" value="0" />
                                    <input type="hidden" id="chkSelDate" value="0" />
                                    <div class="rc-filter-area">
                                        <div class="filter_check">
                                            <div class="f_con">
                                                <div class="date_wrap">
                                                    <div class="date_pick">
                                                        <label>대여일</label>
                                                        <div class="value-text">
                                                            <div class="date-container">
                                                               <span class="date-pick">
                                                                   <input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
                                                                   <input class="datepicker" type="text" name="sFromDtView" id="sFromDtView" placeholder="대여일 선택" value="${searchVO.sFromDtView}" onclick="optionClose('.popup-typeA')">
                                                               </span>
                                                               <div class="time-area">
                                                                <select name="sFromTm" id="sFromTm" class="full" title="시간선택">
                                                                    <c:forEach begin="8" end="20" step="1" var="fromTime">
                                                                        <c:if test='${fromTime < 10}'>
                                                                            <c:set var="fromTime_v" value="0${fromTime}00" />
                                                                            <c:set var="fromTime_t" value="0${fromTime}:00" />
                                                                        </c:if>
                                                                        <c:if test='${fromTime > 9}'>
                                                                            <c:set var="fromTime_v" value="${fromTime}00" />
                                                                            <c:set var="fromTime_t" value="${fromTime}:00" />
                                                                        </c:if>
                                                                        <option value="${fromTime_v}" <c:if test="${searchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
                                                                    </c:forEach>
                                                                </select>
                                                               </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="date_pick_out">
                                                        <label>반납일</label>
                                                        <div class="value-text">
                                                            <div class="date-container">
                                                                <span class="date-pick">
                                                                    <input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
                                                                    <input class="datepicker" type="text" name="sToDtView" id="sToDtView" placeholder="반납일 선택" value="${searchVO.sToDtView}" onclick="optionClose('.popup-typeA')">
                                                                </span>
                                                                <div class="time-area">
                                                                    <select name="sToTm" id="sToTm" class="full" title="시간선택">
                                                                        <c:forEach begin="8" end="20" step="1" var="toTime">
                                                                        <c:if test='${toTime < 10}'>
                                                                            <c:set var="toTime_v" value="0${toTime}00" />
                                                                            <c:set var="toTime_t" value="0${toTime}:00" />
                                                                        </c:if>
                                                                        <c:if test='${toTime > 9}'>
                                                                            <c:set var="toTime_v" value="${toTime}00" />
                                                                            <c:set var="toTime_t" value="${toTime}:00" />
                                                                        </c:if>
                                                                        <option value="${toTime_v}" <c:if test="${searchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
                                                                    </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="search_btn">
                                                    <a href="javascript:fn_formSubmit();">
                                                        <c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
                                                        검색
                                                        </c:if>
                                                        <c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">
                                                        재검색
                                                        </c:if>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="total-area">
                                            <span class="money"><strong id="vCarSaleAmt">0</strong>원</span>
                                            <span class="text">
                                                <span class="usedHourStr"></span>
                                                <span class="usedInfo">대여료<c:if test="${prdtVO.isrDiv eq 'ID10'}"> + 자차 포함</c:if></span>
                                            </span>
                                        </div>
                                        <input type="hidden" name="carSaleAmt" id="carSaleAmt" />
                                        <input type="hidden" name="nmlAmt" id="nmlAmt" />
                                        <input type="hidden" name="insuSaleAmt" id="insuSaleAmt" value="0" />
                                        <input type="hidden" name="totalAmt" id="totalAmt" />
                                        <div class="purchasing-info">
											<c:if test="${chkPointBuyAble eq 'Y'}">
												<div class="purchase-btn-group" id="divAble">
													<button type="button" id="cartBtn" class="comm-btn gray width40" onclick="javascript:fn_RcAddCart();">장바구니</button>
													<button type="button" class="comm-btn red width60" onclick="<c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
													return fn_chkDate();</c:if><c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">fn_gotoRsv();</c:if>">예약하기</button>
												</div>
												<div class="purchase-btn-group hide" id="divAbleNone">
													<span class="comm-btn not-ms width100" id="errorMsg">대여일의 범위가 올바르지 않습니다.</span>
												</div>
											</c:if>
											<c:if test="${chkPointBuyAble ne 'Y'}">
												<div class="purchase-btn-group">
													<button type="button" class="comm-btn gray width100">구매불가</button>
												</div>
											</c:if>

                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- 렌터가 구매하기창 -->

						</div> <!-- rc-detail-area -->

						<!-- recommend-wrap-->
				    	<%--<div class="recommend-group">
                            <div id="rc-Recommend">
                                <div class="rc-info-title">유모차/카시트</div>
                                <div class="product-slide-item">
                                    <div id="product_slideItem" class="swiper-container">
                                        <ul class="swiper-wrapper">
                                            <c:forEach items="${bacsList }" var="result" varStatus="status">
                                                <li class="swiper-slide">
                                                    <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${result.prdtNum}&prdtDiv=${result.prdtDiv}'/>">
                                                        <div class="recommendPhoto">
                                                            <img src="${result.savePath}thumb/${result.saveFileNm}" width="250" height="250" loading="lazy" alt="product">
                                                        </div>
                                                        <div class="recommendText">
                                                            <div class="rcTitle"><c:out value='${result.prdtNm}' /></div>
                                                            <div class="rcPrice"><fmt:formatNumber value="${result.saleAmt}" type="number"/><span class="won">원</span></div>
                                                        </div>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <div id="slideItem_arrow" class="arrow-box">
                                        <div id="slideItem_next" class="swiper-button-next"></div>
                                        <div id="slideItem_prev" class="swiper-button-prev"></div>
                                    </div>
                                </div>
                            </div>
				    	</div> <!-- recommend-wrap-->--%>
			        </div> <!--//Fasten-->
			    </div> <!--//bgWrap-->
			</div> <!-- //new-detail -->
	        <!-- //Change Contents -->

	        <div id="insurance_info" class="comm-layer-popup_fixed">
	            <div class="content-wrap">
	                <div class="content">
	                    <div class="installment-head">
	                        <h3 class="title"></h3>
	                        <button type="button" class="close" onclick="close_popup('#insurance_info')"><img src="../../images/mw/icon/close/dark-gray.png" loading="lazy" alt="닫기"></button>
	                        <!-- 1109 자차보험 안내 레이어팝업 업데이트 -->
							<div class="rent-qna">
                                    <div class="car_insurance">
                                        <div class="info-head">자차보험 <span>안내</span></div>
                                        <div class="free-wrap">
                                            <div class="allguide">
                                                <table>
                                                    <colgroup>
                                                        <col style="width:16%">
                                                        <col style="width:21%">
                                                        <col style="width:21%">
                                                        <col style="width:21%">
                                                        <col style="width:21%">
                                                    </colgroup>
                                                    <thead>
                                                        <th>구분</th>
                                                        <th>일반자차</th>
                                                        <th>일반자차(부분무제한)</th>
                                                        <th>고급자차</th>
                                                        <th>고급자차(전액무제한)</th>
                                                    </thead>
                                                    <tbody>
                                                        <!-- 보상한도 -->
                                                        <tr>
                                                            <td class="aside_tit">보상한도</td>
                                                            <td>한도 내 보상</td>
                                                            <td>무제한</td>
                                                            <td>한도 내 보상</td>
                                                            <td>무제한</td>
                                                        </tr><!-- //보상한도 -->

                                                        <!-- 면책금 -->
                                                        <tr>
                                                            <td class="aside_tit">면책금</td>
                                                            <td>면책금 발생</td>
                                                            <td>면책금 발생</td>
                                                            <td>
                                                                <dl>
                                                                    <dt>한도 내 면제</dt>
                                                                    <dd>(일부업체 발생)</dd>
                                                                </dl>
                                                            </td>
                                                            <td>면제</td>
                                                        </tr><!--//면책금-->

                                                        <!--휴차 보상료-->
                                                        <tr>
                                                            <td class="aside_tit">휴차 보상료</td>
                                                            <td>부담금 발생</td>
                                                            <td>부담금 발생</td>
                                                            <td>
                                                                <dl>
                                                                    <dt>한도 내 면제</dt>
                                                                    <dd>(일부업체 발생)</dd>
                                                                </dl>
                                                            </td>
                                                            <td>면제</td>
                                                        </tr><!-- //휴차 보상료 -->

                                                        <!-- 단독 사고 -->
                                                        <tr>
                                                            <td class="aside_tit">단독 사고</td>
                                                            <td>보장 안됨</td>
                                                            <td>보장</td>
                                                            <td>
                                                                <dl>
                                                                    <dt>보장 안됨</dt>
                                                                    <dd>(일부업체 보장)</dd>
                                                                </dl>
                                                            </td>
                                                            <td>보장</td>
                                                        </tr><!-- //단독사고 -->

                                                        <!--휠/타이어 -->
                                                        <tr>
                                                            <td class="aside_tit">휠/타이어</td>
                                                            <td>보장 안됨</td>
                                                            <td>보장</td>
                                                            <td>보장 안됨</td>
                                                            <td>보장</td>
                                                        </tr><!-- //휠/타이어 -->
                                                    </tbody>
                                                </table>

                                            </div>

                                            <!-- info -->
                                            <div class="event-note">
                                                <ul>
                                                    <li><span>●</span> <span class="tit">자차보험이란 :</span> 차량 사고 발생 시 대여한 렌터카 파손에 대하여 보장해주는 보험</li>
                                                    <li><span>●</span> <span class="tit">보상한도 :</span> 보험으로 처리 가능한 사고비용의 최대한도 비용</li>
                                                    <li><span>●</span> <span class="tit">면책금 :</span> 사고에 대한 책임을 면하기 위해 지불 하는 돈</li>
                                                    <li><span>●</span> <span class="tit">휴차 보상료 :</span> 사고 발생 후 차량 수리기간 동안 발생한 영업손실 비용</li>
                                                    <li><span>●</span> <span class="tit">단독사고 :</span> 과실 유무와 상관없이 주·정차된 차량 및 시설물을 접촉하거나 본인과실 100% 사고인 경우</li>
                                                    <li><span>●</span> <span class="tit">휠/타이어 보장 :</span> 타이어, 휠 파손에 대한 수리비용</li>
                                                    <li>* 세부 내용은 렌터카 업체마다 다를 수 있습니다. 차량 상세페이지 보험내용을 꼭 확인해주세요.</li>
                                                </ul>
                                            </div><!-- //info -->
                                            <div class="character">
                                                <img src="../../images/web/rent/insurance.png" loading="lazy" alt="탐나르방">
                                            </div>
                                        </div><!-- //free-wrap -->
                                    </div><!-- //free_installment -->
						</div>
							<!-- //1109 자차보험 안내 레이어팝업 업데이트 -->
	                    </div>
	                </div>
	            </div>
	        </div>
		</div> <!-- //subContents -->
	</div><!-- subContainer -->
</main>

<script type="text/javascript" src="<c:url value='/js/useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/lite-yt-embed.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/bloglink.js?version=${nowDate}'/>"></script> --%>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>

<script type="text/javascript">

	function fn_CalRent(){
		if(!checkByFromTo($('#sFromDtView').val(), $("#sToDtView").val(), "Y")){
			window.alert('대여일의 범위가 올바르지 않습니다.');
			return;
		}
	
		let parameters = "sPrdtNum=${prdtVO.prdtNum}";
		parameters += "&sFromDt=" + $("#sFromDt").val();
		parameters += "&sFromTm=" + $("#sFromTm").val();
		parameters += "&sToDt=" + $("#sToDt").val();
		parameters += "&sToTm=" + $("#sToTm").val();

		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/web/rentcar/calRent.ajax'/>",
			data:parameters ,
			success:function(data){
				fn_ChangeRange();
				if(data.prdtInfo.saleAmt < 1){
					$(".money").html("");
					$(".usedInfo").html("선택하신 시간은 마감되었습니다.");
				}else{
					$(".usedHourStr").html(data.prdtInfo.rsvTm + "시간");
				}
	
				$("#carSaleAmt").val(data.prdtInfo.saleAmt);
				$("#vCarSaleAmt").html(commaNum(data.prdtInfo.saleAmt));
				$("#lpointSavePoint").html(commaNum(parseInt((data.prdtInfo.saleAmt * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
				$("#nmlAmt").val(data.prdtInfo.nmlAmt);
	
				fn_TotalCmt();
				/** 쿠폰 리스트 체크 */
				fn_chkCouponList();

				/**자차보험여부 */
				checkIsrDiv(data.prdtInfo);
	
				$("#divAble").removeClass('hide');
	
				if(data.prdtInfo.ableYn == "Y" && data.prdtInfo.saleAmt > "1"){
					$('#chkRsvFlag').val('1');
					$("#divAbleNone").addClass('hide');
					$("#divAble .comm-btn.red").text("예약하기")

					/** 리본 */
					if(data.prdtInfo.apiRentDiv == "R"){
						if(data.prdtInfo.isrTypeDiv == "LUXY"){
							$(".isrAge").text("만 "+data.prdtInfo.luxyIsrAge+"세 이상");
							$(".isrCareer").text(data.prdtInfo.luxyIsrCareer+"년 이상");
							let rewarAmt = data.prdtInfo.luxyIsrRewardAmt;
							if(data.prdtInfo.luxyIsrRewardAmt == "0" || data.prdtInfo.luxyIsrRewardAmt == "-1"){
								rewarAmt = "무제한";
							}
							$(".isrRewardAmt").text(rewarAmt);
							$(".isrBurcha").text(data.prdtInfo.luxyIsrBurcha);
	
						}
						if(data.prdtInfo.isrTypeDiv == "GENL"){
							let rewarAmt = data.prdtInfo.generalIsrRewardAmt;
							if(data.prdtInfo.generalIsrRewardAmt == "0" || data.prdtInfo.generalIsrRewardAmt == "-1"){
								rewarAmt = "무제한";
							}
							$(".isrAge").text("만 "+data.prdtInfo.generalIsrAge+"세 이상");
							$(".isrCareer").text(data.prdtInfo.generalIsrCareer+"년 이상");
							$(".isrRewardAmt").text(rewarAmt);
							$(".isrBurcha").text(data.prdtInfo.generalIsrBurcha);
						}
						$("._inDetail").text(data.prdtInfo.isrAmtGuide)
					}
					$(".rc_insurance").show();
				}else{
					if("${searchVO.searchYn}" == "Y"){
						$(".money").hide();
						$(".usedHourStr").hide();
						$(".usedInfo").html("선택하신 시간은 마감되었습니다.");
						$("#divAble .comm-btn.red").text("예약마감");
						$("#divAble .comm-btn.red").removeAttr("onclick");
	                }
					$('#chkRsvFlag').val('0');
					$(".rc_insurance").hide();
				}
			},
			error:function(error){
				$(".money").hide();
				$(".usedHourStr").hide();
				$(".usedInfo").html("선택하신 시간은 마감되었습니다.");
				$("#divAble .comm-btn.red").text("예약마감");
				$("#divAble .comm-btn.red").removeAttr("onclick");
				$('#chkRsvFlag').val('0');
				$(".rc_insurance").hide();
			}
		});
	}
	
	/** 대여기간 텍스트 변경 */
	function fn_ChangeRange(){
		$("#info_sDt").html($("#sFromDtView").val());
		$("#info_sTm").html($("#vFromTm :selected").text().substring(0,2) + "시");
		$("#info_eDt").html($("#sToDtView").val());
		$("#info_eTm").html($("#vToTm :selected").text().substring(0,2) + "시");
	}
	
	function fn_OnchangeTime(){
		$("#sFromTm").val($("#vFromTm :selected").val());
		$("#sToTm").val($("#vToTm :selected").val());
	}
	/** 선택사항 변경 시 */
	function fn_OptChange(obj){
		$("#insuSaleAmt").val($(obj).val());
		$("#vInsuSaleAmt").html(commaNum($(obj).val()));
		fn_TotalCmt();
	}
	/** 총합계 노출 */
	function fn_TotalCmt(){
		$("#totalAmt").val(parseInt($("#insuSaleAmt").val()) + parseInt($("#carSaleAmt").val()));
		$("#vTotalAmt").html(commaNum($("#totalAmt").val()));
	}
	
	<c:if test="${prdtVO.isrDiv eq 'ID00'}">
		<c:set var="isrStr" value="자차자율" />
	</c:if>
	<c:if test="${prdtVO.isrDiv eq 'ID10'}">
		<c:if test="${prdtVO.isrTypeDiv eq 'GENL'}">
			<c:set var="isrStr" value="자차포함-일반자차" />
		</c:if>
		<c:if test="${prdtVO.isrTypeDiv eq 'LUXY'}">
			<c:set var="isrStr" value="자차포함-고급자차" />
		</c:if>
	</c:if>
	<c:if test="${prdtVO.isrDiv eq 'ID20'}">
		<c:set var="isrStr" value="자차필수" />
	</c:if>
	/** 찜하기 */
	function fn_RcAddPocket() {
		let pocket = [{
			prdtNum 	: "<c:out value='${prdtVO.prdtNum}'/>",
			prdtNm 		: "<c:out value='${prdtVO.prdtNm}'/> / <c:out value='${prdtVO.useFuelDivNm}'/> / <c:out value='${isrStr}'/>",
			prdtDiv 	: "<c:out value='${Constant.RENTCAR}'/>",
			corpId 		: "<c:out value='${prdtVO.corpId}'/>",
			corpNm 		: "<c:out value='${prdtVO.corpNm}'/>",
		}];
	
		fn_AddPocket(pocket);
	}
	
	function fn_chkDate() {
		if ($("#chkSelDate").val() == '0') {
			$('#sFromDtView').focus();
			alert('예약을 원하는 날짜를 선택해주세요.\n선택한 날짜에 따라 결제금액이 변경될 수 있습니다.');
			return false;
		} else {
			if (parseInt($('#sFromDt').val() + $('#sFromTm').val()) >= parseInt($('#sToDt').val() + $('#sToTm').val())) {
				alert('대여일의 범위가 올바르지 않습니다.');
				$('#sToDtView').focus();
				return false;
			} else {
				$("#frm").attr('action', '/web/rentcar/car-detail.do').submit();
				return false;
			}
		}
	}
	
	function fn_RcAddCart(){
		<c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
		return fn_chkDate();
		</c:if>
	
		if ($('#chkRsvFlag').val() == 0) {
			fn_CalRent();
			return false;
		}
		
		/* 현대캐피탈 one-card */
		var useFuelDiv = "${prdtVO.useFuelDiv}";
		var hcOneCardYn = "";
		if(useFuelDiv != "CF04"){
			hcOneCardYn = "N"
		} else {
			hcOneCardYn = $("input:radio[name=hcOneCardYn]:checked").val();
		}
	
		let cart = [{
				prdtNum 	: "<c:out value='${prdtVO.prdtNum}'/>",
				prdtNm 		: "<c:out value='${prdtVO.prdtNm}'/> / <c:out value='${prdtVO.useFuelDivNm}'/> / <c:out value='${isrStr}'/>",
				prdtDivNm 	: "렌터카",
				corpId 		: "<c:out value='${prdtVO.corpId}'/>",
				corpNm 		: "<c:out value='${prdtVO.corpNm}'/>",
				fromDt 		: $("#sFromDt").val(),
				toDt 		: $("#sToDt").val(),
				totalAmt 	: $("#totalAmt").val(),
				nmlAmt 		: $("#nmlAmt").val(),
				fromTm 		: $("#sFromTm").val(),	// 대여시간
				toTm 		: $("#sToTm").val(),	// 반납시간
				addAmt		: $("#insuSaleAmt").val(),
				insureDiv	: $("#payOption :selected").val(),
				imgPath 	: $("#imgPath").attr("src"),
				hcOneCardYn : hcOneCardYn
			}];
	
		fn_AddCart(cart);
	}
	
	function fn_RcInstantBuy(){
		<c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
		return fn_chkDate();
		</c:if>
		
		/* 현대캐피탈 one-card */
		var useFuelDiv = "${prdtVO.useFuelDiv}";
		var hcOneCardYn = "";
		if(useFuelDiv != "CF04"){
			hcOneCardYn = "N"
		} else {
			hcOneCardYn = $("input:radio[name=hcOneCardYn]:checked").val();
		}	
		
		let cart = [{
				prdtNum 	: "<c:out value='${prdtVO.prdtNum}'/>",
				prdtNm 		: "<c:out value='${prdtVO.prdtNm}'/> / <c:out value='${prdtVO.useFuelDivNm}'/> / <c:out value='${isrStr}'/>",
				prdtDivNm 	: "렌터카",
				corpId 		: "<c:out value='${prdtVO.corpId}'/>",
				corpNm 		: "<c:out value='${prdtVO.corpNm}'/>",
				fromDt 		: $("#sFromDt").val(),
				toDt 		: $("#sToDt").val(),
				totalAmt 	: $("#totalAmt").val(),
				nmlAmt 		: $("#nmlAmt").val(),
				fromTm 		: $("#sFromTm").val(),	// 대여시간
				toTm 		: $("#sToTm").val(),	// 반납시간
				addAmt		: $("#insuSaleAmt").val(),
				insureDiv	: $("#payOption :selected").val(),
				imgPath 	: $("#imgPath").attr("src"),
				hcOneCardYn : hcOneCardYn
			}];

		fn_InstantBuy(cart);
	}
	
	function fn_DetailPrdt(prdtNum){
		$("#prdtNum").val(prdtNum);
		document.frm.action = "<c:url value='/web/rentcar/car-detail.do'/>";
		document.frm.submit();
	}
	
	/** 검색폼 */
	function fn_formSubmit() {
		document.frm.submit();
	}
	
	/** 쿠폰 리스트 체크 */
	function fn_chkCouponList() {
		let copNum = 0;
		let amt = eval(fn_replaceAll($("#vCarSaleAmt").text(), ",", ""));
	
		$(".useCouponList").each(function() {
			if (amt < $(this).attr('minAmt')) {
				$("#cpTitle" + $(this).attr("showKey")).addClass("hide");
				$("#useCouponNm_" + $(this).attr("showKey")).addClass("hide");
				$("#useCouponAmt_" + $(this).attr("showKey")).addClass("hide");
			} else {
				copNum++;
	
				$("#cpTitle" + $(this).attr("showKey")).removeClass("hide");
				$("#useCouponNm_" + $(this).attr("showKey")).removeClass("hide");
				$("#useCouponAmt_" + $(this).attr("showKey")).removeClass("hide");
			}
		});
	
		if (copNum == 0) {
			$("#useAbleCoupon").addClass("hide");
		} else {
			$("#useAbleCoupon").removeClass("hide");
		}
	}
	
	/** 쿠폰 받기 */
	function fn_couponDownload(cpId, idx) {
		let parameters = "cpId=" + cpId;
	
		$.ajax({
			url:"<c:url value='/mw/couponDownload.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.result == "success") {
					$("#btnCoupon" + idx).addClass("hide");
					$("#cpTitle" + idx).html("할인쿠폰");
	
					alert("<spring:message code='success.coupon.download'/>");
				} else {
					alert("<spring:message code='fail.coupon.download'/>");
				}
			},
			error: fn_AjaxError
		})
	}
	
	/** 쿠폰코드 등록 */
	function goCouponCode() {
		if(confirm("<spring:message code='confirm.coupon.code' />")){
			location.href = "<c:url value='/web/mypage/couponList.do' />";
		}
	}
	
	function fn_gotoRsv() {
	
		//현대캐피탈 one-card
		let hcOneCardTxt = "";
		var useFuelDiv = "${prdtVO.useFuelDiv}";
		var hcOneCardYn = $("input:radio[name=hcOneCardYn]:checked").val();
		if(useFuelDiv == "CF04" && hcOneCardYn == "Y"){
			hcOneCardTxt += "<strong class='title'>현대캐피탈 EV 충전카드</strong>";
			hcOneCardTxt += "<div>";
			hcOneCardTxt += "<p>렌터카 예약을 완료하고, 발송되는 링크를 통해 회원 가입 필수";
			hcOneCardTxt += "<br/>제주공항에서 카드를 수령하고 사용 등록을 완료해야 이용 가능  ";
			hcOneCardTxt += "</p>";
			hcOneCardTxt += "</div>";															        
		} else {
			hcOneCardTxt = "";
		}
		$("#hcOneCardTxt").html(hcOneCardTxt);
		
		if ($('#chkRsvFlag').val() == 1) {

			//예약하기 - 구매 전 확인 필수 - 대여 조건 셋팅
			$("#id00rentAge").html($(".isrAge").text());
			if ($("#id00rentAge").html() == "undefined" || $("#id00rentAge").html() == "" || $("#id00rentAge").html() == null){
				$("#id00rentAge").html($("#popRentAge").text());
			}
			$("#id00rentCaree").html($(".isrCareer").text());
			if ($("#id00rentCaree").html() == "undefined" || $("#id00rentCaree").html() == "" || $("#id00rentCaree").html() == null){
				$("#id00rentCaree").html($("#popRentCareer").text());
			}

			show_popup('#purchase_popup');
		} else {
			fn_CalRent();
		}
	}
	
	function fn_productList(){
		document.frm.action = "<c:url value='/web/rentcar/car-list.do'/>";
		document.frm.submit();
	}

	function checkIsrDiv(prdtInfo){
		if (prdtInfo.isrDiv == 'ID10'){
			if (prdtInfo.isrTypeDiv == 'GENL'){
				if (prdtInfo.generalIsrRewardAmt == '0' && prdtInfo.generalIsrBurcha == '0'){
					$(".checkIsrDivGen").text('(전액 무제한)');
				}

				if (prdtInfo.generalIsrRewardAmt == '-1' && prdtInfo.generalIsrBurcha == '0' && prdtInfo.corpId != 'CRCO180002'){
					$(".checkIsrDivGen").text('(전액 무제한)');
				}

				if (prdtInfo.generalIsrRewardAmt == '0' && prdtInfo.generalIsrBurcha != '0') {
					$(".checkIsrDivGen").text('(부분 무제한)');
				}

				if (prdtInfo.generalIsrRewardAmt == '-1' && prdtInfo.generalIsrBurcha != '0' && prdtInfo.corpId != 'CRCO180002') {
					$(".checkIsrDivGen").text('(부분 무제한)');
				}
			}

			if (prdtInfo.isrTypeDiv == 'LUXY'){
				if (prdtInfo.luxyIsrRewardAmt == '0' && prdtInfo.luxyIsrBurcha == '0'){
					$(".checkIsrDivLux").text('(전액 무제한)');
				}

				if (prdtInfo.luxyIsrRewardAmt == '-1' && prdtInfo.luxyIsrBurcha == '0' && prdtInfo.corpId != 'CRCO180002'){
					$(".checkIsrDivLux").text('(전액 무제한)');
				}

				if (prdtInfo.luxyIsrRewardAmt == '0' && prdtInfo.luxyIsrBurcha != '0'){
					$(".checkIsrDivLux").text('(부분 무제한)');
				}

				if (prdtInfo.luxyIsrRewardAmt == '-1' && prdtInfo.luxyIsrBurcha != '0'&& prdtInfo.corpId != 'CRCO180002'){
					$(".checkIsrDivLux").text('(부분 무제한)');
				}
			}

		}
	}


	$(document).ready(function(){
	    /*if($('#product_slideItem .swiper-slide').length > 1) {
	        var swiper = new Swiper('#product_slideItem', {
	            slidesPerView: 4,
	            spaceBetween: 10,
	            pagination: '#slideItem_paging',
	            nextButton: '#slideItem_next',
	            prevButton: '#slideItem_prev',
	            loop: true
	        });
	    }*/
	
		if("${fn:length(imgList)}" != "1"){
			$("#carousel").show();
			$(".gallery-view1 .carousel").jCarouselLite({
		        btnNext: ".gallery-view1 .next",
		        btnPrev: ".gallery-view1 .prev",
		        speed: 300,
		        visible: 5,
		        circular: false
		    });
		}
	
	    $(".gallery-view1 .carousel img").click(function() { //이미지 변경
	        $(".gallery-view1 .mid img").attr("src", $(this).attr("src"));
	    });
	    $('.gallery-view1 .carousel li').click(function(){ //class 추가
	        $('.gallery-view1 .carousel li').removeClass('select');
	        $(this).addClass('select');
	    });
	
		$("#sFromDtView").datepicker({
			dateFormat: "yy-mm-dd",
			minDate: "${SVR_TODAY}",
			maxDate: "${AFTER_DAY}",
			defaultDate: "${searchVO.sFromDtView}",
			onSelect : function(selectedDate) {
				$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
				$('#sToDtView').datepicker("destroy");
				$("#sToDtView").datepicker({
					dateFormat: "yy-mm-dd",
					minDate: $('#sFromDtView').val(),
					defaultDate: fn_NexDay(selectedDate),
					onSelect : function(selectedDate) {
						$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
					}
				});
				$("#sToDtView").val(fn_NexDay(selectedDate)).datepicker("option", "minDate", selectedDate);
				$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
				$("#chkSelDate").val(1);
			}
		});
	
		$("#sToDtView").datepicker({
			dateFormat: "yy-mm-dd",
			minDate: "${SVR_TODAY}",
			maxDate: "${AFTER_DAY}",
			defaultDate: "${searchVO.sToDtView}",
			onSelect : function(selectedDate) {
				$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
				$("#chkSelDate").val(1);
			}
		});
	
		fn_CalRent();
	
		g_UE_corpId		= "${prdtVO.corpId}";			//업체 코드 - 넣어야함
		g_UE_prdtnum 	= "${prdtVO.prdtNum}";			//상품번호  - 넣어야함
		g_UE_corpCd 	= "${Constant.RENTCAR}";
		g_UE_getContextPath = "${pageContext.request.contextPath}";
		fn_useepilInitUI("${prdtVO.corpId}", "${prdtVO.prdtNum}", "${Constant.RENTCAR}");
		fn_useepilList("${prdtVO.corpId}", "${prdtVO.prdtNum}", "${Constant.RENTCAR}");
		g_Oto_corpId	= "${prdtVO.corpId}";					//업체 코드 - 넣어야함
		g_Oto_prdtnum 	= "${prdtVO.prdtNum}";					//상품번호  - 넣어야함
		g_Oto_corpCd 	= "${Constant.RENTCAR}";	//숙박/랜트.... - 페이지에 고정
		g_UE_getContextPath = "${pageContext.request.contextPath}";
	
		fn_otoinqInitUI("${prdtVO.corpId}", "${prdtVO.prdtNum}", "${Constant.RENTCAR}");
		fn_otoinqList("${prdtVO.corpId}", "${prdtVO.prdtNum}", "${Constant.RENTCAR}", "${prdtVO.rsvTelNum }");
	
		fn_ChangeRange();
	
		$('input[name=sCarDivCdStr]').click(function() {
			$('#sCarDivCd').val($(this).val());
			$('#carDivStr').text($("label[for=" + $(this).attr('id') + "]").text());
			optionClose($("#rent_zone"));
		});
	
		/** L.Point 적립 금액 */
		$("#lpointSavePoint").html(commaNum(parseInt((eval($("#vCarSaleAmt").text().replace(/,/g, '')) * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
	
		/** 더 보기 function*/
		if($("._inDetail").height() > 100){
		$(".memo-con .show-more").css("display","block");
			$("._inDetail").css("height","80px");
		}
		$("span.show-more").click(function(){
			if($("span.show-more").text() == "닫기"){
				$("span.show-more").text("더 보기")
				$("._inDetail").css("height","80px");
			}else{
				$("span.show-more").text("닫기")
				$("._inDetail").css("height","");
			}
		});
	
		$(window).scroll(function(event) {
			if($(".rc-detail-info").offset().top - 16 < $(window).scrollTop() && ($(document).height() - $(".footer_wrap").offset().top) - ($(".footer_wrap").offset().top - $(window).scrollTop()) < 250  ){
				$(".rc-filter-area").css("position","fixed");
				$(".rc-filter-area").css("top","10px");
			}else if(($(document).height() - $(".footer_wrap").offset().top) - ($(".footer_wrap").offset().top - $(window).scrollTop()) > 0){
				$(".rc-filter-area").css("position","absolute");
				$(".rc-filter-area").css("top",$(".rc-detail-area").height()-$(".rc-filter-area").height() - 50 +"px")
			}else{
				$(".rc-filter-area").css("position","absolute");
				$(".rc-filter-area").css("top","10px");
			}
		});
	});
</script>

<jsp:include page="/web/foot.do" />
</body>
</html>