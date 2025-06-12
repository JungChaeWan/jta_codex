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
<c:choose>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
		<c:set value="관광지/레저" var="ctgrNm"/>
		<c:set value="관광지,레저" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_ETC}">
		<c:set value="음식/뷰티" var="ctgrNm"/>
		<c:set value="음식,뷰티" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C130'}">
		<c:set value="카텔" var="ctgrNm"/>
		<c:set value="카텔" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C170'}">
		<c:set value="골프패키지" var="ctgrNm"/>
		<c:set value="골프패키지" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C160'}">
		<c:set value="버스/택시관광" var="ctgrNm"/>
		<c:set value="버스관광,택시관광" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C120'}">
		<c:set value="에어카텔" var="ctgrNm"/>
		<c:set value="에어카텔" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C140'}">
		<c:set value="에어카" var="ctgrNm"/>
		<c:set value="에어카" var="keys"/>
	</c:when>

	<c:when test="${searchVO.sCtgrTab eq 'C140'}">
		<c:set value="테마여행" var="ctgrNm"/>
		<c:set value="테마여행" var="keys"/>
	</c:when>

	<c:otherwise>
	</c:otherwise>

</c:choose>

<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="${ctgrNm} 목록"/>
	<jsp:param name="keywords" value="제주,제주도 여행,제주도 관광,탐나오,${keys}"/>
	<jsp:param name="description" value="탐나오 ${ctgrNm} 목록"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_package.css'/>">

<script src="<c:url value='/js/jquery.bxslider.js' />"></script>
<script src="<c:url value='/js/slider.js' />"></script>

<script type="text/javascript">
function fn_SpSearch(pageIndex){
	$("#pageIndex").val(pageIndex);
	var parameters = $("#searchForm").serialize();

	$.ajax({
		type:"post",
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mw/sp/spList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			$(".loading-wrap").show();
		},
		success:function(data){
			$(".loading-wrap").hide();
			$("#prdtList").html(data);

			var offset = $("#subContent").offset();
			$('html, body').animate({scrollTop : offset.top}, 200);
		},
		error:fn_AjaxError
	});
}

function fn_MoreSearch(){
	fn_SpSearch(parseInt($("#pageIndex").val()) + 1);
}

function fn_OrderChange(){
	$("#orderCd").val($("#orderSelect>option:selected").val());

	if($("#orderSelect>option:selected").val() == '${Constant.ORDER_DIST}'){
		//alert("거리순");
		fn_ChangeOrderDist();
		return;
	}

	fn_SpSearch(1);
}


/* 거리순 */
function fn_ChangeOrderDist() {

	if(window.navigator.geolocation){
		window.navigator.geolocation.getCurrentPosition(fn_getGPS_Success, fn_getGPS_Error);
	}else{
		alert("위치 정보를 지원 하지않아 제주국제공항을 기준으로 검색 합니다.");
		fn_ChangeOrderDist_process('33.510418','126.4891594');
	}

}

function fn_getGPS_Success(pos){
	//alert(pos.coords.latitude + ":" + pos.coords.longitude);

	//pos.coords.timestamp; // 정보를 얻은 시간 (ms)
	//pos.coords.latitude; // 위도
	//pos.coords.longitude; // 경도
	//pos.coords.accuracy; // 위도, 경도 오차 (m)
	//pos.coords.altitude; // 고도
	//pos.coords.altitudeAccuracy; // 고도 오차 (m)
	//pos.coords.speed; // 진행속도 (m/s)
	//pos.coords.heading; // 정북의 시계방향 각도

	fn_ChangeOrderDist_process(pos.coords.latitude, pos.coords.longitude);
}

function fn_getGPS_Error(error ){
	//alert(code + ":" + message);
	//alert("위치 정보를 얻을수 없어 제주국제공항을 기준으로 검색 합니다.");
	var strMsg="";

	switch(error.code) {
		case error.PERMISSION_DENIED:
			strMsg = "GPS 관련 기능이 차단되 있어서";
	        break;
	    case error.POSITION_UNAVAILABLE:
	    	strMsg = "위치 정보를 찾을 수 없어";
	        break;
	    case error.TIMEOUT:
	    	strMsg = "위치 정보를 얻을 수 있는 시간이 지나서";
	        break;
	    case error.UNKNOWN_ERROR:
	    	strMsg = "위치 정보를 얻을 수 없어";
	        break;
	}
	strMsg += " 제주국제공항을 기준으로 검색 합니다.";
	alert(strMsg);
	fn_ChangeOrderDist_process('33.510418','126.4891594');
}

function fn_ChangeOrderDist_process(lon, lat) {
	$("#orderCd").val("${Constant.ORDER_DIST}");
	$("#sLON").val(lon);
	$("#sLAT").val(lat);

	fn_SpSearch(1);

}

function fn_ChangeTab(carDiv, obj){
	$("#sTabCtgr").val(carDiv);
	$("#top_menu_list>li").removeClass("active");
	$(obj).parent().addClass("active");

	fn_SpSearch(1);
}

function fn_Search(){
	document.frm.action = "<c:url value='/mw/sp/spList.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	menu_slider();

	if("${searchVO.sCtgr}" != ""){
		$("#${searchVO.sCtgrTab}A").trigger("click");
		/* if("${searchVO.sCtgr}" != "C100"){
			fn_ChangeTab("${searchVO.sCtgr}", $("#${searchVO.sCtgr}A"));
		} */
	}else{
		fn_SpSearch($("#pageIndex").val());
	}

	$("#proInfo").change(function() {
		$("#sPrdtDiv").val($("#proInfo option:selected").val());
		fn_SpSearch(1);
	});

	fn_SpSearch(1);

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
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>
			<c:if test="${searchVO.sCtgrDiv eq Constant.CATEGORY_PACKAGE}">패키지 할인상품 조회결과</c:if>
			<c:if test="${searchVO.sCtgrDiv eq Constant.CATEGORY_TOUR}">관광지/레저</c:if>
			<c:if test="${searchVO.sCtgrDiv eq Constant.CATEGORY_ETC}">음식/뷰티</c:if>
		</h2>
	</div>
	<div class="sub-content">
		<!-- md's pick -->
		<c:if test="${((searchVO.sCtgrDiv eq Constant.CATEGORY_TOUR) or (searchVO.sCtgrDiv eq Constant.CATEGORY_ETC)) and fn:length(mdsPickList) > 0 }">
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
        	<input type="hidden" name="sTabCtgr" 	id="sTabCtgr" 	value="${searchVO.sTabCtgr}" />
        	<input type="hidden" name="sPrice" 		id="sPrice" 	value="${searchVO.sPrice}" />
        	<input type="hidden" name="orderCd" 	id="orderCd" 	value="${searchVO.orderCd}" />
        	<input type="hidden" name="sPrdtDiv" 	id="sPrdtDiv" 	value="${searchVO.sPrdtDiv}" />
        	<input type="hidden" name="sAplDt" 		id="sAplDt" 	value="${searchVO.sAplDt}" />
        	<input type="hidden" name="prdtNum" 	id="prdtNum" />
        	<input type="hidden" name="sLON" 		id="sLON" 		value="${searchVO.sLON }" />
        	<input type="hidden" name="sLAT" 		id="sLAT" 		value="${searchVO.sLAT }" />

        	<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
        </form>
        <nav class="top-menu-slider menu-list">
			<div class="pd-wrap">
				<div id="subMenuContainer" class="sm-list">
					<ul id="top_menu_list" class="nav-list">
						<li class="active">
							<a onclick="javascript:fn_ChangeTab('', this);">모든상품 <small>(${ctgrTotalCnt})</small></a>
						</li>
						<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
							<li>
								<a onclick="javascript:fn_ChangeTab('${cntCtgrPrdtList.ctgr}', this); return false;" id="${cntCtgrPrdtList.ctgr}A"><c:out value="${cntCtgrPrdtList.ctgrNm}"/>
								<small>(<c:out value="${cntCtgrPrdtList.prdtCount}"/>)</small></a>
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
						<c:if test="${searchVO.sCtgrDiv ne Constant.CATEGORY_PACKAGE}">
						<option value="${Constant.ORDER_DIST}" <c:if test="${Constant.ORDER_DIST == searchVO.orderCd}">selected="selected"</c:if>>거리순</option>
						</c:if>
					</select>
					<c:if test="${searchVO.sCtgrDiv eq Constant.CATEGORY_PACKAGE}">
						<a href="javascript:void(0);" id="search_btn" class="btn btn7">검색</a>
					</c:if>
					<c:if test="${searchVO.sCtgrDiv ne Constant.CATEGORY_PACKAGE}">
					<select id="proInfo">
						<option value="">모든상품보기</option>
						<option value="FREE">할인쿠폰보기</option>
					</select>
					</c:if>
				</p>
				<!--검색폼-->
				<c:if test="${searchVO.sCtgrDiv eq Constant.CATEGORY_PACKAGE}">
				<div class="con-box">
					<form name="frm" id="frm" method="get" onsubmit="return false;">
						<input type="hidden" name="sCtgr" 		id="sCtgr" 		value="${searchVO.sCtgr}" />
						<div class="form1 form1-0">
							<label>유형</label><br>
							<select style="width: 100%; margin-bottom:10px;" name="sCtgrTab" id="sCtgrTab">
								<option value="${fn:substring(searchVO.sCtgrTab, 0, 2)}00">전체</option>
								<c:forEach items="${categoryList}" var="category" varStatus="status">
									<option value="${category.cdNum}" <%-- <c:if test="${category.cdNum == searchVO.sCtgrTab}">selected</c:if> --%> ><c:out value="${category.cdNm}" /></option>
								</c:forEach>
							</select>
						</div>
						<div class="form1 form1-1">
							<label>여행희망일 / 가격</label><br>
							<span class="cal">
								<input type="text" readonly="readonly" name="sAplDt" id="sAplDt" class="hasDatepicker"><img class="ui-datepicker-trigger" src="/images/jqueryui/calendar_icon01.gif" alt="날짜를 입력하세요" title="날짜를 입력하세요">
							</span>
							<select name="sPrice" id="sPrice">
								<option value="">가격선택</option>
								<option value="end5">~5만원</option>
								<option value="5to10">5만원~10만원</option>
								<option value="start10">10만원~</option>
								<option value="start20">20만원~</option>
							</select>
						</div>
					</form>
					<p class="btn-list btn-in">
						<a href="javascript:fn_Search();" class="btn btn1">검색하기</a>
						<a href="javascript:fn_Reset();" class="btn btn2"><img src="/images/mw/sub_common/reload.png" width="11" alt=""> 초기화</a>
					</p>
				</div> <!--//con-box-->
				</c:if>
				<div id="prdtList">
					<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>

</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<c:if test="${sCtgr eq 'C200' }">
<!-- 관광지/레저-->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'guZDoCqLQMK9kQ9TJmC1Vg'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
</c:if>
<c:if test="${sCtgr eq 'C200' }">
<!-- 음식/뷰티-->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'d164UG9dQ7C8vQ8lNMcIcg'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
</c:if>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>

