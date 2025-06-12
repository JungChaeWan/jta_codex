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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Search(){
	document.frm.action = "<c:url value='/mas/${fn:toLowerCase(masLoginVO.corpCd)}/anls01.do'/>";
	document.frm.submit();
	
}

$(document).ready(function() {

	$("#sFromDtView").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sToDtView").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	$('#sFromDtView').change(function() {
		$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
	});
	$('#sToDtView').change(function() {
		$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
	});
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=ansl" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3"
							href="<c:url value='/mas/anls02.do'/>">매출통계</a></li>
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/mas/ad/anls01.do'/>">상품별누적통계</a></li>
					</ul>
				</div>
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<form name="frm" method="post">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
									<col width="*" />
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
          								<th scope="row">검색일자</th>
          								<td colspan="3">
          									<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}" />
          									<input type="text" id="sFromDtView" class="input_text6" name="sFromDtView" value="${searchVO.sFromDtView}" title="검색하실 대여일을 입력하세요." maxlength="10" /> ~
          									<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}" />
          									<input type="text" id="sToDtView" class="input_text6" name="sToDtView" value="${searchVO.sToDtView}" title="검색하실 대여일을 입력하세요." maxlength="10" />
          								</td>
       								</tr>
       							</tbody>
                 			</table>
                 		</div>
                 		</form>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search()" />
						</span>
                    </div>
                </div>
                <div class="list">
				<table class="table01">
					<colgroup>
						<col width="10%" />
						<col width="10%" />
						<col width="40%" />
						<col width="40%" />
					</colgroup>
					<thead>
						<tr>
							<th>상품번호</th>
							<th>상품명</th>
							<th>누적예약수</th>
							<th>누적금액</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList}" var="anls" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${anls.prdtNum}" /></td>
								<td class="align_ct"><c:out value="${anls.prdtNm}" /></td>
								<td>
									<table class="chart">
										<tr>
											<td class="grid"><p class="line${status.index mod 5}" style="width: ${anls.rsvCntPer}%"></p></td>
											<td class="text align_rt">
												<fmt:formatNumber><c:out value="${anls.rsvCnt}" /></fmt:formatNumber>
											</td>
										</tr>
									</table>
								</td>
								<td>
									<table class="chart">
										<tr>
											<td class="grid"><p class="line${status.index mod 5}" style="width: ${anls.sumAmtPer}%"></p></td>
											<td class="text align_rt"><fmt:formatNumber><c:out value="${anls.sumAmt}" /></fmt:formatNumber></td>
										</tr>
									</table>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
				</div>
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>