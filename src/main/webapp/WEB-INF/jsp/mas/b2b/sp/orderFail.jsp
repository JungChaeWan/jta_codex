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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">


$(document).ready(function() {
	
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="rsvInfo" id="rsvInfo" onSubmit="return false;">
			<div id="contents">
			<!--검색-->
	            <div class="max-wrap">
                	<div class="pay-end">
                		<div class="title-box">
					        <p class="img"><img src="<c:url value='/images/oss/icon/warning.jpg'/>" alt="경고"></p>
					        <p class="title">“결제승인에 실패하였습니다.”</p>
					        <table class="commRow pay-error">
					            <tbody>
					            	<tr>
						                <th>실패코드</th>
                                        <td><c:out value="${rtnCode}"/></td>
					                </tr>
					                <tr>
					                    <th>실패사유</th>
                                        <td><c:out value="${rtnMsg}"/></td>
					                </tr>
					            </tbody>
				            </table>
					    </div>
					    <div class="btn-wrap1">
					    	<a href="<c:url value='/mas/home.do'/>" class="btn red big">홈으로</a>
					    </div>
				    </div> <!-- //pay-end -->
			    </div> <!-- //max-wrap -->
			</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>