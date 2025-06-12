<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="숙소 검색"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 숙소, 호텔, 민박, 게스트하우스, 실시간 예약, 탐나오"/>
	<jsp:param name="description" value="탐나오 숙소 검색"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/daterangepicker.css' />">

<script src="/js/moment.min.js"></script>
<script src="/js/daterangepicker.js"></script>
<script type="text/javascript">
var prevIndex = 0;

function fn_ClickSearch() {
	$("#sSearchYn").val('Y');
	$("#sAdDiv").val($("select[name=sAdDivSel]:selected").val());

	//다음 페이지에서 뒤로가기 클릭 시 현 상태 유지
	++prevIndex;
	history.replaceState($("#main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);

	<c:if test="${empty searchVO.sPrdtNum }">
		document.frm.action = "<c:url value='/mw/ad/productList.do'/>";
	</c:if>
	<c:if test="${not empty searchVO.sPrdtNum }">
		document.frm.action = "<c:url value='/mw/ad/detailPrdt.do'/>";
	</c:if>

	document.frm.submit();
}

//객실수 및 인원 정보 수정
function modify_room_person() {	
	let str = "성인 " + $('#AdultNum').text();

	if(parseInt($('#ChildNum').text()) > 0){
		str += ",소아 " + $('#ChildNum').text();
	}

	if(parseInt($('#BabyNum').text()) > 0){
		str += ",유아 " + $('#BabyNum').text();
	}
	$('#room_person_str').text(str);
	$("#hotel_count").hide();
}

// 인원수 변경 이벤트
function chg_person(type, gubun) {
	var num = 0;
	if (type == '+') {
		num = eval($('#' + gubun + 'Num').text()) + 1;
	} else {
		num = eval($('#' + gubun + 'Num').text()) - 1;
	}
	
	// 최저 인원 수 - 성인 : 1, 소아&유아 : 0
	if (gubun == 'Adult') {
		if (num < 1) {
			num = 1;
		} else if (num > 30) {
			num = 30;
		}
	} else {
		if (num < 0) {
			num = 0;
		} else if (num > 30) {
			num = 30;
		}
	}	 
	
	$('#' + gubun + 'Num').text(num);
	$('input[name=s' + gubun + 'Cnt]').val(num);
	
	var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
	$('#sMen').val(sMen);
}
$(document).ready(function(){

	//뒤로가기(replaceState) 처리
	var currentState = history.state;
	if(currentState){
		$("#main").html(currentState);
	}

    /** 데이트피커 */
    $('.dateRangePickMw').daterangepicker({}, function(start, end) {
        $("#sFromDt").val(start.format('YYYYMMDD'));
        $("#sToDt").val(end.format('YYYYMMDD'));
        $("#sFromDtView").val(start.format('YYYY. MM. DD')+ "(" + getDate(start.format('YYYY-MM-DD')) + ")");
        $("#sToDtView").val(end.format('YYYY. MM. DD')+ "(" + getDate(end.format('YYYY-MM-DD')) + ")");
		$("#sNights").val(parseInt(moment.duration(end.diff(start)).asDays()));
    });

	// 지역 선택
	$('input[name=sAdAdarChk]').change(function() {
		var area_nm = $("label[for=" + $(this).attr('id') + "]").text();
		if ($(this).val() == "") {
			area_nm = "제주도 " + area_nm;
		}
		$("#area_str").text(area_nm);
		$("#sAdAdar").val($(this).val());

		optionClose($("#hotel_zone"));
	});
	
	<c:if test="${not empty searchVO.sAdAdar }">	
		$('input[name=sAdAdarChk]').change();
	</c:if>

	$("#sFromDtView").val("${fn:substring(searchVO.sFromDt,0,4)}"+"."+"${fn:substring(searchVO.sFromDt,4,6)}" +"."+ "${fn:substring(searchVO.sFromDt,6,8)}" + "(" + getDate("${fn:substring(searchVO.sFromDt,0,4)}"+"-"+"${fn:substring(searchVO.sFromDt,4,6)}"+"-"+"${fn:substring(searchVO.sFromDt,6,8)}") + ")" );
	$("#sToDtView").val("${fn:substring(searchVO.sToDt,0,4)}"+"."+"${fn:substring(searchVO.sToDt,4,6)}" +"."+ "${fn:substring(searchVO.sToDt,6,8)}" + "(" + getDate("${fn:substring(searchVO.sToDt,0,4)}"+"-"+"${fn:substring(searchVO.sToDt,4,6)}"+"-"+"${fn:substring(searchVO.sToDt,6,8)}") + ")");

});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-search-area">
		<div class="search-area hotel">
			<form name="frm" id="frm" method="get" onSubmit="return false;">
				<input type="hidden" name="sSearchYn" id="sSearchYn" value="${Constant.FLAG_N}" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
				<input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />
				<input type="hidden" name="sAdDiv" id="sAdDiv" value="${searchVO.sAdDiv}" />
				<input type="hidden" name="sPriceSe" id="sPriceSe" value="${searchVO.sPriceSe}" />
				<input type="hidden" name="sIconCd" id="sIconCd" value="${searchVO.sIconCd}">
				<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
				<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
				<input type="hidden" name="prdtNum" id="prdtNum" value="${searchVO.sPrdtNum}" />
				<input type="hidden" name="sPrdtNum" id="sPrdtNum" value="${searchVO.sPrdtNum}" />
				<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
				<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
				<input type="hidden" name="sNights" id="sNights" value="${searchVO.sNights}">
				<input type="hidden" name="sMen" id="sMen" value="${searchVO.sMen}">
				<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>

				<div class="area date">
					<dl>
						<dt>입실일</dt>
						<dd>
							<div class="value-text">
								<div class="date-container">
									<div class="dateRangePickMw">
										<input type="hidden" name="vNights" id="vNights" value="${searchVO.sNights}">
										<input type="text" id="sFromDtView" name="sFromDtView" value="" placeholder="입실일 선택" onfocus="this.blur()">
									</div>
								</div>
							</div>
						</dd>
					</dl>
					<dl>
						<dt>퇴실일</dt>
						<dd>
							<div class="value-text">
								<div class="date-container">
									<div class="dateRangePickMw">
										<input type="text" id="sToDtView" name="sToDtView" value="${searchVO.sToDtView}" placeholder="퇴실일 선택" onfocus="this.blur()">
									</div>
								</div>
							</div>
						</dd>
					</dl>
				</div>
				<div class="area zone count select">
					<c:if test="${empty searchVO.sPrdtNum }">
						<dl>
							<dt class="hide">지역</dt>
							<dd>
								<div class="value-text">
									<a href="javascript:void(0)" onclick="optionPopup('#hotel_zone', this)" id="area_str">제주도 전체</a>
								</div>
								<div id="hotel_zone" class="popup-typeA hotel-zone">
									<div class="title-area">
										<h3 class="title">제주 지역 선택</h3>
										<button type="button" class="close"><img src="/images/mw/icon/close/dark-gray.png" alt="닫기"></button>
									</div>
									<div class="content-area">
										<ul class="select-menu col3">
											<li>
												<div class="lb-box">
													<input id="adArea0" name="sAdAdarChk" type="radio" value="" <c:if test="${empty searchVO.sAdAdar}">checked</c:if>>
													<label for="adArea0">전체</label>
												</div>
											</li>
											<c:forEach items="${cdAdar}" var="area" varStatus="status">
												<li>
													<div class="lb-box">
														<input id="adArea${status.count}" name="sAdAdarChk" type="radio" value="${area.cdNum}" <c:if test="${area.cdNum eq searchVO.sAdAdar}">checked</c:if>>
														<label for="adArea${status.count}">${area.cdNm}</label>
													</div>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</dd>
						</dl>
					</c:if>
					<dl <c:if test="${not empty searchVO.sPrdtNum }">class="single"</c:if>>
						<dt class="hide">투숙객</dt>
						<dd>
							<div class="value-text">
								<a href="javascript:void(0)" onclick="optionPopup('#hotel_count', this)" id="room_person_str">
									성인 ${searchVO.sAdultCnt}
									<c:if test="${searchVO.sChildCnt ne 0 }">, 소아 ${searchVO.sChildCnt}</c:if>
									<c:if test="${searchVO.sBabyCnt ne 0 }">, 유아 ${searchVO.sBabyCnt}</c:if>
								</a>
							</div>
							<div id="hotel_count" class="popup-typeA hotel-count">
								<div class="title-area">
									<h3 class="title">인원 선택</h3>
									<button type="button" class="close"><img src="/images/mw/icon/close/dark-gray.png" alt="닫기"></button>
								</div>
								<div class="content-area">
									<div class="detail-area">
										<input type="hidden" name="sRoomNum" id="sRoomNum" value="1">
									</div>
									<div class="detail-area counting-area">
										<c:set var="adultAge" value="만 13세 이상" />
										<c:set var="juniorAge" value="만 2 ~ 13세 미만" />
										<c:set var="childAge" value="만 2세(24개월) 미만" />

										<c:if test="${not empty searchVO.sPrdtNum}">
											<c:set var="adultAge" value="${webDtl.adultAgeStd}" />
											<c:set var="juniorAge" value="${webDtl.juniorAgeStd}" />
											<c:set var="childAge" value="${webDtl.childAgeStd}" />
										</c:if>

										<div class="counting">
											<div class="l-area">
												<strong class="sub-title">성인</strong>
												<span class="memo">${adultAge}</span>
											</div>
											<div class="r-area">
												<input type="hidden" name="sAdultCnt" value="${searchVO.sAdultCnt }" />
												<button type="button" class="counting-btn" onclick="chg_person('-', 'Adult')"><img src="/images/mw/main/form/subtraction.png" alt="빼기"></button>
												<span class="counting-text" id="AdultNum">${searchVO.sAdultCnt }</span>
												<button type="button" class="counting-btn" onclick="chg_person('+', 'Adult')"><img src="/images/mw/main/form/addition.png" alt="더하기"></button>
											</div>
										</div>
										<c:if test="${webDtl.juniorAbleYn ne 'N'}">
										<div class="counting">
											<div class="l-area">
												<strong class="sub-title">소아</strong>
												<span class="memo">${juniorAge}</span>
											</div>
											<div class="r-area">
												<button type="button" class="counting-btn" onclick="chg_person('-', 'Child')"><img src="/images/mw/main/form/subtraction.png" alt="빼기"></button>
												<span class="counting-text" id="ChildNum">${searchVO.sChildCnt }</span>
												<button type="button" class="counting-btn" onclick="chg_person('+', 'Child')"><img src="/images/mw/main/form/addition.png" alt="더하기"></button>
											</div>
										</div>
										</c:if>
										<input type="hidden" name="sChildCnt" value="${searchVO.sChildCnt }" />
										<c:if test="${webDtl.childAbleYn ne 'N'}">
										<div class="counting">
											<div class="l-area">
												<strong class="sub-title">유아</strong>
												<span class="memo">${childAge}</span>
											</div>
											<div class="r-area">
												<button type="button" class="counting-btn" onclick="chg_person('-', 'Baby')"><img src="/images/mw/main/form/subtraction.png" alt="빼기"></button>
												<span class="counting-text" id="BabyNum">${searchVO.sBabyCnt }</span>
												<button type="button" class="counting-btn" onclick="chg_person('+', 'Baby')"><img src="/images/mw/main/form/addition.png" alt="더하기"></button>
											</div>
										</div>
										</c:if>
										<input type="hidden" name="sBabyCnt" value="${searchVO.sBabyCnt }" />
									</div>
									<div class="detail-area info-area">
										<ul class="list-disc sm">
											<li>업체별로 연령 기준은 다를 수 있습니다.</li>
										</ul>
									</div>
									<div class="btn-wrap type-full">
										<!-- form 사용시 submit 변경 -->
										<button type="button" class="comm-btn red" onclick="modify_room_person()">선택 완료</button>
									</div>
								</div>
							</div>
						</dd>
					</dl>
				</div>
				<div class="btn-wrap type-big">
					<button type="button" class="comm-btn red big" onclick="fn_ClickSearch();">검색</button>
				</div>
			</form>
			<div class="search-info-text">
				<div class="big">
					<%--업체마다 취소 수수료 규정이 다릅니다. <br>상세페이지에 안내되어 있는 숙소별 규정을 숙지하시고 예약하시기 바랍니다.--%>
				</div>
				<p class="memo">업체마다 취소 수수료 규정이 다릅니다.<br>상세페이지에 안내되어 있는 숙소별 규정을 숙지하시고 예약하시기 바랍니다.</p>
			</div>
		</div> <!--//search-area-->
	</div> <!-- //mw-search-area -->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'YKmv5z8ZQBe23U2v7PT-tw'
    };
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>
