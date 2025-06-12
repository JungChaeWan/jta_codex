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
<meta name="robots" content="noindex">
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="렌터카 목록"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 렌터카, 실시간 예약, 탐나오"/>
	<jsp:param name="description" value="탐나오 렌터카 목록"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />">

<script src="/js/moment.min.js"></script>
<script src="/js/daterangepicker.js"></script>
<script type="text/javascript">
	var prevIndex = 0;

       function fn_ClickSearchPage(pageIndex){

           $("#pageIndex").val(pageIndex);
           $("#mYn").val("");
           //$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
           //$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
           $("#sCorpId").val($("select[name=vCorpId] option:selected").val());
           $("#sIsrDiv").val($("select[name=vIsrDiv] option:selected").val());

		//다음 페이지에서 뒤로가기 클릭 시 현 상태 유지
		++prevIndex;
		history.replaceState($("#main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);

           document.frm.target = "";
           <c:if test="${empty searchVO.sPrdtNum }">
           document.frm.action = "<c:url value='/mw/rentcar/car-list.do'/>";
           </c:if>
           <c:if test="${not empty searchVO.sPrdtNum }">
           document.frm.action = "<c:url value='/mw/rentcar/car-detail.do'/>";
           </c:if>
           document.frm.submit();
       }

       function fn_categorySelect(o, v) {
           $('#' + o).val(v);
       }

       $(document).ready(function () {

		//history.back (replaceState) 처리
		var currentState = history.state;
		if(currentState){
			$("#main").html(currentState);
		}

		$('.dateRangePickMw').daterangepicker({}, function(start, end) {
			// $("#sFromDtView").val(start.format('YYYY-MM-DD'));
			// $("#sFromDtView").attr("value",start.format('YYYY-MM-DD'));
			// $("#sToDtView").val(end.format('YYYY-MM-DD'));
			// $("#sToDtView").attr("value",end.format('YYYY-MM-DD'));
			const sFromDt = start.format('YYYY-MM-DD');
			const sToDt = end.format('YYYY-MM-DD');
			$("#sFromDtView").val(sFromDt.replace(/-/gi, ". ")+ "(" + getDate(sFromDt) + ")");
			$("#sToDtView").val(sToDt.replace(/-/gi, ". ")+ "(" + getDate(sToDt) + ")");
			$("#sFromDt").val(start.format('YYYYMMDD'));
			$("#sToDt").val(end.format('YYYYMMDD'));
		});

		//차종 선택
           $('input[name=sCarDivCdStr]').click(function () {
			$('#sCarDivCd').val($(this).val());

			//history.back 처리
			$("input[name='sCarDivCdStr']").each(function() {
				if ($('#sCarDivCd').val() == $(this).val()) {
					$(this).attr("checked", true);
				}else{
					$(this).attr("checked", false);
				}
			});
           });

           //보험 선택
		$('input[name=sIsrTypeDiv]').click(function () {
			$('#sIsrDiv').val($(this).val());

			//history.back 처리
			$("input[name='sIsrTypeDiv']").each(function() {
				if ($('#sIsrDiv').val() == $(this).val()) {
					$(this).attr("checked", true);
				}else{
					$(this).attr("checked", false);
				}
			});
		});
		//대여시간, 반납시간 history.back 처리
           $("#sFromTm").change(function(){
			var selVal  = $(this).val();
			$("#sFromTm").find("option").each(function() {
				if (selVal == $(this).val()){
					$(this).attr("selected", true);
				}else{
					$(this).attr("selected", false);
				}
			});
		});
		$("#sToTm").change(function(){
			var selVal  = $(this).val();
			$("#sToTm").find("option").each(function() {
				if (selVal == $(this).val()){
					$(this).attr("selected", true);
				}else{
					$(this).attr("selected", false);
				}
			});
		});
		//.대여시간, 반납시간 history.back 처리

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
			<form name="frm" id="frm" method="get" onSubmit="return false;">
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
				<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
				<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
				<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
				<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
				<input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_N}" />
				<input type="hidden" name="prdtNum" id="prdtNum" value="${searchVO.sPrdtNum}" />
				<input type="hidden" name="sPrdtNum" id="sPrdtNum" value="${searchVO.sPrdtNum}" />
				<input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />	<!-- 보험여부 -->
				<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" /> <!-- 렌터카회사 -->
				<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" /> <!-- 차량 유형 검색 -->
				<input type="hidden" name="sMakerDivCd" id="sMakerDivCd" value="${searchVO.sMakerDivCd}" /> <!-- 제조사 검색 -->
				<input type="hidden" name="sUseFuelDiv" id="sUseFuelDiv" value="${searchVO.sUseFuelDiv}" /> <!-- 사용연료 검색 -->
				<input type="hidden" name="sModelYear" id="sModelYear" value="${searchVO.sModelYear}" /> <!-- 연식 검색 -->
				<input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}" /> <!-- 연식 검색 -->
				<div class="search-area rent">
					<div class="area date">
						<dl class="dateRangePickMw">
							<dt>대여일</dt>
							<dd>
								<div class="value-text">
									<div class="date-time-area">
										<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
										<div class="date-container">
		                            <span class="date-wrap">
		                                <input class="datepicker" type="text" name="sFromDtView" id="sFromDtView" placeholder="대여일 선택" value="${searchVO.sFromDtView}" onclick="optionClose('.popup-typeA')" onfocus="this.blur()">
		                            </span>
										</div>
									</div>
								</div>
							</dd>
						</dl>
						<dl class="dateRangePickMw">
							<dt>반납일</dt>
							<dd>
								<div class="value-text">
									<div class="date-time-area">
										<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
										<div class="date-container">
		                            <span class="date-wrap">
		                                <input class="datepicker" type="text" name="sToDtView" id="sToDtView" placeholder="반납일 선택" value="${searchVO.sToDtView}" onclick="optionClose('.popup-typeA')" onfocus="this.blur()">
		                            </span>
										</div>
									</div>
								</div>
							</dd>
						</dl>
					</div>
					<div class="area time">
						<dl>
							<dt class="hide">대여시간 선택</dt>
							<dd>
								<div class="value-text">
									<div class="time-area">
										<select name="sFromTm" id="sFromTm" class="full" title="시간선택">
											<c:forEach begin="8" end="20" step="1" var="fromTime">
												<c:if test='${fromTime < 10}'>
													<c:set var="fromTime_v" value="0${fromTime}00" />
													<c:set var="fromTime_t" value="0${fromTime}:00" />
												</c:if>
												<c:if test='${fromTime > 9}'>
													<c:set var="fromTime_v" value="${fromTime}00" />
													<c:set var="fromTime_t" value="${fromTime}:00" />
												</c:if>
												<option value="${fromTime_v}" <c:if test="${searchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</dd>
						</dl>
						<dl>
							<dt class="hide">반납시간 선택</dt>
							<dd>
								<div class="value-text">
									<div class="time-area">
										<select name="sToTm" id="sToTm" class="full" title="시간선택">
											<c:forEach begin="8" end="20" step="1" var="toTime">
												<c:if test='${toTime < 10}'>
													<c:set var="toTime_v" value="0${toTime}00" />
													<c:set var="toTime_t" value="0${toTime}:00" />
												</c:if>
												<c:if test='${toTime > 9}'>
													<c:set var="toTime_v" value="${toTime}00" />
													<c:set var="toTime_t" value="${toTime}:00" />
												</c:if>
												<option value="${toTime_v}" <c:if test="${searchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</dd>
						</dl>
					</div>


				    <c:if test="${empty searchVO.sPrdtNum }">
					<div class="area car-type">
						<div class="content-area">
							<ul class="select-menu col3">
								<li>
									<div class="lb-box">
										<input id="sCarDivCd0" name="sCarDivCdStr" type="radio" value="" checked="checked" >
										<label for="sCarDivCd0">차종 전체</label>
									</div>
								</li>
								<c:forEach var="code" items="${carDivCd}" varStatus="status">
									<li>
										<div class="lb-box">
											<input id="sCarDivCd${status.count}" name="sCarDivCdStr" type="radio" value="${code.cdNum}" >
											<label for="sCarDivCd${status.count}">${code.cdNm}</label>
										</div>
									</li>
								</c:forEach>
							</ul>

						</div>
					</div>

					<div class="area car-type">
						<div class="content-area">
							<ul class="select-menu col3">
								<li>
									<div class="lb-box">
										<input id="sIsrTypeDiv0" name="sIsrTypeDiv" value="" type="radio" checked="checked">
										<label for="sIsrTypeDiv0">보험 전체</label>
									</div>
								</li>
								<li>
									<div class="lb-box">
										<input id="sIsrTypeDiv1" name="sIsrTypeDiv" value="FEE" type="radio" >
										<label for="sIsrTypeDiv1">자차 미포함</label>
									</div>
								</li>
								<li>
									<div class="lb-box">
										<input id="sIsrTypeDiv2" name="sIsrTypeDiv" value="GENL" type="radio" >
										<label for="sIsrTypeDiv2">일반자차포함</label>
									</div>
								</li>
								<li>
									<div class="lb-box">
										<input id="sIsrTypeDiv3" name="sIsrTypeDiv" value="LUXY" type="radio" >
										<label for="sIsrTypeDiv3">고급자차포함</label>
									</div>
								</li>
							</ul>

						</div>
					</div>
					</c:if>
					<ul class="list-disc type-A">
						<li>오전  8시 ~ 오후 8시 외 차량 대여/반납은 일부 업체만 가능하며, 추가요금이 발생하거나 완전자차 보험가입이 필요할 수 있습니다.</li>
					</ul>
					<div class="btn-wrap type-big">
						<!-- form 사용시 type submit 변경 / onclick 삭제 -->
						<button type="button" class="comm-btn red big" onclick="fn_ClickSearchPage('1')">검색</button>
					</div>
				</div> <!-- //search-area -->
			</form>
		</div> <!-- //mw-search-area -->
		<!--//change contents-->
	</main>

	<!-- 콘텐츠 e -->

	<!-- 푸터 s -->
	<jsp:include page="/mw/foot.do"></jsp:include>
	<!-- 푸터 e -->
</div>
</body>
</html>
