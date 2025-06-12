<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"	uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


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
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/event/pointList2018.do'/>";
	document.frm.submit();
}


function fn_ExcelDown(){
	frmFileDown.location = "/oss/event/excelVoucherStatus.do?sVcCd=" + $("#sVcCd").val();
}

$(document).ready(function(){

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=grandSale2018" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<div id="menu_depth3">
						<ul>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/voucherMng.do'/>">탐나오상품권</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/pointJoinList2018.do'/>">상품권대상관리</a></li>
							<li class="on"><a class="menu_depth3" href="<c:url value='/oss/event/pointList2018.do'/>">상품권현황</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/grandSaleJoinList2018.do'/>">참여현황</a></li>

		                </ul>
		            </div>
					<form name="frm" id="frm" method="post" onSubmit="return false;">
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

						<div id="contents">
							<h4 class="title03">포인트 현황</h4>
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
				               						<th scope="row">사용자명</th>
        											<td>
        												<input type="text" id="sUserNm" class="input_text_full" name="sUserNm" value="${searchVO.sUserNm}" title="검색하실 사용자를 입력하세요." />
        											</td>
													<th scope="row">상품권명</th>
													<td>
														<select name="sVcCd" id="sVcCd" style="width:148px">
															<option value="">전체</option>
															<c:forEach var="data" items="${voucherList}"	varStatus="status">
															<option value="${data.vcCd}" <c:if test="${data.vcCd eq searchVO.sVcCd}">selected</c:if>>${data.vcNm}</option>
															</c:forEach>
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
						<!--검색-->

						<p class="search_list_ps title-btn">[총 <strong>${totalCnt}</strong>건]
							<span class="side-wrap"><a class="btn_sty04" href="javascript:fn_ExcelDown();">엑셀다운로드</a></span>
						</p>
						<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>순번</th>
									<th>상품권명</th>
									<th>사용자ID</th>
									<th>사용자</th>
									<th>전화번호</th>
									<th>지급 포인트</th>
									<th>사용 포인트</th>
									<th>취소 포인트</th>
									<th>잔여 포인트</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="10" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="data" items="${resultList}"	varStatus="status">
									<tr>
										<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
										<td class="align_ct"><c:out value="${data.vcNm}" /></td>
										<td class="align_ct"><c:out value="${data.userId}"/></td>
										<td class="align_ct"><c:out value="${data.userNm}" /></td>
										<td class="align_ct"><c:out value="${data.telNum}" /></td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${data.savePoint}"/></fmt:formatNumber></td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${data.usePoint}"/></fmt:formatNumber></td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${data.cancelPoint}"/></fmt:formatNumber></td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${data.remainingPoint}"/></fmt:formatNumber></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						</div>
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
						
						<!-- <ul class="btn_rt01">
							<li class="btn_sty04"><a href="javascript:fn_Ins()">등록</a></li>
						</ul> -->
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>
