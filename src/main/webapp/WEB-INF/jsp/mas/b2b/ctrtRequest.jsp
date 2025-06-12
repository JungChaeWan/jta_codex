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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/b2b/ctrtRequestList.do'/>";
	document.frm.submit();
}


function fn_RequestPop(corpId, corpNm){
	$("#tgtCorpId").val(corpId);
	$("#tgtCorpNm").text(corpNm);
	show_popup("#requestPop");
	
}

function fn_Request(){
	if(confirm("해당 업체에 판매대행계약 요청 하시겠습니까?")){
		var parameters = "tgtCorpId=" + $("#tgtCorpId").val();
		parameters += "&requestRsn=" + $("#requestRsn").val();
		
		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/mas/b2b/ctrtB2bReq.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "${Constant.FLAG_N}"){
					alert(data.errorMsg);
					return;
				}else{
					
					fn_Search('1');
				}
			},
			error : fn_AjaxError
		});
	}
}

/**
 * 검색 노출 허용/비허용
 */
function fn_SFlag(sFlag){
	var parameters = "b2bUseYn=" + sFlag;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mas/b2b/updateB2bUseCorp.ajax'/>",
		data:parameters ,
		success:function(data){
			if(sFlag == 'N'){
				alert("내 업체가 검색결과에 노출되고 있지 않습니다");
			}else{
				alert("내 업체가 검색결과에 노출되고 있는 상태입니다");
			}
			document.frm.action = "<c:url value='/mas/b2b/ctrtRequestList.do'/>";
			document.frm.submit();
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
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="corpId" name="corpId" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
			<!--검색-->
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/ctrtCorpList.do'/>">계약업체관리</a></li>
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/tgtCtrtRequestList.do'/>">받은요청관리</a></li>
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/sendCtrtRequestList.do'/>">보낸요청관리</a></li>
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/mas/b2b/ctrtRequestList.do'/>">계약요청하기</a></li>
					</ul>
				</div>
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
	        									<option value="${Constant.FLAG_Y}" <c:if test="${searchVO.sStatusCd eq Constant.FLAG_Y}">selected="selected"</c:if>>요청가능</option>
	        									<option value="${Constant.FLAG_N}" <c:if test="${searchVO.sStatusCd eq Constant.FLAG_N}">selected="selected"</c:if>>요청불가</option>
	        								</select>
	        							</td>
	        							<th scope="row">업&nbsp;체&nbsp;명</th>
	        							<td><input type="text" id="sCorpNm" class="input_text_full" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
	     							</tr>
	     							<c:if test="${corpConfVO.corpCd eq Constant.SOCIAL}">
	     							<tr>
	     								<th scope="row">카테고리</th>
	     								<td colspan="3">
	     									<select name="sCorpCd" id="sCorpCd">
	     										<option value="">전체</option>
	     										<option value="${Constant.ACCOMMODATION}" <c:if test="${searchVO.sCorpCd eq Constant.ACCOMMODATION}">selected="selected"</c:if>>숙박</option>
	     										<option value="${Constant.RENTCAR}" <c:if test="${searchVO.sCorpCd eq Constant.RENTCAR}">selected="selected"</c:if>>렌터카</option>
	     										<option value="${Constant.GOLF}" <c:if test="${searchVO.sCorpCd eq Constant.GOLF}">selected="selected"</c:if>>골프</option>
	     									</select>
	     								</td>
	     							</tr>
	     							</c:if>
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
				            
				            <div class="side-wrap">
				            	<c:if test="${corpConfVO.b2bUseYn eq Constant.FLAG_Y}">
				            		<div><a href="javascript:fn_SFlag('N');" class="bt">B2B시스템 검색 비허용</a></div>
					            	<p class="info">※ 내 업체가 검색결과에 노출되고 있는 상태입니다.</p>
				            	</c:if>
				            	<c:if test="${corpConfVO.b2bUseYn eq Constant.FLAG_N}">
				            		<div><a href="javascript:fn_SFlag('Y');" class="bt">B2B시스템 검색 허용</a></div>
					            	<p class="info">※ 내 업체가 검색결과에 노출되고 있지 않습니다.</p>
				            	</c:if>
				            </div>
			            </div>
						
	              	</div>
	            </div>
            	<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> 
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
						<col width="5%" />
						<col />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="100px" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>업체명</th>
							<th>업체분류</th>
							<th>상태</th>
							<th>대표자명</th>
							<th>담당자명</th>
							<th>전화번호</th>
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
								<td class="align_ct"><c:out value="${corpInfo.corpNm}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.corpCdNm}"/></td>
								<td class="align_ct">
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_ABLE}">요청가능</c:if>
									<c:if test="${corpInfo.statusCd ne Constant.CTRT_STATUS_CD_ABLE}">요청불가</c:if>
								</td>
								<td class="align_ct"><c:out value="${corpInfo.ceoNm}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.admNm}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.rsvTelNum}"/></td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="<c:url value='/mas/b2b/detailCorp.do?corpId=${corpInfo.corpId}'/>">상세보기</a></span></div>
								</td>
								<td class="align_ct">
									<c:if test="${corpInfo.statusCd eq Constant.CTRT_STATUS_CD_ABLE}">
										<div class="btn_sty06"><span><a href="javascript:fn_RequestPop('${corpInfo.corpId}', '${corpInfo.corpNm}');">계약요청</a></span></div>
									</c:if>
									<c:if test="${not corpInfo.statusCd eq Constant.CTRT_STATUS_CD_ABLE}">
										<div class="btn_sty06 disabled"><span><a>계약요청</a></span></div>
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

<div id="requestPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">판매대행계약 요청</h3>
                <button type="button" class="close" onclick="close_popup('#requestPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<input type="hidden" name="tgtCorpId" id="tgtCorpId" />
            	<div class="info"><strong>요청업체 :</strong> <span>${corpConfVO.corpNm}</span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo">
                		<textarea id="requestRsn" name="requestRsn" rows="5" class="width90"></textarea>
					</div>
                </div>
                <div class="info"><strong>승인업체 :</strong> <span id="tgtCorpNm"></span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn" onclick="fn_Request();">요청</a> 
            </div>
        </div>
    </div>
</div>

</body>
</html>