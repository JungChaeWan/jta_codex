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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />

<script type="text/javascript">
	var isExitPageComm = false; //페이지 나갈때 물음 여부

	function fn_SetExitParm() {
		isExitPageComm = true;
		//isExitPageComm = false;
	}

	function fn_UnsetExitParm() {
		isExitPageComm = false;
	}

	function fn_Calendar(sPrevNext) {

		$("#sPrevNext").val(sPrevNext);

		document.calendar.action = "<c:url value='/oss/adtmAmtForm.do'/>";
		document.calendar.submit();
	}

	function fn_SetCalendar() {

		var objAdtm = document.calendar.adtmAmt;
		var frmCnt = objAdtm.length;

		for (k = 0; k < frmCnt; k++) {
			var bChkDdl = false;
			if(objAdtm[k].value != "") {
				bChkDdl = true;
			}

			if(objAdtm[k].value != "") {
				if (isNaN(objAdtm[k].value) == true) {
					alert("광고비 는 숫자만 입력이 가능합니다.(" + (k + 1) + "일)");
					objAdtm[k].focus();
					return;
				}
				if (objAdtm[k].value < 0) {
					alert("광고비 는 양의 정수만 입력이 가능합니다.(" + (k + 1) + "일)");
					objAdtm[k].focus();
					return;
				}
			}
		}
		fn_UnsetExitParm();

		document.calendar.action = "<c:url value='/oss/adtmAmtSetCal.do'/>";
		document.calendar.submit();
	}

	$(document).ready(function() {
	    $(window).on("beforeunload", function () {
	        if (isExitPageComm == true){
	        	return "달력 금액에 변경된 부분이 있습니다. 적용하지 않고 페이지를 이동 하시겠습니까?";
	        }
	    });

	});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
        <div id="side_area">
            <!--사이드메뉴-->
            <div class="side_menu">
                <jsp:include page="/oss/left.do?menu=maketing&sub=adtm" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            	<!-- change contents -->
            	<form:form commandName="calendar" name="calendar" method="post"	enctype="multipart/form-data" onSubmit="return false;">

						<!--광고비 입력-->
						<table width="100%" border="0">
							<tr>
								<td valign="top">
									<!--달력입력폼-->
									<input type="hidden" id="iYear" name="iYear" value='<c:out value="${calendarVO.iYear}" />' />
									<input type="hidden" id="iMonth" name="iMonth" value='<c:out value="${calendarVO.iMonth}" />' />
									<input type="hidden" id="iMonthLastDay" name="iMonthLastDay" value='<c:out value="${calendarVO.iMonthLastDay}" />' />
									<input type="hidden" id="sPrevNext" name="sPrevNext" value='' />
									<table border="0" class="calendar_form">
										<col width="25%" />
										<col width="25%" />
										<col width="25%" />
										<col width="25%" />
										<tr class="title">
											<th onclick="fn_Calendar('prev'); return false;" style="cursor: pointer;">◀</th>
											<th id="current_month">${calendarVO.iYear}-${calendarVO.iMonth}</th>
											<th onclick="fn_Calendar('next'); return false;" style="cursor: pointer;">▶</th>
											<td align="right" style="border: 0; padding-left: 25px;">
												<div class="btn_sty01">
													<span> <input type="button" value="수정값 변경 적용" onclick="fn_SetCalendar(); return false;" /></span>
												</div>
											</td>
										</tr>
									</table>
									<div id="lay_calendar">
										<table width="100%" border="0" class="calendar">
											<col width="*" />
											<col width="14.2%" />
											<col width="14.2%" />
											<col width="14.2%" />
											<col width="14.2%" />
											<col width="14.2%" />
											<col width="14.2%" />
											<tr>
												<th scope="col" class="font_red">일</th>
												<th scope="col">월</th>
												<th scope="col">화</th>
												<th scope="col">수</th>
												<th scope="col">목</th>
												<th scope="col">금</th>
												<th scope="col" class="font_blue">토</th>
											</tr>
											<tr>
												<c:forEach var="i" begin="1" end="${calendarVO.iWeek-1}">
													<td>
														<p><strong>&nbsp;</strong></p>
													</td>
												</c:forEach>

												<c:forEach var="data" items="${calList}" varStatus="status">
													<td >
														<c:if test="${data.sHolidayYN == 'Y'}">
															<p class="font_red">
																<strong>${data.iDay}</strong><span class="day_sp"><!-- ${data.sHolidayNm} --></span>
														</c:if>
														<c:if test="${data.sHolidayYN != 'Y'}">
															<c:if test="${data.iWeek == 1}">
																<p class="font_red">
																	<strong>${data.iDay}</strong>
															</c:if>
															<c:if test="${data.iWeek == 7}">
																<p class="font_blue">
																	<strong>${data.iDay}</strong>
															</c:if>
															<c:if test="${!(data.iWeek == 1 || data.iWeek == 7)}">
																<p>
																	<strong>${data.iDay}</strong>
															</c:if>
														</c:if>
														</p>

														<div>
															<p class="calendar_ipgum">
																<span>판&nbsp;매&nbsp;액&nbsp;&nbsp;</span>
																<fmt:formatNumber value="${data.saleAmt}" />
															</p>
															<p class="calendar_price">
																<span >키&nbsp;워&nbsp;드&nbsp;&nbsp;</span>
																<input type="text" id="adtmAmt" name="adtmAmt" class="right" title="광고비를 입력하세요." value="${data.adtmAmt}" onchange="fn_SetExitParm();" style="width: 100px" />
															</p>
															<p class="calendar_price">
																<span>타겟배너&nbsp;&nbsp;</span>
																<input type="text" id="adtmAmtAdd1" name="adtmAmtAdd1" class="right" title="광고비를 입력하세요." value="${data.adtmAmtAdd1}" onchange="fn_SetExitParm();" style="width: 100px" />
															</p>
															<p class="calendar_price">
																<span>바&nbsp;이&nbsp;럴&nbsp;&nbsp;</span>
																<input type="text" id="adtmAmtAdd2" name="adtmAmtAdd2" class="right" title="광고비를 입력하세요." value="${data.adtmAmtAdd2}" onchange="fn_SetExitParm();" style="width: 100px" />
															</p>
															<p class="calendar_price">
																<span>기&nbsp;&nbsp;&nbsp;&nbsp;타&nbsp;&nbsp;</span>
																<input type="text" id="adtmAmtAdd3" name="adtmAmtAdd3" class="right" title="광고비를 입력하세요." value="${data.adtmAmtAdd3}" onchange="fn_SetExitParm();" style="width: 100px" />
															</p>
															<p class="calendar_price">
																<span>온라인합&nbsp;&nbsp;</span>
																<input type="text" id="adtmAmtAdd4" name="adtmAmtAdd4" class="right" title="광고비를 입력하세요." value="${data.adtmAmtAdd4}" onchange="fn_SetExitParm();" style="width: 100px" />
															</p>
															<p class="calendar_price">
																<span>오프라인합</span>
																<input type="text" id="adtmAmtAdd5" name="adtmAmtAdd5" class="right" title="광고비를 입력하세요." value="${data.adtmAmtAdd5}" onchange="fn_SetExitParm();" style="width: 100px" />
															</p>
														</div>
													</td>
													<c:if test="${data.iWeek == 7 && data.iDay!=calendarVO.iMonthLastDay}">
											</tr>
											<tr>
												</c:if>
												<c:set var="lastWeek" value="${data.iWeek}" />
											</c:forEach>
											<c:forEach var="i" begin="${lastWeek+1}" end="7">
													<td>
														<p><strong>&nbsp;</strong></p>
													</td>
											</c:forEach>
											</tr>
										</table>
									</div> <!--//달력입력폼-->
								</td>
							</tr>
						</table>
						<!--//광고비 입력-->

						<!--//본문-->
					</form:form>
			    <!-- //change contents -->

            </div>
        </div>
    </div>
    <!--//Contents 영역-->
</div>
</body>
</html>