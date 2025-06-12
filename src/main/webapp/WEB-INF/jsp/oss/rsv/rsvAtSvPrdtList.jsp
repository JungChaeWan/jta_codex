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

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	var strDate = $("#sStartDt").val().replace(/-/g,"");
	var strDate2 = $("#sEndDt").val().replace(/-/g,"");
	
	if(!isNull(strDate)){
		if(!CheckDate(strDate)){
			alert("날짜를 잘못 입력하셨습니다.\n예) 2016-01-01");
			return;
		}
	}
	if(!isNull(strDate2)){
		if(!CheckDate(strDate2)){
			alert("날짜를 잘못 입력하셨습니다.\n예) 2016-01-01");
			return;
		}
	}
	if(!isNull(strDate) && !isNull(strDate2)){
		if(!checkByFromTo($("#sStartDt").val(), $("#sEndDt").val(), "Y")){
			alert("검색시작일자가 검색종료일자보다 미래일입니다.");
			return;
		}
	}
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/rsvAtSvPrdtList.do'/>";
	document.frm.submit();
}

function fn_DetailRsv(rsvNum){
	$("#rsvNum").val(rsvNum);

	document.frm.action = "<c:url value='/oss/detailRsvAtSvPrdt.do'/>";
	document.frm.submit();
}

function fn_ExcelDown(){
	var parameters = $("#frm").serialize();
	
	frmFileDown.location = "<c:url value='/oss/rsvExcelDown2.do?'/>" + parameters;
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
		<jsp:include page="/oss/left.do?menu=rsv&sub=rsv2" />
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="rsvNum" name="rsvNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<div id="menu_depth3">
						<ul>
							<li><a class="menu_depth3" href="<c:url value='/oss/rsvAtPrdtList.do'/>">관광상품</a></li>
							<li class="on"><a class="menu_depth3" href="<c:url value='/oss/rsvAtSvPrdtList.do'/>">특산/기념품</a></li>
						</ul>
					</div>
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form" style="min-width: 800px;">
								<table width="100%" border="0">
									<colgroup>
										<col width="55" />
										<col width="*" />
										<col width="90" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">구매일자</th>
											<td>
												<input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt}"  title="검색시작일" /> ~
												<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일"   value="${searchVO.sEndDt}"/>
											</td>
											<th scope="row">구매상태</th>
											<td>
												<select name="sRsvStatusCd" style="width:100%">
													<option value="">전체</option>
													<option value="${Constant.RSV_STATUS_CD_READY}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_READY}">selected="selected"</c:if>>구매처리중</option>
													<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>구매완료</option>
													<option value="${Constant.RSV_STATUS_CD_DLV}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">selected="selected"</c:if>>배송중</option>
													<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
													<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청</option>
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
										<tr>
											<th scope="row">예약번호</th>
											<td>
												<input type="text" id="sRsvNum" class="input_text13" name="sRsvNum" value="${searchVO.sRsvNum}" title="검색하실 예약번호를 입력하세요." maxlength="20" />
											</td>
											<th scope="row">자동취소</th>
											<td>
												<select name="sAutoCancelViewYn" id="sAutoCancelViewYn" style="width:100%">
													<option value="N" <c:if test="${searchVO.sAutoCancelViewYn == 'N'}">selected="selected"</c:if>>포함안함</option>
													<option value="Y" <c:if test="${searchVO.sAutoCancelViewYn == 'Y'}">selected="selected"</c:if>>포함</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">구&nbsp;매&nbsp;자</th>
											<td><input type="text" id="sRsvNm" class="input_text13" name="sRsvNm" value="${searchVO.sRsvNm}" title="검색하실 예약자를 입력하세요." maxlength="20" /></td>
											<th scope="row">상품구분</th>
											<td>
												<select name="sPrdtCd" style="width:100%">
													<option value="">전체</option>
													<c:forEach items="${ctgrList}" var="ctgr" varStatus="status">
														<option value="${ctgr.cdNum}" <c:if test="${ctgr.cdNum eq searchVO.sPrdtCd}">selected="selected"</c:if>><c:out value="${ctgr.cdNm}" /></option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">업&nbsp;체&nbsp;명</th>
											<td><input type="text" id="sCorpNm" class="input_text13" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명를 입력하세요." maxlength="20" /></td>
											<th scope="row">상&nbsp;품&nbsp;명</th>
											<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." maxlength="13" /></td>
										</tr>
										<tr>
											<th scope="row">구&nbsp;매&nbsp;ID</th>
											<td>

												<select name="sGuestYn" style="width:175px;">
													<option value="">전체</option>
													<option value="N" <c:if test="${searchVO.sGuestYn == 'N' }"> selected="selected" </c:if>>회원</option>
													<option value="Y" <c:if test="${searchVO.sGuestYn == 'Y' }">selected="selected"</c:if> >비회원</option>
												</select>
											</td>
											<th scope="row">이벤트 코드</th>
											<td>
												<input type="text" id="sEvntCd" class="input_text13" name="sEvntCd" value="${searchVO.sEvntCd}" title="검색하실 이벤트코드를 입력하세요." maxlength="30" />
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
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<colgroup>
								<col width="120" />
								<col />
								<col width="100" />
								<col width="100" />
								<col width="220" />
								<col width="100" />
								<col width="120" />
								<col width="120" />
								<col width="100" />
							</colgroup>
							<thead>
								<tr>
									<th>예약번호</th>
									<th>예약정보</th>
									<th>예약상태</th>
									<th>배송정보</th>
									<th>상품금액</th>
									<th>구매일시</th>
									<th>구매자</th>
									<th>수령인</th>
									<th>구매ID</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="9" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach items="${resultList}" var="rsvInfo" varStatus="stauts">
									<tr style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.rsvNum}')">
										<td class="align_ct">${rsvInfo.rsvNum}</td>
										<td class="align_lt">
											<p>[<c:out value="${rsvInfo.prdtCdNm}"/>]</p>
											<h5 style="font-size: 12px;"><span class="cProduct"><c:out value="${rsvInfo.corpNm}"/> <c:out value="${rsvInfo.prdtNm}"/></span></h5>
											<p><c:out value="${rsvInfo.prdtInf}"/></p>
										</td>
										<td class="align_ct">
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">구매처리중</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">구매완료</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">배송중</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">
												<span class="font02">취소요청</span>
												<br>(<c:out value="${rsvInfo.cancelRequestDttm}"/>)
											</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}"><span class="font02">환불요청</span></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료<br>(<c:out value="${rsvInfo.cancelCmplDttm}"/>)</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}"><span class="font02">부분환불요청</span></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료
												<c:if test="${rsvInfo.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
														<br>(<c:out value="${rsvInfo.useDttm}"/>)
												</c:if>
											</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">
												구매확정<br>(<c:out value="${rsvInfo.buyFixDttm}"/>)
											</c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${empty rsvInfo.dlvNum}"><p>-</p></c:if>
											<c:if test="${not empty rsvInfo.dlvNum}">
												<p><c:out value="${rsvInfo.dlvCorpNm}"/></p>
												<p><c:out value="${rsvInfo.dlvNum}"/></p>
											 </c:if>
										</td>
										<td class="align_rt">
											<div class="price-wrap">
												<p>
													<span class="text">상품금액</span>
													<span class="price"><fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber>원</span>
												</p>
												<p>
													<span class="text">(-)&nbsp;할인금액</span>
													<span class="price"><fmt:formatNumber>${rsvInfo.disAmt}</fmt:formatNumber>원</span>
												</p>
												<p class="total">
													<span class="text"><strong>결제금액</strong></span>
													<span class="price font03"><fmt:formatNumber>${rsvInfo.saleAmt}</fmt:formatNumber>원</span>
												</p>
											</div>
										</td>
										<td class="align_ct"><c:out value='${rsvInfo.regDttm}'/></td>
										<td class="align_ct">
											<p><c:out value='${rsvInfo.rsvNm}'/></p>
											<p>(<c:out value='${rsvInfo.rsvTelnum}'/>)</p>
										</td>
										<td class="align_ct">
											<p><c:out value='${rsvInfo.useNm}'/></p>
											<p>(<c:out value='${rsvInfo.useTelnum}'/>)</p>
										</td>
										<td class="align_ct">
											<c:if test="${Constant.RSV_GUSET_NAME == rsvInfo.userId}">
												<p>비회원</p>
											</c:if>
											<c:if test="${Constant.RSV_GUSET_NAME != rsvInfo.userId}">
												<p>회원</p>
												<p>(<c:out value='${rsvInfo.userId}'/>)</p>
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
						<li class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>