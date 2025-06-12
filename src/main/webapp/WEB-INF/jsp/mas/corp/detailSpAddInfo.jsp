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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

function fn_UdtCorp() {
	document.corp.action="<c:url value='/mas/viewUpdateSpAddInfo.do'/>";
	document.corp.submit();
}

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<form name="corp" method="post">
			<div id="contents">
				<h4 class="title03">판매처관리</h4>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">상호명</th>
						<td>
							<input type="hidden" id="corpId" name="corpId" value='<c:out value="${corpInfo.corpId}" />' />
							<c:out value="${corpInfo.shopNm}" />
						</td>
					</tr>
					<tr>
						<th>간략설명</th>
						<td><c:out value="${corpInfo.adtmSimpleExp}"/></td>
					<tr>
						<th>회사로고</th>
						<td><c:out value="${corpInfo.adtmImg}"/>
								<c:if test="${not empty corpInfo.adtmImg }">
								<div class="btn_sty06">
									<span><a href="${corpInfo.adtmImg}" target="_blank">상세보기</a></span>
								</div>
								</c:if>
						</td>
					</tr>
					<tr>
						<th>홈페이지</th>
						<td><c:out value="${corpInfo.adtmUrl}" /></td>
					</tr>
					<tr>
						<th>문의전화</th>
						<td><c:out value="${corpInfo.rsvTelNum}" /></td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtCorp()">수정</a>
					</li>
				</ul>
			</div>
			</form>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>