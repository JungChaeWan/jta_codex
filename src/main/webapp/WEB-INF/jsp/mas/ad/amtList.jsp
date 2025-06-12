<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/toastr.min.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel='stylesheet' type="text/css" href="<c:url value='/css/common/toastr.min.css'/>"/>

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
		document.calendar.action = "<c:url value='/mas/ad/productList.do'/>";
		document.calendar.submit();
	}

	function fn_Calendar(sPrevNext) {

		$("#sPrevNext").val(sPrevNext);

		document.calendar.action = "<c:url value='/mas/ad/amtList.do'/>";
		document.calendar.submit();
	}

	/**
	 * 수정값 변경 적용 click
	 * TB_AD_AMTINF테이블에 입금가 (DEPOSIT_AMT) 저장 로직 추가 2022.03.17 chaewan.jung
	 **/
	function fn_SetCalendar() {
		var objSal = document.calendar.saleAmt;
		var objNml = document.calendar.nmlAmt;
		var objDep = document.calendar.depositAmt;

		var objHotdallYn = document.calendar.hotdallYn;
		var objDaypriceYn = document.calendar.daypriceYn;
		var objDaypriceAmt = document.calendar.daypriceAmt;
		var frmCnt = objSal.length;

		// 콤마 제거
		delCommaFormat();

		for (k = 0; k < frmCnt; k++) {
			var bChkDdl = false;
			if(objSal[k].value != "") {
				bChkDdl = true;
			}
			if(objNml[k].value != "") {
				bChkDdl = true;
			}
			if(objDep[k].value != ""){
				bChkDdl = true;
			}

			if(objSal[k].value != "") {
				if (isNaN(objSal[k].value) == true) {
					alert("판매가는 숫자만 입력이 가능합니다.(" + (k + 1) + "일)");
					objSal[k].focus();
					return;
				}
				if (objSal[k].value < 0) {
					alert("판매가는 양의 정수만 입력이 가능합니다.(" + (k + 1) + "일)");
					objSal[k].focus();
					return;
				}

			}

			if(objNml[k].value != "") {
				if (isNaN(objNml[k].value) == true) {
					alert("정가는 숫자만 입력이 가능합니다.(" + (k + 1) + "일)");
					objNml[k].focus();
					return;
				}
				if (objNml[k].value < 0) {
					alert("정가는 양의 정수만 입력이 가능합니다.(" + (k + 1) + "일)");
					objNml[k].focus();
					return;
				}
				if(objSal[k].value == "") {
					alert("판매가를 입력 해주세요." + (k + 1) + "일)");
					objSal[k].focus();
					return;
				}
			}

			if(bChkDdl == true){
				if(objDaypriceYn[k].value==""){
					objDaypriceYn[k].value="N";
	        	}
				if(objDaypriceYn[k].value=="Y"){
					if(objDaypriceAmt[k].value==""){
						alert("" + (k+1) + "일 당일특가 금액을 입력 하세요");
						objDaypriceAmt[k].focus();
						return;
					}
					if (isNaN(objDaypriceAmt[k].value) == true) {
						alert("당일특가 금액은 숫자만 입력이 가능합니다.(" + (k + 1) + "일)");
						objDaypriceAmt[k].focus();
						return;
					}
					if (objDaypriceAmt[k].value < 0) {
						alert("당일특가 금액은 양의 정수만 입력이 가능합니다.(" + (k + 1) + "일)");
						objDaypriceAmt[k].focus();
						return;
					}
					if (Number(objDaypriceAmt[k].value) >= Number(objSal[k].value)) {
						alert("당일특가를 판매가 미만으로 입력 해주세요.(" + (k + 1) + "일)");
						objDaypriceAmt[k].focus();
						return;
					}
				}else{
					if (isNaN(objDaypriceAmt[k].value) == true) {
						objDaypriceAmt[k].value = "";
					}
				}
			}
		}

		for (k = 0; k < frmCnt; k++) {
			$(objDaypriceAmt[k]).attr("disabled", false);
		}

		fn_UnsetExitParm();

		document.calendar.action = "<c:url value='/mas/ad/amtSetCal.do'/>";
		document.calendar.submit();
	}

	function fn_OnCalendarDaypriceAmt(nDay) {
		var objDaypriceYn = document.calendar.daypriceYn;
		var objDaypriceAmt = document.calendar.daypriceAmt;
		var nIdx = nDay-1;

		if(objDaypriceYn[nIdx].value == 'Y'){
			$(objDaypriceAmt[nIdx]).attr("disabled", false);
		}else{
			$(objDaypriceAmt[nIdx]).attr("disabled", true);
		}

		fn_SetExitParm();
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

		// 콤마 제거
		delCommaFormat();
		
		if (document.calendar.nmlAmtSmp.value != "") {
			if (isNaN(document.calendar.nmlAmtSmp.value) == true) {
				alert("간편입력기에 정가를 숫자만 입력 하세요.");
				document.calendar.nmlAmtSmp.focus();
				return;
			}
			if (document.calendar.nmlAmtSmp.value < 0) {
				alert("간편입력기에 정가를 양의 정수만 입력 하세요.");
				document.calendar.nmlAmtSmp.focus();
				return;
			}
			bInput = true;
		}

		if (document.calendar.nmlAmtSmp.value == "") {
			document.calendar.nmlAmtSmp.value = 0;
		}

		if (document.calendar.saleAmtSmp.value != "") {
			if (isNaN(document.calendar.saleAmtSmp.value) == true) {
				alert("간편입력기에 판매가를 숫자만 입력 하세요.");
				$("#simpleSaleAmt").val("");
				$("#simpleAdjAmt").val("");
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

		if (document.calendar.depositAmtSmp.value != "") {
			if (isNaN(document.calendar.depositAmtSmp.value) == true) {
				alert("간편입력기에 입금가를 숫자만 입력 하세요.");
				$("#simpleSaleAmt").val("");
				$("#simpleAdjAmt").val("");
				document.calendar.depositAmtSmp.focus();
				return;
			}
			if (document.calendar.depositAmtSmp.value < 0) {
				alert("간편입력기에 입금가를 양의 정수 만 입력 하세요.");
				document.calendar.depositAmtSmp.focus();
				return;
			}
			bInput = true;
		}

		if (document.calendar.daypriceYnSmp.value != "") {
			if (document.calendar.daypriceYnSmp.value == "Y"){
				if (document.calendar.daypriceAmtSmp.value == "") {
					alert("간편입력기에 당일특가를 입력 하세요.");
					document.calendar.daypriceAmtSmp.focus();
					return;
				}

				if (isNaN(document.calendar.daypriceAmtSmp.value) == true) {
					alert("간편입력기에 당일특가를 숫자만 입력 하세요.");
					document.calendar.daypriceAmtSmp.focus();
					return;
				}

				if (document.calendar.daypriceAmtSmp.value <= 0 ) {
					alert("간편입력기에 당일특가에 0보다 큰 금액을 하세요.");
					document.calendar.daypriceAmtSmp.focus();
					return;
				}
				
				if (Number(document.calendar.daypriceAmtSmp.value) >= Number(document.calendar.saleAmtSmp.value)) {
					alert("당일특가를 판매가 미만으로 입력 해주세요.");
					document.calendar.daypriceAmtSmp.focus();
					return;
				}
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

		document.calendar.action = "<c:url value='/mas/ad/amtSetSimple.do' />";
		document.calendar.submit();

	}

	function fn_OnSmpDaypriceAmt(){
		if(document.calendar.daypriceYnSmp.value == 'Y'){
			$('#daypriceAmtSmp').attr("disabled", false);
		}else{
			$('#daypriceAmtSmp').attr("disabled", true);
		}
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

	/**
	 * 상품 승인 요청
	 */
	function fn_ApprovalReqPrdt() {
		$.ajax({
				url : "<c:url value='/mas/ad/approvalPrdt.ajax'/>",
				dataType : "json",
				data : "prdtNum=${adPrdinf.prdtNum}",
				success : function(data) {
					//location.reload(true);
					location.href = "<c:url value='/mas/ad/amtList.do'/>?prdtNum=${adPrdinf.prdtNum}";
				},
				error : function(request, status, error) {
					if (request.status == "500") {
						alert("<spring:message code='fail.common.logout'/>");
						location.reload(true);
					} else {
						alert("<spring:message code='fail.common.msg'/>");
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
					}
				}
			});
	}

	/**
	 * 상품 승인 취소 요청
	 */
	function fn_CancelApproval() {
		$.ajax({
			url : "<c:url value='/mas/ad/cancelApproval.ajax'/>",
			dataType : "json",
			data : "prdtNum=${adPrdinf.prdtNum}",
			success : function(data) {
				//location.reload(true);
				location.href = "<c:url value='/mas/ad/amtList.do'/>?prdtNum=${adPrdinf.prdtNum}";
			},
			error : function(request, status, error) {
				if (request.status == "500") {
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				} else {
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			}
		});
	}
	
	function pad(n, width) {
		  n = n + '';
		  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}
	
	$(document).ready(function() {
		var prdtNum = "${ADCALENDARVO.prdtNum}";
		toastr.options = {
			"progressBar": true,
			"timeOut": 10000,
			"positionClass": "toast-bottom-left"
		}

		if(${ADCALENDARVO.ioDiv eq Constant.FLAG_Y}){
			if("${adPrdinf.tradeStatus}" != "TS05"){
				toastr.success("요금이 적용됐습니다.<br>(수량을 적용하셔야 정상 적용됩니다.)", "<a href='/mas/ad/cntList.do?prdtNum="+prdtNum+"'"+">수량관리 바로가기</a>");
			}else{
				toastr.success("요금이 적용됐습니다.<br>(수량을 적용하셔야 정상 적용됩니다.)" );
			}
		}

		$("#startDtView").datepicker({
			dateFormat: "yy-mm-dd",
			minDate: "${today}",
			maxDate: '+5y',
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
			maxDate: '+5y',
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

	    // 예상 입금가 출력
	    $('.salePrice').change(function() {
	    	var num = eval($(this).val().replace(/(,)/g, ""));
	    	var adjAmt = num - Math.floor($('#cmssRate').val() * (num / 100) / 10) * 10;
	    	if(!isNaN(adjAmt)){
	    		$('.adjAmt:eq(' + $(this).attr('key') + ')').val(adjAmt);
	    	}
	    });
	    
	 	// 예상 판매가 입력
	    $('.adjAmt').change(function() {
	    	var num = eval($(this).val().replace(/(,)/g, ""));
	    	var saleAmt = Math.floor(eval(num * 100) / (100 - $('#cmssRate').val()) / 10) * 10;	
	    	if(!isNaN(saleAmt)){
	    		$('.salePrice:eq(' + $(this).attr('key') + ')').val(saleAmt);
	    	}
	    });

	    $('.adjAmt').each(function() {
	    	$('.salePrice').change();
	    });

	    // 간편편집기의 예상 판매가 & 입금가
	    $('#simpleSaleAmt').focus(function() {
	    	$('#simpleAdjAmt').attr('disabled', "disabled");
	    });
	    $('#simpleSaleAmt').blur(function() {
	    	if ($('#simpleSaleAmt').val() == '' || $('#simpleSaleAmt').val() == '0') {
	    		$('#simpleAdjAmt').removeAttr('disabled');
	    	}
	    });
	    $('#simpleSaleAmt').change(function() {
	    	var num = eval($(this).val().replace(/(,)/g, ""));
	    	var adjAmt = num - Math.floor($('#cmssRate').val() * (num / 100) / 10) * 10;
	    	$('#simpleAdjAmt').val(adjAmt);
	    	$('input[name=saleAmtSmp]').val($(this).val());
			$('input[name=depositAmtSmp]').val($('#simpleAdjAmt').val());
	    });

	    $('#simpleAdjAmt').focus(function() {
	    	$('#simpleSaleAmt').attr('disabled', "disabled");
	    });
	    $('#simpleAdjAmt').blur(function() {
	    	if ($('#simpleAdjAmt').val() == '' || $('#simpleSaleAmt').val() == '0') {
	    		$('#simpleSaleAmt').removeAttr('disabled');
	    	}
	    });
	    $('#simpleAdjAmt').change(function() {
	    	var num = eval($(this).val().replace(/(,)/g, ""));
	    	var saleAmt = Math.floor(eval(num * 100) / (100 - $('#cmssRate').val()) / 10) * 10;
	    	$('#simpleSaleAmt').val(saleAmt);
	    	$('input[name=saleAmtSmp]').val(saleAmt);
			$('input[name=depositAmtSmp]').val($(this).val());
	    });
	    
	    $(".saleInit").click(function(){
	    	if(confirm("해당날짜의 금액을 정말 초기화하시겠습니까?")){
	    		isExitPageComm = false;
				
				var submitDate = $("#iYear").val() + pad($("#iMonth").val(),2) + pad($(this).parents("p").children("strong").text(),2);  
				$("input[name=aplDt]").val(submitDate);
					
				document.calendar.action = "<c:url value='/mas/ad/delDay.do' />";
				document.calendar.submit();	
	    	};
		  });
	});
</script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="/mas/head.do?menu=product"></jsp:include>
		<!--Contents 영역-->
		<div id="contents_wrapper">
			<div id="contents_area">
				<div id="contents">
					<h2 class="title08"><c:out value="${adPrdinf.prdtNm}"/></h2>
					<input type="hidden" id="cmssRate" value="${adPrdinf.cmssRate }" />

					<div id="menu_depth3">
						<ul>
							<li><a class="menu_depth3" href="<c:url value='/mas/ad/detailPrdt.do?prdtNum=${adPrdinf.prdtNum}'/>">객실정보</a></li>
							<!-- <li><a class="menu_depth3" href="<c:url value='/mas/ad/cntList.do?prdtNum=${adPrdinf.prdtNum}'/>">수량관리</a></li> -->
							<li><a class="menu_depth3" href="<c:url value='/mas/ad/imgList.do?prdtNum=${adPrdinf.prdtNum}'/>">객실이미지</a></li>
							<li class="on"><a class="menu_depth3" href="<c:url value='/mas/ad/amtList.do?prdtNum=${adPrdinf.prdtNum}'/>">요금관리</a></li>
							<c:if test="${adPrdinf.ctnAplYn == 'Y'}">
								<li><a class="menu_depth3" href="<c:url value='/mas/ad/continueNight.do?prdtNum=${adPrdinf.prdtNum}'/>">연박 요금관리</a></li>
						    </c:if>
							<li><a class="menu_depth3" href="<c:url value='/mas/ad/adAddamtPrdtList.do?prdtNum=${adPrdinf.prdtNum}'/>">인원추가요금</a></li>
						</ul>
						<div class="btn_rt01">
							<c:if test="${adPrdinf.tradeStatus == Constant.TRADE_STATUS_REG || adPrdinf.tradeStatus == Constant.TRADE_STATUS_EDIT}">
								<div class="btn_sty01">
									<a href="javascript:fn_ApprovalReqPrdt();">승인요청</a>
								</div>
							</c:if>
							<c:if test="${adPrdinf.tradeStatus == Constant.TRADE_STATUS_APPR_REQ}">
								<div class="btn_sty01">
									<a href="javascript:fn_CancelApproval();">승인요청취소</a>
								</div>
							</c:if>
						</div>
					</div>

					<!--본문-->

					<form:form name="calendar" method="post" enctype="multipart/form-data" onSubmit="return false;">
						<input type="hidden" name="aplDt" value=""/>
						<!--상품요금 입력-->
						<table width="100%" border="0">
							<tr>
								<td valign="top" width="290">
									<h5 class="title03">요금관리</h5>
									<table class="quick_calendar" style="width: 285px;">
										<col width="28%" />
	                                	<col width="72%" />
									</table>
									
									<h5 class="title02">간편입력기</h5>
									<table class="quick_calendar" style="width: 285px;">
										<col width="28%" />
	                                	<col width="72%" />
										<tr>
											<th>적용기간</th>
											<td class="td_align_lt01">
												<div style="display:inline-block;">
													<fmt:parseDate value='${calendarVO.startDt}' var='startDt' pattern="yyyymmdd" scope="page" />
													<input type="text" id="startDtView" name="startDtView" class="input_text3 center" value="<fmt:formatDate value="${startDt}" pattern="yyyy-mm-dd"/>" readonly="readonly" /> 
													<input type="hidden" id="startDt" name="startDt" class="input_text3 center" value="${calendarVO.startDt}" />
												</div>
												<div style="display:inline-block;">
													~
													<fmt:parseDate value='${calendarVO.endDt}' var='endDt' pattern="yyyymmdd" scope="page" />
													<input type="text" id="endDtView" name="endDtView" class="input_text3 center" value="<fmt:formatDate value="${endDt}" pattern="yyyy-mm-dd"/>" readonly="readonly" /> 
													<input type="hidden" id="endDt" name="endDt" class="input_text3 center" value="${calendarVO.endDt}" />
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
														<td style="line-height:1.9em;">
															<input type="checkbox" name="wday" class="required" id="wday_1" value="1" title="적용요일을 선택하세요." />
															<label for="wday_1" style="color: red">일요일</label><br>
															<input type="checkbox" name="wday" id="wday_2" value="2" />
															<label for="wday_2">월요일</label><br>
															<input type="checkbox" name="wday" id="wday_3" value="3" />
															<label for="wday_3">화요일</label><br>
															<input type="checkbox" name="wday" id="wday_4" value="4" />
															<label for="wday_4">수요일</label><br>
															<input type="checkbox" name="wday" id="wday_5" value="5" />
															<label for="wday_5">목요일</label><br>
															<input type="checkbox" name="wday" id="wday_6" value="6" />
															<label for="wday_6">금요일</label><br>
															<input type="checkbox" name="wday" id="wday_7" value="7" />
															<label for="wday_7" style="color: blue">토요일</label>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>정가</th>
											<td class="td_align_lt01">
												<input type="text"	name="nmlAmtSmp"  class="full right numFormat" title="간편입력 정가을 입력하세요." value="${calendarVO.nmlAmtSmp}" />
											</td>
										</tr>
										<tr>
											<th>판매가</th>
											<td class="td_align_lt01">
												<input type="hidden" name="saleAmtSmp" value="" />
												<input type="text" class="full right numFormat"  key='0' id="simpleSaleAmt" title="간편입력 판매가을 입력하세요." value="${calendarVO.saleAmtSmp}" />
											</td>
										</tr>
										<tr>
											<th class="font_red">입금가</th>
											<td class="td_align_lt01">
												<input type="hidden" name="depositAmtSmp" value="" />
												<input type="text" class="full right numFormat"  title="예상 정산 금액 입니다.." value="" id="simpleAdjAmt"/>
											</td>
										</tr>
										<tr>
											<th>당일특가</th>
											<td class="td_align_lt01">
												<select name="daypriceYnSmp" id="daypriceYnSmp" onchange="fn_OnSmpDaypriceAmt();">
		                                    		<option value="" ></option>
		                                            <option value="Y" >사용</option>
		                                            <option value="N" >미사용</option>
		                                        </select>
												<input type="text" name="daypriceAmtSmp" id="daypriceAmtSmp" class="full right numFormat" title="간편입력 당일 특가를 입력하세요." placeholder="판매가 입력" value="${calendarVO.daypriceAmtSmp}" disabled="disabled" />
											</td>
										</tr>
									</table>

									<div class="btn_ct02">
										<li class="btn_sty04"><a href="javascript:fn_SimpleCal()">간편 입력 적용</a></li>
									</div>
									<div>
										<p><span style="background-color:#fa7415;color:#fff;">정</span><span>:정가</span></p>
										<p><span style="background-color:#0760b2;color:#fff;">판</span><span>:판매가 (사용자구매가격)</span></p>
										<p><span style="background-color:red;color:#fff;">입</span><span>:입금가</span></p>
										<p><span style="background-color:#0760b2;color:#fff;">당</span><span>:당일특가 (사용자구매가격)</span></p>
									</div>
								</td>

								<!--//간편입력폼-->
								<td valign="top">
									<input type="hidden" id="prdtNum" name="prdtNum" value='<c:out value="${adPrdinf.prdtNum}" />' />
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
													<td>
														<c:if test="${data.sHolidayYN == 'Y'}">
															<p class="font_red">
																<strong>${data.iDay}</strong><span class="day_sp"></span>
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
														<c:if test="${not empty data.saleAmt}">
															<span class="btn_sty06 dayDel"><a href="javascript:(0);" class="saleInit" >초기화</a></span>
														</c:if>
														</p>

														<div>
															<p class="calendar_ipgum">
																<span>정</span>
																<input type="text" id="nmlAmt" name="nmlAmt" class="right numFormat" title="정상가을 입력하세요." value="${data.nmlAmt}" onchange="fn_SetExitParm();"/>
															</p>
															<p class="calendar_price">
																<span>판</span>
																<input type="text" id="saleAmt" name="saleAmt" key='${status.index }' class="right salePrice numFormat" title="판매가을 입력하세요." value="${data.saleAmt}" onchange="fn_SetExitParm();"/>
															</p>
															<p class="calendar_price">
																<span class="bg-red">입</span>
																<input type="text" id="depositAmt" name="depositAmt" class="right adjAmt font_red numFormat" key='${status.index }' />
															</p>
															<p class="calendar_price">
																<span>당</span>
																<select name="daypriceYn" id="daypriceYn" onchange="fn_OnCalendarDaypriceAmt(${data.iDay});">
																	<c:if test="${data.daypriceYn == null}">
						                                    			<option value="" <c:if test="${data.daypriceYn == null}">selected="selected"</c:if> ></option>
						                                    		</c:if>
					                                           		<option value="Y" <c:if test="${data.daypriceYn == 'Y'}">selected="selected"</c:if> >Y</option>
					                                            	<option value="N" <c:if test="${data.daypriceYn == 'N'}">selected="selected"</c:if> >N</option>
						                                        </select>
						                                        <input type="text" id="daypriceAmt" name="daypriceAmt" class="right numFormat" title="판매가을 입력하세요." value="${data.daypriceAmt}" style="width: 50%" <c:if test="${data.daypriceYn != 'Y'}">disabled="disabled"</c:if> onchange="fn_SetExitParm();"/>
						                                     </p>
														</div>
													</td>

													<c:if test="${data.iWeek == 7 && data.iDay != calendarVO.iMonthLastDay}">
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