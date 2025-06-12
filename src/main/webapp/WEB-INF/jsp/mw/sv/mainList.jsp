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

<un:useConstants var="Constant" className="common.Constant" />

<head>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주 특산 기념품 목록"/>
	<jsp:param name="keywords" value="제주, 특산물, 기념품, 탐나오"/>
	<jsp:param name="description" value="탐나오 제주 특산 기념품 목록"/>
</jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sv.css?version=${nowDate}' />">
<link rel="canonical" href="https://www.tamnao.com/web/sv/mainList.do">

<script src="<c:url value='/js/jquery.bxslider.js?version=${nowDate}' />"></script>
<script src="<c:url value='/js/slider.js?version=${nowDate}' />"></script>

<script type="text/javascript">
function doSwiper() {
	screenWidth = $(window).width();
    if (screenWidth < 720) {
        slideCnt = 2;
    } else {
        slideCnt = 3;
    }	
    
    for(var i=0; i<=$('.sv-list').length-1; i++){	
 	    if($('#pop_Slider'+i+' .swiper-slide').length > 1) {
	        new Swiper('#pop_Slider'+i, {
	            spaceBetween: 20,
	            slidesPerView: slideCnt,
	            paginationClickable: true,
	            loop: true
	        });
	    }	
    }
}

// 화면 사이즈 변경 이벤트
$(window).resize(function(){
    var screenWidth2 = $(window).width();

    if(screenWidth2 >= 720) {
        if(screenWidth < 720) {
            doSwiper();
        }
    } else {
        if(screenWidth >= 720) {
            doSwiper();
        }
    }
    $(".bx-wrapper").css("max-width", screenWidth2);
});

$(document).ready(function(){
	//Top Banner Slider
	if($('#from_top_slider .swiper-slide').length > 1) {
		new Swiper('#from_top_slider', {
	        pagination: '#from_top_navi',
	        paginationClickable: true,
	        autoplay: 5000,
	        loop: true
	    });
	}

    // 해시태그
    var tagWidth = parseInt($(window).width() / 3);

    $(".today-keyword ul li a").css("width", tagWidth);

    $(".hashtagSlide").bxSlider({
		minSlides: 3,
		maxSlides: 3,
		slideWidth: tagWidth,
		ticker: true,
		speed: 20000,
		useCSS: false,
		tickerHover: true
    });

    doSwiper();
});
</script>
</head>
<body class="svbody">
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" />
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<div class="sv-List">
		<!-- Top Slider -->
		<c:if test="${fn:length(prmtList) != 0}">
			<div class="from-top-slider">
				<div id="from_top_slider" class="swiper-container">
					<ul class="swiper-wrapper">
						<c:forEach items="${prmtList}" var="prmt" varStatus="status">
							<li class="swiper-slide" style="background-color: #${prmt.bgColorNum}">
								<div class="Fasten">
									<a href="<c:url value='/mw/evnt/detailPromotion.do?prmtNum=${prmt.prmtNum}'/>&type=${fn:toLowerCase(prmt.prmtDiv)}">
										<img src="${prmt.mobileMainImg}" alt="${prmt.prmtNm}">
									</a>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div id="from_top_navi" class="swiper-pagination"></div>
				</div>
			</div> <!-- //from-top-slider -->
		</c:if>
		<!-- //Top Slider -->

		<div class="sv-list according">
	        <div class="con-header">
	            <p class="con-title">카테고리별 추천상품</p>
	        </div>
	        <div id="pop_Slider0" class="swiper-container">
	            <ul class="swiper-wrapper">
	            	<c:forEach var="rcmdList" items="${mainCtgrRcmdList}" varStatus="status">
	                <li class="swiper-slide">
	                    <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${rcmdList.prdtNum}'/>" target="_blank">
	                        <div class="main-photo">
	                        	<img src="${rcmdList.imgPath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
	                        </div>
	                        <div class="main-text">
	                            <%-- <div class="j-info">${rcmdList.etcExp}</div> --%>
	                            <div class="j-title">${rcmdList.prdtNm}</div>
	                            <div class="main-price"><fmt:formatNumber value="${rcmdList.saleAmt}"/><span class="won">원~</span></div>
	                        </div>
	                    </a>
	                 </li>
	                 </c:forEach>
	            </ul>
	        </div>
        </div>

        <c:forEach items="${crtnList }" var="crtn" varStatus="status">
        <div class="sv-list according">
            <div class="con-header">
                <p class="con-title">${crtn.crtnNm }</p>
            </div>
            <div id="pop_Slider${status.count}" class="swiper-container">
                <ul class="swiper-wrapper">
                	<c:forEach items="${crtnPrdtMap[crtn.crtnNum]}" var="prdt">
                    <li class="swiper-slide">
                        <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${prdt.prdtNum}'/>">
                            <div class="main-photo">
                            	<img src="${prdt.savePath}thumb/${prdt.saveFileNm}" alt="${prdt.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">
                            </div>
                            <div class="main-text">
                                <div class="j-title">${prdt.prdtNm}</div>
                                <div class="main-price"><fmt:formatNumber value="${prdt.saleAmt}"/><span class="won">원~</span></div>
                            </div>
                        </a>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        </c:forEach>
	</div> <!--//mw-list-area-->
</main>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TNdyOePATUamc8VWDrd-ww'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>

