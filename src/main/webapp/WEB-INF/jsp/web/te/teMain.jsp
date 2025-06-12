<!DOCTYPE html>
<html lang="ko">
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
<%-- <jsp:include page="/web/includeJs.do"></jsp:include>--%>
<title></title>
<meta name="description" content="">
<meta name="keywords" content="">

<meta name="robots" content="noindex, nofollow">

<link rel="shortcut icon" href="/images/web/favicon/16.ico">
<link rel="shortcut icon" href="/images/web/favicon/32.ico">

<script src="/js/jquery-1.11.1.js" ></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.cookie.js"></script>
<script src="/js/slideshow_dot.js"></script>
<script src="/js/slider.js"></script>
<script src="/js/common.js"></script>

<script src="/js/cookie.js"></script>

<script src="/js/swiper.js"></script>
<script src="/js/html_style.js"></script>

<script src="/js/jquery.zoom.min.js"></script>



<script type="text/javascript" src="<c:url value='/js/adDtlCalendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/glDtlCalendar.js'/>"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />



<script type="text/javascript">

function layerP1() {
	$('.layer-1').click(function() {
		$(this).next('.layerP1').css('display', 'block');
	});
	$('.layerP1-close').click(function() {
		$('.layerP1').css('display', 'none');
	});
};



function fn_goTab(type) {
	$(".travel-list li").removeClass('select');
	$("#" + type).addClass("select");
	
	$(".search-form").addClass("hide");
	
	if(type=="c_tourCpn") {
		// 리스트 출력.
		$("#spForm input[name=sCtgr]").val('${Constant.CATEGORY_TOUR}');
		$("#spForm input[name=sTabCtgr]").val('');
		//fn_SpSearch(1);
		// 네비 출력.
		$(".tourCpnForm").removeClass('hide');
		spSearchForm('', type);
	} else if(type == "c_etc") {
		$("#spForm input[name=sCtgr]").val('${Constant.CATEGORY_ETC}')
		$("#spForm input[name=sTabCtgr]").val('');
		//fn_SpSearch(1);
		// 네비 출력.
		$(".etcForm").removeClass('hide');
		spSearchForm('', type);
	} else if(type == "c_av") {
		$(".avForm").removeClass('hide');
	} else if(type == "c_ad") {
		fn_AdSearch(1);
		$(".adForm").removeClass('hide');
	} else if(type == "c_rc") {
		fn_RcSearch(1);
		$(".rcForm").removeClass('hide');
	} else if(type == "c_golf") {
		fn_GlSearch(1);
		$(".golfForm").removeClass('hide');
	}
} 

function fn_ShowOption(prdtNum, divCd){
	var parameters = "prdtNum=" + prdtNum + "&divCd=" +divCd;;
	
	if(divCd == "ad") {
		parameters += "&sFromDt="+$("#adForm").find("[name=sFromDt]").val()
		         	+ "&sNights="+$("#adForm").find("[name=sNights]").val()
	}else if(divCd == "gl") {
		parameters += "&sFromDt="+$("#glForm").find("[name=sFromDt]").val()
     				+ "&sNights="+$("#glForm").find("[name=sNights]").val()
	}else if(divCd == "rc"){
		parameters += "&sFromDt="+$("#rcForm").find("[name=sFromDt]").val()
					+ "&sFromTm="+$("#rcForm").find("[name=sFromTm]").val()
					+ "&sToDt="+$("#rcForm").find("[name=sToDt]").val()
					+ "&sToTm="+$("#rcForm").find("[name=sToTm]").val()
					
		$("#rcForm").find("[name=prdtNum]").val(prdtNum);
	}
	
	$.ajax({
		type:"post", 
		url:"<c:url value='/web/te/optionLayer.ajax'/>",
		data:parameters ,
		success:function(data){
			$('.option-wrap').html(data);

			/***************************************************
			* 렌터카
			****************************************************/
			if(divCd == 'rc') {
				
				$("#sFromDt").val($("#rcForm").find("[name=sFromDt]").val());
				
				$("#sFromDtView").datepicker({
					dateFormat: "yy-mm-dd",
					minDate: "${SVR_TODAY}",
					defaultDate: fn_addDate($("#rcForm").find("[name=sFromDt]").val()),
					onSelect : function(selectedDate) {
						$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
						
						$('#sToDtView').datepicker("destroy");
						
						$("#sToDtView").datepicker({
							dateFormat: "yy-mm-dd",
							minDate: "${SVR_TODAY}",
							defaultDate: fn_NexDay(selectedDate),
							onSelect : function(selectedDate) {
								$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
								fn_CalRent();
								
							}
						});
						
						$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
						
						fn_CalRent();
						
						// $("#sToDtView").datepicker("option", "minDate", selectedDate); 
					}
				});
				
				$("#sToDtView").datepicker({
					dateFormat: "yy-mm-dd",
					minDate: "${SVR_TODAY}",
					defaultDate: fn_addDate($("#rcForm").find("[name=sToDt]").val()),
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
				$('.comm-select1 .select-button').click(function(){
					if($("#firstOptionList").css('display') == 'block') {
						$('.comm-select .select-list-option').css('display', 'none');
						return ;
					}
					if($("#firstOptionList li").length > 0) {
						if($("#firstOptionList").css('display') == 'none') {
							$('.comm-select .select-list-option').css('display', 'none');
							<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
								$('.packCalendar').css('display','none');
							</c:if>
							$("#firstOptionList").css('display', 'block');
							$('.comm-select').removeClass('open');
							$('.comm-select1').addClass('open');
						}
						return;
					}
			      $.ajax({
						url: "<c:url value='/web/sp/getDivInfList.ajax'/>",
						data: "prdtNum=" + prdtNum,
						success:function(data) {
							var list = data.list;
							var dataArr ;
							var inx = 0, count =1;
							if(list != "" ) {
								$(list).each( function() {
									dataArr = '<li><a href="javascript:;" data-raw="" title="'+this.prdtDivNm +'"><p class="product"><span>[선택'+ count+']</span> '
															+'<span>'+  this.prdtDivNm + '</span></p></a></li>';
									count++;
									$("#firstOptionList").append(dataArr);
									$("#firstOptionList li:eq("+inx+")>a").attr("data-raw",JSON.stringify(this) );
									inx++;
								});
								
								$('.comm-select .select-list-option').css('display', 'none');
								$('.comm-select1 .select-list-option').css('display', 'block');
								
								$('.comm-select').removeClass('open');
								$('.comm-select1').addClass('open');
							}
						},
						error : fn_AjaxError
					})
			      
			    });
				
				$("#firstOptionList").on('click', "li>a", function() {
					var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
					var title = $(this).attr("title");
					
					$(".comm-select1 .select-button").text(title);
					
					$("#secondOptionList").empty();
					getSecondOption(dataRaw.spDivSn)
					
				});
				
				$('.comm-select2 .select-button').click(function(){
					if($("#secondOptionList").css('display') == 'block') {
						$("#secondOptionList").css('display', 'none');
					} else {
						if($("#secondOptionList li").length > 0) {
							$("#secondOptionList").css('display', 'block');
							$('.comm-select').removeClass('open');
							$('.comm-select2').addClass('open');
						} else {
							$("#secondOptionList").css('display', 'none');
						}
					}
				});
				
				// 옵션 클릭시.
				$("#secondOptionList").on("click", "li>a", function() {
					var dataRaw =  jQuery.parseJSON($(this).attr("data-raw"));
					var ori_dataRaw = $(this).attr("data-raw");
					var firstOptionText = $(".comm-select1 .select-button").text();
					var secondOptionText = $(this).attr("title");
					if(checkDupOption(dataRaw)) {
						alert("<spring:message code='fail.product.duplication'/>");
						return ;
					}
					
					if($("#addOptListLength").val() == 0) {
						var text = '<li class="qty-list"><ol><li class="list1">' + firstOptionText + "<br/>" + fn_addDate(dataRaw.aplDt) +" "+ secondOptionText+ ' | 잔여 : <span class="option-stockNum" style="display:none">' + commaNum(dataRaw.stockNum) + '</span>개</li>'
						 + '<li class="list2"><input type="text" value="1" class="qty-input"><button class="addition">+</button><button class="subtract">-</button></li>' 
						 +'<li class="list3"><span class="price">'+ commaNum(dataRaw.saleAmt)+'</span> <a href="javascript:;"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a></li>'
						 +'</ol></li>';
						 
						$("#selectedItemWrapper ul").append(text);
						
						$("#selectedItemWrapper ul>li").last().attr("data-raw",ori_dataRaw);
						
						$("#selectedItemWrapper").css('display', 'block');
						$('.comm-select .select-list-option').css('display', 'none');
						$("#secondOptionList").empty();
						$(".comm-select1 .select-button").text($(".comm-select1 .select-button").attr("title"));
						
						$('.comm-select').removeClass('open');
						$('.comm-select1').addClass('open');
						
						selectedItemSaleAmt();
					} else {
						getAddOption();
						 $("#addOptionList").attr("data-raw",ori_dataRaw);
						 $(".comm-select2 .select-button").text(secondOptionText);
					}
					
				});
				
				$('.comm-select3 .select-button').click(function(){
					if($("#addOptionList").css('display') == 'block') {
						$("#addOptionList").css('display', 'none');
					} else {
						if($("#addOptionList li").length > 0) {
							$("#addOptionList").css('display', 'block');
							$(".comm-select").removeClass('open');
							$(".opCal").removeClass('open');
							$(".comm-select3").addClass('open');
						}
					}
			    });
				
				$("#addOptionList").on('click', "li>a", function() {
					var dataRaw =  jQuery.parseJSON($("#addOptionList").attr("data-raw"));
					var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));
					
					dataRaw.addOptAmt = thisDataRaw.addOptAmt;
					dataRaw.addOptNm = thisDataRaw.addOptNm;
					dataRaw.addOptSn = thisDataRaw.addOptSn;
					
					var ori_dataRaw = JSON.stringify(dataRaw);
					
					var firstOptionText = $(".comm-select1 .select-button").text();
					var secondOptionText = $(".comm-select2 .select-button").text();
					var addOptionText = $(this).attr("title");
				
					if(checkDupOption(dataRaw)) {
						alert("<spring:message code='fail.product.duplication'/>");
						return ;
					}
					
					var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);
					 var text = '<li class="qty-list"><ol><li class="list1">' + firstOptionText + "<br/>" + fn_addDate(dataRaw.aplDt) +" "+ secondOptionText+ "<br/>" + addOptionText +'<span class="option-stockNum" style="display:none">' + commaNum(dataRaw.stockNum) + '</span></li>'
					 + '<li class="list2"><input type="text" value="1" class="qty-input"><button class="addition">+</button><button class="subtract">-</button></li>' 
					 +'<li class="list3"><span class="price">'+ commaNum(saleAmt)+'</span> <a href="javascript:;"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a></li>'
					 +'</ol></li>';
						 
					$("#selectedItemWrapper ul").append(text);
					
					$("#selectedItemWrapper ul>li").last().attr("data-raw",ori_dataRaw);
					
					$("#selectedItemWrapper").css('display', 'block');
					$('.comm-select .select-list-option').css('display', 'none');
				 	$("#secondOptionList").empty();
				 	$("#addOptionList").empty();
					$(".comm-select1 .select-button").text($(".comm-select1 .select-button").attr("title"));
					$(".comm-select2 .select-button").text($(".comm-select2 .select-button").attr("title"));
					$(".comm-select3 .select-button").text($(".comm-select3 .select-button").attr("title"));
					$(".opCal-title span").text('');
					$(".opCal .calendar").html('');
					$('.comm-select').removeClass('open');
					$('.comm-select1').addClass('open');
					
					selectedItemSaleAmt();	
					
				});
				
				$("#selectedItemWrapper").on("keyup", ".qty-input", function() {
					var  stockNum =fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",","");
					$(this).val($(this).val().replace(/[^0-9]/gi,""));
					if($(this).val() > stockNum) {
						$(this).val(stockNum);
					}
					selectedItemSaleAmt();
				});
				
				$("#selectedItemWrapper").on("click", ".addition", function() {
					var  stockNum =fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",","");
					var num = Number($(this).prev().val()) + 1;
					if(num <= stockNum) {
						$(this).prev().val(num);
						selectedItemSaleAmt();
					}
				});
				
				$("#selectedItemWrapper").on("click", ".subtract", function() {
					var num = Number($(this).parents(".qty-list").find(".qty-input").val()) - 1;
					if(num >= 1) {
						$(this).parents(".qty-list").find(".qty-input").val(num);
						selectedItemSaleAmt();
					}
				});
			} else if(divCd == "ad") {
				/***************************************************
				* 숙소
				****************************************************/
				
				
			} else if(divCd == "gl") {
				/***************************************************
				* 골프
				****************************************************/
			}
			
			
			//옵션 닫기
		    $('.option-close').click(function(){
		        close_popup($('.option-wrap'));
		        $('.option-wrap').html("");
		    });
			
			show_popup($('.option-wrap'));
		},
		error:fn_AjaxError
	});
}

/**
 * 합계내기
 */
function fn_TotalPrdtAmt(type) {
	
	var sub_price = 0;
	
	$("#" + type +" .money .right span").each(function () {
		sub_price = sub_price +  Number(fn_replaceAll($(this).text(), ",",""));
	});
	
	$("#" + type + " .title .price").text(commaNum(sub_price) + "원");
	
	var price = 0;
	$("#sliding_area .sub-list .money .right span").each(function () {
		price = price +  Number(fn_replaceAll($(this).text(), ",",""));
	});
	
	//$("#totalPrdtAmt").html(commaNum(price));
	
	// 총합계.
	$("#totalAmt").html(commaNum(price));
	
}

/**
 *  예약하기
 */
 function fn_Buy(){
	 if($("#totalAmt").text() == "0"){
		 alert("상품을 선택해 주세요.")
		return ;
	 }
	 var cart = [];
	 
	 $("#c_tourCpnList li").each(function() {
		 var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
		 cart.push({
				prdtNum 	: dataRaw.prdtNum,
				nmlAmt 		: 0,
				qty : dataRaw.qty,
				spOptSn : dataRaw.spOptSn,
				spDivSn :dataRaw.spDivSn,
				corpId : dataRaw.corpId,
				addOptAmt : dataRaw.addOptAmt,
				addOptNm : dataRaw.addOptNm
			 });
	 });
	 
	 $("#c_etcList li").each(function() {
		 var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
		 cart.push({
				prdtNum 	: dataRaw.prdtNum,
				qty : dataRaw.qty,
				spOptSn : dataRaw.spOptSn,
				spDivSn :dataRaw.spDivSn,
				corpId : dataRaw.corpId,
				addOptAmt : dataRaw.addOptAmt,
				addOptNm : dataRaw.addOptNm
			 });
	 });
	 
	
	 //숙소
	 $("#c_adList li").each(function(index){
		cart.push({
			prdtNum 	: $('input[name=adPE_prdtNum]').eq(index).val(),
			prdtNm 		: $('input[name=adPE_prdtNm]').eq(index).val(),
			corpId 		: $('input[name=adPE_corpId]').eq(index).val(),
			corpNm 		: $('input[name=adPE_corpNm]').eq(index).val(),
			prdtDivNm 	: "숙소",
			//fromDt 		: $('input[name=adPE_sFromDt]').eq(index).val(),
			startDt		: $('input[name=adPE_sFromDt]').eq(index).val(),
			night 		: $('input[name=adPE_iNight]').eq(index).val(),
			adultCnt 	: $('input[name=adPE_adCalMen1]').eq(index).val(),
			juniorCnt 	: $('input[name=adPE_adCalMen2]').eq(index).val(),
			childCnt 	: $('input[name=adPE_adCalMen3]').eq(index).val()
		 });
	});
	 
	 //골프
	 $("#c_golfList li").each(function(index){
		//alert($('input[name=adPE_sFromDt]').eq(index).val());
		cart.push({
			prdtNum 	: $('input[name=glPE_prdtNum]').eq(index).val(),
			prdtNm 		: $('input[name=glPE_corpNm]').eq(index).val(),
			corpId 		: $('input[name=glPE_corpId]').eq(index).val(),
			prdtDivNm 	: "골프",
			startDt		: $('input[name=glPE_sFromDt]').eq(index).val(),
			tm 			: $('input[name=glPE_tm]').eq(index).val(),
			memCnt 		: $('input[name=glPE_Rsv]').eq(index).val()
		 });
	});
	 
	
	//렌트카
	$("#c_rcList li").each(function(index){
		//alert($('input[name=adPE_sFromDt]').eq(index).val());
		cart.push({
			prdtNum 	: $('input[name=rcPE_prdtNum]').eq(index).val(),
			prdtNm 		: $('input[name=rcPE_prdtNm]').eq(index).val(),
			prdtDivNm 	: "렌터카",
			corpId 		: $('input[name=rcPE_corpId]').eq(index).val(),
			corpNm 		: $('input[name=rcPE_corpNm]').eq(index).val(),
			fromDt 		: $('input[name=rcPE_fromDt]').eq(index).val(),
			toDt 		: $('input[name=rcPE_toDt]').eq(index).val(),
			totalAmt 	: $('input[name=rcPE_totalAmt]').eq(index).val(),
			nmlAmt 		: $('input[name=rcPE_nmlAmt]').eq(index).val(),
			fromTm 		: $('input[name=rcPE_fromTm]').eq(index).val(),	// 대여시간
			toTm 		: $('input[name=rcPE_toTm]').eq(index).val(),	// 반납시간
			addAmt		: $('input[name=rcPE_addAmt]').eq(index).val(),
			insureDiv	: $('input[name=rcPE_insureDiv]').eq(index).val()
		 });
	});

	 
	fn_InstantBuy(cart);
}
/***************************************************
* 소셜 script
****************************************************/
//페이징.
function fn_SpSearch(pageIndex) {
	$("#spForm input[name=pageIndex]").val(pageIndex)
	var parameters = $("#spForm").serialize();
		$.ajax({
				type : "post",
				url : "<c:url value='/web/te/spProductList.ajax'/>",
				data : parameters,
				success : function(data) {
					$("#prdtList").html(data);
					
					/* var nav_totalObj;
					var nav_total = 0;
					$("input[name=sp_ctgr]").each(function () {
						$("#nav_" + $(this).attr("id")).text("(" + $(this).val() + ")");
						nav_total += Number($(this).val());
						nav_totalObj = $("#nav_" + $(this).attr("id")).closest(".list-button")..siblings(':first-child').find(".count");
					});
					nav_totalObj.text("("+ nav_total + ")"); */
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "\n" + "error:"+ error);
				}
			});
}

function spSearchForm(ctgr, type) {
	$("#spForm input[name=sTabCtgr]").val(ctgr);
	if(type == "c_tourCpn") {
		$(".packList-button a").removeClass('select');
		$("#c_tourCpn_" + ctgr).addClass('select');
	} else if(type == "c_etc") {
		$(".foodList-button a").removeClass('select');
		$("#c_etc_" + ctgr).addClass('select');
	}
	fn_SpSearch(1);
}
function getSecondOption(spDivSn) {
	$("#secondOptionList").empty();
	$.ajax({
		url: "<c:url value='/web/sp/getOptionList.ajax'/>",
		data: "prdtNum="+$("#prdtNum").val() +"&spDivSn="+spDivSn,
		success:function(data) {
			var list = data.list;
			var dataArr;
			var inx = 0, count =1;
			if(list != "" ) {
				$(list).each( function() {
					if(this.stockNum > 0 && this.ddlYn == 'N') {
						dataArr = '<li><a href="javascript:;" data-raw="" title="'+this.optNm +'"><p class="product"><span>[선택'+ count+']</span> '
											+'<span>'+ fn_addDate(this.aplDt)+ " " +  this.optNm + '</span> <span class="count"> | 잔여 : '+commaNum(this.stockNum) + '개</span></p>'
					                      	+ '<p class="price">' + commaNum(this.saleAmt) + '</p></a></li>';
					} else {
						dataArr = '<li><p class="product"><span>[선택'+ count+']</span> '
						+ fn_addDate(this.aplDt)+ " " +  this.optNm + '</span> <span class="count"> | 잔여 : '+commaNum(this.stockNum) + '개</span></p>'
                      	+ '<p class="price">품절</p></li>'
					}
					count++;
					$("#secondOptionList").append(dataArr);
					$("#secondOptionList li:eq("+inx+")>a").attr("data-raw",JSON.stringify(this) );
					inx++;
				});
				$('.comm-select .select-list-option').css('display', 'none');
				$("#secondOptionList").css('display', 'block');
				
				$('.comm-select').removeClass('open');
				$('.comm-select2').addClass('open');
				
			}
		},
		error : fn_AjaxError
	});
}

function checkDupOption(newData) {
	var result =false ;
	$("#selectedItemWrapper ul>li").each(function () {
		 var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
		if(newData.spDivSn == dataRaw.spDivSn && newData.spOptSn == dataRaw.spOptSn) {
			result = true;
			return ;
		}
	});
	return result;
}

function getAddOption() {
	if($("#addOptionList").css('display') == 'block') {
		$('.comm-select .select-list-option').css('display', 'none');
		return ;
	}
	
	if($("#addOptionList li").length > 0) {
		if($("#addOptionList").css('display') == 'none') {
			$('.comm-select .select-list-option').css('display', 'none');
			$('.packCalendar').css('display','none');
			$("#addOptionList").css('display', 'block')
		}
		$('.comm-select').removeClass('open');
		$('.opCal').removeClass('open');
		$('.comm-select3').addClass('open');
		return false;
	}
	var b_data = {
 			addOptNm : '',
 			addOptAmt : 0,
 			addOptSn : ''
 	};
	$.ajax({
		url: "<c:url value='/web/sp/getAddOptList.ajax'/>",
		data: "prdtNum=" + $("#prdtNum").val(),
		success:function(data) {
			var list = data.list;
			var dataArr ='<li><a href="javascript:;" data-raw="" title=""><p class="product"><span>선택안함</span></p></a></li>';
			$("#addOptionList").append(dataArr);
			var inx = 1;
			if(list != "" ) {
				$(list).each( function() {
					dataArr = '<li><a href="javascript:;" data-raw="" title="'+this.addOptNm +'"><p class="product">'
											+'<span>'+  this.addOptNm + '</span><p class="price">' + commaNum(this.addOptAmt) + '</p></p></a></li>';
					$("#addOptionList").append(dataArr);
					$("#addOptionList li:eq("+inx+")>a").attr("data-raw",JSON.stringify(this) );
					inx++;
				});
				$("#addOptionList li:eq(0)>a").attr("data-raw",JSON.stringify(b_data) );
				//$('.comm-select .select-list-option').css('display', 'none');
				//$('.comm-select3 .select-list-option').css('display', 'block');
			}
		},
		error : fn_AjaxError
	});
	$('.comm-select').removeClass('open');
	$('.opCal').removeClass('open');
	$('.comm-select3').addClass('open');
	$('.comm-select .select-list-option').css('display', 'none');
	$("#addOptionList").css('display', 'block');
}
/**
 * 총합계.
 */
function selectedItemSaleAmt() {
	var price = 0;
	
	$("#selectedItemWrapper .price").each(function(){
		price = price +  Number(fn_replaceAll($(this).text(), ",","")) * Number($(this).parents(".qty-list").find(".qty-input").val());
	});
	$("#totalProductAmt").html(commaNum(price));
}

/**
 * 선택완료 버튼 클릭시
 */
 function fn_addSp() {
	 var item = $("#selectedItemWrapper ul>li").length;
		if($("#selectedItemWrapper ul>li").length == 0 ) {
			alert("옵션을 선택해 주세요.")
			return ;
		}
		var obj = "c_tourCpn";
		if($("#ctgr").val().substring(0,2) == "C2") {
			obj = "c_tourCpn";
		} else if($("#ctgr").val().substring(0,2) == "C3") {
			obj = "c_etc";
		}
		var data;
		var teText = "";
		 $("#selectedItemWrapper ul>li").each( function() {
			 var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
			 data =  {
				prdtNum : $("#prdtNum").val(),
				qty :  $(this).find(".list2 .qty-input").val(),
				spOptSn : dataRaw.spOptSn,
				spDivSn :dataRaw.spDivSn,
				corpId : $("#corpId").val(),
				addOptAmt : dataRaw.addOptAmt,
				addOptNm : dataRaw.addOptNm
			 };
			 var saleAmt = 0;
			 if($("#addOptListLength").val() == 0) {
				 saleAmt = Number(dataRaw.saleAmt);
			 } else {
				saleAmt = Number(dataRaw.saleAmt) + Number(dataRaw.addOptAmt); 
			 }
			 teText ='<li data-raw="">' +
			 				'<h5 class="product"><span class="cProduct">' + $(this).find(".list1").html() + '</span><h5>' +
			 				'<p class="money"><span class="left">수량 : <span>' + $(this).find(".list2 .qty-input").val() +'</span>'+
			 										'<span class="right"><span>' + commaNum(saleAmt * Number($(this).find(".list2 .qty-input").val())) + '</span>원</p>' +
			 				'<a class="close"><img src="<c:url value="/images/web/icon/close7.png"/>" alt="삭제"></a>' + 
			 				'</li>';
			 
			 $("#" + obj + "List").append(teText);
				
			$("#" + obj + "List li").last().attr("data-raw", JSON.stringify(data));
		 });
		 
	close_popup($('.option-wrap'));
	$('.option-wrap').html("");
	
	fn_TotalPrdtAmt(obj);
}
/***************************************************
* 소셜 script_End
****************************************************/	


/***************************************************
* 숙소 script
****************************************************/

//페이징.
function fn_AdSearch(pageIndex) {
	
	//$("#adForm input[name=sNights]").val($("#adForm input[name=vNights]").val());
	$("#adForm").find("[name=sNights]").val( $("#adForm").find("[name=vNights]").val() );
	
	//$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
	$("#adForm").find("[name=sFromDt]").val( $("#adForm").find("[name=sFromDtView]").val().replace(/-/g, '') );
	
	//alert($("#adForm").find("[name=sNights]").val() + " : " +$("#adForm").find("[name=sFromDt]").val() );
	
	$("#adForm input[name=pageIndex]").val(pageIndex)
	var parameters = $("#adForm").serialize();
	
	//alert(parameters);
	$.ajax({
			type : "post",
			url : "<c:url value='/web/te/adProductList.ajax'/>",
			data : parameters,
			success : function(data) {
				$("#prdtList").html(data);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "\n" + "error:"+ error);
			}
		});
}

//유형 선택
function fn_AdChangeTab(ctge){
	
	$("#adForm input[name=sAdDivCdView]").val(ctge)

	$(".lodgeList-button a").removeClass('select');
	$("#adCate" + ctge).addClass('select');
	
	fn_AdSearch("1");
}

//선택완료 버튼
function fn_addAd() {
	
	if(    $("#adDtlInput").find('#adCalMen1').val() =="0"
		&& $("#adDtlInput").find('#adCalMen2').val() =="0"
		&& $("#adDtlInput").find('#adCalMen3').val() =="0"){
		$("#adDtlInput").find('#adCalMen1').focus();
		alert("투숙 인원을 설정해 주세요.");
		
		return;
	}
	
	var adCalMen1 = $("#adDtlInput").find('#adCalMen1').val();
	var adCalMen2 = $("#adDtlInput").find('#adCalMen2').val();
	var adCalMen3 = $("#adDtlInput").find('#adCalMen3').val();

	
	var parameters = "prdtNum="+$("#adDtlCalendar").children('#prdtNum').val();
	parameters += "&sFromDt="+$("#adDtlCalendar").children('#sFromDt').val();
	parameters += "&iNight="+$("#adDtlCalendar").children('#iNight').val();
	parameters += "&adCalMen1="+adCalMen1;
	parameters += "&adCalMen2="+adCalMen2;
	parameters += "&adCalMen3="+adCalMen3;
	

	$.ajax({
		//type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/ad/adDtlAddPrdt.ajax'/>",
		data:parameters ,
		success:function(data){
			//alert(data["Status"]);
			if(data["Status"] == 1){
				//alert("성공:"+ data["Price"]);
				
				var YYYYMMDD = $("#adDtlCalendar").children('#sFromDt').val();
				var Year	= YYYYMMDD.substring(2,4);
				var Month 	= YYYYMMDD.substring(4,6);
				var ToDay	= YYYYMMDD.substring(6,8);
				var strHtml = "";
				
				strHtml += '<li>';
				strHtml += '	<h5 class="product">['+$("#adDtlInput input[name=adAreaNm]").val()+'] <span class="cProduct">'+$("#adDtlInput input[name=adNm]").val()+'</span></h5>';
				strHtml += '	<p class="infoText">'+$("#adDtlCalendar").children('#prdtNm').val()+' ('+Year+'-'+Month+'-'+ToDay+'~ '+$("#adDtlCalendar").children('#iNight').val()+'박)</p>';
				strHtml += '	<p class="money">';
				strHtml += '	<span class="left">성인'+adCalMen1+'|소아'+ adCalMen2 + '|유아'+ adCalMen3 +'</span>';
				strHtml += '	<span class="right"><span>'+data["Price"].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'</span>원</span>'
				strHtml += '	</p>';
				strHtml += '	<a class="close"><img src="<c:url value="/images/web/icon/close7.png"/>" alt="삭제"></a>';
				strHtml +=		'<input type="hidden" name="adPE_prdtNum" value="'+$("#adDtlCalendar").children('#prdtNum').val()+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_prdtNm" value="'+$("#adDtlCalendar").children('#prdtNm').val()+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_sFromDt" value="'+$("#adDtlCalendar").children('#sFromDt').val()+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_iNight" value="'+$("#adDtlCalendar").children('#iNight').val()+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_adCalMen1" value="'+adCalMen1+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_adCalMen2" value="'+adCalMen2+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_adCalMen3" value="'+adCalMen3+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_Price" value="'+data["Price"]+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_corpNm" value="'+$("#adDtlInput input[name=adNm]").val()+'"/>';
				strHtml +=		'<input type="hidden" name="adPE_corpId" value="'+$("#adDtlInput input[name=corpId]").val()+'"/>';
				strHtml += '</li>';
				
				$("#c_adList").append(strHtml);
				
				close_popup($('.option-wrap'));
				$('.option-wrap').html("");
				fn_TotalPrdtAmt("c_ad");
				
			}else if(data["Status"] == 0){
				alert("투숙인원이 없습니다.");
				return;
			}else if(data["Status"] == -1){
				alert("투숙 최대 인원을 넘었습니다.");
				return;
			}else if(data["Status"] == -2){
				alert("투숙 날짜중에 마감/미정이 있습니다.");
				return;
			}else if(data["Status"] == -3){
				alert("없는 객실 입니다.");
				return;
			}else{
				alert("오류("+data["Status"]+")");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});

}

/***************************************************
* 숙소 script_end
****************************************************/


/***************************************************
* 골프 script
****************************************************/

//페이징.
function fn_GlSearch(pageIndex) {
	
	$("#glForm").find("[name=sNights]").val( $("#glForm").find("[name=vNights]").val() );
	$("#glForm").find("[name=sFromDt]").val( $("#glForm").find("[name=sFromDtView]").val().replace(/-/g, '') );
	
	//alert(document.glForm.vNights.value);
	//alert( $("#glForm").find("[name=sFromDt]").val() + ":" + $("#glForm").find("[name=sNights]").val() );

	$("#glForm input[name=pageIndex]").val(pageIndex)
	var parameters = $("#glForm").serialize();
	//alert(parameters);
	$.ajax({
			type : "post",
			url : "<c:url value='/web/te/glProductList.ajax'/>",
			data : parameters,
			success : function(data) {
				$("#prdtList").html(data);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "\n" + "error:"+ error);
			}
		});

}

//유형 선택
function fn_GlChangeTab(ctge){
	
	$("#glForm input[name=sGlAdarCdView]").val(ctge);
	
	//alert("")
	
	$(".golfList-button a").removeClass('select');
	$("#glCate" + ctge).addClass('select');
	
	fn_GlSearch("1");

}

//선택완료 버튼
function fn_addGl() {
	var parameters = "prdtNum="+$("#glDtlCalendar").children('#prdtNum').val();
	parameters += "&sFromDt="+$("#glDtlCalendar").children('#sFromDt').val();
	parameters += "&tm="+$("#glDtlInput").find('#hour').val();
	parameters += "&Rsv="+$("#glDtlInput").find('#personnel').val();
	
	$.ajax({
		//type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/gl/glDtlAddPrdt.ajax'/>",
		data:parameters ,
		success:function(data){
			//alert(data["Status"]);
			if(data["Status"] == 1){
				//alert("성공:"+ data["Price"]);

				var YYYYMMDD = data["sFromDt"];//$("#glDtlCalendar").children('#sFromDt').val();
				var tm = data["tm"];//$("#glDtlInput").find('#hour').val();
				var Rsv = data["Rsv"]
				var itm = parseInt(tm, 10);
				var Year	= YYYYMMDD.substring(2,4);
				var Month 	= YYYYMMDD.substring(4,6);
				var ToDay	= YYYYMMDD.substring(6,8);
				var strHtml = "";
				
				strHtml += '<li>';
				strHtml += '	<h5 class="product">['+$("#glDtlInput input[name=areaNm]").val()+'] <span class="cProduct">'+$("#glDtlInput input[name=prdtNm]").val()+'</span></h5>';
				strHtml += '	<p class="infoText">';
				strHtml += '		'+Year+'/'+Month+'/'+ToDay+' ~';
				if(itm<=12){
					strHtml += 		"오전 "+tm+":00 ";
				}else{
					strHtml += 		"오후 0"+(itm-12)+":00 ";
				}
				strHtml += '	</p>';
				strHtml += '	<p class="money">';
				strHtml += '	<span class="left"><span>'+Rsv+'인 1조</span></span>';
				strHtml += '	<span class="right"><span>'+data["Price"].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'</span>원</span>';
				strHtml += '	</p>';
				strHtml += '	<a class="close"><img src="<c:url value="/images/web/icon/close7.png"/>" alt="삭제"></a>';
				strHtml +=		'<input type="hidden" name="glPE_prdtNum" value="'+data["prdtNum"]+'"/>';
				strHtml +=		'<input type="hidden" name="glPE_sFromDt" value="'+YYYYMMDD+'"/>';
				strHtml +=		'<input type="hidden" name="glPE_tm" value="'+tm+'"/>';
				strHtml +=		'<input type="hidden" name="glPE_Rsv" value="'+Rsv+'"/>';
				strHtml +=		'<input type="hidden" name="glPE_Price" value="'+data["Price"]+'"/>';
				strHtml +=		'<input type="hidden" name="glPE_corpNm" value="'+$("#glDtlInput input[name=corpNm]").val()+'"/>';
				strHtml +=		'<input type="hidden" name="glPE_corpId" value="'+$("#glDtlInput input[name=corpId]").val()+'"/>';
				strHtml += '</li>';
				
				$("#c_golfList").append(strHtml);
				
				close_popup($('.option-wrap'));
				$('.option-wrap').html("");
				fn_TotalPrdtAmt("c_golf");

				
			}else if(data["Status"] == 0){
				alert("예약인원이 없습니다.");
			}else if(data["Status"] == -1){
				alert("예약인원을 넘었습니다.");
			}else if(data["Status"] == -2){
				alert("마감 되었습니다.");
			}else if(data["Status"] == -3){
				alert("없는 상품 입니다.");
			}else if(data["Status"] == -4){
				alert("최소인원 미달입니다.");
			}else if(data["Status"] == -5){
				alert("가격/수량이 미정으로 예약 할 수 없습니다.");
			}else{
				alert("오류("+data["Status"]+")");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});


}

/***************************************************
* 골프 script_end
****************************************************/



/***************************************************
* 랜트카 script
****************************************************/

//페이징.
function fn_RcSearch(pageIndex) {
	
	$("#rcForm").find("[name=sFromDt]").val( $("#rcForm").find("[name=sFromDtView]").val().replace(/-/g, '') );
	$("#rcForm").find("[name=sFromTm]").val( $("#rcForm").find("[name=vFromTm]").val() );
	
	$("#rcForm").find("[name=sToDt]").val( $("#rcForm").find("[name=sToDtView]").val().replace(/-/g, '') );
	$("#rcForm").find("[name=sToTm]").val( $("#rcForm").find("[name=vToTm]").val() );
	

	//alert( $("#rcForm").find("[name=sFromDt]").val() + ":" + $("#rcForm").find("[name=sFromTm]").val() +" ~ " 
	//	+  $("#rcForm").find("[name=sToDt]").val() + ":" + $("#rcForm").find("[name=sToTm]").val() );

	$("#rcForm input[name=pageIndex]").val(pageIndex)
	var parameters = $("#rcForm").serialize();
	//alert(parameters);
	$.ajax({
			type : "post",
			url : "<c:url value='/web/te/rcProductList.ajax'/>",
			data : parameters,
			success : function(data) {
				$("#prdtList").html(data);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "\n" + "error:"+ error);
			}
		});

}


//유형 선택
function fn_RcChangeTab(ctge){
	
	$("#rcForm input[name=sCarDivCd]").val(ctge);
	
	//alert("")
	
	$(".rcList-button a").removeClass('select');
	$("#rcCate" + ctge).addClass('select');
	
	fn_RcSearch("1");

}


function fn_OnchangeTime(){
	
	$("#rcForm").find("[name=sFromTm]").val($("#vFromTm :selected").val());
	$("#rcForm").find("[name=sToTm]").val($("#vToTm :selected").val());
	
	//$("#sFromTm").val($("#vFromTm :selected").val());
	//$("#sToTm").val($("#vToTm :selected").val());
	
	fn_CalRent();
}

/**
 * 대여기간 텍스트 변경
 */
function fn_ChangeRange(){
	$("#info_sDt").html($("#sFromDtView").val());
	$("#info_sTm").html($("#vFromTm :selected").text().substring(0,2) + "시");
	$("#info_eDt").html($("#sToDtView").val());
	$("#info_eTm").html($("#vToTm :selected").text().substring(0,2) + "시");
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
	var prdtNum = $("#rcForm").find("[name=prdtNum]").val();
	//var sFromDt = $("#rcForm").find("[name=sFromDt]").val();
	//var sFromDtView = $("#rcForm").find("[name=sFromDtView]").val();
	//var sFromTm = $("#rcForm").find("[name=sFromTm]").val();
	//var sToDt = $("#rcForm").find("[name=sToDt]").val();
	//var sToDtView = $("#rcForm").find("[name=sToDtView]").val();
	//var sToTm = $("#rcForm").find("[name=sToTm]").val();
	
	if(!checkByFromTo($('#sFromDtView').val(), $("#sToDtView").val(), "Y")){
		$("#errorMsg").html("대여일의 범위가 올바르지 않습니다.");
		$("#divAbleNone").show();
		$("#divAble").hide();
		$("#totalAmt").val('0');
		$("#vTotalAmt").html('0');
		return;
	}
	
	var parameters = "sPrdtNum=" + prdtNum;
	parameters += "&sFromDt=" + $("#sFromDt").val();
	parameters += "&sFromTm=" + $("#sFromTm").val();
	parameters += "&sToDt=" + $("#sToDt").val();
	parameters += "&sToTm=" + $("#sToTm").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/rentcar/calRent.ajax'/>",
		data:parameters ,
		success:function(data){
			fn_ChangeRange();
			// alert(data.prdtInfo.ableYn);
			$(".info1 .comm-color1").html(data.prdtInfo.rsvTm + "시간");
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

//선택완료 버튼
function fn_addRc() {
	
	var prdtNum = $("#rcForm").find("[name=prdtNum]").val();
	var sFromDt = $("#sFromDt").val();//$("#rcForm").find("[name=sFromDt]").val();
	var sFromDtView = $("#sFromDtView").val();//$("#rcForm").find("[name=sFromDtView]").val();
	var sFromTm = $("#sFromTm").val();//$("#rcForm").find("[name=sFromTm]").val();
	var sToDt = $("#sToDt").val();//$("#rcForm").find("[name=sToDt]").val();
	var sToDtView = $("#sToDtView").val();//$("#rcForm").find("[name=sToDtView]").val();
	var sToTm = $("#sToTm").val();//$("#rcForm").find("[name=sToTm]").val();
	
	
	var strHtml = "";
	
	strHtml += '<li>';
	strHtml += '	<h5 class="product"><span class="cProduct">탐나오렌트카 K5</span></h5>';
	strHtml += '	<p class="infoText">'+sFromDtView+' '+sFromTm.substring(0,2)+':00 ~ '+sToDtView+' '+sToTm.substring(0,2)+':00</p>';
	strHtml += '	<p class="money">';
	//strHtml += '		<span class="left">수량 : <span>1</span></span>';
	strHtml += '		<span class="right"><span>'+commaNum($("#totalAmt").val())+'</span>원</span>';
	strHtml += '	</p>';
	strHtml += '	<a class="close"><img src="<c:url value="/images/web/icon/close7.png"/>" alt="삭제"></a>';
	strHtml +=		'<input type="hidden" name="rcPE_prdtNum" value="'+$("#rco_prdtNum").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_prdtNm" value="'+$("#rco_prdtNm").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_corpId" value="'+$("#rco_corpId").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_corpNm" value="'+$("#rco_corpNm").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_fromDt" value="'+$("#sFromDt").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_toDt" value="'+$("#sToDt").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_totalAmt" value="'+$("#totalAmt").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_nmlAmt" value="'+$("#nmlAmt").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_fromTm" value="'+$("#sFromTm").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_toTm" value="'+$("#sToTm").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_addAmt" value="'+$("#insuSaleAmt").val()+'"/>';
	strHtml +=		'<input type="hidden" name="rcPE_insureDiv" value="'+$("#payOption :selected").val()+'"/>';
	strHtml += '</li>';

	$("#c_rcList").append(strHtml);
	
	close_popup($('.option-wrap'));
	$('.option-wrap').html("");
	fn_TotalPrdtAmt("c_rc");
	
}


/***************************************************
* 랜터카 script_end
****************************************************/

$(document).ready(function(){
	
	//fn_goTab('c_rc'); // 여행경비산출 버튼 클릭시 처음 로딩. 임시.
	fn_goTab('c_ad'); 
	
	$(".travel-list").on("click", ".close", function () {
		var type = $(this).closest(".sub-list").parent().prop("id");
		
		$(this).closest("li").remove();
		fn_TotalPrdtAmt(type);
	});
	
	

	//$("#sFromDtView").datepicker({		
	$("#adForm").find("[name=sFromDtView]").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: '+12m',
		onClose : function(selectedDate) {
			//$("#sToDtView").datepicker("option", "minDate", selectedDate);
		}
	});
	
	$("#glForm").find("[name=sFromDtView]").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: '+3m',
		onClose : function(selectedDate) {
			//$("#sToDtView").datepicker("option", "minDate", selectedDate);
		}
	});
	
	
	$("#rcForm").find("[name=sFromDtView]").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "${AFTER_DAY}",
		//maxDate: '+3m',
		onClose : function(selectedDate) {
			$("#rcForm").find("[name=sToDtView]").datepicker("option", "minDate", selectedDate);
		}
	});
	
	$("#rcForm").find("[name=sToDtView]").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "${AFTER_DAY}",
		onClose : function(selectedDate) {
			$("#rcForm").find("[name=sFromDtView]").datepicker("option", "maxDate", selectedDate);
		}
	});
	
});
</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>

	<main id="main">
	    <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>여행경비산출</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
		
		<div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="travelExpenses-wrap">
                    <div class="travel-head">
                        <div class="title-info">
                            <div class="Fasten">
                                <article class="text-wrap">
                                    <h2 class="title">여행경비산출</h2>
                                    <p class="sub-text">내가 원하는 제주여행을 예상비용은 간편하게 산출할 수 있습니다.</p>
                                </article>
                            </div>
                        </div>
                        <div class="travel-search">
                            <div class="Fasten">
                            	<table class="search-form avForm hide">
                                    <tr>
                                        <th class="title-wrap">항공검색 &gt;</th>
                                        <td class="int-wrap air-wrap">
                                            <span class="list-button">
                                                <a class="select" href="">왕복</a>
                                                <a href="">편도</a>
                                            </span>
                                            <span class="list-title">출발</span>
                                            <span class="list-select">
                                                <select id="start_region">
                                                    <option value="">김포</option>
                                                </select>
                                                <input class="datepicker" type="text">
                                            </span>
                                            <span class="list-title">도착</span>
                                            <span class="list-select">
                                                <select id="end_region">
                                                    <option value="">김포</option>
                                                </select>
                                                <input class="datepicker" type="text">
                                            </span>
                                            <span class="list-title">인원</span>
                                            <span class="list-select personnel">
                                                <select>
                                                    <option value="">성인1인</option>
                                                </select>
                                                <select>
                                                    <option value="">소아1인</option>
                                                </select>
                                                <select>
                                                    <option value="">유아1인</option>
                                                </select>
                                            </span>
                                            <span><a class="searchBT" href="">검색</a></span>
                                        </td>
                                    </tr>
                                </table>
                            	
                            	<form  name="adForm" id="adForm" method="get">
                            		<input type="hidden" name="pageIndex" id="pageIndex" value="0" />
                            		<input type="hidden" name="sAdDivCdView" id="sAdDivCdView" value="" />
									<input type="hidden" name="orderCd" value="${Constant.ORDER_SALE}}" />
									<input type="hidden" name="orderAsc" value="" />
									<input type="hidden" name="sLON" />
									<input type="hidden" name="sLAT" />
									<input type="hidden" name="prdtNum"  />
									<input type="hidden" name="sPrdtNum"  />
									<input type="hidden" name="sAdDiv"  value="" />
									<input type="hidden" name="sAdAdar"  value="" />
									<input type="hidden" name="sPriceSe"  value="" />
									<input type="hidden" name="sPrdtNm" value="" />
									<input type="hidden" name="sMen" id="sMen" value="">
										
									<table class="search-form adForm hide">
									     <tr>
									         <th class="title-wrap">숙박검색 &gt;</th>
									         <td class="int-wrap">
									             <span class="list-title">유형</span>
									             <span class="list-button lodgeList-button">
									                 <a id="adCate" class="select" href="javascript:fn_AdChangeTab('');">전체</a>
									                 <a id="adCateHO" href="javascript:fn_AdChangeTab('HO');">호텔</a>
									                 <a id="adCatePE" href="javascript:fn_AdChangeTab('PE');">펜션</a>
									                 <a id="adCateCO" href="javascript:fn_AdChangeTab('CO');">콘도/리조트</a>
									                 <!-- <a id="adCateFU" href="javascript:fn_AdChangeTab('FU');">풀빌라</a> -->
									                 <a id="adCateGE" href="javascript:fn_AdChangeTab('GE');">게스트하우스</a>
									                 <!-- <a id="adCateCA" href="javascript:fn_AdChangeTab('CA');">캠핑/카라반</a> -->
									             </span>
									             <span class="list-title">입실일자</span>
									             <span class="list-select">
									                <input class="datepicker" type="text" name="sFromDtView" value="${SVR_TODAY}" readonly="readonly">
                                                 	<input type="hidden" name="sFromDt" value="">									                 
									                 
									                <input type="hidden" name="sNights" value="${searchVO.sNights}">
									                <select name="vNights" class="lodge_time_st">
									                	<option value="1" <c:if test="${searchVO.sNights=='1' ||  empty searchVO.sNights}">selected="selected"</c:if> >1박</option>
                                                 		<option value="2" <c:if test="${searchVO.sNights=='2'}">selected="selected"</c:if>>2박</option>
                                                    	<option value="3" <c:if test="${searchVO.sNights=='3'}">selected="selected"</c:if>>3박</option>
                                                    	<option value="4" <c:if test="${searchVO.sNights=='4'}">selected="selected"</c:if>>4박</option>
                                                    	<option value="5" <c:if test="${searchVO.sNights=='5'}">selected="selected"</c:if>>5박</option>
									             	</select>
									             </span>                                            
									             <span><a class="searchBT" href="javascript:fn_AdSearch(1)">검색</a></span>
									         </td>
									     </tr>
									</table>
	                            </form>
                               <form  name="rcForm" id="rcForm" method="get">
                               		<input type="hidden" name="pageIndex" value="1" />
									<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
									<input type="hidden" name="orderCd"  value="" />
									<input type="hidden" name="orderAsc" value="" />
									<input type="hidden" name="prdtNum" />
									<input type="hidden" name="sCarDivCd" value="" />
									
	                               	<table class="search-form rcForm hide">
	                                    <tr>
	                                        <th class="title-wrap">렌터카검색 &gt;</th>
	                                        <td class="int-wrap">
	                                            <span class="list-title">유형</span>
	                                            <span class="list-button rcList-button">
	                                                <a id="rcCate" class="select" href="javascript:fn_RcChangeTab('');">전체</a>
	                                                <a id="rcCateCAR1" href="javascript:fn_RcChangeTab('CAR1');">중소형</a>
	                                                <a id="rcCateCAR2" href="javascript:fn_RcChangeTab('CAR2');">고급</a>
	                                                <a id="rcCateCAR3" href="javascript:fn_RcChangeTab('CAR3');">SUV/승합</a>
	                                                <a id="rcCateCAR4" href="javascript:fn_RcChangeTab('CAR4');">수입/오픈/스포츠</a>
	                                            </span>
	                                            <span class="list-title">대여일자</span>
	                                            <span class="list-select">
	                                            	<input class="datepicker" type="text" name="sFromDtView" value="${SVR_NEXTDAY}" readonly="readonly">
                                                	<input type="hidden" name="sFromDt" value="">
                                                	<input type="hidden" name="sFromTm" value="">

	                                                <select name="vFromTm">
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

	                                            </span>
	                                            <span class="list-select">
	                                            	<input class="datepicker" type="text" name="sToDtView" value="${SVR_NEXTNEXTDAY}" readonly="readonly">
	                                                <input type="hidden" name="sToDt" value="">
	                                                <input type="hidden" name="sToTm" value="">
	                                                <select name="vToTm">
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
	                                            </span>
	                                            <span><a class="searchBT" href="javascript:fn_RcSearch(1)">검색</a></span>
	                                        </td>
	                                    </tr>
	                                </table>
	                            </form>
                                
                                <form  name="glForm" id="glForm" method="get">
                                	<input type="hidden" name="pageIndex" value="0" />
									<input type="hidden" name="sGlAdarCdView" id="sGlAdarCdView" value="" />
									<input type="hidden" name="orderCd" value="${Constant.ORDER_SALE}" />
									<input type="hidden" name="orderAsc" value="" />
									<input type="hidden" name="sLON" />
									<input type="hidden" name="sLAT" />
									<input type="hidden" name="prdtNum" />
									<input type="hidden" name="sPrdtNum" />
									<input type="hidden" name="sGlAdar" value="" />
                                
	                                 <table class="search-form golfForm hide">
	                                    <tr>
	                                        <th class="title-wrap">골프검색 &gt;</th>
	                                        <td class="int-wrap">
	                                            <span class="list-title">유형</span>
	                                            <span class="list-button golfList-button">
	                                                <a id="glCate" class="select" href="javascript:fn_GlChangeTab('');">전체</a>
	                                                <a id="glCateJE" href="javascript:fn_GlChangeTab('JE');">제주시</a>
	                                                <a id="glCateEA" href="javascript:fn_GlChangeTab('EA');">동부권</a>
	                                                <a id="glCateWE" href="javascript:fn_GlChangeTab('WE');">서부권</a>
	                                                <a id="glCateSE" href="javascript:fn_GlChangeTab('SE');">중문/서귀포</a>
	                                            </span>
	                                            <span class="list-title">라운딩 일자</span>
	                                            <span class="list-select">
	                                                <input class="datepicker" type="text" name="sFromDtView"  value="${SVR_NEXTDAY}" readonly="readonly">
                                                 	<input type="hidden" name="sFromDt" id="sFromDt" value="">
	                                                
	                                                
	                                                <input type="hidden" name="sNights"  value="${searchVO.sNights}">
									                <select name="vNights" class="lodge_time_st">
									                	<option value="3" <c:if test="${searchVO.sNights=='3' ||  empty searchVO.sNights}">selected="selected"</c:if> >3일</option>
                                                    	<option value="5" <c:if test="${searchVO.sNights=='5'}">selected="selected"</c:if>>5일</option>
                                                    	<option value="7" <c:if test="${searchVO.sNights=='7'}">selected="selected"</c:if>>7일</option>
									             	</select>

	                                            </span>
	                                            <span><a class="searchBT" href="javascript:fn_GlSearch(1)">검색</a></span>
	                                        </td>
	                                    </tr>
	                                </table>
	                           </form>
	                           
                                	<form  name="spForm" id="spForm" method="get">
									<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}" />
									<input type="hidden" name="sCtgr" />
									<input type="hidden" name="sTabCtgr" />
									</form>
                                <table class="search-form tourCpnForm hide">
                                    <tr>
                                        <th class="title-wrap">관광지/레저 &gt;</th>
                                        <td class="int-wrap">
                                            <span class="list-button packList-button">
                                                <a id="c_tourCpn_" class="select" href="javascript:spSearchForm('', 'c_tourCpn');">전체상품 <span class="count" id="nav_sp_total"></span></a>
                                                <a id="c_tourCpn_C210" href="javascript:spSearchForm('C210', 'c_tourCpn');">전시/박물관 <span class="count" id="nav_C210"></span></a>
                                                <a id="c_tourCpn_C220" href="javascript:spSearchForm('C220', 'c_tourCpn');">테마공원 <span class="count" id="nav_C220"></span></a>
                                                <a id="c_tourCpn_C250" href="javascript:spSearchForm('C250', 'c_tourCpn');">스포츠/레저 <span class="count" id="nav_C250"></span></a>
                                                <a id="c_tourCpn_C260" href="javascript:spSearchForm('C260', 'c_tourCpn');">해양관광 <span class="count" id="nav_C260"></span></a>
                                                <a id="c_tourCpn_C230" href="javascript:spSearchForm('C230', 'c_tourCpn');">공연/쇼 <span class="count" id="nav_C230"></span></a>
                                                <a id="c_tourCpn_C240" href="javascript:spSearchForm('C240', 'c_tourCpn');">기타 <span class="count" id="nav_C240"></span></a>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                                
                               <table class="search-form etcForm hide">
                                    <tr>
                                        <th class="title-wrap">음식/뷰티 &gt;</th>
                                        <td class="int-wrap">
                                            <span class="list-button foodList-button">
                                                <a id="c_etc_" class="select" href="javascript:spSearchForm('', 'c_etc');">전체상품 <span class="count"></span></a>
                                                <a id="c_etc_C310" href="javascript:spSearchForm('C310', 'c_etc');">음식 <span class="count" id="nav_C310"></span></a>
                                                <a id="c_etc_C360" href="javascript:spSearchForm('C360', 'c_etc');">카페 <span class="count" id="nav_C360"></span></a>
                                                <a id="c_etc_C350" href="javascript:spSearchForm('C350', 'c_etc');">뷰티 <span class="count" id="nav_C350"></span></a>
                                                <a id="c_etc_C370" href="javascript:spSearchForm('C370', 'c_etc');">기타 <span class="count" id="nav_C370"></span></a>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                               
                            </div>
                        </div>
                    </div> <!-- //travel-head -->
		
					<div class="Fasten">
                        <div class="travel-contents">
                            <div class="l-area">
                            	<div id="prdtList"></div>
                                
							</div> <!-- //l-area -->
                            <div id="sliding_area" class="r-area">
                                <ul class="travel-list">
                                	<!-- 
                                    <li id="c_av">
                                        <a class="title" href="javascript:fn_goTab('c_av');">항공 <span class="price">0원</span></a>
                                        <div class="sub-list">
                                            <ul id="c_avList">
                                            </ul>
                                        </div>                                        
                                    </li>
                                     -->
                                    <li id="c_ad">
                                        <a class="title" href="javascript:fn_goTab('c_ad');">숙박 <span class="price">0원</span></a>
                                        <div class="sub-list">
                                            <ul id="c_adList">
                                            </ul>
                                        </div>   
                                    </li>
                                    <li id="c_rc">
                                        <a class="title" href="javascript:fn_goTab('c_rc');">렌터카 <span class="price">0원</span></a>        
                                        <div class="sub-list">
                                            <ul id="c_rcList">
                                            </ul>
                                        </div>                                   
                                    </li>
                                    <!-- <li id="c_golf">
                                        <a class="title" href="javascript:fn_goTab('c_golf');">골프 <span class="price">0원</span></a>
                                        <div class="sub-list">
                                            <ul id="c_golfList">
                                            </ul>
                                        </div>                                     
                                    </li> -->
                                    <li id="c_tourCpn">
                                        <a class="title" href="javascript:fn_goTab('c_tourCpn');">관광지/레저 <span class="price">0원</span></a>
                                        <div class="sub-list">
                                            <ul id="c_tourCpnList">
                                            </ul>
                                        </div>
                                    </li>
                                    <li id="c_etc">
                                        <a class="title" href="javascript:fn_goTab('c_etc');">음식/뷰티 <span class="price">0원</span></a>
                                        <div class="sub-list">
                                            <ul id="c_etcList">
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                                <div class="travel-pay">
                                    <h3 class="wrap-title">총 여행경비</h3>
                                    <!-- <ul class="pay-list">
                                        <li>
                                            <p class="pay-title">총상품가</p>
                                            <p class="pay-price"><span id="totalPrdtAmt">0</span>원</p>
                                        </li>
                                        <li>
                                            <p class="pay-title">할인캐쉬 <a href="" class="bt">캐쉬함</a></p>
                                            <p class="pay-price"><span>0</span>원</p>
                                        </li>
                                    </ul> -->
                                    <div class="pay-info">
                                        <p class="pay-total"><span class="price" id="totalAmt">0</span><span class="won">원</span></p>
                                    </div>
                                    <p class="pay-button"><a href="javascript:fn_Buy();"><img src="<c:url value='/images/web/icon/check2.png'/>" alt="check"> 예약하기</a></p>
                                </div> <!-- //travel-pay -->
                            </div> <!-- //r-area -->
                        </div>                        
                    </div>
					<div class="option-wrap"></div> <!-- //option-wrap -->  
                   </div> <!-- //travel-expenses-wrap -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>

	</form>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>
                  						