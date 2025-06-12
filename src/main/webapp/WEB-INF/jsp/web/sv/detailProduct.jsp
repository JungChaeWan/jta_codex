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

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="nofollow">
<c:if test="${fn:length(prdtImg) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(prdtImg) != 0}">
	<c:set value="${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtInfo.prdtNum}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}"/>

<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="${prdtInfo.prdtNm} - 제주도 공공플랫폼 탐나오"/>
	<jsp:param name="description" value="${prdtInfo.prdtInf}. 탐나오는 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 구매가 가능합니다."/>
	<jsp:param name="keywordsLinkNum" value="${prdtInfo.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="imagePath" value="${seoImage}"/>
	<jsp:param name="headTitle" value="${prdtInfo.prdtNm}"/>
</jsp:include>
<meta property="og:title" content="${prdtInfo.prdtNm} - 제주도 공공플랫폼 탐나오" />
<meta property="og:url" content="<c:out value='${strUrl}' />" />
<meta property="og:description" content="<c:out value='${prdtInfo.prdtNm}'/> - <c:out value='${prdtInfo.prdtInf}'/>" />
<c:if test="${fn:length(prdtImg) != 0}">
<meta property="og:image" content="<c:out value='${imgUrl}' />" />
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

<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" /> --%>

<c:if test="${not empty prdtInfo.adMov}">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/lite-yt-embed.css?version=${nowDate}'/>" />
<script type="text/javascript" src="<c:url value='/js/lite-yt-embed.js?version=${nowDate}'/>"></script>
</c:if>

<link rel="canonical" href="https://www.tamnao.com/web/sv/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/sv/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
<c:if test="${gpaVO.gpaCnt ne null}">
<script type="application/ld+json">

{
	"@context": "https://schema.org/",
    "@type": "Product",
    "name": "${prdtInfo.prdtNm}",
	"image": [
		"${imgUrl}"
	],
	"description": "${prdtInfo.prdtInf}",
	"sku": "${prdtInfo.prdtNum}",
	"brand": {
    	"@type": "Brand",
    	"name": "탐나오"
  	},
	"aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": ${gpaVO.gpaAvg eq null ? 0 : gpaVO.gpaAvg},
        "reviewCount": ${gpaVO.gpaCnt eq null ? 0 : gpaVO.gpaCnt},
		"worstRating":0,
        "bestRating":5
	},
	"offers": {
        "@type": "Offer",
        "url": "${strUrl}",
        "priceCurrency": "KRW",
        "price": ${prdtInfo.saleAmt}
	},
    "sameAs": [
        "http://www.visitjeju.or.kr",
        "https://www.youtube.com/@tamnaojeju",
        "https://www.instagram.com/tamnao_jeju",
        "https://www.facebook.com/JEJUTAMNAOTRAVEL",
        "https://blog.naver.com/jta0119",
        "https://pf.kakao.com/_xhMCrj"
    ]
}
</script>
</c:if>
</head>
<body>

<jsp:include page="/web/head.do" />

<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>제주특산/기념품</span>
	    </div>
	</div>
	
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	        <!-- Change Contents -->
	        <div class="sightseeing2 new-detail"> <!-- add Class (new-detail) -->
			    <div class="bgWrap2">
			        <div class="Fasten">
			            <!-- 상품정보 -->
			            <div class="detail">
			                <div class="detailL">
			                    <div class="detail-slider package">
								    <div id="detail_slider" class="swiper-container">
									    <div class="swiper-wrapper">
									      	<c:forEach var="prdtImg" items="${prdtImg}" varStatus="status">
									        	<div class="swiper-slide"><img id="imgPath${status.count}" src="${prdtImg.savePath}thumb/${prdtImg.saveFileNm}" alt="${prdtInfo.prdtNm}"></div>
									      	</c:forEach>
									    </div>
									    <c:if test="${fn:length(prdtImg) > 1}">
											<div id="detail_paging" class="swiper-pagination"></div>
											<div id="detail_arrow" class="arrow-area">
												<div id="detail_next" class="swiper-button-next"></div>
												<div id="detail_prev" class="swiper-button-prev"></div>
											</div>
    									</c:if>
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
										        <span class="score" id="ind_grade">평점 <strong class="text-red">0</strong>/5</span>
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
												<c:if test="${prdtInfo.superbSvYn eq 'Y'}">
													<span class="main_label back-purple">공모전 수상작</span>
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
										    		<img src="/images/web/icon/sns.png" width="25" height="31" alt="sns">
										    	</button>
										<%--    	<c:if test="${pocketCnt eq 0}">
													<button type="button" onclick="javascript:fn_SvAddPocket();" id="pocketBtnId">
														<img src="/images/web/icon/product_like_off2.png" width="34" height="30" alt="찜하기">
													</button>
										    	</c:if>
										    	<c:if test="${pocketCnt ne 0}">
													<button type="button">
														<img src="/images/web/icon/product_like_on2.png" width="34" height="30" alt="찜하기">
													</button>
										    	</c:if>--%>
										    </div>
										</div>
										<div class="origin-info">
											<span class="inline">제조사 : <c:out value="${prdtInfo.prdc}" /></span>
										</div>
										<div id="sns_popup" class="sns-popup">
											<ul class="sns-area">
												<li>
													<a href="javascript:shareKakao('<c:out value="${prdtInfo.prdtNm}" />', '${imgUrl}', '${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'PC' , 'KAKAO');">
														<img src="/images/web/icon/sns/kakaostory.png" loading="lazy" alt="카카오톡">
														<span>카카오톡</span>
													</a>
												</li>
												<li>
													<a href="javascript:shareFacebook('${strURL}'); snsCount('${prdtInfo.prdtNum}', 'PC' , 'FACEBOOK');">
														<img src="/images/web/icon/sns/facebook.png" loading="lazy" alt="페이스북">
														<span>페이스북</span>
													</a>
												</li>
												<li>
													<a href="javascript:shareBand('${strURL}'); snsCount('${prdtInfo.prdtNum}', 'PC', 'BAND');">
														<img src="/images/web/icon/sns/band.png" loading="lazy" alt="밴드">
														<span>밴드</span>
													</a>
												</li>
												 <li>
													<a href="javascript:shareLine('${strURL}'); snsCount('${prdtInfo.prdtNum}', 'PC', 'LINE');">
														<img src="/images/web/icon/sns/line.png" loading="lazy" alt="라인">
														<span>라인</span>
													</a>
												</li>
											</ul>
										</div><!-- //0310 공유하기-모달팝업 -->
			                    	</div> <!-- //title-box -->
			                    	
			                    	<div class="package-selected">
			                    		<ul class="prInfo">
										    <li class="left"></li>
										    <li class="option">
										        <div class="comm-select comm-select1 open"> <a class="select-button" id="select-button-opt1" title="상품 선택">1. 상품을 선택하세요</a>
										            <ul class="select-list-option" id="firstOptionList" style="display:none;">
										            </ul>
										        </div>
										        <!--달력-->
										        <div class="comm-select comm-select2"> <a class="select-button" id="select-button-opt2" title="옵션 선택">2. 옵션을 선택하세요</a>
										            <ul class="select-list-option" id="secondOptionList" style="display:none;">
													</ul>
										        </div>
												<c:if test="${fn:length(addOptList) > 0}">
													<div class="comm-select comm-select3">
														<a class="select-button" id="select-button-opt3" title="추가옵션 선택">3. 추가옵션을 선택하세요</a>
														<ul class="select-list-option" id="addOptionList" style="display:none;">
														</ul>
													</div>
                                                </c:if>
										        <!--선택항목추가-->
										        <div class="qtyWrap" id="selectedItemWrapper" style="display:none;">
										          	<ul></ul>
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
				                    		<div class="typography-info" id="directRecvYNPrice">
												<div class="check-option">
													<div class="label-typeA">
														<c:if test="${prdtInfo.deliveryYn eq 'Y'}">
															<label>
																<input type="radio" name="directRecvYn" value="N" checked>
																<span>일반택배</span>
															</label>
														</c:if>
														<c:if test="${prdtInfo.directRecvYn eq 'Y'}">
															<label>
																<input type="radio" name="directRecvYn" value="Y" <c:if test="${prdtInfo.deliveryYn eq 'N'}">checked</c:if>>
																<span>직접수령</span>
															</label>
														</c:if>
													</div>
												</div>

												<c:if test="${prdtInfo.deliveryYn eq 'Y'}">
													<p>배송비:
														<c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV}">
															<c:if test="${prdtInfo.dlvAmt eq prdtInfo.inDlvAmt}">
																<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
															</c:if>
															<c:if test="${prdtInfo.dlvAmt ne prdtInfo.inDlvAmt}">
																도외(<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원), 도내(<fmt:formatNumber>${prdtInfo.inDlvAmt}</fmt:formatNumber>원)
															</c:if>
														</c:if>
														<c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL}">
															<c:if test="${prdtInfo.dlvAmt eq prdtInfo.inDlvAmt}">
																<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
															</c:if>
															<c:if test="${prdtInfo.dlvAmt ne prdtInfo.inDlvAmt}">
																도외(<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원), 도내(<fmt:formatNumber>${prdtInfo.inDlvAmt}</fmt:formatNumber>원),
															</c:if>
															(<fmt:formatNumber>${corpDlvAmtVO.aplAmt}</fmt:formatNumber>원 이상 구매시 무료)
														</c:if>
														<c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI}">
															${prdtInfo.maxiBuyNum}개당 <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
														</c:if>
														<c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE}">
															무료
														</c:if>
													</p>
												</c:if>

												<c:if test="${prdtInfo.directRecvYn eq 'Y' }">
													<p>직접수령: 매장에 방문하여 주문 상품을 수령(배송비 무료) <button class="comm-btn sm blue" onclick="javascript:fn_showMap();">위치</button></p>
												</c:if>
				                    		</div>
				                    	</div>
				                    	<div class="point-area">
				                    	  	<%--<c:if test="${not empty loginVO and fn:length(couponList) > 0}">
												<div class="row" id="useAbleCoupon">
													<span class="col1 text-red">
														<c:forEach var="coupon" items="${couponList}" varStatus="status">
															<c:set var="userCp" value="${userCpMap[coupon.cpId]}" />
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
														<c:forEach var="coupon" items="${couponList}" varStatus="status">
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
					                      	</c:if>--%>
				                    		<div class="row">
				                    			<span class="col1">L.POINT 적립금</span>
				                    			<span class="col2" id="lpointSavePoint">0원</span>
				                    			<span class="col3"></span>
				                    		</div>
				                    	</div>
										<c:if test="${chkPointBuyAble eq 'Y'}">
											<div class="purchase-btn-group">
												<button type="button" id="cartBtn" class="comm-btn gray width40" onclick="fn_SvAddCart(); return false;">장바구니</button>
												<button type="button" class="comm-btn red width60" onclick="javascript:fn_SvBuy();">바로구매</button>
											</div>
										</c:if>
										<c:if test="${chkPointBuyAble ne 'Y'}">
											<div class="purchase-btn-group">
												<button type="button" class="comm-btn gray width100">구매불가</button>
											</div>
										</c:if>
									</div> <!-- //purchasing-info -->
			                    </div>
			                </div>
			            </div>
			            
			            <!-- 탭 정보 (이용안내, 취소/환불규정 등등) -->
			            <div id="tabs" class="nav-tabs2">
			                <ul class="menuList">
			                    <li class="active"><a href="#tabs-1">상품설명</a></li>
			                    <li><a href="#tabs-2">취소/환불</a></li>
			                    <li><a href="#tabs-5">이용후기</a></li>
			                    <li><a href="#tabs-6">1:1문의</a></li>
			                </ul>
			                
			                <!--상품설명-->
			                <div id="tabs-1" class="tabPanel">
			                	<div class="type-bodyA">
			                	  	<c:if test="${fn:length(prmtList) > 0 }">
										<!-- 프로모션 추가 -->
										<c:forEach items="${prmtList }" var="prmt">
											<div class="promotion-detail">
												<c:if test="${not empty fn:trim(prmt.dtlImg)}">
													<div class="photo">
														<img src='<c:url value="${prmt.dtlImg}" />' alt="${prmt.prmtNm}">
													</div>
												</c:if>
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
											</div> <!-- //promotion-detail -->
										</c:forEach>
										<!-- //프로모션 추가 -->
				                  	</c:if>
				                  
				                  	<c:if test="${not empty prdtInfo.adMov}">
				                  		<div class="video-area">
				                  			<lite-youtube videoid="${fn:replace(prdtInfo.adMov, 'https://www.youtube.com/embed/', '')}" playlabel="${prdtInfo.prdtNm} 유튜브영상"></lite-youtube>
				                  		</div>
				                  		<%--
										<div class="video-area">
											<iframe title="${prdtInfo.prdtNm} 유튜브영상" width="740" height="276" src="${prdtInfo.adMov}" allowfullscreen></iframe>
										</div>
										--%>
						          	</c:if>
				                  
			                		<div class="typography-typeA">
			                			<c:out value="${prdtInfo.prdtExp}" escapeXml="false"/>
			                		</div>
			                		<div class="detail-photo">
			                		  	<c:forEach items="${dtlImg}" var="dtlImg">
								        	<img class="full" src="${dtlImg.savePath}${dtlImg.saveFileNm}" loading="lazy" alt="${prdtInfo.prdtNm}">
								      	</c:forEach>
								    </div>
									<dl class="typeA">
										<dt>원산지</dt>
										<dd>
											<c:out value="${prdtInfo.org}" escapeXml="false"/>
										</dd>
									</dl>
								    <c:if test="${not empty prdtInfo.hdlPrct}">
										<dl class="typeA">
											<dt>취급주의사항</dt>
											<dd>
												<c:out value="${prdtInfo .hdlPrct}"  escapeXml="false"/>
											</dd>
										</dl>
								    </c:if>
								    
								    <c:if test="${(not empty prdtInfo.hdlPrct) and (fn:length(dtlImg) eq 0) and (not empty prdtInfo.prdtExp)}">
                                    	<!--콘텐츠 없을 시-->
                                    	<p class="no-content">상세 상품 설명이 없습니다.</p>
                                    </c:if>
							    </div>
			                </div> <!-- //tabs-1 -->
			                
			                <!--환불규정-->
			                <div id="tabs-2" class="tabPanel">
			                    <div class="type-bodyA">
			                      	<c:if test="${not empty prdtInfo.dlvGuide}">
										<dl class="typeA">
											<dt>배송안내</dt>
											<dd>
												<c:out value="${prdtInfo.dlvGuide}" escapeXml="false"/>
											</dd>
										</dl>
								  	</c:if>
								  	<c:if test="${not empty prdtInfo.cancelGuide}">
										<dl class="typeA">
											<dt>취소안내</dt>
											<dd>
												<c:out value="${prdtInfo.cancelGuide}" escapeXml="false"/>
											</dd>
										</dl>
								  	</c:if>
								  	<c:if test="${not empty prdtInfo.tkbkGuide}">
										<dl class="typeA">
											<dt>교환/반품안내</dt>
											<dd>
												<c:out value="${prdtInfo.tkbkGuide}" escapeXml="false"/>
											</dd>
										</dl>
								  	</c:if>
								  	<c:if test="${not empty prdtInfo.shopNm}">
										<dl class="typeA">
											<dt>판매처 정보</dt>
											<dd>
												<div class="float-content distributor">
													<div class="l-area icon">
													  	<c:if test="${prdtInfo.superbCorpYn eq 'Y'}">
															<img class="excellence" src="<c:url value='/images/web/icon/excellence_02.jpg' />" loading="lazy" alt="우수관광사업체">
													  	</c:if>
													  	<c:if test="${not empty prdtInfo.adtmImg}">
															<img src="${prdtInfo.adtmImg}" loading="lazy" alt="ci">
													  	</c:if>
													</div>
													<div class="r-area text">
														<p>판매자명 : <c:out value="${prdtInfo.shopNm}" /></p>
														<p>주소 : <c:out value="${corpInfo.roadNmAddr}"/> <c:out value="${corpInfo.dtlAddr}"/></p>
														<p>연락처 : <c:out value="${prdtInfo.rsvTelNum}"/></p>
													</div>
												</div>
											</dd>
										</dl>
								    </c:if>
			                    </div>
			                </div> <!-- //tabs-2 -->
			                
			                <!--이용후기-->
			                <div id="tabs-5" class="tabPanel"></div> <!-- //tabs-5 -->
			                
			                <!--1:1문의-->
			                <div id="tabs-6" class="tabPanel"></div> <!--//tabs-->
			        	
			        		<c:if test="${fn:length(otherProductList) > 1}">
								<div class="recommend-wrap">
									<section class="recommend-product">
										<h2 class="sec-caption">추천 상품</h2>

										<div class="recommend-group">
											<div class="title-side-area">
												<div class="l-area">
													<h3 class="title-type4">묶음 배송 가능한 상품</h3>
												</div>
												<div class="r-area text">
													<a href="<c:url value='/web/sv/corpPrdt.do?sCorpId=${corpInfo.corpId}&sPrdc=${prdtInfo.prdc}'/>">전체보기</a>
												</div>
											</div>

											<div class="promotion-content">
												<div class="swiper-container">
													<ul class="swiper-wrapper">
													  	<c:forEach var="product" items="${otherProductList}">
															<li class="swiper-slide">
																<div class="photo">
																	<a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${product.prdtNum}'/>">
																		<img class="product" src="${product.savePath}thumb/${product.saveFileNm}" alt="product">
																	</a>
																</div>
																<div class="text">
																	<div class="title"><c:out value='${product.prdtNm}' /></div>
																	<div class="info">
																		<dl>
																			<dt class="text-red">탐나오가</dt>
																			<dd>
																				<div class="price">
																					<del><fmt:formatNumber value='${product.nmlAmt}' type='number' />원</del>
																					<strong><fmt:formatNumber value='${product.saleAmt}' type='number' />원</strong>
																				</div>
																			</dd>
																		</dl>
																		<div class="like">
																			<c:if test="${not empty pocketMap[product.prdtNum] }">
																				<%-- <a href="javascript:void(0)"> --%>
																				<a href="javascript:void(0)">
																					<img src="<c:url value='/images/web/icon/product_like_on.png' />" width="24" height="24" alt="찜하기">
																				</a>
																			</c:if>
																			<c:if test="${empty pocketMap[product.prdtNum] }">
																				<%-- <a href="javascript:void(0)" id="pocket${product.prdtNum }" onclick="fn_listAddPocket('${Constant.SV}', '${product.corpId }', '${product.prdtNum }')"> --%>
																				<a id="pocket${product.prdtNum }" onclick="fn_listAddPocket('${Constant.SV}', '${product.corpId }', '${product.prdtNum }')">
																					<img src="<c:url value='/images/web/icon/product_like_off.png' />" width="24" height="24" alt="찜하기">
																				</a>
																			</c:if>
																		</div>
																	</div>
																</div>
															</li>
													  	</c:forEach>
													</ul>
												</div>
											</div>
										</div> <!-- //recommend-group -->
									</section> <!-- //recommend-product -->
								</div> <!-- //recommend-wrap -->
			        		</c:if>
						</div> <!--//Fasten-->
					</div> <!--//bgWrap-->
				</div> <!-- //new-detail -->
			</div><!-- //Change Contents -->
	    </div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<script type="text/javascript" src="<c:url value='/js/useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js?version=${nowDate}'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/bloglink.js?version=${nowDate}'/>"></script> --%>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
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
	
	function getSecondOption(svDivSn) {
		$("#secondOptionList").empty();
	
		$.ajax({
			url: "<c:url value='/web/sv/getOptionList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}&svDivSn=" + svDivSn,
			success:function(data) {
				var list = data.list;
				var dataArr;
				var inx = 0;
				var count = 1;
	
				if(list != "") {
					$(list).each(function() {
						optionCount = list.length;
	
						if(this.stockNum > 0 && this.ddlYn == 'N') {
							dataArr = "<li>";
							dataArr += "<a href='javascript:;' data-raw='' title='" + this.optNm +"'>";
							dataArr += "<p class='product'>";
							dataArr += "<span>[선택" + count + "]" + fn_addDate(this.aplDt) +  " " + this.optNm + "</span>";
							dataArr += "<span class='count'> | 잔여 : " + commaNum(this.stockNum) + "개</span>";
							dataArr += "</p>";
							/** 개발용코드*/
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
						$("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this) );
						count++;
						inx++;
					});
	
					$('.comm-select').removeClass('open');
					//$('.comm-select2').addClass('open');	//자동open 해제
					$('.comm-select .select-list-option').css('display', 'none');
					//$("#secondOptionList").css('display', 'block');	//자동open 해제
					$("#secondOptionList").css('display', 'none');
				}
			},
			error: fn_AjaxError
		});
	}
	
	/** 추가옵션선택시 */
	function getAddOption() {
		if($("#addOptionList").css('display') == 'block') {
			$('.comm-select .select-list-option').css('display', 'none');
			return ;
		}
		if($("#addOptionList li").length > 0) {
			if($("#addOptionList").css('display') == 'none') {
				$('.comm-select .select-list-option').css('display', 'none');
				$("#addOptionList").css('display', 'block')
			}
			$('.comm-select').removeClass('open');
			$('.comm-select3').addClass('open');
			return false;
		}
	 	var b_data = {
	 			addOptNm 	: '',
	 			addOptAmt 	: 0,
	 			addOptSn 	: ''
	 	};
	
		$.ajax({
			url: "<c:url value='/web/sv/getAddOptList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}",
			success:function(data) {
				var dataArr = '<li><a href="javascript:;" data-raw="" title=""><p class="product"><span>선택안함</span></p></a></li>';
	
				$("#addOptionList").append(dataArr);
	
				var list = data.list;
				var inx = 1;
	
				if(list != "") {
					addOptionCount = list.length;
	
					$(list).each( function() {
						dataArr = "<li>";
						dataArr += "<a href='javascript:;' data-raw='' title='" + this.addOptNm + "'>";
						dataArr += "<p class='product'><span>" + this.addOptNm + "</span></p>";
						/**개발용코드*/
						dataArr += "<del></del>";
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
	
					$("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data) );
				}
			},
			error: fn_AjaxError
		});
	
		$('.comm-select').removeClass('open');
		//$('.comm-select3').addClass('open');	//자동open 해제
		$('.comm-select .select-list-option').css('display', 'none');
		//$("#addOptionList").css('display', 'block');	//자동open 해제
		$("#addOptionList").css('display', 'none');
	}
	/**
	 * 총합계.
	 */
	function selectedItemSaleAmt() {
		var price = 0;
	
		$("#selectedItemWrapper .price").each(function(){
			price = price +  Number(fn_replaceAll($(this).text(), ",", ""));
		});
	
		$("#totalProductAmt").html(commaNum(price));
		$("#lpointSavePoint").html(commaNum(parseInt((price * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
		// 쿠폰리스트 체크
		fn_chkCouponList();
	}
	
	function fn_SvAddCart(){
		var item = $("#selectedItemWrapper ul>li");
	
		if(item.length == 0 ) {
			alert("옵션을 선택해주세요.")
			return ;
		}
		var cart = [];
	
		item.each(function() {
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			cart.push({
				prdtNum 		: "<c:out value='${prdtInfo.prdtNum}'/>",
				prdtNm 			: "<c:out value='${prdtInfo.prdtNm}'/>",
				corpId 			: "<c:out value='${prdtInfo.corpId}'/>",
				corpNm 			: "<c:out value='${prdtInfo.corpNm}'/>",
				prdtDivNm 		: dataRaw.prdtDivNm,
				svOptSn 		: dataRaw.svOptSn,
				svDivSn 		: dataRaw.svDivSn,
				addOptAmt 		: dataRaw.addOptAmt,
				addOptNm 		: dataRaw.addOptNm,
				qty 			: $(this).find(".list2 .qty-input").val(),
				directRecvYn 	: $("input[name=directRecvYn]:checked").val(),
				nmlAmt 			: 0,
				imgPath			: $("#imgPath1").attr("src")
			});
		});
	
		fn_AddCart(cart);
		// 장바구니에 담고 선택한거 삭제
		$("#selectedItemWrapper ul").html('');
	
		selectedItemSaleAmt();
	}
	
	/**
	 * 찜한 상품
	 */
	function fn_SvAddPocket(){
		var pocket = [{
			prdtNum 	: "<c:out value='${prdtInfo.prdtNum}'/>",
			prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
			corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
			corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
			prdtDiv 	: "${Constant.SV}"
		}];
		
		fn_AddPocket(pocket);
	}
	
	/**
	 * 즉시구매
	 */
	function fn_SvBuy(){
		var item = $("#selectedItemWrapper ul>li");
	
		if(item.length == 0 ) {
			alert("옵션을 선택해주세요.")
			return ;
		}
		var cart = [];
	
		item.each( function() {
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			cart.push({
				prdtNum 		: "<c:out value='${prdtInfo.prdtNum}'/>",
				prdtNm 			: "<c:out value='${prdtInfo.prdtNm}'/>",
				corpId 			: "<c:out value='${prdtInfo.corpId}'/>",
				corpNm 			: "<c:out value='${prdtInfo.corpNm}'/>",
				prdtDivNm 		: dataRaw.prdtDivNm,
				svOptSn 		: dataRaw.svOptSn,
				svDivSn 		: dataRaw.svDivSn,
				addOptAmt 		: dataRaw.addOptAmt,
				addOptNm 		: dataRaw.addOptNm,
				qty 			: $(this).find(".list2 .qty-input").val(),
				directRecvYn 	: $("input[name=directRecvYn]:checked").val(),
				nmlAmt 			: 0,
				imgPath			: $("#imgPath1").attr("src")
			});
		});
	
		fn_InstantBuy(cart);
	}
	
	function checkDupOption(newData) {
		var result = false ;
	
		$("#selectedItemWrapper ul>li").each(function (){
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			if(newData.svDivSn == dataRaw.svDivSn && newData.svOptSn == dataRaw.svOptSn) {
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
	
	function fn_clickTab(nTab){
		$('#tabs ul li a').eq(nTab).trigger("click");
		location.href = "#tabs";
	}
	
	function fn_dlvText(dlvAmtDiv, dlvAmt, inDlvAmt, maxiBuyNum) {
		if(dlvAmtDiv == "${Constant.DLV_AMT_DIV_DLV}") {
			return "도외("+ commaNum(dlvAmt) + "),도내(" + commaNum(inDlvAmt) + ")";
		} else if (dlvAmtDiv == "${Constant.DLV_AMT_DIV_APL}") {
			return commaNum('${corpDlvAmtVO.aplAmt}') + "원 이상 무료";
		} else if(dlvAmtDiv == "${Constant.DLV_AMT_DIV_MAXI}") {
			return commaNum(maxiBuyNum) + "개당 "+ commaNum(dlvAmt) + "원";
		} else if(dlvAmtDiv == "${Constant.DLV_AMT_DIV_FREE}") {
			return "무료";
		}
	}
	
	function onChgDirectRecvYn(obj){
		if(obj.value == "Y"){
			//직접 수령
			fn_showMap();
		}
	}
	
	function fn_showMap(){
		//위치 정보가 있어야 표시
		if(${not empty svDftinfo.directrecvLon} && ${not empty svDftinfo.directrecvLat}) {
			window.open("<c:url value='/web/sv/showDirRecvMap.do'/>?corpId=${prdtInfo.corpId}","위치보기", "width=580, height=400, scrollbars=yes, status=no, toolbar=no;");
		}
	}
	
	// 쿠폰 리스트 체크
	function fn_chkCouponList() {
		var copNum = 0;
		var amt = eval(fn_replaceAll($("#totalProductAmt").text(), ",", ""));
	
		$('.useCouponList').each(function() {		
			if (amt < $(this).attr('minAmt')) {
				$("#cpTitle" + $(this).attr("showKey")).addClass("hide");
				$('#useCouponNm_' + $(this).attr('showKey')).addClass('hide');
				$('#useCouponAmt_' + $(this).attr('showKey')).addClass('hide');
			} else {
				copNum++;
	
				$("#cpTitle" + $(this).attr("showKey")).removeClass("hide");
				$('#useCouponNm_' + $(this).attr('showKey')).removeClass('hide');
				$('#useCouponAmt_' + $(this).attr('showKey')).removeClass('hide');
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
	
	// 쿠폰코드 등록
	function goCouponCode() {
		if(confirm("<spring:message code='confirm.coupon.code' />")){
			location.href = "<c:url value='/web/mypage/couponList.do' />";
		}
	}
	
	$(document).ready(function() {
		//Top Banner Slider
		if($('#detail_slider .swiper-slide').length > 1) {
			new Swiper('#detail_slider', {
		        pagination		: '#detail_paging',
		        paginationType	: 'fraction',
				nextButton		: '#detail_next',
				prevButton		: '#detail_prev',
				loop			: true
		    });
		} else {
			$('#detail_arrow').hide();
		}
		
		$(".gallery-view1 .carousel").jCarouselLite({
		    btnNext		: ".gallery-view1 .next",
		    btnPrev		: ".gallery-view1 .prev",
		    speed		: 300,
		    visible		: 5,
		    circular	: false
		});
	
		$(".gallery-view1 .carousel img").click(function() { //이미지 변경
		    $(".gallery-view1 .mid img").attr("src", $(this).attr("src"));
		});
	
		$('.gallery-view1 .carousel li').click(function(){ //class 추가
		    $('.gallery-view1 .carousel li').removeClass('select');
		    $(this).addClass('select');
		});
	
		// 상품을 선택하세요
		$('.comm-select1 .select-button').click(function(){
			if($("#firstOptionList").css('display') == 'block') {
				$('.comm-select .select-list-option').css('display', 'none');
				return ;
			}
			if($("#firstOptionList li").length > 0) {
				if($("#firstOptionList").css('display') == 'none') {
					$('.comm-select .select-list-option').css('display', 'none');
					$("#firstOptionList").css('display', 'block')
				}
				$('.comm-select').removeClass('open');
				$('.comm-select1').addClass('open');
				return false;
			}
	
	      	$.ajax({
				url: "<c:url value='/web/sv/getDivInfList.ajax'/>",
				data: "prdtNum=${prdtInfo.prdtNum}",
				success:function(data) {
					var list = data.list;
					var dataArr;
					var inx = 0;
					var count = 1;
	
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
	
						$('.comm-select .select-list-option').css('display', 'none');
						$('.comm-select1 .select-list-option').css('display', 'block');
	
						/*if(productCount == 1) {
							//자동open 해제
							//$("#firstOptionList li:eq(0)>a").trigger("click");			// 1개 상품 경우 자동선택
						} else if(productCount > 1) {
							$(".comm-select1").addClass("open");						// 2개 이상 상품일 경우 open
						}else {
							$(".comm-select1 .select-button").trigger("click");
						}*/
					}
				},
				error: fn_AjaxError
			})
	    });
	
		// 상품 목록 펼침(자동오픈 해제 요청)
		//$(".comm-select1 .select-button").trigger("click");
	
		// 상품 선택
		$("#firstOptionList").on('click', "li>a", function() {
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
			var title = $(this).attr("title");
	
			$("#svDivSn").val(dataRaw.svDivSn);
	
			$(".comm-select1 .select-button").html("1. 선택상품 : <span></span>");
			$(".comm-select1 .select-button span").text(title);
			$(".comm-select1 .select-button span").addClass("text-red");
	
			$("#secondOptionList").empty();
	
			getSecondOption(dataRaw.svDivSn);
		});
	
		// 옵션을 선택하세요
		$('.comm-select2 .select-button').click(function(){
			if($("#secondOptionList").css('display') == 'block') {
				$("#secondOptionList").css('display', 'none');
			} else {
				if($("#secondOptionList li").length > 0) {
					$("#secondOptionList").css('display', 'block');
					$(".comm-select").removeClass('open');
					$(".comm-select2").addClass('open');
				}
			}
		});
	
		// 옵션 선택
		$("#secondOptionList").on("click", "li>a", function() {
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
				 // 2016-01-17, 잔여수가 없어져버려서 수량 변경 기능이 오작동됨.. 롤백(by ezham)
				var text = "<li class='qty-list'>";
				text += "<ol>";
				text += "<li class='list1'>";
				text += firstOptionText;
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
				$("#selectedItemWrapper ul>li").last().attr("data-raw",ori_dataRaw);
				$("#selectedItemWrapper").css('display', 'block');
	
				if(productCount > 1) {
					if(optionCount == 1) {
						$(".comm-select").removeClass("open");
						$(".comm-select1 .select-button").html("1. 상품을 선택하세요");
						$(".comm-select2 .select-button").html("2. 옵션을 선택하세요");
						$("#secondOptionList").empty();
					}
				}
				$('.comm-select .select-list-option').css('display', 'none');
	
				selectedItemSaleAmt();
			} else {
				getAddOption();
	
				$("#addOptionList").attr("data-raw",ori_dataRaw);
				$(".comm-select2 .select-button").html("2. 선택옵션 : <span></span>");
				$(".comm-select2 .select-button span").text(secondOptionText);
				$(".comm-select2 .select-button span").addClass("text-red");
			}
		});
	
		// 추가 옵션을 선택하세요
		$('.comm-select3 .select-button').click(function(){
			if($("#addOptionList").css('display') == 'block') {
				$("#addOptionList").css('display', 'none');
			} else {
				if($("#addOptionList li").length > 0) {
					$("#addOptionList").css('display', 'block');
					$(".comm-select").removeClass('open');
					$(".comm-select3").addClass('open');
				}
			}
	    });
	
		// 추가 옵션 선택
		$("#addOptionList").on('click', "li>a", function() {
			var dataRaw =  jQuery.parseJSON($("#addOptionList").attr("data-raw"));
			var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			dataRaw.addOptAmt = thisDataRaw.addOptAmt;
			dataRaw.addOptNm = thisDataRaw.addOptNm;
			dataRaw.addOptSn = thisDataRaw.addOptSn;
	
			var ori_dataRaw = JSON.stringify(dataRaw);
	
			var firstOptionText = $(".comm-select1 .select-button").text();
			var secondOptionText = $(".comm-select2 .select-button").text();
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
			text += "<br>- " + secondOptionText;
	
			if(addOptionText != "") {
				text += "<br>- " + addOptionText;
			}
			text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
			text += "</li>";
			text += "<li class='shipping' attr-maxiBuyNum='" + dataRaw.maxiBuyNum + "'>배송비 : " + fn_dlvText(dataRaw.dlvAmtDiv, dataRaw.dlvAmt, dataRaw.inDlvAmt, dataRaw.maxiBuyNum) + "</li>";
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
			$("#selectedItemWrapper").css('display', 'block');
			$('.comm-select .select-list-option').css('display', 'none');
	
			if(productCount > 1) {
				$("#secondOptionList").empty();
			}
			$("#addOptionList").empty();
	
			$('.comm-select').removeClass('open');
	
			if(productCount > 1) {
				$(".comm-select1 .select-button").html("1. 상품을 선택하세요");
			}
			$(".comm-select2 .select-button").html("2. 옵션을 선택하세요");
	
			selectedItemSaleAmt();
		});
	
		$("#selectedItemWrapper").on("click", ".del", function() {
			$(this).parents(".qty-list").remove();
	
			if($(this).parents(".qty-list").length == 0 ) {
				$("#selectedItemWrapper").css('display', 'block');
			}
			selectedItemSaleAmt();
	
			return ;
		});
	
		$("#selectedItemWrapper").on("keyup", ".qty-input", function() {
			var stockNum = fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",", "");
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
	
			$(this).val($(this).val().replace(/[^0-9]/gi,""));
	
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
			var stockNum = fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",", "");
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
			var addtionCount = Number($(this).prev().val()) + 1;
	
			//플러스 버튼 클릭 시 추가옵션 금액 추가 2021.05.03 cahewan.jung
			if (typeof thisDataRaw.addOptAmt != "undefined" && thisDataRaw.addOptAmt != "" && thisDataRaw.addOptAmt != null){
				saleAmt = saleAmt + parseInt(thisDataRaw.addOptAmt);
			}
	
			if(addtionCount <= stockNum) {
				$(this).prev().val(addtionCount);
				$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * addtionCount));
	
				selectedItemSaleAmt();
			}
		});
	
		$("#selectedItemWrapper").on("click", ".subtract", function() {
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
			var subtractCount = Number($(this).parents(".qty-list").find(".qty-input").val()) - 1;
	
			//마이너스 버튼 클릭 시 추가옵션 금액 추가 2021.05.03 cahewan.jung
			if (typeof thisDataRaw.addOptAmt != "undefined" && thisDataRaw.addOptAmt != "" && thisDataRaw.addOptAmt != null){
				saleAmt = saleAmt + parseInt(thisDataRaw.addOptAmt);
			}
	
			if(subtractCount >= 1) {
				$(this).parents(".qty-list").find(".qty-input").val(subtractCount);
				$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * subtractCount));
	
				selectedItemSaleAmt();
			}
		});
	
		// 쿠폰리스트 체크
		// fn_chkCouponList();
	
		g_UE_corpId		="${prdtInfo.corpId}";
		g_UE_prdtnum 	="${prdtInfo.prdtNum}";
		g_UE_corpCd 	="${Constant.SV}";
		g_UE_getContextPath = "${pageContext.request.contextPath}";
	
		fn_useepilInitUI("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SV}");
		fn_useepilList("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SV}");
	
		//-1:1문의 관련 설정 --------------------------------
		g_Oto_corpId	="${prdtInfo.corpId}";					//업체 코드
		g_Oto_prdtnum 	="${prdtInfo.prdtNum}";				//상품번호
		g_Oto_corpCd 	="${Constant.SV}";
		g_Oto_getContextPath = "${pageContext.request.contextPath}";
	
		fn_otoinqInitUI("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SV}");
		fn_otoinqList("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SV}", "${prdtInfo.rsvTelNum}");
		
		// L.Point 적립 예상요금 출력
		var price = fn_replaceAll($("#totalProductAmt").text(), ",","");
		$("#lpointSavePoint").html(commaNum(parseInt((price * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
	
		/**최근 본 상품 2021.08.12 chaewan.jung**/
		let newGoodsList = [];
		if(localStorage.getItem('newGoodsList')){
			newGoodsList = JSON.parse(localStorage.getItem('newGoodsList'));
		}
	
		let isDupl = true;
		newGoodsList.forEach(function(list){
			if (list.prdtNum == "<c:out value='${prdtInfo.prdtNum}'/>"){
				isDupl = false;
			}
		});
	
		if (isDupl){
			newGoodsList.unshift({
				"prdtNum"     : "<c:out value='${prdtInfo.prdtNum}'/>",
				"prdtNm"      : "<c:out value='${prdtInfo.prdtNm}'/>",
				"corpId"      : "<c:out value='${prdtInfo.corpId}'/>",
				"corpNm"      : "<c:out value='${prdtInfo.corpNm}'/>",
				"saleAmt"     : "<c:out value='${prdtInfo.saleAmt}'/>",
				"imgPath"     : $("#imgPath1").attr("src")
			});
		}
	
		//최근 본 상품 5개만 남기고 삭제
		if (newGoodsList.length > 4) {
			newGoodsList.splice(4,99);
		}
		localStorage.setItem('newGoodsList', JSON.stringify(newGoodsList));
	});
</script>
<jsp:include page="/web/foot.do" />
</body>
</html>