<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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
<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_package.css'/>">

<script src="<c:url value='/js/jquery.bxslider.js' />"></script>
<script src="<c:url value='/js/slider.js' />"></script>	
<script type="text/javascript">
function fn_SvSearch(pageIndex){
	$("#pageIndex").val(pageIndex);
	var parameters = $("#searchForm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mw/sv/svList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			$(".loading-wrap").show();
			$("#prdtList").html("");
		},
		success:function(data){
			$(".loading-wrap").hide();
			$("#prdtList").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_MoreSearch(){
	fn_SvSearch(parseInt($("#pageIndex").val()) + 1);
}

function fn_OrderChange(){
	$("#orderCd").val($("#orderSelect>option:selected").val());
	
	fn_SvSearch(1);
}

function fn_ChangeTab(carDiv, carSubDiv, obj){
	$("#sCtgr").val(carDiv);
	$("#sSubCtgr").val(carSubDiv);
	$("#top_menu_list>li").removeClass("active");
	$(obj).parent().addClass("active");
	$(obj).parents('.depth2').parent('li').addClass("active");
	
	fn_SvSearch(1);
}

function fn_Search(){
	document.frm.action = "<c:url value='/mw/sv/svList.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	menu_slider();
	
	if("${searchVO.sCtgr}" != ""){
		$("#${searchVO.sCtgr}A").trigger("click");
	}else{
		fn_SvSearch($("#pageIndex").val());
	}
	
	$("#proInfo").change(function() {
		$("#sPrdtDiv").val($("#proInfo option:selected").val());
		fn_SvSearch(1);
	});
	
	fn_SvSearch(1);
	
	$('#search_btn').on('click', function() {
		if($('.con-box').css('display')=='none') {
			$(this).text('닫기');
			$('.con-box').css('display', 'block');
			
		}
		else {
			$(this).text('검색');
			$('.con-box').css('display', 'none');
		}
	}); 
	
	// md's pick slider
	$("#md_list").jCarouselLite({
		btnNext: "#md_sliderBTN",
		btnPrev: "",
		vertical: true,
		visible: 1,
		circular: true,
		auto: 5000,
	});
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>제주특산/기념품</h2>
	</div>
	<div class="sub-content">
		<!-- md's pick -->
		<c:if test="${fn:length(mdsPickList) > 0 }">
		<div class="item-box article-list"> <!-- 상품없을 시 통으로 삭제 -->
			<div class="event-list">
				<div id="md_list">
					<ul>
						<c:forEach items="${mdsPickList }" var="mds">
						<li>
							<a href="<c:url value='/mw/coustomer/mdsPickDtl.do?rcmdNum=${mds.rcmdNum }' />">
								<span class="photo"><img src="<c:url value='${mds.listImgPath }' />" alt="product"></span>
								<span class="text">${mds.subject }</span>
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="fixed">
					<p class="icon"><img src="<c:url value='/images/mw/menu/md_label.png' />" alt="MD's Pick"></p>
					<button id="md_sliderBTN" type="button"><img src="<c:url value='/images/mw/main/alim_btn.jpg' />" alt="button"></button>
				</div>
			</div>
		</div>
		</c:if>
		
		<form name="searchForm" id="searchForm" method="get">
        	<input type="hidden" name="pageIndex" 	id="pageIndex" 	value="${searchVO.pageIndex}" />
        	<input type="hidden" name="sCtgr" 		id="sCtgr" 		value="${searchVO.sCtgr}" />
        	<input type="hidden" name="sSubCtgr"	id="sSubCtgr"	value="${searchVO.sSubCtgr}" />
        	<input type="hidden" name="orderCd" 	id="orderCd" 	value="${searchVO.orderCd}" />
        	<input type="hidden" name="prdtNum" 	id="prdtNum" />	
        </form>
        <nav class="top-menu-slider menu-list">
			<div class="pd-wrap">
				<div id="subMenuContainer" class="sm-list">
					<ul id="top_menu_list" class="nav-list depth2-nav">
						<li class="active">
							<a onclick="javascript:fn_ChangeTab('', '', this);">전체 <small>(${ctgrTotalCnt})</small></a>
						</li>
						<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
							<li>
								<a href="#" id="${cntCtgrPrdtList.ctgr}A"><c:out value="${cntCtgrPrdtList.ctgrNm}"/> 
								<small>(<c:out value="${cntCtgrPrdtList.prdtCount}"/>)</small></a>
								<div class="depth2">
									<h3 class="title"><c:out value="${cntCtgrPrdtList.ctgrNm}"/></h3>
									<ul>
										<c:forEach items="${subCtgrMap[cntCtgrPrdtList.ctgr] }" var="subCtgr">
										<li><a href="#" onclick="javascript:fn_ChangeTab('${cntCtgrPrdtList.ctgr}','${subCtgr.cdNum}', this); return false;">${subCtgr.cdNm }</a></li>
										</c:forEach>
									</ul>
									<a href="#" class="close-x"><img src="<c:url value='/images/mw/icon/close_depth2.png'/>" alt="닫기"></a>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<span id="btnSubMenusPrev" class="scroll-prev"><img src="<c:url value='/images/mw/menu/prev.png'/>" alt="prev"></span>
			<span id="btnSubMenusNext" class="scroll-next"><img src="<c:url value='/images/mw/menu/next.png'/>" alt="next"></span>
		</nav>
		<%-- <p class="sub-tabs">
			<a onclick="javascript:fn_ChangeTab('', this);" class="active">모든<br>상품<br>(<c:out value="${ctgrTotalCnt}" />)</a>
			<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
			<a onclick="javascript:fn_ChangeTab('${cntCtgrPrdtList.ctgr}', this); return false;" id="${cntCtgrPrdtList.ctgr}A"><c:out value="${cntCtgrPrdtList.ctgrNm}"/><br>
				<em>(<c:out value="${cntCtgrPrdtList.prdtCount}"/>)</em>
            </a>
            </c:forEach>
		</p> --%>
		<div class="package">
			<div class="search-container">
				<p class="comm-sort">
					<select id="orderSelect" onchange="fn_OrderChange()">
						<option value="${Constant.ORDER_SALE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_SALE}">selected</c:if>>판매순</option>
						<option value="${Constant.ORDER_PRICE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_PRICE}">selected</c:if>>가격순</option>
						<option value="${Constant.ORDER_NEW}" <c:if test="${searchVO.orderCd eq Constant.ORDER_NEW}">selected</c:if>>최신상품순</option>
						<option value="${Constant.ORDER_GPA}" <c:if test="${searchVO.orderCd eq Constant.ORDER_GPA}">selected</c:if>>추천순</option>
					</select>
				</p>
				<div id="prdtList">
					<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
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

	