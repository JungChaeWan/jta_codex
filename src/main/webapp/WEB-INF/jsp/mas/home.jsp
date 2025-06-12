<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery.cookie.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css?version=1.0'/>" />

<title></title>
<script type="text/javascript">
function closePopupToday(){
	/*$.cookie("masPopup", "Y", {expires: 1, path: "/"});
	$("#notice_container").fadeOut(0);*/
}

$(document).ready(function(){
	/*if($.cookie("masPopup")) {
	   $("#notice_container").hide();
	}else{
	   $("#notice_container").show();
	}*/
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=home" />
	<!--LayerPopup 영역-->
	<div id="notice_container" style="display: none;">
		<div class="notice">
			<div class="notice_title"> 알려드립니다</div>
			<div class="notice_content">
				<p>저희 탐나오에서는 코로나19 여파로 큰 피해를 입고 있는 입점업체의 부담을 줄이고 고통을 분담하기 위한 일환으로 판매수수료를 감면하여 운영하고자 합니다.</p>
				<div class="notice_memo">
					<p>기간 : <b>2020. 4월 ~ 5월</b></p>
					<p>수수료 : </p>
					<p> - 여행상품 (기존) 5.5% → <strong>(변경) 2%</strong></p>
					<p> - 특산/기념품 (기존)  11% → <strong>(변경) 2%</strong></p>
					<p>정산지급 안내<br>
					- 3.26(목) ~ 4.1(수) 사용처리 건 (4.10 지급) 부터<br>
					- 5.21(목) ~ 5.27(수) 사용처리 건 (6.5 지급) 까지
					</p>
				</div>

			</div>
			<div class="notice_close" onclick="closePopupToday();">[닫기]&nbsp;&nbsp;</div>
		</div>
	</div>
	<!--//LayerPopup 영역-->

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
                        		<li><a class="skipStr300" href="<c:url value='/mas/bbs/bbsDtl.do'/>?bbsNum=MASNOTI&noticeNum=${data.noticeNum}"><c:out value="${data.subject}"/></a><span class="date">${fn:substring(data.frstRegDttm, 0, 10)}</span></li>
                        	</c:forEach>
                        </ul>
                        <span class="more"><a href="<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=MASNOTI" title="공지사항 더보기"><img src="<c:url value='/images/oss/home/more_btn01.gif'/>" alt="공지사항 더보기" /></a></span>
                    </div>
                    <div class="latest_post post2">
                    	<h3>1:1문의</h3>
                    	<ul>
                    		<c:forEach var="data" items="${masqaList}" varStatus="status">
                        		<li><a class="skipStr300" href="<c:url value='/mas/${corpCd}/detailOtoinq.do'/>?otoinqNum=<c:out value="${data.otoinqNum}"/>"><c:out value="${data.subject}"/></a><span class="date">${fn:substring(data.frstRegDttm, 0, 10)}</span></li>
                        	</c:forEach>
                        	<!-- 
                        	<li><a href="#">예약이 안됩니다. 문의 드립니다..</a><span class="answer">답변(1)</span><span class="date">15-12-15</span></li>
                        	<li><a href="#">문의드립니다</a><span class="date">15-12-15</span></li>
                        	<li><a href="#">문의드립니다</a><span class="date">15-12-15</span></li>
                        	 -->
                        </ul>
                        <span class="more"><a href="<c:url value='/mas/${corpCd}/otoinqList.do'/>" title="1:1문의 더보기"><img src="<c:url value='/images/oss/home/more_btn01.gif'/>" alt="1:1문의 더보기" /></a></span>
                    </div>		
                	<!--//최근게시물-->
                    
                	<!--미처리현황, 진행현황-->
                    <ul class="process">
                    	<li>
                        	<h3>미처리현황</h3>
                            <ul class="process_box process01">
                            	<li>
                                    <strong>커뮤니티 미답변</strong>
                                    <span>1:1문의：<a href="<c:url value='/mas/${corpCd}/otoinqList.do'/>"> ${otoinqCnt}건</a></span>
                                    <span>상품평：<a href="<c:url value='/mas/${corpCd}/useepilList.do'/>">${useepilCnt}건</a></span>
                                </li>
                            </ul>    
                            <ul class="process_box process02">
                            	<li>
                            		<a href="<c:url value='/mas/${corpCd}/rsvList.do' />">
	                                	<img src="<c:url value='/images/oss/home/progress_icon02.gif'/>" alt="취소요청" />
	                                	<strong>취소 요청건</strong>
	                                    <span><strong>${rsvCalCnt }</strong>건</span>
	                                </a>
                                </li>
								<li>
									<a href="<c:url value='/mas/${corpCd}/productList.do' />?sTradeStatus=TS06">
										<img src="<c:url value='/images/oss/home/progress_icon01.gif'/>" alt="수정요청" />
										<strong>수정 요청건</strong>
										<span><strong>${editCnt}</strong>건</span>
									</a>
								</li>
							</ul>
                        </li>
                    	<li>
                        	<h3>진행현황</h3>
                            <ul class="process_box process02">
                                <li>
                                	<a href="<c:url value='/mas/${corpCd}/rsvList.do' />">
	                                	<img src="<c:url value='/images/oss/home/progress_icon02.gif'/>" alt="오늘예약" />
	                                	<strong>오늘 예약건</strong>
	                                    <span><strong>${rsvTodyaCnt}</strong>건</span>
	                                </a>
                                </li>
                                <li>
	                                <a href="<c:url value='/mas/prmt/promotionList.do' />">
	                                   	<img src="<c:url value='/images/oss/home/progress_icon03.gif'/>" alt="이벤트진행" />
		                               	<strong>이벤트 진행건</strong>
		                                <span>
		                                	<strong>${prmtCnt}</strong>건
		                                </span>
		                            </a>
                                </li>
                            </ul>
                        </li>	
                    </ul>   
                	<!--//미처리현황, 진행현황-->    
                    
                	<!--총 합계-->
                    <%--<div class="home_total_info">
                    	<ul>
                        	<li>총 누적판매수량(취소건 포함) : <fmt:formatNumber value="${rsvTotal}"/>건</li>
                        	<li>총 판매금액 : <fmt:formatNumber value="${amtTotal}"/>원</li>
                        	<li>총 취소수량 : <fmt:formatNumber value="${rsvTotCalCnt}"/>건</li>
                        	<li>총 환불금액 : <fmt:formatNumber value="${amtTotCal}"/>원</li>
                        	<li>총 누적정산금액 : <fmt:formatNumber value="${adjTotal}"/>원</li>
                        </ul>	
                    </div>--%>
                	<!--//총 합계-->
					
                    <!--Help Desk-->
                    <div class="help_desk">
                    	<h3>Help Desk</h3>
                        <strong class="tel"><img src="<c:url value='/images/oss/home/help_icon01.gif'/>" alt="" /><span>1522 – 3454</span></strong>
                        <p>평일업무시간 : 09:00~18:00. 점심시간 : 12:00~13:00</p>
                        <p>* 토요일, 일요일 및 공휴일 휴무</p>
                    </div>
                    <!--//Help Desk-->
                    
                    <div id="footer_wrapper">
					    <p class="footer_text">CopyRight ⓒ 2015 탐나오. All Rights Reserved.</p>
					</div>
                </div>
            	<!--//관리자 홈-->
            </div>
        </div>
    </div>
</div>
</body>
</html>