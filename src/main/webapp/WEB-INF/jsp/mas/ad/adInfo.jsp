<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<%--<script type="text/javascript" src="<c:url value='/js/toastr.min.js'/>"></script>--%>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<%--<link rel='stylesheet' type="text/css" href="<c:url value='/css/common/toastr.min.css'/>"/>--%>

<title></title>

<script type="text/javascript">
function fn_Udt() {
	document.AD_DFTINFVO.action = "<c:url value='/mas/ad/viewUpdateAdInfo.do' />";
	document.AD_DFTINFVO.submit();
}

function fn_Ins() {
	document.AD_DFTINFVO.action = "<c:url value='/mas/ad/viewInsertAdInfo.do' />";
	document.AD_DFTINFVO.submit();
}

$(document).ready(function() {
	<%--toastr.options = {
		"progressBar": true,
		"timeOut": 20000,
		"positionClass": "toast-bottom-full-width"
	}
	if("${adAddamtYn}" == "N" && "${TypeInsYN}" == "N"){
		toastr.success("인원추가요금을 등록하시지 않았습니다. 해당페이지로 이동 하시려면 상단의 바로가기를 눌러주세요.","<a href='/mas/ad/adAddamtList.do'>바로가기</a>");
	}--%>

});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=corp"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form name="AD_DFTINFVO" method="post">
				<div id="contents">
					<h4 class="title03">숙소 정보</h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">업체 아이디<span></span></th>
							<td colspan="3">
								<input type="hidden" name="corpId" value='<c:out value="${adDftInf.corpId}" />' />
								<c:out value="${adDftInf.corpId}" />
							</td>
						</tr>
						<tr>
							<th>숙소명</th>
							<td colspan="3"><c:out value="${adDftInf.adNm}" /></td>
						</tr>
						<tr>
							<th>지역</th>
							<td>
								<%-- <c:out value="${adDftInf.adAreaNm}" /> --%>
								<c:if test="${adDftInf.adArea == 'JE'}">제주시내권</c:if>
								<c:if test="${adDftInf.adArea == 'EA'}">제주동부</c:if>
								<c:if test="${adDftInf.adArea == 'WE'}">제주서부</c:if>
								<c:if test="${adDftInf.adArea == 'ES'}">서귀동부</c:if>
								<c:if test="${adDftInf.adArea == 'WS'}">서귀서부</c:if>
								<c:if test="${adDftInf.adArea == 'SE'}">중문/서귀포권</c:if>
							</td>
							<th>구분</th>
							<td><c:out value="${adDftInf.adDivNm}" /></td>
						</tr>
						<tr>
							<th>숙소 분류</th>
							<td colspan="3"><c:out value="${adDftInf.adGrd}" /></td>
						</tr>
						<tr>
							<th>주요정보</th>
							<td colspan="3">
								<c:forEach var="icon" items="${iconCdList}" varStatus="status">
									<c:if test="${icon.checkYn eq 'Y' }">
										<c:out value='${icon.iconCdNm}'/>,
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<%-- <tr>
							<th>설명</th>
							<td  colspan="3">
								${adDftInf.adInf}
							</td>
						</tr> --%>
						<tr>
							<th>한줄소개</th>
							<td  colspan="3"><c:out value="${adDftInf.adSimpleExp}" /></td>
						</tr>

						<!--
						<tr>
							<th>이미지</th>
							<td colspan="3">
							</td>
						</tr>
						 -->
						<%-- <tr>
							<th>총 구매수</th>
							<td colspan="3">
								<c:out value="${adDftInf.totalBuyNum}" />
							</td>
						</tr> --%>
						<tr>
							<th>소아 접수 가능 여부</th>
							<td>
								<c:if test="${adDftInf.juniorAbleYn == 'Y'}">가능</c:if>
								<c:if test="${adDftInf.juniorAbleYn == 'N'}">불가</c:if>
							</td>
							<th>유아 접수 가능 여부</th>
							<td>
								<c:if test="${adDftInf.childAbleYn == 'Y'}">가능</c:if>
								<c:if test="${adDftInf.childAbleYn == 'N'}">불가</c:if>
							</td>
						</tr>
<%--						<tr>--%>
<%--							<th>금액연동기준</th>--%>
<%--							<td colspan="3">--%>
<%--								<c:if test="${adDftInf.tllPriceLink == 'SELL'}">판매가</c:if>--%>
<%--								<c:if test="${adDftInf.tllPriceLink == 'NET'}">입금가</c:if>--%>
<%--							</td>--%>
<%--						</tr>--%>
						<tr>
							<th>성인 연령 기준</th>
							<td colspan="3">
								<c:out value="${adDftInf.adultAgeStd}" />
							</td>
						</tr>
						<tr>
							<th>소아 연령 기준</th>
							<td colspan="3">
								<c:out value="${adDftInf.juniorAgeStd}" />
								(${adDftInf.juniorAgeStdApicode})
							</td>
						</tr>
						<tr>
							<th>유아 연령 기준</th>
							<td colspan="3">
								<c:out value="${adDftInf.childAgeStd}" />
								(${adDftInf.childAgeStdApicode})
							</td>
						</tr>
						<tr>
							<th>당일예약</th>
							<td>
								<c:if test="${adDftInf.dayRsvUnableYn == 'N'}">가능</c:if>
								<c:if test="${adDftInf.dayRsvUnableYn == 'Y'}">불가</c:if>
							</td>
							<th>당일예약 불가시간</th>
							<td>
								<c:if test="${adDftInf.dayRsvUnableYn == 'N'}">
									<c:out value="${adDftInf.dayRsvUnableTm}" /> 시 이후 예약 불가
								</c:if>
							</td>
						</tr>
						<%-- <tr>
							<th>최초등록일시</th>
							<td><c:out value="${adDftInf.frstRegDttm}" /></td>
							<th>최초등록아이디</th>
							<td><c:out value="${adDftInf.frstRegId}" /></td>
						</tr>
						<tr>
							<th>최종등록일시</th>
							<td><c:out value="${adDftInf.lastModDttm}" /></td>
							<th>최종등록아이디</th>
							<td><c:out value="${adDftInf.lastModId}" /></td>
						</tr> --%>
						<tr>
							<th>체크인 시간</th>
							<td><c:out value="${adDftInf.chkinTm}" /></td>
							<th>체크아웃 시간</th>
							<td><c:out value="${adDftInf.chkoutTm}" /></td>
						</tr>
						<tr>
							<th>검색어</th>
							<td colspan="3">
								<c:if test="${adDftInf.srchWord1 != null}">#<c:out value="${adDftInf.srchWord1}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord2 != null}">#<c:out value="${adDftInf.srchWord2}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord3 != null}">#<c:out value="${adDftInf.srchWord3}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord4 != null}">#<c:out value="${adDftInf.srchWord4}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord5 != null}">#<c:out value="${adDftInf.srchWord5}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord6 != null}">#<c:out value="${adDftInf.srchWord6}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord7 != null}">#<c:out value="${adDftInf.srchWord7}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord8 != null}">#<c:out value="${adDftInf.srchWord8}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord9 != null}">#<c:out value="${adDftInf.srchWord9}" />&nbsp;</c:if>
								<c:if test="${adDftInf.srchWord10 != null}">#<c:out value="${adDftInf.srchWord10}" />&nbsp;</c:if>
							</td>
						</tr>
						<tr>
							<th>TIP</th>
							<td  colspan="3">
								<c:out value="${adDftInf.tip}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<th>홍보영상</th>
							<td  colspan="3">
								<c:out value="${adDftInf.sccUrl}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<th>숙소소개</th>
							<td  colspan="3">
								<c:out value="${adDftInf.infIntrolod}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<th>객실 비품안내</th>
							<td  colspan="3">
								<c:out value="${adDftInf.infEquif}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<th>이용안내</th>
							<td  colspan="3">
								<c:out value="${adDftInf.infOpergud}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<th>참고사항(특전사항)</th>
							<td  colspan="3">
								<c:out value="${adDftInf.infNti}" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<th>취소/환불 규정</th>
							<td  colspan="3">
								<c:out value="${adDftInf.cancelGuide}" escapeXml="false"/>
							</td>
						</tr>
					</table>
					
					<ul class="btn_rt01">
						<li class="btn_sty04">
							<c:if test="${TypeInsYN == 'Y'}">
								<a href="javascript:fn_Ins()">추가</a>
							</c:if>
							<c:if test="${TypeInsYN == 'N'}">
								<a href="javascript:fn_Udt()">수정</a>
							</c:if>
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