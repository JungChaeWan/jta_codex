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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>


<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


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
			prdtNum : $("#" + itrPrdtSn + "_prdtNum").val(),
			corpId : $("#" + itrPrdtSn + "_corpId").val(),
			qty : $("#" + itrPrdtSn + "_spBuyNum").val(),
			spDivSn: $("#" + itrPrdtSn + "_divSn").val(),
			spOptSn: $("#" + itrPrdtSn + "_optSn").val(),
			addOptAmt: $("#" + itrPrdtSn + "_addOptAmt").val(),
			addOptNm: $("#" + itrPrdtSn + "_addOptNm").val()
		});
	} else if(prdtDiv == "${Constant.RENTCAR}") {
		cart.push({
			prdtNum : $("#" + itrPrdtSn + "_prdtNum").val(),
			prdtNm : $("#" + itrPrdtSn + "_prdtNm").val(),
			prdtDivNm : "렌트카",
			corpId : $("#" + itrPrdtSn + "_corpId").val(),
			corpNm : $("#" + itrPrdtSn + "_corpNm").val(),
			fromDt : $("#" + itrPrdtSn + "_rentStartDt").val(),
			fromTm : $("#" + itrPrdtSn + "_rentStartTm").val(),
			toDt : $("#" + itrPrdtSn + "_rentEndDt").val(),
			toTm : $("#" + itrPrdtSn + "_rentEndTm").val(),
			addAmt : 0
		});
	} else if(prdtDiv == "${Constant.ACCOMMODATION}") {
		cart.push({
			prdtNum : $("#" + itrPrdtSn + "_prdtNum").val(),
			prdtNm : $("#" + itrPrdtSn + "_prdtNm").val(),
			prdtDivNm : "숙소",
			corpId : $("#" + itrPrdtSn + "_corpId").val(),
			corpNm : $("#" + itrPrdtSn + "_corpNm").val(),
			startDt : $("#" + itrPrdtSn + "_adUseDt").val(),
			night : $("#" + itrPrdtSn + "_adUseNight").val(),
			adultCnt : $("#" + itrPrdtSn + "_adAdultNum").val(),
			juniorCnt : $("#" + itrPrdtSn + "_adJuniorNum").val(),
			childCnt : $("#" + itrPrdtSn + "_adChildNum").val()
		});
	} else if(prdtDiv == "${Constant.GOLF}") {
		cart.push({
			prdtNum : $("#" + itrPrdtSn + "_prdtNum").val(),
			prdtNm : $("#" + itrPrdtSn + "_prdtNm").val(),
			prdtDivNm : "골프",
			corpId : $("#" + itrPrdtSn + "_corpId").val(),
			startDt : $("#" + itrPrdtSn + "_glUseDt").val(),
			tm : $("#" + itrPrdtSn + "_glUseTm").val(),
			memCnt : $("#" + itrPrdtSn + "_glUseMem").val(),
		});
	} else if(prdtDiv == "${Constant.SV}") {
		cart.push({
			prdtNum : $("#" + itrPrdtSn + "_prdtNum").val(),
			corpId : $("#" + itrPrdtSn + "_corpId").val(),
			qty : $("#" + itrPrdtSn + "_svBuyNum").val(),
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

	if(pocketSn.length == 0){
		alert("선택된 상품이 없습니다.");
		return;
	}

	if(!isAble) {
		alert("기간만료, 재고없음, 예약불가 상태의 상품은 장바구니로 이동되지 않습니다.");
	}

	fn_AddCart(cart);
	cart = [];
}

function fn_AllAddCart() {
	$("input[name=chPocket]").prop("checked", true);
	fn_ChkAddCart();
}
function fn_DelPocket() {
	var pocketSn = [];
	$("input:checkbox[name=chPocket]").each(function(index){
		if($(this).is(":checked")){
			pocketSn.push($(this).val());
		}
	});

	if(pocketSn.length == 0){
		alert("선택된 상품이 없습니다.");
		return;
	}else{
		if(confirm("상품을 삭제하시겠습니까?")) {
			var parameters = "pocketSn=" + pocketSn;
			$.ajax({
				type:"post",
				// dataType:"json",
				// async:false,
				url:"<c:url value='/web/mypage/deletePocket.ajax'/>",
				data:parameters ,
				beforeSend:function(){
					if("${fn:length(pocketList)==0}" == "true"){
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

function fn_AllDelPocket() {
	$("input[name=chPocket]").prop("checked", true);
	if("${fn:length(pocketList) == 0}" == "true"){
		alert("상품이 없습니다.");
	}else {
		fn_DelPocket();
	}
}

function fn_DetailPrdt(prdtNum){

	var code = prdtNum.substring(0,2);
	if(code=='${Constant.RENTCAR}' ){
		location.href = "<c:url value='/web/rentcar/car-detail.do'/>?prdtNum="+prdtNum;
	}else if(code=='${Constant.ACCOMMODATION}'){
		location.href = "<c:url value='/web/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	}else if(code=='${Constant.GOLF}' ){
		location.href = "<c:url value='/web/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum;
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
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>마이페이지</span> <span class="gt">&gt;</span>
                <span>찜한 상품</span>
            </div>
        </div>

        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="mypage sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                                <jsp:include page="/web/mypage/left.do?menu=pocket" flush="false"></jsp:include>
                                <div class="rContents smON">
				                    <h3 class="mainTitle">찜한 상품</h3>
				
				                    <ul class="commList1">
				                        <li>상품정보</li>
				                    </ul>
				
				                    <table class="commCol product-info like">
				                        <colgroup>
				                            <col style="width: 5%">
				                            <col style="width: 15%">
				                            <col>
				                            <col style="width: 12%">
				                            <col style="width: 15%">
				                        </colgroup>
				                        <thead>
				                            <tr>
				                                <th class="title1"><input type="checkbox" id="allCheck"></th>
				                                <th class="title2">구분</th>
				                                <th class="title3">상품정보</th>
				                                <th class="title4">금액</th>
				                                <th class="title5">비고</th>
				                            </tr>
				                        </thead>
				                        <tbody>
				                        	<c:if test="${fn:length(pocketList) == 0}">
				                        	<!--상품 비었을때-->
				                            <tr>
												<td colspan="5" class="no-content">
													<div class="not-content">
														<p class="icon"><img src="<c:url value='/images/web/other/no_item.png' />" alt="warning"></p>
														<p class="text">찜한상품이 비었습니다.</p>
													</div>
												</td>
											</tr>
											<!--//상품 비었을때-->
											</c:if>
											<c:forEach items="${pocketList}" var="data">
				                            <tr>
				                                <td><input class="ch" name="chPocket" value="${data.itrPrdtSn}" type="checkbox"></td>
				                                <td>${data.prdtDivNm }</td>
				                                <td class="left">
				                                    <a href="<c:url value='/web/${fn:toLowerCase(fn:substring(data.prdtNum, 0, 2)) }/detailPrdt.do?sPrdtNum=${data.prdtNum}&prdtNum=${data.prdtNum}'/>">
				                                    	<div class="photo">
											    			<img src="${data.imgPath }" alt="${data.prdtDivNm }">
											    		</div>
				                                    	<h5 class="product"><span class="cProduct"><c:out value="${data.prdtNm}" /></span></h5>
				                                    </a>
				                                </td>
				                                <td><fmt:formatNumber>${data.saleAmt}</fmt:formatNumber>원~</td>
				                                <td class="option">
				                                    <a class="optionBT" href="<c:url value='/web/${fn:toLowerCase(fn:substring(data.prdtNum, 0, 2)) }/detailPrdt.do?sPrdtNum=${data.prdtNum}&prdtNum=${data.prdtNum}'/>">바로가기</a>
				                                </td>
				                            </tr>
				                            </c:forEach>
				                        </tbody>
				                    </table>
				
									<c:if test="${fn:length(pocketList) != 0}">
				                    <div class="btn-lrWrap">
				                        <div class="r-area">
				                            <a class="btn" href="javascript:fn_DelPocket();">선택상품 삭제</a>
				                            <a class="btn" href="javascript:fn_AllDelPocket();">전체상품 삭제</a>
				                        </div>
				                    </div>
				                    </c:if>
				                </div> <!--//rContents-->				            
                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage1 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>


<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>

