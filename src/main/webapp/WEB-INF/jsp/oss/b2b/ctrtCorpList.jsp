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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
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
	document.frm.action = "<c:url value='/oss/b2bCtrtList.do'/>";
	document.frm.submit();
}


/**
 * 요청상세
 */
function fn_DtlRequest(ctrtNum){
	var parameters = "ctrtNum=" + ctrtNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/b2b/selectCtrtInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#requestCorpNm").text(data.ctrtVO.requestCorpNm);
			$("#tgtCorpNm").text(data.ctrtVO.tgtCorpNm);
			$("#requestDttm").text(data.ctrtVO.requestDttm);
			$("#requestRsn").html(data.ctrtVO.requestRsn);
			
			show_popup("#requestPop");
		},
		error : fn_AjaxError
	});
}

/**
 * 계약 취소 팝업
 */
function fn_CancelCtrtPop(ctrtNum){
	var parameters = "ctrtNum=" + ctrtNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mas/b2b/selectCtrtInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#requestCorpNm3").text(data.ctrtVO.requestCorpNm);
			$("#tgtCorpNm3").text(data.ctrtVO.tgtCorpNm);
			$("#confDttm3").text(data.ctrtVO.confDttm);
			$("#cancelCtrtNum").val(ctrtNum);
			
			show_popup("#cancelPop");
		},
		error : fn_AjaxError
	});
}

/**
 * 계약 취소 요청
 */
function fn_Cancel(){
	if(confirm("해당업체에 대해 계약취소를 요청 하시겠습니까?")){
		var parameters = "ctrtNum=" + $("#cancelCtrtNum").val();
		parameters += "&cancelRsn=" + $("#cancelRsn").val();
		
		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/mas/b2b/ctrtCancelReq.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "${Constant.FLAG_N}"){
					alert(data.errorMsg);
					return;
				}else{
					alert("해당업체에 대해 계약취소가 요청 되었습니다.");
					
					document.frm.action = "<c:url value='/mas/b2b/ctrtCorpList.do'/>";
					document.frm.submit();
				}
			},
			error : fn_AjaxError
		});
	}
}

/**
 * 취소상세
 */
function fn_DtlCancel(ctrtNum){
	var parameters = "ctrtNum=" + ctrtNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/b2b/selectCtrtInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#requestCorpNm3").text(data.ctrtVO.requestCorpNm);
			$("#requestDttm3").text(data.ctrtVO.requestDttm);
			$("#cancelRsn3").html(data.ctrtVO.cancelRsn);
			$("#cancelRequestDttm3").html(data.ctrtVO.cancelRequestDttm);
			$("#cancelDttm3").html(data.ctrtVO.cancelDttm);
			$("#tgtCorpNm3").html(data.ctrtVO.tgtCorpNm);
			
			show_popup("#dtlCancelPop");
		},
		error : fn_AjaxError
	});
}

/**
 * 반려상세
 */
function fn_DtlRstr(ctrtNum){
	var parameters = "ctrtNum=" + ctrtNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/b2b/selectCtrtInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#requestCorpNm2").text(data.ctrtVO.requestCorpNm);
			$("#tgtCorpNm2").text(data.ctrtVO.tgtCorpNm);
			$("#requestDttm2").text(data.ctrtVO.requestDttm);
			$("#rstrRsn2").html(data.ctrtVO.rstrRsn);
			$("#rstrDttm2").html(data.ctrtVO.rstrDttm);
			
			show_popup("#dtlRstrPop");
		},
		error : fn_AjaxError
	});
}

$(document).ready(function() {
	$("#sFromDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sToDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=b2bCtrt" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="corpId" name="corpId" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
			<!--검색-->
	            <div class="search_box">
	            	<div class="search_form">
	                	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="100" />
	                                <col width="*" />
									<col width="100" />
	                                <col width="*" />
								</colgroup>
	             				<tbody>
	             					<tr>
	        							<th scope="row">상&nbsp;태</th>
	        							<td>
	        								<select name="sStatusCd" id="sStatusCd">
	        									<option value="">전체</option>
	        									<option value="${Constant.CTRT_STATUS_CD_APPR}" <c:if test="${Constant.CTRT_STATUS_CD_APPR eq searchVO.sStatusCd}">selected="selected"</c:if>>계약완료</option>
	        								</select>
	        							</td>
	        							<th scope="row">업&nbsp;체&nbsp;명</th>
	        							<td><input type="text" id="sCorpNm" class="input_text13" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
	     							</tr>
	             					<%-- <tr>
	             						<th scope="row">처리상태</th>
	        							<td>
	        								<select name="sStatusCd" id="sStatusCd">
	        									<option value="">전 체</option>
	        									<option value="${Constant.TRADE_STATUS_APPR_REQ}" <c:if test="${Constant.TRADE_STATUS_APPR_REQ eq searchVO.sStatusCd}">selected="selected"</c:if>>승인요청</option>
	        									<option value="${Constant.TRADE_STATUS_APPR_REJECT}" <c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq searchVO.sStatusCd}">selected="selected"</c:if>>반려</option>
	        									<option value="${Constant.TRADE_STATUS_APPR}" <c:if test="${Constant.TRADE_STATUS_APPR eq searchVO.sStatusCd}">selected="selected"</c:if>>승인</option>
	        								</select>
	        							</td>
	        						</tr> --%>
	     						</tbody>
	               			</table>
	               		</div>
	               		<div class="search-wrap">
				            <span class="btn">
								<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
				            
			            </div>
						
	              	</div>
	            </div>
            	<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> 
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
						<col width="5%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col />
						<col width="150px" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>요청한업체</th>
							<th>계약요청일</th>
							<th>요청받은업체</th>
							<th>처리상태</th>
							<th colspan="2">기능툴</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="11" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="corpInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.requestCorpNm}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.requestDttm}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.tgtCorpNm}"/></td>
								<td class="align_ct">
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_REQ}">계약요청중</c:if>
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_APPR}">계약완료(<c:out value="${corpInfo.confDttm}" />)</c:if>
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_REJECT}">반려(<c:out value="${corpInfo.rstrDttm}" />)</c:if>
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_CANCEL_REQ}">취소처리중(<c:out value="${corpInfo.cancelRequestDttm}" />)</c:if>
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_CANCEL}">취소완료(<c:out value="${corpInfo.cancelDttm}" />)</c:if>
								</td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_DtlRequest('${corpInfo.ctrtNum}')">요청상세</a></span></div>
									<c:if test="${(corpInfo.statusCd eq Constant.CTRT_STATUS_CD_CANCEL_REQ) or (corpInfo.statusCd eq Constant.CTRT_STATUS_CD_CANCE)}">
										<div class="btn_sty06"><span><a href="javascript:fn_DtlCancel('${corpInfo.ctrtNum}')">취소상세</a></span></div>
									</c:if>
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_REJECT}">
										<div class="btn_sty06"><span><a href="javascript:fn_DtlRstr('${corpInfo.ctrtNum}')">반려상세</a></span></div>
									</c:if>
								</td>
								<td class="align_ct">
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_CANCEL_REQ}">
										<div class="btn_sty09"><span><a href="javascript:fn_Cancel('${corpInfo.ctrtNum}');">계약취소승인</a></span></div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
			</div>
			</form>
		</div>
	</div>
</div>
<!-- layer popup  -->
<div class="blackBg"></div>

<!-- 요청 상세 -->
<div id="requestPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">판매대행계약 요청</h3>
                <button type="button" class="close" onclick="close_popup('#requestPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<input type="hidden" name="tgtCorpId" id="tgtCorpId" />
            	<div class="info"><strong>요청업체 :</strong> <span id="requestCorpNm"></span></div>
            	<div class="info"><strong>요청일시 :</strong> <span id="requestDttm"></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo" id="requestRsn">
					</div>
                </div>
                <div class="info"><strong>승인업체 :</strong> <span id="tgtCorpNm"></span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn" onclick="close_popup('#requestPop');">확인</a> 
            </div>
        </div>
    </div>
</div>

<!-- 반려 상세 레이어 -->
<div id="dtlRstrPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">판매대행계약 반려</h3>
                <button type="button" class="close" onclick="close_popup('#dtlRstrPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<input type="hidden" name="tgtCorpId" id="tgtCorpId" />
            	<div class="info"><strong>요청업체 :</strong> <span id="requestCorpNm2"></span></div>
            	<div class="info"><strong>요청일시 :</strong> <span id="requestDttm2"></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo" id="rstrRsn2">
					</div>
                </div>
                <div class="info"><strong>승인업체 :</strong> <span id="tgtCorpNm2"></span></div>
                <div class="info"><strong>반려일시 :</strong> <span id="rstrDttm2"></span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn" onclick="close_popup('#dtlRstrPop');">확인</a> 
            </div>
        </div>
    </div>
</div>

<!-- 취소 상세 레이어 -->
<div id="dtlCancelPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">판매대행계약 취소상세</h3>
                <button type="button" class="close" onclick="close_popup('#dtlCancelPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<div class="info"><strong>요청업체 :</strong> <span id="requestCorpNm3"></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo" id="cancelRsn3">
					</div>
                </div>
                <div class="info"><strong>승인업체 :</strong> <span id="tgtCorpNm3"></span></div>
                <div class="info"><strong>취소요청일시 :</strong> <span id="cancelRequestDttm3"></span></div>
                <div class="info"><strong>취소완료일시 :</strong> <span id="cancelDttm3"></span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn" onclick="close_popup('#dtlCancelPop');">확인</a> 
            </div>
        </div>
    </div>
</div>

<!-- 취소 레이어 -->
<div id="cancelPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">판매대행계약 취소요청</h3>
                <button type="button" class="close" onclick="close_popup('#cancelPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<div class="info"><strong>요청업체 :</strong> <span id="requestCorpNm3"></span></div>
            	<div class="info"><strong>승인일시 :</strong> <span id="confDttm3"></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo" id="cancelRsn3">
					</div>
                </div>
                <div class="info"><strong>승인업체 :</strong> <span id="tgtCorpNm3"></span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn red" onclick="fn_Cancel();">취소요청</a> 
            </div>
        </div>
    </div>
</div>

</body>
</html>