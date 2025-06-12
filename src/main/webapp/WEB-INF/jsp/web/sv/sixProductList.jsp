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
<meta name="robots" content="noindex">
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주 농부의 장 목록, 탐나오"/>
	<jsp:param name="description" value="제주산 원물 가공 음식품, 농축산물, 생활용품 등을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다."/>
	<jsp:param name="keywords" value="6차산업,제주,제주도,간식,음료차,식초,유제품,육가공,발효식품,반찬,원물가공,잼,꿀,조청,과일,생활용품,화장품,분재"/>
</jsp:include>
<meta property="og:title" content="제주 농부의 장 목록, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/web/sv/productList.do">
<meta property="og:description" content="제주산 원물 가공 음식품, 농축산물, 생활용품 등을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다." >
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common2.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sv.css'/>" />
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>

<div id="_wrap">
    <div class="mapLocation">
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>6차산업인증</span>
        </div>
    </div>

	<div id="subContents" class="sub_wrap">
		<!-- filter_wrap -->
		<div class="filter_wrap">
			<!-- 0304 탐나는전 check point -->
			<div class="filter_jejupay">
				<div class="pay-check">
					<input type="checkbox" name="payCheck" id="payCheck" value="Y" >
					<label for="payCheck">
						<img src="../../images/web/icon/jeju_pay_icon.png" width="22" height="20" alt="탐나는전">
						<span>탐나는전 가맹점보기</span>
					</label>
				</div>
			</div>
			<!-- //0304 탐나는전 check point -->
			<div class="filter_refine">
				<section>
					<h2>카테고리</h2>
					<div class="categoryMenu">
						<ul>
							<c:forEach items="${tsCdList}" var="tsCdList">
								<li class="item-list <c:if test="${tsCdList.cdNum eq param.sCtgr}">active</c:if>">
									<a class="embrace-item" href="<c:url value='/web/sv/sixProductList.do?sCtgr=${tsCdList.cdNum}'/>"><c:out value="${tsCdList.cdNm}"/></a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</section>
			</div>
		</div><!-- // filter_wrap -->

        <!-- list_wrap -->
        <div class="list_wrap">
            <div class="sv_tab">
				<c:forEach items="${tsCdList}" var="tsCdList">
					<c:if test="${tsCdList.cdNum eq searchVO.sCtgr }">
					<h2 class="sbt"><c:out value="${tsCdList.cdNm}"/></h2>
					</c:if>
				</c:forEach>
			</div>
			<div class="__sort">
                <div class="sort-filter">
                    <ul>
                        <li class="sortSocial1">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SvSearch(1);" class="sort active" value="${Constant.ORDER_GPA}">탐나오 추천순</button>
                        </li>
                        <li class="sortSocial2">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SvSearch(1);" class="sort" value="${Constant.ORDER_SALE}">판매순</button>
                        </li>
                        <li class="sortSocial3">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SvSearch(1);" class="sort" value="${Constant.ORDER_PRICE}">가격순</button>
                        </li>
                        <li class="sortSocial4">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SvSearch(1);" class="sort" value="${Constant.ORDER_NEW}">최신등록순</button>
                        </li>
                    </ul>
                </div>
			</div>

	        <!-- 상품 목록 -->
   			<div class="item-area">
   				<ul class="col4" id="div_productAjax">
   				</ul>
   			</div> <!-- //item-area -->
			<form action="<c:url value='/web/sv/sixProductList.do'/>" name="searchForm" id="searchForm" method="get">
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
				<input type="hidden" name="sCtgr" id="sCtgr" value="${searchVO.sCtgr}" />
				<input type="hidden" name="sSubCtgr" id="sSubCtgr" value="${searchVO.sSubCtgr}" />
				<input type="hidden" name="sCrtnNum" id="sCrtnNum" value="" />
				<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
				<input type="hidden" name="prdtNum" id="prdtNum" />
				<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
				<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" />
			</form>

			<div class="paging-wrap" id="moreBtn">
		    	<%-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>--%>
		    	<a id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
			</div>
   		</div> <!-- // list_wrap -->
   	</div> <!-- //subContents -->
</div>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
<script type="text/javascript">

function fn_SvSearch(pageIndex) {
	$("#searchForm input[name=pageIndex]").val(pageIndex);
	$("#curPage").text(pageIndex);

	//탐나는전checkbox 설정
	if (sessionStorage.getItem("tamnacardChk") == "Y"){
		$("input:checkbox[id='payCheck']").prop("checked", true);
	} else {
		$("input:checkbox[id='payCheck']").prop("checked", false);
	}

	const parameters = $("#searchForm").serialize()+"&sTamnacardYn="+sessionStorage.getItem("tamnacardChk");
	$.ajax({
		type:"post",
		url:"<c:url value='/web/sv/sixProductList.ajax'/>",
		data:parameters ,
		success:function(data){
			if (pageIndex == 1) {
				$("#div_productAjax").html("");
				$('#moreBtn').show();
			}

			$("#div_productAjax").append(data);

			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));

			if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
				$('#moreBtn').hide();

			var offset = $("#tabs").offset();
			$('html, body').animate({scrollTop : offset.top}, 0);

		},
		error:function(request,status,error){
	    //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function fn_SvSearchNoSrc(pageIndex) {
	$("#searchForm input[name=pageIndex]").val(pageIndex);
	$("#curPage").text(pageIndex);

	//탐나는전checkbox 설정
	if (sessionStorage.getItem("tamnacardChk") == "Y"){
		$("input:checkbox[id='payCheck']").prop("checked", true);
	} else {
		$("input:checkbox[id='payCheck']").prop("checked", false);
	}

	const parameters = $("#searchForm").serialize()+"&sTamnacardYn="+sessionStorage.getItem("tamnacardChk");
	$.ajax({
		type:"post",
		url:"<c:url value='/web/sv/sixProductList.ajax'/>",
		data:parameters ,
		success:function(data){
			if (pageIndex == 1) {
				$("#div_productAjax").html("");
				$('#moreBtn').show();
			}

			$("#div_productAjax").append(data);

			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));

			if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
				$('#moreBtn').hide();

			if($(".item-area .list-item").length > 0){
				$(".item-noContent").hide();
			}
		},
		error:function(request,status,error){
	     //   alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function fn_ChangeTab(tabCtgr, tabSubCtgr, obj){
	$("#sCtgr").val(tabCtgr);
	$("#sSubCtgr").val(tabSubCtgr);
	$("#menuTab li").removeClass("select");
	$(obj).parent().addClass("select");
	$(obj).parents('.depth2').parent('li').addClass("select");

	fn_SvSearchNoSrc("1");
}

function fn_ChangeOrder(sOrder, obj){
	$("#orderCd").val(sOrder);
	$('#orderUl li').removeClass('select');

	$(obj).parent().addClass('select')
	fn_SvSearchNoSrc("1");
}

function fn_ChangeOrderDist( lat, lon) {
	$("#sLON").val(lon);
	$("#sLAT").val(lat);

	fn_ChangeOrder('${Constant.ORDER_DIST}', $(".distance a"));
	close_popup($('.map-wrap'));
}

function fn_DetailPrdt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/web/sv/detailPrdt.do'/>";
	document.frm.submit();
}

$(function () {
	if($("#sCtgr").val() == ""){
		if("${searchVO.sCtgr}" != ""){
			fn_ChangeTab("${searchVO.sCtgr}", "${searchVO.sSubCtgr}", $("#${searchVO.sCtgr}A"));
		}else{
			fn_SvSearchNoSrc($("#pageIndex").val());
		}
	}else{
		fn_ChangeTab($("#sCtgr").val() , $("#sSubCtgr").val() , $("#" + $("#sCtgr").val() + "A"));
	}
});

/**
 * 정렬 순서 변경
 */
function fn_OrderChange(orCd){
    $(".sort-filter button").removeClass("active");
    if(orCd == "${Constant.ORDER_GPA}"){
        $(".sortSocial1 button").addClass("active");
    }else if(orCd == "${Constant.ORDER_SALE}"){
        $(".sortSocial2 button").addClass("active");
    }else if(orCd == "${Constant.ORDER_PRICE}"){
        $(".sortSocial3 button").addClass("active");
    }else if(orCd == "${Constant.ORDER_NEW}"){
        $(".sortSocial4 button").addClass("active");
    }
    var orAs;
    if (orCd == "${Constant.ORDER_PRICE}") {
        orAs = "${Constant.ORDER_ASC}";
    } else {
        orAs = "${Constant.ORDER_DESC}";
    }
    $("#orderCd").val(orCd);
    $("#orderAsc").val(orAs);
}

function tabFunc(param) {
    // $(".category-nav__list").hide();
    $("." + param).show();
    $(".category-nav__item a").removeClass("on");

    if(param == "all"){
        $(".tab-s1 a").addClass("on");
    }else if(param == "nav1"){
        $(".tab-s2 a").addClass("on");
    }else if(param == "nav2"){
        $(".tab-s3 a").addClass("on");
    }else if(param == "nav3"){
        $(".tab-s4 a").addClass("on");
    }else if(param == "nav4") {
        $(".tab-s5 a").addClass("on");
    }else if(param == "nav5") {
        $(".tab-s6 a").addClass("on");
    }else if(param == "nav6") {
        $(".tab-s7 a").addClass("on");
    }else if(param == "nav7") {
        $(".tab-s8 a").addClass("on");
    }else if(param == "nav8") {
        $(".tab-s9 a").addClass("on");
    }
}

$(document).ready(function(){
	$(".category-nav__item >  a").click( function() {
		$(this).prop('href', $(this).attr("href") + "&orderCd=" + $("#orderCd").val() );
	});

	$(".sort-filter button").removeClass("active");
	if($("#orderCd").val() == ""){
		$("#orderUl>li").eq(0).addClass("select");
	}else if($("#orderCd").val() == "${Constant.ORDER_SALE}"){
		$(".sortSocial2 button").addClass("active");
	}else if($("#orderCd").val() == "${Constant.ORDER_PRICE}"){
		$(".sortSocial3 button").addClass("active");
	}else if($("#orderCd").val() == "${Constant.ORDER_NEW}"){
		$(".sortSocial4 button").addClass("active");
	}else if($("#orderCd").val() == "${Constant.ORDER_GPA}"){
		$(".sortSocial1 button").addClass("active");
	}

	//event slider
	if($('#specialty_slider ul li').length > 1) {                	//2개 이상시 실행
        $('#specialty_slider ul').after('<div id="specialty_nav" class="slider-nav">').cycle({
            pager:'#specialty_nav',
            prev: '#specialty_prev',
            next: '#specialty_next',
            timeout: 5000
        });
        $('#specialty_btn').show();                         		//paging show
	}

	//hot item
	if($('#hot_item > ul > li').length > 1) {                		//2개 이상시 실행
		$("#hot_item").jCarouselLite({
            visible: 2,
            auto: 5000,
            btnNext: "#specialtyHot_next",
            btnPrev: "#specialtyHot_prev",
            vertical: true
        });
		$('#hot_btn').show();                         				//button show
	}

	$('#moreBtnLink').click(function() {
        if(Number($("#pageIndex").val()) < Number($("#pageInfoCnt").attr('totalPageCnt')) ){
        	fn_SvSearchNoSrc(eval($("#pageIndex").val()) + 1);
        }
	});

	$('#payCheck').click(function (){
		//탐나는전 session 설정
		if ($("#payCheck").is(":checked") == true) {
			sessionStorage.setItem("tamnacardChk","Y");
		} else{
			sessionStorage.setItem("tamnacardChk","N");
		}

		fn_SvSearchNoSrc(1);
	});
});
</script>
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