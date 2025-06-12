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
	<jsp:param name="title" value="제주여행 공공플랫폼 핫플레이스 패키지여행, 탐나오"/>
	<jsp:param name="description" value="버스, 택시, 감성 투어 패키지 여행을 할인받고 가세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다."/>
	<jsp:param name="keywords" value="제주관광지,제주도관광지,제주여행,제주도여행,제주핫플,버스투어,택시투어,감성투어,${keys}"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 핫플레이스 패키지여행, 탐나오" >
<meta property="og:url" content="https://www.tamnao.com/mw/web/jeju.do" >
<meta property="og:description" content="버스, 택시, 감성 투어 패키지 여행을 할인받고 가세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>"> --%>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>"> --%>
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
	<div class="socialTx">
		<div class="inner">
			<div class="social-title">여행사상품</div>
	           <div class="social-memo">패키지투어, 단체여행, 개별여행 여행사에서 책임지겠습니다.</div>
		</div>
	</div>

	<!-- 상품 목록 -->
	<div class="socialItem">
       	<h2 class="sec-caption">여행사상품</h2>
       	<div class="inner">
       		<!--단체관광 및 골프패키지 문의 layer-popup-->
       		<%--<div class="btnPack">
				<div class="pack_btn">
                       <a href="javascript:show_popup('#package_info');">단체관광 및 골프패키지 문의</a>
				</div>    

                   <div id="package_info" class="comm-layer-popup_fixed">
                       <div class="content-wrap">
                           <div class="content">
                               <div class="installment-head">
                                   <h3 class="title">단체관광 및 골프패키지 문의</h3>
                                   <button type="button" class="close" onclick="close_popup('#package_info')"><img src="../../images/mw/icon/close/dark-gray.png" alt="닫기"></button>
                               </div>

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
									         
	                                <div class="packCon">
	                                	<c:if test="${C160Cnt > 0 }">
		                                	<div class="packList">
		                                        <h3>단체관광 견적문의</h3>
		                                        <ul class="recommend-list">
		                                        	<c:forEach items="${corpRcmdList }" var="corp">
		                                        		<c:if test="${corp.rcmdDiv eq 'C160' }">
				                                            <li>
				                                                <a href="<c:url value='/web/sp/corpPrdt.do?sCorpId=${corp.corpId }' />">
				                                                    <span class="name">${corp.corpNm }</span>
				                                                    <span class="tel"><c:out value="${corp.rsvTelNum}"/></span>
				                                                </a>
				                                            </li>
														</c:if>
		                                            </c:forEach>
		                                        </ul>
		                                	</div>
	                                	</c:if>

	                                	<c:if test="${C170Cnt > 0 }">
											<div class="packList">
		                                        <h3>골프패키지 견적문의</h3>
		                                        <ul class="recommend-list">
		                                        	<c:forEach items="${corpRcmdList }" var="corp">
		                                        		<c:if test="${corp.rcmdDiv eq 'C170' }">
				                                            <li>
				                                                <a href="<c:url value='/web/sp/corpPrdt.do?sCorpId=${corp.corpId }' />">
				                                                    <span class="name">${corp.corpNm }</span>
				                                                    <span class="tel"><c:out value="${corp.rsvTelNum}"/></span>
				                                                </a>
				                                            </li>
														</c:if>
		                                            </c:forEach>
		                                        </ul>
											</div>
	                                	</c:if>					
									</div>
                               </c:if>
                           </div>
					</div>
				</div>
			</div>--%>

			<div class="__sort" style="top:0;">
                <div class="sort-filter">
                    <ul>
                        <li class="sortSocial1">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort " value="${Constant.ORDER_GPA}">탐나오 추천순</button>
                        </li>
                        <li class="sortSocial2">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort" value="${Constant.ORDER_SALE}">판매순</button>
                        </li>
                        <li class="sortSocial3">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort" value="${Constant.ORDER_PRICE}">가격순</button>
                        </li>
                        <li class="sortSocial4">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort" value="${Constant.ORDER_NEW}">최신등록순</button>
                        </li>
                    </ul>
                </div>
            </div>
			
			<div class="item-area">
	        	<h2 class="sec-caption">여행사 상품 목록</h2>
				<%--<div class="category-tab" style="height:90px;">
					<div class="tabList tab-s1"><a href="#" onclick="fn_ChangeTab('',this); return false;"<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_PACKAGE}"> class="active"</c:if>>전체</a></div>
					<c:forEach items="${categoryList}" var="category" varStatus="status">
						<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
							<c:if test="${category.cdNum eq cntCtgrPrdtList.ctgr and cntCtgrPrdtList.prdtCount > 0}">
								<c:if test="${category.cdNum eq 'C160' or category.cdNum eq 'C420' or category.cdNum eq 'C180'}">
									<div class="tabList tab-s2"><a href="#" id="${cntCtgrPrdtList.ctgr}A" onclick="fn_ChangeTab('${cntCtgrPrdtList.ctgr}',this); return false;"<c:if test="${searchVO.sCtgr eq cntCtgrPrdtList.ctgr}"> class="active"</c:if>><c:out value="${cntCtgrPrdtList.ctgrNm}" /></a></div>
								</c:if>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>--%>
      			<ul class="col4" id="div_productAjax"></ul>
				<div class="loading-wrap">
					<div class="spinner-con"></div>
				</div>
			</div>
      		<div class="paging-wrap" id="moreBtn">
			    <!-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> -->
			    <a id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
			</div>				
		</div>				
	</div>    
	
	<form action="<c:url value='/web/sp/packageList.do'/>" name="searchForm" id="searchForm" method="get">
		<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
		<input type="hidden" name="sCtgr" id="sCtgr" value="${searchVO.sCtgr}" />
		<input type="hidden" name="sTabCtgr" id="sTabCtgr" value="${searchVO.sTabCtgr}" />
		<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
		<input type="hidden" name="prdtNum" id="prdtNum" />
		<%-- <input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}"/>통합검색 더보기를 위함 --%>
		<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
	</form>		    
</main>
<script>
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
		$(".tabList a").removeClass("active");
		$(obj).addClass("active");

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

		$(".sort-filter button").removeClass("active");
		if($("#orderCd").val() == "${Constant.ORDER_SALE}") {
			$(".sortSocial2 button").addClass("active");
		} else if($("#orderCd").val() == "${Constant.ORDER_PRICE}") {
			$(".sortSocial3 button").addClass("active");
		} else if($("#orderCd").val() == "${Constant.ORDER_NEW}") {
			$(".sortSocial4 button").addClass("active");
		} else if($("#orderCd").val() == "${Constant.ORDER_GPA}") {
			$(".sortSocial1 button").addClass("active");
		}

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
		}else{
			$('#slideItem_arrow').hide();
		}
	
	    $('#moreBtnLink').click(function() {
	        if(Number($("#pageIndex").val()) < Number($("#pageInfoCnt").attr('totalPageCnt')) ){
	            fn_SpSearchNoSrc(eval($("#pageIndex").val()) + 1);
	        }
	    });
	
		/*fn_SpSearchNoSrc($("#pageIndex").val());*/
	});
</script>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>