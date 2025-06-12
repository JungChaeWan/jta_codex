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

<title></title>
<script type="text/javascript">

function fn_Search(){
	document.frm.action = "<c:url value='/oss/anls03.do'/>";
	document.frm.submit();
}

$(document).ready(function() {
	$("#sFromDtView").datepicker({
		dateFormat: "yy-mm-dd",
		maxDate:"${SVR_TODAY}"
	});
	$('#sFromDtView').change(function() {
		$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
		fn_Search();
	});
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=anls" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=anls&sub=anls03" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3" href="<c:url value='/oss/anls06.do'/>">매출통계</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/anls05.do'/>">고객통계</a></li>
						<li class="on"><a class="menu_depth3" href="<c:url value='/oss/anls03.do'/>">일별현황</a></li>
						<%-- <li><a class="menu_depth3"
							href="<c:url value='/mas/${fn:toLowerCase(masLoginVO.corpCd)}/anls01.do'/>">상품별누적통계</a></li> --%>
					</ul>
				</div>
				<form name="frm" method="post">
	                <div>
	                	<fmt:parseDate value='${searchVO.sFromDt}' var='vFromDt' pattern="yyyymmdd" scope="page" />
						<input type="text" id="sFromDtView" name="sFromDtView" class="input_text3 center" value="<fmt:formatDate value="${vFromDt}" pattern="yyyy-mm-dd"/>" readonly="readonly" /> 
						<input type="hidden" id="sFromDt" name="sFromDt" value="${searchVO.sFromDt}" />
	                </div>
                </form>
                <div class="list margin-top5 margin-btm15">
				<table class="table01">
					<colgroup>
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
					</colgroup>
					<thead>
						<tr>
							<th>구분</th>
							<th>예약건수</th>
							<th>결제건수</th>
							<th>판매금액</th>
						</tr>
					</thead>
					<tbody>
						<%-- <c:forEach items="${resultList}" var="anls" varStatus="status">
							<tr>
								<td class="align_ct"><a href="javascript:fn_DtlAnls('${fn:substring(anls.dt, 5, 7)}')" style="text-decoration:underline;color:#4897dc;font-weight: bold;">${anls.dt}</a></td>
								<td class="align_ct"><fmt:formatNumber>${anls.rsvCnt}</fmt:formatNumber></td>
								<td class="align_rt"><fmt:formatNumber>${anls.nmlAmt}</fmt:formatNumber>원</td>
								<td class="align_ct"><fmt:formatNumber>${anls.cancelCnt}</fmt:formatNumber></td>
								<td class="align_rt"><fmt:formatNumber>${anls.cmssAmt}</fmt:formatNumber>원</td>
								<td class="align_rt">
									<table class="chart">
										<tr>
											<td class="grid"><p style="width: 45%"></p></td>
											<td class="text align_rt">
												<fmt:formatNumber><c:out value="${anls.cmssAmt + anls.nmlAmt}" /></fmt:formatNumber>
											</td>
										</tr>
									</table>
								<fmt:formatNumber>${anls.cmssAmt + anls.nmlAmt}</fmt:formatNumber>원</td>
							</tr>
						</c:forEach> --%>
						<tr>
							<td class="align_ct">숙소</td>
							<c:set var="adChk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'AD'}">
									<c:set var="adChk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${adChk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">렌터카</td>
							<c:set var="rcChk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'RC'}">
									<c:set var="rcChk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${rcChk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">골프패키지</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C170'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">버스/택시관광</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C160'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">카텔</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C130'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">에어카텔</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C120'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">에어카</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C140'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">에어텔</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C150'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">테마여행</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C180'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">할인/특가항공</td>
							<c:set var="c1Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C110'}">
									<c:set var="c1Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c1Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">관광지/레저</td>
							<c:set var="c2Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C200'}">
									<c:set var="c2Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c2Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">음식/뷰티</td>
							<c:set var="c3Chk" value="N" />
							<c:forEach items="${rsvList}" var="rsvVO" varStatus="status">
								<c:if test="${rsvVO.ctgr eq 'C300'}">
									<c:set var="c3Chk" value="Y" />
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.rsvCnt1}</fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber>${rsvVO.nmlAmt}</fmt:formatNumber></td>
								</c:if>
							</c:forEach>
							<c:if test="${c3Chk eq 'N'}">
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
								<td class="align_ct">0</td>
							</c:if>
						</tr>
						<tr>
							<td class="align_ct">회원가입수</td>
							<td class="align_ct" colspan="3">일 : <c:out value="${joinVO.nowJoin}"/>명 / 누계 : <c:out value="${joinVO.userJoin}"/>명 (<c:out value="${joinVO.allJoin}"/>명)</td>
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