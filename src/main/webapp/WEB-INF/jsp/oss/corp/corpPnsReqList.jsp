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
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/corpPnsReqList.do'/>";
	document.frm.submit();
}

function fn_viewCorpOnsReq(requestNum) {
	document.frm.requestNum.value = requestNum;
	document.frm.action = "<c:url value='/oss/detailCorpPnsReq.do'/>";
	document.frm.submit();
}

function fn_ExcelDown(){
	var parameters = $("#frm").serialize();

	frmFileDown.location = "<c:url value='/oss/corpPnsReqExcelDown.do' />?" + parameters;
}

$(function() {
	$("#sStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});

    $("#sStartDt2").datepicker({
        onClose : function(selectedDate) {
            $("#sEndDt").datepicker("option", "minDate", selectedDate);
        }
    });
    $("#sEndDt2").datepicker({
        onClose : function(selectedDate) {
            $("#sStartDt").datepicker("option", "maxDate", selectedDate);
        }
    });
});
</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corpapp" />

		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="requestNum" id="requestNum" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>

				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="100" />
										<col width="300" />
										<col width="100" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">카테고리</th>
											<td>
												<select name="sCorpCd">
													<option value="">전 체</option>
													<c:forEach var="corpCd" items="${corpCdList}">
														<option value="${corpCd.cdNum}" <c:if test="${corpCd.cdNum eq searchVO.sCorpCd}">selected="true"</c:if>><c:out value="${corpCd.cdNm}" /></option>
													</c:forEach>
												</select>
											</td>
											<th scope="row">처리상태</th>
											<td>
												<select name="sStatusCd">
													<option value="">전 체</option>
													<option value="${Constant.CORP_STATUS_CD_01}" <c:if test="${Constant.CORP_STATUS_CD_01 eq searchVO.sStatusCd}">selected="true"</c:if>>신청중</option>
													<option value="${Constant.CORP_STATUS_CD_02}" <c:if test="${Constant.CORP_STATUS_CD_02 eq searchVO.sStatusCd}">selected="true"</c:if>>승인검토중</option>
													<option value="${Constant.CORP_STATUS_CD_03}" <c:if test="${Constant.CORP_STATUS_CD_03 eq searchVO.sStatusCd}">selected="true"</c:if>>승인완료</option>
													<option value="${Constant.CORP_STATUS_CD_04}" <c:if test="${Constant.CORP_STATUS_CD_04 eq searchVO.sStatusCd}">selected="true"</c:if>>입점불가</option>
													<option value="${Constant.CORP_STATUS_CD_05}" <c:if test="${Constant.CORP_STATUS_CD_05 eq searchVO.sStatusCd}">selected="true"</c:if>>입점취소</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">요청일</th>
											<td>
												<input type="text" name="sStartDt" id="sStartDt" class="input_text5" value="${searchVO.sStartDt}">
												&nbsp;~ <input type="text" name="sEndDt" id="sEndDt" class="input_text5" value="${searchVO.sEndDt}">
											</td>
											<th scope="row">처리일</th>
											<td>
												<input type="text" name="sStartDt2" id="sStartDt2" class="input_text5" value="${searchVO.sStartDt2}">
												&nbsp;~ <input type="text" id="sEndDt2" name="sEndDt2" class="input_text5" value="${searchVO.sEndDt2}">
											</td>
										</tr>
										<tr>
											<th scope="row">업&nbsp;체&nbsp;명</th>
											<td colspan="3">
												<input type="text" name="sCorpNm" id="sCorpNm" class="input_text20" value="${searchVO.sCorpNm}" title="검색하실 업체명를 입력하세요." />
											</td>
										</tr>

									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="<c:url value="/images/oss/btn/search_btn01.gif"/>" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>

					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:void(0)" onclick="fn_ExcelDown();">엑셀다운로드</a></div>
					</div>
					<p class="search_list_ps">[총 <strong><fmt:formatNumber value="${totalCnt}" type="number" /></strong>건]</p>

					<table class="table01 list_tb">
						<thead>
							<tr>
								<th>번호</th>
								<th>업체명</th>
								<th>상태</th>
								<th>대표자명</th>
								<th>담당자명</th>
								<th>전화번호</th>
								<th>휴대전화</th>
								<th>요청일</th>
								<th>처리일</th>
								<th>기능툴</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="10" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;">
									<td class="align_ct"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
									<td><c:out value="${result.corpNm}"/></td>
									<td class="align_ct">
										<c:choose>
											<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_01}">신청중</c:when>
											<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_02}">승인검토중</c:when>
											<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_03}">승인완료</c:when>
											<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_04}">입점불가</c:when>
											<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_05}">입점취소</c:when>
										</c:choose>
									</td>
									<td class="align_ct"><c:out value="${result.ceoNm}"/></td>
									<td class="align_ct"><c:out value="${result.admNm}"/></td>
									<td class="align_ct"><c:out value="${result.admTelnum}"/></td>
									<td class="align_ct"><c:out value="${result.admMobile}"/></td>
									<td class="align_ct">
										<fmt:parseDate var="frstRegDttm" value="${result.frstRegDttm}" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="align_ct">
										<fmt:parseDate var="lastModDttm" value="${result.lastModDttm}" pattern="yyyy-MM-dd" />
										<fmt:formatDate value="${lastModDttm}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="javascript:void(0)" onclick="fn_viewCorpOnsReq('${result.requestNum}');">상세</a></span></div>
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
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>