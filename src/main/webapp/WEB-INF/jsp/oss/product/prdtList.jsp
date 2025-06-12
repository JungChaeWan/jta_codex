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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
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
	document.frm.action = "<c:url value='/oss/prdtList.do'/>";
	document.frm.submit();
}

function fn_viewProductAppr(prdtNum) {
	$.ajax({
		type:"post", 
		url:"<c:url value='/oss/viewPrdtAppr.ajax'/>",
		data:"linkNum=" + prdtNum ,
		success:function(data){
			$("#div_ProductAppr").html(data);
			show_popup($("#div_ProductAppr"));
		},
		error : fn_AjaxError
	});
}

function fn_InsertProductAppr() {
	var parameter = $("#CM_CONFHISTVO").serialize();
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/productAppr.ajax'/>",
		data:parameter,
		success:function(data){
			fn_Search($("#pageIndex").val());
		},
		error : fn_AjaxError
	});
}

function fn_viewProduct(prdtNum){
	//alert(prdtNum);
	var code = prdtNum.substring(0,2);
	
	if(code=="AD"){
		window.open("<c:url value='/oss/preview/adPrdt.do'/>?sPrdtNum="+prdtNum, '_blank');
	}else if(code=="RC"){
		window.open("<c:url value='/oss/preview/rcPrdt.do'/>?prdtNum="+prdtNum, '_blank');
	}else if(code=="GL"){
		window.open("<c:url value='/oss/preview/glPrdt.do'/>?sPrdtNum="+prdtNum, '_blank');
	}
}

function fn_LoginMas(corpId, prdtNum){
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				if (prdtNum == "") {
					window.open("<c:url value='/mas/home.do'/>", '_blank');
				}else{
					window.open("<c:url value='/mas/rc/viewUpdatePrdt.do'/>?prdtNum="+prdtNum, '_blank');
				}
			}else{
				alert("업체 로그인에 실패하였습니다.");
			}
		}
	});
}

/* 엑셀 다운로드  */
function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/prdtListExcel.do?"+ parameters +"'/>";

}


$(document).ready(function(){
	$("#sConfStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sConfEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
});
</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=product" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="prdtNum" name="prdtNum" />
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
                                <col width="100" />
                                <col width="*" />
                            </colgroup>
             				<tbody>
             					<tr>
               						<th scope="row">처리상태</th>
               						<td colspan="5">
               							<input type="radio" name="sTradeStatus" value=""   <c:if test='${empty searchVO.sTradeStatus}'>checked</c:if>> 전체</input>&nbsp;
               							<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REQ}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REQ}'>checked</c:if>> 승인요청</input>&nbsp;
               							<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR}'>checked</c:if>> 승인</input>&nbsp;
               							<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REJECT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REJECT}'>checked</c:if>> 승인거절</input>&nbsp;
               							<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_STOP}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_STOP}'>checked</c:if>> 판매중지</input>&nbsp;
               							<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_STOP_REQ}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_STOP_REQ}'>checked</c:if>> 판매중지 요청</input>&nbsp;
               							<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_EDIT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_EDIT}'>checked</c:if>> 수정요청</input>&nbsp;
               						</td>
               					</tr>
               					<tr>
        							<th scope="row">상&nbsp;품&nbsp;명</th>
        							<td><input type="text" id="sPrdtNm" class="input_text15" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
        							<th scope="row">업&nbsp;체&nbsp;명</th>
        							<td><input type="text" id="sCorpNm" class="input_text15" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명를 입력하세요." /></td>
        							<th scope="row">상품구분</th>
        							<td>
        								<select name="sPrdtCd" id="sPrdtCd">
        									<option value="">전체</option>
        									<option value="${Constant.ACCOMMODATION}" <c:if test="${searchVO.sPrdtCd eq Constant.ACCOMMODATION}">selected="selected"</c:if>>숙소</option>
        									<option value="${Constant.RENTCAR}" <c:if test="${searchVO.sPrdtCd eq Constant.RENTCAR}">selected="selected"</c:if>>렌터카</option>
        									<option value="${Constant.GOLF}" <c:if test="${searchVO.sPrdtCd eq Constant.GOLF}">selected="selected"</c:if>>골프</option>
        								</select>
        							</td>
     							</tr>
               					<tr>
     								<th scope="row">승인일</th>
               						<td>
               							<input type="text" id="sConfStartDt" class="input_text4 center" name="sConfStartDt" value="${searchVO.sConfStartDt}"  title="요청시작일" /> ~
               							<input type="text" id="sConfEndDt" class="input_text4 center" name="sConfEndDt"  title="요청종료일"   value="${searchVO.sConfEndDt}"/>
               						</td>
               						<th scope="row">노출구분</th>
        							<td colspan="3">
        								<select name="sDisplayYn" id="sDisplayYn">
        									<option value="">전체</option>
        									<option value="${Constant.FLAG_Y}" <c:if test="${searchVO.sDisplayYn eq Constant.FLAG_Y}">selected="selected"</c:if>>노출</option>
        									<option value="${Constant.FLAG_N}" <c:if test="${searchVO.sDisplayYn eq Constant.FLAG_N}">selected="selected"</c:if>>비노출</option>
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
            <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				<thead>
					<tr>
						<th>번호</th>
						<th>상품번호</th>
						<th>상태</th>
						<th>업체명</th>
						<th>상품명</th>												
						<th>요청일</th>
						<th>승인일</th>
						<th width="320">기능툴</th>
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
					<c:forEach var="prdtInfo" items="${resultList}" varStatus="status">
						<tr>
							<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
							<td class="align_ct"><c:out value="${prdtInfo.prdtNum}"/></td>
							<td class="align_ct"><c:out value="${prdtInfo.tradeStatusNm}"/></td>
							<td class="align_ct"><c:out value="${prdtInfo.corpNm}" /></td>
							<td class="align_ct"><c:out value="${prdtInfo.prdtNm}"/></td>
							<td class="align_ct">								
								<fmt:parseDate value="${prdtInfo.confRequestDttm}" var="confRequestDttm" pattern="yyyy-MM-dd"/>
								<fmt:formatDate value="${confRequestDttm}" pattern="yyyy-MM-dd"/>
							</td>
							<td class="align_ct">								
								<fmt:parseDate value="${prdtInfo.confDttm}" var="confDttm" pattern="yyyy-MM-dd"/>
								<fmt:formatDate value="${confDttm}" pattern="yyyy-MM-dd"/>
							</td>
							<td class="align_ct">
								<div class="btn_sty08"><span><a href="javascript:fn_viewProduct('${prdtInfo.prdtNum}');">상세보기</a></span></div>
								<div class="btn_sty06"><span><a href="javascript:fn_viewProductAppr('${prdtInfo.prdtNum}');">승인관리</a></span></div>
								<div class="btn_sty09"><span><a href="javascript:fn_LoginMas('${prdtInfo.corpId}','');">업체관리자</a></span></div>
								<c:if test='${fn:substring(prdtInfo.prdtNum, 0, 2) eq Constant.RENTCAR}'>
								<div class="btn_sty08"><span><a href="javascript:fn_LoginMas('${prdtInfo.corpId}','${prdtInfo.prdtNum}');">연동확인</a></span></div>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			</p>
			<ul class="btn_rt01">
				<li class="btn_sty02">
					<a href="javascript:fn_SaveExcel()">엑셀저장</a>
				</li>
			</ul>
			</div>
		</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_ProductAppr" class="lay_popup lay_ct"  style="display:none;">
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>