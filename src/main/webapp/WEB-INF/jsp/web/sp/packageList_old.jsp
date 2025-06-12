<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>


<c:choose>
	<c:when test="${searchVO.sCtgrTab eq 'C120'}">
		<c:set value="카텔/에어카텔" var="ctgrNm"/>
		<c:set value="카텔,에어카텔" var="keys"/>
	</c:when>
	<%-- <c:when test="${searchVO.sCtgrTab eq 'C130'}">
		<c:set value="카텔" var="ctgrNm"/>
		<c:set value="카텔" var="keys"/>
	</c:when> --%>

	<c:when test="${searchVO.sCtgrTab eq 'C170'}">
		<c:set value="골프패키지" var="ctgrNm"/>
		<c:set value="골프패키지" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C160'}">
		<c:set value="버스/택시관광" var="ctgrNm"/>
		<c:set value="버스관광,택시관광" var="keys"/>
	</c:when>

	<%-- <c:when test="${searchVO.sCtgrTab eq 'C120'}">
		<c:set value="에어카텔" var="ctgrNm"/>
		<c:set value="에어카텔" var="keys"/>
	</c:when> --%>

	<%-- <c:when test="${searchVO.sCtgrTab eq 'C140'}">
		<c:set value="에어카" var="ctgrNm"/>
		<c:set value="에어카" var="keys"/>
	</c:when> --%>

	<%-- <c:when test="${searchVO.sCtgrTab eq 'C140'}">
		<c:set value="테마여행" var="ctgrNm"/>
		<c:set value="테마여행" var="keys"/>
	</c:when> --%>

	<c:when test="${searchVO.sCtgrTab eq 'C420'}">
		<c:set value="여행사 렌터카" var="ctgrNm"/>
		<c:set value="여행사 렌터카" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C410'}">
		<c:set value="여행사 숙박" var="ctgrNm"/>
		<c:set value="여행사 숙박" var="keys"/>
	</c:when>

	<c:otherwise>
		<c:set value="여행사 상품" var="ctgrNm"/>
		<c:set value="여행사 상품" var="keys"/>
	</c:otherwise>

</c:choose>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="${ctgrNm} 목록"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 탐나오,${keys}"/>
	<jsp:param name="description" value="탐나오 ${ctgrNm} 목록"/>
	<jsp:param name="headTitle" value="제주도 ${ctgrNm}"/>
</jsp:include>



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>">


<script>
	function fn_ClickSearch(pageIndex) {
		$("#searchForm input[name=sTabCtgr]").val('');
		$("#orderCd").val('');
		$("#searchForm input[name=pageIndex]").val(pageIndex)

		$("#sCtgr").val($("input:radio[name=sCtgrV]:checked").val());
		$("#sPrice").val($("input:radio[name=sPriceV]:checked").val());

		$("#searchForm").submit();
	}

	function fn_SpSearch(pageIndex) {
		$("#searchForm input[name=pageIndex]").val(pageIndex);
		$("#curPage").text(pageIndex);

		var parameters = $("#searchForm").serialize();
				$.ajax({
					type : "post",
					url : "<c:url value='/web/sp/packageList.ajax'/>",
					data : parameters,
					success : function(data) {

						if (pageIndex == 1) {
							$("#div_productAjax").html("");
							$('#moreBtn').show();
						}

						$("#div_productAjax").append(data);
                        $(".loading-wrap").hide();

						$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));

						if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
							$('#moreBtn').hide();

					//	var offset = $("#menuTab").offset();
					//	$('html, body').animate({scrollTop : offset.top}, 0);
					},
					error : function(request, status, error) {
				//		alert("code:" + request.status + "\n" + "\n" + "error:" + error);
					}
				});
	}

	function fn_SpSearchNoSrc(pageIndex) {
		$("#searchForm input[name=pageIndex]").val(pageIndex);
		$("#curPage").text(pageIndex);

		var parameters = $("#searchForm").serialize();
				$.ajax({
					type : "post",
					/*async: false,*/
					url : "<c:url value='/web/sp/packageList.ajax'/>",
					data : parameters,
                    beforeSend:function(){

                        if (pageIndex == 1) {
                            $("#div_productAjax").html("");
                        }
                        $(".loading-wrap").show();
                        $('#moreBtn').show();
                    },
					success : function(data) {
						if (pageIndex == 1) {
							$("#div_productAjax").html("");
							$('#moreBtn').show();
						}
                        $('.loading-wrap').hide();
						$("#div_productAjax").append(data);

						$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));

						if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
							$('#moreBtn').hide();
					},
					error : function(request, status, error) {
					//	alert("code:" + request.status + "\n" + "\n" + "error:"	+ error);
					}
				});
	}

	function fn_ChangeTab(tabCtgr, obj) {
		$("#sTabCtgr").val(tabCtgr);
		if (tabCtgr != '') {
			$("#sCtgr").val(tabCtgr.substring(0, 2) + "00");
		} else {
			$("#sCtgr").val('C100');
		}
		$("#menuTab li>a").removeClass("select");
		$(obj).addClass("select");

		fn_SpSearchNoSrc("1");
	}

	function fn_ChangeOrder(sOrder, obj) {
		$("#orderCd").val(sOrder);
		$('#orderUl li').removeClass('select');
		$(obj).parent().addClass('select')

		fn_SpSearchNoSrc("1");
	}

	function fn_Reset() {
		$("input:radio[name=sCtgr][value='${fn:substring(searchVO.sCtgr, 0, 2)}00']").prop("checked", "checked");
		$("input:radio[name=sPrice][value='']").prop("checked", "checked");
		$("#sAplDt").val('');
	}

	$(function() {
		$("#sAplDt").datepicker({
			dateFormat : "yy-mm-dd",
			minDate : 0
		});
		
		/*$("#demo3").webwidget_slideshow_dot({
			slideshow_window_width : '336',
			slideshow_window_height : '224',
			slideshow_title_color : '#fff',
			slideshow_foreColor : '#39cba6',
			context : getContextPath,
			directory : "PA" //icon image
		});*/
	});
$(document).ready(function(){
	// fn_ChangeTab($("#sTabCtgr").val(), $("#${searchVO.sCtgrTab}A"));

	if($("#sTabCtgr").val() == ""){
		if("${searchVO.sCtgrTab}" != ""){
			fn_ChangeTab("${searchVO.sCtgrTab}", $("#${searchVO.sCtgrTab}A"));
			// $("#${searchVO.sCtgrTab}LI>a").trigger("click");
		}else{
			fn_SpSearchNoSrc($("#pageIndex").val());
		}
	}else{
		fn_ChangeTab($("#sTabCtgr").val(), $("#" + $("#sTabCtgr").val() + "A"));
	}


	$('#orderUl li').removeClass('select');

	if($("#orderCd").val() == ""){
		$("#orderUl>li").eq(0).addClass("select");
	}else if($("#orderCd").val() == "${Constant.ORDER_SALE}"){
		$("#orderUl>li").eq(0).addClass("select");
	}else if($("#orderCd").val() == "${Constant.ORDER_PRICE}"){
		$("#orderUl>li").eq(1).addClass("select");
	}else if($("#orderCd").val() == "${Constant.ORDER_NEW}"){
		$("#orderUl>li").eq(2).addClass("select");
	}else if($("#orderCd").val() == "${Constant.ORDER_GPA}"){
		$("#orderUl>li").eq(3).addClass("select");
	}

	//Top Slider Item
	if($('#product_slideItem .swiper-slide').length > 3) {			//4개 이상시 실행
		var swiper = new Swiper('#product_slideItem', {
			slidesPerView: 3,
	        paginationClickable: true,
	        spaceBetween: 15,
	        nextButton: '#slideItem_next',
	        prevButton: '#slideItem_prev'
	    });
	}
	else {
		$('#slideItem_arrow').hide();
	}

    $('#moreBtnLink').click(function() {
        if(Number($("#pageIndex").val()) < Number($("#pageInfoCnt").attr('totalPageCnt')) ){
            fn_SpSearchNoSrc(eval($("#pageIndex").val()) + 1);
        }
    });

	fn_SpSearchNoSrc($("#pageIndex").val());

});
</script>

</head>
<body>
	<header id="header">
		<jsp:include page="/web/head.do" flush="false"></jsp:include>
	</header>
	<main id="main">
        <div class="mapLocation">
		    <div class="inner">
		        <span>홈</span> <span class="gt">&gt;</span>
		        <span>여행사 상품</span>
		    </div>
		</div>

		<div class="subContainer">
		    <div class="subHead"></div>
		    <div class="subContents">
		        <!-- Change Contents -->
		        <!-- 여행사 상품 Slide -->
		        <section class="product-slide-area">
		        	<div class="Fasten">
		        		<h2 class="title-type2">여행사 상품</h2>
		        		<p class="title-type2-memo">패키지투어, 단체여행, 개별여행 여행사에서 책임지겠습니다.</p>
		        	  <c:if test="${fn:length(bestProductList) > 0 }">
		        		<div class="product-slide-item">
			        		<div id="product_slideItem" class="swiper-container">
							    <ul class="swiper-wrapper">
							      <c:forEach items="${bestProductList}" var="bestProduct">
							        <li class="swiper-slide">
                                        <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${bestProduct.prdtNum}'/>">
							        		<div class="photo">
							        		  <c:if test="${not empty bestProduct.prmtContents }">
							        			<span class="text-tag">${bestProduct.prmtContents }</span>
							        		  </c:if>
											    <img class="product" src="<c:url value='${bestProduct.savePath}thumb/${bestProduct.saveFileNm}'/>" alt="product">
											</div>
											<div class="text">
												<div class="title"><c:out value='${bestProduct.prdtNm}'/></div>
												<div class="price"><fmt:formatNumber value='${bestProduct.saleAmt}' type='number' />원</div>
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
	        		  </c:if>
		        	</div>
		        </section>

		        <!-- 추천여행사 -->
		      <c:if test="${fn:length(corpRcmdList) > 0 }">
		        <c:set var="C160Cnt" value="0" />
		        <c:set var="C170Cnt" value="0" />
		        <c:forEach items="${corpRcmdList }" var="corp">
				  <c:if test="${corp.rcmdDiv eq 'C160' }">
				    <c:set var="C160Cnt" value="${C160Cnt + 1 }" />
				  </c:if>
				  <c:if test="${corp.rcmdDiv eq 'C170' }">
				    <c:set var="C170Cnt" value="${C170Cnt + 1 }" />
				  </c:if>
				</c:forEach>

		        <section class="recommend-travel">
		        	<div class="Fasten">
					    <h2 class="title-type3"><img src="<c:url value='/images/web/title/recommend.png' />" alt="" class="icon"> 탐나오 추천 여행사</h2>
					  <c:if test="${C160Cnt > 0 }">
					    <div class="travel-agency first">
					    	<h3 class="recommend-title"><img src="<c:url value='/images/web/travel/request-tour.png' />" alt="단체관광 견적문의"></h3>
					    	<ul class="recommend-list">
					    	  <c:forEach items="${corpRcmdList }" var="corp">
					    	    <c:if test="${corp.rcmdDiv eq 'C160' }">
					    		<li>
					    			<a href="<c:url value='/web/sp/corpPrdt.do?sCorpId=${corp.corpId }' />">
					    				<strong class="name">${corp.corpNm }</strong>
					    				<span class="tel"><c:out value="${corp.rsvTelNum}"/></span>
					    			</a>
					    		</li>
					    		</c:if>
					    	  </c:forEach>
					    	</ul>
					    </div> <!-- //travel-agency -->
					  </c:if>
					  <c:if test="${C170Cnt > 0 }">
					    <div class="travel-agency">
					    	<h3 class="recommend-title"><img src="<c:url value='/images/web/travel/request-golf.png' />" alt="골프패키지 견적문의"></h3>
					    	<ul class="recommend-list">
					    	  <c:forEach items="${corpRcmdList }" var="corp">
					    	    <c:if test="${corp.rcmdDiv eq 'C170' }">
					    		<li>
					    			<a href="<c:url value='/web/sp/corpPrdt.do?sCorpId=${corp.corpId }' />">
					    				<strong class="name">${corp.corpNm }</strong>
					    				<span class="tel"><c:out value="${corp.rsvTelNum}"/></span>
					    			</a>
					    		</li>
					    		</c:if>
					    	  </c:forEach>
					    	</ul>
					    </div> <!-- //travel-agency -->
					  </c:if>
				    </div> <!-- //Fasten -->
				</section>
			  </c:if>

		        <!-- 상품 목록 -->
		        <form action="<c:url value='/web/sp/packageList.do'/>" name="searchForm" id="searchForm" method="get">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
					<input type="hidden" name="sCtgr" id="sCtgr" value="${searchVO.sCtgr}" />
					<input type="hidden" name="sTabCtgr" id="sTabCtgr" value="${searchVO.sTabCtgr}" />
					<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
					<input type="hidden" name="prdtNum" id="prdtNum" />
					<%-- <input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}"/>통합검색 더보기를 위함 --%>
					<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
				</form>
		        <section class="product-item-area">
		        	<h2 class="sec-caption">여행사 상품 목록</h2>
	        		<div class="Fasten">
	        			<div id="tabs" class="mainTabMenu1">
						    <ul id="menuTab" class="menuList">
							    <li class="all"><a href="#" onclick="fn_ChangeTab('',this); return false;"<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_PACKAGE}"> class="select"</c:if>>전체</a></li>
						  <c:forEach items="${categoryList}" var="category" varStatus="status">
							<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
							  <c:if test="${category.cdNum eq cntCtgrPrdtList.ctgr and cntCtgrPrdtList.prdtCount > 0}">
							    <c:if test="${category.cdNum ne 'C120' and category.cdNum ne 'C130' }">
							    <li> <a href="#" id="${cntCtgrPrdtList.ctgr}A" onclick="fn_ChangeTab('${cntCtgrPrdtList.ctgr}',this); return false;"<c:if test="${searchVO.sCtgr eq cntCtgrPrdtList.ctgr}"> class="select"</c:if>><c:out value="${cntCtgrPrdtList.ctgrNm}" /></a> </li>
							    </c:if>
							    <c:if test="${category.cdNum eq 'C120' }">
							    <li> <a href="#" id="${cntCtgrPrdtList.ctgr}A" onclick="fn_ChangeTab('${cntCtgrPrdtList.ctgr}',this); return false;"<c:if test="${searchVO.sCtgr eq cntCtgrPrdtList.ctgr}"> class="select"</c:if>>${cntCtgrPrdtList.ctgrNm}</a> </li>
							    </c:if>
							  </c:if>
							</c:forEach>
						  </c:forEach>
							</ul>
					    </div>
	        			<div class="item-area">
	        				<ul class="col4" id="div_productAjax">
	        				</ul>
							<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
	        			</div> <!-- //item-area -->

	        			<div class="paging-wrap" id="moreBtn">
						    <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
						</div>
	        		</div>
	        	</section>
		        <!-- //Change Contents -->

		    </div> <!-- //subContents -->
		</div> <!-- //subContainer -->
	</main>
	<jsp:include page="/web/right.do" flush="false"></jsp:include>
	<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>