<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
	
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 목록
 */
function fn_ListPrdt(){
	document.prdtImg.action = "<c:url value='/mas/ad/productList.do'/>";
	document.prdtImg.submit();
}


/**
 * 상품 승인 요청
 */
function fn_ApprovalReqPrdt(){
	$.ajax({
		url : "<c:url value='/mas/ad/approvalPrdt.ajax'/>",
		dataType:"json",
		data : "prdtNum=${adPrdinf.prdtNum}",
		success: function(data) {
			//location.reload(true);
			location.href = "<c:url value='/mas/ad/imgList.do'/>?prdtNum=${adPrdinf.prdtNum}";
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}

/**
 * 상품 승인 취소 요청
 */
function fn_CancelApproval(){
	$.ajax({
		url : "<c:url value='/mas/ad/cancelApproval.ajax'/>",
		dataType:"json",
		data : "prdtNum=${adPrdinf.prdtNum}",
		success: function(data) {
			//location.reload(true);
			location.href = "<c:url value='/mas/ad/imgList.do'/>?prdtNum=${adPrdinf.prdtNum}";
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}



$(document).ready(function(){

});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<h2 class="title08"><c:out value="${adPrdinf.prdtNm}"/></h2>

				<div id="menu_depth3">
					<ul>
			            <li><a class="menu_depth3" href="<c:url value='/mas/ad/detailPrdt.do?prdtNum=${adPrdinf.prdtNum}'/>">객실정보</a></li>
		              	<!-- <li><a class="menu_depth3" href="<c:url value='/mas/ad/cntList.do?prdtNum=${adPrdinf.prdtNum}'/>">수량관리</a></li> -->
		              	<li class="on"><a class="menu_depth3" href="<c:url value='/mas/ad/imgList.do?prdtNum=${adPrdinf.prdtNum}'/>">객실이미지</a></li>
		              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/amtList.do?prdtNum=${adPrdinf.prdtNum}'/>">요금관리</a></li>
		              	<c:if test="${adPrdinf.ctnAplYn == 'Y'}">
		              		<li><a class="menu_depth3" href="<c:url value='/mas/ad/continueNight.do?prdtNum=${adPrdinf.prdtNum}'/>">연박 요금관리</a></li>
		              	</c:if>
		              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/adAddamtPrdtList.do?prdtNum=${adPrdinf.prdtNum}'/>">인원추가요금</a></li>
	                </ul>

	                <div class="btn_rt01">
	                	<c:if test="${adPrdinf.tradeStatus==Constant.TRADE_STATUS_REG || adPrdinf.tradeStatus==Constant.TRADE_STATUS_EDIT}">
	                		<div class="btn_sty01"><a href="javascript:fn_ApprovalReqPrdt();">승인요청</a></div>
	                	</c:if>
	                	<c:if test="${adPrdinf.tradeStatus==Constant.TRADE_STATUS_APPR_REQ}">
	                		<div class="btn_sty01"><a href="javascript:fn_CancelApproval();">승인요청취소</a></div>
	                	</c:if>
	                </div>
	            </div>

				<h4 class="title03">객실 이미지</h4>
	            <!--본문-->
	            <!--상품 등록-->
	            <jsp:include page="/mas/cmm/imgList.do?linkNum=${adPrdinf.prdtNum}"></jsp:include>
	            <!--//상품등록-->
	            <!--//본문-->
	        </div>
        </div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>