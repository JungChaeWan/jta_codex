<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<script type="text/javascript">
// 조회 & 페이징
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/pointUsageInfo.do'/>";
	document.frm.submit();
}

/**
 * 사용자 정보 상세보기
 */
function fn_DetailUser(userId){
	document.frm.userId.value = userId;
	document.frm.action = "<c:url value='/oss/detailUser.do'/>";
	document.frm.submit();
}

function fn_ExcelDown() {
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/pointUsageInfoExcel.do?"+ parameters +"'/>";
}
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=user" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=user&sub=user" flush="false"></jsp:include>
		<div id="contents_area">
			<form id="frm" name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="userId" name="userId" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />
			<div id="contents">
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="140" />
                                	<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
          								<th scope="row">아&nbsp;이&nbsp;디</th>
          								<td><input type="text" id="sUserId" class="input_text_full" name="sUserId" value="${searchVO.sUserId}" title="검색하실 아이디를 입력하세요." /></td>
          								<th scope="row">고&nbsp;객&nbsp;명</th>
          								<td><input type="text" id="sUserNm" class="input_text_full" name="sUserNm" value="${searchVO.sUserNm}" title="검색하실 고객명를 입력하세요." /></td>
       								</tr>
               						<tr>
               							<th scope="row">이&nbsp;메&nbsp;일</th>
          								<td><input type="text" id="sEmail" class="input_text_full" name="sEmail" value="${searchVO.sEmail}" title="검색하실 이메일를 입력하세요." /></td>
          								<th scope="row">연락처</th>
          								<td><input type="text" id="sTelNum" class="input_text_full" name="sTelNum" value="${searchVO.sTelNum}" title="검색하실 전화번호를 입력하세요." /></td>
       								</tr>
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
                    </div>
                </div>

				<!--사용포인트-->
				<div class="search_box">
					<div class="search_form">
						<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="140" />
									<col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">예산액</th>
									<td><fmt:formatNumber><c:out value="${pointInfo.partnerBudget}" /></fmt:formatNumber></td>
									<th scope="row">총 발급 포인트</th>
									<td><fmt:formatNumber><c:out value="${pointInfo.plusPoint}" /></fmt:formatNumber></td>
									<th scope="row">총 사용 포인트</th>
									<td><fmt:formatNumber><c:out value="${pointInfo.minusPoint}" /></fmt:formatNumber></td>
								</tr>

								</tbody>
							</table>
						</div>
					</div>
				</div>

                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>번호</th>
							<th>이메일</th>
							<th>고객명</th>
							<th>연락처</th>
							<th>발급포인트</th>
							<th>사용포인트</th>
							<th>최종 로그인 일시</th>
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
						<c:forEach var="userInfo" items="${resultList}" varStatus="status">
							<tr style="cursor:pointer;" onclick="fn_DetailUser('${userInfo.userId}')">
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct"><c:out value="${userInfo.email}" /></td>
								<td class="align_ct"><c:out value="${userInfo.userNm}" /></td>
								<td class="align_ct"><c:out value="${userInfo.telNum}" /></td>
								<td class="align_ct">
									<fmt:formatNumber><c:out value="${userInfo.plusPoint}" /></fmt:formatNumber>
								</td>
								<td class="align_ct">
									<fmt:formatNumber><c:out value="${userInfo.minusPoint}" /></fmt:formatNumber>
								</td>
								<td class="align_ct"><c:out value="${userInfo.lastLoginDttm}" /></td>

							</tr>
						</c:forEach>
					</tbody>
				</table>

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