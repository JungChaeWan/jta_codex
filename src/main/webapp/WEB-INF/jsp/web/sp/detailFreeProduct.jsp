<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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

<c:if test="${fn:length(prdtImg) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(prdtImg) != 0}">
	<c:set value="${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtInfo.prdtNum}&prdtDiv=${prdtInfo.prdtDiv}"/>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="keywordsLinkNum" value="${prdtInfo.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="description" value="${prdtInfo.prdtInf}"/>
	<jsp:param name="imagePath" value="${seoImage}"/>
	<jsp:param name="headTitle" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="area" value="${prdtInfo.areaNm}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtInfo.prdtNm}' />" />
<meta property="og:url" content="http://${strURL}" />
<meta property="og:description" content="<c:out value='${prdtInfo.prdtNm}'/> - <c:out value='${prdtInfo.prdtInf}'/>" />
<c:if test="${fn:length(prdtImg) != 0}">
<meta property="og:image" content="http://${strServerName}${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" />
</c:if>

<script type="text/javascript" src="<c:url value='/js/useepil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bloglink.js'/>"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/printThis.js'/>"></script>

<script type="text/javascript">

$(document).ready(function() {

	<c:if test="${preview ne Constant.FLAG_Y}">
	var savePath, saveFileNm;
	<c:forEach items="${prdtImg}" var="prdtImg" end="0">
	savePath = '${prdtImg.savePath}';
	saveFileNm = '${prdtImg.saveFileNm}';
	</c:forEach>
	/*fn_AddTodayPrdt("${prdtInfo.prdtNum}", "${prdtInfo.prdtNm}", savePath, saveFileNm, servlet_path + "?" + queryString);*/
	</c:if>

	g_UE_corpId		="${prdtInfo.corpId}";
	g_UE_prdtnum 	="${prdtInfo.prdtNum}";
	g_UE_corpCd 	="${Constant.SOCIAL}";
	g_UE_getContextPath = "${pageContext.request.contextPath}";

	//-1:1문의 관련 설정 --------------------------------

	g_Oto_corpId	="${prdtInfo.corpId}";					//업체 코드 - 넣어야함
	g_Oto_prdtnum 	="${prdtInfo.prdtNum}";				//상품번호  - 넣어야함
	g_Oto_corpCd 	="${Constant.SOCIAL}";	//숙박/랜트.... - 페이지에 고정
	g_Oto_getContextPath = "${pageContext.request.contextPath}";

	// 평점
	//fn_useepilInitUI();
	fn_useepilInitUI("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");

	//fn_useepilList();
	fn_useepilList("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");

	//1:1문의 탭에 숫자 변경 (서비스로 사용해도됨)
	fn_otoinqInitUI("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");
	// * 서비스 사용시 int ossOtoinqService.getCntOtoinqCnt(OTOINQSVO); 사용

	//1:1문의 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
	fn_otoinqList("${prdtInfo.corpId}", "${prdtInfo.prdtNum}", "${Constant.SOCIAL}");

	/*
	//-블로그 리스트 --------------------------------
	g_bl_prdtnum 	="${prdtInfo.prdtNum}";		//상품/업체번호  - 넣어야함
	g_bl_corpCd 	="${Constant.SOCIAL}";	//숙박/랜트.... - 페이지에 고정
	g_bl_getContextPath = "${pageContext.request.contextPath}";

	// 탭에 숫자 변경 (서비스로 사용해도됨)
	fn_bloglistInitUI("${prdtInfo.prdtNum}", "${Constant.SOCIAL}");


	// 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
	fn_blogList("${prdtInfo.prdtNum}", "${Constant.SOCIAL}");


	//--------------------------------------------------
	*/


	$(".gallery-view1 .carousel").jCarouselLite({
	    btnNext: ".gallery-view1 .next",
	    btnPrev: ".gallery-view1 .prev",
	    speed: 300,
	    visible: 5,
	    circular: false
	});
	$(".gallery-view1 .carousel img").click(function() { //이미지 변경
	    $(".gallery-view1 .mid img").attr("src", $(this).attr("src"));
	});
	$('.gallery-view1 .carousel li').click(function(){ //class 추가
	    $('.gallery-view1 .carousel li').removeClass('select');
	    $(this).addClass('select');
	});


});

function showSendEmail() {
	/* if($(".mail-form").css('display') == 'none') {
		$(".mail-form").css('display', 'block');
	} else {
		$(".mail-form").css('display', 'none');
	} */
	$(".mail-form").show();
}

function hideSendEmail() {
	$(".mail-form").hide();
}

function sendFreeCoupon() {
	var email = $("#reciver").val();
	if(email == "") {
		alert("이메일을 입력해 주세요.");
		return ;
	}
	if(!fn_is_email(email)) {
		alert("이메일 형식이 맞지 않습니다.");
		return ;
	}
	$.ajax({
		url: "<c:url value='/web/sp/freeCouponMail.ajax'/>",
		data: "prdtNum=${prdtInfo.prdtNum}&email="+email,
		success:function(data) {
			alert("이메일을 성공적으로 보냈습니다.");
			hideSendEmail();
			$("#reciver").val('');
		},
		error : fn_AjaxError
	});
}

function saveInterestProduct()
{
	$.ajax({
		url : "<c:url value='/web/mypage/saveInterestProduct.ajax'/>",
		data: "itrPrdtNum=${prdtInfo.prdtNum}",
		dataType: "json",
		success:function(data) {
			alert("마이페이지에 저장하였습니다.");
		},
		error : function(request, status, error){
			if(request.status == "500"){
				fn_loginUser();
			}else{
				alert("에러가 발생했습니다!");
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}

function printCoupon()
{
	$(".sale-couponWrap2").printThis({
		importCSS:true,
	});
}

function fn_clickTab(nTab){
	$('#tabs ul li a').eq(nTab).trigger( "click" );
	location.href="#tabs";
}
</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
	    <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <!-- <span></span> <span class="gt">&gt;</span>
                <span></span> <span class="gt">&gt;</span> -->
                <span>할인쿠폰</span>
            </div>
        </div>
		<!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="free-coupons">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <!-- 숙박정보 -->
                            <div class="detail">
                                <div class="detailL">
                                   <%--  <img class="serviceInfo" src="<c:url value='/images/web/icon/event.png'/>" alt="event"> --%>
                                    <!--phto gallery-->
                                    <div class="custom-container gallery-view1">
                                    	<div class="mid">
                                    		 <c:forEach items="${prdtImg}" var="prdtImg" end="0">
                                    		 <img src="${prdtImg.savePath}${prdtImg.saveFileNm}" alt="0">
                                    		 </c:forEach>
                                    	</div>
                                    	<c:if test="${fn:length(prdtImg) >1}">
                                    	<div class="carousel">
                                            <ul>
	                                        	<c:forEach items="${prdtImg}" var="prdtImg">
	                                            <li><img src="${prdtImg.savePath}thumb/${prdtImg.saveFileNm}" alt=""></li>
	                                       		</c:forEach>
                                        	</ul>
                                   		</div>
                                    	<a href="#" class="prev arrow"></a>
                                        <a href="#" class="next arrow"></a>
                                       	</c:if>
                                        <div class="clear"></div>
                                    </div>
                                    <!--//phto gallery-->
                                </div>
                                <div class="detailR detailR2">
                                    <div class="pdWrap">
                                        <p class="subText"><c:out value="${prdtInfo.prdtInf}" /></p>
                                        <h2 class="title">
                                            <c:out value="${prdtInfo.prdtNm}" />
                                        </h2>
                                        <ul class="evaluation">
                                            <li>
                                            	<c:if test="${!(fn:substring(prdtInfo.ctgr, 0,2) == 'C1')}">
                                            		<a href="javascript:fn_clickTab(3);" >
                                            	</c:if>

                                            	<c:if test="${(fn:substring(prdtInfo.ctgr, 0,2) == 'C1')}">
                                            		<a href="javascript:fn_clickTab(2);" >
                                            	</c:if>
	                                            	<span id="useepil_uiTopHearts">
	                                                </span>
	                                                <span id="ind_grade">평점 <strong></strong></span>
	                                             </a>
                                            </li>
                                            <li>
                                            	<c:if test="${!(fn:substring(prdtInfo.ctgr, 0,2) == 'C1')}">
                                            		<a href="javascript:fn_clickTab(3);" >
                                            	</c:if>

                                            	<c:if test="${(fn:substring(prdtInfo.ctgr, 0,2) == 'C1')}">
                                            		<a href="javascript:fn_clickTab(2);" >
                                            	</c:if>
	                                                <span><img src="<c:url value='/images/web/icon/comment2.gif'/>" alt="리뷰"></span>
	                                                <span id="ind_review">이용후기 <strong>0건</strong></span>
	                                            </a>
                                            </li>
                                        </ul>
                                        <ul class="prInfo">
                                            <li class="price-sns"  style="height:61px">
                                                <span class="sns">
                                                	<a href="javascript:shareFacebook('${strURL}'); snsCount('${prdtInfo.prdtNum}', 'PC');"><img src="<c:url value='/images/web/icon/sns1.gif'/>" onmouseover="this.src='<c:url value='/images/web/icon/sns1_on.gif'/>';" onmouseout="this.src='<c:url value='/images/web/icon/sns1.gif'/>';" alt="페이스북"></a>
                                                	<a href="javascript:shareBand('${strURL}'); snsCount('${prdtInfo.prdtNum}', 'PC');"><img src="<c:url value='/images/web/icon/sns2.gif'/>" onmouseover="this.src='<c:url value='/images/web/icon/sns2_on.gif'/>';" onmouseout="this.src='<c:url value='/images/web/icon/sns2.gif'/>';" alt="밴드"></a>
                                                	<a href="javascript:shareStory('${strURL}'); snsCount('${prdtInfo.prdtNum}', 'PC');"><img src="<c:url value='/images/web/icon/sns3.gif'/>" onmouseover="this.src='<c:url value='/images/web/icon/sns3_on.gif'/>';" onmouseout="this.src='<c:url value='/images/web/icon/sns3.gif'/>';" alt="카카오스토리"></a>
                                           		</span>
                                            </li>
                                            <li class="left"><%-- 현재 <span><fmt:formatNumber value='${prdtInfo.saleNum}'  type='number'  /></span>개 구매 |  --%><%-- 남은시간 <strong id="realTimeAttack">00일 00:00:00</strong>--%></li>
                                            <li class="total-money"><!-- 총상품금액&nbsp;&nbsp;<span class="money"><strong  id="totalProductAmt">0</strong>원</span> --></li>
                                            <li class="button">
                                            	 <a class="layer-1" href="javascript:printCoupon();"><img src="<c:url value='/images/web/button/print.gif'/>" alt="인쇄하기"></a>
                                                <a href="javascript:showSendEmail();" class="layer-1"><img src="<c:url value='/images/web/button/email2.gif'/>" alt="이메일로 받기"></a>
                                                <div class="layerP1 mail-form">
                                                    <img class="bubble" src="<c:url value='/images/web/icon/bubble.png'/>" alt="말풍선" height="7" width="11">
                                                    <table class="commRow">
                                                        <tr>
                                                            <th>받는메일</th>
                                                            <td><input class="full" type="text" placeholder="이메일 주소 입력" id="reciver"></td>
                                                        </tr>
                                                    </table>
                                                    <p class="comm-button1">
                                                        <a class="color1" href="javascript:sendFreeCoupon();">보내기</a>
                                                        <a href="javascript:hideSendEmail();">취소</a>
                                                    </p>
                                                    <a href="javascript:hideSendEmail();"><img class="layerP1-close" src="<c:url value='/images/web/icon/close2.gif'/>" alt="닫기"></a>
                                                </div>

                                                <input src="<c:url value='/images/web/button/mypage2.gif'/>" alt="마이페이지 저장" type="image" onClick="saveInterestProduct(); return false;">
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div> <!--//detail-->

                            <div class="tabs-wrap">
                                <div class="tabs-left">
                                    <!-- 탭 정보 (이용안내, 취소/환불규정 등등) -->
                                    <div id="tabs" class="detailTabMenu1">
                                        <ul class="menuList">
                                            <li><a class="select" href="#tabs-1">상품설명</a></li>
                                            <li><a href="#tabs-3">사용조건</a></li>
                                            <c:if test="${!(fn:substring(prdtInfo.ctgr, 0,2) eq 'C1')}">
                                            	<li><a href="#tabs-4">위치보기</a></li>
                                            </c:if>
                                            <li><a href="#tabs-5" >이용후기 <span id="useepil_uiTab">(0)</span></a></li>
                                            <!-- <li id="bloglist_liTab"><a href="#tabs-7">블로그 리뷰 <span id="bloglist_uiTab">(0)</span></a></li> -->
                                            <li><a href="#tabs-6">1:1문의 <span id="otoinq_uiTab">(0)</span></a></li>
                                        </ul>
                                        <!--소개-->
                                        <div id="tabs-1" class="tabPanel">

                                            <div class="sale-couponWrap2" >
                                            	 <table width="674" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <img src="<c:url value='/images/web/coupon/top.jpg'/>" alt="">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-left:1px solid #d9d9d9; border-right:1px solid #d9d9d9; padding: 0 30px; text-align: center;">
                                                            <h3 class="name"><c:out value="${prdtInfo.prdtNm}"/></h3>
                                                            <p class="sale"><c:out value="${prdtInfo.disInf}" /></p>
                                                            <p class="date">유효기간 :<fmt:parseDate value="${prdtInfo.exprStartDt}" var="exprStartDt"	pattern="yyyyMMdd" />
													   			<fmt:parseDate value="${prdtInfo.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd" />
													   			<fmt:formatDate value="${exprStartDt}" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${exprEndDt}" pattern="yyyy.MM.dd" />
													   		</p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <img src="<c:url value='/images/web/coupon/bottom.jpg'/>" alt="">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>

											<%--
                                            <!--콘텐츠 없을 시-->
                                            <c:if test="${fn:length(dtlImg)==0}">
                                            	<p class="no-content">상세 상품 설명이 없습니다..</p>
                                            </c:if>
                                            --%>

                                            <div>
                                            	<%-- 첫번째 이미지만 먼저 뿌리기 --%>
	                                             <c:forEach items="${dtlImg}" var="dtlImg" varStatus="status">
	                                             	<c:if test="${status.index == 0}">
	                                            		<img class="full" src="${dtlImg.savePath}${dtlImg.saveFileNm}" alt="상품설명">
	                                            	</c:if>
	                                        	</c:forEach>

	                                        	<c:if test="${!(empty prdtInfo.adMov)}">
													<%-- 홍보영상 --%>
		                                        	<div class="video-area youtube">
											            	<iframe width="100%" height="400" src="${prdtInfo.adMov}" frameborder="0" allowfullscreen></iframe>
											        </div>
										        </c:if>

												<%-- 상세정보 --%>
												<c:if test="${empty infoBgColor}"><c:set value="2e4b55" var="varBgColor"/></c:if>
	                                        	<c:if test="${!(empty infoBgColor)}"><c:set value="${infoBgColor}" var="varBgColor"/></c:if>

												<c:if test="${(fn:length(dtlInfList) != 0)}">
	                                        		<div class="product-detailInfo" style="background: #${infoBgColor}">
														<c:forEach var="data" items="${dtlInfList}" varStatus="status">

															<c:if test="${data.dtlinfType == 'B' }">
																<!-- 소셜기본폼양식 -->
					                                            <div class="item-area">
					                                            	<div class="product-title"><strong><c:out value="${data.subject}"/></strong></div>

					                                            	<c:forEach var="item" items="${data.spDtlinfItem}" varStatus="status1">

						                                            	<div class="type-area item">
						                                            		<div class="title-area">
						                                            			<strong>선택 ${status1.count }</strong>
						                                            		</div>
						                                            		<div class="text-area">
						                                            			<strong class="title"><c:out value="${item.itemNm}"/></strong>
						                                            			<ul>
						                                            				<li>
						                                            					<div class="names">탐나오가</div>
						                                            					<div class="price">
						                                            						<div class="cost"><del><fmt:formatNumber value="${item.itemAmt}"/> 원</del></div>
						                                            						<div class="sale"><fmt:formatNumber value="${item.itemDisAmt}"/> <small>원</small></div>
						                                            					</div>
						                                            				</li>
						                                            			</ul>
						                                            			<div class="memo"><c:out value="${item.itemEtc}" escapeXml="false"/></div>
						                                            		</div>
						                                            	</div> <!-- //type-area -->
						                                            </c:forEach>

					                                            </div> <!-- //product-detailInfo -->
					                                            <!-- //소셜기본폼양식 -->
					                                         </c:if>

														</c:forEach>
													</div> <!-- //product-detailInfo -->
												</c:if>

												<%-- 나머지 이미지 --%>
	                                        	<c:forEach items="${dtlImg}" var="dtlImg" varStatus="status">
	                                             	<c:if test="${status.index != 0}">
	                                            		<img class="full" src="${dtlImg.savePath}${dtlImg.saveFileNm}" alt="상품설명">
	                                            	</c:if>
	                                        	</c:forEach>
                                        	</div>

											<c:if test="${!(empty SP_GUIDINFOVO)}">
                                        		<div class="product-detailInfo" style="background: #${infoBgColor}">

													<div class="info-area item">
		                                           		<h3 class="title">안내사항</h3>
		                                           		<div class="table-area">
		                                           			<table class="table-row">
														        <caption>상품관련 안내사항 내용입니다.</caption>
														        <colgroup>
														            <col style="width: 25%">
														            <col>
														        </colgroup>
														        <tbody>
														            <tr>
														                <th>문의전화</th>
														                <td><c:out value="${SP_GUIDINFOVO.telnum}"/></td>
														            </tr>
														            <tr>
														                <th>주소지</th>
														                <td>
														                	<c:out value="${SP_GUIDINFOVO.roadNmAddr}"/>
																			<c:out value="${SP_GUIDINFOVO.dtlAddr}"/>
																		</td>
														            </tr>
																	<c:if test="${!(empty SP_GUIDINFOVO.prdtExp)}">
															            <tr>
															                <th>상품설명</th>
															                <td><c:out value="${SP_GUIDINFOVO.prdtExp}" escapeXml="false"/></td>
															            </tr>
															        </c:if>
															        <c:if test="${!(empty SP_GUIDINFOVO.useQlfct)}">
															            <tr>
															                <th>사용조건</th>
															                <td><c:out value="${SP_GUIDINFOVO.useQlfct}" escapeXml="false"/></td>
															            </tr>
															        </c:if>
															        <c:if test="${!(empty SP_GUIDINFOVO.useGuide)}">
															            <tr>
															                <th>이용안내</th>
															                <td><c:out value="${SP_GUIDINFOVO.useGuide}" escapeXml="false"/></td>
															            </tr>
														            </c:if>
														            <c:if test="${!(empty SP_GUIDINFOVO.cancelRefundGuide)}">
															            <tr>
															                <th>취소/환불 안내</th>
															                <td><c:out value="${SP_GUIDINFOVO.cancelRefundGuide}" escapeXml="false"/></td>
															            </tr>
															        </c:if>
														        </tbody>
														    </table>
		                                           		</div>
		                                           	</div> <!-- //info-area -->

												</div> <!-- //product-detailInfo -->
											</c:if>


                                        </div> <!-- //tabs-1 -->
                                        <!--사용조건-->
                                        <div id="tabs-3" class="tabPanel">
                                        	<c:if test="${(not empty prdtInfo.exprStartDt) or (not empty prdtInfo.exprEndDt)}">
                                            <article class="comm-art1">
                                            	<h6>사용정보</h6>
                                                <p class="fix">
	                                            	<fmt:parseDate value="${prdtInfo.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd"/><fmt:parseDate value="${prdtInfo.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd"/>
	                                            	<span>ㆍ유효기간 : <strong class="comm-color1"><fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/></strong></span>
	                                             </p>
	                                        </article>
	                                        </c:if>
	                                        <c:if test="${not empty prdtInfo.useQlfct}">
                                            <article class="comm-art1">
                                                <h6>안내사항</h6>
                                               <p> <c:out value="${prdtInfo.useQlfct}"  escapeXml="false"/></p>
                                            </article>
                                            </c:if>
                                        </div> <!-- //tabs-3 -->

                                        <c:if test="${!(fn:substring(prdtInfo.ctgr, 0,2) eq 'C1')}">
	                                        <!--위치보기-->
			                                <div id="tabs-4" class="tabPanel">

			                                	<c:if test="${(empty prdtInfo.lat) or (empty prdtInfo.lon)}">
			                                		<p class="no-content">위치 정보가 없습니다.</p>
			                                	</c:if>

			                                	<c:if test="${(not empty prdtInfo.lat) and (not empty prdtInfo.lon)}">
			                                        <!--여기다 추가-->
			                                        <div class="mapWrap">
			                                        	<div class="map" id="mapTab" ></div>
			                                        </div>
			                                        <script type="text/javascript">
													//동적 지도 ( 움직이는 지도.)
													var container = document.getElementById('mapTab');
													var options = {
														center: new daum.maps.LatLng(${prdtInfo.lat}, ${prdtInfo.lon}),
														level: 3
													};

													var map = new daum.maps.Map(container, options);

													//마커가 표시될 위치입니다
													var markerPosition  = new daum.maps.LatLng(${prdtInfo.lat}, ${prdtInfo.lon});

													// 마커를 생성합니다
													var marker = new daum.maps.Marker({
													    position: markerPosition
													});

													// 마커가 지도 위에 표시되도록 설정합니다
													marker.setMap(map);
													</script>
												</c:if>
			                                </div> <!-- //tabs-4 -->
		                                </c:if>

                                        <!--이용후기-->
                                        <div id="tabs-5" class="tabPanel">
                                        </div> <!-- //tabs-5 -->
                                        <!--1:1문의-->
                                        <div id="tabs-6" class="tabPanel">
                                        </div> <!-- //tabs-6 -->
                                        <!-- 블로그 -->
                            			<div id="tabs-7" class="tabPanel"></div>
                                        <script>
                                            tabPanel({container:"#tabs"});
                                        </script>
                                    </div> <!--//tabs-->
                                </div> <!--//tabs-left-->
                                <div class="tabs-right">
                                	<c:if test="${prdtInfo.prdtDiv == Constant.SP_PRDT_DIV_TOUR }">
                                    <h4>판매처 다른 상품보기</h4>
                                    <ul class="different">
                                    	<c:forEach items="${otherProductList}" var="product">
                                        <li>
                                            <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>">
                                                <p class="photo"><img src="${product.savePath}thumb/${product.saveFileNm}" alt=""></p>
                                                <p class="text">${product.prdtNm }</p>
                                                <p class="price"><fmt:formatNumber value='${product.saleAmt}'  type='number'  />원</p>
                                            </a>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                    </c:if>
                                    <c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR }">
                                    <h4>주변 숙소 보기</h4>
                                    <ul class="different">
                                    	<c:forEach items="${otherAdList}" var="product">
                                        <li>
                                            <a href="<c:url value='/web/ad/detailPrdt.do?sPrdtNum=${product.prdtNum}'/>">
                                                <p class="photo"><img src="${product.savePath}thumb/${product.saveFileNm}" alt=""></p>
                                                <p class="text">[${product.adAreaNm}]<c:out value="${product.adNm}"/></p>
                                                <p class="price"><fmt:formatNumber value='${product.saleAmt}'  type='number'  />원</p>
                                            </a>
                                        </li>
                                      </c:forEach>
                                    </ul>
                                    </c:if>
                                </div> <!--tabs-right-->
                            </div> <!--//tabs-wrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap-->
                </div> <!-- //package2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
<form name="cartForm" id="cartForm">
	<input type="hidden" name="prdtNum" id="prdtNum"/>
	<input type="hidden" name="spDivSn" id="spDivSn" />
	<input type="hidden" name="spOptSn" id="spOptSn" />
	<input type="hidden" name="sCtgr"/>
</form>
<script type="text/javascript">
//남은시간 갱신

var timeLeft = <c:out value="${difTime}" />;
var updateLeftTime = function() {
    timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;

    var hours = Math.floor(timeLeft / 3600);
    var minutes = Math.floor((timeLeft - 3600 * hours) / 60);
    var seconds = timeLeft % 60;

    var time_text = timegroup_format(${difDay}) + "일 "
    				   + timegroup_format(hours) + ':'
                       + timegroup_format(minutes) + ':'
                       + timegroup_format(seconds);

      $("#realTimeAttack").text(time_text);
}

function timegroup_format(num)
{
    var ret_str = '';
    var n = num.toString();
    if (n.length == 1)
        ret_str += '0' + n;
    else
        ret_str += n;
    return ret_str;
}

function realTimeAttack() {

}
$(document).ready(function() {

    //setInterval(updateLeftTime, 1000);
});
</script>
</body>
</html>