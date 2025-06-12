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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<title></title>
<script type="text/javascript">


$(document).ready(function(){

});
</script>

</head>
<body>
<c:if test="${resultCd eq '200'}">
<div id="intro_wrapper">
	<div class="intro">	
	    <h1></h1>
	    <div class="login"> <!--agent를 추가하면 입력폼 3줄에 맞게 적용됨-->
	        <table>
				<tbody>
					<tr>
						<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">날짜</th>
						<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc; display: none;" class="rcCnt">전기차 예약개수</th>
						<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">발송건수</th>
					</tr>
				</tbody>
				<c:forEach var="list" items="${resultList}" varStatus="status">
					<tr>
						<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.week}</td>
						<td style="padding: 10px 10px; border:1px solid #dcdcdc; display: none;" class="rcCnt">${list.amount}</td>
						<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.rsvCnt}</td>
					</tr>
				</c:forEach>
			</table>
	    </div>
	</div>
</div>
<div id="footer_wrapper">
    <p>CopyRight ⓒ 2015 탐나오. All Rights Reserved.</p>
</div>
</c:if>
<c:if test="${resultCd eq '401'}">
	열람 접근권한 없음.
</c:if>

</body>
</html>