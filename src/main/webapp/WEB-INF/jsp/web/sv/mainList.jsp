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
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주 특산 기념품 목록"/>
	<jsp:param name="keywords" value="제주, 특산물, 기념품, 탐나오"/>
	<jsp:param name="description" value="탐나오 제주특산/기념품 목록"/>
	<jsp:param name="headTitle" value="제주도 제주 특산 기념품"/>
</jsp:include>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common2.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sv.css?version=${nowDate}'/>" />
<link rel="canonical" href="https://www.tamnao.com/web/sv/mainList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/sv/mainList.do">

<script type="text/javascript">
$(document).ready(function(){
	//Top Banner Slider
	if($('#main_top_slider .swiper-slide').length > 1) {
		var swiper = new Swiper('#main_top_slider', {
	        pagination: '#main_top_navi',
	        nextButton: '#main_top_next',
	        prevButton: '#main_top_prev',
	        paginationClickable: true,
	        autoplay: 5000,
	        loop: true
	    });
	}
	else {
		$('#main_top_arrow').hide();
	}
	
	 /* 특산기념품 Slider*/
	for(var i=0; i<=$('.qurationList').length; i++){	
 	    if($('#qu'+i+' .swiper-slide').length > 1) {
	        new Swiper('#qu'+i, {
	            slidesPerView: 3,
	            spaceBetween: 36,
	            paginationClickable: true,
	            nextButton: '#qu'+i+'_next',
	            prevButton: '#qu'+i+'_prev',
	            autoplay: 2000
	        });
	    }
	    else {
	        $('#product_prev').hide();
	        $('#product_next').hide();
	    }
	}

});

</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do"></jsp:include>
</header>

<div id="_wrap">
    <div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>특산/기념품</span>
	    </div>
	</div>	
    <div class="socialTx">
        <div class="inner">
            <div class="social-title">특산/기념품</div>
            <div class="social-memo">청정지역 제주가 생산한 식품부터 기념품까지 집에서 받아볼 수 있는 제주 직배송</div>
        </div>
    </div>	
	<div id="subContents" class="sub_wrap">
		<!-- filter_wrap -->
		<div class="filter_wrap">
			<div class="filter_refine">
				<section>
					<h3>카테고리</h3>
					<div class="categoryMenu">
						<ul>
							<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
								<c:if test="${cntCtgrPrdtList.ctgr != 'S700'}">
								<li class="item-list active">
									<a href="<c:url value='/web/sv/productList.do?sCtgr=${cntCtgrPrdtList.ctgr}'/>"><c:out value="${cntCtgrPrdtList.ctgrNm}"/></a>
	                               	<c:if test="${fn:length(subCtgrMap[cntCtgrPrdtList.ctgr]) > 1 }">
                               		<ul>
										<c:forEach items="${subCtgrMap[cntCtgrPrdtList.ctgr] }" var="subCtgr">
											<c:if test="${cntCtgrPrdtList.ctgr != 'S700'}">
												<li>
													<a href="<c:url value='/web/sv/productList.do?sCtgr=${cntCtgrPrdtList.ctgr}&sSubCtgr=${subCtgr.cdNum }'/>">${subCtgr.cdNm }</a>
												</li>
											</c:if>
										</c:forEach>
									</ul>			
									</c:if>		
								</li>
								</c:if>										
							</c:forEach>
							<li class="item-list active">
								<a href="javascript:void(0)">슬기로운 제주쇼핑</a>
								<ul>
									<c:forEach items="${crtnList }" var="crtn" varStatus="status">
									<li>
										<a href="<c:url value='/web/sv/crtnList.do?crtnNum=${crtn.crtnNum}'/>">${crtn.crtnNm }</a>
									</li>
									</c:forEach>
								</ul>
							</li>
						</ul>
					</div>
				</section>
                <section>
                    <h3>브랜드</h3>
                    <div class="categoryMenu">
	                    <ul>
	                    	<li class="item-list active">
	                    		<ul>
		                    		<c:forEach items="${brandPrdtList}" var="brandPrdtList" varStatus="status">
									<li>
										 <a href="<c:url value='/web/sv/productList.do?sCorpId=${brandPrdtList.corpId}&sFlag=Brd'/>">${brandPrdtList.corpAliasNm}</a>
									</li>
									</c:forEach>
								</ul>
							</li>
						</ul>
					</div>
                </section>				
			</div>
		</div><!-- // filter_wrap -->	

		<!-- list_wrap -->
        <div class="list_wrap">
        	<div class="sv_best">
        		<h2 class="sbt"><span class="ftLight">카테고리별</span> 추천상품</h2>
       			<div class="item-area">	
        			<ul class="col4">
        				<c:forEach var="rcmdList" items="${mainCtgrRcmdList}" varStatus="status" end="7">
							<li class="list-item">
	                            <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${rcmdList.prdtNum}'/>" target="_blank">
	                                <div class="box__image">
	                                    <img src="${rcmdList.imgPath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
	                                </div>
	                                <div class="box__information">
	                                    <strong class="bx_label _green"><c:out value='${rcmdList.etcExp}' /></strong>
	                                    <div class="bxTitle"><c:out value="${rcmdList.prdtNm}"/></div>
	                                    <div class="bxEvent"><c:out value="${rcmdList.prdtExp}" default="　"/></div>
	                                    <div class="bxPrice">
	                                        <span class="text__price"><fmt:formatNumber value="${rcmdList.saleAmt}"/></span><span class="text__unit">원</span>
	                                    </div>
	                                    <div class="bxLabel">
	                                    	<c:if test="${rcmdList.eventCnt > 0 }">
	                                        	<span class="main_label eventblue">이벤트</span>
	                                        </c:if>
	                                        <c:if test="${rcmdList.couponCnt > 0 }">
	                                        	<span class="main_label pink">할인쿠폰</span>
	                                        </c:if>
											<c:if test="${rcmdList.tamnacardYn eq 'Y'}">
												<span class="main_label yellow">탐나는전</span>
											</c:if>
	                                    </div>
	                                </div>
	                            </a>							
							</li>
						</c:forEach>
        			</ul>
        		</div>
        	</div>
        	
        	<div class="sv_quration">
        		<c:forEach items="${crtnList }" var="crtn" varStatus="status">
	        		<div class="qurationList">
	        			<h2 class="sbt">${crtn.crtnNm }</h2>
			            <a href="<c:url value='/web/sv/crtnList.do?crtnNum=${crtn.crtnNum}'/>"><span class="con_more" >상품 더 보기 ></span></a>
	        			<div class="product-area">
	        				<div id="qu${status.count}" class="swiper-container swiper-container-horizontal">
	        					<ul class="swiper-wrapper col3">
	        						<c:forEach items="${crtnPrdtMap[crtn.crtnNum] }" var="prdt">
		        						<li class="swiper-slide">
		        							 <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${prdt.prdtNum}'/>" target="_blank">
		        							 	<div class="box__image">
                                            		<img src="<c:url value='${prdt.savePath}thumb/${prdt.saveFileNm}' />" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
                                        		</div>
		                                        <div class="box__information">
		                                            <div class="bxTitle">${prdt.prdtNm}</div>
		                                            <div class="bxPrice">
		                                                <span class="text__price"><fmt:formatNumber value="${prdt.saleAmt}"/></span><span class="text__unit">원</span>
		                                            </div>
		                                        </div>                                        		
		        							</a>
		        						</li>
	        						</c:forEach>
	        					</ul>
	        				</div>
	                        <div class="arrow-box">
	                            <div id="qu${status.count}_next" class="swiper-button-next"></div>
	                            <div id="qu${status.count}_prev" class="swiper-button-prev"></div>
	                        </div>	        				
	        			</div>
	        		</div>
        		</c:forEach>
        	</div>        	
        </div>
	</div>
</div>
<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TNdyOePATUamc8VWDrd-ww'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
<%--<script type="text/javascript">
(function(w, d, a){
    w.__beusablerumclient__ = {
        load : function(src){
            var b = d.createElement("script");
            b.src = src; b.async=true; b.type = "text/javascript";
            d.getElementsByTagName("head")[0].appendChild(b);
        }
    };w.__beusablerumclient__.load(a);
})(window, document, "//rum.beusable.net/script/b200710e130805u687/56055e8501");
</script>--%>
</body>
</html>