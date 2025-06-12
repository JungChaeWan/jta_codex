<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/svPrdtList.do'/>";
	document.frm.submit();
}

function fn_viewProductAppr(prdtNum) {	
	$.ajax({
		type:"post", 
		url:"<c:url value='/oss/viewPrdtAppr.ajax'/>",
		data:"linkNum=" + prdtNum,
		success:function(data){
			$("#div_ProductAppr").html(data);
			show_popup($("#div_ProductAppr"));
		},
		error:fn_AjaxError
	});
}

function fn_InsertProductAppr() {
	if($("#superbSvYn").is(":checked")) {
		$("#superbSvYn").val("Y");
	}
	if($("#jqYn").is(":checked")) {
		$("#jqYn").val("Y");
	}
	var parameter = $("#CM_CONFHISTVO").serialize();

	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/productAppr.ajax'/>",
		data:parameter,
		success:function(data){
			fn_Search($("#pageIndex").val());
		},
		error:fn_AjaxError
	});
}

function fn_LoginMas(corpId) {
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.success == "Y") {
				window.open("<c:url value='/mas/home.do'/>", '_blank');
			} else {
				alert("업체 로그인에 실패하였습니다.");
			}
		}
	});
}

function fn_ExcelDown() {
	document.frm.action = "<c:url value='/oss/svPrdtListExcelDown.do'/>";
	document.frm.submit();
}

function fn_goExprPrdtList() {
	document.frm.action = "<c:url value='/oss/svExprProductList.do'/>";
	document.frm.submit();
}

$(function() {

	if(opener){
		var openType = "true";
	}

	$("#sSaleStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sSaleEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
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
	
	$("select[name=sCtgr]").change(function() {
		if($(this).val() != "") {
			// 기존 subCd 제거
			$('select[name=sSubCtgr]').find('option').each(function() {
				$(this).remove();	
			});
			
			$("select[name=sSubCtgr]").show();
			
			$("select[name=sSubCtgr]").append("<option value=''>전체</option>");
			
			var parameters = "cdNum=" + $(this).val();

			$.ajax({
				type:"post", 
				dataType:"json",
				url:"<c:url value='/getCodeList.ajax'/>",
				data:parameters,
				success:function(data){
					var cdList = data["cdList"];
					for(var i = 0, e = cdList.length; i < e; i++) {
						var selectedStr = "";
						if ("${searchVO.sSubCtgr}" == cdList[i].cdNum)
							selectedStr = " selected";
						
						$("select[name=sSubCtgr]").append("<option value='" + cdList[i].cdNum + "'" + selectedStr + ">" + cdList[i].cdNm + "</option>");
					}
				}
			});
		} else {
			$("select[name=sSubCtgr]").hide();
		}
	});
	
	$("select[name=sCtgr]").change();
});

function fn_prdt_reg(prdtNum){
	$(opener.location).attr("href","javascript:fn_get_prdt('"+prdtNum+"');");
	self.close();
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=sv" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="55" />
										<col width="*" />
										<col width="55" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">처리상태</th>
											<td colspan="3">
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
											<th scope="row">승인일</th>
											<td><input type="text" id="sConfStartDt" class="input_text4 center" name="sConfStartDt" value="${searchVO.sConfStartDt}"  title="승인시작일" /> ~ <input type="text" id="sConfEndDt" class="input_text4 center" name="sConfEndDt"  title=승인종료일"   value="${searchVO.sConfEndDt}"/></td>
											<th scope="row">판매일</th>
											<td><input type="text" id="sSaleStartDt" class="input_text4 center" name="sSaleStartDt" value="${searchVO.sSaleStartDt}"  title="판매시작일" /> ~ <input type="text" id="sSaleEndDt" class="input_text4 center" name="sSaleEndDt"  value="${searchVO.sSaleEndDt}" title="판매종료일" /></td>
										</tr>
										<tr>
											<th scope="row">업체명</th>
											<td><input type="text" id="sCorpNm" name="sCorpNm" class="input_text15" value="${searchVO.sCorpNm}"/></td>
											<th scope="row">상품명</th>
											<td><input type="text" id="sPrdtNm" name="sPrdtNm" class="input_text15" value="${searchVO.sPrdtNm}"/></td>
										</tr>
										<tr>
											<th scope="row">카테고리</th>
											<td>
												<select id="sCtgr" name="sCtgr">
													<option value="" <c:if test="${empty searchVO.sCtgr}">selected</c:if>>전   체 </option>
													<c:forEach items="${ctgrList}" var="cd">
														<option value="${cd.cdNum}" <c:if test="${searchVO.sCtgr eq cd.cdNum}">selected</c:if>>${cd.cdNm}</option>
													</c:forEach>
												</select>
												<select name="sSubCtgr" style="width: 130px; display: none;"></select>
											</td>
											<th scope="row">노출 여부</th>
											<td>
												<select name="sDisplayYn" id="sDisplayYn">
													<option value="">전체</option>
													<option value="${Constant.FLAG_Y}" <c:if test="${searchVO.sDisplayYn eq Constant.FLAG_Y}">selected="selected"</c:if>>노출</option>
													<option value="${Constant.FLAG_N}" <c:if test="${searchVO.sDisplayYn eq Constant.FLAG_N}">selected="selected"</c:if>>비노출</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">JQ 인증<br>상품</th>
											<td>
												<label class="lb"><input type="checkbox" name="sJqYn" value="Y" <c:if test="${searchVO.sJqYn eq 'Y'}">checked</c:if>/></label>
												<img src="<c:url value='/images/oss/icon/jq.png'/>" width="20px" />
											</td>
											<th scope="row">공모전<br>수상작</th>
											<td>
												<label class="lb"><input type="checkbox" name="sSuperbSvYn" value="Y" <c:if test="${searchVO.sSuperbSvYn eq 'Y'}">checked</c:if>/></label>
												<img src="<c:url value='/images/oss/icon/superb_sv.png'/>" width="20px" />
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
					<p class="search_list_ps title-btn">[총 <strong><fmt:formatNumber value="${totalCnt}" type="number" /></strong>건]
					 <span class="side-wrap">
						[기간만료예정 상품 총 <strong><fmt:formatNumber value="${exprCnt}" type="number" /></strong>건]
						<c:if test="${exprCnt > 0}">
						 <a class="btn_sty04" href="javascript:fn_goExprPrdtList();">상품보기</a>
						</c:if>
					 </span>
					</p>
					<div class="list">
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th width="75">번호</th>
								<th>상품번호</th>
								<th>상태</th>
								<th>업체명</th>
								<th>상품명</th>
								<th>판매기간</th>
								<th>요청일</th>
								<th>승인일</th>
								<th width="210">기능틀</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="9" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="svPrdtInfo" items="${resultList}" varStatus="status">
								<tr>
									<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
									<td class="align_ct"><c:out value="${svPrdtInfo.prdtNum}"/></td>
									<td class="align_ct">
										<c:if test="${Constant.TRADE_STATUS_REG eq svPrdtInfo.tradeStatus}">
											등록중
										</c:if>
										<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq svPrdtInfo.tradeStatus}">
											승인요청
										</c:if>
										<c:if test="${Constant.TRADE_STATUS_APPR eq svPrdtInfo.tradeStatus}">
											승인
										</c:if>
										<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq svPrdtInfo.tradeStatus}">
											승인거절
										</c:if>
										<c:if test="${Constant.TRADE_STATUS_STOP eq svPrdtInfo.tradeStatus}">
											판매중지
										</c:if>
										<c:if test="${Constant.TRADE_STATUS_EDIT eq svPrdtInfo.tradeStatus}">
											수정요청
										</c:if>
										<c:if test="${Constant.TRADE_STATUS_STOP_REQ eq svPrdtInfo.tradeStatus}">
											판매중지 요청
										</c:if>
									</td>
									<td class="align_ct"><a href="javascript:fn_layerDetailCorp('${svPrdtInfo.corpId}');"><c:out value="${svPrdtInfo.corpNm}" /></a></td>
									<td class="align_ct">
										<c:if test="${svPrdtInfo.jqYn eq 'Y'}">
											<img src="<c:url value='/images/oss/icon/jq.png'/>" width="20px" />
										</c:if>
										<c:if test="${svPrdtInfo.superbSvYn eq 'Y'}">
											<img src="<c:url value='/images/oss/icon/superb_sv.png'/>" width="20px" />
										</c:if>
										<c:out value="${svPrdtInfo.prdtNm}" />
									</td>
									<td class="align_ct">
										<fmt:parseDate value="${svPrdtInfo.saleStartDt}" var="saleStartDt" pattern="yyyyMMdd"/>
										<fmt:parseDate value="${svPrdtInfo.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="align_ct">
										<fmt:parseDate value="${svPrdtInfo.confRequestDttm}" var="confRequestDttm" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${confRequestDttm}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="align_ct">
										<fmt:parseDate value="${svPrdtInfo.confDttm}" var="confDttm" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${confDttm}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="align_ct">
										<div class="btn_sty08"><span><a href="<c:url value='/oss/preview/svDetailProduct.do?prdtNum=${svPrdtInfo.prdtNum}'/>" target="_blank">상세보기</a></span></div>
										<!-- 관리자 예약 기능 추가 2021.06.16 chaewan.jung -->
										<script>
											if (opener && ${Constant.TRADE_STATUS_APPR eq svPrdtInfo.tradeStatus}){
												document.write("<div class=\"btn_sty06\"><span><a href=\"javascript:fn_prdt_reg('${svPrdtInfo.prdtNum}');\">등록</a></span></div>");
											}else{
												document.write("<div class=\"btn_sty06\"><span><a href=\"javascript:fn_viewProductAppr('${svPrdtInfo.prdtNum}');\">승인관리</a></span></div>");
											}

										</script>
										<div class="btn_sty09"><span><a href="javascript:fn_LoginMas('${svPrdtInfo.corpId}');">업체페이지</a></span></div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
					<ul class="btn_rt01">
						<li class="btn_sty04">
							<a href="javascript:fn_ExcelDown();">엑셀다운로드</a>
						</li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_ProductAppr" class="lay_popup lay_ct"  style="display:none;"></div>

</body>
</html>