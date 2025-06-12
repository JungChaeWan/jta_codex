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
<meta name="robots" content="noindex, nofollow">
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?trova=${search}"/>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="제주특별자치도관광협회">
<meta name="robots" content="noindex, nofollow">

<link rel="shortcut icon" href="<c:url value='/images/web/favicon/16.ico'/>">
<link rel="shortcut icon" href="<c:url value='/images/web/favicon/32.ico'/>">

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=1.2'/>" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />

<script src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<%-- <script src="<c:url value='/js/jquery-ui.js'/>"></script> --%>
<script src="<c:url value='/js/jquery.cookie.js'/>"></script>
<script src="<c:url value='/js/slideshow_dot.js'/>"></script>
<script src="<c:url value='/js/slider.js'/>"></script>
<script src="<c:url value='/js/common.js'/>"></script>
<script src="<c:url value='/js/cookie.js'/>"></script>
<script src="<c:url value='/js/swiper.js'/>"></script>
<script src="<c:url value='/js/html_style.js'/>"></script>
<script defer src="<c:url value='/js/jquery.zoom.min.js'/>"></script>

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
	<header id="header">
		<jsp:include page="/web/head.do" />
	</header>

	<div id="_wrap">
		<c:if test="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt == 0 }">
        	<div class="sh-top">
            <!-- 콘텐츠 없을 시 -->
            	<div class="item-noContent">
	                <p class="text">검색하신<strong class="comm-color1">"<c:out value="${search}" />"</strong>에 대한 <br>검색결과가 없습니다.</p>
	                <span class="side-noContent">다른 검색어를 입력하시거나 철자와 띄어쓰기를 확인해보세요.</span>
	                <span class="noContent_keyword">
	                    <%--<div class="title">이런 상품은 어떠세요?</div>
	                    <ul>
	                        <li>
	                            <a href="">호텔샬롬</a>
	                        </li>
                    	</ul>--%>
                	</span>
            	</div>
        	</div> <!-- //top -->
		</c:if>

		<c:if test="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt > 0 }">
			<div class="sh-top">
				<div class="inner">
	                <div class="box__result">
	                    '<em><c:out value="${search}" /></em>' 검색결과
	                    <strong class="count"><c:out value="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt}"/>개</strong>
	                </div>		
		            <%--<div class="box__sch">
		                <div class="box__keyword">
		                    <h3>연관검색어</h3>
		                    <ul class="list__keyword">
		                        <li class="list-item">
		                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도호텔</a>
		                        </li>
		                        <li class="list-item">
		                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도맛집</a>
		                        </li>
		                        <li class="list-item">
		                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도카페</a>
		                        </li>
		                        <li class="list-item">
		                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도레저</a>
		                        </li>
		                        <li class="list-item">
		                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도렌터카</a>
		                        </li>
		                        <li class="list-item">
		                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도펜션</a>
		                        </li>
		                    </ul>
		                </div>
		                <div class="sort-search">
		                    <input type="text" class="" placeholder="검색 결과 내 재검색" autocapitalize="off">
		                    <button type="button" title="검색" class="sort-search-btn" ></button> <!--  onclick="fn_subSearch()"  -->
		                </div>
		           	</div>--%>
				</div>
			</div> <!--  //top -->
		
			<!-- 상품 목록 -->
			<div class="socialItem">
				<h2 class="sec-caption">검색결과</h2>
				<div class="inner">
				
					<c:if test="${adCnt>0}">
						<div class="item-area">
							<h2 class="listTitle1">숙소 <span><c:out value="${adCnt}"/>개</span></h2>
							<div id="dataAD">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${adCnt > 10}">
		                    	<div class="srh_more dataAD">
		                        	<a href="javascript:fn_ShowProducts('dataAD')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div>	
					</c:if>
					
					<input type="hidden" name="sFromDt" value="${rcSearch.sFromDt}"/>
					<input type="hidden" name="sToDt" value="${rcSearch.sToDt}"/>
					<input type="hidden" name="sFromTm" value="${rcSearch.sFromTm}"/>
					<input type="hidden" name="sToTm" value="${rcSearch.sToTm}"/>		

					<c:if test="${rcCnt>0}">
	 					<div class="item-area">
							<h2 class="listTitle1">렌터카 <span><c:out value="${rcCnt}"/>개</span></h2>
							<div id="dataRC">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${rcCnt > 10}">
		                    	<div class="srh_more dataRC">
		                        	<a href="javascript:fn_ShowProducts('dataRC')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div>
					</c:if>

					<c:if test="${packageCnt>0}">
	   					<div class="item-area">
							<h2 class="listTitle1">여행사 상품 <span><c:out value="${packageCnt}"/>개</span></h2>
							<div id="dataPackage">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${packageCnt > 10}">
		                    	<div class="srh_more dataPackage">
		                        	<a href="javascript:fn_ShowProducts('dataPackage')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div> 
					</c:if>
					
					<c:if test="${tourCnt>0}">
						<div class="item-area">
							<h2 class="listTitle1">관광지/레저 <span><c:out value="${tourCnt}"/>개</span></h2>
							<div id="dataTure">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${tourCnt > 10}">
		                    	<div class="srh_more dataTure">
		                        	<a href="javascript:fn_ShowProducts('dataTure')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div>
					</c:if>
					
					<c:if test="${foodCnt>0}">
						<div class="item-area">
							<h2 class="listTitle1">맛집 <span><c:out value="${foodCnt}"/>개</span></h2>
							<div id="dataFood">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${foodCnt > 10}">
		                    	<div class="srh_more dataFood">
		                        	<a href="javascript:fn_ShowProducts('dataFood')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div>	
					</c:if>
					
					<c:if test="${strollerCnt>0}">
						<div class="item-area">
							<h2 class="listTitle1">유모차/카시트 <span><c:out value="${strollerCnt}"/>개</span></h2>
							<div id="dataStroller">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${strollerCnt > 10}">
		                    	<div class="srh_more dataStroller">
		                        	<a href="javascript:fn_ShowProducts('dataStroller')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div>	
					</c:if>
					
					<c:if test="${svCnt>0}">
						<div class="item-area">
							<h2 class="listTitle1">특산/기념품 <span><c:out value="${svCnt}"/>개</span></h2>
							<div id="dataSV">
								<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
							</div>
							<c:if test="${svCnt > 10}">
		                    	<div class="srh_more dataSV">
		                        	<a href="javascript:fn_ShowProducts('dataSV')"><button type="button" class="btn_more">더보기</button></a>
		                    	</div>	
							</c:if>							
						</div>					
					</c:if>
				</div>
			</div>
		</c:if>
	</div>

	<form name="cmmfrm" id="cmmfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="pageIndex" id="pageIndex"/>
		<input type="hidden" name="orderCd" id="orderCd"/>
		<input type="hidden" name="orderAsc" id="orderAsc"/>
		<input type="hidden" name="sLON"  id="sLON"/>
		<input type="hidden" name="sLAT" id="sLAT"/>
		<input type="hidden" name="searchWord" value="<c:out value='${search}'/>"/>
	</form>
	<form name="adfrm" id="adfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sFromDt" value="${adSearch.sFromDt}"/>
		<input type="hidden" name="sToDt" value="${adSearch.sToDt}"/>
		<input type="hidden" name="sNights" value="${adSearch.sNights}"/>
		<input type="hidden" name="sSearchYn" value="N">
		<input type="hidden" name="sAdultCnt" value="2">
		<input type="hidden" name="sChildCnt" value="0">
		<input type="hidden" name="sBabyCnt" value="0">
		<input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />
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
	<input type="hidden" id="tabType" value="AD">

<script type="text/javascript">

	function fn_DetailPrdt(prdtNum, corpCd, aplDt){
		var code = prdtNum.substring(0,2);
		if(code=='${Constant.RENTCAR}' ){
			window.open("<c:url value='/web/rentcar/car-detail.do'/>?prdtNum="+prdtNum+"&sPrdtNm=${search}&searchYn=${Constant.FLAG_N}", '_blank');
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
			window.open("<c:url value='/web/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum+"&sFromDtView="+fn_addDate(aplDt)+"&sFromDt="+aplDt+"&sToDtView="+strDate+"&sToDt="+strDate2+"&sSearchYn=${Constant.FLAG_N}", '_blank');
		}else if(code=='${Constant.GOLF}' ){
			window.open("<c:url value='/web/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum, '_blank');
		}else if(code=='${Constant.SOCIAL}'){
			location.href = "<c:url value='/web/sp/detailPrdt.do'/>?prdtNum="+prdtNum;
		}else if(code=='${Constant.SV}'){
			location.href = "<c:url value='/web/sv/detailPrdt.do'/>?prdtNum="+prdtNum;
		}
	}
	
	function fn_AdSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		$("#orderCd").val("GPA");
	
		var parameters = $("#cmmfrm").serialize() + "&" + $("#adfrm").serialize()+"&totSch=Y";
		$.ajax({
			type:"post",
			url:"<c:url value='/web/ad/adList.ajax'/>",
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$("#tabs-1").html(data);
				$("#dataAD").html(data);
			},
			error:fn_AjaxError
		});
	}
	
	function fn_RcSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		var parameters = $("#cmmfrm").serialize() + "&" + $("#rcfrm").serialize()+"&totSch=Y&searchYn=Y";
		$.ajax({
			type:"post",
			// dataType:"json",
			// async:false,
			url:"<c:url value='/web/rc/rcListTotSch.ajax'/>",
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#tabs-1").html(data);
				$("#dataRC").html(data);
			},
			error:fn_AjaxError
		});
	}

	function fn_SpSearchPackage(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_PACKAGE}");
	
		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "";
		url = "<c:url value='/web/sp/packageList.ajax'/>";
	
		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#tabs-1").html(data);
				$("#dataPackage").html(data);
			},
			error:fn_AjaxError
		});
	}
	
	function fn_SpSearchTure(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_TOUR}");
	
		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "";
		url = "<c:url value='/web/sp/productList.ajax'/>";
	
		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#tabs-1").html(data);
				$("#dataTure").html(data);
			},
			error:fn_AjaxError
		});
	}
	
	function fn_SpSearchFood(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_ETC}");
	
		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "";
		url = "<c:url value='/web/sp/productList.ajax'/>";
	
		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#tabs-1").html(data);
				$("#dataFood").html(data);
			},
			error:fn_AjaxError
		});
	}
	
	function fn_SpSearchStroller(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_BABY_SHEET}");
	
		var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
		var url = "";
		url = "<c:url value='/web/sp/productList.ajax'/>";
		$.ajax({
			type:"post",
			url:url,
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#tabs-1").html(data);
				$("#dataStroller").html(data);
			},
			error:fn_AjaxError
		});
	}
	
	function fn_SvSearch(pageIndex){
		$("#cmmfrm input[name=pageIndex]").val(pageIndex);
		var parameters = $("#cmmfrm").serialize() + "&" + $("#svfrm").serialize()+"&totSch=Y&";
	
		$.ajax({
			type:"post",
			url:"<c:url value='/web/sv/productList.ajax'/>",
			data:parameters ,
			beforeSend:function(){
				//$(".loading-wrap").show();
			},
			success:function(data){
				//$(".loading-wrap").hide();
				//$("#tabs-1").html(data);
				$("#dataSV").html(data);
			},
			error:fn_AjaxError
		});
	}
	
	function fn_ChangeTab(type, obj){
		$(".menuList li>a").removeClass("select");
		$(obj).addClass("select");
		if(type == "AD") {
			$('#prdtTool').hide();
			$('#areaTool').show();
			fn_AdSearch(1);
			$("#tabType").val("AD");
			$("li.distance").css('display', 'inline-block');
		} else if(type == "RC") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			fn_RcSearch(1);
			$("#tabType").val("RC");
			$("li.distance").css('display', 'none');
		} else if(type == "GL") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			fn_GlSearch(1);
			$("#tabType").val("GL");
			$("li.distance").css('display', 'none');
		} else if(type == "PACKAGE") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_PACKAGE}");
			fn_SpSearch(1);
			$("#tabType").val("PACKAGE");
			$("li.distance").css('display', 'none');
		} else if(type == "TOUR") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_TOUR}");
			fn_SpSearch(1);
			$("#tabType").val("TOUR");
			$("li.distance").css('display', 'inline-block');
		} else if(type == "FOOD") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_ETC}");
			fn_SpSearch(1);
			$("#tabType").val("FOOD");
			$("li.distance").css('display', 'inline-block');
		} else if(type == "FOOD") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_BABY_SHEET}");
			fn_SpSearch(1);
			$("#tabType").val("FOOD");
			$("li.distance").css('display', 'inline-block');
		} else if(type == "SV") {
			$('#prdtTool').show();
			$('#areaTool').hide();
			fn_SvSearch(1);
			$("#tabType").val("SV");
			$("li.distance").css('display', 'none');
		}
	}
	
	function fn_OrderChange(orCd, orAs, obj, area){
		$(".array>li").removeClass("select");
		$(obj).parent("li").addClass("select");
		$("#orderCd").val(orCd);
		$("#orderAsc").val(orAs);
	
		$("#sAdAdar").val(area);
	
		var type = $("#tabType").val();
		if(type == "AD") {
			fn_AdSearch($("#pageIndex").val());
		} else if(type == "RC") {
			fn_RcSearch($("#pageIndex").val());
		} else if(type == "GL") {
			fn_GlSearch($("#pageIndex").val());
		} else if(type == "PACKAGE") {
			fn_SpSearch($("#pageIndex").val());
		} else if(type == "TOUR") {
			fn_SpSearch($("#pageIndex").val());
		} else if(type == "FOOD") {
			fn_SpSearch($("#pageIndex").val());
		} else if(type == "CATEGORY_BABY_SHEET") {
			fn_SpSearch($("#pageIndex").val());	
		} else if(type == "SV") {
			fn_SvSearch($("#pageIndex").val());
		}
	}
	
	function fn_ChangeOrderDist( lat, lon) {
		$("#sLON").val(lon);
		$("#sLAT").val(lat);
	
		fn_OrderChange('${Constant.ORDER_DIST}','${Constant.ORDER_ASC}', $(".distance a"));
		close_popup($('.map-wrap'));
	}
	
	function fn_ShowProducts(category){
		$("#" + category +  " .list-item").removeClass('off');
		
		var offset = $("#" + category).offset();
		$('html, body').animate({scrollTop : offset.top}, 400);
		        
		$("."+category).hide();        
	}
	
	$(document).ready(function(){
		if("${adCnt}">0) fn_AdSearch(1);
		if("${rcCnt}">0) fn_RcSearch(1);
		if("${packageCnt}">0) fn_SpSearchPackage(1);
		if("${tourCnt}">0) fn_SpSearchTure(1);
		if("${foodCnt}">0) fn_SpSearchFood(1);
		if("${strollerCnt}">0) fn_SpSearchStroller(1);
		if("${svCnt}">0) fn_SvSearch(1);
	});
</script>

<!-- AceCounter eCommerce (Product_Search) v8.0 Start -->
<script language='javascript'>
	var _skey = '${search}';
</script>
<!-- AceCounter eCommerce (Product_Search) v8.0 End -->
<jsp:include page="/web/right.do" />
<jsp:include page="/web/foot.do" />
</body>
</html>