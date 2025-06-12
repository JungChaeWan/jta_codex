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
<meta name="robots" content="noindex, nofollow">
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?trova=${search}"/>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="author" content="제주특별자치도관광협회">
<meta name="robots" content="noindex, nofollow">

<link rel="shortcut icon" href="/images/web/favicon/16.ico">
<link rel="shortcut icon" href="/images/web/favicon/32.ico">

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_hotel.css'/>">

<script src="/js/jquery-1.11.1.js"></script>
<script src="/js/mw_style.js"></script>
<script defer src="/js/swiper.js"></script>
<script defer src="/js/common.js"></script>
<script src="/js/mw_common.js"></script>
<script defer src="/js/jquery.cookie.js"></script>
<script defer src="/js/cookie.js"></script>

<%-- GDN --%>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10926637573"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'AW-10926637573');
</script>

<%--키워드 본예산--%>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-818795361"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'AW-818795361');
</script>

<%--키워드 기금예산--%>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10926598396"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'AW-10926598396');
</script>

<%-- GA4 --%>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-FTMM6J180S"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-FTMM6J180S');
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->

<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>검색결과</h2>
	</div>
	<div class="sub-content">

		<!--검색결과 없을 시-->
		<c:if test="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt == 0 }">
		<div class="item-noContent">
			<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png'/>" alt="경고"></p>
			<p class="text">죄송합니다.<br><strong class="comm-color1">"<c:out value='${search}'/>"</strong>에 대한 검색결과가 없습니다.</p>
		</div>
		</c:if>

		<c:if test="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt > 0 }">

			<!--검색결과 존재할 시-->
			<div class="on-ct">
				<h3 class="search-result">
					<strong class="comm-color1">"<c:out value="${search}"/>"</strong>에 대한 <strong class="count"><c:out value="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt}"/></strong>건의 상품검색 결과입니다.
				</h3>

				<div class="search-item keyword-result">

					<c:if test="${adCnt>0}">
						<h4 class="listTitle1">숙박 <span>(<c:out value="${adCnt}"/>)</span>
						  <c:if test="${adCnt>4}">
							<a class="side-btn" href="<c:url value='/mw/ad/productList.do'/>?searchWord=<c:out value="${search}" />">더보기</a>
						  </c:if>
						</h4>
		               	<div id="dataAD">
		               		<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
		               	</div>
		            </c:if>

					<c:if test="${rcCnt>0}">
		               	<h4 class="listTitle1">렌터카 <span>(<c:out value="${rcCnt}"/>)</span>
		               	  <c:if test="${rcCnt>4}">
							<a class="side-btn" href="<c:url value='/mw/rentcar/car-list.do'/>?searchWord=<c:out value="${search}"/>&sPrdtNm=<c:out value="${search}"/>&searchYn=N&sFromDt=${rcSearch.sFromDt}&sFromDtView=${rcSearch.sFromDtView}&sFromTm=1200&sToDt=${rcSearch.sToDt}&sToDtView=${rcSearch.sToDtView}&sToTm=1200">더보기</a>
						  </c:if>
						</h4>
		               	<div id="dataRC">
		               		<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
	    	           	</div>
	    	        </c:if>

					<c:if test="${packageCnt>0}">
	               		<h4 class="listTitle1">여행사 상품 <span>(<c:out value="${packageCnt}"/>)</span>
	               		  <c:if test="${packageCnt>5}">
							<a class="side-btn" href="<c:url value='/mw/tour/jeju.do'/>?sCtgrTab=C100&sCtgr=C100&searchWord=<c:out value="${search}" />&orderCd=GPA">더보기</a>
						  </c:if>
						</h4>
	               		<div id="dataPackage">
	               			<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
	               		</div>
	               	</c:if>

					<c:if test="${tourCnt>0}">
	               		<h4 class="listTitle1">관광지/레저 <span>(<c:out value="${tourCnt}"/>)</span>
	               		  <c:if test="${tourCnt>4}">
							<a class="side-btn" href="<c:url value='/mw/tour/jeju.do'/>?sCtgr=C200&searchWord=<c:out value="${search}" />&orderCd=GPA">더보기</a>
						  </c:if>
						</h4>
		               	<div id="dataTure">
		               		<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
	    	           	</div>
	    	        </c:if>

					<c:if test="${foodCnt>0}">
	               		<h4 class="listTitle1">맛집 <span>(<c:out value="${foodCnt}"/>)</span>
	               		  <c:if test="${foodCnt>4}">
							<a class="side-btn" href="<c:url value='/mw/tour/jeju.do'/>?sCtgr=C300&searchWord=<c:out value="${search}" />&orderCd=GPA">더보기</a>
						  </c:if>
						</h4>
	               		<div id="dataFood">
	               			<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
	               		</div>
	               	</c:if>

					<c:if test="${strollerCnt>0}">
	               		<h4 class="listTitle1">유모차/카시트 <span>(<c:out value="${strollerCnt}"/>)</span>
	               		  <c:if test="${strollerCnt>4}">
							<a class="side-btn" href="<c:url value='/mw/tour/jeju.do'/>?sCtgr=C500&searchWord=<c:out value="${search}" />&orderCd=GPA">더보기</a>
						  </c:if>
						</h4>
	               		<div id="dataStroller">
	               			<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
	               		</div>
	               	</c:if>

					<c:if test="${svCnt>0}">
	               		<h4 class="listTitle1">특산/기념품 <span>(<c:out value="${svCnt}"/>)</span>
	               		  <c:if test="${svCnt>4}">
							<a class="side-btn" href="<c:url value='/mw/sv/productList.do'/>?searchWord=<c:out value="${search}" />&orderCd=GPA">더보기</a>
						  </c:if>
						</h4>
		               	<div id="dataSV">
		               		<div class="loading-wrap" ><img src="<c:url value='/images/mw/sub_common/loading.gif'/>" alt="로딩중"></div>
	    	           	</div>
	    	        </c:if>

				</div>
		</c:if>
			<%--
			<div class="select-box">
				<select id="selectTabs">
					<option value="AD">숙박 <span>(<c:out value="${adCnt}"/>)</span></option>
					<option value="RC">렌터카 <span>(<c:out value="${rcCnt}"/>)</span></option>
					<%-- <option value="GL">골프 <span>(<c:out value="${glCnt}"/>)</span></option> --%
					<option value="PACKAGE">패키지할인상품 <span>(<c:out value="${packageCnt}"/>)</span></option>
					<option value="TOUR">관광지/레저 <span>(<c:out value="${tourCnt}"/>)</span></option>
					<option value="FOOD">음식/뷰티 <span>(<c:out value="${foodCnt}"/>)</span></option>
					<option value="SV">제주특산/기념품 <span>(<c:out value="${svCnt}"/>)</span></option>
				</select>
			</div>
			<p class="comm-sort" id="areaTool">
				<select onchange="fn_OrderChange(this);">
					<option value="">추천순</option>
					<c:forEach var="data" items="${cdAdar}" varStatus="status">
					<option value="${data.cdNum }" <c:if test="${searchVO.sAdAdar==data.cdNum}">selected="selected"</c:if>>${data.cdNm }</option>
                     </c:forEach>
				</select>
			</p>
			<p class="comm-sort" id="prdtTool">
				<select id="orderSelect" onchange="fn_OrderChange(this)">
					<%-- <option value="${Constant.ORDER_DISPER}" <c:if test="${searchVO.orderCd eq Constant.ORDER_DISPER}">selected</c:if>>할인율순</option> --%
					<option value="${Constant.ORDER_SALE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_SALE}">selected</c:if>>판매순</option>
					<option value="${Constant.ORDER_PRICE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_PRICE}">selected</c:if>>가격순</option>
					<option value="${Constant.ORDER_NEW}" <c:if test="${searchVO.orderCd eq Constant.ORDER_NEW}">selected</c:if>>최신상품순</option>
					<option value="${Constant.ORDER_GPA}" <c:if test="${searchVO.orderCd eq Constant.ORDER_GPA}">selected</c:if>>추천순</option>
					<option value="${Constant.ORDER_DIST}" <c:if test="${searchVO.orderCd eq Constant.ORDER_DIST}">selected</c:if>>거리순</option>
				</select>
			</p>
			<div class="search-item">
				<div id="prdtList"></div>
			</div>
			 --%>
		</div> <!--//on-ct-->
	</div>
</section>
<!-- 콘텐츠 e -->
	<form name="cmmfrm" id="cmmfrm" method="get" onSubmit="return false;">
	<input type="hidden" name="pageIndex" id="pageIndex"/>
	<input type="hidden" name="orderCd" id="orderCd"/>
	<input type="hidden" name="orderAsc" id="orderAsc"/>
	<input type="hidden" name="sLON"  id="sLON"/>
	<input type="hidden" name="sLAT" id="sLAT"/>
	<input type="hidden" name="searchWord" value="${search}"/>
	</form>
	<form name="adfrm" id="adfrm" method="get" onSubmit="return false;">
	<input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />
	<input type="hidden" name="sFromDt" value="${adSearch.sFromDt}"/>
	<input type="hidden" name="sToDt" value="${adSearch.sToDt}"/>
	<input type="hidden" name="sNights" value="${adSearch.sNights}"/>
	<input type="hidden" name="sSearchYn" value="N">
	<input type="hidden" name="sAdultCnt" value="2">
	<input type="hidden" name="sChildCnt" value="0">
	<input type="hidden" name="sBabyCnt" value="0">
	</form>
	<form name="rcfrm" id="rcfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sFromDt" value="${rcSearch.sFromDt}"/>
		<input type="hidden" name="sToDt" value="${rcSearch.sToDt}"/>
		<input type="hidden" name="sFromTm" value="${rcSearch.sFromTm}"/>
		<input type="hidden" name="sToTm" value="${rcSearch.sToTm}"/>
	</form>
	<form name="spfrm" id="spfrm" method="get" onSubmit="return false;">
	<input type="hidden" name="sCtgr" />
	</form>
	<form name="svfrm" id="svfrm" method="get" onSubmit="return false;">
	<input type="hidden" name="sCtgr" />
	</form>

<script type="text/javascript">
	function fn_DetailPrdt(prdtNum, corpCd, aplDt){
		var code = prdtNum.substring(0,2);
		if(code=='${Constant.RENTCAR}' ){
			location.href = "<c:url value='/mw/rentcar/car-detail.do'/>?prdtNum="+prdtNum;
		}else if(code=='${Constant.ACCOMMODATION}'){
			// 숙소 시작일 ~ 종료일 구하기.
			// 예약마감 상태일 경우 빈문자열로 전달하면 controller에서 설정함.
			let strDate = "";
			let strDate2 = "";
			if (aplDt){
				var strApl = fn_addDate(aplDt);
				var arrApl = strApl.split('-');
				var date1 = new Date(arrApl[0], arrApl[1]-1, arrApl[2]);
				date1.setDate(date1.getDate() + 1)
				var yy = date1.getFullYear();
				var mm = date1.getMonth()+1; mm = (mm < 10) ? '0' + mm : mm;
				var dd = date1.getDate(); dd = (dd < 10) ? '0' + dd : dd;
				strDate = yy + '-' +  mm  + '-' + dd;
				strDate2 = strDate.replace(/-/gi, "");
			}
			location.href = "<c:url value='/mw/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum+"&sFromDtView="+fn_addDate(aplDt)+"&sFromDt="+aplDt+"&sToDtView="+strDate+"&sToDt="+strDate2+"&sSearchYn=${Constant.FLAG_N}";
		}else if(code=='${Constant.SOCIAL}'){
			location.href = "<c:url value='/mw/sp/detailPrdt.do'/>?prdtNum="+prdtNum;
		}else if(code=='${Constant.SV}'){
			location.href = "<c:url value='/mw/sv/detailPrdt.do'/>?prdtNum="+prdtNum;
		}
	}

	function fn_AdSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		$("#orderCd").val("GPA");
		var parameters = $("#cmmfrm").serialize() + "&" + $("#adfrm").serialize()+"&totSch=Y";

		$.ajax({
			type:"post",
			url:"<c:url value='/mw/ad/adList.ajax'/>",
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#prdtList").html(data);
				$("#dataAD").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_RcSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		var parameters = $("#cmmfrm").serialize() + "&" + $("#rcfrm").serialize()+"&totSch=Y";

		$.ajax({
			type:"post",
			// dataType:"json",
			// async:false,
			url:"<c:url value='/mw/rc/rcList.ajax'/>",
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#prdtList").html(data);
				$("#dataRC").html(data);
			},
			error:fn_AjaxError
		});
	}

	/*
	function fn_SpSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "<c:url value='/mw/sp/productList.ajax'/>";

		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				$(".loading-wrap").show();
			},
			success:function(data){
				$(".loading-wrap").hide();
				$("#prdtList").html(data);
			},
			error:fn_AjaxError
		});
	}
	*/

	function fn_SpSearchPackage(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		$("#orderCd").val("GPA");
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_PACKAGE}");

		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "<c:url value='/mw/sp/productList.ajax'/>";

		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				$("#dataPackage").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_SpSearchTure(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_TOUR}");

		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "<c:url value='/mw/sp/productList.ajax'/>";

		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				$("#dataTure").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_SpSearchFood(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_ETC}");

		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "<c:url value='/mw/sp/productList.ajax'/>";

		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				$("#dataFood").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_SpSearchStroller(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_BABY_SHEET}");

		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "<c:url value='/mw/sp/productList.ajax'/>";

		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				$("#dataStroller").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_SvSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		var parameters = $("#cmmfrm").serialize() + "&" + $("#svfrm").serialize()+"&totSch=Y";
		var url = "<c:url value='/mw/sv/productList.ajax'/>";

		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#prdtList").html(data);
				$("#dataSV").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_OrderChange(obj){
		var strHtml = "";
		strHtml += '<div class="loading-wrap">';
		strHtml += '<img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중">'
		strHtml += '</div>';
		$("#prdtList").html(strHtml);

	//	$("#orderCd").val( obj.value );
		$("#orderCd").val( '${Constant.ORDER_GPA}' );

		$("#sAdAdar").val( obj.value );

		if(obj.value == '${Constant.ORDER_DIST}'){
			//alert("거리순");
			fn_ChangeOrderDist();
			return;
		}

		fn_AdSearch(1);
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

	$(document).ready(function(){
		/*
		$("#selectTabs").change(function() {
			var type = $("#selectTabs").val();

			if(type == "AD") {
				$('#prdtTool').hide();
				$('#areaTool').show();
				fn_AdSearch(1);
			} else if(type == "RC") {
				$('#prdtTool').show();
				$('#areaTool').hide();
				fn_RcSearch(1);
			} else if(type == "GL") {
				$('#prdtTool').show();
				$('#areaTool').hide();
				fn_GlSearch(1);
			} else if(type == "PACKAGE") {
				$('#prdtTool').show();
				$('#areaTool').hide();
				$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_PACKAGE}");
				fn_SpSearch(1);
			} else if(type == "TOUR") {
				$('#prdtTool').show();
				$('#areaTool').hide();
				$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_TOUR}");
				fn_SpSearch(1);
			} else if(type == "FOOD") {
				$('#prdtTool').show();
				$('#areaTool').hide();
				$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_ETC}");
				fn_SpSearch(1);
			} else if(type == "SV") {
				$('#prdtTool').show();
				$('#areaTool').hide();
				fn_SvSearch(1);
			}

		});

		if(parseInt("${adCnt}") > 0){
			$('#prdtTool').hide();
			$('#areaTool').show();
			fn_AdSearch(1);
		}else if(parseInt("${rcCnt}") > 0){
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#selectTabs").val("RC").attr("selected", "selected");
			$("#selectTabs").trigger("change");
		}else if(parseInt("${glCnt}") > 0){
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#selectTabs").val("GL").attr("selected", "selected");
			$("#selectTabs").trigger("change");
		}else if(parseInt("${packageCnt}") > 0){
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#selectTabs").val("PACKAGE").attr("selected", "selected");
			$("#selectTabs").trigger("change");
		}else if(parseInt("${tourCnt}") > 0){
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#selectTabs").val("TOUR").attr("selected", "selected");
			$("#selectTabs").trigger("change");
		}else if(parseInt("${foodCnt}") > 0){
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#selectTabs").val("FOOD").attr("selected", "selected");
			$("#selectTabs").trigger("change");
		}else if(parseInt("${svCnt}") > 0){
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#selectTabs").val("SV").attr("selected", "selected");
			$("#selectTabs").trigger("change");
		}
		*/

		if("${adCnt}">0) fn_AdSearch(1);
		if("${rcCnt}">0) fn_RcSearch(1);
		if("${packageCnt}">0) fn_SpSearchPackage(1);
		if("${tourCnt}">0) fn_SpSearchTure(1);
		if("${foodCnt}">0) fn_SpSearchFood(1);
		if("${strollerCnt}">0) fn_SpSearchStroller(1);
		if("${svCnt}">0) fn_SvSearch(1);
	});
</script>

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 쇼핑몰에서 검색을 이용한 제품찾기 페이지 -->
<script language='javascript'>
   var m_skey='<c:out value='${search}'/>';
</script>

<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->
</body>
</html>