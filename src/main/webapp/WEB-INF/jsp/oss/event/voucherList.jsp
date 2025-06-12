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
	document.frm.action = "<c:url value='/oss/event/voucherMng.do'/>";
	document.frm.submit();
}


function fn_ExcelDown(){
	frmFileDown.location = "<c:url value='/oss/event/excelDownGSJoinList2018.do'/>";
}

function fn_InsJoin(){
    document.frm.action = "<c:url value='/oss/event/insertVoucherMng.do'/>";
    document.frm.submit();
}



$(document).ready(function(){

});

</script>

</head>
<body>
<div id="wrapper" class="container-fluid">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=grandSale2018" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<div id="menu_depth3">
						<ul>
							<li class="on"><a class="menu_depth3" href="<c:url value='/oss/event/voucherMng.do'/>">탐나오상품권</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/pointJoinList2018.do'/>">상품권대상관리</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/pointList2018.do'/>">상품권현황</a></li>
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
				                                <col width="100" />
				                            </colgroup>
				             				<tbody>
				             					<tr>
				               						<th scope="row">상품권명</th>
        											<td>
                                                                               <input type="text" id="sVcNm" class="form-control" name="sVcNm" value="${searchVO.sVcNm}" title="코드명을 입력하세요." />
        											</td>
				               					</tr>
				     						</tbody>
				               			</table>
				               		</div>
                                                        <span class="btn">
                                                                               <button type="button" class="btn btn-primary" onclick="fn_Search('1');">검색</button>
                                                                        </span>
			              	</div>
			            </div>
						<!--검색-->
						<p style="font-size: 12px; padding-top: 5px; font-weight: 700; position: relative; top: -40px; clear: both;">
							1.코드는 자동생성. <br>
							2.상품권 기간이 중복이고, 사용자가 해당기간에 모두 상품권이 발급이 된다면 만료일 다음날 부터 다른 상품권을 사용할 수 있습니다.<br>
							3.상품권을 생성하고 상품권이 사용되면, 해당하는 데이터는 변경이 불가능합니다. 상품권사용 전 변경을 하고 싶다면 시스템담당자에게 요청바랍니다.
						</p>

						<p class="search_list_ps title-btn">[총 <strong>${totalCnt}</strong>건]
							<!-- <span class="side-wrap"><a class="btn_sty04" href="javascript:fn_ExcelDown();">엑셀다운로드</a></span> -->
						</p>
                                                <div class="table-responsive">
                                                <table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th>순번</th>
									<th>코드</th>
									<th>상품권명</th>
									<th>시작일</th>
									<th>만료일</th>
									<th>설명</th>
									<th>등록일</th>
									<th>등록ID</th>
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
										<td class="align_ct"><c:out value="${data.vcCd}" /></td>
										<td class="align_ct"><c:out value="${data.vcNm}"/></td>
										<td class="align_ct"><c:out value="${data.exprStartDt}"/></td>
										<td class="align_ct"><c:out value="${data.exprEndDt}"/></td>
										<td class="align_ct"><c:out value="${data.vcExp}"/></td>
										<td class="align_ct"><c:out value="${data.regDttm}"/></td>
										<td class="align_ct"><c:out value="${data.regId}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						</div>
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
					</form>
                                        <ul class="btn_rt01">
                                                <li><button type="button" class="btn btn-primary" onclick="fn_InsJoin()">등록</button></li>
                                        </ul>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
