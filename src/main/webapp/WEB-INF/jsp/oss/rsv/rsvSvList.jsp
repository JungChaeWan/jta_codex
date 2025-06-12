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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/rsvSvList.do'/>";
	document.frm.submit();
}

function fn_DetailRsv(rsvNum) {
	$("#rsvNum").val(rsvNum);

	document.frm.action = "<c:url value='/oss/detailRsvSv.do'/>";
	document.frm.submit();
}

/** 예약일자, 사용일자가 일정기간내에 포함되어있는지 유효성검사*/
function excelDayCntValidate(startDt,endDt,validateCnt){
	let resultYn = true;

	if(!$("#"+startDt).val() || !$("#"+endDt).val()){
		resultYn = false;
	}
	let strSDate = $("#"+startDt).val();
	let strEDate = $("#"+endDt).val();

	let arraySDate = strSDate.split("-");
	let arrayEDate = strEDate.split("-");

	let sDate = new Date(arraySDate[0], arraySDate[1], arraySDate[2]);
	let eDate = new Date(arrayEDate[0], arrayEDate[1], arrayEDate[2]);

	let diff = eDate - sDate;
	let currDay = 24 * 60 * 60 * 1000;

	if(parseInt(diff / currDay) > validateCnt){
		resultYn = false;
	}
	return resultYn;
}

function fn_ExcelDown() {

/*	let bookDt = excelDayCntValidate("sStartDt", "sEndDt",366);
	if(!bookDt){
		alert("365일 이상의 엑셀데이터는 다운로드가 불가능합니다.");
		return;
	}*/

	let parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/rsvExcelDown2.do?' />" + parameters;
}

function fn_admin_rsv(){
	document.frm.action = "<c:url value='/oss/adminRsvReg.do'/>";
	document.frm.submit();
}

function fn_admin_rsv_excel(){
	document.frm.action = "<c:url value='/oss/adminRsvRegExcel.do'/>";
	document.frm.submit();
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
	<jsp:include page="/oss/head.do?menu=rsv" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=rsv&sub=rsvSv" />
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="rsvNum" name="rsvNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="userId" name="userId" value="${searchVO.userId}" />
				<input type="hidden" id="partnerCode" name="partnerCode" value="${ssPartnerCode}" />
				<div id="contents">
					<c:if test="${ssPartnerCode eq 'tamnao'}">
					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_admin_rsv()">관리자 예약(단건)</a></li>
					</ul>
					</c:if>
					<!--검색-->
					<%--<c:if test="${searchVO.userId eq '' || searchVO.userId ne null}">
						<input type="hidden" name="sAutoCancelViewYn" value="Y" />
					</c:if>--%>
					<c:if test="${searchVO.userId eq '' || searchVO.userId eq null}">
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="85" />
										<col width="300" />
										<col width="85" />
										<col width="300" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">구매일자</th>
											<td colspan="3">
												<input type="text" id="sStartDt" class="input_text5 center" name="sStartDt" value="${searchVO.sStartDt}"  title="구매일자 시작" /> ~
												<input type="text" id="sEndDt" class="input_text5 center" name="sEndDt"  title="구매일자 종료" value="${searchVO.sEndDt}"/>
											</td>
										</tr>
										<tr>
											<th scope="row">구매번호</th>
											<td>
												<input type="text" id="sRsvNum" class="input_text13" name="sRsvNum" value="${searchVO.sRsvNum}" title="구매번호를 입력하세요." maxlength="20" />
											</td>
											<th scope="row">자동취소</th>
											<td>
												<select name="sAutoCancelViewYn" id="sAutoCancelViewYn">
													<option value="N" <c:if test="${searchVO.sAutoCancelViewYn == 'N'}">selected="selected"</c:if>>포함안함</option>
													<option value="Y" <c:if test="${searchVO.sAutoCancelViewYn == 'Y'}">selected="selected"</c:if>>포함</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">구&nbsp;매&nbsp;자</th>
											<td><input type="text" id="sRsvNm" class="input_text13" name="sRsvNm" value="${searchVO.sRsvNm}" title="구매자를 입력하세요." maxlength="20" /></td>
											<th scope="row">전화번호</th>
											<td><input type="text" id="sRsvTelnum" class="input_text6" name="sRsvTelnum" value="${searchVO.sRsvTelnum}" title="전화번호를 입력하세요." maxlength="13" /></td>
										</tr>
										<tr>
											<th scope="row">업&nbsp;체&nbsp;명</th>
											<td>
												<input type="text" id="sCorpNm" class="input_text13" name="sCorpNm" value="${searchVO.sCorpNm}" title="업체명을 입력하세요." maxlength="20" />
											</td>
											<th scope="row">상&nbsp;품&nbsp;명</th>
											<td>
												<input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="상품명을 입력하세요." maxlength="13" />
											</td>
										</tr>
										<tr>
											<th scope="row">앱&nbsp;구&nbsp;분</th>
											<td>
												<select name="sAppDiv" id="sAppDiv">
													<option value="">전체</option>
													<option value="PC" <c:if test="${searchVO.sAppDiv == 'PC'}">selected="selected"</c:if>>PC</option>
													<option value="AW" <c:if test="${searchVO.sAppDiv == 'AW'}">selected="selected"</c:if>>Android Mobile Web</option>
													<option value="AA" <c:if test="${searchVO.sAppDiv == 'AA'}">selected="selected"</c:if>>Android APP</option>
													<option value="IW" <c:if test="${searchVO.sAppDiv == 'IW'}">selected="selected"</c:if>>IOS Mobile Web</option>
													<option value="IA" <c:if test="${searchVO.sAppDiv == 'IA'}">selected="selected"</c:if>>IOS APP</option>
													<option value="AR" <c:if test="${searchVO.sAppDiv == 'AR'}">selected="selected"</c:if>>Admin Register</option>
												</select>
											</td>
											<th scope="row">L.Point</th>
											<td>
												<select name="sLpointDiv" id="sLpointDiv">
													<option value="">= 전 체 =</option>
													<option value="dont" <c:if test="${searchVO.sLpointDiv == 'dont'}">selected="selected"</c:if>>미사용</option>
													<option value="use" <c:if test="${searchVO.sLpointDiv == 'use'}">selected="selected"</c:if>>사용</option>
													<option value="save" <c:if test="${searchVO.sLpointDiv == 'save'}">selected="selected"</c:if>>적립</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">예약상태</th>
											<td>
												<select name="sRsvStatusCd" >
													<option value="">= 전 체 =</option>
													<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>결제완료</option>
													<option value="${Constant.RSV_STATUS_CD_READY}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_READY}">selected="selected"</c:if>>구매처리중</option>
													<option value="${Constant.RSV_STATUS_CD_EXP}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">selected="selected"</c:if>>구매불가</option>
													<option value="${Constant.RSV_STATUS_CD_DLV}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">selected="selected"</c:if>>배송중</option>
													<option value="${Constant.RSV_STATUS_CD_DLVE}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}">selected="selected"</c:if>>배송완료</option>
													<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
													<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청건</option>
													<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>취소완료</option>
													<option value="${Constant.RSV_STATUS_CD_CCOM2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">selected="selected"</c:if>>환불완료</option>
													<option value="${Constant.RSV_STATUS_CD_SREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">selected="selected"</c:if>>부분환불요청</option>
													<option value="${Constant.RSV_STATUS_CD_SCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">selected="selected"</c:if>>부분환불완료</option>
													<option value="${Constant.RSV_STATUS_CD_ACC}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">selected="selected"</c:if>>자동취소</option>
													<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>구매확정</option>
													<option value="${Constant.RSV_STATUS_CD_ECOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">selected="selected"</c:if>>기간만료</option>
												</select>
											</td>										
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>
					</c:if>
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<colgroup>
								<col width="120" />
								<col />
								<col width="220" />
								<col width="100" />
								<col width="120" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
							</colgroup>
							<thead>
								<tr>
									<th>구매번호</th>
									<th>상품명</th>
									<th>상품금액</th>
									<th>구매일시</th>
									<th>구매자</th>
									<th>구매자구분</th>
									<th>결제구분</th>
									<th>앱구분</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="8" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="rsvInfo" items="${resultList}" varStatus="stauts">
									<tr style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.rsvNum}')">
										<td class="align_ct">${rsvInfo.rsvNum}</td>
										<td class="align_lt">
											<table class="product-list" style="table-layout:fixed">
												<colgroup>
													<col />
													<col width="100" />
													<col width="100" />
												</colgroup>
												<c:forEach var="orderInfo" items="${orderList}" varStatus="status2">
													<c:if test="${orderInfo.rsvNum eq rsvInfo.rsvNum}">
														<tr>
															<td class="left2">
																<p>[<c:out value="${orderInfo.prdtCdNm}"/>] <c:out value="${orderInfo.corpNm}"/></p>
																<p class="product"><strong><c:out value="${orderInfo.prdtNm}"/></strong></p>
																<p class="infoText"><c:out value="${orderInfo.prdtInf}"/></p>
															</td>
															<td style="border-right:1px solid #e1e3e4 !important">
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">결제완료</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">구매처리중</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">구매불가</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">
																	<span class="font02">취소요청</span><br>
																	(<c:out value="${orderInfo.cancelRequestDttm}"/>)
																</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}"><span class="font02">환불요청건</span></c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">
																	<span class="font01">구매확정</span><br>
																	(${orderInfo.buyFixDttm eq null?"관리자 확정": orderInfo.buyFixDttm} )
																</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">배송중</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}">배송완료</c:if>
																<c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">환불완료</c:if>
															</td>
															<td>
																<c:choose>
																	<c:when test="${orderInfo.directRecvYn == 'Y'}">
																		<p>직접수령</p>
																	</c:when>
																	<c:when test="${not empty orderInfo.dlvNum}">
																		<p><c:out value="${orderInfo.dlvCorpNm}"/></p>
																		<p><c:out value="${orderInfo.dlvNum}"/></p>
																	</c:when>
																	<c:otherwise>
																		<p>-</p>
																	</c:otherwise>
																</c:choose>
															</td>
														</tr>
													</c:if>
												</c:forEach>
											</table>
										</td>
										<td class="align_rt">
											<div class="price-wrap">
												<p>
													<span class="text">상품금액</span>
													<span class="price"><fmt:formatNumber>${rsvInfo.totalNmlAmt}</fmt:formatNumber>원</span>
												</p>
												<p>
													<span class="text">(-)&nbsp;할인금액</span>
													<span class="price"><fmt:formatNumber>${rsvInfo.totalDisAmt}</fmt:formatNumber>원</span>
												</p>
												<p>
													<span class="text">(-)&nbsp;L.Point</span>
													<c:if test="${rsvInfo.lpointUsePoint == 0}"><span class="price"><fmt:formatNumber>${rsvInfo.lpointUsePoint}</fmt:formatNumber>원</span></c:if>
													<c:if test="${rsvInfo.lpointUsePoint != 0}"><span class="price font03" style="font-weight: normal;"><fmt:formatNumber>${rsvInfo.lpointUsePoint}</fmt:formatNumber>원</span></c:if>
												</p>
												<p>
													<span class="text">(-)&nbsp;포인트</span>
													<c:if test="${rsvInfo.usePoint == 0}"><span class="price"><fmt:formatNumber>${rsvInfo.usePoint}</fmt:formatNumber>원</span></c:if>
													<c:if test="${rsvInfo.usePoint != 0}"><span class="price font03" style="font-weight: normal;"><fmt:formatNumber>${rsvInfo.usePoint}</fmt:formatNumber>원</span></c:if>
												</p>
												<p class="total">
													<span class="text"><strong>결제금액</strong></span>
													<span class="price font03"><fmt:formatNumber>${rsvInfo.totalSaleAmt}</fmt:formatNumber>원</span>
												</p>
											</div>
										</td>
										<td class="align_ct">
											<c:out value='${rsvInfo.regDttm}'/>
										</td>
										<td class="align_ct">
											<p><c:out value='${rsvInfo.rsvNm}'/></p>
											<p>(<c:out value='${rsvInfo.rsvTelnum}'/>)</p>
										</td>
										<td class="align_ct">
											<c:if test="${rsvInfo.userId eq Constant.RSV_GUSET_NAME}">비회원</c:if>
											<c:if test="${rsvInfo.userId ne Constant.RSV_GUSET_NAME}">회원</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_MI}">무통장입금</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_EMI}">무통장입금(에스크로)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_LI}">L.Point결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_SI}">스마트스토어</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_LI}">라이브커머스</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI}">탐나는전(PC)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_MI}">탐나는전<br>(모바일)</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TA_PI}">포인트결제</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KP}">카카오페이</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_NP}">네이버페이</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_AP}">애플페이</c:if>
											<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TP}">토스페이</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${rsvInfo.appDiv eq 'AR'}">Admin Register</c:if>
											<c:if test="${rsvInfo.appDiv eq 'PC'}">PC</c:if>
											<c:if test="${rsvInfo.appDiv eq 'AW'}">Android Mobile Web</c:if>
											<c:if test="${rsvInfo.appDiv eq 'AA'}">Android APP</c:if>
											<c:if test="${rsvInfo.appDiv eq 'IW'}">IOS Mobile Web</c:if>
											<c:if test="${rsvInfo.appDiv eq 'IA'}">IOS APP</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
					<%--<c:if test="${searchVO.userId eq ''|| searchVO.userId eq null}">--%>
						<%--<c:if test="${ssPartnerCode eq 'tamnao'}">--%>
						<ul class="btn_rt01">
							<li class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></li>
						</ul>
						<%--</c:if>--%>
					<%--</c:if>--%>
				</div>
			</form>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>