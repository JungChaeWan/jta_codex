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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_cart.css?version=${nowDate}'/>">

<script type="text/javascript" src="<c:url value='/js/mw_adDtlCalendar.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_glDtlCalendar.js?version=${nowDate}'/>"></script>
<script type="text/javascript">
/***************************************************
* 렌터카 script
****************************************************/
function fn_OnchangeTime(){
	$("#sFromTm").val($("#vFromTm :selected").val());
	$("#sToTm").val($("#vToTm :selected").val());

	fn_CalRent();
}

/**
 * 대여기간 텍스트 변경
 */
function fn_ChangeRange(){
	$("#info_sDt").html($("#sFromDtView").val());
	$("#info_sTm").html($("#vFromTm :selected").text().text().substring(0,2) + "시");
	$("#info_eDt").html($("#sToDtView").val());
	$("#info_eTm").html($("#vToTm :selected").text().text().substring(0,2) + "시");
}

/**
 * 총합계 노출
 */
function fn_TotalCmt(){
	$("#totalAmt").val(parseInt($("#insuSaleAmt").val()) + parseInt($("#carSaleAmt").val()));
	$("#vTotalAmt").html(commaNum($("#totalAmt").val()));
}

/**
 * 선택사항 변경 시
 */
function fn_OptChange(obj){
	$("#insuSaleAmt").val($(obj).val());
	$("#vInsuSaleAmt").html(commaNum($(obj).val()));

	fn_TotalCmt();
}

function fn_CalRent(){
	if(!checkByFromTo($('#sFromDtView').val(), $("#sToDtView").val(), "Y")){
		$("#errorMsg").html("대여일의 범위가 올바르지 않습니다.");
		$("#divAbleNone").show();
		$("#divAble").hide();
		return;
	}
	var parameters = "sPrdtNum=" + $("#prdtNum").val();
	parameters += "&sFromDt=" + $("#sFromDt").val();
	parameters += "&sFromTm=" + $("#sFromTm").val();
	parameters += "&sToDt=" + $("#sToDt").val();
	parameters += "&sToTm=" + $("#sToTm").val();

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/rentcar/calRent.ajax'/>",
		data:parameters,
		success:function(data){
			fn_ChangeRange();
			// alert(data.prdtInfo.ableYn);
			$(".time").html(data.prdtInfo.rsvTm + "시간");
			$("input[name=time]").val(data.prdtInfo.rsvTm + "시간");
			$("#carSaleAmt").val(data.prdtInfo.saleAmt);
			$("#vCarSaleAmt").html(commaNum(data.prdtInfo.saleAmt));
			$("#insuSaleAmt").val($("#payOption :selected").val());
			$("#vInsuSaleAmt").html(commaNum($("#insuSaleAmt").val()));
			$("#nmlAmt").val(data.prdtInfo.nmlAmt);

			fn_TotalCmt();

			if(data.prdtInfo.ableYn == "Y"){
				$("#divAbleNone").hide();
				$("#divAble").show();
			}else{
				$("#errorMsg").html("예약마감");
				$("#divAbleNone").show();
				$("#divAble").hide();
			}
		},
		error:fn_AjaxError
	});
}

function changeOptionCartRC(cartSn) {
	var cart = {
		prdtNum 	: $("#prdtNum").val(),
		fromDt 		: $("#sFromDt").val(),
		toDt 		: $("#sToDt").val(),
		fromTm 		: $("#sFromTm").val(),	// 대여시간
		toTm 		: $("#sToTm").val(),	// 반납시간
		insureDiv	: $("#payOption :selected").val(),
		addAmt		: $("#insuSaleAmt").val(),
		cartSn 		: cartSn
	};

	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json",
		url:"<c:url value='/mw/changeCart.ajax'/>",
		data:JSON.stringify(cart),
		success:function(data){
			alert("옵션이 변경됐습니다.");
			$('.option-wrap').html('');
			close_popup($('.option-wrap'));
			location.reload();
		},
		error:fn_AjaxError
	});
}

/***************************************************
* 렌터카 script_End
****************************************************/
/***************************************************
* 소셜 script
****************************************************/
function getCalOption() {
	var calP = $("#spCalendarForm").serialize();

	$.ajax({
		url:"<c:url value='/mw/sp/getCalOptionList.ajax'/>",
		data:calP,
		success:function(data) {
			$('.comm-select dd').css('display', 'none');
			$('#calendar').html(data);
			$('#calendar').css('display','block');
			$("#iYear").val($(".calY1").text());
			$("#iMonth").val($(".calM1").text());
		},
		error:fn_AjaxError
	});
}

/**
 * 달력 옵션 선택시
 */
function selectCalOption(selectDay, obj) {
	$(".comm-select2 dt>span").text("(" + getDayFormat(selectDay, ". ") + ")");
	$("table.cal tr>td").removeClass("today");
	$(obj).parents("td").addClass("today");

	getSecondOption(selectDay);
}

function getSecondOption(aplDt) {
	$("#secondOptionList").empty();

	$.ajax({
		url: "<c:url value='/mw/sp/getOptionList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val() + "&spDivSn=" + $("#spDivSn").val() + "&aplDt=" + aplDt,
		success:function(data) {
			var list = data.list;
			var dataArr;
			var inx = 0, count =1;

			if(list != "") {
				$(list).each( function() {
					if(this.stockNum > 0 && this.ddlYn == 'N') {
						dataArr = '<li>';
						dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.optNm + '">';
						dataArr += '<p class="product">';
						dataArr += '<span>[선택' + count + ']</span>';
						dataArr += '<span>' + fn_addDate(this.aplDt) + " " + this.optNm + '</span>';
						dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
						dataArr += '</p>';
						dataArr += '<p class="price">' + commaNum(this.saleAmt) + '</p>';
						dataArr += '</a>';
						dataArr += '</li>';
					} else {
						dataArr = '<li>';
						dataArr += '<p class="product">';
						dataArr += '<span>[선택' + count + ']</span>';
						dataArr += '<span>' + fn_addDate(this.aplDt) + " " + this.optNm + '</span>';
						// dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
						dataArr += '</p>';
						dataArr += '<p class="price">품절</p>';
						dataArr += '</li>';
					}
					count++;
					$("#secondOptionList").append(dataArr);
					$("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this) );
					inx++;
				});

				$('.comm-select dd').css('display', 'none');
				$(".comm-select3 dd").css('display', 'block');
			}
			// $("#calendar").hide();
		},
		error: fn_AjaxError
	});
}

function loadSecondOption() {
	$("#secondOptionList").empty();

	$.ajax({
		url: "<c:url value='/mw/sp/getOptionList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val() + "&spDivSn=" + $("#spDivSn").val(),
		success:function(data) {
			var list = data.list;
			var text;
			var count =1;
			if(list != "" ) {
				$(list).each( function() {
					if(this.spOptSn == $("#spOptSn").val()) {
						text = '<span>[선택' + count + ']</span>';
						text += '<span>' + fn_addDate(this.aplDt) + ' ' + this.optNm + '</span>';

						if(this.stockNum > 0 && this.ddlYn == 'N') {
							text += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
						}
						$(".comm-select3 dt").html(text);
						$(".comm-select3 dt").attr("data-raw", JSON.stringify(this));
						$("#addOptionList").attr("data-raw", JSON.stringify(this));
						return false;
					}
					count++;
				});
			}
		},
		error: fn_AjaxError
	});
}

/** 추가옵션선택시 */
function getAddOption() {
	if($(".comm-select4 dd").css('display') == 'block') {
		$('.comm-select dd').css('display', 'none');
		return ;
	}

	if($("#addOptionList li").length > 0) {
		if($(".comm-select4 dd").css('display') == 'none') {
			$('.comm-select dd').css('display', 'none');
			$('#calendar').css('display','none');
			$(".comm-select4 dd").css('display', 'block')
		}
		$('.comm-select').removeClass('open');
		$('.opCal').removeClass('open');
		$('.comm-select4').addClass('open');
		return false;
	}
	var b_data = {
		addOptNm 	: '',
		addOptAmt 	: 0,
		addOptSn 	: ''
 	};

	$.ajax({
		url: "<c:url value='/web/sp/getAddOptList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val(),
		success:function(data) {
			var list = data.list;

			var dataArr ='<li><a href="javascript:void(0)" data-raw="" title=""><p class="product"><span>선택안함</span></p></a></li>';

			$("#addOptionList").append(dataArr);

			var inx = 1;

			if(list != "") {
				$(list).each( function() {
					dataArr = '<li>';
					dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.addOptNm + '">';
					dataArr += '<p class="product"><span>' +  this.addOptNm + '</span></p>';
					dataArr += '<p class="price">' + commaNum(this.addOptAmt) + '</p>';
					dataArr += '</a>';
					dataArr += '</li>';

					$("#addOptionList").append(dataArr);
					$("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
					inx++;
				});
				$("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data));
			}
		},
		error: fn_AjaxError
	});

	$('.comm-select').removeClass('open');
	$('.opCal').removeClass('open');
	$('.comm-select4').addClass('open');
	$('.comm-select dd').css('display', 'none');
	$(".comm-select4 dd").css('display', 'block');
}

function addition() {
	var dataRaw =  jQuery.parseJSON($(".comm-select3 dt").attr("data-raw"));
	var  stockNum = parseInt(dataRaw.stockNum);
	var num = parseInt($("#qty").val()) + 1;

	if(num <= stockNum) {
		$("#qty").val(num);

		selectedItemSaleAmt();
	}
}

function substract() {
	var num = parseInt($("#qty").val()) - 1;

	if(num >= 1) {
		$("#qty").val(num);
		selectedItemSaleAmt();
	}
}

// 금액 변경
function selectedItemSaleAmt() {
	var dataRaw = "";

	if($("#addOptListLength").val() == 0) {
		dataRaw = jQuery.parseJSON($(".comm-select3 dt").attr("data-raw"));
	} else {
		dataRaw = jQuery.parseJSON($(".comm-select4 dt").attr("data-raw"));
	}
	var price = parseInt(dataRaw.saleAmt) * parseInt($("#qty").val());

	$("#vTotalAmt").html(commaNum(price));
}

// 카트 정보에 옵션 중복 체크.
function checkDupOption(newData) {
	var result = false;

	$("input[name='spCart']").each( function() {
		var cartSn = $(this).val();

		if( $("input[name='" + cartSn + "_prdtNum']").val() == $("#prdtNum").val()) {
			// 내꺼는 다시 선택해도 괜찮다.
			if($("#spDivSn").val() == newData.spDivSn && $("#spOptSn").val() == newData.spOptSn) {
				result = false;
				return false;
			} else if($("input[name='" + cartSn + "_optSn']").val() == newData.spOptSn && $("input[name='" + cartSn + "_divSn']").val() == newData.spDivSn) {
				result = true;
				return false;
			}
		}
	});

	return result;
}

//변경 완료 버튼 클릭 시 카트 다시 담기.
function changeOptionCartSP(cartSn) {
	// validation에 따라 바뀔수 있음.
	var cart = {
		prdtNum 	: $("#prdtNum").val(),
		qty 		: $("#qty").val(),
		spOptSn 	: $("#spOptSn").val(),
		spDivSn 	: $("#spDivSn").val(),
		cartSn 		: cartSn,
		addOptAmt 	: $("#addOptAmt").val(),
		addOptNm 	: $("#addOptNm").val()
	};

	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json",
		url:"<c:url value='/mw/changeCart.ajax'/>",
		data:JSON.stringify(cart),
		success:function(data){
			alert("옵션이 변경됐습니다.");
			$('.option-wrap').html('');
			close_popup($('.option-wrap'));
			location.reload();
		},
		error:fn_AjaxError
	});
}

function nextCalendar(){
	$("#sPrevNext").val("next");

	getCalOption();
}

function prevCalendar() {
	$("#sPrevNext").val("prev");

	getCalOption();
}

/***************************************************
* 소셜 script_End
****************************************************/


/***************************************************
* 숙소 script
****************************************************/

//변경 완료 버튼 클릭 시 카트 다시 담기.
function changeOptionCartAD(cartSn) {
	var cart = {
		prdtNum 	: $("#prdtNum").val(),
		startDt 	: $("#sFromDt").val(),
		night 		: $("#adCalNight").val(),
		adultCnt	: $("#adCalMen1").val(),
		juniorCnt	: $("#adCalMen2").val(),
		childCnt	: $("#adCalMen3").val(),
		cartSn 		: cartSn
	};

	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json",
		url:"<c:url value='/web/changeCart.ajax'/>",
		data:JSON.stringify(cart),
		success:function(data){
			alert("옵션이 변경됐습니다.");
			$('.option-wrap').html('');
			close_popup($('.option-wrap'));
			location.reload();
		},
		error:fn_AjaxError
	});

}

/***************************************************
* 숙소 script_End
****************************************************/

/***************************************************
* 기념품 script
****************************************************/
function getSvSecondOption() {
	$("#secondOptionList").empty();

	$.ajax({
		url: "<c:url value='/web/sv/getOptionList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val() + "&svDivSn=" + $("#svDivSn").val(),
		success:function(data) {
			var list = data.list;
			var dataArr;
			var inx = 0, count =1;

			if(list != "") {
				$(list).each(function() {
					if(this.stockNum > 0 && this.ddlYn == 'N') {
						dataArr = '<li>';
						dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.optNm + '">';
						dataArr += '<p class="product">';
						dataArr += '<span>[선택' + count + ']</span>';
						dataArr += '<span>' + this.optNm + '</span>';
						dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
						dataArr += '</p>';
						dataArr += '<p class="price">' + commaNum(this.saleAmt) + '</p>';
						dataArr += '</a>';
						dataArr += '</li>';
					} else {
						dataArr = '<li>';
						dataArr += '<p class="product">';
						dataArr += '<span>[선택' + count + ']</span>';
						dataArr += '<span>' + this.optNm + '</span>';
						// dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
						dataArr += '</p>';
						dataArr += '<p class="price">품절</p>';
						dataArr += '</li>';
					}
					count++;
					$("#secondOptionList").append(dataArr);
					$("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
					inx++;
				});

				$('.comm-select dd').css('display', 'none');
				$(".comm-select3 dd").css('display', 'block');
				$('.comm-select3').addClass('open');
			}
		},
		error: fn_AjaxError
	});
}

function SvLoadSecondOption() {
	$("#secondOptionList").empty();

	$.ajax({
		url: "<c:url value='/web/sv/getOptionList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val() + "&svDivSn=" + $("#svDivSn").val(),
		success:function(data) {
			var list = data.list;
			var text;
			var count = 1;

			if(list != "" ) {
				$(list).each(function() {
					if(this.svOptSn == $("#svOptSn").val() ) {
						text = '<span>[선택' + count + ']</span>';
						text += '<span>' + fn_addDate(this.aplDt) + ' ' + this.optNm + '</span>';

						if(this.stockNum > 0 && this.ddlYn == 'N') {
							text += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
						}
						$(".comm-select3 dt").html(text);
						$(".comm-select3 dt").attr("data-raw", JSON.stringify(this) );
						$("#addOptionList").attr("data-raw", JSON.stringify(this));
						$(".comm-select3").addClass("open");

						var dataRaw = this;
						var saleAmt = Number(this.saleAmt) + Number($("#addOptAmt").val());
						this.saleAmt = saleAmt;
						$(".comm-select4 dt").attr("data-raw", JSON.stringify(dataRaw));
						return false;
					}
					count++;
				});
			}
		},
		error: fn_AjaxError
	});
}

function SvAddition() {
	var dataRaw = jQuery.parseJSON($(".comm-select3 dt").attr("data-raw"));
	var stockNum = parseInt(dataRaw.stockNum);
	var num = parseInt($("#qty").val()) + 1;

	if(num <= stockNum) {
		$("#qty").val(num);

		selectedItemSaleAmt();
	}
}

function SvSubstract() {
	var num = parseInt($("#qty").val()) - 1;

	if(num >= 1) {
		$("#qty").val(num);

		selectedItemSaleAmt();
	}
}

// 카트 정보에 옵션 중복 체크.
function SvCheckDupOption(newData) {
	var result = false;

	$("input[name='svCart']").each(function() {
		var cartSn = $(this).val();

		if( $("input[name='" + cartSn + "_prdtNum']").val() == $("#prdtNum").val()) {
			// 내꺼는 다시 선택해도 괜찮다.
			if($("#svDivSn").val() == newData.svDivSn && $("#svOptSn").val() == newData.svOptSn) {
				result = false;
				return false;
			} else if($("input[name='" + cartSn + "_optSn']").val() == newData.svOptSn && $("input[name='" + cartSn + "_divSn']").val() == newData.svDivSn) {
				result = true;
				return false;
			}
		}
	});

	return result;
}

/** 추가옵션선택시 */
function getSvAddOption() {
	if($(".comm-select4 dd").css('display') == 'block') {
		$('.comm-select4 dd').css('display', 'none');
		return ;
	}
	if($("#addOptionList li").length > 0) {
		if($(".comm-select4 dd").css('display') == 'none') {
			$('.comm-select3 dd').css('display', 'none');
			$(".comm-select4 dd").css('display', 'block')
		}
		$('.comm-select').removeClass('open');
		$('.comm-select4').addClass('open');
		return false;
	}
	var b_data = {
		addOptNm 	: '',
		addOptAmt 	: 0,
		addOptSn 	: ''
 	};

	$.ajax({
		url: "<c:url value='/web/sv/getAddOptList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val(),
		success:function(data) {
			var dataArr ='<li><a href="javascript:void(0)" data-raw="" title=""><p class="product"><span>선택안함</span></p></a></li>';

			$("#addOptionList").append(dataArr);

			var list = data.list;
			var inx = 1;

			if(list != "" ) {
				$(list).each( function() {
					dataArr = '<li>';
					dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.addOptNm + '">';
					dataArr += '<p class="product"><span>' +  this.addOptNm + '</span></p>';
					dataArr += '<p class="price">' + commaNum(this.addOptAmt) + '</p>';
					dataArr += '</a>';
					dataArr += '</li>';

					$("#addOptionList").append(dataArr);
					$("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
					inx++;
				});

				$("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data));
			}
		},
		error : fn_AjaxError
	});

	$('.comm-select').removeClass('open');
	$('.comm-select4').addClass('open');
	$('.comm-select dd').css('display', 'none');
	$(".comm-select4 dd").css('display', 'block');
}

//변경 완료 버튼 클릭 시 카트 다시 담기.
function changeOptionCartSv(cartSn) {
	// validation에 따라 바뀔수 있음.
	var cart = {
		prdtNum 		: $("#prdtNum").val(),
		qty 			: $("#qty").val(),
		svOptSn 		: $("#svOptSn").val(),
		svDivSn 		: $("#svDivSn").val(),
		cartSn 			: cartSn,
		addOptAmt 		: $("#addOptAmt").val(),
		addOptNm 		: $("#addOptNm").val(),
		directRecvYn 	: $("select[name=directRecvYn]").val()
	};

	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json",
		url:"<c:url value='/web/changeCart.ajax'/>",
		data:JSON.stringify(cart),
		success:function(data){
			alert("옵션이 변경됐습니다.");
			$('.option-wrap').html('');
			close_popup($('.option-wrap'));
			location.reload();
		},
		error:fn_AjaxError
	});
}

/***************************************************
* 제주특산품 script_End
****************************************************/


/**
 * 장바구니 비우기
 */
function fn_ChkDelCart(){
	if(!confirm("선택상품을 삭제하시겠습니까?")){return;}
	var cartSn = [];

	$("input:checkbox[name=chk]").each(function(index){
		if($(this).is(":checked")){
			cartSn.push($(this).val());
		}
	});

	var parameters = "cartSn=" + cartSn;

	$.ajax({
		type:"post",
		url:"<c:url value='/web/deleteCart.ajax'/>",
		data:parameters,
		beforeSend:function(){
			if("${fn:length(cartList) == 0}" == "true"){
				alert("장바구니에 담긴 상품이 없습니다.");
				location.reload();
				return false;
			}
		},
		success:function(data){
			for(var i = $("#cartGoodsList .check-goods").length; i >= 0; i--){
				if($("input:checkbox[name=chk]").eq(i-1).is(":checked")){
					$("#cartGoodsList .check-goods").eq(i-1).remove();
				}
			}
			if($("#cartGoodsList .check-goods").length == 0){
				$("#cartList").css("display", "none");

				if($("#sv_cartGoodsList .check-goods").length == 0){
					$("#emptyCart").css("display", "block");
				}
			}
			$("#headCartCnt").html(data.cartCnt);

			fn_TotalJumunAmt();
		},
		error:fn_AjaxError
	});
}

/**
 * 단건 삭제
 */
function fn_DelCart(cartSn, category){
	if(!confirm("삭제하시겠습니까?")){return;}

	var parameters = "cartSn=" + cartSn;

	$.ajax({
		type:"post",
		url:"<c:url value='/web/deleteCart.ajax'/>",
		data:parameters,
		beforeSend:function(){
			if("${fn:length(cartList) == 0}" == "true"){
				alert("장바구니에 담긴 상품이 없습니다.");
				location.reload();
				return false;
			}
		},
		success:function(data){
			if(category != "SV") {
				for(var i = $("#cartGoodsList .check-goods").length; i >= 0; i--){
					if($("input[name=cartSn]").eq(i-1).val() == cartSn){
						$("#cartGoodsList .check-goods").eq(i-1).remove();
					}
				}
				if($("#cartGoodsList .check-goods").length == 0){
					$("#cartList").css("display", "none");

					if($("#sv_cartGoodsList .check-goods").length == 0){
						$("#emptyCart").css("display", "block");
					}
				}
				fn_TotalJumunAmt();
			} else {
				for(var i = $("#sv_cartGoodsList .check-goods").length; i >= 0; i--){
					if($("input[name=svCart]").eq(i-1).val() == cartSn){
						$("#sv_cartGoodsList .check-goods").eq(i-1).remove();
					}
				}
				if($("#sv_cartGoodsList .check-goods").length == 0){
					$("#sv_cartList").css("display", "none");

					if($("#cartGoodsList .check-goods").length == 0){
						$("#emptyCart").css("display", "block");
					}
				}
				fn_TotalSvJumunAmt();
			}
			$("#headCartCnt").html(data.cartCnt);
		},
		error:fn_AjaxError
	});
}

/**
 * 기념품 장바구니 비우기
 */
function fn_SvDelCart(){
	if(!confirm("선택상품을 삭제하시겠습니까?")){return;}
	var cartSn = [];

	$("input:checkbox[name=sv_chk]").each(function(index){
		if($(this).is(":checked")){
			cartSn.push($(this).val());
		}
	});

	if(cartSn.length == 0){
		alert("선택된 상품이 없습니다.");
		return;
	}else{
		var parameters = "cartSn=" + cartSn;

		$.ajax({
			type:"post",
			url:"<c:url value='/web/deleteCart.ajax'/>",
			data:parameters,
			beforeSend:function(){
				if("${fn:length(cartList) == 0}" == "true"){
					alert("장바구니에 담긴 상품이 없습니다.");
					location.reload();
					return false;
				}
			},
			success:function(data){
				for(var i = $("#sv_cartGoodsList .check-goods").length; i >= 0; i--){
					if($("input[name=svCart]").eq(i-1).val() == cartSn){
						$("#sv_cartGoodsList .check-goods").eq(i-1).remove();
					}
				}
				if($("#sv_cartGoodsList .check-goods").length == 0){
					$("#sv_cartList").css('display', 'none');

					if($("#cartGoodsList .check-goods").length == 0){
						$("#emptyCart").css("display", "block");
					}
				}
				$("#headCartCnt").html(data.cartCnt);

				fn_TotalSvJumunAmt();
			},
			error:fn_AjaxError
		});
	}
}

function fn_ShowLayer(cartSn, divCd){
	var parameters = "cartSn=" + cartSn;
	$('.option-wrap').html("");
	
	$.ajax({
		type:"post",
		url:"<c:url value='/mw/cartOptionLayer.ajax'/>",
		data:parameters,
		beforeSend:function(){
			if("${fn:length(cartList) == 0}" == "true"){
				alert("장바구니에 담긴 상품이 없습니다.");
				location.reload();
				return false;
			}
		},
		success:function(data){
			$('.option-wrap').html(data);

			/***************************************************
			* 렌터카
			****************************************************/
			if(divCd == 'rc') {
				$("#sFromDtView").datepicker({
					dateFormat: "yy-mm-dd",
					minDate: "${SVR_TODAY}",
					onSelect: function(selectedDate) {
						$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));

						$("#sToDtView").val(fn_NexDay(selectedDate));
						$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

						fn_CalRent();
					}
				});

				$("#sToDtView").datepicker({
					dateFormat: "yy-mm-dd",
					minDate: "${SVR_TODAY}",
					onSelect : function(selectedDate) {
						$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

						fn_CalRent();
					}
				});

				fn_CalRent();

			} else if(divCd == "sp") {
				/***************************************************
				* 소셜
				****************************************************/
				$('.comm-select2 dt').click(function(){
					 if($('#calendar').css('display')=='block'){
					        $('#calendar').css('display', 'none');
					 } else {
					   	if($("#calendar strong").length > 0 ) {
					       	$('#calendar').css('display', 'block');
					   	} else {
					   		getCalOption();
				    	}
				    }
				});

				$('.comm-select3 dt').click(function(){
					if($(".comm-select3 dd").css('display') == 'block') {
						$(".comm-select3 dd").css('display', 'none');
					} else {
						if($("#secondOptionList li").length > 0) {
							$(".comm-select3 dd").css('display', 'block');
						} else {
							if("${Constant.SP_PRDT_DIV_TOUR}" != $("#prdtDiv").val())
								getSecondOption('');
						}
					}
				});

				$('.comm-select4 dt').click(function(){
					if($(".comm-select4 dd").css('display') == 'block') {
						$(".comm-select4 dd").css('display', 'none');
					} else {
						if($("#addOptionList li").length > 0) {
							$(".comm-select4 dd").css('display', 'block');
						} else {
							if("${Constant.SP_PRDT_DIV_TOUR}" != $("#prdtDiv").val())
								getAddOption();
						}
					}
			    });

				// 옵션 클릭시.
				$("#secondOptionList").on("click", "li>a", function() {
					var data = jQuery.parseJSON($(this).attr("data-raw"));
					// 중복체크.
					if(checkDupOption(data)) {
						alert("<spring:message code='fail.product.duplication'/>");
						return false;
					}
					if($("#addOptListLength").val() == 0) {

					 	$(".comm-select3 dt").attr("data-raw", $(this).attr("data-raw"))
						$('.comm-select3 dd').css('display', 'none');
						$(".comm-select3 dt").html($(this).find(".product").html());
						$("#spOptSn").val(data.spOptSn);

						selectedItemSaleAmt();
					} else {
						getAddOption();

						$("#spOptSn").val(data.spOptSn);
						$("#addOptionList").attr("data-raw",$(this).attr("data-raw"));
						$(".comm-select3 dt").html($(this).find(".product").html());
					}
				});

				//추가옵션 클릭시
				$("#addOptionList").on('click', "li>a", function() {
					var dataRaw =  jQuery.parseJSON($("#addOptionList").attr("data-raw"));
					var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));

					var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);

					dataRaw.saleAmt = saleAmt;

					var ori_dataRaw = JSON.stringify(dataRaw);

					$('.comm-select dd').css('display', 'none');
					$(".comm-select4 dt").attr("data-raw", ori_dataRaw)
					$(".comm-select4 dt").html($(this).find(".product").html());

					$("#addOptNm").val(thisDataRaw.addOptNm);
					$("#addOptAmt").val(thisDataRaw.addOptAmt);

					if($('.opCal').css('display') == "block") {
						$(".comm-select").removeClass("open");
						$('.opCal').addClass("open");
					} else {
						$('.comm-select').removeClass('open');
						$('.comm-select2').addClass('open');
					}
					selectedItemSaleAmt();
				});

				$(".comm-qtyWrap").on("keyup", "#qty", function() {
					var dataRaw =  jQuery.parseJSON($(".comm-select3 dt").attr("data-raw"));
					var stockNum = parseInt(dataRaw.stockNum);
					$(this).val($(this).val().replace(/[^0-9]/gi,""));
					if($(this).val() > stockNum) {
						$(this).val(stockNum);
					}
					selectedItemSaleAmt();
				});
				// 초기화.
				loadSecondOption();

			} else if(divCd == "ad") {
				/***************************************************
				* 숙소
				****************************************************/
			} else if(divCd == "sv") {
				/***************************************************
				* 제주특산품
				****************************************************/
				$('.comm-select3 dt').click(function(){
					if($(".comm-select3 dd").css('display') == 'block') {
						$(".comm-select3 dd").css('display', 'none');
					} else {
						if($("#secondOptionList li").length > 0) {
							$(".comm-select3 dd").css('display', 'block');
						} else {
							getSvSecondOption();
						}
					}
				});

				$('.comm-select4 dt').click(function(){
					if($(".comm-select4 dd").css('display') == 'block') {
						$(".comm-select4 dd").css('display', 'none');
					} else {
						if($("#addOptionList li").length > 0) {
							$(".comm-select4 dd").css('display', 'block');
						} else {
							getSvAddOption();
						}
					}
			    });

				// 옵션 클릭시.
				$("#secondOptionList").on("click", "li>a", function() {
					var data =  jQuery.parseJSON($(this).attr("data-raw"));
					// 중복체크.
					if(SvCheckDupOption(data)) {
						alert("<spring:message code='fail.product.duplication'/>");
						return false;
					}
					if($("#addOptListLength").val() == 0) {
					 	$(".comm-select3 dt").attr("data-raw", $(this).attr("data-raw"))
						$('.comm-select3 dd').css('display', 'none');
						$(".comm-select3 dt").html($(this).find(".product").html());
						$("#svOptSn").val(data.svOptSn);

						selectedItemSaleAmt();
					} else {
						getSvAddOption();

						$("#svOptSn").val(data.svOptSn);
						$("#addOptionList").attr("data-raw", $(this).attr("data-raw"));
						$(".comm-select3 dt").html($(this).find(".product").html());
					}
				});

				//추가옵션 클릭시
				$("#addOptionList").on('click', "li>a", function() {
					var dataRaw = jQuery.parseJSON($("#addOptionList").attr("data-raw"));
					var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));

					var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);

					dataRaw.saleAmt = saleAmt;

					var ori_dataRaw = JSON.stringify(dataRaw);

					$('.comm-select dd').css('display', 'none');
					$(".comm-select4 dt").attr("data-raw", ori_dataRaw)
					$(".comm-select4 dt").html($(this).find(".product").html());

					$("#addOptNm").val(thisDataRaw.addOptNm);
					$("#addOptAmt").val(thisDataRaw.addOptAmt);

					$('.comm-select').removeClass('open');
					$('.comm-select3').addClass('open');

					selectedItemSaleAmt();
				});

				$(".comm-qtyWrap").on("keyup", "#qty", function() {
					var dataRaw = jQuery.parseJSON($(".comm-select3 dt").attr("data-raw"));
					var stockNum = parseInt(dataRaw.stockNum);
					$(this).val($(this).val().replace(/[^0-9]/gi,""));

					if($(this).val() > stockNum) {
						$(this).val(stockNum);
					}

					selectedItemSaleAmt();
				});
				// 초기화.
				SvLoadSecondOption();
			}

			//옵션 닫기
			$('.option-change .btn-close').click(function(){

				$('.option-wrap').hide();
				$('.option-wrap').css('top', 'auto');

				$(".lock-bg").remove();
				$(".not_scroll").removeClass();

				return false;
			});

		},
		error:fn_AjaxError
	});
}

function fn_TotalJumunAmt(){
	var totalJumunAmt = 0;

	$("input:checkbox[name=chk]").each(function(index){
		if($(this).is(":checked")){
			totalJumunAmt += parseInt($("input[name=cartTotalAmt]").eq(index).val());
		}
	});

	$("#totalJumunAmt").html(commaNum(totalJumunAmt));
}

function fn_TotalSvJumunAmt(){
	var prdtAmt = 0;
	var dlvAmt = 0;

	$("input:checkbox[name=sv_chk]").each(function(index){
		if($(this).is(":checked")){
			prdtAmt += parseInt($("input[name=sv_cartTotalAmt]").eq(index).val());
			dlvAmt += parseInt($("input[name=sv_dlvAmt]").eq(index).val());
		}
	});

	$("#sv_totalPrdtAmt").html(commaNum(prdtAmt));
	$("#sv_totalDlvAmt").html(commaNum(dlvAmt));
	$("#sv_totalJumunAmt").html(commaNum(prdtAmt + dlvAmt));
}

function fn_Reservation(){
	var cartSn = [];

	$("input:checkbox[name=chk]").each(function(index){
		if($(this).is(":checked")){
			cartSn.push($(this).val());
		}
	});

	if(cartSn.length == 0){
		alert("선택된 상품이 없습니다.");
		return;
	}else{
		$.ajax({
			type:"post",
			url:"<c:url value='/web/reservationChk.ajax'/>",
			beforeSend:function(){
				if("${fn:length(cartList) == 0}" == "true") {
					alert("장바구니에 담긴 상품이 없습니다.");
					location.reload();
					return false;
				}
			},
			success:function(data){
				var errorCnt = 0;

				jQuery.each(data.cartList, function(index, onerow){
					if(onerow["ableYn"] == "N") {
						if(onerow["prdtNum"].substring(0, 2) != "SV") {
							if($("#chk" + onerow["cartSn"]).is(":checked")) {
								errorCnt++;
							}
							$("#nt" + onerow["cartSn"]).show();
						}
					}
				});

				if(errorCnt > 0) {
					alert("예약이 불가능한 상품이 존재합니다.");
					return;
				} else {
					location.href = "<c:url value='/mw/order01.do?cartSn=' />" + cartSn + "&rsvDiv=${Constant.RSV_DIV_C}";
				}
			},
			error:fn_AjaxError
		});
	}
}

function fn_SvReservation(){
	var cartSn = [];

	$("input:checkbox[name=sv_chk]").each(function(index){
		if($(this).is(":checked")){
			cartSn.push($(this).val());
		}
	});

	if(cartSn.length == 0){
		alert("선택된 상품이 없습니다.");
		return;
	}else{
		$.ajax({
			type:"post",
			url:"<c:url value='/web/reservationChk.ajax'/>",
			beforeSend:function(){
				if("${fn:length(cartList) == 0}" == "true") {
					alert("장바구니에 담긴 상품이 없습니다.");
					location.reload();
					return false;
				}
			},
			success:function(data){
				var errorCnt = 0;

				jQuery.each(data.cartList, function(index, onerow){
					if(onerow["ableYn"] == "N"){
						if(onerow["prdtNum"].substring(0, 2) == "SV") {
							if($("#chk" + onerow["cartSn"]).is(":checked")) {
								errorCnt++;
							}
							$("#nt" + onerow["cartSn"]).show();
						}
					}
				});

				if(errorCnt > 0) {
					alert("예약이 불가능한 상품이 존재합니다.");
					return;
				} else {
					location.href = "<c:url value='/mw/order01.do?cartSn=' />" + cartSn + "&rsvDiv=${Constant.RSV_DIV_C}";
				}
			},
			error:fn_AjaxError
		});
	}
}


$(document).ready(function(){

	// 옵션변경 레이어팝업
    $(".unit_btnarea > a").click(function(){

		$(".option-wrap").fadeToggle();

		$("body").addClass("not_scroll");
		$('.option-wrap').css('position', 'fixed');
		$('.option-wrap').animate( {'top' : '5%'}, 200);

		$("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경

    });

	$("#all_check").click(function(){
		if($(this).is(":checked")){
			$("input:checkbox[name=chk]").prop("checked", true);
		}else{
			$("input:checkbox[name=chk]").prop("checked", false);
		}
		fn_TotalJumunAmt();
	});

	$("input:checkbox[name=chk]").click(function(){
		fn_TotalJumunAmt();
		if($("input:checkbox[name=chk]").length == $("input:checkbox[name=chk]:checked").length ){
			$("#all_check").prop("checked", true);
		}else if($("input:checkbox[name=chk]").length > $("input:checkbox[name=chk]:checked").length){
			$("#all_check").prop("checked", false);
		}
	});

	$("#sv_all_check").click(function(){
		if($(this).is(":checked")){
			$("input:checkbox[name=sv_chk]").prop("checked", true);
		}else{
			$("input:checkbox[name=sv_chk]").prop("checked", false);
		}
		fn_TotalSvJumunAmt();
	});

	$("input:checkbox[name=sv_chk]").click(function(){
		fn_TotalSvJumunAmt();
		if($("input:checkbox[name=sv_chk]").length == $("input:checkbox[name=sv_chk]:checked").length ){
			$("#sv_all_check").prop("checked", true);
		}else if($("input:checkbox[name=sv_chk]").length > $("input:checkbox[name=sv_chk]:checked").length){
			$("#sv_all_check").prop("checked", false);
		}
	});

	fn_TotalJumunAmt();
	fn_TotalSvJumunAmt();
});
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="장바구니"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="sub-content">
		<div class="cart">
			<div class="cart-section" id="emptyCart" <c:if test="${not empty cartList}">style="display:none;"</c:if>>
				<section class="cart-none">
					<div class="">
						<img src="/images/mw/cart/not.gif" alt="빈 장바구니">
						<p>장바구니가 비었습니다.</p>
					</div>
				</section>
			</div>

			<c:if test="${not empty cartList}">
				<c:set var="cartSize" value="0" />
				<c:set var="sv_cartSize" value="0" />

				<c:forEach var="cart" items="${cartList}" varStatus="status">
					<c:choose>
						<c:when test="${fn:substring(cart.prdtNum, 0, 2) eq Constant.SV}">
							<c:set var="sv_cartSize" value="${sv_cartSize + 1}" />
						</c:when>
						<c:otherwise>
							<c:set var="cartSize" value="${cartSize + 1}" />
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${cartSize > 0}">
					<div class="cart-section" id="cartList">
						<h3 class="title">여행 상품</h3>
						<div class="goods_control">
							<div class="goods_control_check">
                            <span class="check-all">
                                <input type="checkbox" id="all_check" class="blind form_checkbox" checked="checked">
                                <label class="text_all-agree" for="all_check">
                                    <span class="blind">모든상품전체선택</span>
                                </label>
                            </span>
								<label for="all_check" class="all_check_tx text_all-agree">전체선택</label>
							</div>
							<a href="javascript:fn_ChkDelCart();" class="clear-btn">
								<span>선택삭제</span>
							</a>
						</div>
						<div id="cartGoodsList">
						<c:forEach var="cart" items="${cartList}" varStatus="status">
						<c:set var="category" value="${fn:substring(cart.prdtNum, 0, 2)}" />
						<c:choose>
						<c:when test="${category eq Constant.SOCIAL}">
						<input type="hidden" name="spCart" value="${cart.cartSn}" />
						<input type="hidden" name="${cart.cartSn}_prdtNum" value="${cart.prdtNum}" />
						<input type="hidden" name="${cart.cartSn}_optSn" value="${cart.spOptSn}" />
						<input type="hidden" name="${cart.cartSn}_divSn" value="${cart.spDivSn}" />

						<div class="check-goods">
							<div class="unit_thmb">
								<span class="unit_chk">
								<input type="hidden" name="cartSn" value="${cart.cartSn}">
								<input class="form_checkbox" type="checkbox" name="chk" id="chk${cart.cartSn}" value="${cart.cartSn}" <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
								<label class="label_terms" for="chk${cart.cartSn}">
									<span class="blind">상품선택</span>
								</label>
								</span>
								<span class="unit_img">
									<img src="${cart.imgPath}" alt="소셜이미지" onerror="this.src='/images/web/other/no-image.jpg'">
								</span>
							</div>
							<div class="unit_cont">
								<div class="unit_top">
									<span class="unit_option">${cart.prdtDivNm} | ${cart.optNm}
										<c:if test="${not empty cart.addOptNm}">
											| ${cart.addOptNm}
										</c:if>
									</span>
									<span>
										<a href="javascript:fn_DelCart('${cart.cartSn}', '${category}')" class="unitbtn close">
											<img src="/images/mw/icon/close/dark-gray.png" alt="삭제">
										</a>
									</span>
								</div>
								<p class="unit_title">
									<a href="javascript:void(0)">
										<span><strong>[${cart.corpNm}]</strong>${cart.prdtNm}</span>
									</a>
								</p>
								<span class="unit_cnt">
									수량 : <strong>${cart.qty}</strong>
									<c:if test="${not empty cart.aplDt}">
										<fmt:parseDate value='${cart.aplDt}' var='aplDt' pattern="yyyyMMdd" scope="page"/>
										(<fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd"/>)
									</c:if>
								</span>
								<div class="unit_prdpay">
									<div class="unit_l">
										<input type="hidden" name="cartTotalAmt" value="${cart.totalAmt}">
										<c:if test="${cart.totalAmt != '-2'}">
										<em class="item-newprice"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber></em>
										<span class="won">원</span>
										</c:if>
										<c:if test="${cart.totalAmt == '-2'}">
											<em class="item-newprice">예약불가</em>
										</c:if>
									</div>
									<div class="unit_r">
										<div class="unit_btnarea">
											<a href="javascript:fn_ShowLayer('${cart.cartSn}', 'sp')" class="option1 unitbtn"><span>옵션 변경</span></a>
										</div>
									</div>
								</div>
							</div>
						</div>
						</c:when>
						<c:when test="${category eq Constant.ACCOMMODATION}">
						<div class="check-goods">
							<div class="unit_thmb">
							<span class="unit_chk">
							<input type="hidden" name="cartSn" value="${cart.cartSn}">
							<input class="form_checkbox" type="checkbox" name="chk" id="chk${cart.cartSn}" value="${cart.cartSn}" <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
							<label class="label_terms" for="chk${cart.cartSn}">
								<span class="blind">상품선택</span>
							</label>
							</span>
								<span class="unit_img">
									<img src="${cart.imgPath}" alt="숙소이미지" onerror="this.src='/images/web/other/no-image.jpg'">
							</span>
							</div>
							<div class="unit_cont">
								<div class="unit_top">
									<span class="unit_cnt">
									<fmt:parseDate value='${cart.startDt}' var='fromDttm' pattern="yyyyMMdd" scope="page"/>
									<fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd"/> 부터 ${cart.night}박
									</span>
									<span>
										<a href="javascript:fn_DelCart('${cart.cartSn}', '${category}')" class="unitbtn close">
											<img src="/images/mw/icon/close/dark-gray.png" alt="삭제">
										</a>
									</span>
								</div>
								<p class="unit_title">
									<a href="javascript:void(0)">
										<span><strong>[${cart.corpNm}]</strong>${cart.prdtNm}</span>
									</a>
								</p>
								<span class="unit_option">
								성인 ${cart.adultCnt}
								<c:if test="${cart.juniorCnt > 0}">, 소아 ${cart.juniorCnt}</c:if>
								<c:if test="${cart.childCnt > 0}">, 유아 ${cart.childCnt}</c:if>
								</span>
								<div class="unit_prdpay">
									<div class="unit_l">
										<input type="hidden" name="cartTotalAmt" value="${cart.totalAmt}">
										<c:if test="${cart.totalAmt != '-2'}">
											<em class="item-newprice"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber></em>
											<span class="won">원</span>
										</c:if>
										<c:if test="${cart.totalAmt == '-2'}">
											<em class="item-newprice">예약불가</em>
										</c:if>
									</div>
									<div class="unit_r">
										<div class="unit_btnarea">
											<a href="javascript:fn_ShowLayer('${cart.cartSn}', 'sp')" class="option1 unitbtn"><span>옵션 변경</span></a>
										</div>
									</div>
								</div>
							</div>
						</div>
						</c:when>
						<c:when test="${category eq Constant.RENTCAR}">
						<div class="check-goods">
							<div class="unit_thmb">
						<span class="unit_chk">
						<input type="hidden" name="cartSn" value="${cart.cartSn}">
						<input class="form_checkbox" type="checkbox" name="chk" id="chk${cart.cartSn}" value="${cart.cartSn}" <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
						<label class="label_terms" for="chk${cart.cartSn}">
							<span class="blind">상품선택</span>
						</label>
						</span>
								<span class="unit_img">
								<img src="${cart.imgPath}" alt="렌트이미지" onerror="this.src='/images/web/other/no-image.jpg'">
						</span>
							</div>
							<div class="unit_cont">
								<div class="unit_top">
									<c:set var="prdtNms" value="${fn:split(cart.prdtNm, '/')}" />
									<span class="unit_option">${prdtNms[1]} | ${prdtNms[2]}</span>
									<span>
										<a href="javascript:fn_DelCart('${cart.cartSn}', '${category}')" class="unitbtn close">
											<img src="/images/mw/icon/close/dark-gray.png" alt="삭제">
										</a>
									</span>
								</div>
								<p class="unit_title">
									<a href="javascript:void(0)">
										<span><strong>[${cart.corpNm}]</strong>${prdtNms[0]}</span>
									</a>
								</p>
								<span class="unit_cnt">
								<fmt:parseDate value='${cart.fromDt}${cart.fromTm}' var='fromDttm' pattern="yyyyMMddHHmm" scope="page"/>
								<fmt:parseDate value='${cart.toDt}${cart.toTm}' var='toDttm' pattern="yyyyMMddHHmm" scope="page"/>
								<fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${toDttm}" pattern="yyyy-MM-dd HH:mm"/>
								</span>
								<div class="unit_prdpay">
									<div class="unit_l">
										<input type="hidden" name="cartTotalAmt" value="${cart.totalAmt}">
										<c:if test="${cart.totalAmt != '-2'}">
											<em class="item-newprice"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber></em>
											<span class="won">원</span>
										</c:if>
										<c:if test="${cart.totalAmt == '-2'}">
											<em class="item-newprice">예약불가</em>
										</c:if>
									</div>
									<div class="unit_r">
										<div class="unit_btnarea">

										</div>
									</div>
								</div>
							</div>
						</div>
						</c:when>
						</c:choose>
						</c:forEach>
						</div>
						<div class="price">
							<div class="price-comment">
								<span class="sale">할인</span>
								예약페이지에서 할인쿠폰 선택하기 확인
							</div>
							총 주문금액
							<span><strong id="totalJumunAmt">0</strong>원</span>
						</div>
						<div class="purchaseButton">
							<a href="javascript:fn_Reservation();" class="btn btn1">예약하기</a>
						</div>
					</div>
				</c:if>

				<!-- 제주특산품 -->
				<c:if test="${sv_cartSize > 0}">
					<div class="cart-section" id="sv_cartList">
						<h3 class="title">제주 특산/기념품</h3>
						<div class="goods_control">
							<div class="goods_control_check">
                            <span class="check-all">
                                <input type="checkbox" id="sv_all_check" class="blind form_checkbox sprite_join-default" checked="checked">
                                <label for="sv_all_check">
                                    <span class="blind">모든상품전체선택</span>
                                </label>
                            </span>
								<label for="sv_all_check" class="all_check_tx">전체선택</label>
							</div>
							<a href="javascript:fn_SvDelCart();" class="clear-btn">
								<span>선택삭제</span>
							</a>
						</div>
						<div id="sv_cartGoodsList">
						<c:set var="sv_dlvAmtDiv" value="NULL" />
						<c:set var="sv_pCorpId" value="NULL" />
						<c:set var="sv_prdc" value="NULL"/>
						<c:forEach var="cart" items="${cartList}" varStatus="status">
							<c:if test="${fn:substring(cart.prdtNum, 0, 2) eq Constant.SV}">
								<c:set var="sv_dlvAmt" value="0" />
								<input type="hidden" name="svCart" value="${cart.cartSn}" />
								<input type="hidden" name="${cart.cartSn}_prdtNum" value="${cart.prdtNum}" />
								<input type="hidden" name="${cart.cartSn}_optSn" value="${cart.svOptSn}" />
								<input type="hidden" name="${cart.cartSn}_divSn" value="${cart.svDivSn}" />

								<div class="check-goods">
									<div class="unit_thmb">
								   <span class="unit_chk">
										<input type="hidden" name="cartSn" value="${cart.cartSn}">
										<input class="form_checkbox" type="checkbox" name="sv_chk" id="chk${cart.cartSn}" value="${cart.cartSn}" <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if> class="form_checkbox">
										<label class="label_terms" for="chk${cart.cartSn}">
											<span class="blind">상품선택</span>
										</label>
								   </span>
									<span class="unit_img">
									  <img src="${cart.imgPath}" alt="특산기념품이미지" onerror="this.src='/images/web/other/no-image.jpg'">
								   </span>
									</div>
									<div class="unit_cont">
										<div class="unit_top">
											<span class="unit_option">${cart.prdtDivNm} | ${cart.optNm} <c:if test="${not empty cart.addOptNm}"> | ${cart.addOptNm}</c:if></span>
											<span>
												<a href="javascript:fn_DelCart('${cart.cartSn}', 'SV')" class="unitbtn close">
													<img src="/images/mw/icon/close/dark-gray.png" alt="삭제">
												</a>
											</span>
										</div>
										<p class="unit_title">
											<a href="javascript:void(0)">
												<span><strong>[${cart.corpNm}]</strong>${cart.prdtNm}</span>
											</a>
										</p>
										<span class="unit_cnt">수량 : ${cart.qty}</span>
										<div class="unit_deliveryPrice">
											<c:if test="${(cart.corpId ne sv_pCorpId) or ((cart.corpId eq sv_pCorpId) and ((cart.dlvAmtDiv ne sv_dlvAmtDiv) or (cart.directRecvYn ne sv_directRecvYn) or (cart.prdc ne sv_prdc) )) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI)}">
												<c:set var="c_SaleAmt" value="0" />
												<c:if test="${(cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV)}">
													<c:forEach var="sub_cart" items="${cartList}" varStatus="sub_status">
														<c:if test="${(fn:substring(sub_cart.prdtNum, 0, 2) eq Constant.SV) and (sub_cart.corpId eq cart.corpId) and (sub_cart.dlvAmtDiv eq cart.dlvAmtDiv) and (sub_cart.directRecvYn eq cart.directRecvYn) and (sub_cart.prdc eq cart.prdc)}">
															<c:set var="c_SaleAmt" value="${c_SaleAmt + sub_cart.totalAmt}" />
														</c:if>
													</c:forEach>
												</c:if>
												<span>배송비 : </span>
												<c:choose>
													<c:when test="${cart.directRecvYn == 'Y'}">
														<span class="deliveryPrice"><span>무료(직접수령)</span></span>
													</c:when>
													<c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV}">
														<c:set var="sv_dlvAmt" value="${cart.dlvAmt}" />
														<span class="deliveryPrice"><span><fmt:formatNumber>${cart.dlvAmt}</fmt:formatNumber>원</span></span>
													</c:when>
													<c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL}">
														<c:if test="${cart.aplAmt <= c_SaleAmt}">
															<c:set var="sv_dlvAmt" value="0" />
															<span class="deliveryPrice"><span>무료</span></span>
														</c:if>
														<c:if test="${cart.aplAmt > c_SaleAmt}">
															<c:set var="sv_dlvAmt" value="${cart.dlvAmt}" />
															<span class="deliveryPrice"><span><fmt:formatNumber>${cart.dlvAmt}</fmt:formatNumber>원</span></span>
														</c:if>
														<span class="deliveryPrice_cmt">(<fmt:formatNumber>${cart.aplAmt}</fmt:formatNumber>원 이상 구매시 무료)</span>
													</c:when>
													<c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI}">
														<c:set var="sv_dlvAmt" value="${cart.dlvAmt}" />
														개별 배송비
													</c:when>
													<c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE}">
														<c:set var="sv_dlvAmt" value="0" />
														<span class="deliveryPrice">무료</span>
													</c:when>
												</c:choose>
											</c:if>
											<c:if test="${(cart.corpId eq sv_pCorpId) and (cart.dlvAmtDiv eq sv_dlvAmtDiv) and (cart.directRecvYn eq sv_directRecvYn)}">
												<span>배송비 : 판매자 묶음상품</span>
											</c:if>
										</div>
										<div class="unit_prdpay">
											<input type="hidden" name="cartTotalAmt" value="10,500">
											<div class="unit_l">
												<c:if test="${cart.totalAmt != '-2'}">
													<em class="item-newprice"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber></em>
													<span class="won">원</span>
												</c:if>
												<c:if test="${cart.totalAmt == '-2'}">
													<p class="item-newprice">예약 불가</p>
												</c:if>

											</div>
											<div class="unit_r">
												<div class="unit_btnarea">
													<a href="javascript:fn_ShowLayer('${cart.cartSn}', 'sv')" class="option4 unitbtn"><span>옵션 변경</span></a>
													<input type="hidden" name="sv_dlvAmt" value="${sv_dlvAmt}">
													<input type="hidden" name="sv_cartTotalAmt" value="${cart.totalAmt}">
												</div>
											</div>
										</div>
									</div>
								</div>
								<c:set var="sv_pCorpId" value="${cart.corpId}" />
								<c:set var="sv_dlvAmtDiv" value="${cart.dlvAmtDiv}" />
								<c:set var="sv_directRecvYn" value="${cart.directRecvYn}" />
								<c:set var="sv_prdc" value="${cart.prdc}"/>
							</c:if>
						</c:forEach>
						</div>
						<div class="price">
							<div class="price-comment">
								<span class="sale">할인</span>
								예약페이지에서 할인쿠폰 선택하기 확인
							</div>
							<div class="price-container">
								<div class="price-container-wrap">
									총 상품가격
									<span><strong id="sv_totalPrdtAmt">0</strong>원</span>
								</div>
								<div class="price-container-wrap">
									총 배송비
									<span><strong id="sv_totalDlvAmt">0</strong>원</span>
								</div>
							</div>
							총 주문 금액
							<span><strong id="sv_totalJumunAmt">0</strong>원</span>
						</div>
						<div class="purchaseButton">
							<a href="javascript:fn_SvReservation();" class="btn btn1">구매하기</a>
						</div>
					</div> <!-- //제주특산품 -->
				</c:if>
			</c:if>
		</div>
	</div>
</section>
<div class="option-wrap"></div>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 장바구니목록페이지 (장바구니보기) -->
<!-- AceCounter Mobile eCommerce (Cart_Inout) v7.5 Start -->
<script language='javascript'>
 var AM_Cart=(function(){
	var c=
		//{pd:'제품ID',pn:'제품명',am:'제품소계',qy:'제품수량',ct:'제품카테고리명'}
		{
		<c:forEach items="${cartList}" var="cart" varStatus="status">
			<c:choose>
				<c:when test="${Constant.ACCOMMODATION eq fn:substring(cart.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="숙소" />
				</c:when>
				<c:when test="${Constant.RENTCAR eq fn:substring(cart.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="렌터카" />
				</c:when>
				<c:when test="${Constant.GOLF eq fn:substring(cart.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="골프" />
				</c:when>
				<c:when test="${Constant.SOCIAL eq fn:substring(cart.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="${cart.ctgrNm}" />
				</c:when>

   				<c:when test="${Constant.SV eq fn:substring(cart.prdtNum,0,2)}">
   					<c:set var="strprdtNm" value="제주특산/기념품" />
   				</c:when>
   			</c:choose>
			pd:'<c:out value='${cart.prdtNum}'/>',pn:'<c:out value='${cart.prdtNm}'/>',am:'[<c:out value="${cart.corpNm}"/>]<c:out value='${cart.prdtNm}'/>',qy:'1',ct:'${strprdtNm}'
			<c:if test='${!status.last}'>,</c:if>

		</c:forEach>
		};
	var u=(!AM_Cart)?[]:AM_Cart; u[c.pd]=c;return u;
})();
</script>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

</body>
</html>
