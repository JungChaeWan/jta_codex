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
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.min.js'/>"></script>

<validator:javascript formName="SP_OPTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

//상품 리스트
function fn_socialProductList() {
	location.href="<c:url value='/mas/sp/productList.do' />?pageIndex=${searchVO.pageIndex}";
}

function fn_InsertSpDivInf(){
	// validation 체크
	var prdtDivNm = $("#SP_DIVINFVO input[name=prdtDivNm]").val();
	var viewSn =  $("#SP_DIVINFVO select[name=viewSn] option:selected").val();

	if(prdtDivNm == "") {
		alert("<spring:message code='common.required.msg' arguments='상품구분명'/>");
		return ;
	}
	//if(strLengthCheck(prdtDivNm) > 60) {
	if(prdtDivNm.length > 60) {
		alert("<spring:message code='common.maxlength.msg' arguments="상품구분명,60"/>");
		return ;
	}
	if(viewSn == 0) {
		alert("<spring:message code='common.required.msg' arguments='노출순번'/>");
		return ;
	}
	var tempSpDivSn = $("#SP_DIVINFVO").find("[name=spDivSn]").val();

	document.SP_DIVINFVO.pageIndex.value=$('input[name=pageIndex]').val();
	if(tempSpDivSn == "") {
		document.SP_DIVINFVO.action = "<c:url value='/mas/sp/insertSocialDivInf.do' />";
	} else {
		document.SP_DIVINFVO.action = "<c:url value='/mas/sp/updateSocialDivInf.do' />";
	}
	document.SP_DIVINFVO.submit();
}

function fn_clearSpDivinf() {
	$("#SP_DIVINFVO").find("[name=viewSn] option").remove();
	$("#SP_DIVINFVO input:not([name=prdtNum])").val("");
}

function fn_clearSpOptinf() {
	$("#SP_OPTINFVO").find("[name=viewSn] option").remove();
	$("#SP_OPTINFVO input:not([name=prdtNum])").val("");
	$("#span_divOpt_divNm").html('');
}

function fn_viewSpDivinf() {
	fn_clearSpDivinf();

	$.ajax({
		dataType:"json",
		url : "<c:url value='/mas/sp/getDivMaxViewSn.ajax' />",
		data : "prdtNum=${SP_OPTINFVO.prdtNum}",
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			var dataArr = [];
			for(var i = 1; i <= maxViewSn + 1; i++) {
				if( i == (maxViewSn + 1) )
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				else
					dataArr[i] = "<option value='"+ i +"'>";
				dataArr[i] +=  i + "</option>";
			}
			$("#SP_DIVINFVO").find("[name=viewSn]").append(dataArr);
			show_popup($("#div_spDivInf"));
		},
		error :fn_AjaxError
	});
}

function fn_viewSpOptInf(spDivSn, prdtDivNm) {
	fn_clearSpOptinf();

	$.ajax({
		dataType: "json",
		url : "<c:url value='/mas/sp/getOptMaxViewSn.ajax' />",
		data : "prdtNum=${SP_OPTINFVO.prdtNum}&spDivSn=" + spDivSn,
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			var dataArr = [];

			for(var i = 1; i <= maxViewSn + 1; i++) {
				if(i == (maxViewSn + 1)) {
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				} else {
					dataArr[i] = "<option value='"+ i +"'>";
				}
				dataArr[i] +=  i + "</option>";
			}
			$("#span_divOpt_divNm").html(prdtDivNm);
			$("#SP_OPTINFVO").find("[name=viewSn]").append(dataArr);
			$("#SP_OPTINFVO").find("[name=spDivSn]").val(spDivSn);

			show_popup($("#div_spOptInf"));
			// 금액 소숫점 추가
		    $('.numFormat').each(function() {
		    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		    });
		},
		error : fn_AjaxError
	})
}

function fn_InsertSpOptInf(){
	// 콤마 제거
	delCommaFormat();
	// validation 체크
	if(!validateSP_OPTINFVO(document.SP_OPTINFVO)){
		return;
	}
	if(${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}) {
		if($("#aplDt").val() == "") {
			alert("<spring:message code='common.required.msg' arguments='적용일자'/>");
			return ;
		}
		$("#aplDt").val($('#aplDt').val().replace(/-/g, ""));

		if(!CheckDate($("#aplDt").val())) {
			alert("<spring:message code='common.wrong.msg' arguments='적용일자'/>");
			return ;
		}
	}
	if(parseInt($("#saleAmt").val()) > parseInt($("#nmlAmt").val())) {
		alert("<spring:message code='errors.price.compare' arguments='판매금액, 정상금액'/>");
		return ;
	}
	if(parseInt($("#nmlAmt").val()) <= 0) {
		alert("정상가는 0보다 커야 합니다.");
		$("#nmlAmt").focus();
		return ;
	}
	if(parseInt($("#saleAmt").val()) <= 0) {
		alert("판매가는 0보다 커야 합니다.");
		$("#saleAmt").focus();
		return ;
	}
	if(parseInt($("#optPrdtNum").val()) <= 0) {
		alert("상품수는 0보다 커야 합니다.");
		$("#optPrdtNum").focus();
		return ;
	}
	
	document.SP_OPTINFVO.pageIndex.value=$('input[name=pageIndex]').val();
	var tempSpOptSn = $("#SP_OPTINFVO").find("[name=spOptSn]").val();

	if(tempSpOptSn == "") {
		document.SP_OPTINFVO.action = "<c:url value='/mas/sp/insertSocialOption.do' />";
	} else {
		document.SP_OPTINFVO.action = "<c:url value='/mas/sp/updateSocialOptInf.do' />";
	}
	document.SP_OPTINFVO.submit();
}

function fn_viewUpdateSpDivinf(spDivSn) {
	fn_clearSpDivinf();

	$.ajax({
		url : "<c:url value='/mas/sp/viewUpdateSpDivinf.ajax' />",
		data : "prdtNum=${SP_OPTINFVO.prdtNum}&spDivSn=" + spDivSn,
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			$("#SP_DIVINFVO").find("[name=prdtDivNm]").val(data.spDivInfVO.prdtDivNm);
			$("#SP_DIVINFVO").find("[name=spDivSn]").val(data.spDivInfVO.spDivSn);
			var dataArr = [];

			for(var i = 1; i <= maxViewSn; i++) {
				if( i == data.spDivInfVO.viewSn) {
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				} else {
					dataArr[i] = "<option value='"+ i +"'>";
				}
				dataArr[i] +=  i + "</option>";
			}
			$("#SP_DIVINFVO").find("[name=viewSn]").append(dataArr);

			show_popup($("#div_spDivInf"));
		},
		error :fn_AjaxError
	})
}

function fn_viewUpdateSpOptInf(spDivSn, spOptSn, prdtDivNm) {
	fn_clearSpOptinf();

	$.ajax({
		url : "<c:url value='/mas/sp/viewUpdateSpOptinf.ajax' />",
		data : "prdtNum=${SP_OPTINFVO.prdtNum}&spDivSn=" + spDivSn + "&spOptSn=" + spOptSn,
		dataType:"json",
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			$("#SP_OPTINFVO").find("[name=spDivSn]").val(data.spOptInfVO.spDivSn);
			$("#SP_OPTINFVO").find("[name=spOptSn]").val(data.spOptInfVO.spOptSn);
			$("#SP_OPTINFVO").find("[name=optNm]").val(data.spOptInfVO.optNm);
			$("#SP_OPTINFVO").find("[name=nmlAmt]").val(data.spOptInfVO.nmlAmt);
			$("#SP_OPTINFVO").find("[name=saleAmt]").val(data.spOptInfVO.saleAmt);
			$("#SP_OPTINFVO").find("[name=optPrdtNum]").val(data.spOptInfVO.optPrdtNum);
			$("#SP_OPTINFVO").find("[name=aplDt]").val(fn_addDate(data.spOptInfVO.aplDt));
			$("#SP_OPTINFVO").find("[name=printYn]").val(data.spOptInfVO.printYn);
			$("#SP_OPTINFVO").find("[name=lsLinkOptNum]").val(data.spOptInfVO.lsLinkOptNum);

			if(${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD}) {
				$("#SP_OPTINFVO").find("[name=ddlYn]").val(data.spOptInfVO.ddlYn);
			}
			$("#SP_OPTINFVO").find("[name=printYn]").val(data.spOptInfVO.printYn);
			$("#span_divOpt_divNm").html(prdtDivNm);

			var dataArr = [];

			for(var i = 1; i <= maxViewSn; i++) {
				if( i == data.spOptInfVO.viewSn) {
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				} else {
					dataArr[i] = "<option value='"+ i +"'>";
				}
				dataArr[i] +=  i + "</option>";
			}
			$("#SP_OPTINFVO").find("[name=viewSn]").append(dataArr);
			// 예상정산액 산출
			$('#saleAmt').change();

			show_popup($("#div_spOptInf"));
		},
		error : fn_AjaxError
	})
}
function fn_DelSpDivinf(spDivSn) {
	$.ajax({
		url : "<c:url value='/mas/sp/checkSpRsv.ajax' />",
		data : "prdtNum=${SP_OPTINFVO.prdtNum}&spDivSn=" + spDivSn,
		dataType:"json",
		success: function(data) {
			if(data.chkVal == "Y") {
				if(confirm("<spring:message code='common.delete.msg'/>")) {
					$("#SP_DIVINFVO input[name=spDivSn]").val(spDivSn);
					$("#SP_DIVINFVO input[name=pageIndex]").val($('input[name=pageIndex]').val());
					document.SP_DIVINFVO.action = "<c:url value='/mas/sp/deleteSocialDivInf.do' />";
					document.SP_DIVINFVO.submit();
				}
			} else {
				alert("예약건이 존재하여 삭제가 불가능합니다.");
				return false;
			}
		},
		error : fn_AjaxError
	});
}

function fn_DelSpOptinf(spDivSn, spOptSn) {
	$.ajax({
		url : "<c:url value='/mas/sp/checkSpRsv.ajax' />",
		data : "prdtNum=${SP_OPTINFVO.prdtNum}&spDivSn=" + spDivSn + "&spOptSn=" + spOptSn,
		dataType:"json",
		success: function(data) {
			if(data.chkVal == "Y"){
				if(confirm("<spring:message code='common.delete.msg'/>")){
					$("#SP_OPTINFVO input[name=spDivSn]").val(spDivSn);
					$("#SP_OPTINFVO input[name=spOptSn]").val(spOptSn);
					$("#SP_OPTINFVO input[name=pageIndex]").val($('input[name=pageIndex]').val());
					document.SP_OPTINFVO.action = "<c:url value='/mas/sp/deleteSocialOptInf.do' />";
					document.SP_OPTINFVO.submit();
				}
			}else{
				alert("예약건이 존재하여 삭제가 불가능합니다.");
				return false;
			}
		},
		error : fn_AjaxError
	});


}

// 옵션 일괄등록
function fn_viewSpBatchOpt() {
	<c:if test="${fn:length(resultList) == 0}">
		alert("구분자를 등록해 주세요.");
		return ;
	</c:if>
	show_popup($("#div_spBatchOptInf"));
}

function fn_InsertBatchSpOptInf() {
	// 콤마 제거
	delCommaFormat();
	// validation 체크
	if(!validateSP_OPTINFVO(document.SP_BatchOpt)){
		return;
	}
	if($("#startAplDt").val() == "") {
		alert("<spring:message code='common.required.msg' arguments='적용일자'/>");
		return ;
	}
	$("#startAplDt").val($('#startAplDt').val().replace(/-/g, ""));

	if(!CheckDate($("#startAplDt").val())) {
		alert("<spring:message code='common.wrong.msg' arguments='적용일자'/>");
		return ;
	}
	if(parseInt($("#batchSaleAmt").val()) > parseInt($("#batchNmlAmt").val())) {
		alert("<spring:message code='errors.price.compare' arguments='판매금액, 정상금액'/>");
		return ;
	}
	if(parseInt($("#batchNmlAmt").val()) <= 0) {
		alert("정상가는 0보다 커야 합니다.");
		$("#batchNmlAmt").focus();
		return ;
	}
	if(parseInt($("#batchSaleAmt").val()) <= 0) {
		alert("판매가는 0보다 커야 합니다.");
		$("#batchSaleAmt").focus();
		return ;
	}
	if(parseInt($("#batchOptPrdtNum").val()) <= 0) {
		alert("상품수는 0보다 커야 합니다.");
		$("#batchOptPrdtNum").focus();
		return ;
	}
	document.SP_BatchOpt.pageIndex.value=$('input[name=pageIndex]').val();
	document.SP_BatchOpt.action = "<c:url value='/mas/sp/insertBatchSpOption.do' />";
	document.SP_BatchOpt.submit();
}

//옵션 일괄수정
function fn_viewUpdateSpBatchOpt() {
	if("${fn:length(resultList)}" == "0") {
		alert("구분자를 등록해 주세요.");
		return ;
	}
	show_popup($("#div_UpdateSpBatchOptInf"));
}

function fn_UpdateBatchSpOptInf() {
	$("#" + $("#updateField").val()).val($("#updateValue").val());

	if($("#updateValue").val() == 0 ) {
		alert("0보다 커야합니다.");
		$("#updateValue").focus();
		return ;
	}
	if(!isNumber($("#UpdateNmlAmt").val())) {
		alert("정상가는 숫자만 입력해 주세요.");
		$("#updateValue").focus();
		return ;
	}
	if(!isNumber($("#UpdateSaleAmt").val())) {
		alert("판매가는 숫자만 입력해 주세요.");
		$("#updateValue").focus();
		return ;
	}
	if(!isNumber($("#UpdateOptPrdtNum").val())) {
		alert("상품수는 숫자만 입력해 주세요.");
		$("#updateValue").focus();
		return ;
	}
	if(strLengthCheck($("#UpdateOptNm").val()) > 90 ){
		alert("옵션명의 글자가 한도를 초과 하였습니다.");
		$("#updateValue").focus();
		return ;
	}
	if($("#UpdateStartAplDt").val() == "") {
		alert("<spring:message code='common.required.msg' arguments='적용일자'/>");
		$("#UpdateStartAplDt").focus();
		return ;
	}
	if($("#SP_UpdateBatchOpt input[name=aplWeek]:checked").length ==0) {
		alert("<spring:message code='common.required.msg' arguments='적용요일'/>");
		return ;
	}
	$("#UpdateStartAplDt").val($('#UpdateStartAplDt').val().replace(/-/g, ""));

	if(!CheckDate($("#UpdateStartAplDt").val())) {
		alert("<spring:message code='common.wrong.msg' arguments='적용일자'/>");
		$("#UpdateStartAplDt").focus();
		return ;
	}
	$("#UpdateEndAplDt").val($('#UpdateEndAplDt').val().replace(/-/g, ""));

	if(!CheckDate($("#UpdateEndAplDt").val())) {
		alert("<spring:message code='common.wrong.msg' arguments='적용일자'/>");
		$("#UpdateEndAplDt").focus();
		return ;
	}
	document.SP_UpdateBatchOpt.pageIndex.value=$('input[name=pageIndex]').val();
	if(confirm("<spring:message code='common.save.msg'/>")) {
		$.ajax({
			type:"post",
			url : "<c:url value='/mas/sp/updateBatchSpOption.ajax'/>",
			data : $("#SP_UpdateBatchOpt").serialize(),
			dataType:"json",
			success: function(data) {
				alert(data.updateCnt + "건 수정되었습니다.");
				fn_goTap("OPTION");
			},
			error : fn_AjaxError
		});
	}
}

//옵션엑셀 일괄등록 layer
function fn_viewSpExcelOpt() {
	show_popup($("#div_spExcelOptInf"));
}

/**
 * 엑셀 일괄등록 저장
 */
function fn_InsertExcelSpOptInf() {
	if($("#checkDeleteOpt:checked").val() == "Y") {
		$("#deleteOpt").val("Y");
	} else {
		$("#deleteOpt").val("N");
	}
	var ext = $('#excelFile').val().split('.').pop().toLowerCase();

	if($.inArray(ext, ['xls', 'xlsx']) == -1 ) {
		alert("엑셀 파일이 아닙니다. 다시 선택해 주세요.");
		return ;
	}
	document.SP_ExcelOpt.pageIndex.value=$('input[name=pageIndex]').val();
	$("#SP_ExcelOpt").submit();
}

//승인요청
function fn_approvalReqSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/approvalReqSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum}",
		dataType:"json",
		success: function(data) {
			fn_goTap("OPTION");
		},
		error : fn_AjaxError
	});
}

// 승인취소하기
function fn_approvalCancelSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/approvalCancelSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum}",
		dataType:"json",
		success: function(data) {
			fn_goTap("OPTION");
		},
		error : fn_AjaxError
	});
}

//탭 이동
function fn_goTap(menu) {
	if(menu == "PRODUCT") {
		document.tabForm.action="<c:url value='/mas/sp/viewUpdateSocial.do' />";
	} else if( menu == "IMG") {
		document.tabForm.action="<c:url value='/mas/sp/imgList.do' />";
	} else if(menu == "IMG_DETAIL") {
		document.tabForm.action="<c:url value='/mas/sp/dtlImgList.do' />";
	} else if(menu == "OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewOption.do' />";
	} else if(menu == "ADD_OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewAddOption.do' />";
	} else if(menu == "DTLINF") {
		document.tabForm.action="<c:url value='/mas/sp/dtlinfList.do' />";
	}
	document.tabForm.submit();
}

// 선택 옵션 삭제
function fn_selDelOption() {
	if ($('.optionSel:checked').length == 0) {
		alert('삭제를 원하는 옵션항목을\n  선택해주세요.');
		return false;
	}else if(($('.optionSel:checked').length >= 11)){
		alert('10개 옵션 이상 항목삭제가 불가능합니다. "전체옵션삭제" 버튼을 이용해 주세요.');
		return false;
	}
	if (window.confirm('선택된 옵션들을 모두\n  삭제하시겠습니까?')) {
		var selOptList = [];

		$('.optionSel:checked').each(function() {
			selOptList.push($(this).val());
		});

		$.ajax({
			url : "<c:url value='/mas/sp/selDeleteSocialOptInf.ajax' />",
			data : "prdtNum=${SP_OPTINFVO.prdtNum}&selOptList=" + selOptList,
			dataType:"json",
			success: function(data) {
				if(data.chkVal == "N") {
					alert("예약건이 존재하여 삭제가 불가능한 옵션이 있습니다.");
				} else {
					alert("선택된 옵션들을 삭제했습니다.");
				}
				location.reload();
			},
			error : fn_AjaxError
		});
	}
}

// 전체 옵션 삭제
function fn_selDelAllOption() {

	if (window.confirm("판매가 되었거나 취소가 된 상품을 제외하고 모두 삭제됩니다. 삭제하시겠습니까?")) {
		$.ajax({
			url : "<c:url value='/mas/sp/selDeleteSocialAllOptInf.ajax' />",
			data : "prdtNum=${SP_OPTINFVO.prdtNum}",
			dataType:"json",
			success: function(data) {
					alert("전체 옵션을 삭제했습니다.");
				location.reload();
			},
			error : fn_AjaxError
		});
	}
}

function sendCheckLsCompanyProduct(lsPrdtNum,lsOptNum) {
	var params = {};
	params["lsLinkPrdtNum"] = lsPrdtNum;
	params["lsLinkOptNum"] = lsOptNum;

	var apiUrl = "/oss/lsProductDetail.ajax"

	$.ajax({
		dataType : apiUrl,
		url : apiUrl,
		data : params,
		dataType:"json",
		success: function(data) {
		    console.log(data);
		    alert(data.resultData.resultMessage);
		},
		error : fn_AjaxError
	});
}

function sendCheckHijejuProduct(lsPrdtNum,lsOptNum) {
	var params = {};
    params["lsLinkPrdtNum"] = lsPrdtNum;
    params["lsLinkOptNum"] = lsOptNum;

	var apiUrl = "/web/requestUseableHijejuProduct.ajax"

	$.ajax({
		dataType : apiUrl,
		url : apiUrl,
		data : params,
		dataType:"json",
		success: function(data) {
			console.log(data);
			alert(data.success);
		},
		error : fn_AjaxError
	});
}


$(function() {
	if("true" == "${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}") {
		$("#aplDt").datepicker({
			dateFormat: "yy-mm-dd",
			minDate : fn_addDate("${spPrdtInf.saleStartDt}"),
			maxDate : "+1y",
		});

		$("#startAplDt").datepicker({
			dateFormat: "yy-mm-dd",
			minDate : fn_addDate("${spPrdtInf.saleStartDt}"),
			maxDate : "+1y",
			onClose : function(selectedDate) {
				$("#endAplDt").datepicker("option", "minDate", selectedDate);
			}
		});

		$("#endAplDt").datepicker({
			dateFormat: "yy-mm-dd",
			minDate : fn_addDate("${spPrdtInf.saleStartDt}"),
			maxDate : "+1y",
			onClose : function(selectedDate) {
				$("#startAplDt").datepicker("option", "maxDate", selectedDate);
			}
		});

		$("#UpdateStartAplDt").datepicker({
			dateFormat: "yy-mm-dd",
			minDate : fn_addDate($("#UpdateBatchSpDivSn option:selected").attr("data-startAplDt")),
			maxDate : fn_addDate($("#UpdateBatchSpDivSn option:selected").attr("data-endAplDt")),
			onClose : function(selectedDate) {
				$("#UpdateEndAplDt").datepicker("option", "minDate", selectedDate);
			}
		});

		$("#UpdateEndAplDt").datepicker({
			dateFormat: "yy-mm-dd",
			minDate : fn_addDate($("#UpdateBatchSpDivSn option:selected").attr("data-startAplDt")),
			maxDate : fn_addDate($("#UpdateBatchSpDivSn option:selected").attr("data-endAplDt")),
			onClose : function(selectedDate) {
				$("#UpdateStartAplDt").datepicker("option", "maxDate", selectedDate);
			}
		});

		var option = {
				iframe: true,
				dataType:'json',
				success: function(data) {

					console.log(data.RESULT);
					//빈행 체크
					if (data.RESULT === "ROW_FAIL") {
						alert(data.MESSAGE + "에 빈값이 존재 합니다.\n"+"삭제하시거나 고객센터(1522-3454)로 문의 바랍니다.");
						return;
					}

					alert("성공 : " + data.s_cnt + " 실패 : " + data.f_cnt);
					fn_goTap('OPTION');
				},
				error : function(request, status, error){
					if(request.status == "500"){
						alert("로그인 정보가 없습니다. 로그인 후 진행하시기 바랍니다.");
						location.reload(true);
					}else{
						console.log("에러가 발생했습니다!");
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				},
				clearForm : true
		};

		$("#SP_ExcelOpt").submit(function() {
			$(this).ajaxSubmit(option);
			return false;
		});

		$("#updateField").change(function() {
			$("#updateValue").val('');
			$("#UpdateNmlAmt").val(0);
			$("#UpdateSaleAmt").val(0);
			$("#UpdateOptPrdtNum").val(0);
			$("#UpdateOptNm").val('');
		});

		$("#UpdateBatchSpDivSn").change(function() {
			$("#UpdateStartAplDt").datepicker('option', 'maxDate', fn_addDate($(this).children("option:selected").attr("data-endAplDt")));
			$("#UpdateStartAplDt").datepicker('option', 'minDate', fn_addDate($(this).children("option:selected").attr("data-startAplDt")));
			$("#UpdateEndAplDt").datepicker('option', 'maxDate', fn_addDate($(this).children("option:selected").attr("data-endAplDt")));
			$("#UpdateEndAplDt").datepicker('option', 'minDate', fn_addDate($(this).children("option:selected").attr("data-startAplDt")));
		});

		$("#aplWeekAll").click(function () {
			if($("#aplWeekAll").prop("checked")) {
				$("#SP_BatchOpt input[name=aplWeek]").prop("checked", true);
			} else {
				$("#SP_BatchOpt input[name=aplWeek]").prop("checked", false);
			}
		});

		$("#UpdateAplWeekAll").click(function () {
			if($("#UpdateAplWeekAll").prop("checked")) {
				$("#SP_UpdateBatchOpt input[name=aplWeek]").prop("checked", true);
			} else {
				$("#SP_UpdateBatchOpt input[name=aplWeek]").prop("checked", false);
			}
		});
	}
	if("${error}" == "Y"){
		show_popup($("#div_spOptInf"));
	}
	// 예상정산액 산출
	$('#saleAmt').change(function() {
		$('#cmssAmt').val($(this).val() - Math.floor('${spPrdtInf.cmssRate}' * ($(this).val() / 100) / 10) * 10);
	});

	// 전체선택 & 해제
	$("#allOptionSel").click(function() {
		if ($(this).prop('checked') == true) {
			$(".optionSel").prop('checked', true);
		} else {
			$(".optionSel").prop('checked', false);
		}
	});

	// 전체선택 체크 여부
	$('.optionSel').click(function() {
		var allCheck = true;
		$('.optionSel').each(function() {
			if ($(this).prop('checked') == false) {
				allCheck = false;
				return;
			}
		});

		$("#allOptionSel").prop('checked', allCheck);
	});

});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form name="SP_OPTINFVO_LIST" method="post">
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
				<div id="contents">
					<h2 class="title08"><c:out value="${spPrdtInf.prdtNm}"/></h2>

					<div id="menu_depth3">
						<ul>
							<li><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
							<li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
							<li><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
							<li><a class="menu_depth3" href="javascript:fn_goTap('DTLINF');" >상세정보</a></li>
							<c:if test="${spPrdtInf.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
								<li class="on"><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
								<li><a class="menu_depth3" href="javascript:fn_goTap('ADD_OPTION');" >추가옵션설정</a></li>
							</c:if>
					   	</ul>
					   	<div class="btn_rt01">
							<c:if test="${Constant.TRADE_STATUS_REG eq btnApproval }">
								<div class="btn_sty01"><a href="javascript:fn_approvalReqSocial();">승인요청</a></div>
							</c:if>
							<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq btnApproval }">
								<div class="btn_sty01"><a href="javascript:fn_approvalCancelSocial();">승인취소</a></div>
							</c:if>
					   	</div>
					</div>
					<table border="1" cellspacing="0" cellpadding="0" class="table04">
						<colgroup>
							<col width="6%" />
							<col width="10%" />
							<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR }">
								<col width="10%" />
							</c:if>
							<col />
							<col width="7%" />
							<col width="7%" />
							<col width="7%" />
							<c:if test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD }">
								<col width="10%" />
								<col width="10%" />
							</c:if>
							<col width="10%" />
							<col width="5%" />
							<col width="15%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><input type='checkbox' id="allOptionSel" /> 전체선택</th>
								<th scope="col">
									<c:if test="${not empty spPrdtInf.lsLinkPrdtNum && spPrdtInf.lsLinkYn eq 'Y'}">
										LS컴퍼니 연동확인
									</c:if>
									<c:if test="${empty spPrdtInf.lsLinkPrdtNum}">
										상품구분
									</c:if>
								</th>
								<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
									<th scope="col">적용일자</th>
								</c:if>
								<th scope="col">옵션명</th>
								<th scope="col">정상가</th>
								<th scope="col">판매가</th>
								<th scope="col">예상정산액</th>
								<c:if test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD }">
									<th scope="col">기준인원</th>
									<th scope="col">마감여부</th>
								</c:if>
								<th scope="col">상품수</th>
								<th scope="col">출력</th>
								<th scope="col">관리자툴</th>
							</tr>
							<c:if test="${fn:length(resultList) == 0}">
							<!-- 데이터 없음 -->
								<tr>
									<c:choose>
										<c:when test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD}">
											<td colspan="12" class="align_ct"><spring:message code="info.nodata.msg" /></td>
										</c:when>
										<c:when test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
											<td colspan="11" class="align_ct"><spring:message code="info.nodata.msg" /></td>
										</c:when>
										<c:otherwise>
											<td colspan="10" class="align_ct"><spring:message code="info.nodata.msg" /></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:if>
							<c:forEach items="${resultList}" var="spOptInf">
								<c:choose>
									<c:when test="${empty spOptInf.optNm }">
										<tr class="tr_bg01">
											<c:choose>
												<c:when test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD}">
													<td colspan="10">
												</c:when>
												<c:when test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
													<td colspan="9">
												</c:when>
												<c:otherwise>
													<td colspan="8">
												</c:otherwise>
											</c:choose>
											<strong><c:out value="${spOptInf.prdtDivNm}"/></strong></td>
											<td class="td_align_ct01">
												<%--c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq spPrdtInf.tradeStatus or Constant.TRADE_STATUS_EDIT eq spPrdtInf.tradeStatus}"--%>
													<div class="btn_sty06"><span><a href="javascript:fn_viewUpdateSpDivinf('${spOptInf.spDivSn}')">수정</a></span></div>
													<div class="btn_sty09"><span><a href="javascript:fn_DelSpDivinf('${spOptInf.spDivSn}')">삭제</a></span></div>
													<div class="btn_sty06"><span><a href="javascript:fn_viewSpOptInf('${spOptInf.spDivSn}', '${spOptInf.prdtDivNm}')">옵션추가</a></span></div>
												<%--/c:if--%>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td>
												<c:if test="${spOptInf.rsvNum eq 0}">
													<input type='checkbox' class="optionSel" value="${spOptInf.spDivSn}_${spOptInf.spOptSn}" />
												</c:if>
											</td>
											<td class="td_align_ct01">
												<c:if test="${spPrdtInf.lsLinkYn eq 'Y' and not empty spPrdtInf.lsLinkPrdtNum and not empty spOptInf.lsLinkOptNum }">
													<div class="btn_sty06">
														<span><a href="javascript:sendCheckLsCompanyProduct('${spPrdtInf.lsLinkPrdtNum}','${spOptInf.lsLinkOptNum}')">연동확인</a></span>
													</div>
												</c:if>
												<c:if test="${spPrdtInf.lsLinkYn eq 'H' and not empty spPrdtInf.lsLinkPrdtNum and not empty spOptInf.lsLinkOptNum }">
													<div class="btn_sty06">
														<span><a href="javascript:sendCheckHijejuProduct('${spPrdtInf.lsLinkPrdtNum}','${spOptInf.lsLinkOptNum}')">연동확인</a></span>
													</div>
												</c:if>
											</td>
											<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
												<td class="td_align_ct01">
													<c:out value="${fn:replace(spOptInf.aplDt, '/','-')}" />
												</td>
											</c:if>
											<td class="td_align_lt01"><c:out value="${spOptInf.optNm }" /></td>
											<td class="td_align_rt01"><fmt:formatNumber value="${spOptInf.nmlAmt}"  type="number"/></td>
											<td class="td_align_rt01"><fmt:formatNumber value="${spOptInf.saleAmt}"  type="number"/></td>
											<c:set var="cmssAmt" value="${(spOptInf.saleAmt * (spPrdtInf.cmssRate / 100) / 10) }" />
											<td class="td_align_rt01"><fmt:formatNumber value="${spOptInf.saleAmt - (cmssAmt-(cmssAmt%1)) * 10}"  type="number"/></td>
											<c:if test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD }">
												<td class="td_align_ct01"><fmt:formatNumber value="${spOptInf.stdMem}"  type="number"/></td>
												<td class="td_align_ct01"><c:out value="${spOptInf.ddlYn}" /></td>
											</c:if>
											<td class="td_align_ct01"><fmt:formatNumber value="${spOptInf.optPrdtNum}"  type="number"/></td>
											<td class="td_align_ct01">
												<c:if test="${spOptInf.printYn eq 'Y'}">
													출력
												</c:if>
												<c:if test="${spOptInf.printYn ne 'Y'}">
													미출력
												</c:if>
											</td>
											<td class="td_align_ct01">
												<%--c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq spPrdtInf.tradeStatus  or  Constant.TRADE_STATUS_EDIT eq spPrdtInf.tradeStatus}" --%>
												<div class="btn_sty06"><span><a href="javascript:fn_viewUpdateSpOptInf('${spOptInf.spDivSn}', '${spOptInf.spOptSn}', '${spOptInf.prdtDivNm}')">수정</a></span></div>
												<div class="btn_sty09"><span><a href="javascript:fn_DelSpOptinf('${spOptInf.spDivSn}', '${spOptInf.spOptSn}' )">삭제</a></span></div>
												<%--/c:if --%>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
					<div class="btn-fixed">
						<%-- c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq spPrdtInf.tradeStatus  or  Constant.TRADE_STATUS_EDIT eq spPrdtInf.tradeStatus}"--%>
						<ul class="btn_lt01">
							<li class="btn_sty04"><a href="javascript:fn_viewSpDivinf()">상품구분추가</a></li>
							<li class="btn_sty03"><a href="javascript:fn_selDelOption()">선택옵션삭제</a></li>
							<li class="btn_sty03"><a href="javascript:fn_selDelAllOption()">전체옵션삭제</a></li>
							<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
								<li class="btn_sty04"><a href="javascript:fn_viewSpBatchOpt()">옵션일괄등록</a></li>
								<li class="btn_sty04"><a href="javascript:fn_viewUpdateSpBatchOpt()">옵션일괄수정</a></li>
								<li class="btn_sty04"><a href="javascript:fn_viewSpExcelOpt()">옵션엑셀등록</a></li>
							</c:if>
						</ul>
						<%-- /c:if--%>
						<ul class="btn_rt01 align_ct">
							<li class="btn_sty01">
								<a href="javascript:fn_socialProductList()">목록</a>
							</li>
						</ul>
					</div>
				</div>
			</form>
		<!--//Contents 영역-->
		</div>
	</div>
</div>
<form name="tabForm" method="get">
	<input type="hidden" name="prdtNum"  value="${SP_OPTINFVO.prdtNum }"/>
	<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>
</form>
<div class="blackBg"></div>

<div id="div_spDivInf" class="lay_popup lay_ct"  style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_spDivInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
           	<form:form commandName="SP_DIVINFVO"  name="SP_DIVINFVO" method="post" onsubmit="return false" >
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
				<input type="hidden" name="spDivSn" />
				<input type="hidden" name="pageIndex" />

				<table border="1" cellpadding="0" cellspacing="0" class="table02">
				   	<caption class="tb02_title">
						상품 구분<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</caption>
					<colgroup>
						 <col width="33%" />
						 <col width="65%" />
					</colgroup>
					<tr>
						<th>상품구분명<span class="font_red">*</span></th>
						<td><form:input path="prdtDivNm" class="input_text_full"  maxlength="60" /></td>
					</tr>
					<tr>
						<th>노출순번</th>
						<td>
							<form:select path="viewSn">
							</form:select>
						</td>
					</tr>
				</table>
			</form:form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertSpDivInf();">저장</a></span></div>
</div>

<div id="div_spOptInf" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_spOptInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
			<form:form commandName="SP_OPTINFVO"  name="SP_OPTINFVO" method="post" onSubmit="return false">
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
				<input type="hidden" name="spDivSn" />
				<input type="hidden" name="spOptSn" />
				<input type="hidden" name="selOptList" />
				<input type="hidden" name="pageIndex" />

				<table border="1" class="table02">
					<caption class="tb02_title">
						상품 옵션<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</caption>
					<colgroup>
						<col width="33%" />
						<col width="65%" />
					</colgroup>
					<tr>
						<th>상품구분명</th>
						<td><span id="span_divOpt_divNm"></span></td>
					</tr>
					<c:choose>
						<c:when test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
							<tr>
								<th>적용일자<span class="font_red">*</span></th>
								<td>
									<form:input path="aplDt"  id="aplDt" readonly="true"  class="input_text5" value="${spDivInf.aplDt}"/>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="aplDt" id="aplDt" />
						</c:otherwise>
					</c:choose>
					<tr>
						<th>옵션명<span class="font_red">*</span></th>
						<td>
							<form:input path="optNm" id="optNm" class="input_text_full" maxlength="30" value="${spOptInfo.optNm}"/>
							<form:errors path="optNm"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>노출순번</th>
						<td>
							<form:select path="viewSn">
							</form:select>
							<form:errors path="viewSn"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>정상가<span class="font_red">*</span></th>
						<td>
							<form:input path="nmlAmt"  class="input_text10 numFormat"/>
							<form:errors path="nmlAmt"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>판매가<span class="font_red">*</span></th>
						<td>
							<form:input path="saleAmt" class="input_text10 numFormat" />
							<form:errors path="saleAmt"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>예상정산액</th>
						<td>
							<input type="text" id="cmssAmt" class="input_text10 numFormat" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th>상품수<span class="font_red">*</span></th>
						<td><form:input path="optPrdtNum"  class="input_text10 numFormat"/>
							<form:errors path="optPrdtNum"  cssClass="error_text"/>
						</td>
					</tr>
					<c:if test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD }">
					 	<tr>
							<th>기준인원<span class="font_red">*</span></th>
							<td>
								<input type="text" name="stdMem" class="input_text10 numFormat" />명
							</td>
						</tr>
						<tr>
							<th>마감여부<span class="font_red">*</span></th>
							<td>
								<select name="ddlYn">
									<option value="N">판매중</option>
									<option value="Y">마감</option>
								</select>
							</td>
						</tr>
					</c:if>
					<tr>
						<th>출력여부<span class="font_red">*</span></th>
						<td>
							<select name="printYn">
								<option value="Y">출력</option>
								<option value="N">미출력</option>
							</select>
						</td>
					</tr>
					<c:if test="${spPrdtInf.lsLinkYn eq 'Y' and not empty spPrdtInf.lsLinkPrdtNum || spPrdtInf.lsLinkYn eq 'J' and not empty spPrdtInf.lsLinkPrdtNum || spPrdtInf.lsLinkYn eq 'V' and not empty spPrdtInf.lsLinkPrdtNum}">
						<tr>
							<th>
								<c:if test="${spPrdtInf.lsLinkYn eq 'Y' and not empty spPrdtInf.lsLinkPrdtNum}">
									LS컴퍼니 옵션번호
								</c:if>
								<c:if test="${spPrdtInf.lsLinkYn eq 'J' and not empty spPrdtInf.lsLinkPrdtNum}">
									야놀자 옵션번호
								</c:if>
								<c:if test="${spPrdtInf.lsLinkYn eq 'V' and not empty spPrdtInf.lsLinkPrdtNum}">
									브이패스 옵션번호
								</c:if>
							</th>
							<td>
								<form:input path="lsLinkOptNum" class="input_text10" />
								<form:errors path="lsLinkOptNum"  cssClass="error_text"/>
							</td>
						</tr>
					</c:if>
				</table>
			</form:form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertSpOptInf();">저장</a></span></div>
</div>

<div id="div_spBatchOptInf" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_spBatchOptInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
			<form:form commandName="SP_OPTINFVO"  name="SP_BatchOpt" id="SP_BatchOpt" method="post" onSubmit="return false">
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
				<input type="hidden" name="pageIndex"/>
				<table border="1" class="table02">
					<caption class="tb02_title">
						상품 옵션 일괄 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</caption>
					<colgroup>
						 <col width="33%" />
						 <col width="65%" />
					</colgroup>
					<tr>
						<th>상품구분<span class="font_red">*</span></th>
						<td>
							<select id="batchSpDivSn" name="spDivSn" style="width:300px">
								<c:forEach items="${resultList}" var="spOptInf">
									<c:if test="${empty spOptInf.optNm }">
										<option value="${spOptInf.spDivSn}">${spOptInf.prdtDivNm}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>적용일자<span class="font_red">*</span></th>
						<td>
							<form:input path="startAplDt"  id="startAplDt" readonly="true"  class="input_text5" /> ~ <form:input path="endAplDt"  id="endAplDt" readonly="true"  class="input_text5" />
						</td>
					</tr>
					<tr>
						<th>적용요일<span class="font_red">*</span></th>
						<td>
							<input type="checkbox" name="aplWeekAll"  id="aplWeekAll" /> <label for="aplWeekAll">전체</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek1"  value="1"/> <label for="aplWeek1">일</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek2" value="2"/> <label for="aplWeek2">월</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek3" value="3"/> <label for="aplWeek3">화</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek4" value="4"/> <label for="aplWeek4">수</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek5" value="5"/> <label for="aplWeek5">목</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek6" value="6" /> <label for="aplWeek6">금</label>&nbsp;
							<form:checkbox path="aplWeek"  id="aplWeek7" value="7"/> <label for="aplWeek7">토</label>&nbsp;
						</td>
					</tr>
					<tr>
						<th>옵션명<span class="font_red">*</span></th>
						<td>
							<form:input path="optNm" id="optNm" class="input_text_full" maxlength="30" value="${spOptInfo.optNm}" />
							<form:errors path="optNm"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>정상가<span class="font_red">*</span></th>
						<td>
							<form:input path="nmlAmt"  id="batchNmlAmt" class="input_text10 numFormat"/>
							<form:errors path="nmlAmt"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>판매가<span class="font_red">*</span></th>
						<td>
							<form:input path="saleAmt" id="batchSaleAmt" class="input_text10 numFormat" />
							<form:errors path="saleAmt"  cssClass="error_text"/>
						</td>
					</tr>
					<tr>
						<th>상품수<span class="font_red">*</span></th>
						<td><form:input path="optPrdtNum"  id="batchOptPrdtNum" class="input_text10 numFormat"/>
							<form:errors path="optPrdtNum"  cssClass="error_text"/>
						</td>
					</tr>
					<c:if test="${spPrdtInf.ctgr eq Constant.CATEGORY_PACK_AD }">
						<tr>
							<th>기준인원<span class="font_red">*</span></th>
							<td>
								<input type="text" name="stdMem" class="input_text10 numFormat" />명
							</td>
						</tr>
						<tr>
							<th>마감여부<span class="font_red">*</span></th>
							<td>
								<select name="ddlYn">
									<option value="N">판매중</option>
									<option value="Y">마감</option>
								</select>
							</td>
						</tr>
					</c:if>
					<tr>
						<th>출력여부<span class="font_red">*</span></th>
						<td>
							<select name="printYn">
								<option value="Y">출력</option>
								<option value="N">미출력</option>
							</select>
						</td>
					</tr>
				</table>
			</form:form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertBatchSpOptInf();">저장</a></span></div>
</div>

<div id="div_spExcelOptInf" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_spExcelOptInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
			<form  name="SP_ExcelOpt" id="SP_ExcelOpt" action="/mas/sp/insertExcelSpOption.ajax" method="post" enctype="multipart/form-data" onSubmit="return false">
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
				<input type="hidden" name="pageIndex"  />

				<table border="1" class="table02">
					<caption class="tb02_title">
						상품 옵션 엑셀 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</caption>
					<colgroup>
						 <col width="33%" />
						 <col width="65%" />
					</colgroup>
					<tr>
						<th>상품구분<span class="font_red">*</span></th>
						<td>
							<select id="excelSpDivSn" name="spDivSn" style="width:300px">
								<option value="">전 체</option>
								<c:forEach items="${resultList}" var="spOptInf">
									<c:if test="${empty spOptInf.optNm }">
										<option value="${spOptInf.spDivSn}">${spOptInf.prdtDivNm}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>첨부파일<span class="font_red">*</span></th>
						<td>
							<input type="file" id="excelFile" name="excelFile" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" style="width: 70%" />
							<br>
							<c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
						</td>
					</tr>
					<tr>
						<th>삭제여부<span class="font_red">*</span></th>
						<td>
							<input type="checkbox" id="checkDeleteOpt" name="checkDeleteOpt"  value="Y"/> 등록된 옵션 삭제
							<br>선택하시면 등록되어 있는 옵션이 전부 삭제됩니다.
							<input type="hidden" id="deleteOpt" name="deleteOpt" />
						</td>
					</tr>
				</table>
			</form>
		</li>
		<li>※ 엑셀 형식에 맞게 입력바랍니다. <a href="/data/manual/option.xls" target="_blank" class="link">[엑셀 다운로드]</a></li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertExcelSpOptInf();">저장</a></span></div>
</div>

<div id="div_UpdateSpBatchOptInf" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_UpdateSpBatchOptInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
			<form name="SP_UpdateBatchOpt" id="SP_UpdateBatchOpt" method="post" onSubmit="return false">
				<input type="hidden" name="prdtNum" value="${SP_OPTINFVO.prdtNum }" />
				<input type="hidden" name="pageIndex" />
				<table border="1" class="table02">
					<caption class="tb02_title">
						상품 옵션 일괄 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</caption>
					<colgroup>
						 <col width="33%" />
						 <col width="65%" />
					</colgroup>
					<tr>
						<th>상품구분<span class="font_red">*</span></th>
						<td>
							<select id="UpdateBatchSpDivSn" name="spDivSn" style="width:300px">
								<c:forEach items="${spTourDivList}" var="spOptInf">
									<option value="${spOptInf.spDivSn}" data-startAplDt="${spOptInf.startAplDt}" data-endAplDt="${spOptInf.endAplDt}">${spOptInf.prdtDivNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>적용일자<span class="font_red">*</span></th>
						<td>
							<input type="text" name="startAplDt"  id="UpdateStartAplDt" readonly="true"  class="input_text5" /> ~ <input type="text" name="endAplDt"  id="UpdateEndAplDt" readonly="true"  class="input_text5" />
						</td>
					</tr>
					<tr>
						<th>적용요일<span class="font_red">*</span></th>
						<td>
							<input type="checkbox" name="UpdateAplWeekAll"  id="UpdateAplWeekAll" /> <label for="UpdateAplWeekAll">전체</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek1"  value="1"/> <label for="UpdateAplWeek1">일</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek2" value="2"/> <label for="UpdateAplWeek2">월</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek3" value="3"/> <label for="UpdateAplWeek3">화</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek4" value="4"/> <label for="UpdateAplWeek4">수</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek5" value="5"/> <label for="UpdateAplWeek5">목</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek6" value="6" /> <label for="UpdateAplWeek6">금</label>&nbsp;
							<input type="checkbox" name="aplWeek"  id="UpdateAplWeek7" value="7"/> <label for="UpdateAplWeek7">토</label>&nbsp;
						</td>
					</tr>
					<tr>
						<th>적용항목<span class="font_red">*</span></th>
						<td>
							<select id="updateField">
								<option value="UpdateOptNm">옵션명</option>
								<option value="UpdateNmlAmt">정상가</option>
								<option value="UpdateSaleAmt">판매가</option>
								<option value="UpdateOptPrdtNum">상품수</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>적용값<span class="font_red">*</span></th>
						<td>
							<input name="updateValue" id="updateValue" class="input_text_full"/>
							<input type="hidden" name="optNm" id="UpdateOptNm" value=""/>
							<input type="hidden" name="nmlAmt" id="UpdateNmlAmt" value="0"/>
							<input type="hidden" name="saleAmt" id="UpdateSaleAmt" value="0"/>
							<input type="hidden" name="optPrdtNum" id="UpdateOptPrdtNum" value="0"/>
						</td>
					</tr>
				</table>
			</form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_UpdateBatchSpOptInf();">저장</a></span></div>
</div>

</body>
</html>