<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="un"
	uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript"
	src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
	var isExitPageComm = false; //페이지 나갈때 물음 여부
	
	function fn_SetExitParm() {
		isExitPageComm = true;
		//isExitPageComm = false;
	}

	function fn_UnsetExitParm() {
		isExitPageComm = false;
	}

	/**
	 * 목록
	 */
	function fn_List() {
		document.calendar.action = "<c:url value='/mas/b2b/ad/corpGrpAmtList.do'/>";
		document.calendar.submit();
	}

	function fn_Calendar(sPrevNext) {

		$("#sPrevNext").val(sPrevNext);
		
		document.calendar.action = "<c:url value='/mas/b2b/ad/corpGrpAmt.do'/>";
		document.calendar.submit();
	}

	function fn_SetCalendar() {

		var objSal = document.calendar.saleAmt;
		
		var frmCnt = objSal.length;

		for (k = 0; k < frmCnt; k++) {
			var bChkDdl = false;
			if(objSal[k].value != "") {
				bChkDdl = true;
			}
			
			if(objSal[k].value != "") {
				if (isNaN(objSal[k].value) == true) {
					alert("판매가 는 숫자만 입력이 가능합니다.(" + (k + 1) + "일)");
					objSal[k].focus();
					return;
				}
				if (objSal[k].value < 0) {
					alert("판매가 는 양의 정수만 입력이 가능합니다.(" + (k + 1) + "일)");
					objSal[k].focus();
					return;
				}
			}

			//console.log("["+ (k+1) + "]["+ objSal[k].value);
		}
		
		fn_UnsetExitParm();
		
		document.calendar.action = "<c:url value='/mas/b2b/ad/amtSetCal.do'/>";
		document.calendar.submit();
	}
	
	function fn_SimpleCal() {
		if ($('#startDt').val() == "") {
			alert("적용 기간 시작 일자를 선택 하세요.");
			return;
		}
		if ($('#endDt').val() == "") {
			alert("적용 기간 끝 일자를 선택 하세요.");
			return;
		}

		var nChkCnt = 0;
		var obj = document.calendar.wday;
		var frmCnt = obj.length;
		for (k = 0; k < frmCnt; k++) {
			if (obj[k].checked) {
				nChkCnt++;
			}
		}
		if (nChkCnt == 0) {
			alert("적용 요일을 선택 하세요.");
			return;
		}

		var bInput = false;
		
		if (document.calendar.saleAmtSmp.value != "") {
			//alert("간편입력기에 판매가를 입력 하세요.");
			//document.calendar.saleAmtSmp.focus();
			//return;

			if (isNaN(document.calendar.saleAmtSmp.value) == true) {
				alert("간편입력기에 판매가를 숫자만 입력 하세요.");
				document.calendar.saleAmtSmp.focus();
				return;
			}
			if (document.calendar.saleAmtSmp.value < 0) {
				alert("간편입력기에 판매가를 양의 정수 만 입력 하세요.");
				document.calendar.saleAmtSmp.focus();
				return;
			}
			bInput = true;
		}

		if (bInput == false) {
			alert("적용 할 값을 입력 하세요.");
		}
		
		if(confirm('요금 정보를 입력(수정)하시겠습니까?')==false){
			return;
		}

		fn_UnsetExitParm();
		
		document.calendar.action = "<c:url value='/mas/b2b/ad/amtSetSimple.do' />";
		document.calendar.submit();

	}
	
	function fn_WdayAllSel() {

		var obj = document.calendar.wday;
		var frmCnt = obj.length;

		for (k = 0; k < frmCnt; k++) {
			obj[k].checked = true;
		}

	}

	function fn_WdayInvSel() {

		var obj = document.calendar.wday;
		var frmCnt = obj.length;

		for (k = 0; k < frmCnt; k++) {
			if (obj[k].checked) {
				obj[k].checked = false;
			} else {
				obj[k].checked = true;
			}
		}

	}

	$(document).ready(function() {

		$("#startDtView").datepicker({
			dateFormat: "yy-mm-dd",
			minDate: "${today}",
			maxDate: '+1y',
			onClose : function(selectedDate) {
				$("#endDtView").datepicker("option", "minDate", selectedDate);
			}
		});
		$('#startDtView').change(function() {
			$('#startDt').val($('#startDtView').val().replace(/-/g, ''));
		});
		
			
		$("#endDtView").datepicker({
			dateFormat: "yy-mm-dd",
			minDate: "${today}",
			maxDate: '+1y',
			onClose : function(selectedDate) {
				$("#startDtView").datepicker("option", "maxDate", selectedDate);
			}
		});
		$('#endDtView').change(function() {
			$('#endDt').val($('#endDtView').val().replace(/-/g, ''));
		});

		//요일 선택
		var strWDays = '${calendarVO.wday}'
		var obj = document.calendar.wday;
		var frmCnt = obj.length;
		for (k = 0; k < frmCnt; k++) {
			if (strWDays.charAt(k) == "1") {
				obj[k].checked = true;
			} else {
				obj[k].checked = false;
			}
		}
		
		 
		    
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
		<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
		<!--Contents 영역-->
		<div id="contents_wrapper">
			<div id="contents_area">
				<div id="contents">
					<h2 class="title08"><c:out value="${amtGrpVO.amtNm}" />&nbsp;>&nbsp;<c:out value="${adPrdinf.prdtNm}"/></h2>
				
					<div id="menu_depth3">
						<ul>
							<li><a class="menu_depth3"
								href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpList.do'/>">그룹관리</a></li>
							<c:if test="${Constant.ACCOMMODATION eq masLoginVO.corpCd}">
							<li class="on"><a class="menu_depth3"
								href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpAmtList.do'/>">그룹요금관리</a></li>
							</c:if>
							<c:if test="${Constant.RENTCAR eq masLoginVO.corpCd}">
							<li><a class="menu_depth3"
								href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpDisPerList.do'/>">그룹할인율관리</a></li>
							</c:if>
						</ul>
					</div>
	
					<!--본문-->
	
					<form:form commandName="calendar" name="calendar" method="post"	onSubmit="return false;">
	
						<!--상품요금 입력-->
						<table width="100%" border="0">
							<tr>
								<td valign="top" width="290">
									<!--간편입력폼-->
	
									<h5 class="title03">요금관리</h5>
									<table class="quick_calendar" style="width: 285px;">
										<col width="28%" />
	                                	<col width="72%" />
										<!-- 
	                                <tr>
	                                    <th>객실</th>
	                                    <td class="td_align_lt01"><select name="id2" onchange="this.form.submit();" style="width:96%;">
	                                            <option value="1" selected="selected">Y 디럭스</option>
	                                            <option value="2">Y 패밀리스위트</option>
	                                            <option value="3">Y 허니문스위트</option>
	                                            <option value="4">Y 스파 코너스위트</option>
	                                            <option value="5">Y 풀코너스위트</option>
	                                            <option value="6">Y 펜트하우스</option>
	                                        </select></td>
	                                </tr>
	                                 -->
									</table>
									<h5 class="title02">간편입력기</h5>
	
	
	
									<table class="quick_calendar" style="width: 285px;">
										<col width="28%" />
	                                	<col width="72%" />
										<!-- 
		                                <tr>
		                                    <th>가능기간</th>
		                                    <td class="td_align_lt01 a"><strong>2013-01-01 ~ 2016-12-31</strong></td>
		                                </tr>
		                                 -->
										<tr>
											<th>적용기간</th>
											<td class="td_align_lt01">
												<div style="display:inline-block;">
													<fmt:parseDate value='${calendarVO.startDt}' var='startDt'
														pattern="yyyymmdd" scope="page" />
													<input type="text" id="startDtView" name="startDtView"
														class="input_text3 center"
														value="<fmt:formatDate value="${startDt}" pattern="yyyy-mm-dd"/>"
														readonly="readonly" /> <input type="hidden" id="startDt"
														name="startDt" class="input_text3 center"
														value="${calendarVO.startDt}" />
												</div>
												<div style="display:inline-block;">
													~
													<fmt:parseDate value='${calendarVO.endDt}' var='endDt'
														pattern="yyyymmdd" scope="page" />
													<input type="text" id="endDtView" name="endDtView"
														class="input_text3 center"
														value="<fmt:formatDate value="${endDt}" pattern="yyyy-mm-dd"/>"
														readonly="readonly" /> <input type="hidden" id="endDt"
														name="endDt" class="input_text3 center"
														value="${calendarVO.endDt}" />
												</div>
											</td>
										</tr>
										<tr>
											<th>적용요일</th>
											<td class="td_align_lt01">
												<table border="1" style="width: 100%;">
													<tr>
														<td>
															<div class="btn_sty06">
																<span><a href="javascript:fn_WdayAllSel()">전체선택</a></span>
															</div>
															<div class="btn_sty06">
																<span><a href="javascript:fn_WdayInvSel()">선택반전</a></span>
															</div>
														</td>
													</tr>
													<tr>
														<td style="line-height:1.9em;"><input type="checkbox" name="wday"
															class="required" id="wday_1" value="1"
															title="적용요일을 선택하세요." /> <label for="wday_1"
															style="color: red">일요일</label> <br /> <input
															type="checkbox" name="wday" id="wday_2" value="2" /> <label
															for="wday_2">월요일</label> <br /> <input type="checkbox"
															name="wday" id="wday_3" value="3" /> <label for="wday_3">화요일</label>
															<br /> <input type="checkbox" name="wday" id="wday_4"
															value="4" /> <label for="wday_4">수요일</label> <br /> <input
															type="checkbox" name="wday" id="wday_5" value="5" /> <label
															for="wday_4">목요일</label> <br /> <input type="checkbox"
															name="wday" id="wday_6" value="6" /> <label for="wday_6">금요일</label>
															<br /> <input type="checkbox" name="wday" id="wday_7"
															value="7" /> <label for="wday_7" style="color: blue">토요일</label>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>판매가</th>
											<td class="td_align_lt01">
												<input type="text" name="saleAmtSmp" class="full right" title="간편입력 판매가을 입력하세요." value="${calendarVO.saleAmtSmp}" />
											</td>
										</tr>
									</table> <!--  </form:form> -->
	
									<div class="btn_ct02">
										<li class="btn_sty04"><a href="javascript:fn_SimpleCal()">간편
												입력 적용</a></li>
									</div>
								</td>
	
								<!--//간편입력폼-->
	
	
								<td valign="top">
									<!--달력입력폼--> <!--	<form:form commandName="calendar" name="calendar" method="post" enctype="multipart/form-data"> -->
	
									<input type="hidden" id="prdtNum" name="prdtNum" value='<c:out value="${adPrdinf.prdtNum}" />' /> 
									<input type="hidden" id="iYear" name="iYear" value='<c:out value="${calendarVO.iYear}" />' /> 
									<input type="hidden" id="iMonth" name="iMonth" value='<c:out value="${calendarVO.iMonth}" />' /> 
									<input type="hidden" id="iMonthLastDay" name="iMonthLastDay" value='<c:out value="${calendarVO.iMonthLastDay}" />' /> 
									<input type="hidden" id="sPrevNext" name="sPrevNext" value='' />
									<input type="hidden" id="amtGrpNum" name="amtGrpNum" value="${amtGrpVO.amtGrpNum}" />
									<table border="0" class="calendar_form">
										<col width="25%" />
										<col width="25%" />
										<col width="25%" />
										<col width="25%" />
										<tr class="title">
											<th onclick="fn_Calendar('prev'); return false;"
												style="cursor: pointer;">◀</th>
											<th id="current_month">${calendarVO.iYear}-${calendarVO.iMonth}</th>
											<th onclick="fn_Calendar('next'); return false;"
												style="cursor: pointer;">▶</th>
											<td align="right" style="border: 0; padding-left: 25px;"><div
													class="btn_sty01">
													<span> <input type="button" value="수정값 변경 적용"
														onclick="fn_SetCalendar(); return false;" />
													</span>
												</div></td>
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
													<td><p>
															<strong>&nbsp;</strong>
														</p></td>
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
															<p class="calendar_price">
																<span>판</span>
																<input type="text" id="saleAmt" name="saleAmt" class="right" title="판매가을 입력하세요." value="${data.saleAmt}" onchange="fn_SetExitParm();"/>
															</p>
														</div></td>
	
													<c:if
														test="${data.iWeek == 7 && data.iDay!=calendarVO.iMonthLastDay}">
											</tr>
											<tr>
												</c:if>
	
												<c:set var="lastWeek" value="${data.iWeek}" />
	
												</c:forEach>
												<c:forEach var="i" begin="${lastWeek+1}" end="7">
													<td><p>
															<strong>&nbsp;</strong>
														</p></td>
												</c:forEach>
	
											</tr>
	
										</table>
	
	
	
										<!--<div style="width:100%;height:500px;text-align:center;font-size:16px;padding-top:100px;"> 로딩중입니다. 잠시만 기다려주세요... </div>-->
									</div> <!--//달력입력폼-->
								</td>
							</tr>
						</table>
						<!--//상품요금 입력-->
	
						<!--//본문-->
					</form:form>
					
					<ul class="btn_rt01">
						<li class="btn_sty01"><a href="javascript:fn_List()">목록</a></li>
					</ul>
	
				</div>
				
			</div>	
		</div>
		<!--//Contents 영역-->
	</div>
</body>
</html>