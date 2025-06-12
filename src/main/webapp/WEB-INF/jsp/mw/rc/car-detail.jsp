<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex">
<c:if test="${fn:length(imgInfo) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(imgInfo) != 0}">
	<c:set value="${imgInfo[0].savePath}thumb/${imgInfo[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtVO.prdtNum}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${prdtVO.carImg}"/>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="${prdtVO.prdtNm} - ${prdtVO.corpNm}"/>
	<jsp:param name="keywordsLinkNum" value="${prdtVO.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtVO.prdtNm}"/>
	<jsp:param name="keywordAdd2" value="${prdtVO.corpNm}"/>
	<jsp:param name="description" value="[${prdtVO.corpNm}] ${prdtVO.prdtNm} : ${prdtVO.carDivNm}, ${prdtVO.modelYear}년식, ${prdtVO.transDivNm}, ${prdtVO.useFuelDivNm}, 승차인원 ${prdtVO.maxiNum}명 "/>
	<jsp:param name="imagePath" value="${seoImage}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtVO.prdtNm}'/>" />
<meta property="og:url" content="${strUrl}" />
<meta id="metaDesc" name="metaDesc" property="og:description" content="[${prdtVO.corpNm}] ${prdtVO.prdtNm} : ${prdtVO.carDivNm}, ${prdtVO.modelYear}년식, ${prdtVO.transDivNm}, ${prdtVO.useFuelDivNm}, 승차인원 ${prdtVO.maxiNum}명 " />
<meta property="fb:app_id" content="182637518742030" />
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style2.css?version=${nowDate}'/>">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-detail-area">
		<section class="detail-product-area">
			<h2 class="sec-caption">상품 정보</h2>
			<div class="detail-slider rentcar">
				<div class="title-box">
					<h3 class="title"><c:out value="${prdtVO.prdtNm}"/></h3>
				</div>
				<div id="detail_slider" class="swiper-container">
			        <div class="swiper-wrapper">
			            <div class="swiper-slide">
			            	<img src="<c:url value='${prdtVO.carImg}' />" alt="">
			            </div>   
			        </div>
			    </div>
			    <div class="bottom-info">
					<p>해당 이미지는 이해를 돕기 위한 예시로,<br>실제 배차되는 차량의 색상이나 버전이 다를 수 있습니다.</p>
			    	<ul>
			    		<li>
			    			<img src="<c:url value='/images/mw/rent/info/kind.png' />" alt="">
			    			<span><c:out value="${prdtVO.carDivNm}"/></span>
			    		</li>
			    		<li>
			    			<img src="<c:url value='/images/mw/rent/info/people.png' />" alt="">
			    			<span><c:out value="${prdtVO.maxiNum}"/>명</span>
			    		</li>
			    		<li>
			    			<img src="<c:url value='/images/mw/rent/info/oil.png' />" alt="">
			    			<span><c:out value="${prdtVO.useFuelDivNm}"/></span>
			    		</li>
			    	</ul>
			    </div>
			</div> <!-- //detail-slider -->
			<div class="product-info">
				<div class="title-area">
					<div class="title"><c:out value="${prdtVO.corpNm}"/></div>
					<div class="grade-area">
						<div class="score-area">
							<span class="score" id="ind_grade">평점 <strong class="text-red">0</strong>/5</span>
							<span class="icon" id="useepil_uiTopHearts">
				        </span>
						</div>
						<div class="bxLabel">
							<c:if test="${prdtVO.eventCnt > 0 }">
								<span class="main_label eventblue">이벤트</span>
							</c:if>
							<c:if test="${prdtVO.couponCnt > 0 }">
								<span class="main_label pink">할인쿠폰</span>
							</c:if>
							<c:if test="${prdtVO.tamnacardYn eq 'Y'}">
								<span class="main_label yellow">탐나는전</span>
							</c:if>
						</div>
					</div>
					<div class="rent-info">
						<span class="text"><span class="usedHourStr">0시간</span> 대여료</span>
						<strong class="price" id="vCarSaleAmt">0</strong>원
					</div>
    			</div>
			</div> <!-- //product-info -->

			<div class="selected-option-info side-padding">
				<div class="search-value">
					<div class="text">
						<fmt:parseDate var="fromDT" value="${searchVO.sFromDt}${searchVO.sFromTm}" pattern="yyyyMMddHHmm" />
						<fmt:parseDate var="toDT" value="${searchVO.sToDt}${searchVO.sToTm}" pattern="yyyyMMddHHmm" />
						<a href="javascript:document.frm.submit();" class="text-white"><fmt:formatDate value="${fromDT}" pattern="MM월 dd일 HH시"/> - <fmt:formatDate value="${toDT}" pattern="MM월 dd일 HH시"/>
						<span><img class="clock_icon" src="/images/mw/icon/clock_r.png" alt="대여시간">대여
							<span class="usedHourStr">0시간</span>
						</span>
						</a>

						<input type="hidden" name="carSaleAmt" id="carSaleAmt" />
                        <input type="hidden" name="nmlAmt" id="nmlAmt" />
                        <input type="hidden" name="insuSaleAmt" id="insuSaleAmt" value="0" />
                        <input type="hidden" name="totalAmt" id="totalAmt" />
						<input type="hidden" id="ableYn" />
					</div>
					<form name="frm" id="frm" method="get" onSubmit="return false;" action = "<c:url value='/mw/rentcar/mainList.do'/>">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
						<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
						<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
						<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
						<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
						<input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_N}" />
						<input type="hidden" name="sPrdtNum" id="sPrdtNum" value="${prdtVO.prdtNum}" />
						<input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />	<!-- 보험여부 -->
						<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" /> <!-- 렌터카회사 -->
						<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" /> <!-- 차량 유형 검색 -->
						<input type="hidden" name="sMakerDivCd" id="sMakerDivCd" value="${searchVO.sMakerDivCd}" /> <!-- 제조사 검색 -->
						<input type="hidden" name="sUseFuelDiv" id="sUseFuelDiv" value="${searchVO.sUseFuelDiv}" /> <!-- 사용연료 검색 -->
						<input type="hidden" name="sModelYear" id="sModelYear" value="${searchVO.sModelYear}" /> <!-- 연식 검색 -->
						<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}" />
						<input type="hidden" name="sFromDtView" id="sFromDtView" value="${searchVO.sFromDtView}" />
						<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}" />
						<input type="hidden" name="sToDtView" id="sToDtView" value="${searchVO.sToDtView}" />
						<input type="hidden" name="sFromTm" id="sFromTm" value="${searchVO.sFromTm}" />
						<input type="hidden" name="sToTm" id="sToTm" value="${searchVO.sToTm}" />
					</form>
				</div>
			</div>
			<div class="point-area">
				<c:if test="${!empty loginVO && fn:length(couponList) > 0}">
					<div class="col2-area hide" id="useAbleCoupon">
						<div class="title text-red">할인쿠폰</div>
						<c:forEach var="coupon" items="${couponList}" varStatus="status">
							<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>

							<div class="row useCouponList" minAmt="${coupon.buyMiniAmt}">
								<span class="col1">
									<div class="coupon-title-wrap">
										<div class="coupon-title">
											${coupon.cpNm}
										</div>
										<span class="text-gray"><fmt:formatNumber>${coupon.buyMiniAmt}</fmt:formatNumber>원 이상 구매시<br>사용 가능</span>
									</div>
								</span>
								<span class="col2">
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
								<c:if test="${!empty userCp}">
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
							</div>
						</c:forEach>
					</div>
				</c:if>
			    <div class="col2-area line">
					<div class="row">
				        <span class="col1">L.POINT적립금</span>
				        <span class="col2" id="lpointSavePoint">0원</span>
				    </div>
			    </div>
			</div>
		</section> <!-- //detail-product-area -->
		<section class="rent-info-area">
			<h2 class="sec-caption">렌터카 정보</h2>
			<!-- 현대캐피탈 one-card -->
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
							<li class="procedure">
								<input type="radio" name="hcOneCardYn" id="hcOneCardY" value="Y" class="application" />
								<label for="hcOneCardY">신청</label>
							</li>
							<li>
								<input type="radio" name="hcOneCardYn" id="hcOneCardN" value="N" class="Not-applied" checked="checked"/>
								<label for="hcOneCardN">미신청</label>
							</li>
						</ul>
					</div>
				</section>
				<!-- 현대캐피탈 EV 충전카드 이용안내 -->
				<div id="application_popup" class="comm-layer-popup application-popup">
					<div class="content-wrap">
						<div class="content">
							<div class="head">
								<div class="head_detail">
									<h3 class="title">현대캐피탈 EV 충전카드 이용안내</h3>
									<button class="popup_close" type="button" onclick="close_popup('#application_popup');">
										<img src="/images/mw/icon/close/faq_close.png" alt="닫기" onclick="">
									</button>
								</div>
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
											<li>- 현대캐피탈 EV 충전카드는 서비스 제공업체의 책임하에 운영되므로 서비스와 관련된 모든 법적 책임은 해당 업체에 있습니다.</li>
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
			<section class="content-group-area">
				<h3 class="title-type4">대여 기준</h3>
				<div class="inline-typeA side-padding">
				    <dl>
				        <dt>나이 : </dt>
				        <dd id="popRentAge">만 ${prdtVO.rntQlfctAge}세 이상</dd>
				    </dl>
				    <dl>
				        <dt>운전경력 : </dt>
				        <dd id="popRentCareer">${prdtVO.rntQlfctCareer}년 이상</dd>
				    </dl>
				    <dl>
				        <dt>면허종류 : </dt>
				        <dd>${prdtVO.rntQlfctLicense}종보통 이상</dd>
				    </dl>
				</div>
			</section> <!-- //content-group-area -->
			<section class="content-group-area">
				<div class="question-area">
					<h3 class="title-type4">자차보험 여부
						<button type="button" class="question" onfocus="this.blur()">
							<img src="<c:url value='/images/mw/icon/question.png' />" loading="lazy" alt="질문">
						</button>
					</h3>
					<!-- 1114 자차보험 안내 레이어팝업 업데이트 -->
					<div id="question_memo" class="comm-layer-popup">
						<div class="content-wrap">
							<div class="content">
								<div class="head">
									<h3 class="title">자차보험 안내</h3>
									<button type="button" class="close"><img src="/images/mw/icon/close/dark-gray.png" onclick="itemSingleHide('#car_info_box_1');" loading="lazy" alt="닫기"></button>
								</div>
								<div class="rent-qna">
									<!-- info -->
									<div class="event-note">
										<ul>
											<li> <span class="tit">· 자차보험이란 :</span> 차량 사고 발생 시 대여한 렌터카 파손에 대하여 보장해주는 보험</li>
											<li>* 세부 내용은 렌터카 업체마다 다를 수 있습니다. 차량 상세페이지 보험내용을 꼭 확인해주세요.</li>
										</ul>
									</div><!-- //info -->
									<div class="car_insurance">
										<!-- 일반보험 -->
										<h2>일반보험</h2>
										<div class="free-wrap">
											<div class="allguide">
												<table>
													<colgroup>
														<col style="width:33.3%">
														<col style="width:33.3%">
														<col style="width:33.3%">
													</colgroup>
													<thead>
														<th>구분</th>
														<th>일반자차</th>
														<th>일반자차<span>(부분무제한)</span></th>
													</thead>
													<tbody>

													<!-- 보상한도 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="1">
																보상한도
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_1" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>보상한도</span> : <br>보험으로 처리 가능한 사고비용의 <br>최대한도 비용</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>한도 내 보상</td>
														<td>무제한</td>
													</tr><!-- //보상한도 -->

													<!-- 면책금 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="2">
																면책금
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_2" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>면책금</span> : <br>사고에 대한 책임을 면하기 위해 <br>지불 하는 돈
															</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>한도 내 면제<br>(일부업체 발생)</td>
														<td>면제</td>
													</tr><!--//면책금-->

													<!--휴차 보상료-->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="3">
																휴차 보상료
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_3" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>휴차 보상료</span> : <br>사고 발생 후 차량 수리기간 동안 <br>발생한 영업손실 비용</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>부담금 발생</td>
														<td>부담금 발생</td>
													</tr><!-- //휴차 보상료 -->

													<!-- 단독 사고 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="4">
																단독 사고
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_4" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>단독사고</span> : <br>과실 유무와 상관없이 주·정차된 차량 및 <br>시설물을 접촉하거나 본인과실<br> 100% 사고인 경우</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>보장 안됨</td>
														<td>보장</td>
													</tr><!-- //단독사고 -->

													<!--휠/타이어 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="5">
																휠/타이어
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_5" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>휠/타이어 보장</span> : <br>타이어, 휠 파손에 대한 수리비용</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>보장 안됨</td>
														<td>보장</td>
													</tr><!-- //휠/타이어 -->
													</tbody>
												</table>
											</div>
										</div><!-- //free-wrap --><!-- //일반보험 -->
										<!-- 고급보험 -->
										<h2>고급보험</h2>
										<div class="free-wrap">
											<div class="allguide">
												<table>
													<colgroup>
														<col style="width:33.3%">
														<col style="width:33.3%">
														<col style="width:33.3%">
													</colgroup>
													<thead>
														<th>구분</th>
														<th>고급자차</th>
														<th>고급자차<br>(전액무제한)</th>
													</thead>
													<tbody>
													<!-- 보상한도 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="6">
																보상한도
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_6" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>보상한도</span> : <br>보험으로 처리 가능한 사고비용의<br> 최대한도 비용</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>한도 내 보상</td>
														<td>무제한</td>
													</tr><!-- //보상한도 -->
													<!-- 면책금 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="7">
																면책금
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_7" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>면책금</span> : <br>사고에 대한 책임을 면하기 위해 <br>지불 하는 돈</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>한도 내 면제<br>(일부업체 발생)</td>
														<td>면제</td>
													</tr><!--//면책금-->
													<!--휴차 보상료-->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="8">
																휴차 보상료
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_8" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>휴차 보상료</span> : <br>사고 발생 후 차량 수리기간 동안 <br>발생한 영업손실 비용</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>한도 내 면제<br>(일부업체 발생)</td>
														<td>면제</td>
													</tr><!-- //휴차 보상료 -->
													<!-- 단독 사고 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="9">
																단독 사고
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_9" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>단독사고</span> : <br>과실 유무와 상관없이 주·정차된 차량 및 <br>시설물을 접촉하거나 <br>본인과실 100% 사고인 경우</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>보장 안됨<br>(일부업체 보장)</td>
														<td>보장</td>
													</tr><!-- //단독사고 -->
													<!--휠/타이어 -->
													<tr>
														<td class="aside_tit">
															<button class="car_info_box" data-id="10">
																휠/타이어
																<img src="../../images/mw/icon/question_mark.png" alt="">
															</button>
														</td>
														<div id="car_info_box_10" class="car_info_box_d">
															<p class="info_artcle">
																<img src="../../images/mw/icon/question_mark.png" alt="">
																<span>휠/타이어 보장</span> : <br>타이어, 휠 파손에 대한 수리비용</p>
															<button>
																<img src="/images/mw/icon/close/rcpopup_close.png" alt="닫기버튼" loading="lazy" onclick="itemSingleHide('.car_info_box_d');">
															</button>
														</div>
														<td>보장 안됨</td>
														<td>보장</td>
													</tr><!-- //휠/타이어 -->
													</tbody>
												</table>
											</div>
										</div><!-- //free-wrap --><!-- //고급보험 -->
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- //1114 자차보험 안내 레이어팝업 업데이트 -->
				</div>
				<div class="side-padding">
				    <dl class="type-A">
				      <c:if test="${prdtVO.isrDiv eq 'ID00'}">
				        <dt>자차자율 상품</dt>
				        <dd>본 상품은 <strong class="text-red"><u>인수현장</u>에서 자차보험</strong>을
				        	<strong class="text-red"><u>자율적</u></strong>으로 <strong class="text-red">선택</strong> 가능한 상품
				        </dd>
				      </c:if>										      
                      <c:if test="${prdtVO.isrDiv eq 'ID10'}">
                       	<dt>자차포함 상품</dt>
				        <dd>본 상품은
				      	<c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">
							<strong class="text-red"><u>일반자차<div class="checkIsrDivGen"></div> 보험 포함</u></strong>된 상품</dd>
				      	</c:if>
				      	<c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">
							<strong class="text-red"><u>고급자차<div class="checkIsrDivLux"></div> 보험 포함</u></strong>된 상품</dd>
				      	</c:if>
                      </c:if>
                      <c:if test="${prdtVO.isrDiv eq 'ID20'}">
                      	<dt>자차필수 상품</dt>
				        <dd>본 상품은 <strong class="text-red"><u>인수현장</u>에서 자차보험</strong>을 필수로 결제해야 하는 상품</dd>
                      </c:if>
				    </dl>
				</div>
				<c:if test="${prdtVO.isrDiv eq 'ID10'}">
				<h3 class="title-type4 margin-top50">보험요금 안내</h3>
				<div class="type-body1 side-padding">
				  <c:if test="${(prdtVO.isrDiv eq 'ID10' and prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN)}">
					<dl class="type-A">
				        <dt>일반자차</dt>
				        <dd>
		                    <div>
		                        <p class="isrAge">나이 : 만 ${prdtVO.generalIsrAge}세 이상</p>
		                    </div>
		                    <div>
		                        <p class="isrCareer">운전경력 : ${prdtVO.generalIsrCareer}년 이상</p>
		                    </div>
		                    <div>
		                        <p class="isrRewardAmt">보상한도 :
								<c:if test="${prdtVO.generalIsrRewardAmt eq '0'}">무제한</c:if>
								<c:if test="${prdtVO.generalIsrRewardAmt ne '0'}">${prdtVO.generalIsrRewardAmt}</c:if>
								</p>
		                    </div>
		                    <div>
		                        <p class="isrBurcha">고객부담금 : ${prdtVO.generalIsrBurcha}</p>
		                    </div>
				        </dd>
				    </dl>
				  </c:if>
				  <c:if test="${(prdtVO.isrDiv eq 'ID10' and prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX) }">
				    <dl class="type-A">
				        <dt>고급자차</dt>
				        <dd>
		                    <div>
		                        <p class="isrAge">나이 : 만 ${prdtVO.luxyIsrAge}세 이상</p>
		                    </div>
		                    <div>
		                        <p class="isrCareer">운전경력 : ${prdtVO.luxyIsrCareer}년 이상</p>
		                    </div>
		                    <div>
		                        <p class="isrRewardAmt">보상한도 :
								<c:if test="${prdtVO.luxyIsrRewardAmt eq '0'}">무제한</c:if>
								<c:if test="${prdtVO.luxyIsrRewardAmt ne '0'}">${prdtVO.luxyIsrRewardAmt}</c:if>
								</p>
		                    </div>
		                    <div>
		                        <p class="isrBurcha">고객부담금 : ${prdtVO.luxyIsrBurcha}</p>
		                    </div>
				        </dd>
				    </dl>
				  </c:if>
				  <c:if test="${prdtVO.isrDiv eq 'ID10' }">
				    <dl class="type-A">
				        <dt>보험안내</dt>
				        <dd>
				        	<div class="_inDetail">
				        		${prdtVO.isrAmtGuide}
				        	</div>
				        </dd>
				    </dl>
				  </c:if>
				</div>
				</c:if>
			</section> <!-- //content-group-area -->
		</section> <!-- //rent-info-area -->
		<div class="nav-tabs2">
		    <div class="menu-wrap">
		        <ul id="scroll_tabs"  class="nav-menu">
		            <li class="active"><a href="#tabs-info">상품설명</a></li>
		            <li><a href="#tabs-cancel">취소/환불</a></li>
		            <li><a href="#tabs-review">이용후기</a></li>
		            <li><a href="#tabs-counsel">1:1문의</a></li>
		        </ul>
		    </div>
		    <div id="tabs-info" class="tabPanel">
		        <div class="text-groupA">
		          <c:if test="${fn:length(prmtList) > 0 }">
               		<!-- 프로모션 추가 -->
               		<c:forEach items="${prmtList }" var="prmt">
                	<div class="promotion-detail">
                	  <c:if test="${not empty fn:trim(prmt.dtlImg) }">
                		<div class="photo">
                			<img src='<c:url value="${prmt.dtlImg }" />' alt="프로모션">
                		</div>
                	  </c:if>
                		<div class="text-area">
                			<dl>
                				<dt class="title"><c:url value="${prmt.prmtNm }" /></dt>
                				<dd>
                					<ul>
										<li class="text-right">
											<fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
											<fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
											<span><fmt:formatDate value="${startDt}" pattern="yyyy년 MM월 dd일" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy년 MM월 dd일" /></span>
										</li>
										<c:if test="${not empty prmt.prmtExp}">
											<li>
												<span style="white-space:pre-wrap;"><c:out value="${prmt.prmtExp}" escapeXml="false" /></span>
											</li>
										</c:if>
                					</ul>
                				</dd>
                			</dl>
                		</div>
                	</div> <!-- //promotion-detail -->
                	</c:forEach>
                	<!-- //프로모션 추가 -->
                  </c:if>
                  <c:if test="${not empty rcDftInfo.sccUrl }">
               		<div class="video-area">
		            	<iframe width="100%" height="276" src="${rcDftInfo.sccUrl }" allowfullscreen></iframe>
		            </div>
		          </c:if>
					<dl class="inline">
						<dt class="title-type3">연식</dt>
						<dd class="type-body1"><c:out value="${prdtVO.modelYear}"/>년</dd>
					</dl>
					<dl class="inline">
						<dt class="title-type3">변속기</dt>
						<dd class="type-body1"><c:out value="${prdtVO.transDivNm}"/></dd>
					</dl>
					<dl>
						<dt class="title-type3">차량옵션</dt>
						<dd class="type-body1">
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
						</dd>
					</dl>
					<dl>
						<dt class="title-type3">셔틀버스</dt>
						<dd class="type-body1">
							제주공항 도착 게이트 5번 건너편 (구)렌트카하우스<br>
							<strong class="text-red"><c:out value="${rcDftInfo.shutZone1}"/>구역 <c:out value="${rcDftInfo.shutZone2}"/>번</strong>
						</dd>
					</dl>
					<div class="inline-typeA margin-top15">
						<dl>
							<dt>운행시간</dt>
							<dd><c:out value="${rcDftInfo.shutRunTm}"/>분</dd>
						</dl>
						<dl>
							<dt>운행간격</dt>
							<dd><c:out value="${rcDftInfo.shutRunInter}"/>분</dd>
						</dl>
						<dl>
							<dt>소요시간</dt>
							<dd><c:out value="${rcDftInfo.shutCostTm}"/>분</dd>
						</dl>
					</div>
					<c:if test="${corpVO.superbCorpYn eq 'Y'}">
					<dl>
						<dt class="title-type3">우수관광업체</dt>
						<dd class="type-body1">
							<img class="excellence" src="<c:url value='/images/web/icon/excellence_02.jpg'/>" alt="우수관광사업체">
						</dd>
					</dl>
				    </c:if>
					<dl>
						<dt class="title-type3">차량 인수/반납 위치</dt>
						<dd class="type-body1">
							<div class="map-area rent" id="sighMap"></div>
						  <c:if test="${not empty rcDftInfo.tkovLat }">
							<script type="text/javascript">
							//동적 지도 ( 움직이는 지도.)
							var container2 = document.getElementById('sighMap');
							var options2 = {
								center: new daum.maps.LatLng(${rcDftInfo.tkovLat}, ${rcDftInfo.tkovLon}),
								//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
								level: 4
							};

							var map2 = new daum.maps.Map(container2, options2);

							// 현재 위치.
							//마커가 표시될 위치입니다
							var c_markerPosition  = new daum.maps.LatLng(${rcDftInfo.tkovLat}, ${rcDftInfo.tkovLon});
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
											'<a href="javascript:c_closeOverlay();" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
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
						  </c:if>
							<div class="map-text-info">
								<p>상호 : <c:out value="${prdtVO.corpNm}"/></p>
								<p>주소 : <c:out value="${rcDftInfo.tkovRoadNmAddr}"/> <c:out value="${rcDftInfo.tkovDtlAddr}"/></p>
								<p>전화번호 : <a href="tel:<c:out value="${prdtVO.rsvTelNum}"/>"><c:out value="${prdtVO.rsvTelNum}"/></a></p>
							</div>
						</dd>
					</dl>
				  <c:if test="${prdtVO.useFuelDiv eq 'CF04' }">
					<!-- 전기차인 경우 노출 -->
					<dl>
						<dt class="title-type3">전기차 충전소 안내</dt>
						<dd class="type-body1">
							<h4 class="title-type5">환경부 전기차 충전소 홈페이지</h4>
							<div class="type-body1 depth">
								<a href="https://www.ev.or.kr/mobile" target="_blank" class="link">https://www.ev.or.kr/mobile</a>
							</div>
							<h4 class="title-type5">모바일 앱 스토어</h4>
							<div class="type-body1 depth rent-app">
								<div class="icon">
									<img src="<c:url value='/images/mw/rent/app-electric.png' />" alt="제주충전소앱">
								</div>
								<div class="text">
									<p>‘제주 전기차 충전소’ 검색해 보세요.</p>
									<div class="app">
										<a href="https://play.google.com/store/apps/details?id=jejuevservice.com" target="_blank">
											<span><img src="<c:url value='/images/mw/rent/app-google.png' />" alt=""> 안드로이드</span>
										</a>
										<a href="https://itunes.apple.com/kr/app/제주-전기차-충전소/id1269451470?mt=8&newopen=yes" target="_blank">
											<span><img src="<c:url value='/images/mw/rent/app-ios.png' />" alt=""> iOS</span>
										</a>
									</div>
								</div>
							</div>
						</dd>
					</dl>
					<!-- //전기차인 경우 노출 -->
				  </c:if>
				</div> <!-- //text-groupA -->
		    </div> <!-- //tabs-info -->
		    <div id="tabs-cancel" class="tabPanel">
		        <div class="text-groupA">
					<dl>
						<dt class="title-type3">취소/환불</dt>
						<dd class="type-body1">
							<c:out value="${prdtVO.cancelGuide}" escapeXml="FALSE" />
						</dd>
					</dl>
				</div> <!-- //text-groupA -->
		    </div> <!-- //tabs-cancel -->
		    <c:if test="${not empty prdtVO.nti}">
		    <div id="tabs-etc" class="tabPanel">
		        <div class="text-groupA">
					<dl>
						<dt class="title-type3">참고사항</dt>
						<dd class="type-body1">
							<c:out value="${fn:replace(prdtVO.nti, newLineChar, '<br/>')}" escapeXml="FALSE" />
						</dd>
					</dl>
				</div> <!-- //text-groupA -->
		    </div> <!-- //tabs-cancel -->
		    </c:if>
		    <!-- 이용후기 -->
		    <div id="tabs-review" class="tabPanel">
		    	<div class="text-groupA">
			        <!-- 기존코드 동일 -->
			        <div id="review" class="tab-con con-review">					    
					</div> <!-- //#review -->
				</div>
		    </div> <!-- //tabs-review -->
		    <!-- 1:1문의 -->
		    <div id="tabs-counsel" class="tabPanel">
		        <div class="text-groupA">
		        	<!-- 기존코드 동일 -->
		        	<div id="counsel" class="tab-con con-counsel">					    
					</div> <!-- //counsel -->
		        </div>
		    </div> <!-- //tabs-counsel -->
		</div>

		<!-- 구매하기 -->
		<div class="purchase-area">
			<div class="basic">
				<div class="icon-area">
					<%-- <a href="javascript:void(0)" onclick="itemSingleShow('#sns_popup');"> --%>
					<a id="rc-sns-share" class="sns-share">
						<img src="<c:url value='/images/mw/icon/sns.png' />" alt="sns">
						<span>공유하기</span>
					</a>				    	
					<%--<c:if test="${pocketCnt eq 0 }">
					&lt;%&ndash; <a href="javascript:void(0)" onclick="javascript:fn_RcAddPocket();" id="pocketBtnId"> &ndash;%&gt;
					<a onclick="javascript:fn_RcAddPocket();" id="pocketBtnId">
						<img src="<c:url value='/images/mw/icon/product_like2_off.png' />" alt="찜하기">
					</a>
					</c:if>
					<c:if test="${pocketCnt ne 0 }">					    	
					<a>
						<img src="<c:url value='/images/mw/icon/product_like2_on.png' />" alt="찜하기">
					</a>
					</c:if>--%>
				</div>
				<input type="hidden" id="chkPurchaseFlag" value="0" />
				<c:if test="${chkPointBuyAble eq 'Y'}">
                <button type="button" class="gobuy" onclick="fn_clicksaleBtn();">구매하기</button>
				</c:if>
				<c:if test="${chkPointBuyAble ne 'Y'}">
					<!-- 0217 구매불가 -->
					<button type="button" class="gobuy change">구매불가</button>
				</c:if>
			</div>
			<div id="purchase_popup" class="purchase-popup rent comm-layer-popup">
				<div class="top-area">
					<strong>구매 전 확인 필수</strong>
					<button type="button" class="close" onclick="itemSingleHide('#purchase_popup');">
						<img src="<c:url value='/images/mw/icon/close/dark-gray.png' />" loading="lazy" alt="닫기">
					</button>
				</div>
				<div class="middle-area">
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
					    	<div><fmt:formatDate value="${fromDT }" pattern="yyyy년 MM월 dd일 HH시"/> ~ <fmt:formatDate value="${toDT }" pattern="yyyy년 MM월 dd일 HH시"/></div>
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
					            <p>(본 상품은 <strong class="text-red"><u>인수현장</u>에서 자차보험</strong>을 <strong class="text-red"><u>자율적</u></strong>으로 <strong class="text-red">선택</strong> 가능한 상품)</p>
					            </c:if>
					            <c:if test="${prdtVO.isrDiv eq 'ID10'}">
					            <p>자차포함 상품</p>
					            <p>(대여기간 동안의
					          	  <c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">
									  <strong class="text-red"><u>일반자차<div class="checkIsrDivGen"></div> 보험 포함</u></strong>된 상품)</p>
						      	  </c:if>
						      	  <c:if test="${prdtVO.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">
									  <strong class="text-red"><u>고급자차<div class="checkIsrDivLux"></div> 보험 포함</u></strong>된 상품</p>
						      	  </c:if>
					            </c:if>
					        	<c:if test="${prdtVO.isrDiv eq 'ID20'}">
					            <p>자차필수 상품</p>
					            <p>(본 상품은 <strong class="text-red"><u>인수현장</u>에서 자차보험</strong>을 필수로 결제해야 하는 상품)</p>
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
						가능하며, 추가요금이 발생하거나 고급자차 보험가입이
						필요할 수 있습니다.</p>
						<p>기타 문의사항은 해당업체로 연락바랍니다.</p>
						<p><c:out value="${prdtVO.corpNm}"/> : <c:out value="${prdtVO.rsvTelNum}"/></p>
					</div>
				</div> <!-- //middle-area -->
				<div class="bottom-area">
					<div class="purchase-btn-group">
						<button type="button" id="cartBtn" class="gray addcart" onclick="fn_RcAddCart();">장바구니</button>
						<button type="button" class="red gobuy" onclick="fn_RcInstantBuy();">바로구매</button>
					</div>
				</div>
			</div>
		</div> <!-- //purchase-area -->
		
		<!-- SNS 링크 -->
		<div id="sns_popup" class="sns-popup">
			<div class="popup">
				<a type="button" class="close" href="javascript:itemSingleHide('#sns_popup');" >
					<img src="<c:url value='/images/mw/rent/close-btn.png' />" loading="lazy" alt="닫기">
				</a>
				<div class="sns-area">
					<ul>
						<li>
							<a href="javascript:shareKakao('<c:out value='${prdtVO.prdtNm}'/>', '${imgUrl}', '${strUrl}'); snsCount('${prdtVO.prdtNum}', 'MO', 'KAKAO');" id="kakao-link-btn">
								<img src="<c:url value='/images/mw/icon/sns/kakaotalk.png' />" loading="lazy" alt="카카오톡">
								<span>카카오톡</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareFacebook('${strUrl}'); snsCount('${prdtVO.prdtNum}', 'MO', 'FACEBOOK');">
								<img src="<c:url value='/images/mw/icon/sns/facebook.png' />" loading="lazy" alt="페이스북">
								<span>페이스북</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareBand('${strUrl}'); snsCount('${prdtVO.prdtNum}', 'MO', 'BAND');">
								<img src="<c:url value='/images/mw/icon/sns/band.png' />" loading="lazy" alt="네이버밴드">
								<span>네이버 밴드</span>
							</a>
						</li>
						<li>
							<a href="javascript:shareLine('${strUrl}'); snsCount('${prdtVO.prdtNum}', 'MO', 'LINE'); ">
								<img src="<c:url value='/images/mw/icon/sns/line.png' />" loading="lazy" alt="라인">
								<span>라인</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div> <!-- //sns-popup -->
	</div> <!-- //mw-detail-area -->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->

<!-- 이용후기 사진 레이어 팝업 (클릭시 호출) -->
<div class="review-gallery"></div>

<!-- 면책제도안내 팝업e -->
<script type="text/javascript" src="<c:url value='/js/mw_useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_otoinq.js?version=${nowDate}'/>"></script>
<!-- SNS관련------------------------------------------->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function() {
	
		// 현대캐피탈 EV 충전카드 이용안내
		$("#hcOneCardY").click(function(){
	
			$('body').append('<div class="lock-bg"></div>');
			$('.comm-layer-popup').css('top', '50%');

			//스크롤 방지
			$('body').addClass('not_scroll');
	
			//레이어 팝업 show
			$('#application_popup').fadeToggle();
			$('#application_popup').show();
		});
	});
	
	function fn_CalRent(){
		const sFromDtView = $('#sFromDt').val().substring(0,4) + "-" + $('#sFromDt').val().substring(4,6)+ "-" + $('#sFromDt').val().substring(6,8);
		const sToDtView = $('#sFromDt').val().substring(0,4) + "-" + $('#sFromDt').val().substring(4,6)+ "-" + $('#sFromDt').val().substring(6,8);
	
		if(!checkByFromTo(sFromDtView, sToDtView, "Y")){
			window.alert('대여일의 범위가 올바르지 않습니다.');
			return;
		}
	
		var parameters = "sPrdtNum=${prdtVO.prdtNum}";
		parameters += "&sFromDt=" + $("#sFromDt").val();
		parameters += "&sFromTm=" + $("#sFromTm").val();
		parameters += "&sToDt=" + $("#sToDt").val();
		parameters += "&sToTm=" + $("#sToTm").val();
	
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/mw/rc/calRent.ajax'/>",
			data:parameters ,
			success:function(data){
	
				if(data.prdtInfo.rsvTm){
					$(".usedHourStr").html(data.prdtInfo.rsvTm + "시간");
				}
				$("#info_range").html(data.prdtInfo.rsvTm);
				$("#carSaleAmt").val(data.prdtInfo.saleAmt);
				$("#vCarSaleAmt").html(commaNum(data.prdtInfo.saleAmt));
				$("#nmlAmt").val(data.prdtInfo.nmlAmt);
				fn_TotalCmt();
	
				//쿠폰 리스트 체크
				fn_chkCouponList();

				/**자차보험여부 */
				checkIsrDiv(data.prdtInfo);
	
				// L.Point 적립 금액
				$("#lpointSavePoint").html(commaNum(parseInt((eval(data.prdtInfo.saleAmt) * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
	
				// 광고 스크립트를 위한 meta content 값 수정
	//			$("#nmlAmtId").attr('content', data.prdtInfo.nmlAmt);
	//			$("#saleAmtId").attr('content', data.prdtInfo.saleAmt);
	
				if(data.prdtInfo.ableYn == "Y" && data.prdtInfo.saleAmt > "1"){
				    $("#ableYn").val("Y")
				    $(".gobuy").text("구매하기")
					$(".warning").hide();
					$(".btn-cart").show();
	
					if(data.prdtInfo.apiRentDiv == "R"){
						if(data.prdtInfo.isrTypeDiv == "LUXY"){
							$(".isrAge").text("나이 : 만 "+ data.prdtInfo.luxyIsrAge+"세 이상");
							$(".isrCareer").text("운전경력 : "+ data.prdtInfo.luxyIsrCareer+"년 이상");
							let rewarAmt = data.prdtInfo.luxyIsrRewardAmt;
							if(data.prdtInfo.luxyIsrRewardAmt == "0" || data.prdtInfo.luxyIsrRewardAmt == "-1"){
								rewarAmt = "무제한";
							}
							$(".isrRewardAmt").text("보상한도 : "+ rewarAmt);
							$(".isrBurcha").text("고객부담금 : "+ data.prdtInfo.luxyIsrBurcha);
						}
						if(data.prdtInfo.isrTypeDiv == "GENL"){
							$(".isrAge").text("나이 : 만 "+ data.prdtInfo.generalIsrAge+"세 이상");
							$(".isrCareer").text("운전경력 : "+ data.prdtInfo.generalIsrCareer+"년 이상");
							let rewarAmt = data.prdtInfo.generalIsrRewardAmt;
							if(data.prdtInfo.generalIsrRewardAmt == "0" || data.prdtInfo.generalIsrRewardAmt == "-1"){
								rewarAmt = "무제한";
							}
							$(".isrRewardAmt").text("보상한도 : "+ rewarAmt);
							$(".isrBurcha").text("고객부담금 : "+ data.prdtInfo.generalIsrBurcha);
						}
						$("._inDetail").text(data.prdtInfo.isrAmtGuide)
					}
					$(".content-group-area").show();
	
				}else{
				    $("#ableYn").val("N")
				    $(".gobuy").text("예약마감")
				    $(".rent-info").html("해당일은 예약마감입니다. " + "<a class='text-white' href='javascript:fn_productList();'>다른차량검색</a>");
					$(".warning").html("예약마감");
					$(".warning").show();
					$(".btn-cart").hide();
					$(".content-group-area").hide();
				}
			},
			error:function(error){
				$("#ableYn").val("N")
				$(".gobuy").text("예약마감")
				$(".rent-info").html("해당일은 예약마감입니다. " + "<a class='text-white' href='javascript:fn_productList();'>다른차량검색</a>");
				$(".warning").html("예약마감");
				$(".warning").show();
				$(".btn-cart").hide();
				$(".content-group-area").hide();
			}
		});
	}
	
	/**
	 * 총합계 노출
	 */
	function fn_TotalCmt(){
		$("#totalAmt").val(parseInt($("#insuSaleAmt").val()) + parseInt($("#carSaleAmt").val()));
		$("#vTotalAmt").html(commaNum($("#totalAmt").val()) + "원");
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
	
	/**
	 *  찜하기
	 */
	function fn_RcAddPocket() {
		var pocket = [{
			prdtNum 	: "<c:out value='${prdtVO.prdtNum}'/>",
			prdtNm 		: "<c:out value='${prdtVO.prdtNm}'/> / <c:out value='${prdtVO.useFuelDivNm}'/> / <c:out value='${isrStr}'/>",
			prdtDiv 	: "${Constant.RENTCAR}",
			corpId 		: "<c:out value='${prdtVO.corpId}'/>",
			corpNm 		: "<c:out value='${prdtVO.corpNm}'/>"
		}];
		fn_AddPocket(pocket);
	}

	/* layer popup */
	// head.jsp 출력시 삭제
	function show_popup(obj){
		if($(obj).is(":hidden")){
			$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
			$('#application_popup').fadeToggle();
			$(obj).show();
			$('.comm-layer-popup').css('top', '0px');
		}else{
			$(obj).hide();
			$('.lock-bg').remove();
		}
	}
	function close_popup(obj){
		$(obj).hide();
		$('.lock-bg').remove();
		$('.not_scroll').removeClass();
	}

	function fn_RcAddCart(){
		
		/* 현대캐피탈 one-card */
		var useFuelDiv = "${prdtVO.useFuelDiv}";
		var hcOneCardYn = "";
		if(useFuelDiv != "CF04"){
			hcOneCardYn = "N"
		} else {
			hcOneCardYn = $("input:radio[name=hcOneCardYn]:checked").val();
		}
	
		var cart = [{
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
				hcOneCardYn : hcOneCardYn
	    }];
	
		fn_AddCart(cart);
	
		AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
	}
	
	function fn_RcInstantBuy(){
		
		/* 현대캐피탈 one-card */
		var useFuelDiv = "${prdtVO.useFuelDiv}";
		var hcOneCardYn = "";
		if(useFuelDiv != "CF04"){
			hcOneCardYn = "N"
		} else {
			hcOneCardYn = $("input:radio[name=hcOneCardYn]:checked").val();
		}
		
		var cart = [{
				prdtNum 	: "<c:out value='${prdtVO.prdtNum}'/>",
				prdtNm 		: "<c:out value='${prdtVO.prdtNm}'/> / <c:out value='${prdtVO.useFuelDivNm}'/> / <c:out value='${isrStr}'/>",
				prdtDivNm 	: "${Constant.RENTCAR}",
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
				hcOneCardYn : hcOneCardYn
	    }];
	
		fn_InstantBuy(cart);
	
		AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
	}
	
	function fn_productList(){
		document.frm.action = "<c:url value='/mw/rentcar/car-list.do'/>";
		document.frm.submit();
	}
	
	function fn_DetailPrdt(prdtNum){
		$("#prdtNum").val(prdtNum);
	
		document.frm.action = "<c:url value='/mw/rentcar/car-detail.do'/>";
		document.frm.submit();
	}
	
	function fn_OnchangeTime(){
		$("#sFromTm").val($("#vFromTm :selected").val());
		$("#sToTm").val($("#vToTm :selected").val());
	
		fn_CalRent();
	}
	
	//쿠폰 리스트 체크
	function fn_chkCouponList() {
		var copNum = 0;
		var amt = eval(fn_replaceAll($("#vCarSaleAmt").text(), ",", ""));
		
		$('.useCouponList').each(function() {
			if (amt < $(this).attr('minAmt')) {
				$(this).addClass('hide');
			} else {
				copNum++;			
				$(this).removeClass('hide');
			}
		});
		if (copNum == 0) {
			$("#useAbleCoupon").addClass('hide');
		} else {
			$("#useAbleCoupon").removeClass('hide');
		}
	}
	
	// 쿠폰 받기
	function fn_couponDownload(cpId, idx) {
		var parameters = "cpId=" + cpId;
	
		$.ajax({
			url:"<c:url value='/mw/couponDownload.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.result == "success") {
					$("#btnCoupon" + idx).addClass("hide");
	
					alert("<spring:message code='success.coupon.download'/>");
				} else {
					alert("<spring:message code='fail.coupon.download'/>");
				}
			},
			error: fn_AjaxError
		})
	}
	
	// 쿠폰코드 등록
	function goCouponCode() {
		if(confirm("<spring:message code='confirm.coupon.code' />")){
			location.href = "<c:url value='/mw/mypage/couponList.do' />";
		}
	}
	
	// 구매하기 클릭 시
	function fn_clicksaleBtn() {
		
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
		
	    if($("#ableYn").val() == "N"){
	        alert("해당일은 예약마감입니다.")
	        return;
		}
		if ($('#chkPurchaseFlag').val() == 0) {

			//예약하기 - 구매 전 확인 필수 - 대여 조건 셋팅
			$("#id00rentAge").html($(".isrAge").text().replace("나이 : ",""));
			if ($("#id00rentAge").html() == "undefined" || $("#id00rentAge").html() == "" || $("#id00rentAge").html() == null){
				$("#id00rentAge").html($("#popRentAge").text());
			}
			$("#id00rentCaree").html($(".isrCareer").text().replace("운전경력 : ",""));
			if ($("#id00rentCaree").html() == "undefined" || $("#id00rentCaree").html() == "" || $("#id00rentCaree").html() == null){
				$("#id00rentCaree").html($("#popRentCareer").text());
			}

			$('#chkPurchaseFlag').val(1);
			itemSingleShow('#purchase_popup');
		} else {
			fn_RcInstantBuy();
		}
	}
	
	// 1130 구매하기 레이어팝업 잠금
	function itemSingleShow(obj) {
		if($(obj).is(":hidden")) {
			$('.comm-layer-popup').animate( {'top' : '40px'}, 200);					//top이 0인경우
			$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
			$('.purchase-area').css('z-index', '100');
			$(obj).show();
			$('body').addClass('not_scroll');
		} else {
			$(obj).hide();
			$('.comm-layer-popup').css('top', '0px');								//애니에 따른 추가
		}
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

		// 공유하기 레이어팝업
		$(".icon-area > .sns-share").click(function(){

			$("#sns_popup").fadeToggle();

			$("body").addClass("not_scroll");
			$('#sns_popup').css('position', 'fixed');
			$('#sns_popup').animate( {'top' : '70%'}, 200);

			$("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경

		});

		$(".car_info_box").click(function(){

			//레이어 팝업 show
			$('#car_info_box_'+ $(this).data('id')).fadeToggle();
			$('#car_info_box_'+ $(this).data('id')).show();
		});

        // 레이어팝업 닫기 btn
		$(".close").click(function(){
			$('.purchase-area').css('z-index', '97');
			$('body').removeClass('not_scroll');
			$('#sns_popup').css('top', '80%');			//애니에 따른 추가
		});

		// 자차보험 안내 레이어팝업
		$(".question").on("click", function(e){
			layer_popup2('#question_memo', this);
		});

		//Tab Menu (상품설명, 사용조건 등)
		targetTabMenu('#scroll_tabs');
		fn_CalRent();
		
		g_UE_getContextPath = "${pageContext.request.contextPath}";
		g_UE_corpId		= "${prdtVO.corpId}";			//업체 코드 - 넣어야함
		g_UE_prdtnum 	= "${prdtVO.prdtNum}";			//상품번호  - 넣어야함
		g_UE_corpCd 	= "${Constant.RENTCAR}";
	
		fn_useepilInitUI();
		fn_useepilList();
	
		g_Oto_getContextPath = "${pageContext.request.contextPath}";
		g_Oto_corpId	= "${prdtVO.corpId}";					//업체 코드 - 넣어야함
		g_Oto_prdtnum 	= "${prdtVO.prdtNum}";					//상품번호  - 넣어야함
		g_Oto_corpCd 	= "${Constant.RENTCAR}";	//숙박/랜트.... - 페이지에 고정
	
		fn_otoinqList();
	});

	// 외부영역 클릭 시 팝업 닫기
	$(document).mouseup(function (e){
		var LayerPopup = $(".car_info_box_d");
		if(LayerPopup.has(e.target).length === 0){
			LayerPopup.hide("show");
		}
	});
</script>
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 제품상세페이지 분석코드 -->
<!-- AceCounter Mobile eCommerce (Product_Detail) v7.5 Start -->
<script language='javascript'>
var m_pd ="<c:out value="${prdtVO.prdtNm}"/>";
var m_ct ="렌터카";
var m_amt="미정";
</script>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->
</body>
</html>