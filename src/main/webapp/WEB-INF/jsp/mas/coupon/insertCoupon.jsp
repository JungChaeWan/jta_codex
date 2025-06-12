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
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<validator:javascript formName="CPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_couponList() {
	document.CPVO.action = "<c:url value='/oss/couponList.do' />";
	document.CPVO.submit();
}
/*
 * 쿠폰추가
 */
function fn_insertCoupon() {
	// 콤마 제거
	delCommaFormat();
	
	if(!validateCPVO(document.CPVO)){
		return;
	}	
	
	var prdtNumList = [];
	$("input[name='prdtNum']").each(function () {
		prdtNumList.push($(this).val());
	});
	$("#prdtNumList").val(prdtNumList.toString());
	
	if ($("#prdtNumList").val() == "" ) {
		alert("적용 상품은 필수 선택 사항입니다..");
		return	;
	}
	
	if($('#disDivPrice').prop('checked') && Number($("#buyMiniAmt").val()) <= Number($("#disAmt").val())) {
		alert("구매최소금액이 할인금액보다 커야 합니다.");
		$("#disAmt").focus();
		return ;
	}
	
	if($('#disDivRate').prop('checked') && $("#disPct").val() == "") {
		alert("구매최소금액이 할인금액보다 커야 합니다.");
		$("#disAmt").focus();
		return ;
	}
	
	$("#aplStartDt").val($('#aplStartDt').val().replace(/-/g, ""));
	$("#aplEndDt").val($('#aplEndDt').val().replace(/-/g, ""));
	
	document.CPVO.action= "<c:url value='/mas/insertCoupon.do'/>";
	document.CPVO.submit();
}

function fn_aplPct() {
	if ($('#aplPctBtn').hasClass('disabled'))
		return false;
	
	if($("#aplPct").val() != 0) {
		var saleMinAmt = Number($("#disAmt").val()) * (100 / Number($("#aplPct").val()) );
		$("#buyMiniAmt").val(saleMinAmt);
	} else {
		$("#buyMiniAmt").val(0);
	}
}

function fn_viewSelectProduct() {
	var retVal = window.open("<c:url value='/oss/findPrdt.do?sCorpId=${CPVO.corpId}'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSoProduct() {
	var retVal = window.open("<c:url value='/oss/findSpPrdt.do?sCorpId=${CPVO.corpId}'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSvProduct() {
	var retVal = window.open("<c:url value='/oss/findSvPrdt.do?sCorpId=${CPVO.corpId}'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectProduct(prdtId, corpNm, prdtNm) {
	var strHtml = "";
	strHtml =	'<li>' + '['+prdtId+']['+corpNm+']['+prdtNm+']';	
	strHtml +=	' <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>'; 
	strHtml +=	'<input type="hidden" name="prdtNum" value="'+ prdtId + '"/>';
	strHtml += '</li>';
	$("#selectProduct ul").append(strHtml);
}

function fn_Dummay(){
}

$(function() {
	$("#aplStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#aplEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#aplEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleStartDt").datepicker("option", "maxDate",selectedDate);
		}
	});
	
	$("#disAmt").keyup(function() {
		if($("#disPct").val() != 0) {
			var amt = $(this).val();
			var saleMinAmt = Number(amt) * (100 / Number($("#aplPct").val()) );
			$("#buyMiniAmt").val(saleMinAmt);
		}
	});		
	
	$("#selectProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
		var prdtNumList = [];
		$("input[name='prdtNum']").each(function () {
			prdtNumList.push($(this).val());
		});
		$("#prdtNumList").val(prdtNumList.toString());
	});
	
	$("#disDivPrice").click(function() {
		$('#disAmt').val(0).removeClass('disabled').attr("readonly", false);
		$('#aplPctBtn').removeClass('disabled');
		$('#disPct').val(0).addClass('disabled').attr("readonly", true);
		
		// 적용 상품 초기화
		$('.del').each(function() {
			$(this).click();
		});
	});
	
	$("#disDivRate").click(function() {
		$('#disAmt').val(0).addClass('disabled').attr("readonly", true);
		$('#aplPctBtn').addClass('disabled');
		$('#disPct').val(0).removeClass('disabled').attr("readonly", false);		
		
		// 적용 상품 초기화
		$('.del').each(function() {
			$(this).click();
		});
	});
	
	$("#disDivPrice").click();
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">		
		<div id="contents_area">
			<form:form commandName="CPVO"  name="CPVO" method="post"  enctype="multipart/form-data">
			<form:hidden path="corpId"/>			
			<input type="hidden" name="linkNum" />
			<div id="contents">
				<h4 class="title03">쿠폰 등록</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
			         	<th>쿠폰ID</th>
			         	<td>자동발행</td>
			         	<th>발행상태</th>
			         	<td>
			         		발행대기
			         		<input type="hidden" name="statusCd" id="statusCd" value="${Constant.STATUS_CD_READY }" />
			         	
			         	</td>
			         </tr>
			         <tr>
			         	<th>쿠폰명<span class="font02">*</span></th>
			         	<td colspan="3">
			         		<form:input path="cpNm" class="input_text_full"/>
			         		<form:errors path="cpNm"  cssClass="error_text" />
			         	</td>
			         </tr>
			         <tr>
			         	<th>적용기간<span class="font02">*</span></th>
			         	<td colspan="3">
			         		<form:input path="aplStartDt" class="input_text4 center"  title="적용시작일" readonly="true" /> ~ <form:input path="aplEndDt" class="input_text4 center" title="적용종료일" readonly="true" />
			         	</td>
			         </tr>
			         <tr>
			         	<th>할인방식<span class="font02">*</span></th>
			         	<td colspan="3">
			         		<input type="radio" name="disDiv" id="disDivPrice" value="${Constant.CP_DIS_DIV_PRICE}" checked> 금액</input>&nbsp;<form:input path="disAmt" id="disAmt" class="input_text10 right numFormat" value="0"/> 원
			         		<!-- <input type="text" name="aplPct" id="aplPct" class="input_text4 right"  title="적용요율" value="0"/> %
			         		<div class="btn_sty06" id="aplPctBtn">
								<span><a href="javascript:fn_aplPct();">적용</a></span>
							</div> -->&nbsp;
			         		<input type="radio" name="disDiv" id="disDivRate" value="${Constant.CP_DIS_DIV_RATE}"> 할인율</input>&nbsp;<form:input path="disPct" id="disPct" class="input_text10 right" value="0" /> %
			         	</td>
			         </tr>
			         <tr>
			         	<th>구매 최소 금액</th>
			         	<td colspan="3">
			         		<form:input path="buyMiniAmt" id="buyMiniAmt" class="input_text10 right numFormat"/> 원
			         	</td>
			         </tr>
			         <tr>
			         	<th>이미지</th>
			         	<td colspan="3">
			         		<input type="file" id="imgPathFile" name="imgPathFile" accept="image/*" style="width: 70%" />
			         		<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
			         	</td>
			         </tr>
			         <tr>
			         	<th>간략설명</th>
			         	<td colspan="3"><textarea name="simpleExp" id="simpleExp" rows="10"  style="width:97%"></textarea>
			         	<form:errors path="simpleExp"  cssClass="error_text" />
			         	</td>
			         </tr>
			         <tr>
			         	<th rowspan='2'>적용상품<span class="font02">*</span></th>			         				         	
			         	<td colspan="3">			         	
			         		<input type="hidden" name="aplprdtDiv" id="aplprdtDivPrdt" value="${Constant.CP_APLPRDT_DIV_PRDT}" />
			         		<span id="selPrdtBtn">
			         			<div class="btn_sty04">
			         				<c:if test="${corpCd==Constant.ACCOMMODATION or corpCd==Constant.RENTCAR}">
									<span><a href="javascript:fn_viewSelectProduct();">상품검색</a></span>
									</c:if>
									<c:if test="${corpCd==Constant.SOCIAL}">
									<span><a href="javascript:fn_viewSelectSoProduct();">상품검색</a></span>
									</c:if>
									<c:if test="${corpCd==Constant.SV}">
									<span><a href="javascript:fn_viewSelectSvProduct();">상품검색</a></span>
									</c:if>
								</div>
								<input type="hidden" name="prdtNumList" id="prdtNumList"/>
							</span>
			         	</td>
			         </tr>
			         <tr>
						<td colspan="3">
						<div id="selectProduct">
							<ul>
							</ul>
						</div>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:fn_insertCoupon()">저장</a></li>
					<li class="btn_sty01"><a href="javascript:fn_couponList()">목록</a></li>
				</ul>
			</div>
			</form:form>
		</div>
	<!--//Contents 영역--> 
	</div>
</div>
</body>
</html>
		