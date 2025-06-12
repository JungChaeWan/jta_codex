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
 <%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
 
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

<title>탐나오 관리자 시스템 > 상품관리</title>
<script type="text/javascript">

//탭 이동
function fn_goTap(menu) {
	if(menu == "PRODUCT") {
		document.tabForm.action="<c:url value='/mas/sv/viewUpdateSv.do' />";
	} else if( menu == "IMG") {
		document.tabForm.action="<c:url value='/mas/sv/imgList.do' />";
	} else if(menu == "IMG_DETAIL") {
		document.tabForm.action="<c:url value='/mas/sv/dtlImgList.do' />";
	} else if(menu == "OPTION") {
		document.tabForm.action="<c:url value='/mas/sv/viewOption.do' />";
	} else if(menu == "ADD_OPTION") {
		document.tabForm.action="<c:url value='/mas/sv/viewAddOption.do' />";
	}
		
	document.tabForm.submit();
}

//승인요청
function fn_approvalReq() {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalReq.ajax'/>",
		data : "prdtNum=${svPrdtInf.prdtNum}",
		success: function(data) {
			fn_goTap("IMG_DETAIL");
		},
		error : fn_AjaxError
	})
}
// 승인취소하기
function fn_approvalCancel() {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalCancel.ajax'/>",
		data : "prdtNum=${svPrdtInf.prdtNum}",
		success: function(data) {
			fn_goTap("IMG_DETAIL");
		},
		error : fn_AjaxError
	})
}
$(document).ready(function(){
	
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
			
				<h2 class="title08"><c:out value="${prdtVO.prdtNm}"/></h2>
				
				<div id="menu_depth3">
						<ul>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
		                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('ADD_OPTION');" >추가옵션설정</a></li>
		               </ul>
		               <div class="btn_rt01">
		              	 	<c:if test="${Constant.TRADE_STATUS_REG eq btnApproval}">
		               		<div class="btn_sty01"><a href="javascript:fn_approvalReq();">승인요청</a></div>
		              		</c:if>
		               		<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq btnApproval }">
		               		<div class="btn_sty01"><a href="javascript:fn_approvalCancel();">승인취소</a></div>
		               		</c:if>
		               </div>
		         </div>
				
	            <!--본문-->
	            <!--상품 등록-->
	             <jsp:include page="/mas/cmm/dtlImgList.do?linkNum=${svPrdtInf.prdtNum}" flush="false"></jsp:include> 
	            <!--//상품등록--> 
	            <!--//본문--> 
	        </div>
	     </div>   
	</div>
	<form name="tabForm">
		<input type="hidden" name="prdtNum"  value="${svPrdtInf.prdtNum }"/>
		<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>
	</form>
	<!--//Contents 영역--> 
</div>
</body>
</html>