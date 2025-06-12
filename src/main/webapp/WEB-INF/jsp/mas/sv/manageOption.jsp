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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.min.js'/>"></script>

<validator:javascript formName="SV_OPTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<title></title>

<script type="text/javascript">

//상품 리스트
function fn_PrdtList() {
	location.href="<c:url value='/mas/sv/productList.do' />?pageIndex=${searchVO.pageIndex}";
}

function fn_InsertDivInf(){
	// validation 체크
	var prdtDivNm = $("#SV_DIVINFVO input[name=prdtDivNm]").val();
	var viewSn =  $("#SV_DIVINFVO select[name=viewSn] option:selected").val();
	if(prdtDivNm == ""){
		alert("<spring:message code='common.required.msg' arguments='상품구분명'/>");
		return ;
	}
	if(strLengthCheck(prdtDivNm) > 90) {
		alert("<spring:message code='common.maxlength.msg' arguments='상품구분명,30'/>");
		return ;
	}
	if(viewSn == 0) {
		alert("<spring:message code='common.required.msg' arguments='노출순번'/>");
		return ;
	}
	var tempDivSn = $("#SV_DIVINFVO").find("[name=svDivSn]").val();
	if(tempDivSn == "")
		document.SV_DIVINFVO.action = "<c:url value='/mas/sv/insertDivInf.do' />";
	else
		document.SV_DIVINFVO.action = "<c:url value='/mas/sv/updateDivInf.do' />";	
	document.SV_DIVINFVO.submit();
}

function fn_clearDivinf() {
	$("#SV_DIVINFVO").find("[name=viewSn] option").remove();
	$("#SV_DIVINFVO input:not([name=prdtNum])").val("");
}

function fn_clearOptinf() {
	$("#SV_OPTINFVO").find("[name=viewSn] option").remove();
	$("#SV_OPTINFVO input:not([name=prdtNum]):not([name=dlvAmtDiv])").val("");
	$("#span_divOpt_divNm").html('');
}

function fn_viewDivinf() {
	fn_clearDivinf();
	$.ajax({
		dataType:"json",
		url : "<c:url value='/mas/sv/getDivMaxViewSn.ajax' />",
		data : "prdtNum=${SV_OPTINFVO.prdtNum}",
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
			$("#SV_DIVINFVO").find("[name=viewSn]").append(dataArr);
			$("#SV_DIVINFVO").find("#printYnChk1").val("Y");
			$("#SV_DIVINFVO").find("#printYnChk1").prop('checked', true);
			$("#SV_DIVINFVO").find("#printYnChk2").val("N");
			show_popup($("#div_svDivInf"));
		},
		error :fn_AjaxError
	});
}

function fn_viewOptInf(svDivSn, prdtDivNm) {
	fn_clearOptinf();
	$.ajax({
		dataType: "json",
		url : "<c:url value='/mas/sv/getOptMaxViewSn.ajax' />",
		data : "prdtNum=${SV_OPTINFVO.prdtNum}&svDivSn=" + svDivSn,
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
			$("#span_divOpt_divNm").html(prdtDivNm);
			$("#SV_OPTINFVO").find("[name=viewSn]").append(dataArr);
			$("#SV_OPTINFVO").find("[name=svDivSn]").val(svDivSn);
			$("#SV_OPTINFVO").find("#printYnChk1").val("Y");
			$("#SV_OPTINFVO").find("#printYnChk1").prop('checked', true);
			$("#SV_OPTINFVO").find("#printYnChk2").val("N");
			show_popup($("#div_svOptInf"));
		},
		error : fn_AjaxError
	})
}

function fn_InsertOptInf(){
	// 콤마 제거
	delCommaFormat();
	
	// validation 체크
	/*if(!validateSV_OPTINFVO(document.SV_OPTINFVO)){
		return;
	}*/

	if(isNull($("#optNm").val()) || $("#optNm").val() == " ") {
		alert("<spring:message code='common.required.msg' arguments='옵션명'/>");
		$("#optNm").focus();
		return ;
	}	
	
	if(isNull($("#nmlAmt").val()) || $("#nmlAmt").val() == " ") {
		alert("<spring:message code='common.required.msg' arguments='정상가'/>");
		$("#nmlAmt").focus();
		return ;
	}		
	
	if(isNull($("#saleAmt").val()) || $("#saleAmt").val() == " ") {
		alert("<spring:message code='common.required.msg' arguments='판매가'/>");
		$("#saleAmt").focus();
		return ;
	}		
	
	if(parseInt($("#saleAmt").val()) > parseInt($("#nmlAmt").val())) {
		alert("<spring:message code='errors.price.compare' arguments='판매금액,정상금액'/>");
		return ;
	}
	
	if(parseInt($("#nmlAmt").val()) <= 0) {
		alert("<spring:message code='errors.excess' arguments='정상가,0' />");
		$("#nmlAmt").focus();
		return ;
	}
	
	if(parseInt($("#saleAmt").val()) <= 0) {
		alert("<spring:message code='errors.excess' arguments='판매가,0' />");
		$("#saleAmt").focus();
		return ;
	}

	var dlvAmtDiv = $("input:radio[name=dlvAmtDiv]:checked").val();
	if(isNull(dlvAmtDiv)) {
		alert("<spring:message code='common.required.msg' arguments='배송비'/>");
		return ;
	}
	if($("input:radio[name='dlvAmtDiv']:radio[value='${Constant.DLV_AMT_DIV_DLV}']").prop("checked")) {
		$("#dlvAmt").val("${corpDlvAmtVO.dlvAmt}");
		$("#inDlvAmt").val("${corpDlvAmtVO.inDlvAmt}");
	} else if($("input:radio[name='dlvAmtDiv']:radio[value='${Constant.DLV_AMT_DIV_APL}']").prop("checked")) {
		$("#dlvAmt").val("${corpDlvAmtVO.dlvAmt}");
		$("#inDlvAmt").val("${corpDlvAmtVO.inDlvAmt}");
	} else if($("input:radio[name='dlvAmtDiv']:radio[value='${Constant.DLV_AMT_DIV_FREE}']").prop("checked")) {
		$("#dlvAmt").val(0);
		$("#inDlvAmt").val(0);
	}
	
	if($("input:radio[name='dlvAmtDiv']:radio[value='${Constant.DLV_AMT_DIV_MAXI}']").prop("checked") == true) {
		if(isNull($("#cMaxiBuyNum").val())) {
			alert("<spring:message code='common.required.msg' arguments='최대구매수'/>");
			$("#cMaxiBuyNum").focus();
			return ;
		}
		
		if(!isNumber($("#cMaxiBuyNum").val())) {
			alert("<spring:message code='errors.integer' arguments='최대구매수'/>");
			$("#cMaxiBuyNum").focus();
			return ;
		}
		
		if(isNull($("#cDlvAmt").val()) || $("#cDlvAmt").val() == " ") {
			alert("<spring:message code='common.required.msg' arguments='배송금액'/>");
			$("#cDlvAmt").focus();
			return ;
		}
		
		if(!isNumber($("#cDlvAmt").val())) {
			alert("<spring:message code='errors.integer' arguments='배송금액'/>");
			$("#cDlvAmt").focus();
			return ;
		}
		$("#maxiBuyNum").val($("#cMaxiBuyNum").val());
		$("#dlvAmt").val($("#cDlvAmt").val());
		$("#inDlvAmt").val($("#cDlvAmt").val());
	}

	if(isNull($("#optPrdtNum").val()) || $("#optPrdtNum").val() == " ") {
		alert("<spring:message code='common.required.msg' arguments='상품수'/>");
		$("#optPrdtNum").focus();
		return ;
	}
	
	if(parseInt($("#optPrdtNum").val()) <= 0) {
		alert("<spring:message code='errors.excess' arguments='상품수,0' />");
		$("#optPrdtNum").focus();
		return ;
	}
	
	var tempOptSn = $("#SV_OPTINFVO").find("[name=svOptSn]").val();
	if(tempOptSn == "")
		document.SV_OPTINFVO.action = "<c:url value='/mas/sv/insertOption.do' />";
	else
		document.SV_OPTINFVO.action = "<c:url value='/mas/sv/updateOptInf.do' />";
	document.SV_OPTINFVO.submit();
}

function fn_viewUpdateDivinf(svDivSn) {
	fn_clearDivinf();
	$.ajax({
		url : "<c:url value='/mas/sv/viewUpdateDivinf.ajax' />",
		data : "prdtNum=${SV_OPTINFVO.prdtNum}&svDivSn=" + svDivSn,
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			$("#SV_DIVINFVO").find("[name=prdtDivNm]").val(data.spDivInfVO.prdtDivNm);
			$("#SV_DIVINFVO").find("[name=svDivSn]").val(data.spDivInfVO.svDivSn);
			var dataArr = [];
			for(var i = 1; i <= maxViewSn; i++) {
				if( i == data.spDivInfVO.viewSn)
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				else
					dataArr[i] = "<option value='"+ i +"'>";	
				dataArr[i] +=  i + "</option>";
			}
			$("#SV_DIVINFVO").find("[name=viewSn]").append(dataArr);
			show_popup($("#div_svDivInf"));
			$("#SV_DIVINFVO").find("#printYnChk1").val("Y");
			$("#SV_DIVINFVO").find("#printYnChk2").val("N");
			$("input:radio[name=printYn]:input[value=" +data.spDivInfVO.printYn+"]").prop("checked", true);			
		},
		error :fn_AjaxError
	})
}

function fn_viewUpdateOptInf(svDivSn, svOptSn, prdtDivNm) {
	fn_clearOptinf();
	$.ajax({
		url : "<c:url value='/mas/sv/viewUpdateOptinf.ajax' />",
		data : "prdtNum=${SV_OPTINFVO.prdtNum}&svDivSn=" + svDivSn + "&svOptSn=" + svOptSn,
		dataType:"json",
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			$("#SV_OPTINFVO").find("[name=svDivSn]").val(data.svOptInfVO.svDivSn);
			$("#SV_OPTINFVO").find("[name=svOptSn]").val(data.svOptInfVO.svOptSn);
			$("#SV_OPTINFVO").find("[name=optNm]").val(data.svOptInfVO.optNm);
			$("#SV_OPTINFVO").find("[name=nmlAmt]").val(data.svOptInfVO.nmlAmt);
			$("#SV_OPTINFVO").find("[name=saleAmt]").val(data.svOptInfVO.saleAmt);
			$("#SV_OPTINFVO").find("[name=optPrdtNum]").val(data.svOptInfVO.optPrdtNum);
			$("#SV_OPTINFVO").find("[name=aplDt]").val(fn_addDate(data.svOptInfVO.aplDt));
			
			$("input:radio[name=dlvAmtDiv]:input[value=" +data.svOptInfVO.dlvAmtDiv+"]").prop("checked", true);
			
			if(data.svOptInfVO.dlvAmtDiv == "${Constant.DLV_AMT_DIV_MAXI}") {
				$("#SV_OPTINFVO").find("[name=cDlvAmt]").val(data.svOptInfVO.dlvAmt);
				$("#SV_OPTINFVO").find("[name=cMaxiBuyNum]").val(data.svOptInfVO.maxiBuyNum);
			}
			
			$("#span_divOpt_divNm").html(prdtDivNm);
			var dataArr = [];
			for(var i = 1; i <= maxViewSn; i++) {
				if( i == data.svOptInfVO.viewSn)
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				else
					dataArr[i] = "<option value='"+ i +"'>";	
				dataArr[i] +=  i + "</option>";
			}
			$("#SV_OPTINFVO").find("[name=viewSn]").append(dataArr);
			show_popup($("#div_svOptInf"));
			console.log(data.svOptInfVO.printYn);
			$("#SV_OPTINFVO").find("#printYnChk1").val("Y");
			$("#SV_OPTINFVO").find("#printYnChk2").val("N");
			$("input:radio[name=printYn]:input[value=" +data.svOptInfVO.printYn+"]").prop("checked", true);

			// 금액 소숫점 추가
		    $('.numFormat').each(function() {
		    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		    });

		},
		error : fn_AjaxError
	})
}
function fn_DelDivinf(svDivSn) {
	$.ajax({
		url : "<c:url value='/mas/sv/checkSvRsv.ajax' />",
		data : "prdtNum=${SV_OPTINFVO.prdtNum}&svDivSn=" + svDivSn,
		dataType:"json",
		success: function(data) {
			if(data.chkVal == "Y"){
				if(confirm("<spring:message code='common.delete.msg'/>")){
					$("#SV_DIVINFVO input[name=svDivSn]").val(svDivSn);
					document.SV_DIVINFVO.action = "<c:url value='/mas/sv/deleteDivInf.do' />";	
					document.SV_DIVINFVO.submit();
				}
			}else{
				alert("<spring:message code='fail.common.delete.exist' arguments='예약건'/>");
				return false;
			}
		},
		error : fn_AjaxError
	});
}

function fn_DelOptinf(svDivSn, svOptSn) {
	$.ajax({
		url : "<c:url value='/mas/sv/checkSvRsv.ajax' />",
		data : "prdtNum=${SV_OPTINFVO.prdtNum}&svDivSn=" + svDivSn + "&svOptSn=" + svOptSn,
		dataType:"json",
		success: function(data) {
			if(data.chkVal == "Y"){
				if(confirm("<spring:message code='common.delete.msg'/>")){
					$("#SV_OPTINFVO input[name=svDivSn]").val(svDivSn);
					$("#SV_OPTINFVO input[name=svOptSn]").val(svOptSn);
					document.SV_OPTINFVO.action = "<c:url value='/mas/sv/deleteOptInf.do' />";	
					document.SV_OPTINFVO.submit();
				}
			}else{
				alert("<spring:message code='fail.common.delete.exist' arguments='예약건'/>");
				return false;
			}
		},
		error : fn_AjaxError
	});
	
	
}

//승인요청
function fn_approvalReq() {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalReq.ajax'/>",
		data : "prdtNum=${svPrdtInf.prdtNum}",
		dataType:"json",
		success: function(data) {
			fn_goTap("OPTION");
		},
		error : fn_AjaxError
	});
}
// 승인취소하기
function fn_approvalCancel() {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalCancel.ajax'/>",
		data : "prdtNum=${svPrdtInf.prdtNum}",
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
		document.tabForm.action="<c:url value='/mas/sv/viewUpdateSv.do' />";
	} else if( menu == "IMG") {
		document.tabForm.action="<c:url value='/mas/sv/imgList.do' />";
	} else if(menu == "IMG_DETAIL") {
		document.tabForm.action="<c:url value='/mas/sv/dtlImgList.do' />";
	} else if(menu == "OPTION") {
		document.tabForm.action="<c:url value='/mas/sv/viewOption.do' />";
	} else if(menu == "ADD_OPTION") {
		document.tabForm.action="<c:url value='/mas/sv/viewAddOption.do' />";
	}
		
	document.tabForm.submit();
}


$(function() {
	if("${error}" == "Y"){
		show_popup($("#div_svOptInf"));
	}
	
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
			<form name="SV_OPTINFVO_LIST" method="post">
				<input type="hidden" name="prdtNum" value="${SV_OPTINFVO.prdtNum }" />
			<div id="contents">
				
				<h2 class="title08"><c:out value="${svPrdtInf.prdtNm}"/></h2>
				
				<div id="menu_depth3">
					<ul>
	                   <li><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
	                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
	                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
	                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('ADD_OPTION');" >추가옵션설정</a></li> 
	               </ul>	
	               <div class="btn_rt01">
	              	 	<c:if test="${Constant.TRADE_STATUS_REG eq btnApproval }">
	               		<div class="btn_sty01"><a href="javascript:fn_approvalReq();">승인요청</a></div>
	              		</c:if>
	               		<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq btnApproval }">
	               		<div class="btn_sty01"><a href="javascript:fn_approvalCancel();">승인취소</a></div>
	               		</c:if>
	               </div>
	            </div>
	               <table border="1" cellspacing="0" cellpadding="0" class="table04">
	               		<colgroup>
	               		<col width="10%" />
	               		<col />
	               		<col width="10%" />
	               		<col width="10%" />
	               		<col width="10%" />
	               		<col width="15%" />
	               		</colgroup>
	               		<tbody>
							<tr>
								<th scope="col">상품구분</th>
								<th scope="col">옵션명</th>
								<th scope="col">정상가</th>
								<th scope="col">판매가</th>
								<th scope="col">상품수</th>
								<th scope="col">관리자툴</th>
							</tr>
							<c:if test="${fn:length(resultList) == 0}">
							<!-- 데이터 없음 -->
								<tr>
									<td colspan="6" class="align_ct"><spring:message code="info.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach items="${resultList}" var="svOptInf">
							<c:choose>
							<c:when test="${empty svOptInf.optNm }">
							<tr class="tr_bg01">
								<td colspan="5"><strong><c:out value="${svOptInf.prdtDivNm}"/></strong></td>
								<td class="td_align_ct01">									
									<%--c:if test="${Constant.TRADE_STATUS_REG eq svPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq svPrdtInf.tradeStatus or Constant.TRADE_STATUS_EDIT eq svPrdtInf.tradeStatus}"--%>
										<div class="btn_sty06"><span><a href="javascript:fn_viewUpdateDivinf('${svOptInf.svDivSn}')">수정</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_DelDivinf('${svOptInf.svDivSn}')">삭제</a></span></div>
										<div class="btn_sty06"><span><a href="javascript:fn_viewOptInf('${svOptInf.svDivSn}', '${svOptInf.prdtDivNm}')">옵션추가</a></span></div>
									<%--/c:if--%>
								</td>
							</tr>
							</c:when>
							<c:otherwise>
							<tr>
									<td></td>
									<td class="td_align_lt01"><c:out value="${svOptInf.optNm }" /></td>
									<td class="td_align_rt01"><fmt:formatNumber value="${svOptInf.nmlAmt}"  type="number"/></td>
									<td class="td_align_rt01"><fmt:formatNumber value="${svOptInf.saleAmt}"  type="number"/></td>
									<td class="td_align_ct01"><fmt:formatNumber value="${svOptInf.optPrdtNum}"  type="number"/></td>
									<td class="td_align_ct01">
										<%--c:if test="${Constant.TRADE_STATUS_REG eq svPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq svPrdtInf.tradeStatus  or  Constant.TRADE_STATUS_EDIT eq svPrdtInf.tradeStatus}" --%>
										<div class="btn_sty06"><span><a href="javascript:fn_viewUpdateOptInf('${svOptInf.svDivSn}', '${svOptInf.svOptSn}', '${svOptInf.prdtDivNm}')">수정</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_DelOptinf('${svOptInf.svDivSn}', '${svOptInf.svOptSn}' )">삭제</a></span></div>
										<%--/c:if --%>
									</td>
							</tr>
							</c:otherwise>
							</c:choose>
							</c:forEach>
						</tbody>
				</table>
				<div class="btn-fixed">
					<%-- c:if test="${Constant.TRADE_STATUS_REG eq svPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq svPrdtInf.tradeStatus  or  Constant.TRADE_STATUS_EDIT eq svPrdtInf.tradeStatus}"--%>
					<ul class="btn_lt01">
						<li class="btn_sty04"><a href="javascript:fn_viewDivinf()">상품구분추가</a></li>
					</ul>
					<%-- /c:if--%>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty01">
							<a href="javascript:fn_PrdtList()">목록</a>
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
	<input type="hidden" name="prdtNum"  value="${SV_OPTINFVO.prdtNum }"/>
	<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>
</form>
<div class="blackBg"></div>

<div id="div_svDivInf" class="lay_popup lay_ct"  style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_svDivInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
           	<form:form commandName="SV_DIVINFVO"  name="SV_DIVINFVO" method="post" onsubmit="return false" >
			<input type="hidden" name="prdtNum" value="${SV_OPTINFVO.prdtNum }" />
			<input type="hidden" name="svDivSn" />
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
		         	<td><form:input path="prdtDivNm" class="input_text_full"  maxlength="30" /></td>
		         </tr>
		         <tr>
		         	<th>노출순번</th>
		         	<td>
		         		<form:select path="viewSn">
		         		</form:select>
		         	</td>
		         </tr>
			 	 <tr>
				 	<th>노출여부<span class="font_red">*</span></th>
					<td>
						<input type="radio" id="printYnChk1" name="printYn" value=" Y " checked />
						<label for="printYnChk1">노출</label>
						<input type="radio" id="printYnChk2" name="printYn" value=" N "/>
						<label for="printYnChk2">비노출</label>
					</td>
				 </tr>		         
			</table>
			</form:form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertDivInf();">저장</a></span></div>
</div>

<div id="div_svOptInf" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_svOptInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
		<form:form commandName="SV_OPTINFVO"  name="SV_OPTINFVO" method="post" onSubmit="return false">
		<input type="hidden" name="prdtNum" value="${SV_OPTINFVO.prdtNum }" />
		<input type="hidden" name="svDivSn" />
		<input type="hidden" name="svOptSn" />
		<input type="hidden" name="dlvAmt" id="dlvAmt" />
		<input type="hidden" name="inDlvAmt" id="inDlvAmt" />
		<input type="hidden" name="maxiBuyNum" id="maxiBuyNum" />
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
	         
	         <tr>
	         	<th>옵션명<span class="font_red">*</span></th>
	         	<td>
	         		<form:input path="optNm" id="optNm" class="input_text_full" maxlength="88" value="${svOptInfo.optNm}"/>
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
	         	<th rowspan="4">배송비<span class="font_red">*</span></th>
	         	<td><label>
						<input type="radio" name="dlvAmtDiv" value="${Constant.DLV_AMT_DIV_DLV}"/>
							<span>도외배송비(<fmt:formatNumber>${corpDlvAmtVO.dlvAmt}</fmt:formatNumber>원)</span>
							<span>도내배송비(<fmt:formatNumber>${corpDlvAmtVO.inDlvAmt}</fmt:formatNumber>원)</span>
					</label>
				</td>
	         </tr>
	         <tr>
	         	<td><label>
					<input type="radio" name="dlvAmtDiv" value="${Constant.DLV_AMT_DIV_APL}"/>
					<span>조건부무료(<fmt:formatNumber>${corpDlvAmtVO.aplAmt}</fmt:formatNumber>원 이상 구매 시 무료)</span>
					</label>
				</td>
	         </tr>
	         <tr>
	         	<td>
					<label>
						<input type="radio" name="dlvAmtDiv" value="${Constant.DLV_AMT_DIV_MAXI}"/>
						<span>개별배송비&nbsp;
							<input type="text" name="cMaxiBuyNum" id="cMaxiBuyNum" class="input_text2 numFormat"/>&nbsp;개당&nbsp;<input type="text" name="cDlvAmt" id="cDlvAmt" class="input_text7 numFormat"/>
						</span>
					</label>
				</td>
	         </tr>
	         <tr>
	         	<td>
					<label>
						<input type="radio" name="dlvAmtDiv" value="${Constant.DLV_AMT_DIV_FREE}"/>
						<span>무료</span>
					</label>
				</td>
	         </tr>
	         <tr>
	         	<th>상품수<span class="font_red">*</span></th>
	         	<td><form:input path="optPrdtNum"  class="input_text10 numFormat"/>
	         		<form:errors path="optPrdtNum"  cssClass="error_text"/>
	         	</td>
	         </tr>
			<tr>
				<th>상품노출여부<span class="font_red">*</span></th>
				<td>
					<input type="radio" id="printYnChk1" name="printYn" value=" Y " checked />
					<label for="printYnChk1">노출</label>
					<input type="radio" id="printYnChk2" name="printYn" value=" N "/>
					<label for="printYnChk2">비노출</label>
				</td>
			 </tr>
		</table>
		</form:form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertOptInf();">저장</a></span></div>
</div>
</body>
</html>