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
<meta name="robots" content="noindex">
<jsp:include page="/mw/includeJs.do" flush="false">
	<jsp:param name="title" value="숙소 검색"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 숙소, 호텔, 민박, 게스트하우스, 실시간 예약, 탐나오"/>
	<jsp:param name="description" value="탐나오 숙소 검색"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_hotel.css'/>">

<script type="text/javascript" src="<c:url value='/js/jquery.bxslider.js'/>"></script>
<script type="text/javascript">
function fn_ClickSearch(){
	//$("#sCarDivCdView").val("");
	$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
	//$("#sCarDivCd").val($("input:radio[name=vCarDivCd]:checked").val());
	//$("#sCorpId").val($("input:radio[name=vCorpId]:checked").val());

	document.frm.action = "<c:url value='/mw/ad/productList.do'/>";
	document.frm.submit();
}

function fn_Reset(){

	$("#sAdAdar").val("");
	$("#sPriceSe").val("");
	$("#sMen").val("");
	$("#sFromDtView").val("${SVR_TODAY}");
	$("#sResEnable").val("");
	$("#sAdDiv").val("");
	$("#sPrdtNm").val("");

}


function fn_DetailPrdt(prdtNum){

	$("#sPrdtNum").val(prdtNum);

	document.frm.action = "<c:url value='/mw/ad/detailPrdt.do'/>";
	document.frm.submit();
}



$(document).ready(function(){

	$("#sFromDtView").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: '+12m',
		onClose : function(selectedDate) {
			//$("#sToDtView").datepicker("option", "minDate", selectedDate);
		}
	});

	<c:forEach var="chkIcon" items="${searchVO.sIconCd}">
	$("input[name=sIconCd][value=${chkIcon}]").attr("checked", true);
	</c:forEach>

	// md's pick slider
	$('.md-slide > ul').bxSlider({
		nextSelector: '.md-slide .btn-next',
		prevSelector: '.md-slide .btn-prev',
		auto: true,
		pause: 5000
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
		<h2>실시간 숙소</h2>
	</div>
	<div class="sub-content">
		<%--
		<p class="sub-tabs">
			<a href="#" class="active">전체<br><em>(550)</em></a>
			<a href="#">제주시<br><em>(50)</em></a>
			<a href="#">동부권<br><em>(50)</em></a>
			<a href="#">서부권<br><em>(550)</em></a>
			<a href="#">중문/서귀포<br><em>(550)</em></a>
		</p>
		 --%>
		<div class="golf">

			<div class="con-box">
				<form name="frm" id="frm" method="get" onSubmit="return false;">
					<input type="hidden" name="sSearchYn" id="sSearchYn" value="${Constant.FLAG_Y }" />
					<input type="hidden" name="prdtNum" id="prdtNum" />
					<input type="hidden" name="sPrdtNum" id="sPrdtNum" />
					<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
					<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />

					<div class="form1 form1-1">
						<%-- <select name="sAdAdar" id="sAdAdar">
							<option value="" <c:if test="${empty searchVO.sAdAdar}">selected="selected"</c:if>>지역전체</option>
							<c:forEach var="data" items="${cdAdar}" varStatus="status">
								<option value="${data.cdNum }" <c:if test="${searchVO.sAdAdar==data.cdNum}">selected="selected"</c:if>>${data.cdNm }</option>
							</c:forEach>
						</select> --%>
						<select name="sPriceSe" id="sPriceSe">
							<option value="" <c:if test="${empty searchVO.sPriceSe}">selected="selected"</c:if> >가격전체</option>
							<option value="1" <c:if test="${searchVO.sPriceSe=='1'}">selected="selected"</c:if> >~5만원</option>
							<option value="2" <c:if test="${searchVO.sPriceSe=='2'}">selected="selected"</c:if> >5만원~10만원</option>
							<option value="3" <c:if test="${searchVO.sPriceSe=='3'}">selected="selected"</c:if> >10만원~</option>
							<option value="4" <c:if test="${searchVO.sPriceSe=='4'}">selected="selected"</c:if> >20만원~</option>
						</select>
						<select name="sMen" id="sMen">
							<option value="" <c:if test="${empty searchVO.sMen}">sselected="selected"</c:if> >2인</option>
							<option value="3" <c:if test="${searchVO.sMen=='3'}">selected="selected"</c:if> >3~4인</option>
							<option value="5" <c:if test="${searchVO.sMen=='5'}">selected="selected"</c:if> >5~6인</option>
							<option value="7" <c:if test="${searchVO.sMen=='7'}">selected="selected"</c:if> >7~8인</option>
							<option value="9" <c:if test="${searchVO.sMen=='9'}">selected="selected"</c:if> >9인 이상</option>
						</select>
					</div>
					<div class="form1 form1-2">
						<h5 class="form-title">입실일</h5>
						<span class="date">
							<input type="text" name="sFromDtView" id="sFromDtView" value="${searchVO.sFromDtView}" readonly>
							<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
						</span>
						<input type="hidden" name="sNights" id="sNights" value="1">
						<!--
						<select name="sNights" id="sNights">
							<option value="1" <c:if test="${searchVO.sNights=='1' ||  empty searchVO.sNights}">selected="selected"</c:if> >1박</option>
							<option value="2" <c:if test="${searchVO.sNights=='2'}">selected="selected"</c:if> >2박</option>
							<option value="3" <c:if test="${searchVO.sNights=='3'}">selected="selected"</c:if> >3박</option>
							<option value="4" <c:if test="${searchVO.sNights=='4'}">selected="selected"</c:if> >4박</option>
							<option value="5" <c:if test="${searchVO.sNights=='5'}">selected="selected"</c:if> >5박</option>
						</select>
						 -->
					</div>
					<div class="form1 form1-3">
						<h5 class="form-title">유형</h5>
						<%--
						<select name="sResEnable" id="sResEnable">
							<option value="">예약전체</option>
							<option value="1">예약가능한숙소</option>
						</select>
						--%>
						<select name="sAdDiv" id="sAdDiv">
							<option value="">숙소유형전체</option>
							<c:forEach var="data" items="${cdAddv}" varStatus="status">
								<option value="${data.cdNum}">${data.cdNm }</option>
							</c:forEach>
						</select>
						<input  name="sPrdtNm" id="sPrdtNm" type="text" value="" class="focus-value" placeholder="숙소명을 입력하세요.">
					</div>

					<!-- 주요정보 추가  -->
					<div class="form1 form1-4">
						<h5 class="form-title">주요정보</h5>
						<div class="check-list">
							<c:forEach var="icon" items="${iconCd}" varStatus="status">
							<span><input id="iconCd${status.index}" type="checkbox" name="sIconCd" value="${icon.cdNum}"><label for="iconCd${status.index}">${icon.cdNm}</label></span>
							</c:forEach>
						</div>
					</div>

					<p class="btn-list btn-in">
						<a href="javascript:fn_ClickSearch();" class="btn btn1">검색하기</a>
						<a href="javascript:fn_Reset();" class="btn btn2"><img src="<c:url value='/images/mw/sub_common/reload.png'/>" width="11" alt=""> 초기화</a>
					</p>
				</form>
				<c:if test="${fn:length(mdsPickList) > 0 }">
				<div class="md-pick"> <!-- 상품없을시 통으로 삭제 -->
					<h3 class="title">MD’s Pick</h3>
					<div class="md-slide">
						<ul>
							<c:forEach items="${mdsPickList }" var="mds">
							<li>
								<a href="<c:url value='/mw/coustomer/mdsPickDtl.do?rcmdNum=${mds.rcmdNum }' />">
								<div class="ct-box">
									<div class="l-area">
										<p class="photo"><img src="<c:url value='${mds.listImgPath }' />" alt="product"></p>
									</div>
									<div class="r-area">
										<p class="title"><strong>${mds.corpNm }</strong></p>
										<p class="memo">${mds.subject }</p>
									</div>
								</div>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				</c:if>
			</div>


			<!--베스트상품-->
			<div class="best-item">
				<div class="goods-list goods-slide mt10">
					<ul>
						<c:forEach var="data" items="${resultBestList}" varStatus="status">
							<li>
								<a href="javascript:fn_DetailPrdt('${data.prdtNum }')">
									<div class="goods-image">
										<!-- <p class="tag3">BEST<br>상품</p> -->
										<ul class="view">
											<li>
												<c:if test="${!(empty data.saveFileNm)}">
													<img src="${data.savePath}thumb/${data.saveFileNm}" alt="">
												</c:if>
												<c:if test="${empty data.saveFileNm}">
													<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="">
												</c:if>
											</li>
										</ul>
									</div>
									<p class="info">
										<span class="txt">
											<span class="city">[${data.adAreaNm}]<strong><c:out value="${data.adNm}"/></strong></span>
										</span>
										<span class="price">
											<em><span class="t_price">탐나오가</span></em><%-- <em><fmt:formatNumber value='${ 1 - data.saleAmt/data.nmlAmt}' type='percent' /></em>--%><br>
											<del><fmt:formatNumber>${data.nmlAmt}</fmt:formatNumber><span>원</del> <img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber>${data.saleAmt}</fmt:formatNumber><span></strong>원~
										</span>
									</p>
								</a>
							</li>
						</c:forEach>

					</ul>
					<p>
						<span class="btn-prev"></span>
						<span class="btn-next"></span>
					</p>

				</div>
			</div>
			<!--//베스트상품-->
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'YKmv5z8ZQBe23U2v7PT-tw'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>
