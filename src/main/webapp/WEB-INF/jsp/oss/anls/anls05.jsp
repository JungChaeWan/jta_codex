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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<style>
.span1 {display: inline-block; width: 100px;padding-left: 10px;}
.span2 {display: inline-block; width: 100px; text-align: right;}

</style>
<title></title>
<script type="text/javascript">

function fn_Search(){
	document.frm.action = "<c:url value='/oss/anls05.do'/>";
	document.frm.submit();
}

$(document).ready(function() {

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=anls" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=anls&sub=anls05" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<!-- <div class="btn_rt01">
					<div class="btn_sty04">
						<a href="javascript:fn_ExcelDown();">엑셀다운로드</a>
					</div>
				</div> -->
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3"
							href="<c:url value='/oss/anls06.do'/>">매출통계</a></li>
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/oss/anls05.do'/>">고객통계</a></li>
						<li><a class="menu_depth3"
							href="<c:url value='/oss/anls03.do'/>">일별현황</a></li>
					</ul>
				</div>
				<form name="frm" method="post">
                <div>
                    <select id="sFromYear" name="sFromYear" style="width:60px;" onchange="fn_Search();">
                    	<c:forEach begin="2016" end="${nowYear}" step="1" var="vYear">
                   			<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}</option>
                    	</c:forEach>
                    </select>
                </div>
                </form>
                <div class="list margin-top5 margin-btm15">
				<table class="table01">
					<colgroup>
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>일자</th>
							<th>회원가입수</th>
							<th>회원탈퇴수</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="allUserJoin" value="0"/>
						<c:set var="allUserOut" value="0"/>
						<c:forEach var="item" items="${userList}" varStatus="status">
							<c:set var="allUserJoin" value="${allUserJoin + item.userJoin}"/>
							<c:set var="allUserOut" value="${allUserOut + userOut}"/>
							<tr>
								<td class="align_ct"><c:out value="${item.dt}"/></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${item.userJoin}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${item.userOut}"/></fmt:formatNumber></td>
							</tr>
						</c:forEach>
						<tr>
							<td class="align_ct">총계</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${allUserJoin}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${allUserOut}"/></fmt:formatNumber></td>
						</tr>
					</tbody>
				</table>	
				</div>
				<h4 class="title03">누적 고객 통계</h4>
                <div class="list margin-top5 margin-btm15">
                	<table class="table01">
						<colgroup>
							<col width="30%" />
							<col width="30%" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>퍼센트</th>
								<th>상세내역</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th class="align_ct">고객 유지율</th>
								<td class="align_ct"><c:out value="${100 - userPer.qutPer}"/>%</td>
								<td class="align_ct">
									<p><span class="span1">총 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.totalCnt}"/></fmt:formatNumber>명</span></p>
									<p><span class="span1">이탈 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.qutCnt}"/></fmt:formatNumber>명</span></p>
								</td>
							</tr>
							<tr>
								<th class="align_ct">고객 전환율</th>
								<td class="align_ct"><c:out value="${userPer.rsvPer}"/>%</td>
								<td class="align_ct">
									<p><span class="span1">총 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.totalCnt}"/></fmt:formatNumber>명</span></p>
									<p><span class="span1">구매 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.rsvCnt}"/></fmt:formatNumber>명</span></p>
								</td>
							</tr>
							<tr>
								<th class="align_ct">복수 구매율</th>
								<td class="align_ct"><c:out value="${userPer.duplPer}"/>%</td>
								<td class="align_ct">
									<p><span class="span1">구매 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.rsvCnt}"/></fmt:formatNumber>명</span></p>
									<p><span class="span1">복수구매 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.duplRsvCnt}"/></fmt:formatNumber>명</span></p>
								</td>
							</tr>
							<tr>
								<th class="align_ct">재 구매율</th>
								<td class="align_ct"><c:out value="${userPer.reRsvPer}"/>%</td>
								<td class="align_ct">
									<p><span class="span1">구매 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.rsvCnt}"/></fmt:formatNumber>명</span></p>
									<p><span class="span1">재구매 고객 수</span>:<span class="span2"><fmt:formatNumber><c:out value="${userPer.reRsvCnt}"/></fmt:formatNumber>명</span></p>
								</td>
							</tr>
						</tbody>
					</table>
                </div>
                
			</div>
		</div>
	</div>
</div>
</body>
</html>