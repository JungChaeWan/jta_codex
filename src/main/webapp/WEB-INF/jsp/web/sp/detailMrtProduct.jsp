<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:if test="${fn:length(prdtImg) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(prdtImg) != 0}">
	<c:set value="${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtInfo.prdtNum}&prdtDiv=${prdtInfo.prdtDiv}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}"/>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="keywordsLinkNum" value="${prdtInfo.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="description" value="${prdtInfo.prdtNm} - ${prdtInfo.prdtInf}"/>
	<jsp:param name="imagePath" value="${seoImage}"/>
	<jsp:param name="headTitle" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="area" value="${prdtInfo.areaNm}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtInfo.prdtNm}' />" />
<meta property="og:url" content="${strUrl}" />
<meta property="og:description" content="<c:out value='${prdtInfo.prdtNm}'/> - <c:out value='${prdtInfo.prdtInf}'/>" />
<c:if test="${fn:length(prdtImg) != 0}">
<meta property="og:image" content="${imgUrl}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
	<div class="mapLocation">
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<c:if test="${(fn:substring(prdtInfo.ctgr, 0,2) eq 'C1') or (fn:substring(prdtInfo.ctgr, 0,2) eq 'C4')}">
				<span>여행사 상품</span>
			</c:if>
			<c:if test="${fn:substring(prdtInfo.ctgr, 0,2) eq 'C2'}">
				<span>관광지/레저</span>
			</c:if>
			<c:if test="${fn:substring(prdtInfo.ctgr, 0,2) eq 'C3'}">
				<span>맛집</span>
			</c:if>
			<c:if test="${fn:substring(prdtInfo.ctgr, 0,2) eq 'C5'}">
				<span>유모차/카시트</span>
			</c:if>
		</div>
	</div>

	<div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
			<!-- Change Contents -->
			<div class="package2 new-detail"> <!-- add Class (new-detail) -->
				<div class="bgWrap2">
					<div class="Fasten">
						<!-- 상품정보 -->
						<div class="detail">
							<div class="detailL">
								<div class="detail-slider package">
									<div id="detail_slider" class="swiper-container">
										<div class="swiper-wrapper">
											<c:if test="${prdtInfo.lsLinkYn eq 'Y'}">
												<div class="swiper-slide"><img src="${prdtInfo.apiImgThumb}" alt="${prdtInfo.prdtNm}"></div>
											</c:if>
											<c:if test="${prdtInfo.lsLinkYn ne 'Y'}">
												<c:forEach var="prdtImg" items="${prdtImg}" varStatus="status">
												<div class="swiper-slide"><img id="imgPath${status.count}" src="${prdtImg.savePath}thumb/${prdtImg.saveFileNm}" alt="${prdtInfo.prdtNm}"></div>
												</c:forEach>
											</c:if>
										</div>
										<div id="detail_paging" class="swiper-pagination"></div>
										<div id="detail_arrow" class="arrow-area">
											<div id="detail_next" class="swiper-button-next"></div>
											<div id="detail_prev" class="swiper-button-prev"></div>
										</div>
									</div>
								</div> <!-- //detail-slider -->
							</div>
							<div class="detailR">
								<div class="pdWrap">
									<div class="title-box">
										<div class="memo"><c:out value="${prdtInfo.prdtInf}" /></div>
										<div class="title"><c:out value="${prdtInfo.prdtNm}" /></div>
										<div class="grade-area">
											<div class="score-area">
												<span class="score" id="ind_grade">평점 <strong class="text-red">3</strong>/5</span>
												<span class="icon" id="useepil_uiTopHearts">
										        </span>
											</div>
											<div class="bxLabel">
												<c:if test="${prdtInfo.eventCnt > 0}">
													<span class="main_label eventblue">이벤트</span>
												</c:if>
												<c:if test="${prdtInfo.couponCnt > 0}">
													<span class="main_label pink">할인쿠폰</span>
												</c:if>
												<c:if test="${prdtInfo.superbCorpYn == 'Y' }">
													<span class="main_label back-red">우수관광사업체</span>
												</c:if>
												<c:if test="${prdtInfo.tamnacardYn eq 'Y'}">
													<span class="main_label yellow">탐나는전</span>
												</c:if>
											</div>

											<!-- 0310 공유하기-모달팝업 -->
											<div class="icon-group">
												<button class="sns-share" type="button">
													<img src="<c:url value='/images/web/icon/sns.png' />" width="25" height="31" alt="sns">
												</button>
											<%--	<c:if test="${pocketCnt eq 0 }">
													<button type="button" onclick="javascript:fn_SpAddPocket();" id="pocketBtnId">
														<img src="<c:url value='/images/web/icon/product_like_off2.png' />" width="34" height="30" alt="찜하기">
													</button>
												</c:if>
												<c:if test="${pocketCnt ne 0 }">
													<button type="button">
														<img src="<c:url value='/images/web/icon/product_like_on2.png' />" width="34" height="30" alt="찜하기">
													</button>
												</c:if>--%>
											</div>
										</div>
										<div id="sns_popup" class="sns-popup">
											<ul class="sns-area">
												<li>
													<a href="javascript:shareStory('${strURL}')">
														<img src="/images/web/icon/sns/kakaostory.png" alt="카카오스토리">
														<span>카카오톡</span>
													</a>
												</li>
												<li>
													<a href="javascript:shareFacebook('${strURL}')">
														<img src="/images/web/icon/sns/facebook.png" alt="페이스북">
														<span>페이스북</span>
													</a>
												</li>
												<li>
													<a href="javascript:shareBand('${strURL}')">
														<img src="/images/web/icon/sns/band.png" alt="밴드">
														<span>밴드</span>
													</a>
												</li>
											</ul>
										</div><!-- //0310 공유하기-모달팝업 -->
									</div> <!-- //title-box -->
									<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
										<c:if test="${prdtInfo.linkPrdtYn eq Constant.FLAG_N}">
											<div class="package-selected">
												<ul class="prInfo">
													<li class="left"></li>
													<li class="option">
														<div class="comm-select comm-select1 open">
															<a class="select-button" id="select-button-opt1" title="상품 선택">1. 상품을 선택하세요<span></span></a>
															<ul class="select-list-option" id="firstOptionList" style="display:none">
															</ul>
														</div>
														<c:set var="idx" value="2" />
														<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
															<!--달력-->
															<form id="calendarForm">
																<input type="hidden" id="iYear" name="iYear" value='0' />
																<input type="hidden" id="iMonth" name="iMonth" value='0' />
																<input type="hidden" id="sPrevNext" name="sPrevNext" value='' />
																<input type="hidden" id="saleStartDt" name="saleStartDt" value="${prdtInfo.saleStartDt }" />
																<input type="hidden" id="saleEndDt" name="saleEndDt" value="${prdtInfo.saleEndDt}" />
																<input type="hidden" id="spDivSn" name="spDivSn">
																<input type="hidden" id="spOptSn" name="spOptSn">
															</form>

															<article class="opCal" >
																<a class="opCal-title">${idx}. 날짜를 선택하세요<span></span></a>
																<div class="packCalendar">
																	<div class="calendar" style="background-color: #f2f2f2;">
																	</div>
																</div>
															</article>
															<!--//달력-->
															<c:set var="idx" value="${idx + 1}" />
														</c:if>
														<div class="comm-select comm-select2">
															<a class="select-button" id="select-button-opt2" title="옵션 선택">${idx}. 옵션을 선택하세요</a>
															<ul class="select-list-option" id="secondOptionList" style="display:none">
															</ul>
														</div>
														<c:if test="${fn:length(addOptList) > 0 }">
															<div class="comm-select comm-select3">
																<a class="select-button" title="추가옵션 선택">${idx + 1}. 추가옵션을 선택하세요</a>
																<ul class="select-list-option" id="addOptionList" style="display:none">
																</ul>
															</div>
														</c:if>
														<!--선택항목추가-->
														<div class="qtyWrap" id="selectedItemWrapper" style="display:none">
															<ul>
															</ul>
														</div>
													</li>
												</ul>
											</div>

											<div class="purchasing-info">
												<div class="total-area">
													<!-- 기본형 -->
													<div class="tybe-A">
														<span class="text">총 상품금액</span>
														<span class="money"><strong id="totalProductAmt">0</strong>원</span>
													</div>
													<!-- //기본형 -->
												</div>

												<div class="point-area">
													<c:if test="${(not empty loginVO) and (fn:length(couponList) > 0)}">
														<div class="row hide" id="useAbleCoupon">
															<span class="col1 text-red">
																<c:forEach var="coupon" items="${couponList}" varStatus="status">
																	<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>

																	<span class="block" id="cpTitle${status.count}" showKey="${status.count}">
																		<c:if test="${not empty userCp}">
																			<c:if test="${userCp.useYn eq 'N'}">
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
																			<c:if test="${not empty coupon.cpCode}">
																				<button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:goCouponCode();">코드등록</button>
																			</c:if>
																		</c:if>
																	</span>
																</c:forEach>
															</span>
															<span class="col2">
																<c:forEach var="coupon" items="${couponList}" varStatus="status">
																	<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>

																	<span class="block useCouponList" id="useCouponNm_${status.count}" minAmt="${coupon.buyMiniAmt}" showKey="${status.count}" title="${coupon.cpNm}">
																			${coupon.cpNm}
																	</span>
																</c:forEach>
															</span>
															<span class="col3">
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
														</div>
													</c:if>
													<div class="row">
														<span class="col1">L.POINT 적립금</span>
														<span class="col2"></span>
														<span class="col3" id="lpointSavePoint">0원</span>
													</div>
												</div>
												<div class="purchase-btn-group">
													<c:choose>
														<c:when test="${(chkPointBuyAble eq 'Y') and (chkTshirts.chkTshirtsAble eq 'Y') }">		
																<button type="button" class="comm-btn red width100" onclick="fn_SpBuy();">바로구매</button>
														</c:when>
														<c:when test="${(chkPointBuyAble eq 'N') or (chkTshirts.chkTshirtsAble eq 'N') }">
															<button type="button" class="comm-btn gray width100">구매불가</button>
														</c:when>
													</c:choose>
												</div>
											</div> <!-- //purchasing-info -->
										</c:if>
										<c:if test="${prdtInfo.linkPrdtYn ne Constant.FLAG_N}">
											<div class="purchasing-info single">
												<div class="total-area border-hide">
													<!-- 기본형 -->
													<div class="tybe-A">
														<span class="text">총 상품금액</span>
														<span class="money"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${prdtInfo.saleAmt}" /></strong>원</span>
													</div>
													<!-- //기본형 -->
												</div>
												<li class="button" style="text-align: right;">
													<a href="http://coupon.hijeju.or.kr?SCID=tamnao" target="_blank"><img src="/images/web/button/payment3.gif" alt="현장결제"></a>
													<a href="${prdtInfo.linkUrl}" target="_blank"><img src="/images/web/button/payment4.gif" alt="바로결제"></a>
												</li>
											</div>
										</c:if>
									</c:if>
									<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
										<div class="purchasing-info">
											<li class="button" style="text-align: right;">
												<a href="javascript:printCoupon();" class="layer-1"><img src="/images/web/button/print.gif" alt="인쇄하기"></a>
												<a href="javascript:showSendEmail();" class="layer-1"><img src="/images/web/button/email2.gif" alt="이메일로 받기"></a>
												<div class="layerP1 mail-form">
													<img src="/images/web/icon/bubble.png" class="bubble" alt="말풍선" height="7" width="11">
													<table class="commRow">
														<tr>
															<th>받는메일</th>
															<td><input type="text" id="reciver" class="full" placeholder="이메일 주소 입력"></td>
														</tr>
													</table>
													<p class="comm-button1">
														<a href="javascript:sendFreeCoupon();" class="color1">보내기</a>
														<a href="javascript:hideSendEmail();">취소</a>
													</p>
													<a href="javascript:hideSendEmail();"><img src="/images/web/icon/close2.gif" class="layerP1-close" alt="닫기"></a>
												</div>

												<input type="image" src="/images/web/button/mypage2.gif" alt="마이페이지 저장" onClick="saveInterestProduct(); return false;">
											</li>
										</div>
									</c:if>
								</div>
							</div>
						</div>
						<!-- 탭 정보 (이용안내, 취소/환불규정 등등) -->
						<div id="tabs" class="nav-tabs2">
							<ul class="menuList">
								<li class="active"><a href="#tabs-1">상품설명</a></li>
								<li><a href="#tabs-3">사용정보</a></li>
								<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
									<li><a href="#tabs-2">취소/환불</a></li>
								</c:if>
								<c:if test="${fn:substring(prdtInfo.ctgr, 0, 2) ne 'C1' and prdtInfo.ctgr ne 'C420' }">
									<li><a href="#tabs-4">위치보기</a></li>
								</c:if>
								<li><a href="#tabs-5">이용후기</a></li>
								<li><a href="#tabs-6">1:1문의</a></li>
							</ul>
							<!--상품설명-->
							<div id="tabs-1" class="tabPanel">
								<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
									<div class="sale-couponWrap2" >
										<table width="674" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td><img src="/images/web/coupon/top.jpg" alt="쿠폰 상단"></td>
											</tr>
											<tr>
												<td style="border-left:1px solid #d9d9d9; border-right:1px solid #d9d9d9; padding: 0 30px; text-align: center;">
													<h3 class="name"><c:out value="${prdtInfo.prdtNm}"/></h3>
													<p class="sale"><c:out value="${prdtInfo.disInf}" /></p>
													<p class="date">유효기간 :<fmt:parseDate value="${prdtInfo.exprStartDt}" var="exprStartDt"	pattern="yyyyMMdd" />
														<fmt:parseDate value="${prdtInfo.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd" />
														<fmt:formatDate value="${exprStartDt}" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${exprEndDt}" pattern="yyyy.MM.dd" />
													</p>
												</td>
											</tr>
											<tr>
												<td><img src="/images/web/coupon/bottom.jpg" alt="쿠폰 하단"></td>
											</tr>
										</table>
									</div>
								</c:if>

								<div class="type-bodyA">
									<c:if test="${fn:length(prmtList) > 0}">
										<!-- 프로모션 추가 -->
										<c:forEach items="${prmtList }" var="prmt">
											<div class="promotion-detail">
												<div class="text-area">
													<dl>
														<dt class="title">${prmt.prmtNm}</dt>
														<dd>
															<ul>
																<li class="align-right">
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
												<c:if test="${not empty fn:trim(prmt.dtlImg)}">
													<div class="photo">
														<img src='<c:url value="${prmt.dtlImg}" />' alt="${prmt.prmtNm}">
													</div>
												</c:if>
											</div> <!-- //promotion-detail -->
										</c:forEach>
										<!-- //프로모션 추가 -->
									</c:if>

									<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
										<c:if test="${not empty prdtInfo.adMov}">
											<div class="video-area">
												<iframe width="740" height="276" src="${prdtInfo.adMov}" allowfullscreen></iframe>
											</div>
										</c:if>
									</c:if>
									<!-- 상세 이미지 -->
									<c:if test="${prdtInfo.lsLinkYn ne 'Y'}">
											<c:if test="${not empty dtlImg[0].savePath}">
											<div class="detail-photo old">
												<img src="${dtlImg[0].savePath}${dtlImg[0].saveFileNm}" class="full" alt="상품설명">
											</div>
											</c:if>
									</c:if>
									<c:if test="${prdtInfo.lsLinkYn eq 'Y'}">
										<c:forTokens items="${prdtInfo.apiImgDetail}" delims="||" var="item">
											<div class="detail-photo old">
												<img src="${item}" class="full" alt="상품설명">
											</div>
										</c:forTokens>
									</c:if>

									<%-- 상세정보 --%>
									<c:if test="${empty infoBgColor}">
										<c:set value="2e4b55" var="varBgColor"/>
									</c:if>
									<c:if test="${not empty infoBgColor}">
										<c:set value="${infoBgColor}" var="varBgColor"/>
									</c:if>

									<c:if test="${(fn:length(dtlInfList) != 0)}">
										<div class="product-detailInfo" style="background: #${infoBgColor}">
											<c:forEach var="data" items="${dtlInfList}" varStatus="status">
												<c:if test="${data.dtlinfType == 'B'}">
													<!-- 소셜기본폼양식 -->
													<div class="item-area">
														<div class="product-title"><strong><c:out value="${data.subject}"/></strong></div>
														<div class="type-body3"><p><c:out value="${data.dtlinfExp}" escapeXml="false"/></p></div>

														<c:forEach var="item" items="${data.spDtlinfItem}" varStatus="status1">
															<div class="type-area item">
																<div class="title-area">
																	<strong>선택 ${status1.count}</strong>
																</div>
																<div class="text-area">
																	<strong class="title"><c:out value="${item.itemNm}"/></strong>
																	<ul>
																		<li>
																			<div class="names"></div>
																			<div class="price">
																				<c:if test="${(item.itemAmt eq item.itemDisAmt) or (empty item.itemDisAmt)}">
																					<div class="sale"><fmt:formatNumber value="${item.itemAmt}"/> <small>원</small></div>
																				</c:if>
																				<c:if test="${(item.itemAmt ne item.itemDisAmt) and (not empty item.itemDisAmt)}">
																					<div class="cost"><del><fmt:formatNumber value="${item.itemAmt}"/> 원</del></div>
																					<div class="sale"><fmt:formatNumber value="${item.itemDisAmt}"/> <small>원</small></div>
																				</c:if>
																			</div>
																		</li>
																	</ul>
																	<div class="memo"><c:out value="${item.itemEtc}" escapeXml="false"/></div>
																</div>
															</div> <!-- //type-area -->
														</c:forEach>
													</div> <!-- //product-detailInfo -->
													<!-- //소셜기본폼양식 -->
												</c:if>
											</c:forEach>
										</div> <!-- //product-detailInfo -->
									</c:if>

									<c:if test="${prdtInfo.lsLinkYn ne 'Y'}">
									<c:if test="${not empty dtlImg[0].savePath}">
									<div class="detail-photo old">
										<c:forEach var="dtlImg" items="${dtlImg}" varStatus="status">
											<c:if test="${status.index != 0}">
												<img src="${dtlImg.savePath}${dtlImg.saveFileNm}" class="full" alt="상품설명">
											</c:if>
										</c:forEach>
									</div>
									</c:if>
									</c:if>

									<c:if test="${(not empty SP_GUIDINFOVO) and (SP_GUIDINFOVO.printYn eq Constant.FLAG_Y)}">
										<div class="product-detailInfo margin-top20" style="background: #${infoBgColor}">
											<div class="info-area item">
												<h3 class="title">안내사항</h3>
												<div class="table-area">
													<table class="table-row">
														<caption>상품관련 안내사항 내용입니다.</caption>
														<colgroup>
															<col style="width: 25%">
															<col>
														</colgroup>
														<tbody>
														<tr>
															<th>문의전화</th>
															<td><c:out value="${SP_GUIDINFOVO.telnum}"/></td>
														</tr>
														<tr>
															<th>주소지</th>
															<td>
																<c:out value="${SP_GUIDINFOVO.roadNmAddr}"/>
																<c:out value="${SP_GUIDINFOVO.dtlAddr}"/>
															</td>
														</tr>
														<c:if test="${not empty SP_GUIDINFOVO.prdtExp}">
															<tr>
																<th>상품설명</th>
																<td><c:out value="${SP_GUIDINFOVO.prdtExp}" escapeXml="false"/></td>
															</tr>
														</c:if>
														<c:if test="${not empty SP_GUIDINFOVO.useQlfct}">
															<tr>
																<th>사용조건</th>
																<td><c:out value="${SP_GUIDINFOVO.useQlfct}" escapeXml="false"/></td>
															</tr>
														</c:if>
														<c:if test="${not empty SP_GUIDINFOVO.useGuide}">
															<tr>
																<th>이용안내</th>
																<td><c:out value="${SP_GUIDINFOVO.useGuide}" escapeXml="false"/></td>
															</tr>
														</c:if>
														<c:if test="${not empty SP_GUIDINFOVO.cancelRefundGuide}">
															<tr>
																<th>취소/환불 안내</th>
																<td><c:out value="${SP_GUIDINFOVO.cancelRefundGuide}" escapeXml="false"/></td>
															</tr>
														</c:if>
														</tbody>
													</table>
												</div>
											</div> <!-- //info-area -->
										</div> <!-- //product-detailInfo -->
									</c:if>
								</div>
							</div> <!-- //tabs-1 -->

							<!--사용조건-->
							<div id="tabs-3" class="tabPanel">
								<div class="type-bodyA">
									<c:if test="${fn:length(prdtInfo.useQlfct) > 0}">
										<dl class="typeA">
											<dt>안내사항</dt>
											<dd><c:out value="${prdtInfo.useQlfct}" escapeXml="false"/></dd>
										</dl>
									</c:if>
								</div>
							</div>

							<!-- 환불규정 -->
							<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
								<div id="tabs-2" class="tabPanel">
									<div class="type-bodyA">
										<dl class="typeA">
											<dt>취소/환불</dt>
											<dd>
												<c:if test="${empty prdtInfo.cancelGuide}">
													<p class="no-content">취소/환불 규정이 없습니다.</p>
												</c:if>
												<c:if test="${not empty prdtInfo.cancelGuide}">
													<c:out value="${prdtInfo.cancelGuide}" escapeXml="false"/>
												</c:if>
											</dd>
										</dl>
										<dl class="typeA">
											<dt>판매처 정보</dt>
											<dd>
												<div class="float-content distributor">
													<div class="l-area icon">
														<c:if test="${prdtInfo.superbCorpYn eq 'Y'}">
															<img class="excellence" src="/images/web/icon/excellence_02.jpg" alt="우수관광사업체">
														</c:if>
														<c:if test="${empty prdtInfo.adtmImg}">
															<img src="/images/web/comm/no_image.jpg" alt="ci">
														</c:if>
														<c:if test="${not empty prdtInfo.adtmImg}">
															<img src="${prdtInfo.adtmImg}" alt="ci">
														</c:if>
													</div>
													<div class="r-area text">
														<p>판매자명 : <c:out value="${prdtInfo.shopNm}" /></p>
														<p><c:out value="${prdtInfo.adtmSimpleExp}"/></p>
														<p>전화번호 : <c:out value="${prdtInfo.rsvTelNum}"/></p>
                                                        <c:if test="${not empty prdtInfo.adtmUrl && !fn:contains(prdtInfo.adtmUrl,'tamnao.com')}">
                                                            <p>홈페이지 : <a href="${prdtInfo.adtmUrl}" target="_blank">${prdtInfo.adtmUrl}</a></p>
                                                        </c:if>
													</div>
												</div>
											</dd>
										</dl>
										<c:if test="${not empty prdtInfo.visitMappingId}">
											<dl class="typeA">
												<dt>주변 관광지 알아보기</dt>
												<dd>
													<a href="https://www.visitjeju.net/kr/detail/view?contentsid=${prdtInfo.visitMappingId}&newopen=yes#tmap" class="link" target="_blank">
														<img src="/images/web/institution/visit-jeju.jpg" alt="visit jeju">
													</a>
												</dd>
											</dl>
										</c:if>
									</div>
								</div> <!-- //tabs-2 -->
							</c:if>

							<c:if test="${(fn:substring(prdtInfo.ctgr, 0, 2) ne 'C1') and (prdtInfo.ctgr ne 'C420')}">
								<!-- 위치 정보-->
								<div id="tabs-4" class="tabPanel">
									<div class="type-bodyA">
										<dl class="typeA">
											<dt>위치보기</dt>
											<dd>
												<c:if test="${(empty prdtInfo.lat) or (empty prdtInfo.lon)}">
													<p class="no-content">위치 정보가 없습니다.</p>
												</c:if>

												<c:if test="${(not empty prdtInfo.lat) and (not empty prdtInfo.lon)}">
													<!--여기다 추가-->
													<div class="mapWrap">
														<div id="mapTab" class="map"></div>
													</div>
													<script type="text/javascript">
														//동적 지도 ( 움직이는 지도.)
														var container = document.getElementById("mapTab");
														var options = {
															center: new daum.maps.LatLng(${prdtInfo.lat}, ${prdtInfo.lon}),
															level: 3
														};
														var map = new daum.maps.Map(container, options);
														//마커가 표시될 위치입니다
														var markerPosition  = new daum.maps.LatLng(${prdtInfo.lat}, ${prdtInfo.lon});
														// 마커를 생성합니다
														var marker = new daum.maps.Marker({
															position: markerPosition
														});
														// 마커가 지도 위에 표시되도록 설정합니다
														marker.setMap(map);
													</script>
												</c:if>
											</dd>
										</dl>
									</div>
								</div> <!-- //tabs-4 -->
							</c:if>
							<!--이용후기-->
							<div id="tabs-5" class="tabPanel"></div>
							<!-- //tabs-5 -->
							<!--1:1문의-->
							<div id="tabs-6" class="tabPanel"></div>
							<!-- //tabs-6 -->
						</div> <!--//tabs-->

					</div> <!--//Fasten-->
				</div> <!--//bgWrap-->
			</div> <!-- //new-detail -->
			<!-- //Change Contents -->
		</div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<script type="text/javascript" src="<c:url value='/js/useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bloglink.js?version=${nowDate}'/>"></script>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/printThis.js'/>"></script>
<script type="text/javascript">

	var productCount = 0;			// 상품 수
	var optionCount = 0;			// 옵션 수
	var addOptionCount = 0;			// 추가옵션 수
	
	//공유하기-모달팝업
	$(document).ready(function () {
	
		isShow = true;
	
		$('.sns-share').click(function () {
			if(isShow) {
				isShow = false;
	
				$('#sns_popup').show();
			}else {
				isShow = true;
	
				$('#sns_popup').hide();
			}
		})
	});
	
	
	function getSecondOption(spDivSn, aplDt) {
		$("#secondOptionList").empty();
	
		/*	
	 	$(".sns-popup").on("click", function() {
			$(this).addClass('on');
		});
		*/
		
		$.ajax({
			url: "<c:url value='/web/sp/getOptionList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}&spDivSn=" + spDivSn + "&aplDt=" + aplDt,
			success:function(data) {
				var list = data.list;
				var dataArr;
				var count = 1;
				var inx = 0;
	
				if(list != "") {
					optionCount = list.length;
	
					$(list).each(function(){
						if(this.stockNum > 0 && this.ddlYn == "N") {
							dataArr = "<li>";
							dataArr += "<a href='javascript:;' data-raw='' title='" + this.optNm +"'>";
							dataArr += "<p class='product'>";
							dataArr += "<span>[선택" + count + "]" + fn_addDate(this.aplDt) +  " " + this.optNm + "</span>";
							if("${prdtInfo.prdtDiv}" != "COUP"){
								dataArr += "<span class='count'> | 잔여 : " + commaNum(this.stockNum) + "개</span>";
							}
							dataArr += "</p>";
							dataArr += "<span class='option_price'>";
							if(this.nmlAmt != this.saleAmt){
								dataArr += "<del>" + commaNum(this.nmlAmt) + "</del>";						
							}						
							dataArr += "<p class='price'>" + commaNum(this.saleAmt) + "</p>";
							dataArr += "</span>";
							dataArr += "</a>";
							dataArr += "</li>";
						} else {
							dataArr = "<li>";
							dataArr += "<p class='product'>";
							dataArr += "<span>[선택" + count + "]" + fn_addDate(this.aplDt) + " " + this.optNm + "</span>";
							// dataArr += "<span class='count'> | 잔여 : " + commaNum(this.stockNum) + "개</span>";
							dataArr += "</p>";
							dataArr += "<p class='price'>품절</p>";
							dataArr += "</li>";
						}
						$("#secondOptionList").append(dataArr);
						$("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
						count++;
						inx++;
					});
	
					$(".comm-select").removeClass("open");
	
					<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
						$(".opCal").removeClass("open");
					</c:if>
					
					//$(".comm-select2").addClass("open");				//자동open 해제
					$(".comm-select .select-list-option").css("display", "none");
					//$("#secondOptionList").css("display", "block");	//자동open 해제
					$("#secondOptionList").css("display", "none");
				}
			},
			error: fn_AjaxError
		});
	}
	
	function getCalOption() {
		var calP = $("#calendarForm").serialize();
	
		$.ajax({
			url: "<c:url value='/web/sp/getCalOptionList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}&" + calP,
			success:function(data) {
				$(".comm-select .select-list-option").css("display", "none");
				$(".comm-select").removeClass("open");
	
				$(".opCal").addClass("open");
				$(".opCal .calendar").html(data);
				//$(".packCalendar").css("display", "block");	//자동open 해제
				$(".packCalendar").css("display", "block");
				
				$("#iYear").val($(".calY1").text().replace(".", ""));
				$("#iMonth").val($(".calM1").text());
	
				/*/!**시티투어 야간특별처리*!/
				if($("#iMonth").val() == "7" && "${prdtInfo.prdtNum}" == "SP00001434") {
					nextCalendar();
				}*/
			},
			error: fn_AjaxError
		});
	}
	
	function nextCalendar() {
		$("#sPrevNext").val("next");
	
		getCalOption();
	}
	
	function prevCalendar() {
		$("#sPrevNext").val("prev");
	
		getCalOption();
	}
	
	/** 달력 옵션 선택시 */
	function selectCalOption(selectDay, obj) {
		$(".opCal-title").html("2. 선택날짜 : <span></span>");
		$(".opCal-title span").text(getDayFormat(selectDay, "."));
		$(".opCal-title span").addClass("text-red");
		$(".packCalendar table>tbody>tr>td>a").removeClass("select");
		$(obj).addClass("select");
		
		$(".packCalendar").css("display", "none");	//자동open 해제
		
		getSecondOption($("#spDivSn").val(), selectDay);
	}
	
	/** 옵션선택시 */
	function getAddOption() {
		if($("#addOptionList").css("display") == "block") {
			$(".comm-select .select-list-option").css("display", "none");
			return ;
		}
		if($("#addOptionList li").length > 0) {
			if($("#addOptionList").css("display") == "none") {
				$(".comm-select .select-list-option").css("display", "none");
				$("#addOptionList").css("display", "block");
			}
			$(".comm-select").removeClass("open");
			$(".comm-select3").addClass("open");
			return false;
		}
		
		var b_data = {
			addOptNm	: "",
			addOptAmt	: 0,
			addOptSn	: ""
		};
	
		$.ajax({
			url: "<c:url value='/web/sp/getAddOptList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}",
			success:function(data) {
				var dataArr = "<li><a href='javascript:;' data-raw='' title=''><p class='product'><span>선택안함</span></p></a></li>";
	
				$("#addOptionList").append(dataArr);
	
				var list = data.list;
				var inx = 1;
	
				if(list != "") {
					addOptionCount = list.length;
	
					$(list).each(function(){
						dataArr = "<li>";
						dataArr += "<a href='javascript:;' data-raw='' title='" + this.addOptNm + "'>";
						dataArr += "<p class='product'><span>" + this.addOptNm + "</span></p>";
						dataArr += "<p class='price'>";
						if(this.addOptAmt > 0) {
							dataArr += commaNum(this.addOptAmt);
						}
						dataArr += "</p>";
						dataArr += "</a>";
						dataArr += "</li>";
	
						$("#addOptionList").append(dataArr);
						$("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
						inx++;
					});
	
					$("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data));
				}
			},
			error: fn_AjaxError
		});
	
		$(".comm-select").removeClass("open");
	
		<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
			$(".opCal").removeClass("open");
		</c:if>
		
		//$(".comm-select3").addClass("open");			//자동open 해제
		$(".comm-select .select-list-option").css("display", "none");
		//$("#addOptionList").css("display", "block");	//자동open 해제
		$("#addOptionList").css("display", "none");
	}
	
	/** 총합계 */
	function selectedItemSaleAmt() {
		var price = 0;
	
		$("#selectedItemWrapper .price").each(function() {
			price = price +  Number(fn_replaceAll($(this).text(), ",", ""));
		});
	
		$("#totalProductAmt").html(commaNum(price));
		$("#lpointSavePoint").html(commaNum(parseInt((price * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
		// 쿠폰리스트 체크
		fn_chkCouponList();
	}
	
	/** 찜한 상품 */
	function fn_SpAddPocket(){
		var pocket = [{
			prdtNum		: "<c:out value='${prdtInfo.prdtNum}'/>",
			prdtNm		: "<c:out value='${prdtInfo.prdtNm}'/>",
			corpId		: "<c:out value='${prdtInfo.corpId}'/>",
			corpNm		: "<c:out value='${prdtInfo.corpNm}'/>",
			prdtDiv		: "${Constant.SOCIAL}",
			spDiv		: "${prdtInfo.ctgr}"
		}];
	
		fn_AddPocket(pocket);
	}
	
	/** 즉시구매 */
	function fn_SpBuy() {
		
		var items = $("#selectedItemWrapper ul>li");
	
		if(items.length == 0) {
			alert("상품을 선택해주세요.")
			return ;
		}
		var cart = [];
	
		items.each(function(){
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));

			let loopCnt = $(this).find(".list2 .qty-input").val();

			for(let i = 0; i<loopCnt; i++){
				cart.push({
					prdtNum		: "<c:out value='${prdtInfo.prdtNum}'/>",
					prdtNm		: "<c:out value='${prdtInfo.prdtNm}'/>",
					prdtDivNm	: "<c:out value='${prdtInfo.ctgrNm}'/>",
					corpId		: "<c:out value='${prdtInfo.corpId}'/>",
					corpNm		: "<c:out value='${prdtInfo.corpNm}'/>",
					nmlAmt		: 0,
					qty			: 1,
					spOptSn		: dataRaw.spOptSn,
					spDivSn		: dataRaw.spDivSn,
					addOptAmt	: dataRaw.addOptAmt,
					addOptNm	: dataRaw.addOptNm,
					imgPath		: $("#imgPath1").attr("src")
				});
				console.log("for int :::" + i );
			}
		});
		fn_InstantBuy(cart);
	}
	
	function checkDupOption(newData) {
		var result = false;
	
		$("#selectedItemWrapper ul>li").each(function() {
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			if((newData.spDivSn == dataRaw.spDivSn) && (newData.spOptSn == dataRaw.spOptSn)) {
				// 추가옵션 체크
				if(typeof newData.addOptSn == "undefined") {
					result = true;
					return;
				} else {
					if(newData.addOptSn == dataRaw.addOptSn) {
						result = true;
						return;
					}
				}
			}
		});
	
		return result;
	}
	
	function fn_clickTab(nTab) {
		$("#tabs ul li a").eq(nTab).trigger("click");
		location.href = "#tabs";
	}
	
	//쿠폰 리스트 체크
	function fn_chkCouponList() {
		var copNum = 0;
		var amt = eval(fn_replaceAll($("#totalProductAmt").text(), ",", ""));
	
		$(".useCouponList").each(function() {
			if (amt < $(this).attr("minAmt")) {
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
	
	// 쿠폰 받기
	function fn_couponDownload(cpId, idx) {
		var parameters = "cpId=" + cpId;
	
		$.ajax({
			url: "<c:url value='/mw/couponDownload.ajax'/>",
			data: parameters,
			success:function(data) {
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
	
	// 쿠폰코드 등록
	function goCouponCode() {
		if(confirm("<spring:message code='confirm.coupon.code' />")){
			location.href = "<c:url value='/web/mypage/couponList.do' />";
		}
	}
	
	function showSendEmail() {
		$(".mail-form").show();
	}
	
	function hideSendEmail() {
		$(".mail-form").hide();
	}
	
	function sendFreeCoupon() {
		var email = $("#reciver").val();
	
		if(email == "") {
			alert("이메일을 입력해주세요.");
			return ;
		}
		if(!fn_is_email(email)) {
			alert("이메일 형식이 맞지 않습니다.");
			return ;
		}
		$.ajax({
			url: "<c:url value='/web/sp/freeCouponMail.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}&email=" + email,
			success:function(data) {
				alert("이메일을 성공적으로 보냈습니다.");
	
				hideSendEmail();
	
				$("#reciver").val("");
			},
			error: fn_AjaxError
		});
	}
	
	function saveInterestProduct() {
		$.ajax({
			url: "<c:url value='/web/mypage/saveInterestProduct.ajax'/>",
			data: "itrPrdtNum=${prdtInfo.prdtNum}",
			dataType: "json",
			success:function(data) {
				alert("마이페이지에 저장했습니다.");
			},
			error: fn_AjaxError2
		});
	}
	
	function printCoupon() {
		$(".sale-couponWrap2").printThis({
			importCSS: true
		});
	}
	
	//총 신청인원 체크
	function fn_totQtyCheck(val) {
		
		var items = $("#selectedItemWrapper ul>li");
		let totQty = 0;
		items.each(function(){
			totQty += Number($(this).find(".list2 .qty-input").val());
		});
		
		if(val == "p"){
			totQty = totQty + 1;
		} else {
			totQty = totQty - 1;
		}
		
		//console.log(totQty);
		if(totQty > 10) {
			alert("총 10명 까지 신청이 가능합니다.");
			return false;
		}
		
		return true;
	}
	
	$(document).ready(function() {
		$(".gallery-view1 .carousel").jCarouselLite({
			btnNext: ".gallery-view1 .next",
			btnPrev: ".gallery-view1 .prev",
			speed: 300,
			visible: 5,
			circular: false
		});
	
		$(".gallery-view1 .carousel img").click(function() { //이미지 변경
			$(".gallery-view1 .mid img").attr("src", $(this).attr("src"));
		});
	
		$(".gallery-view1 .carousel li").click(function(){ //class 추가
			$(".gallery-view1 .carousel li").removeClass("select");
			$(this).addClass("select");
		});

		// 상품을 선택하세요
		$(".comm-select1 .select-button").click(function(){
			if($("#firstOptionList").css("display") == "block") {
				$(".comm-select .select-list-option").css("display", "none");
				return ;
			}
	
			if($("#firstOptionList li").length > 0) {
				if($("#firstOptionList").css("display") == "none") {
					$(".comm-select .select-list-option").css("display", "none");
					$("#firstOptionList").css("display", "block");
				}
				$(".comm-select").removeClass("open");
	
				<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
					$(".opCal").removeClass("open");
				</c:if>
				$(".comm-select1").addClass("open");
	
				return false;
			}
	
			$.ajax({
				url: "<c:url value='/web/sp/getDivInfList.ajax'/>",
				data: "prdtNum=${prdtInfo.prdtNum}",
				success:function(data) {
					var list = data.list;
					var dataArr;
					var count = 1;
					var inx = 0;
	
					if(list != "") {
						productCount = list.length;
	
						$(list).each( function() {
							dataArr = "<li>";
							dataArr += "<a href='javascript:;' data-raw='' title='" + this.prdtDivNm + "'>";
							dataArr += "<p class='product'><span>[선택" + count + "]</span><span>" + this.prdtDivNm + "</span></p>";
							dataArr += "</a>";
							dataArr += "</li>";
	
							$("#firstOptionList").append(dataArr);
							$("#firstOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
							count++;
							inx++;
						});
	
						$(".comm-select .select-list-option").css("display", "none");
						$(".comm-select1 .select-list-option").css("display", "block");
	
						/*if(productCount == 1) {
							//자동open 해제
							//$("#firstOptionList li:eq(0)>a").trigger("click");			// 1개 상품 경우 자동선택
						}else if(productCount > 1){
							$(".comm-select1").addClass("open");						// 2개 이상 상품일 경우 open
						}else {
							$(".comm-select1 .select-button").trigger("click");
						}*/
					}
				},
				error: fn_AjaxError
			})
		});
	
		// 상품 목록 펼침
		//$(".comm-select1 .select-button").trigger("click");
	
		// 상품 선택
		$("#firstOptionList").on("click", "li>a", function() {
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
			var title = $(this).attr("title");
	
			$("#spDivSn").val(dataRaw.spDivSn);
	
			$(".comm-select1 .select-button").html("1. 선택상품 : <span></span>");
			$(".comm-select1 .select-button span").text(title);
			$(".comm-select1 .select-button span").addClass("text-red");
	
			$("#secondOptionList").empty();
	
			<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
				$("#sPrevNext").val("");
	
				getCalOption();
			</c:if>
			<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR}">
				getSecondOption(dataRaw.spDivSn, "");
			</c:if>
		});
	
		// 날짜를 선택하세요
		$(".opCal-title").click(function(){
			if($(".packCalendar").css("display") == "block") {
				$(".packCalendar").css("display", "none");
	
				if($("#secondOptionList li").length > 0 && $(".comm-select2").css("display") == "block") {
					$(".opCal").removeClass("open");
					$(".comm-select2").addClass("open");
				}
			} else {
				if($(".calendar div").length > 0) {
					$(".packCalendar").css("display", "block");
					$(".comm-select").removeClass("open");
					$(".opCal").addClass("open");
				}
			}
		});
	
		// 옵션을 선택하세요
		$(".comm-select2 .select-button").click(function(){
			
			if($("#secondOptionList").css("display") == "block") {
				$("#secondOptionList").css("display", "none");
			} else {
				if($("#secondOptionList li").length > 0) {
					if($("#addOptionList").css("display") == "block") {
						$("#addOptionList").css("display", "none");
					}
					$("#secondOptionList").css("display", "block");
					$(".comm-select").removeClass("open");
					$(".comm-select2").addClass("open");
				}
			}
		});
	
		// 옵션 선택
		$("#secondOptionList").on("click", "li>a", function(){
			
			var items = $("#selectedItemWrapper ul>li");
			let totQty = 1;
			items.each(function(){
				totQty += Number($(this).find(".list2 .qty-input").val());
			});
			if(totQty > 10) {
				alert("총 10명 까지 신청이 가능합니다.");
				return false;
			}
			
			var dataRaw =  jQuery.parseJSON($(this).attr("data-raw"));
			var ori_dataRaw = $(this).attr("data-raw");
			var firstOptionText = $(".comm-select1 .select-button span").text();
			var secondOptionText = $(this).attr("title");
			
			// 추가옵션 유무
			if("${fn:length(addOptList)}" == 0) {
				if(checkDupOption(dataRaw)) {
					alert("<spring:message code='fail.product.duplication'/>");
	
					$(".comm-select .select-list-option").css("display", "none");
					return;
				}
				var text = "<li class='qty-list'>";
				text += "<ol>";
				text += "<li class='list1'>";
				text += firstOptionText;
	
				if(dataRaw.aplDt != null) {
					text += "<br>- " + fn_addDate(dataRaw.aplDt);
				}
				text += "<br>- " + secondOptionText;
				text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
				text += "</li>";
				text += "<li class='list2'>";
				text += "<input type='text' value='1' class='qty-input'><button class='addition'>+</button><button class='subtract'>-</button>";
				text += "</li>";
				text += "<li class='list3'>";
				text += "<span class='price'>" + commaNum(dataRaw.saleAmt) + "</span>";
				text += "<a href='javascript:;'><span class='del'><img src='/images/web/icon/close/selected.png' alt='삭제'></span></a>";
				text += "</li>";
				text += "</ol>";
				text += "</li>";
	
				$("#selectedItemWrapper ul").append(text);
				$("#selectedItemWrapper ul>li").last().attr("data-raw", ori_dataRaw);
				$("#selectedItemWrapper").css("display", "block");
				
				<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR}">
					if(productCount > 1) {
						if(optionCount == 1) {
							$(".comm-select").removeClass("open");
							$(".comm-select1 .select-button").html("1. 상품을 선택하세요");
							$(".comm-select2 .select-button").html("2. 옵션을 선택하세요");
							$("#secondOptionList").empty();
						}
					}
				</c:if>
				<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
					if(optionCount == 1) {
						$(".comm-select").removeClass("open");
						$(".packCalendar table>tbody>tr>td>a").removeClass("select");
						$(".opCal-title").html("2. 날짜를 선택하세요");
						$(".comm-select2 .select-button").html("3. 옵션을 선택하세요");
						$("#secondOptionList").empty();
					}
				</c:if>
				$(".comm-select .select-list-option").css("display", "none");
	
				selectedItemSaleAmt();
			} else {
				getAddOption();
	
				$("#addOptionList").attr("data-raw", ori_dataRaw);
				$(".comm-select2 .select-button").html("2. 선택옵션 : <span></span>");
				$(".comm-select2 .select-button span").text(secondOptionText);
				$(".comm-select2 .select-button span").addClass("text-red");
			}
		});
	
		// 추가 옵션을 선택하세요
		$(".comm-select3 .select-button").click(function(){
			if($("#addOptionList").css("display") == "block") {
				$("#addOptionList").css("display", "none");
			} else {
				if($("#addOptionList li").length > 0) {
					$("#addOptionList").css("display", "block");
					$(".comm-select").removeClass("open");
					$(".opCal").removeClass("open");
					$(".comm-select3").addClass("open");
				}
			}
		});
	
		// 추가 옵션 선택
		$("#addOptionList").on("click", "li>a", function() {
			var dataRaw =  jQuery.parseJSON($("#addOptionList").attr("data-raw"));
			var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			dataRaw.addOptAmt = thisDataRaw.addOptAmt;
			dataRaw.addOptNm = thisDataRaw.addOptNm;
			dataRaw.addOptSn = thisDataRaw.addOptSn;
	
			var ori_dataRaw = JSON.stringify(dataRaw);
	
			var firstOptionText = $(".comm-select1 .select-button span").text();
			var secondOptionText = $(".comm-select2 .select-button span").text();
			var addOptionText = $(this).attr("title");
	
			if(checkDupOption(dataRaw)) {
				alert("<spring:message code='fail.product.duplication'/>");
				return ;
			}
			var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);
			// 2016-01-17, 잔여수가 없어져버려서 수량 변경 기능이 오작동됨.. 롤백(by ezham)
			var text = "<li class='qty-list'>";
			text += "<ol>";
			text += "<li class='list1'>";
			text += firstOptionText;
	
			if(dataRaw.aplDt != null) {
				text += "<br>- " + fn_addDate(dataRaw.aplDt);
			}
			text += "<br>- " + secondOptionText;
	
			if(addOptionText != "") {
				text += "<br>- " + addOptionText;
			}
			text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
			text += "</li>";
			text += "<li class='list2'>";
			text += "<input type='text' value='1' class='qty-input'><button class='addition'>+</button><button class='subtract'>-</button>";
			text += "</li>";
			text += "<li class='list3'>";
			text += "<span class='price'>" + commaNum(saleAmt) + "</span>";
			text += "<a href='javascript:;'><span class='del'><img src='/images/web/icon/close/selected.png' alt='삭제'></span></a>";
			text += "</li>";
			text += "</ol>";
			text += "</li>";
	
			$("#selectedItemWrapper ul").append(text);
			$("#selectedItemWrapper ul>li").last().attr("data-raw", ori_dataRaw);
			$("#selectedItemWrapper").css("display", "block");
			$(".comm-select .select-list-option").css("display", "none");
	
			if(productCount > 1) {
				$("#secondOptionList").empty();
			}
			$("#addOptionList").empty();
	
			var idx = 2;
	
			<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
				$(".packCalendar table>tbody>tr>td>a").removeClass("select");
				$(".opCal-title").html(idx + ". 날짜를 선택하세요");
				idx++;
			</c:if>
			$(".comm-select").removeClass("open");
	
			if(productCount > 1) {
				$(".comm-select1 .select-button").html("1. 상품을 선택하세요");
			}
			$(".comm-select2 .select-button").html(idx + ". 옵션을 선택하세요");
	
			selectedItemSaleAmt();
		});
	
	
		$("#selectedItemWrapper").on("click", ".del", function() {
			$(this).parents(".qty-list").remove();
	
			if($(this).parents(".qty-list").length == 0 ) {
				$("#selectedItemWrapper").css('display','block');
			}
			selectedItemSaleAmt();
			return ;
		});
	
		$("#selectedItemWrapper").on("keyup", ".qty-input", function() {
			var stockNum = fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",", "");
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
	
			$(this).val($(this).val().replace(/[^0-9]/gi, "1"));
	
			var keyCount = Number($(this).val());
	
			if(keyCount > Number(stockNum)) {
				keyCount = stockNum;
				$(this).val(keyCount);
			}
			$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * keyCount));
	
			selectedItemSaleAmt();
		});
	
		$("#selectedItemWrapper").on("blur", ".qty-input", function() {
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
	
			var keyCount = $(this).val();
	
			if(isNull(keyCount)) {
				keyCount = 1;
				$(this).val(keyCount);
			}
			$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * keyCount));
	
			selectedItemSaleAmt();
		});
		
		$("#selectedItemWrapper").on("click", ".addition", function() {
			
			if(fn_totQtyCheck('p')){
			
				var stockNum = fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",", "");
				var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
				var saleAmt = thisDataRaw.saleAmt;
				var addtionCount = Number($(this).prev().val()) + 1;
		
				if(addtionCount <= stockNum) {
					$(this).prev().val(addtionCount);
					$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * addtionCount));
		
					selectedItemSaleAmt();
				}
			}
		});
	
		$("#selectedItemWrapper").on("click", ".subtract", function() {
			
			if(fn_totQtyCheck('m')){		
				var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
				var saleAmt = thisDataRaw.saleAmt;
				var subtractCount = Number($(this).parents(".qty-list").find(".qty-input").val()) - 1;
		
				if(subtractCount >= 1) {
					$(this).parents(".qty-list").find(".qty-input").val(subtractCount);
					$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * subtractCount));
		
					selectedItemSaleAmt();
				}
			}
		});
	
		//-이용 후기 관련 설정 --------------------
		g_UE_corpId ="${prdtInfo.corpId}";				//업체 코드 - 넣어야함
		g_UE_prdtnum ="${prdtInfo.prdtNum}";			//상품번호  - 넣어야함
		g_UE_corpCd ="${Constant.SOCIAL}";				//숙박/랜트.... - 페이지에 고정
		g_UE_getContextPath = "${pageContext.request.contextPath}";
	
		//이용후기 상단 평점/후기수, 탭 숫자 변경(서비스로 사용해도됨)
		fn_useepilInitUI("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");
		// * 서비스 사용시 GPAANLSVO ossUesepliService.selectByGpaanls(GPAANLSVO) 사용
	
		//이용후기 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
		fn_useepilList("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");
	
		//---------------------------------------------------
	
		//-1:1문의 관련 설정 --------------------------------
		g_Oto_corpId ="${prdtInfo.corpId}";					//업체 코드
		g_Oto_prdtnum ="${prdtInfo.prdtNum}";				//상품번호
		g_Oto_corpCd ="${Constant.SOCIAL}";
		g_Oto_getContextPath = "${pageContext.request.contextPath}";
	
		fn_otoinqInitUI("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");
	
		fn_otoinqList("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}", "${prdtInfo.rsvTelNum}");
	
		// L.Point 적립 예상요금 출력
		var price = fn_replaceAll($("#totalProductAmt").text(), ",", "");
	
		$("#lpointSavePoint").html(commaNum(parseInt((price * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
	
		//Top Banner Slider
		if($("#detail_slider .swiper-slide").length > 1) {
			new Swiper("#detail_slider", {
				pagination		: "#detail_paging",
				paginationType	: "fraction",
				nextButton		: "#detail_next",
				prevButton		: "#detail_prev",
				loop			: true
			});
		} else {
			$("#detail_arrow").hide();
		}
	});
</script>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>