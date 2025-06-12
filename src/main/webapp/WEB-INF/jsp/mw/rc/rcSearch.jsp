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
	<jsp:param name="title" value="렌터카 검색"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 렌터카, 실시간 예약, 탐나오"/>
	<jsp:param name="description" value="탐나오 렌터카 검색"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_rent.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select-mobile.css'/>" />

<script type="text/javascript" src="<c:url value='/js/multiple-select.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.bxslider.js'/>"></script>

<script type="text/javascript">
function fn_ClickSearch(){
	$("#sCarDivCdView").val("");
	$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
	$("#sFromTm").val($("#vFromTm").val());
	$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
	$("#sToTm").val($("#vToTm").val());
	$("#sCarDivCd").val($("select[name=vCarDivCd] option:selected").val());
	$("#sCorpId").val($("select[name=vCorpId] option:selected").val());
	$("#sIsrDiv").val($("select[name=vIsrDiv] option:selected").val());
	$("#sAbleYn").val($("select[name=vAbleYn] option:selected").val());

	document.frm.action = "<c:url value='/mw/rc/rcList.do'/>";
	document.frm.submit();
}

function fn_Reset(){
	$("#sFromDtView").val(fn_NexDay(currentDay()));
	$("#sToDtView").val(fn_NexDay(fn_NexDay(currentDay())));

	$("#vFromTm").val("0900");
	$("#vToTm").val("0900");
	$("input:radio[name=vCarDivCd][value='']").prop("checked","checked");
	$("#select[name=vCorpId]").val("");
}

$(document).ready(function(){
	/* $(function() {
        $("#demo3").webwidget_slideshow_dot({
            slideshow_window_width: '336',
            slideshow_window_height: '224',
            slideshow_title_color: '#fff',
            soldeshow_foreColor: '#39cba6',
            context: getContextPath,
            directory: "RC" //icon image
        });
    }); */

	$("#sFromDtView").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "${AFTER_DAY}",
		onClose : function(selectedDate) {
			$("#sToDtView").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#sToDtView").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "${AFTER_DAY}",
		onClose : function(selectedDate) {
			$("#sFromDtView").datepicker("option", "maxDate", selectedDate);
		}
	});

	$("#sCarCd").multipleSelect({
		filter 		: true,
		multiple 	: true,
		multipleWidth : 85,
		maxHeight	: 110,
		selectAllText : "전체차량",
		allSelected : "전체차량"
	});

	<c:forEach var="chkIcon" items="${searchVO.sIconCd}">
	$("input[name=sIconCd][value=${chkIcon}]").attr("checked", true);
	</c:forEach>

	// md's pick slider
	$('.md-slide > ul').bxSlider({
		nextSelector: '.md-slide .btn-next',
		prevSelector: '.md-slide .btn-prev',
		auto: true,
		pause: 5000
	});

	// fn_Search($("#pageIndex").val());
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
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>실시간 렌터카</h2>
	</div>
	<div class="sub-content">
		<div class="rent">
			<div class="con-box">
				<form name="frm" id="frm" method="get" onSubmit="return false;">
					<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
				<%-- <div class="form1 form1-0">
					<label>유형</label><br>
					<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" />
					<select style="width: 100%;" name="vCarDivCd">
						<option value="" <c:if test="${empty searchVO.sCarDivCd}">selected="selected"</c:if>>전체</option>
						<c:forEach var="code" items="${carDivCd}" varStatus="status">
							<option value="${code.cdNum}" <c:if test="${searchVO.sCarDivCd==code.cdNum}">selected="selected"</c:if>>${code.cdNm}</option>
						</c:forEach>
					</select>
				</div> --%>
				<div class="form1 form1-1">
					<label style="width: 50%;">차량유형</label> <label>렌터카회사</label><br>
					<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" />
					<select name="vCarDivCd">
						<option value="" <c:if test="${empty searchVO.sCarDivCd}">selected="selected"</c:if>>전체</option>
						<c:forEach var="code" items="${carDivCd}" varStatus="status">
							<option value="${code.cdNum}" <c:if test="${searchVO.sCarDivCd==code.cdNum}">selected="selected"</c:if>>${code.cdNm}</option>
						</c:forEach>
					</select>
					<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" />
					<select name="vCorpId">
						<option value="" <c:if test="${empty searchVO.sCorpId}">selected="selected"</c:if>>전체</option>
						<c:forEach var="corp" items="${corpList}" varStatus="status">
							<option value="${corp.corpId}" <c:if test="${searchVO.sCorpId==corp.corpId}">selected="selected"</c:if>>${corp.corpNm}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form1 form1-2">
					<label>차량선택</label><br>
					<select name="sCarCd" id="sCarCd" multiple="multiple">
						<c:forEach items="${carCdList}" var="carCd" varStatus="status">
							<option value="${carCd.cdNum}" <c:if test="${fn:indexOf(searchVO.sCarCd, carCd.cdNum) != -1}">selected="selected"</c:if>>${carCd.cdNm}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form1 form1-2">
					<label for="sFromDtView">대여일</label><br>
					<span>
						<input type="text" name="sFromDtView" id="sFromDtView" value="${searchVO.sFromDtView}" readonly>
						<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
                        <input type="hidden" name="sFromTm" id="sFromTm" value="${searchVO.sFromTm}">
						<!-- <img src="../../images/mw/sub_common/icon_ca.png" width="15" alt="달력"> -->
					</span>
					<select name="vFromTm" id="vFromTm">
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

				<div class="label-infoText">20시 이후 인수 / 08시 이전 반납의 경우 차량별 인수정보 필히 확인</div>

				<div class="form1 form1-2">
					<label for="sToDtView">반납일</label><br>
					<span>
						<input type="text" name="sToDtView" id="sToDtView" value="${searchVO.sToDtView}" readonly>
						<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
						<input type="hidden" name="sToTm" id="sToTm" value="${searchVO.sToTm}">
						<!-- <img src="../../images/mw/sub_common/icon_ca.png" width="15" alt="달력"> -->
					</span>
					<select name="vToTm" id="vToTm">
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
				<!-- <div class="form1 form1-3">
					<input type="text" value="총 24시간 30분" readonly="readonly">
				</div> -->

				<div class="form1 form1-1">
					<label style="width: 50%;">보험여부</label><br>
					<input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />
					<select name="vIsrDiv">
						<option value="" <c:if test="${empty searchVO.sIsrDiv}">selected="selected"</c:if>>전체</option>
						<c:forEach var="isrCd" items="${isrCdList}" varStatus="status">
							<option value="${isrCd.cdNum}" <c:if test="${searchVO.sIsrDiv==isrCd.cdNum}">selected="selected"</c:if>>${isrCd.cdNm}</option>
						</c:forEach>
					</select>
				</div>

				<!-- 주요정보 추가  -->
		        <div class="form1 form1-3">
		            <h5 class="form-title">주요정보</h5>
					<div class="check-list">
						<c:forEach var="icon" items="${iconCd}" varStatus="status">
							<span><input id="iconCd${status.index}" type="checkbox" name="sIconCd" value="${icon.cdNum}"><label for="iconCd${status.index}">${icon.cdNm}</label></span>
						</c:forEach>
					</div>
		        </div>

				<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" >
				<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" >
				</form>
				<p class="btn-list btn-in">
					<a href="javascript:fn_ClickSearch();" class="btn btn1">검색하기</a>
					<a class="btn btn2" onclick="javascript:fn_Reset();return false;"><img src="<c:url value='/images/mw/sub_common/reload.png'/>" width="11" alt=""> 초기화</a>
				</p>
				<c:if test="${fn:length(mdsPickList) > 0 }">
				<div class="md-pick"> <!-- 상품없을시 통으로 삭제 -->
					<h3 class="title">MD’s Pick</h3>
					<div class="md-slide">
						<ul>
							<c:forEach items="${mdsPickList }" var="mds">
							<li>
								<a href="<c:url value='/mw/coustomer/mdsPickDtl.do?rcmdNum=${mds.rcmdNum }' />">
								<div class="ct-box">
									<div class="l-area">
										<p class="photo"><img src="<c:url value='${mds.listImgPath }' />" alt="product"></p>
									</div>
									<div class="r-area">
										<p class="title"><strong>${mds.corpNm }</strong></p>
										<p class="memo">${mds.subject }</p>
									</div>
								</div>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				</c:if>
			</div>
			<div class="best-item">
				<div class="goods-list goods-slide">
					<ul>
						<c:forEach items="${bestPrdtList}" var="bestPrdt" varStatus="status">
							<li>
								<a href="<c:url value='/mw/rentcar/car-detail.do?prdtNum=${bestPrdt.prdtNum}'/>">
									<div class="goods-image">
										<p class="tag3">BEST<br>상품</p>
										<ul class="view">
											<li><img src="${bestPrdt.savePath}thumb/${bestPrdt.saveFileNm}" alt=""/></li>
										</ul>
									</div>
									<p class="info">
										<span class="txt">
											<strong><span>[${bestPrdt.rcNm}]</span> ${bestPrdt.prdtNm}</strong><br>
											<!-- <span class="btn btn4">예약가능</span> -->
											<!--<span class="btn btn5">예약불가</span>-->
										</span>
										<span class="price">
											<del><fmt:formatNumber>${bestPrdt.nmlAmt}</fmt:formatNumber>원</del>
											<img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> <strong><fmt:formatNumber>${bestPrdt.saleAmt}</fmt:formatNumber></strong>원~
										</span>
									</p>
								</a>
							</li>
						</c:forEach>
					</ul>
					<p>
						<span class="btn-prev"></span>
						<span class="btn-next"></span>
					</p>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'z6lvrbj4SSWpNEpzvpAqiA'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>
