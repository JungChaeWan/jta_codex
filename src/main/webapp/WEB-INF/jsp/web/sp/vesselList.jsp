<!DOCTYPE html>
<html lang="ko">
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

<jsp:include page="/web/includeJs.do" >
	<jsp:param name="title" value="${ctgrNm} 목록"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 탐나오,${keys}"/>
	<jsp:param name="description" value="탐나오 ${ctgrNm} 목록"/>
	<jsp:param name="headTitle" value="제주도 ${ctgrNm}"/>
</jsp:include>



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style-md.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/sp/vesselList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/sp/vesselList.do?sCtgr=C190">


<script>
	function fn_ClickSearch(pageIndex) {
		$("#searchForm input[name=sTabCtgr]").val('');
		$("#orderCd").val('');
		$("#searchForm input[name=pageIndex]").val(pageIndex)

		$("#sCtgr").val($("input:radio[name=sCtgrV]:checked").val());
		$("#sPrice").val($("input:radio[name=sPriceV]:checked").val());

		$("#searchForm").submit();
	}

	function fn_SpSearchNoSrc(pageIndex) {
		$("#searchForm input[name=pageIndex]").val(pageIndex);
		$("#curPage").text(pageIndex);

		var parameters = $("#searchForm").serialize();
				$.ajax({
					type : "post",
					/*async: false,*/
					url : "<c:url value='/web/sp/vesselList.ajax'/>",
					data : parameters,
                    beforeSend:function(){

                        if (pageIndex == 1) {
                            // $("#div_productAjax").html("");
                            $("#div_productAjax2").html("");
                        }
                        $(".loading-wrap").show();
                        $('#moreBtn').show();
                    },
					success : function(data) {
						if (pageIndex == 1) {
							// $("#div_productAjax").html("");
							$("#div_productAjax2").html("");
							$('#moreBtn').show();
						}
                        $('.loading-wrap').hide();
						// $("#div_productAjax").append(data);
						$("#div_productAjax2").append(data);
						$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));

						if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
							$('#moreBtn').hide();


						// $("#div_productAjax [data-corpid]").each(function() {
						// 	if($(this).attr("data-corpid") != "CSPT190003"){
						// 	    $(this).remove();
						// 	}
						// });
						$("#div_productAjax2 [data-corpid]").each(function() {
							if($(this).attr("data-corpid") == "CSPT190003"){
							    $(this).remove();
							}
						});

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
	$("[data-priority]").each(function() {
		var RandVal = Math.floor(Math.random()*(10-0+10)) + 0;
		$(this).attr("data-priority",RandVal);
	});

	var sort = $("div.prdtArea").sort(function (a, b) {
		/** 랜덤소트*/
		var contentA =parseInt( $(a).attr('data-priority'));
		var contentB =parseInt( $(b).attr('data-priority'));
		return (contentA < contentB) ? -1 : (contentA > contentB) ? 1 : 0;

	});

	$("#topPrdtArea").html(sort);


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
		fn_SpSearchNoSrc(eval($("#pageIndex").val()) + 1);
	});

	fn_SpSearchNoSrc($("#pageIndex").val());

});
</script>

</head>
<body>
	<header id="header">
		<jsp:include page="/web/head.do" ></jsp:include>
	</header>
	
    <div id="_wrap">
		<div class="socialTx vesselBack">
            <div class="inner">
				<form action="<c:url value='/web/sp/packageList.do'/>" name="searchForm" id="searchForm" method="get">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
					<input type="hidden" name="sCtgr" id="sCtgr" value="${searchVO.sCtgr}" />
					<input type="hidden" name="sTabCtgr" id="sTabCtgr" value="${searchVO.sTabCtgr}" />
					<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
					<input type="hidden" name="prdtNum" id="prdtNum" />
					<%-- <input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}"/>통합검색 더보기를 위함 --%>
					<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
				</form>            
                <div class="vesselTitle">
                    <div class="title">제주 크루즈여행</div>
                    <div class="sub_title">제주 여행의 시작! 럭셔리 크루즈를 만나다!</div>
                </div>
            </div>
        </div>
        
        <div class="topPrdtArea">
<%--            <div class="prdtArea" data-priority="1">--%>
<%--                <div class="product-slide-area">--%>
<%--                    <div class="inner">--%>
<%--                        <h2 class="title">씨월드고속훼리주식회사</h2>--%>
<%--                        <span>Seaworld Express Ferry Ltd</span>--%>
<%--                        <div class="goRegion">--%>
<%--                            <div class="goList">제주 - 목포</div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="socialItem vessel">--%>
<%--                    <h2 class="sec-caption">선박 목록</h2>--%>
<%--                    <div class="inner">--%>
<%--                        <div class="item-area">--%>
<%--                            <ul class="col4" id="div_productAjax"></ul>--%>
<%--                        </div> <!-- //item-area -->--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--			</div>--%>
            <div class="prdtArea" data-priority="1">
                <div class="product-slide-area">
                    <div class="inner">
                        <div class="area_flex">
                            <h2 class="title">한일고속페리</h2>
                            <span>Hanil Express Ferry</span>
                            <div class="goRegion">
                            <div class="goList">제주 - 완도 / 여수</div>
                            <div class="goList">제주 - 추자 - 완도</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="socialItem vessel">
                    <h2 class="sec-caption">선박 목록</h2>
                    <div class="inner">
                        <div class="item-area">
                            <ul class="col4" id="div_productAjax2"></ul>
                        </div> <!-- //item-area -->
                    </div>
                </div>           
			</div>
		</div>
	</div>
	<jsp:include page="/web/right.do" ></jsp:include>
	<jsp:include page="/web/foot.do" ></jsp:include>
</body>
</html>