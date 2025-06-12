<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>

<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">
	/** http -> https 변환*/
	if(document.location.protocol == 'http:') {
		var chkInclude = document.location.host;
		var chkPath = document.location.pathname;

		// 로그인 페이지는 java 에서 처리
		if(!chkInclude.includes("localhost") && !chkInclude.includes("dev") && !chkInclude.includes("218.157.128.119") && !chkPath.includes("mw/viewLogin.do") && !chkInclude.includes("tamnao.iptime.org") ) {
			document.location.href = document.location.href.replace("http:", "https:");
		}
	}

	/** 서브도메인없을경우 www 변환*/
	var url1 = 'tamnao.com';
	var url2 = 'm.tamnao.com';
	if( url1 == document.domain ) document.location.href = document.URL.replace(url1, url2);


$(document).ready(function(){
	
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=home" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
		
			<div id="contents">
            	<!--관리자 홈-->
            	<div class="admin_home">
                	<!--최근게시물-->
                    <div class="latest_post post1">
                    	<h3>공지사항</h3>
                    	<ul>
                    		<c:forEach var="data" items="${masnotiList}" varStatus="status">
                        		<li><a href="<c:url value='/oss/nbbs/bbsDtl.do'/>?bbsNum=MASNOTI&noticeNum=${data.noticeNum}"><c:out value="${data.subject}"/></a><span class="date">${fn:substring(data.frstRegDttm, 0, 10)}</span></li>
                        	</c:forEach>
                        </ul>
                        <span class="more"><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASNOTI" title="공지사항 더보기"><img src="<c:url value='/images/oss/home/more_btn01.gif'/>" alt="공지사항 더보기" /></a></span>
                    </div>
                    <div class="latest_post post2">
                    	<h3>업체 Q&amp;A 게시판</h3>
                    	<ul>
                    		<c:forEach var="data" items="${masqaList}" varStatus="status">
                        		<li><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASQA"><c:out value="${data.subject}"/></a><span class="date">${fn:substring(data.frstRegDttm, 0, 10)}</span></li>
                        	</c:forEach>
                        	<!-- 
                        	<li><a href="#">예약이 안됩니다. 문의 드립니다..</a><span class="answer">답변(1)</span><span class="date">15-12-15</span></li>
                        	<li><a href="#">문의드립니다</a><span class="date">15-12-15</span></li>
                        	<li><a href="#">문의드립니다</a><span class="date">15-12-15</span></li>
                        	 -->
                        </ul>
                        <span class="more"><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASQA" title="업체QA게시판 더보기"><img src="<c:url value='/images/oss/home/more_btn01.gif'/>" alt="업체QA게시판 더보기" /></a></span>
                    </div>		
                	<!--//최근게시물-->
                    
                	<!--미처리현황, 진행현황-->
                    <ul class="process">
                    	<li>
                    		<h3>진행현황</h3>
                            <ul class="process_box process02">
                            	<li>
                            		<a href="<c:url value='/oss/corpPnsReqList.do' />">
	                                	<img src="<c:url value='/images/oss/home/progress_icon02.gif'/>" alt="" />
	                                	<strong>입점신청</strong>
	                                    <span><strong>${cntCorpPns}</strong>건</span>
	                                </a>
                                </li>
                                <li>
                                	<a href="<c:url value='/oss/prdtList.do' />?sTradeStatus=TS02">
	                                	<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
	                                	<strong>실시간 상품 승인요청</strong>
	                                    <span><strong>${cntRTPrdt}</strong>건</span>
	                                </a>
                                </li>
                                <li>
                                	<a href="<c:url value='/oss/socialProductList.do'/>?sTradeStatus=TS02">
	                                   	<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
		                               	<strong>소셜 상품 승인요청</strong>
		                                <span>
		                                	<strong>${cntSPPrdt}</strong>건
		                                </span>
		                            </a>
                                </li>
                                <li>
	                                <a href="<c:url value='/oss/svPrdtList.do'/>?sTradeStatus=TS02">
	                                   	<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
		                               	<strong>기념품 상품 승인요청</strong>
		                                <span>
		                                	<strong>${cntSVPrdt}</strong>건
		                                </span>
		                            </a>
                                </li>
                                <li>
	                                <a href="<c:url value='/oss/promotionList.do'/>?sTradeStatus=TS02">
	                                   	<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />                                   	
		                               	<strong>프로모션 승인요청</strong>
		                                <span>
		                                	<strong>${cntPrmt}</strong>건
		                                </span>
		                            </a>
                                </li>
                            </ul>
							<ul class="process_box process02">
								<li>
	                                <a href="<c:url value='/oss/refundRsvList.do'/>">
	                                   	<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
		                               	<strong>무통장입금 환불요청건</strong>
		                                <span>
		                                	<strong>${nCntRfAcc}</strong>건
		                                </span>
		                            </a>
                                </li>
								<li>
									<a href="<c:url value='/oss/rsvList.do'/>?sRsvStatusCd=RS10">
										<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
										<strong>실시간 상품 취소요청</strong>
										<span>
											<strong>${nCntRsvCancel}</strong>건
										</span>
									</a>
								</li>
								<li>
									<a href="<c:url value='/oss/rsvSvList.do'/>?sRsvStatusCd=RS10">
										<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
										<strong>특산기념품 취소요청</strong>
										<span>
											<strong>${nCntRsvSvCancel}</strong>건
										</span>
									</a>
								</li>
								<li>
									<a href="<c:url value='/oss/rsvSvList.do'/>?sRsvStatusCd=RS02">
										<img src="<c:url value='/images/oss/home/progress_icon01.gif'/>" alt="" />
										<strong>특산기념품 미배송</strong>
										<span>
											<strong>${nCntRsvSvRS02}</strong>건
										</span>
									</a>
								</li>
								<li>
									<a href="<c:url value='/oss/tlCancelErrList.do'/>?sRsvStatusCd=RS02">
										<img src="<c:url value='/images/oss/home/progress_icon01.gif'/>" alt="" />
										<strong>TL린칸 취소 오류</strong>
										<span>
											<strong>${nCntTLRsvErr}</strong>건
										</span>
									</a>
								</li>
							</ul>
							<ul class="process_box process02">
								<li>
									<a href="<c:url value='/oss/prdtList.do' />?sTradeStatus=TS08">
										<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
										<strong>실시간 상품 중지요청 </strong>
										<span><strong>${nCntRTPrdtStop}</strong>건</span>
									</a>
								</li>
								<li>
									<a href="<c:url value='/oss/socialProductList.do'/>?sTradeStatus=TS08">
										<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
										<strong>소셜 상품 중지요청</strong>
										<span>
											<strong>${nCntSPPrdtStop}</strong>건
										</span>
									</a>
								</li>
								<li>
									<a href="<c:url value='/oss/svPrdtList.do'/>?sTradeStatus=TS08">
										<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
										<strong>기념품 상품 중지요청</strong>
										<span>
											<strong>${nCntSVPrdtStop}</strong>건
										</span>
									</a>
								</li>
								<li>
									<a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=DESIGN">
										<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="" />
										<strong>디자인 요청건</strong>
										<span>
											<strong>${nCntAdmCmtYn}</strong>건
										</span>
									</a>
								</li>
							</ul>
                        </li>
                    </ul>   
                	<!--//미처리현황, 진행현황-->    
                    
                	<!--총 합계-->
                    <div class="home_total_info">
                    	<ul>
                        	<li>오늘 예약: <fmt:formatNumber value="${cntRsv}"/>건</li>
                        	<li>Active Session Count: ${isConCnt}개</li>
                        	<%--
                        	<li>오늘 취소 요청 : <fmt:formatNumber value="${amtTotal}"/>원</li>
                        	<li>오늘 : <fmt:formatNumber value="${rsvTotCalCnt}"/>건</li>
                        	<li>총 환불금액 : <fmt:formatNumber value="${amtTotCal}"/>원</li>
                        	 --%>
                        </ul>	
                    </div>
                	<!--//총 합계-->
					<%--
                    <!--Help Desk-->
                    <div class="help_desk">
                    	<h3>Help Desk</h3>
                        <strong class="tel"><img src="<c:url value='/images/oss/home/help_icon01.gif'/>" alt="" /><span>1522 – 3454</span></strong>
                        <p>평일업무시간 : 09:00~18:00. 점심시간 : 12:00~13:00</p>
                        <p>* 토요일, 일요일 및 공휴일 휴무</p>
                    </div>
                    <!--//Help Desk-->
                    --%>
                    
                    <div id="footer_wrapper">
					    <p class="footer_text">CopyRight ⓒ 2015 탐나오. All Rights Reserved.</p>
					</div>
                </div>
            	<!--//관리자 홈-->
            </div>
        </div>
		
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>