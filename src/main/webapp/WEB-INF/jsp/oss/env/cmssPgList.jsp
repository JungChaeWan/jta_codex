<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/cmssPgList.do'/>";
	document.frm.submit();
}

/** 등록 레이어팝업 */
function fn_InsCmssPgLay(){
	show_popup($("#lay_popup"));
}

/** 등록  */
function fn_InsCmssPg(){
 	if($('#insAplStartDt').val().length == 0){
		alert("적용 시작 일자를 입력하세요.");
		$('#insAplStartDt').focus();
		return;
	}
	
	if($('#insAplEndDt').val().length == 0){
		alert("적용 종료 일자를 입력하세요.");
		$('#insAplEndDt').focus();
		return;
	}
	
	if($('#insPgCmssDiv').val() == "CM00"){
		if($('#insPgCmssPer').val().length == 0){
			alert("수수료율을 입력하세요.");
			$('#insPgCmssPer').focus();
			return;
		}
	}else{
		if($('#insPgCmssAmt').val().length == 0){
			alert("수수료금액을 입력하세요.");
			$('#insPgCmssAmt').focus();
			return;
		}
	}

	let pgDivSeq = '';
	let pgDiv = $('#insPgDiv').val();
	let aplStartDt = $('#insAplStartDt').val().replace(/-/g, '');
	let aplEndDt = $('#insAplEndDt').val().replace(/-/g, '');

	let returnVal = fn_CheckAplDt(pgDiv, pgDivSeq, aplStartDt, aplEndDt);
	
	if(returnVal == "N"){
		var parameters = "pgDiv=" + $("#insPgDiv").val();
		parameters += "&aplStartDt=" + $("#insAplStartDt").val().replace(/-/g, "");
		parameters += "&aplEndDt=" + $("#insAplEndDt").val().replace(/-/g, "");
		parameters += "&pgCmssDiv=" + $("#insPgCmssDiv").val();
		parameters += "&pgCmssPer=" + $("#insPgCmssPer").val();
		parameters += "&pgCmssAmt=" + $("#insPgCmssAmt").val();
		parameters += "&minCmss=" + $("#insMinCmss").val();
	
	 	$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/insertCmssPg.ajax'/>",
			data:parameters ,
			success:function(data){
				alert("PG사 수수료가 등록되었습니다.");
				document.frm.action = "<c:url value='/oss/cmssPgList.do'/>";
				document.frm.submit();
			}
		});
	}
}

/** 수정 클릭 시 레이어팝업 단건 조회 */
function fn_UdtCmssPgLay(pgDiv, pgDivSeq){
 	
	var parameters = "pgDiv=" + pgDiv;
	parameters += "&pgDivSeq=" + pgDivSeq;
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/selectByCmssPg.ajax'/>",
		data:parameters ,
		success:function(data){
			
  			$("#udtPgDiv").val(data.cmssPgVO.pgDiv);
			$("#udtPgDivSeq").val(data.cmssPgVO.pgDivSeq);
			$("#udtAplStartDt").val(data.cmssPgVO.aplStartDt);
			$("#udtAplEndDt").val(data.cmssPgVO.aplEndDt);
			$("#udtPgCmssPer").val(data.cmssPgVO.pgCmssPer);
			$("#udtPgCmssAmt").val(data.cmssPgVO.pgCmssAmt);
			$("#udtMinCmss").val(data.cmssPgVO.minCmss);
			$("#udtPgCmssDiv").val(data.cmssPgVO.pgCmssDiv);

			show_popup($("#lay_popup2"));
			
			if(data.cmssPgVO.pgCmssDiv == "CM00"){
				 $('#udtCmssPer').attr('style', "");
				 $('#udtCmssAmt').attr('style', "display:none;");
				 $('#udtCmssMin').attr('style', "display:none;");
			}else{
				 $('#udtCmssPer').attr('style', "display:none;");
				 $('#udtCmssAmt').attr('style', "");
				 $('#udtCmssMin').attr('style', "");				 
			}
		}
	});
}

/** 수정 */
function fn_UdtCmssPg(){
	if($('#udtPgCmssDiv').val() == "CM00"){
		if($('#udtPgCmssPer').val().length == 0){
			alert("수수료율을 입력하세요.");
			$('#udtPgCmssPer').focus();
			return;
		}
	}else{
		if($('#udtPgCmssAmt').val().length == 0){
			alert("수수료금액을 입력하세요.");
			$('#udtPgCmssAmt').focus();
			return;
		}
	}
	
	let pgDiv = $('#udtPgDiv').val();
	let pgDivSeq = $('#udtPgDivSeq').val();
	let aplStartDt = $('#udtAplStartDt').val().replace(/-/g, '');
	let aplEndDt = $('#udtAplEndDt').val().replace(/-/g, '');
	
	let returnVal = fn_CheckAplDt(pgDiv, pgDivSeq, aplStartDt, aplEndDt);
	
	if(returnVal == "N"){
		var parameters = "pgDiv=" + $("#udtPgDiv").val();
		parameters += "&pgDivSeq=" + $("#udtPgDivSeq").val();
		parameters += "&aplStartDt=" + $("#udtAplStartDt").val().replace(/-/g, '');
		parameters += "&aplEndDt=" + $("#udtAplEndDt").val().replace(/-/g, '');
		parameters += "&pgCmssPer=" + $("#udtPgCmssPer").val();
		parameters += "&pgCmssAmt=" + $("#udtPgCmssAmt").val();
		parameters += "&minCmss=" + $("#udtMinCmss").val();
		
	 	$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/updateCmssPg.ajax'/>",
			data:parameters ,
			success:function(data){
				alert("수수료가 수정되었습니다.");
				document.frm.action = "<c:url value='/oss/cmssPgList.do'/>";
				document.frm.submit();
			}
		});
	}
}

/** 삭제 */
function fn_DelCmssPg(pgDiv, pgDivSeq){
	var parameters = "pgDiv=" + pgDiv;
	parameters += "&pgDivSeq=" + pgDivSeq;
	
	if(confirm('해당일자의 수수료율을 삭제하시겠습니까?')){
		$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/deleteCmssPg.ajax'/>",
			data:parameters ,
			success:function(data){
				alert("수수료가 삭제 되었습니다.");
				
				document.frm.action = "<c:url value='/oss/cmssPgList.do'/>";
				document.frm.submit();
			}
		});
	}	
}

function fn_CheckAplDt(pgDiv, pgDivSeq, aplStartDt, aplEndDt){
	
	var parameters = "pgDiv=" + pgDiv;
	parameters += "&pgDivSeq=" + pgDivSeq;
	parameters += "&aplStartDt=" + aplStartDt;
	parameters += "&aplEndDt=" + aplEndDt;
	
	var chkYN = "";
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/checkAplDt.do'/>",
		data:parameters ,
		success:function(data){
			if(data.chkVal > 0){
				alert("해당 날짜의 수수료 적용 기간이 이미 존재합니다.");
				chkYN = "Y";
			}else{
				chkYN = "N";
			}
		}
	});
	return chkYN ;
}

function fn_setLastTmEnd(){
	$("#insAplEndDt").val("9999-12-31");
}

$(document).ready(function(){
	$("#insAplStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#insAplEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#insAplEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#insAplStartDt").datepicker("option", "maxDate",selectedDate);
		}
	});
	
	$("#udtAplStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#udtAplEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#udtAplEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#udtAplStartDt").datepicker("option", "maxDate",selectedDate);
		}
	});
	
 	 $('#insPgCmssDiv').change(function() {
		 if($('#insPgCmssDiv').val() == "CM00"){
			 $('#insCmssPer').attr('style', "");
			 $('#insCmssAmt').attr('style', "display:none;");
			 $('#insCmssMin').attr('style', "display:none;");
			 $('#insPgCmssAmt').val('');
			 $('#insMinCmss').val('');
		 }else {
			 $('#insCmssPer').attr('style', "display:none;");
			 $('#insCmssAmt').attr('style', "");			 
			 $('#insCmssMin').attr('style', "");
			 $('#insPgCmssPer').val('');
		 }
	 });
});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=cmssPg" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<h4 class="title03">PG사 수수료 관리</h4>
				<div class="search_box">
	            	<div class="search_form">
	                	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
	                                <col width="100" />
	                                <col width="*" />
	                            </colgroup>
	             				<tbody>
	             					<tr>
	               						<th scope="row">결제 구분</th>
	               						<td>
	               							<select name="sPgDiv" id="sPgDiv">
	               								<option value="">전체</option>
	               								<option value="${Constant.PAY_DIV_LG_CI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_CI}">selected="selected"</c:if>>카드결제</option>
	               								<option value="${Constant.PAY_DIV_LG_HI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_HI}">selected="selected"</c:if>>휴대폰결제</option>
	               								<option value="${Constant.PAY_DIV_LG_TI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_TI}">selected="selected"</c:if>>계좌이체</option>
	               								<option value="${Constant.PAY_DIV_LG_ETI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_ETI}">selected="selected"</c:if>>계좌이체(에스크로)</option>
	               								<option value="${Constant.PAY_DIV_LG_MI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_MI}">selected="selected"</c:if>>무통장입금</option>
	               								<option value="${Constant.PAY_DIV_LG_EMI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_EMI}">selected="selected"</c:if>>무통장이체(에스크로)</option>
	               								<option value="${Constant.PAY_DIV_LG_KI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_KI}">selected="selected"</c:if>>카카오페이 결제</option>
	               								<option value="${Constant.PAY_DIV_LG_FI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_FI}">selected="selected"</c:if>>무료쿠폰 결제</option>
	               								<option value="${Constant.PAY_DIV_LG_LI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_LI}">selected="selected"</c:if>>L.Point결제</option>
												<option value="${Constant.PAY_DIV_NV_SI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_NV_SI}">selected="selected"</c:if>>스마트스토어</option>
												<option value="${Constant.PAY_DIV_NV_LI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_NV_LI}">selected="selected"</c:if>>라이브커머스</option>
												<option value="${Constant.PAY_DIV_TC_WI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_TC_WI}">selected="selected"</c:if>>탐나는전 PC결제</option>
												<option value="${Constant.PAY_DIV_TC_MI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_TC_MI}">selected="selected"</c:if>>탐나는전 모바일결제</option>
												<option value="${Constant.PAY_DIV_TA_PI}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_TA_PI}">selected="selected"</c:if>>포인트결제</option>
												<option value="${Constant.PAY_DIV_LG_NP}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_NP}">selected="selected"</c:if>>네이버페이</option>
												<option value="${Constant.PAY_DIV_LG_KP}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_KP}">selected="selected"</c:if>>카카오페이</option>
												<option value="${Constant.PAY_DIV_LG_AP}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_AP}">selected="selected"</c:if>>애플페이</option>
												<option value="${Constant.PAY_DIV_LG_TP}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_TP}">selected="selected"</c:if>>토스페이</option>
												<option value="${Constant.PAY_DIV_LG_MN}" <c:if test="${searchVO.sPgDiv eq Constant.PAY_DIV_LG_MN}">selected="selected"</c:if>>관리자</option>
	               							</select>
	               						</td>
	               						<th scope="row">수수료 구분</th>
	               						<td>
	               							<select name="sPgCmssDiv" id="sPgCmssDiv">
	               								<option value="">전체</option>
	               								<c:forEach items="${comCdList}" var="comCd">
	               								<option value="${comCd.cdNum}" <c:if test="${comCd.cdNum eq searchVO.sPgCmssDiv}">selected="true"</c:if>><c:out value="${comCd.cdNm}" /></option>
	               								</c:forEach>
	               							</select>
	               						</td>
	               					</tr>
	     						</tbody>
	               			</table>
	               		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
	              	</div>
	            </div>
				<!--검색-->
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table id="mainGrid" width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>번호</th>
							<th>결제구분</th>
							<th>시작일자</th>
							<th>종료일자</th>
							<th>수수료구분</th>
							<th>수수료율</th>
							<th>수수료금액</th>							
							<th>기능툴</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="8" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">
									<c:if test="${Constant.PAY_DIV_LG_CI eq result.pgDiv}">카드결제</c:if>
									<c:if test="${Constant.PAY_DIV_LG_HI eq result.pgDiv}">휴대폰결제</c:if>
									<c:if test="${Constant.PAY_DIV_LG_TI eq result.pgDiv}">계좌이체</c:if>
									<c:if test="${Constant.PAY_DIV_LG_ETI eq result.pgDiv}">계좌이체(에스크로)</c:if>
									<c:if test="${Constant.PAY_DIV_LG_MI eq result.pgDiv}">무통장입금</c:if>
									<c:if test="${Constant.PAY_DIV_LG_EMI eq result.pgDiv}">무통장이체(에스크로)</c:if>
									<c:if test="${Constant.PAY_DIV_LG_KI eq result.pgDiv}">카카오페이 결제</c:if>
									<c:if test="${Constant.PAY_DIV_LG_FI eq result.pgDiv}">무료쿠폰 결제</c:if>
									<c:if test="${Constant.PAY_DIV_LG_LI eq result.pgDiv}">L.Point결제</c:if>
									<c:if test="${Constant.PAY_DIV_NV_SI eq result.pgDiv}">스마트스토어</c:if>
									<c:if test="${Constant.PAY_DIV_NV_LI eq result.pgDiv}">라이브커머스</c:if>
									<c:if test="${Constant.PAY_DIV_TC_WI eq result.pgDiv}">탐나는전 PC결제</c:if>
									<c:if test="${Constant.PAY_DIV_TC_MI eq result.pgDiv}">탐나는전 모바일결제</c:if>
									<c:if test="${Constant.PAY_DIV_TA_PI eq result.pgDiv}">포인트결제</c:if>
									<c:if test="${Constant.PAY_DIV_LG_NP eq result.pgDiv}">네이버페이</c:if>
									<c:if test="${Constant.PAY_DIV_LG_KP eq result.pgDiv}">카카오페이</c:if>
									<c:if test="${Constant.PAY_DIV_LG_AP eq result.pgDiv}">애플페이</c:if>
									<c:if test="${Constant.PAY_DIV_LG_TP eq result.pgDiv}">토스페이</c:if>
									<c:if test="${Constant.PAY_DIV_LG_MN eq result.pgDiv}">관리자</c:if>
								</td>
								<td class="align_ct">
									<fmt:parseDate value="${result.aplStartDt}" var="aplStartDt" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${aplStartDt}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<c:choose>
										<c:when test="${result.aplEndDt eq '99991231'}">종료일 없음</c:when>
										<c:otherwise>
											<fmt:parseDate value="${result.aplEndDt}" var="aplEndDt" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${aplEndDt}" pattern="yyyy-MM-dd"/>
										</c:otherwise>
									</c:choose>
								</td>
                                <td class="align_ct">
									<c:forEach var="code" items="${comCdList}" varStatus="status">
										<c:if test="${result.pgCmssDiv eq code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
									</c:forEach>
                                </td>								
								<td class="align_ct">${result.pgCmssPer}%</td>
								<td class="align_ct">${result.pgCmssAmt}원</td>								
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_UdtCmssPgLay('${result.pgDiv}','${result.pgDivSeq}')">수정</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_DelCmssPg('${result.pgDiv}','${result.pgDivSeq}')">삭제</a></span></div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_InsCmssPgLay();">등록</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<form name="insCmssPgFrm">
		<ul class="form_area">
			<li>
				<table border="1" class="table02" >
  					<caption class="tb01_title">PG사 수수료관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>결제방식 구분<span class="font02">*</span></th>
						<td>
							<select name="pgDiv" id="insPgDiv">					
   								<option value="${Constant.PAY_DIV_LG_CI}">카드결제</option>
   								<option value="${Constant.PAY_DIV_LG_HI}">휴대폰결제</option>
   								<option value="${Constant.PAY_DIV_LG_TI}">계좌이체</option>
   								<option value="${Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</option>
   								<option value="${Constant.PAY_DIV_LG_MI}">무통장입금</option>
   								<option value="${Constant.PAY_DIV_LG_EMI}">무통장이체(에스크로)</option>
   								<option value="${Constant.PAY_DIV_LG_KI}">카카오페이(구) 결제</option>
   								<option value="${Constant.PAY_DIV_LG_FI}">무료쿠폰 결제</option>
								<option value="${Constant.PAY_DIV_LG_LI}">L.Point결제</option>
								<option value="${Constant.PAY_DIV_NV_SI}">스마트스토어</option>
								<option value="${Constant.PAY_DIV_NV_LI}">라이브커머스</option>
								<option value="${Constant.PAY_DIV_TC_WI}">탐나는전 PC결제</option>
								<option value="${Constant.PAY_DIV_TC_MI}">탐나는전 모바일결제</option>
								<option value="${Constant.PAY_DIV_TA_PI}">포인트결제</option>
								<option value="${Constant.PAY_DIV_LG_NP}">네이버페이</option>
								<option value="${Constant.PAY_DIV_LG_KP}">카카오페이</option>
								<option value="${Constant.PAY_DIV_LG_AP}">애플페이</option>
								<option value="${Constant.PAY_DIV_LG_TP}">토스페이</option>
								<option value="${Constant.PAY_DIV_LG_MN}">관리자</option>
   							</select>
						</td>
					</tr>			
					<tr>
						<th>시작일<span class="font_red">*</span></th>
						<td>
							<input type="text" name="aplStartDt" id="insAplStartDt" class="input_text02" maxlength="10"/>
						</td>
					</tr>
					<tr>
						<th>종료일<span class="font_red">*</span></th>
						<td>
							<input type="text" name="aplEndDt" id="insAplEndDt" class="input_text02" maxlength="10"/>
							<span class="btn_sty04"><a href="javascript:fn_setLastTmEnd();">종료일 없음</a></span>
						</td>
					</tr>	
					<tr>
						<th>수수료 구분<span class="font02">*</span></th>
						<td>
							<select name="pgCmssDiv" id="insPgCmssDiv">
   								<c:forEach items="${comCdList}" var="comCd">
   								<option value="${comCd.cdNum}" <c:if test="${comCd.cdNum eq searchVO.sPgCmssDiv}">selected="true"</c:if>><c:out value="${comCd.cdNm}" /></option>
   								</c:forEach>
   							</select>
						</td>
					</tr>	
					<tr id="insCmssPer">
						<th>수수료율<span class="font02">*</span></th>
						<td>
							<input type="text" name="pgCmssPer" id="insPgCmssPer" class="input_text5 center" maxlength="8"/> %
						</td>
					</tr>
					<tr id="insCmssAmt" style="display:none;">
						<th>수수료금액<span class="font02">*</span></th>
						<td>
							<input type="text" name="pgCmssAmt" id="insPgCmssAmt" class="input_text5" maxlength="8"/> 원
						</td>
					</tr>					
					<tr  id="insCmssMin" style="display:none;">
						<th>최소수수료</th>
						<td>
							<input type="text" name="minCmss" id="insMinCmss" class="input_text5" maxlength="8"/> 원
						</td>
					</tr>			
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_InsCmssPg()">저장</a></span>
    </div>
</div>                                            

<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<form name="udtCmssPgFrm">
		<input type="hidden" name="pgDiv" id="udtPgDiv" />
		<input type="hidden" name="pgDivSeq" id="udtPgDivSeq" />
		<input type="hidden" name="pgCmssDiv" id="udtPgCmssDiv" />
		<ul class="form_area">
			<li>
				<table border="1" class="table02" >
  					<caption class="tb01_title">PG사 수수료관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>					
					<tr>
						<th>시작일<span class="font_red">*</span></th>
						<td>
							<input type="text" name="aplStartDt" id="udtAplStartDt" class="input_text02" maxlength="10"/>
						</td>
					</tr>
					<tr>
						<th>종료일<span class="font_red">*</span></th>
						<td>
							<input type="text" name="aplEndDt" id="udtAplEndDt" class="input_text02" maxlength="10"/>
						</td>
					</tr>					
					<tr id="udtCmssPer">
						<th>수수료율<span class="font02">*</span></th>
						<td>
							<input type="text" name="pgCmssPer" id="udtPgCmssPer" class="input_text2 center" maxlength="8"/> %
						</td>
					</tr>
					<tr id="udtCmssAmt">
						<th>수수료금액<span class="font02">*</span></th>
						<td>
							<input type="text" name="pgCmssAmt" id="udtPgCmssAmt" class="input_text5" maxlength="8"/> 원
						</td>
					</tr>					
					<tr id="udtCmssMin">
						<th>최소수수료<span class="font02">*</span></th>
						<td>
							<input type="text" name="minCmss" id="udtMinCmss" class="input_text5" maxlength="8"/> 원
						</td>
					</tr>							
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_UdtCmssPg()">수정</a></span>
    </div>
</div>

</body>
</html>