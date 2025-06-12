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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />">
<script type="text/javascript">
var cart = [];

function fn_PocketAddCart(itrPrdtSn) {
	var prdtDiv = $("#" + itrPrdtSn + "_prdtDiv").val();

	if(prdtDiv == "${Constant.SOCIAL}") {
		 $.ajax({
				url:"<c:url value='/web/checkDupOptionCart.ajax'/>",
				data:"prdtNum="+$("#" + itrPrdtSn + "_prdtNum").val() + "&spDivSn="+$("#" + itrPrdtSn + "_divSn").val() +"&spOptSn="+$("#" + itrPrdtSn + "_optSn").val(),
				success:function(data) {
				}
		});

		cart.push({
			prdtNum: $("#" + itrPrdtSn + "_prdtNum").val(),
			corpId: $("#" + itrPrdtSn + "_corpId").val(),
			qty: $("#" + itrPrdtSn + "_spBuyNum").val(),
			spDivSn: $("#" + itrPrdtSn + "_divSn").val(),
			spOptSn: $("#" + itrPrdtSn + "_optSn").val(),
			addOptAmt: $("#" + itrPrdtSn + "_addOptAmt").val(),
			addOptNm: $("#" + itrPrdtSn + "_addOptNm").val()
		});
	} else if(prdtDiv == "${Constant.RENTCAR}") {
		cart.push({
			prdtNum: $("#" + itrPrdtSn + "_prdtNum").val(),
			prdtNm: $("#" + itrPrdtSn + "_prdtNm").val(),
			prdtDivNm: "렌터카",
			corpId: $("#" + itrPrdtSn + "_corpId").val(),
			corpNm: $("#" + itrPrdtSn + "_corpNm").val(),
			fromDt: $("#" + itrPrdtSn + "_rentStartDt").val(),
			fromTm: $("#" + itrPrdtSn + "_rentStartTm").val(),
			toDt: $("#" + itrPrdtSn + "_rentEndDt").val(),
			toTm: $("#" + itrPrdtSn + "_rentEndTm").val(),
			addAmt: 0
		});
	} else if(prdtDiv == "${Constant.ACCOMMODATION}") {
		cart.push({
			prdtNum: $("#" + itrPrdtSn + "_prdtNum").val(),
			prdtNm: $("#" + itrPrdtSn + "_prdtNm").val(),
			prdtDivNm: "숙박",
			corpId: $("#" + itrPrdtSn + "_corpId").val(),
			corpNm: $("#" + itrPrdtSn + "_corpNm").val(),
			startDt: $("#" + itrPrdtSn + "_adUseDt").val(),
			night: $("#" + itrPrdtSn + "_adUseNight").val(),
			adultCnt: $("#" + itrPrdtSn + "_adAdultNum").val(),
			juniorCnt: $("#" + itrPrdtSn + "_adJuniorNum").val(),
			childCnt: $("#" + itrPrdtSn + "_adChildNum").val()
		});
	} else if(prdtDiv == "${Constant.GOLF}") {
		cart.push({
			prdtNum: $("#" + itrPrdtSn + "_prdtNum").val(),
			prdtNm: $("#" + itrPrdtSn + "_prdtNm").val(),
			prdtDivNm: "골프",
			corpId: $("#" + itrPrdtSn + "_corpId").val(),
			startDt: $("#" + itrPrdtSn + "_glUseDt").val(),
			tm: $("#" + itrPrdtSn + "_glUseTm").val(),
			memCnt: $("#" + itrPrdtSn + "_glUseMem").val(),
		});
	} else if(prdtDiv == "${Constant.SV}") {
		cart.push({
			prdtNum: $("#" + itrPrdtSn + "_prdtNum").val(),
			corpId: $("#" + itrPrdtSn + "_corpId").val(),
			qty: $("#" + itrPrdtSn + "_svBuyNum").val(),
			svDivSn: $("#" + itrPrdtSn + "_divSn").val(),
			svOptSn: $("#" + itrPrdtSn + "_optSn").val(),
			addOptAmt: $("#" + itrPrdtSn + "_addOptAmt").val(),
			addOptNm: $("#" + itrPrdtSn + "_addOptNm").val(),
			directRecvYn: $("#" + itrPrdtSn + "_directRecvYn").val()
		});
	}
}

function fn_OneAddCart(itrPrdtSn) {
	fn_PocketAddCart(itrPrdtSn);
	fn_AddCart(cart);
	cart = [];
}

function fn_ChkAddCart() {
	var pocketSn = [];

	if("${fn:length(pocketList) == 0}" == "true"){
		alert("상품이 없습니다.");
		return ;
	}
	var isAble = true;

	$("input:checkbox[name=chPocket]").each(function(index){
		if($(this).is(":checked")){
			var sn = $(this).val();
			if($("#" + sn + "_ableYn").val() == "${Constant.FLAG_Y}") {
				pocketSn.push($(this).val());
				fn_PocketAddCart($(this).val());
			} else {
				if(isAble) isAble = false;
			}
		}
	});

	if(pocketSn.length == 0) {
		alert("선택된 상품이 없습니다.");
		return;
	}
	if(!isAble) {
		alert("기간만료, 재고없음, 예약불가 상태의 상품은 장바구니로 이동되지 않습니다.");
	}
	fn_AddCart(cart);
	cart = [];
}

function fn_OneDelPocket(itrPrdtSn) {
	$("input[name=chPocket]").prop("checked", false);
	$('#chPocket_' + itrPrdtSn).prop('checked', true);
	fn_DelPocket();
}

function fn_DelPocket() {
	var pocketSn = [];

	$("input:checkbox[name=chPocket]").each(function(index){
		if($(this).is(":checked")) {
			pocketSn.push($(this).val());
		}
	});

	if(pocketSn.length == 0) {
		alert("선택된 상품이 없습니다.");
		return;
	} else {
		if(confirm("상품을 삭제하시겠습니까?")) {
			var parameters = "pocketSn=" + pocketSn;

			$.ajax({
				type:"post",
				url:"<c:url value='/web/mypage/deletePocket.ajax'/>",
				data:parameters,
				beforeSend:function(){
					if("${fn:length(pocketList)==0}" == "true") {
						alert("찜한상품이 없습니다.");
						location.reload();
						return false;
					}
				},
				success:function(data){
					location.reload();
				},
				error:fn_AjaxError
			});
		}
	}
}

// 전체상품 삭제
function fn_AllDelPocket() {
	$('input[name=chPocket]').prop("checked", true);
	
	fn_DelPocket();
}

function fn_DetailPrdt(prdtNum) {
	var code = prdtNum.substring(0, 2);

	if(code == '${Constant.RENTCAR}') {
		location.href = "<c:url value='/mw/rentcar/car-detail.do'/>?prdtNum="+prdtNum;
	}else if(code == '${Constant.ACCOMMODATION}') {
		location.href = "<c:url value='/mw/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	}else if(code == '${Constant.GOLF}') {
		location.href = "<c:url value='/mw/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	}

}

$(document).ready(function(){
	$("#allCheck").click(function () {
		if($("#allCheck").prop("checked")) {
			$("input[name=chPocket]").prop("checked", true);
		} else {
			$("input[name=chPocket]").prop("checked", false);
		}
	});
});
</script>
</head>

<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="찜한 상품"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mypage-area">
	  	<c:if test="${fn:length(pocketList) == 0}">
			<!-- 찜한상품 없을 시 -->
			<div class="not-content">
				<p class="icon"><img src="<c:url value='/images/mw/other/no_item.png' />" alt="warning"></p>
				<p class="text">찜한 상품이 없습니다.</p>
				<p class="text-2">찜한 컨텐츠로 고객님이 좋아할 만한 상품을 추천해드립니다.</p>
			</div>
			<!-- //찜한상품 없을 시 -->
	  	</c:if>
		
		<section class="like-list-area">
			<h2 class="sec-caption">찜한상품 목록</h2>
		  	<c:forEach items="${pocketList}" var="data">
				<div class="like-group">
					<div class="product-area">
						<div class="photo">
							<img src="${data.imgPath }" alt="${data.prdtNm}">
						</div>
						<div class="text">
							<div class="btn1-area">
								<div class="label-typeA">
									<label><input name="chPocket" id="chPocket_${data.itrPrdtSn}" value="${data.itrPrdtSn}" type="checkbox"></label>
								</div>
							</div>
							<div class="product-caption">${data.prdtDivNm }</div>
							<div class="title"><c:out value="${data.prdtNm}" /></div>
							<div class="info">
								<dl>
									<dd>
										<div class="price">
	<%--		    							<del><fmt:formatNumber>${data.nmlAmt}</fmt:formatNumber>원</del>--%>
											<strong><fmt:formatNumber>${data.saleAmt}</fmt:formatNumber>원~</strong>
										</div>
									</dd>
								</dl>
								<div class="btn-area">
									 <button type="button" class="comm-btn" onclick="fn_OneDelPocket('${data.itrPrdtSn}');">삭제</button>
									 <a href="<c:url value='/mw/${fn:toLowerCase(fn:substring(data.prdtNum, 0, 2)) }/detailPrdt.do?sPrdtNum=${data.prdtNum}&prdtNum=${data.prdtNum}'/>" class="comm-btn">바로가기</a>
								</div>
							</div>
						</div>
					</div>
				</div> <!-- //like-group -->
		  	</c:forEach>
	    </section> <!-- //like-list-area -->
	  	<c:if test="${fn:length(pocketList) != 0}">
			<div class="btn-wrap type-A">
				<button type="button" class="comm-btn white" onclick="fn_DelPocket();">선택상품 삭제</button>
				<button type="button" class="comm-btn black" onclick="fn_AllDelPocket();">전체상품 삭제</button>
			</div>
	  	</c:if>
	</div> <!-- //mypage-area -->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
