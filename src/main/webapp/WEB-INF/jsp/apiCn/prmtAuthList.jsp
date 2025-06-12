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
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<meta name="robots" content="noindex, nofollow">

<style>
.dim-layer {
  display: none;
  position: fixed;
  _position: absolute;
  top: 5%;
  left: 48%;
  width: 50%;
  height: 80%;
  z-index: 100;
}
</style>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript">
	function fn_imgPop(imgPath){
		$("#imgDiv").css("display", "block");
		$("#imgDiv").html("<img src=https://www.tamnao.com"+imgPath+" width='100%' height='100%' border='1' onclick='javascript:closeWin();'>");
		//$("#imgDiv").html("<img src='https://www.tamnao.com/data/sp/thumb/SP00002176_1.jpg' width='100%' height='100%' border='1' onclick='javascript:closeWin();'>");
	}
	function closeWin() {
		$("#imgDiv").css("display", "none");
	}
</script>
</head>
<body>
<c:if test="${resultCd eq '200'}">
<div style="width:50%; float: left;">
	<div id="intro_wrapper">
		<div class="intro">	
		    <div class="login"> <!--agent를 추가하면 입력폼 3줄에 맞게 적용됨-->
		        <table>
					<tbody>
						<tr>
							<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">이름</th>
							<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">연락처</th>
							<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">이메일</th>
							<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">주소</th>
							<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;">날짜</th>
							<th style="background: #f4f4f4; padding: 10px 5px; border:1px solid #dcdcdc;"></th>
						</tr>
					</tbody>
					<c:forEach var="list" items="${resultList}" varStatus="status">
						<tr>
							<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.userNm}</td>
							<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.telNum}</td>
							<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.email}</td>
							<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.addr}</td>
							<td style="padding: 10px 10px; border:1px solid #dcdcdc;">${list.regDttm}</td>
							<td style="padding: 10px 10px; border:1px solid #dcdcdc;"><span onclick="fn_imgPop('${list.savePath}/${list.saveFileNm}')">이미지</span></td>
						</tr>
					</c:forEach>
				</table>
		    </div>
		</div>
	</div>
</div>
<div style="width:50%; float: right;">
	<div id="imgDiv" class="dim-layer"></div>
</div>
</c:if>
<c:if test="${resultCd eq '401'}">
	열람 접근권한 없음.
</c:if>
</body>
</html>