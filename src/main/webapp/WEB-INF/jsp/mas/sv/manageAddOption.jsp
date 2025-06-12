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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<validator:javascript formName="SV_ADDOPTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<title></title>

<script type="text/javascript">
function fn_viewInsertAddOpt() {
	fn_clearAddOpt();
	$.ajax({
		dataType:"json",
		url : "<c:url value='/mas/sv/getAddOptMaxViewSn.ajax' />",
		data : "prdtNum=${svPrdtInf.prdtNum}",
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
			$("#SV_ADDOPTINFVO").find("[name=viewSn]").append(dataArr);
			show_popup($("#div_svAddOptInf"));
		},
		error :fn_AjaxError
	});
}

function fn_InsertAddOptInf(){
	// 콤마 제거
	delCommaFormat();
	
	// validation 체크
	if(!validateSV_ADDOPTINFVO(document.SV_ADDOPTINFVO)){
		return;
	}
	
	if(parseInt($("#addOptAmt").val()) <= 0) {
		alert("추가금액은 0보다 커야 합니다.");
		$("#addOptAmt").focus();
		return ;
	}

	var tempOptSn = $("#SV_ADDOPTINFVO").find("[name=addOptSn]").val();
	if(tempOptSn == "")
		document.SV_ADDOPTINFVO.action = "<c:url value='/mas/sv/insertAddOption.do' />";
	else
		document.SV_ADDOPTINFVO.action = "<c:url value='/mas/sv/updateAddOption.do' />";
	document.SV_ADDOPTINFVO.submit();
}

function fn_viewUpdateAddOpt(addOptSn) {
	fn_clearAddOpt();
	$.ajax({
		url : "<c:url value='/mas/sv/viewUpdateAddOpt.ajax' />",
		data : "prdtNum=${svPrdtInf.prdtNum}&addOptSn=" + addOptSn,
		dataType:"json",
		success: function(data) {
			var maxViewSn = data.maxViewSn;
			$("#SV_ADDOPTINFVO").find("[name=addOptSn]").val(data.svOptInfVO.addOptSn);
			$("#SV_ADDOPTINFVO").find("[name=addOptNm]").val(data.svOptInfVO.addOptNm);
			$("#SV_ADDOPTINFVO").find("[name=addOptAmt]").val(data.svOptInfVO.addOptAmt);
			var dataArr = [];
			for(var i = 1; i <= maxViewSn; i++) {
				if( i == data.svOptInfVO.viewSn)
					dataArr[i] = "<option value='"+ i +"' selected='selected'>";
				else
					dataArr[i] = "<option value='"+ i +"'>";	
				dataArr[i] +=  i + "</option>";
			}
			$("#SV_ADDOPTINFVO").find("[name=viewSn]").append(dataArr);
			show_popup($("#div_svAddOptInf"));
			
			// 금액 소숫점 추가
		    $('.numFormat').each(function() {
		    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		    });
		},
		error : fn_AjaxError
	})
}

function fn_DelAddOpt(addOptSn) {
	if(confirm("<spring:message code='common.delete.msg'/>")){
		$("#SV_ADDOPTINFVO input[name=addOptSn]").val(addOptSn);
		document.SV_ADDOPTINFVO.action = "<c:url value='/mas/sv/deleteAddOpt.do' />";	
		document.SV_ADDOPTINFVO.submit();
	}
}

function fn_clearAddOpt() {
	$("#SV_ADDOPTINFVO").find("[name=viewSn] option").remove();
	$("#SV_ADDOPTINFVO input:not([name=prdtNum])").val("");
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

//승인요청
function fn_approvalReq() {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalReq.ajax'/>",
		data : "prdtNum=${svPrdtInf.prdtNum}",
		success: function(data) {
			fn_goTap("ADD_OPTION");
		},
		error : fn_AjaxError
	})
}
// 승인취소하기
function fn_approvalCancel() {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalCancel.ajax'/>",
		data : "prdtNum=${svPrdtInf.prdtNum}",
		success: function(data) {
			fn_goTap("ADD_OPTION");
		},
		error : fn_AjaxError
	})
}

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
			<form name="SV_ADDOPTINFVO_LIST" method="post">
				<input type="hidden" name="prdtNum" value="${svPrdtInf.prdtNum }" />
			<div id="contents">
				
				<h2 class="title08"><c:out value="${svPrdtInf.prdtNm}"/></h2>
				
				<div id="menu_depth3">
					<ul>
	                   <li><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
	                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
	                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
	                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('ADD_OPTION');" >추가옵션설정</a></li>
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
               <table border="1" cellspacing="0" cellpadding="0" class="table01">
               		<colgroup>
               		<col width="10%" />
               		<col />
               		<col width="10%" />
               		<col width="15%" />
               		</colgroup>
               		<tbody>
						<tr>
							<th scope="col">#</th>
							<th scope="col">추가옵션명</th>
							<th scope="col">금액</th>
							<th scope="col">관리자툴</th>
						</tr>
						<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="4" class="align_ct"><spring:message code="info.nodata.msg" /></td>
						</tr>
						</c:if>
						<c:forEach items="${resultList}" var="sAddOptInf" varStatus="status">
						<tr>
							<td class="align_ct">${status.count}</td>
							<td class="align_lt"><c:out value="${sAddOptInf.addOptNm}"/></td>
							<td class="align_rt"><fmt:formatNumber>${sAddOptInf.addOptAmt}</fmt:formatNumber></td>
							<td class="align_ct">
								<%--c:if test="${Constant.TRADE_STATUS_REG eq svPrdtInf.tradeStatus or  Constant.TRADE_STATUS_APPR_REQ eq svPrdtInf.tradeStatus  or  Constant.TRADE_STATUS_EDIT eq svPrdtInf.tradeStatus}"  --%>
									<div class="btn_sty06"><span><a href="javascript:fn_viewUpdateAddOpt('${sAddOptInf.addOptSn}')">수정</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_DelAddOpt('${sAddOptInf.addOptSn}')">삭제</a></span></div>
								<%-- /c:if --%>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="javascript:fn_viewInsertAddOpt()">등록</a></li>
				</ul>
			</div>
		</form>
		</div>
	</div>
</div>
<form name="tabForm" method="get">
	<input type="hidden" name="prdtNum"  value="${svPrdtInf.prdtNum }"/>
	<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>
</form>
<div class="blackBg"></div>

<div id="div_svAddOptInf" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_svAddOptInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
		<form:form commandName="SV_ADDOPTINFVO"  name="SV_ADDOPTINFVO" method="post" onSubmit="return false">
		<input type="hidden" name="prdtNum" value="${svPrdtInf.prdtNum }" />
		<input type="hidden" name="addOptSn" />
		<table border="1" class="table02">
			<caption class="tb02_title">
				상품 추가옵션<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
			</caption>
			<colgroup>
	             <col width="33%" />
	             <col width="65%" />
	         </colgroup>
	         <tr>
	         	<th>추가옵션명<span class="font_red">*</span></th>
	         	<td><form:input path="addOptNm"  id="addOptNm"  class="input_text_full" /></td>
	         </tr>
	         <tr>
	         	<th>추가금액<span class="font_red">*</span></th>
	         	<td>
	         		<form:input path="addOptAmt"  id="addOptAmt" class="input_text5 numFormat" />
	         	</td>
	         </tr>
	         <tr>
	         	<th>노출순번<span class="font_red">*</span></th>
	         	<td>
	         		<form:select path="viewSn">
	         		</form:select>
	         		<form:errors path="viewSn"  cssClass="error_text"/>
	         	</td>
	         </tr>
		</table>
		</form:form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsertAddOptInf();">저장</a></span></div>
</div>
</body>
</html>