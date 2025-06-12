<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	document.frm.action = "<c:url value='/mas/sv/rsvList.do'/>";
	document.frm.submit();
}

function fn_DetailRsv(svRsvNum){
	$("#svRsvNum").val(svRsvNum);
	document.frm.action = "<c:url value='/mas/sv/detailRsv.do'/>";
	document.frm.submit();
}

function fn_ShowInsDlvNum(svRsvNum, dlvInfo) {

	$("#transUniqueCode").val(dlvInfo.getAttribute("data-transuniquecode"));
	$("#fromName").val(dlvInfo.getAttribute("data-fromname"));
	$("#toName").val(dlvInfo.getAttribute("data-toname"));
	$("#orderNo").val(dlvInfo.getAttribute("data-orderno"));
	$("#itemName").val(dlvInfo.getAttribute("data-itemname"));
	$("#itemQty").val(dlvInfo.getAttribute("data-itemqty"));

	$("#dlvNum").val('');
	$("#SV_DLVINF input[name=svRsvNum]").val(svRsvNum);
	show_popup($("#div_InsDlvNum"));
}

function fn_ResetDlvNum(svRsvNum){
	if(confirm("등록 된 운송장정보가 초기화 됩니다.\n 정말 초기화 하시겠습니까?")) {
		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/mas/sv/resetDlvNum.ajax'/>",
			data: "svRsvNum="+svRsvNum,
			success : function(data) {
				if(data.success){
					alert("정상적으로 처리되었습니다.");
					location.reload();
				}else{
					alert("존재하지않는 배송번호 또는 시스템 오류입니다. \n다시한번 시도 하시거나 탐나오측으로 연락바랍니다.")
				}
			}
		});
	}
}

function fn_InsDlvNum() {
	if($("#dlvCorpCd").val() == "" ||$("#dlvCorpCd").val() == null){
		alert("택배사가 입력되지 않았습니다.");
		return;
	}
	$("#SV_DLVINF input[name=dlvCorpNm]").val($("#dlvCorpCd option:selected").text());

	/** 굿스플로우 배송사코드,배송조회번호 입력 */
	$("#logisticsCode").val($("#dlvCorpCd option:selected").attr("data-goodsflowdlvcd"));
	$("#invoiceNo").val($("#dlvNum").val());

	var parameters =  $("#SV_DLVINF").serialize();
	var confirmText = "배송업체 : " + $("#dlvCorpCd option:selected").text() + "\n"
	+ "운송장번호 : " + $("#dlvNum").val() + "\n\n"
	+ "입력하신 정보가 정확한지 다시 한번 확인해 주세요. 등록을 완료하면 고객님께 운송장 정보가 전달됩니다. 등록하시겠습니까?";

	if(confirm(confirmText)) {
		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/mas/sv/insertDlvNum.ajax'/>",
			data: parameters,
			success : function(data) {
				if(data.success){
					alert("정상적으로 등록되었습니다.");
					fn_Search($("#pageIndex").val());
				}else{
					alert("존재하지않는 배송번호 또는 시스템 오류입니다. \n다시한번 등록하시거나 탐나오측으로 연락바랍니다.")
				}
			}
		});
	}
}

function fn_ExcelDown(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/mas/svRsvListExcelDown.do?' />"+ parameters;
}

$(document).ready(function() {
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=rsv" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="rsvNum" name="rsvNum" />
				<input type="hidden" id="svRsvNum" name="svRsvNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
									<col width="*" />
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
               							<th scope="row">구매일자</th>
               							<td colspan="3">
	               							<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt}"  title="검색시작일" readonly /> ~
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일"  readonly value="${searchVO.sEndDt}"/>
               							</td>
               						</tr>
               						<tr>
          								<th scope="row">상&nbsp;품&nbsp;명</th>
          								<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." maxlength="20" /></td>
          								<th scope="row">구&nbsp;매&nbsp;자</th>
          								<td><input type="text" id="sRsvNm" class="input_text13" name="sRsvNm" value="${searchVO.sRsvNm}" title="검색하실 구매자를 입력하세요." maxlength="20" /></td>
       								</tr>
               						<tr>
          								<th scope="row">전화번호</th>
          								<td><input type="text" id="sRsvTelnum" class="input_text13" name="sRsvTelnum" value="${searchVO.sRsvTelnum}" title="검색하실 전화번호를 입력하세요." maxlength="13" /></td>
          								<th scope="row">구매상태</th>
               							<td>
               								<select name="sRsvStatusCd" style="width:100%">
               									<option value="">전체</option>
               									<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>결제완료</option>
               									<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
               									<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청</option>
               									<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>취소완료</option>
               									<option value="${Constant.RSV_STATUS_CD_DLV}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">selected="selected"</c:if>>배송중</option>
												<option value="${Constant.RSV_STATUS_CD_DLVE}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}">selected="selected"</c:if>>배송완료</option>
               									<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>구매확정</option>
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
                <p style="font-size: 12px; padding: 10px; font-weight: 700; position: relative; top: -40px; clear: both;">* 고객이 유선상으로 예약 취소 의사를 밝혔을 경우, 시스템 상 '취소처리' 진행이 꼭 필요합니다. </p>
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]
                	<span class="side-wrap">
               	 	자동구매확정일 : 배송완료 후 3일
               		</span>
                </p>
                <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <col width="8%" />
                        <col width="7%" />
                        <col />
                        <col width="15%" />
                        <col width="8%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="8%" />
                        <col width="8%" />
                        <col width="8%" />
                        <col width="10%" />
                    </colgroup>
					<thead>
						<tr>
							<th>구매번호</th>
							<th>구매상태</th>
							<th>상품명</th>
							<th>옵션명</th>
							<th>구매수</th>
							<th>구매자</th>
							<th>수령인</th>
							<th>판매금액</th>
							<th>취소수수료</th>
							<th class="font_red">예상정산액</th>
							<th>운송장정보</th>
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
						<c:forEach var="rsvInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">${rsvInfo.rsvNum}</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">미결제</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}"></c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">결제완료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><span class="font02">취소요청</span></c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">구매확정</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">배송중</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}">배송완료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">환불완료</c:if> 
								</td>
								<td style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')"><c:out value="${rsvInfo.prdtNm}" /></td>
								<td style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')"><c:out value="${rsvInfo.divNm}" />
									<c:out value="${rsvInfo.optNm}" />
									<c:if test="${rsvInfo.addOptNm ne null && rsvInfo.addOptNm != ''}"> | ${rsvInfo.addOptNm}</c:if>
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')"><fmt:formatNumber>${rsvInfo.buyNum}</fmt:formatNumber></td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">${rsvInfo.rsvNm} / ${rsvInfo.rsvTelnum}</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">${rsvInfo.useNm} / ${rsvInfo.useTelnum}</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">
									<fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">
									<fmt:formatNumber>${rsvInfo.cmssAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.svRsvNum}')">
									<fmt:formatNumber>${rsvInfo.adjAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct">
								<c:choose>
									<c:when test="${rsvInfo.directRecvYn == 'Y'}">
									직접 수령<br/>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">(수령)</c:if>
									<c:if test="${rsvInfo.rsvStatusCd ne Constant.RSV_STATUS_CD_UCOM}">(미수령)</c:if>
									</c:when>
									<c:when test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
									<div class="btn_sty06"><span><a href="javascript:void(0);" onclick="fn_ShowInsDlvNum('${rsvInfo.svRsvNum}',this);" data-transUniqueCode="${rsvInfo.svRsvNum}" data-fromName="${rsvInfo.corpNm}" data-toName="${rsvInfo.useNm}" data-orderNo="${rsvInfo.svRsvNum}" data-itemName="${rsvInfo.divNm} ${rsvInfo.optNm}" data-itemQty="${rsvInfo.buyNum}" >운송장 등록</a></span></div>
									</c:when>
									<c:when test="${not empty rsvInfo.dlvNum}">
									<p><c:out value="${rsvInfo.dlvCorpNm}"/></p>
									<p><c:out value="${rsvInfo.dlvNum}"/></p>
										<!--운송장정보 초기화-->
										<c:choose>
											<c:when test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">
												<div class="btn_sty09">
													<span><a href="javascript:void(0);" onclick="fn_ResetDlvNum('${rsvInfo.svRsvNum}');">운송장 초기화</a></span>
												</div>
											</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
									<p>-</p>
									</c:otherwise>
								</c:choose>
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

<div id="div_InsDlvNum" class="lay_popup lay_ct"  style="display:none">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_InsDlvNum'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
		<form name="SV_DLVINF" id="SV_DLVINF" method="post" onSubmit="return false">
		<%--배송상태 파라미터 --%>
		<input type="hidden" name="svRsvNum" />
		<input type="hidden" name="dlvCorpNm" />
		<%--배송추적 파라미터 --%>
		<input type="hidden" id="transUniqueCode" name="transUniqueCode" />
		<input type="hidden" id="fromName" name="fromName" />
		<input type="hidden" id="toName" name="toName" />
		<input type="hidden" id="logisticsCode" name="logisticsCode" />
		<input type="hidden" id="invoiceNo" name="invoiceNo" />
		<input type="hidden" id="orderNo" name="orderNo" />
		<input type="hidden" id="itemName" name="itemName" />
		<input type="hidden" id="itemQty" name="itemQty" />

		<table border="1" class="table02">
			<caption class="tb02_title">
				운송장정보입력<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
			</caption>
			<colgroup>
	             <col width="33%" />
	             <col width="65%" />
	        </colgroup>
	        <tr>
	         	<th>택배사<span class="font_red">*</span></th>
	         	<td>
	         		<select id="dlvCorpCd" name="dlvCorpCd" style="width:300px">
	         			<c:forEach items="${dlvCorpList}" var="dlv" >
						<option value="${dlv.dlvCorpCd}" data-goodsflowDlvCd="${dlv.goodsflowDlvCd}" data-escrowDlvCd="${dlv.escrowDlvCd}"><c:out value="${dlv.dlvCorpNm}"/></option>
	         			</c:forEach>
	         		</select>
	         	</td>
	        </tr>
	        <tr>
				<th>운송장번호<span class="font_red">*</span></th>
	         	<td>
	         		<input type="text" name="dlvNum"  id="dlvNum"  class="input_text_full" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자만가능합니다." />
	         	</td>
	        </tr>
		</table>
		</form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_InsDlvNum();">등록</a></span></div>
</div>
<div class="blackBg"></div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>