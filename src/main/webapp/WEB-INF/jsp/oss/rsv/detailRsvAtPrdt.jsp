<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>

<script type="text/javascript">
function fn_ListRsv(){
	document.frm.action = "<c:url value='/oss/rsvAtPrdtList.do'/>";
	document.frm.submit();
}

function fn_RefundComplete(prdtRsvNum){
	var parameters = "prdtRsvNum=" + prdtRsvNum + "&rsvNum=" + $("#rsvNum").val();

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/refundComplete.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("환불완료처리가 정상적으로 처리됐습니다.");
			document.frm.action = "<c:url value='/oss/detailRsv.do'/>";
			document.frm.submit();
		},
		error:fn_AjaxError
	});
}

$(document).ready(function(){

});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=rsv" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=rsv&sub=rsv2" />
		<div id="contents_area"> 
			<form name="frm" method="post">
				<input type="hidden" name="rsvNum" id="rsvNum" value="${rsvInfo.rsvNum}" />
				<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}" />
				<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}" />
				<input type="hidden" name="sRsvStatusCd" id="sRsvStatusCd" value="${searchVO.sRsvStatusCd}" />
				<input type="hidden" name="sRsvNum" id="sRsvNum" value="${searchVO.sRsvNum}" />
				<input type="hidden" name="sAutoCancelViewYn" id="sAutoCancelViewYn" value="${searchVO.sAutoCancelViewYn}" />
				<input type="hidden" name="sRsvNm" id="sRsvNm" value="${searchVO.sRsvNm}" />
				<input type="hidden" name="sRsvTelnum" id="sRsvTelnum" value="${searchVO.sRsvTelnum}" />

				<div id="contents">
				<!--본문-->
				<!--상품 등록-->
					<ul class="form_area">
						<li>
							<table border="1" cellpadding="0" cellspacing="0" class="table02">
								<caption class="tb02_title">예약 기본 정보</caption>
								<colgroup>
									<col width='15%' />
									<col width='35%' />
									<col width='15%' />
									<col width='35%' />
								</colgroup>
								<tr>
									<th> 예약번호 </th>
									<td colspan="3"><c:out value="${rsvInfo.rsvNum}"/></td>
									<%-- <th>예약상태</th>
									<td>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
									</td> --%>
								</tr>
								<tr>
									<th>예약자명</th>
									<td><c:out value="${rsvInfo.rsvNm}"/></td>
									<th>사용자명</th>
									<td><c:out value="${rsvInfo.useNm}"/></td>
								</tr>
								<tr>
									<th>예약자 이메일</th>
									<td><c:out value="${rsvInfo.rsvEmail}"/></td>
									<th>사용자 이메일</th>
									<td><c:out value="${rsvInfo.useEmail}"/></td>
								</tr>
								<tr>
									<th>예약자 전화번호</th>
									<td><c:out value="${rsvInfo.rsvTelnum}"/></td>
									<th>사용자 전화번호</th>
									<td><c:out value="${rsvInfo.useTelnum}"/></td>
								</tr>
							</table>
						</li>
						<li>
							<table border="1" cellpadding="0" cellspacing="0" class="table01">
								<caption class="tb02_title">결제 정보</caption>
								<thead>
									<tr>
										<th scope="col">총상품금액</th>
										<th scope="col">할인금액</th>
										<th scope="col">결제금액</th>
										<th scope="col">결제수단</th>
									</tr>
								</thead>
								<tr>
									<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt}"/></fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber></td>
									<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber></td>
									<td class="align_ct">
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_EI}">계좌이체(에스크로)</c:if>
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
									</td>
								</tr>
							</table>
						</li>
						<li>
							<table border="1" cellpadding="0" cellspacing="0" class="table03">
								<caption class="tb02_title">예약 상품 정보</caption>
								<%-- <colgroup>
								<col width='50%' />
								<col width='50%' />
								</colgroup> --%>
								<!-- <thead>
									<tr>
										<th class="align_ct">구분</th>
										<th>예약상태</th>
										<th>상품정보</th>
										<th>상품금액</th>
										<th>최종금액</th>
										<th>비고</th>
									</tr>
								</thead> -->
								<c:forEach var="order" items="${orderList}" varStatus="status">
									<tr class="bg01">
										<th scope="col">[${order.prdtCdNm}] <span class="font03">${order.prdtNm}</span></th>
										<th scope="col" width="343">업체명 : ${order.corpNm}</th>
										<th scope="col" width="300">예약상태 :
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약처리중</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">
												<span class="font02">취소요청</span>
												<br>(<c:out value="${order.cancelRequestDttm}"/>)
											</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료
												<c:if test="${order.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
													<br>(<c:out value="${order.useDttm}"/>)
												</c:if>
											</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료
												<c:if test="${order.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
													<br>(<c:out value="${order.useDttm}"/>)
												</c:if>
											</c:if>
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
										</th>
									</tr>
									<tr>
										<td colspan="3">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
												<caption class="tb04_title">예약정보 상세</caption>
												<tr class="tr_line">
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<colgroup>
																<col width="20%" />
																<col width="80%" />
															</colgroup>
															<tr>
																<th scope="col">ㆍ예약정보</th>
																<td><c:out value="${order.prdtInf}"/></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<colgroup>
																<col width="10%" />
																<col width="23%" />
																<col width="10%" />
																<col width="23%" />
																<col width="10%" />
																<col width="*" />
																</colgroup>
															<tr>
																<th scope="col">ㆍ상품금액</th>
																<td><strong><fmt:formatNumber><c:out value="${order.nmlAmt}"/></fmt:formatNumber></strong> 원</td>
																<th scope="col">ㆍ할인금액</th>
																<td><strong><fmt:formatNumber><c:out value="${order.disAmt}"/></fmt:formatNumber></strong> 원</td>
																<th scope="col">ㆍ판매금액</th>
																<td><strong class="font03"><fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber></strong> 원</td>
															</tr>
														</table>
													</td>
												</tr>
												<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ)
															or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)
															or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM)}">
													<tr>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<colgroup>
																	<col width="10%">
																	<col width="*">
																</colgroup>
																<tbody>
																	<tr>
																		<th scope="col">ㆍ취소사유</th>
																		<td style="text-align: left"><c:out value="${order.cancelRsn}"/></td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</c:if>
											</table>
										</td>
									</tr>
									<c:if test="${	(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or
													(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM) or
													(order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ) or
													(order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM)}">
										<tr class="bg02">
											<td colspan="3">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
													<caption class="tb04_title font02">예약 취소 상세</caption>
													<tr>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<colgroup>
																	<col width="10%" />
																	<col width="23%" />
																	<col width="10%" />
																	<col width="23%" />
																	<col width="10%" />
																	<col width="17%" />
																	<col width="*" />
																</colgroup>
																<tr>
																	<th scope="col">ㆍ취소금액</th>
																	<td><strong class="font03"><fmt:formatNumber><c:out value="${order.cancelAmt}"/></fmt:formatNumber></strong> 원</td>
																	<th scope="col">ㆍ취소 할인금액</th>
																	<td><strong><fmt:formatNumber><c:out value="${order.disCancelAmt}"/></fmt:formatNumber></strong> 원</td>
																	<th scope="col">ㆍ취소 수수료</th>
																	<td><strong class="font02"><fmt:formatNumber><c:out value="${order.cmssAmt}"/></fmt:formatNumber></strong> 원</td>
																	<td>
																		<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ)}">
																			<div class="btn_sty09"><a href="javascript:fn_RefundComplete('${order.prdtRsvNum}')">환불 완료</a></div>
																		</c:if>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</li>
					</ul>
					<!--//상품등록-->
					<!--//본문-->
					<ul class="btn_rt01">
						<li class="btn_sty01"><a href="javascript:fn_ListRsv()">목록</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>