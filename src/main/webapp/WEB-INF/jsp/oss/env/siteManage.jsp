<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<%--<validator:javascript formName="DFTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>--%>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_SaveDftInf() {
	if(confirm("<spring:message code='common.save.msg'/>")) {
		document.DFTINFVO.action= "<c:url value='/oss/saveDftInf.do'/>";
		document.DFTINFVO.submit();
	}
}

function fn_SaveSort(){
	if(confirm("<spring:message code='common.save.msg'/>")) {
		document.DFTINFVO.action= "<c:url value='/oss/saveSort.do'/>";
		document.DFTINFVO.submit();
	}
}

function fn_SaveAppVer(){
	if(confirm("<spring:message code='common.save.msg'/>")) {
		document.DFTINFVO.action= "<c:url value='/oss/saveAppVer.do'/>";
		document.DFTINFVO.submit();
	}
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=site" flush="false"></jsp:include>
		<div id="contents_area">
			<form:form commandName="DFTINFVO"  name="DFTINFVO" method="post">
				<input type="hidden" name="infId" value="${resultVO.infId}" />

				<div id="contents">
					<h4 class="title03 margin-top45">탐나오 쿠폰 설정</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
                        	<col width="*" />
	                    </colgroup>
						<%--<tr>
							<th scope="row">이용제한율</th>
							<td>
								<form:input path="disMaxiPct" id="disMaxiPct" value="${resultVO.disMaxiPct}"  class="input_text2"/> %  <span class='font_blue'>&gt;&gt;&gt; 상품 구매시 판매가의 입력된 요율이하의 탐나오쿠폰만 사용 가능</span>
								<form:errors path="disMaxiPct"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th scope="row">회원가입</th>
							<td>
								<form:input path="userRegCpAmt" id="userRegCpAmt"  value="${resultVO.userRegCpAmt}"  class="input_text5"/> 원  <span class='font_blue'>&gt;&gt;&gt;  회원 가입시 발행되는 탐나오쿠폰 금액</span>
								<form:errors path="userRegCpAmt"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th scope="row">이용후기</th>
							<td>
								<form:input path="useEpilCpAmt" id="useEpilCpAmt"  value="${resultVO.useEpilCpAmt}" class="input_text5"/> 원  <span class='font_blue'>&gt;&gt;&gt;  이용후기 작성시 발행되는 탐나오 쿠폰금액</span>
								<form:errors path="useEpilCpAmt"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th scope="row">APP 설치</th>
							<td>
								<form:input path="appRegCpAmt" id="appRegCpAmt" value="${resultVO.appRegCpAmt}"  class="input_text5"/> 원  <span class='font_blue'>&gt;&gt;&gt;  APP 설치 후 최초 로그인 시 발행되는 탐나오쿠폰 금액</span>
								<form:errors path="appRegCpAmt"  cssClass="error_text" />
							</td>
						</tr>--%>
						<tr>
							<th scope="row">유효일수</th>
							<td>
								<form:input path="cpExprDayNum" id="cpExprDayNum" value="${resultVO.cpExprDayNum}" class="input_text5 right" /> 일
								<span class='font_blue'>* 탐나오쿠폰 발행 시 쿠폰의 유효기간 - 회원가입/앱다운로드/이용후기/재방문</span>
								<form:errors path="cpExprDayNum" cssClass="error_text" />
							</td>
						</tr>
					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_SaveDftInf();">적용</a>
						</li>
					</ul>
						
					<h4 class="title03 margin-top45">탐나오 정렬 설정</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                       	<col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">숙소 정렬 기준</th>
							<td>
								<select name="adSortStd" id="adSortStd">
									<option value="${Constant.ORDER_SALE}" <c:if test="${resultVO.adSortStd eq Constant.ORDER_SALE}">selected="selected"</c:if>>판매순</option>
									<option value="${Constant.ORDER_PRICE}" <c:if test="${resultVO.adSortStd eq Constant.ORDER_PRICE}">selected="selected"</c:if>>가격순</option>
									<option value="${Constant.ORDER_NEW}" <c:if test="${resultVO.adSortStd eq Constant.ORDER_NEW}">selected="selected"</c:if>>최신상품순</option>
									<option value="${Constant.ORDER_GPA}" <c:if test="${resultVO.adSortStd eq Constant.ORDER_GPA}">selected="selected"</c:if>>추천순</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">렌터카 정렬 기준</th>
							<td>
								<select name="rcSortStd" id="rcSortStd">
									<option value="${Constant.ORDER_DISPER}" <c:if test="${resultVO.rcSortStd eq Constant.ORDER_DISPER}">selected="selected"</c:if>>할인율순</option>
									<option value="${Constant.ORDER_SALE}" <c:if test="${resultVO.rcSortStd eq Constant.ORDER_SALE}">selected="selected"</c:if>>판매순</option>
									<option value="${Constant.ORDER_PRICE}" <c:if test="${resultVO.rcSortStd eq Constant.ORDER_PRICE}">selected="selected"</c:if>>가격순</option>
									<option value="${Constant.ORDER_NEW}" <c:if test="${resultVO.rcSortStd eq Constant.ORDER_NEW}">selected="selected"</c:if>>최신상품순</option>
									<option value="${Constant.ORDER_GPA}" <c:if test="${resultVO.rcSortStd eq Constant.ORDER_GPA}">selected="selected"</c:if>>추천순</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">관광지/레저 정렬 기준</th>
							<td>
								<select name="tickSortStd" id="tickSortStd">
									<option value="${Constant.ORDER_SALE}" <c:if test="${resultVO.tickSortStd eq Constant.ORDER_SALE}">selected="selected"</c:if>>판매순</option>
									<option value="${Constant.ORDER_PRICE}" <c:if test="${resultVO.tickSortStd eq Constant.ORDER_PRICE}">selected="selected"</c:if>>가격순</option>
									<option value="${Constant.ORDER_NEW}" <c:if test="${resultVO.tickSortStd eq Constant.ORDER_NEW}">selected="selected"</c:if>>최신상품순</option>
									<option value="${Constant.ORDER_GPA}" <c:if test="${resultVO.tickSortStd eq Constant.ORDER_GPA}">selected="selected"</c:if>>추천순</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">음식/뷰티 정렬 기준</th>
							<td>
								<select name="foodSortStd" id="foodSortStd">
									<option value="${Constant.ORDER_SALE}" <c:if test="${resultVO.foodSortStd eq Constant.ORDER_SALE}">selected="selected"</c:if>>판매순</option>
									<option value="${Constant.ORDER_PRICE}" <c:if test="${resultVO.foodSortStd eq Constant.ORDER_PRICE}">selected="selected"</c:if>>가격순</option>
									<option value="${Constant.ORDER_NEW}" <c:if test="${resultVO.foodSortStd eq Constant.ORDER_NEW}">selected="selected"</c:if>>최신상품순</option>
									<option value="${Constant.ORDER_GPA}" <c:if test="${resultVO.foodSortStd eq Constant.ORDER_GPA}">selected="selected"</c:if>>추천순</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">패키지 정렬 기준</th>
							<td>
								<select name="packSortStd" id="packSortStd">
									<option value="${Constant.ORDER_SALE}" <c:if test="${resultVO.packSortStd eq Constant.ORDER_SALE}">selected="selected"</c:if>>판매순</option>
									<option value="${Constant.ORDER_PRICE}" <c:if test="${resultVO.packSortStd eq Constant.ORDER_PRICE}">selected="selected"</c:if>>가격순</option>
									<option value="${Constant.ORDER_NEW}" <c:if test="${resultVO.packSortStd eq Constant.ORDER_NEW}">selected="selected"</c:if>>최신상품순</option>
									<option value="${Constant.ORDER_GPA}" <c:if test="${resultVO.packSortStd eq Constant.ORDER_GPA}">selected="selected"</c:if>>추천순</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">기념품 정렬 기준</th>
							<td>
								<select name="svSortStd" id="svSortStd">
									<option value="${Constant.ORDER_SALE}" <c:if test="${resultVO.svSortStd eq Constant.ORDER_SALE}">selected="selected"</c:if>>판매순</option>
									<option value="${Constant.ORDER_PRICE}" <c:if test="${resultVO.svSortStd eq Constant.ORDER_PRICE}">selected="selected"</c:if>>가격순</option>
									<option value="${Constant.ORDER_NEW}" <c:if test="${resultVO.svSortStd eq Constant.ORDER_NEW}">selected="selected"</c:if>>최신상품순</option>
									<option value="${Constant.ORDER_GPA}" <c:if test="${resultVO.svSortStd eq Constant.ORDER_GPA}">selected="selected"</c:if>>추천순</option>
								</select>
							</td>
						</tr>
					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_SaveSort();">적용</a>
						</li>
					</ul>

					<h4 class="title03 margin-top45">탐나오 앱 버전 설정</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">ANDROID</th>
							<td>
								<form:input path="androidVer" id="androidVer" value="${resultVO.androidVer}" class="input_text5"/>
								<form:errors path="androidVer" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th scope="row">IOS</th>
							<td>
								<form:input path="iosVer" id="iosVer" value="${resultVO.iosVer}" class="input_text5"/>
								<form:errors path="iosVer" cssClass="error_text" />
							</td>
						</tr>
					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_SaveAppVer();">적용</a>
						</li>
					</ul>
				</div>
			</form:form>
		</div>
	</div>
</div>
</body>
</html>