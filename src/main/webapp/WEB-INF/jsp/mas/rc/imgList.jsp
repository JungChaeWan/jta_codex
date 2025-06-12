<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 목록
 */
function fn_ListPrdt(){
	document.prdtImg.action = "<c:url value='/mas/rc/productList.do'/>";
	document.prdtImg.submit();
}

/**
 * 상품 승인 요청
 */
function fn_ApprovalReqPrdt(){
	$.ajax({
		url : "<c:url value='/mas/rc/approvalPrdt.ajax'/>",
		dataType:"json",
		data : "prdtNum=${prdtInf.prdtNum}",
		success: function(data) {
			
			location.reload(true);
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
		url : "<c:url value='/mas/rc/cancelApproval.ajax'/>",
		dataType:"json",
		data : "prdtNum=${prdtInf.prdtNum}",
		success: function(data) {
			
			location.reload(true);
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
	if('${errorCode}' == '1'){
		alert("상품 정보를 확인해 주세요.");
		location.href = "<c:url value='/mas/rc/productList.do' />";
	}
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<h2 class="title08"><c:out value="${prdtInf.prdtNm}"/></h2>
				<div id="menu_depth3">
					<ul>
	                    <li><a class="menu_depth3" href="<c:url value='/mas/rc/detailPrdt.do?prdtNum=${prdtInf.prdtNum}'/>">차량정보</a></li>
	                	<li class="on"><a class="menu_depth3" href="<c:url value='/mas/rc/imgList.do?prdtNum=${prdtInf.prdtNum}'/>">이미지관리</a></li>
	                	<li><a class="menu_depth3" href="<c:url value='/mas/rc/amtList.do?prdtNum=${prdtInf.prdtNum}'/>">요금관리</a></li>
	                	<li><a class="menu_depth3" href="<c:url value='/mas/rc/disPerList.do?prdtNum=${prdtInf.prdtNum}'/>">할인율관리</a></li>
	                </ul>
	                <div class="btn_rt01">
	                	<c:if test="${(prdtInf.tradeStatus eq Constant.TRADE_STATUS_REG) or (prdtInf.tradeStatus eq Constant.TRADE_STATUS_EDIT)}">
	                	<div class="btn_sty01"><a href="javascript:fn_ApprovalReqPrdt();">승인요청</a></div>
	                	</c:if>
	                	<c:if test="${prdtInf.tradeStatus==Constant.TRADE_STATUS_APPR_REQ}">
	                	<div class="btn_sty01"><a href="javascript:fn_CancelApproval();">승인요청취소</a></div>
	                	</c:if>
	                </div>
	            </div>
	            <!--본문-->
	            <!--상품 등록-->
	            <jsp:include page="/mas/cmm/imgList.do?linkNum=${prdtInf.prdtNum}" flush="false"></jsp:include>
	            <!--//상품등록--> 
	            <!--//본문--> 
	        </div>
		</div>	        
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>