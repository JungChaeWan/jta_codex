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
	document.frm.action = "<c:url value='/mas/sp/rsvList.do'/>";
	document.frm.submit();
}

function fn_DetailRsv(spRsvNum){
	$("#spRsvNum").val(spRsvNum);
	document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
	document.frm.submit();
}
/**
 * 사용처리
 */
function fn_spUseAppr(spRsvNum) {
	var parameters = "spRsvNum=" + spRsvNum;
	if(confirm("사용처리 하시겠습니까?")) {
		$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/mas/sp/spUseAppr.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.exprOut == "Y"){
					alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
					return ;
				} else if(data.useAbleOut == "Y") {
					alert(data.useAbleDttm + "이 후 사용가능합니다.");
					return ;
				} else {
					if(data.success == '${Constant.JSON_SUCCESS}'){
						alert("사용처리가 정상적으로 처리 되었습니다.");
						fn_Search($("#pageIndex").val());
					}
				}
			},
			error : fn_AjaxError
		});
		
	}
}

function fn_spUseRefund(spRsvNum){
	$("#spRsvNum").val(spRsvNum);
	var parameters = "spRsvNum=" + spRsvNum;
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/mas/sp/selectBySpRsv.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#rf_nmlAmt").html(commaNum(data.resultVO.nmlAmt));
			$("#rf_disAmt").html(commaNum(data.resultVO.disAmt));
			$("#rf_saleAmt").html(commaNum(data.resultVO.saleAmt));
			
			show_popup($("#lay_popup2"));
		}
	});
}

function fn_RefundReq(){
	if(confirm("환불 사용 처리 하시겠습니까?")){
		if(isNull($("#refundAmt").val()) || $("#refundAmt").val() == 0){
			if(confirm("환불 금액이 입력되지 않았습니다. 사용처리하시겠습니까?")){
				var parameters = "spRsvNum=" + $("#spRsvNum").val();
			
				$.ajax({
					type:"post", 
					dataType:"json",
					async:false,
					url:"<c:url value='/mas/sp/spUseAppr.ajax'/>",
					data:parameters ,
					success:function(data){
						if(data.exprOut == "Y"){
							alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
							return ;
						} else if(data.useAbleOut == "Y") {
							alert(data.useAbleDttm + "이 후 사용가능합니다.");
							return ;
						} else {
							if(data.success == '${Constant.JSON_SUCCESS}'){
								alert("사용처리가 정상적으로 처리 되었습니다.");
								fn_Search($("#pageIndex").val());
							}
						}
					},
					error : fn_AjaxError
				});
			}else{
				alert("취소되었습니다.");
				close_popup($('#lay_popup2'));
			}
		}else{
			var parameters = "spRsvNum=" + $("#spRsvNum").val();
			parameters += "&refundAmt=" + $("#refundAmt").val();
			
			$.ajax({
				type:"post", 
				dataType:"json",
				async:false,
				url:"<c:url value='/mas/sp/spUseRefund.ajax'/>",
				data:parameters ,
				success:function(data){
					if(data.exprOut == "Y"){
						alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
						return ;
					} else if(data.useAbleOut == "Y") {
						alert(data.useAbleDttm + "이 후 사용가능합니다.");
						return ;
					}else if(data.refundAbleOut == "Y"){
						alert("상품금액과 환불금액이 동일합니다. 취소처리를 이용해주세요.");
						return;
					}else {
						if(data.success == "Y"){
							close_popup($('#lay_popup2'));
							if(data.cancelDiv == "2"){
								alert("환불요청처리가 정상적으로 처리 되었습니다.");
							}else{
								alert("환불처리가 정상적으로 처리 되었습니다.");
							}
							fn_Search($("#pageIndex").val());
						}else{
							alert(data.payResult.payRstInf);
						}
					}
				},
				error : fn_AjaxError
			});
		}
	}
}

function fn_ExcelDown(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/mas/spRsvExcelDown.do?"+ parameters +"'/>";
}

$(document).ready(function() {

	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sUsedStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sUsedEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sAplDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});
</script>

</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=rsv" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="spRsvNum" name="spRsvNum" />
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
								</colgroup>
               					<tbody>
               						<tr>
               							<th scope="row">예약일자</th>
               							<td colspan="3">
	               							<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt}"  title="검색시작일" readonly /> ~ 
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일"  readonly value="${searchVO.sEndDt}"/>
               							</td>
               						</tr>
									<tr>
               							<th scope="row">사용일자</th>
               							<td colspan="3">
	               							<input type="text" id="sUsedStartDt" class="input_text4 center" name="sUsedStartDt" value="${searchVO.sUsedStartDt}"  title="검색시작일" readonly /> ~
	               							<input type="text" id="sUsedEndDt" class="input_text4 center" name="sUsedEndDt"  title="검색종료일"  readonly value="${searchVO.sUsedEndDt}"/>
               							</td>
               						</tr>
									<tr>
               							<th scope="row">적용일자</th>
               							<td colspan="3">
	               							<input type="text" id="sAplDt" class="input_text4 center" name="sAplDt" value="${searchVO.sAplDt}"  title="검색시작일" readonly />
               							</td>
               						</tr>
               						<tr>
          								<th scope="row">상&nbsp;품&nbsp;명</th>
          								<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
										<th scope="row">옵&nbsp;션&nbsp;명</th>
          								<td><input type="text" id="sOptNm" name="sOptNm" class="input_text13" value="${searchVO.sOptNm}"/></td>
       								</tr>
       								<tr>
										<th>예약자 명</th>
          								<td><input type="text" id="sRsvNm" name="sRsvNm" class="input_text13" value="${searchVO.sRsvNm}"/></td>
          								<th scope="row">예약상태</th>
          								<td>
          									<select id="sRsvStatusCd" name="sRsvStatusCd">
          										<option value="" <c:if test="${empty searchVO.sRsvStatusCd}">selected</c:if>>전체</option>
          										<option value="${Constant.RSV_STATUS_CD_READY}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_READY}">selected</c:if>>예약대기</option>
          										<option value="${Constant.RSV_STATUS_CD_EXP}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">selected</c:if>>예약불가</option>	
          										<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected</c:if>>예약완료</option>
          										<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected</c:if>>취소요청</option>	
          										<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected</c:if>>환불요청</option>
          										<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected</c:if>>취소완료</option>
												<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">selected</c:if>>환불완료</option>
												<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>사용완료</option>
												<option value="${Constant.RSV_STATUS_CD_ECOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">selected="selected"</c:if>>기간만료</option>
          									</select>								
          								</td>
       								</tr>
									<tr>
										<th scope="row">전화번호</th>
          								<td><input type="text" id="sRsvTelnum" class="input_text6" name="sRsvTelnum" value="${searchVO.sRsvTelnum}" title="검색하실 전화번호를 입력하세요." maxlength="13" /></td>
										<th scope="row">예약번호</th>
										<td><input type="text" id="sRsvNum" class="input_text13" name="sRsvNum" value="${searchVO.sRsvNum}" title="검색하실 예약번호를 입력하세요." maxlength="15" /></td>
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
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
                <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <%-- <col width="7%" /> --%>
                        <col width="8%" />
                        <col width="6%" />
                        <col />                        
                        <col />
                        <col width="4%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="8%" />
                        <col width="8%" />
                        <col width="8%" />
                        <col width="10%" />
                        <col width="5%" />
                    </colgroup>
					<thead>
						<tr>
							<!-- <th>번호</th> -->
							<th>예약번호</th>
							<th>예약상태</th>
							<th>상품명</th>
							<th>옵션명</th>
							<th>구매수</th>
							<th>예약자</th>
							<th>사용자</th>
							<th>판매금액</th>
							<th>취소수수료</th>
							<th class="font_red">예상정산액</th>
							<th>비고</th>
							<th>예약확인</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="12" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="rsvInfo" items="${resultList}" varStatus="status">
							<tr>
								<%-- <td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td> --%>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">${rsvInfo.rsvNum}</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약대기</c:if>								
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">예약불가</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><span class="font02">취소요청</span></c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">환불완료</c:if> 
								</td>
								<td style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">${rsvInfo.prdtNm}</td>
								<td style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">
									<c:if test="${not empty rsvInfo.aplDt}">
									<fmt:parseDate value='${rsvInfo.aplDt}' var='aplDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd"/> |
									</c:if>
									${rsvInfo.divNm} ${rsvInfo.optNm}
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">
									<c:out value="${rsvInfo.buyNum}" />
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">${rsvInfo.rsvNm} / ${rsvInfo.rsvTelnum}</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">${rsvInfo.useNm} / ${rsvInfo.useTelnum}</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">
									<fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">
									<fmt:formatNumber>${rsvInfo.cmssAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct" style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.spRsvNum}')">
									<fmt:formatNumber>${rsvInfo.adjAmt}</fmt:formatNumber>
								</td>
								<td class="align_ct" >
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
									<div class="btn_sty06"><span><a href="javascript:fn_spUseAppr('${rsvInfo.spRsvNum}');" >사용처리</a></span></div>
									<%-- <div class="btn_sty09"><span><a href="javascript:fn_spUseRefund('${rsvInfo.spRsvNum}');" >환불처리</a></span></div> --%>
									</c:if>							
								</td>
								<td class="align_ct">
									<c:if test="${rsvInfo.rsvIdtYn == 'Y'}">
										<img src="<c:url value='/images/oss/icon/check.png'/>"/>
									</c:if>
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
<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" id="cntLay">
 					<caption class="tb01_title">환불처리</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
				<tr>
					<th>상품금액</th>
					<td id="rf_nmlAmt">
						<fmt:formatNumber><c:out value="${resultVO.nmlAmt}" /></fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<th>할인금액</th>
					<td id="rf_disAmt">
						<fmt:formatNumber><c:out value="${resultVO.disAmt}" /></fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td id="rf_saleAmt">
						<fmt:formatNumber><c:out value="${resultVO.saleAmt}" /></fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<th>환불금액</th>
					<td>
						<input type="text" name="refundAmt" id="refundAmt" maxlength="11" onkeydown="javascript:fn_checkNumber();" />
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty03" id="btnResist"><a href="javascript:fn_RefundReq()">환불처리</a></span>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>