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
	document.frm.action = "<c:url value='/oss/userList.do'/>";
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

/**
 * 사용자 등록 화면 호출
 */
function fn_InsUser(){
	document.frm.action = "<c:url value='/oss/viewInsertUser.do' />";
	document.frm.submit();
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();

	frmFileDown.location = "<c:url value='/oss/userSaveExcel.do?" + parameters + "'/>";

	<%--document.frm.pageIndex.value = '0';
	document.frm.action = "<c:url value='/oss/userSaveExcel.do'/>";
	document.frm.submit();--%>
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
       								<tr>
       									<th scope="row">사용자 구분</th>
          								<td>
          									<select id="sCorpAdminDiv" name="sCorpAdminDiv">
          										<option value="">전체</option>
          										<option value="A" <c:if test="${searchVO.sCorpAdminDiv == 'A'}">selected</c:if>>관리자</option>
          										<option value="C" <c:if test="${searchVO.sCorpAdminDiv == 'C'}">selected</c:if>>입점업체관리자</option>
          										<option value="N" <c:if test="${searchVO.sCorpAdminDiv == 'N'}">selected</c:if>>일반사용자</option>
          									</select>
										</td>
										<th scope="row">블랙리스트</th>
          								<td>
          									<select id="sBadUserYn" name="sBadUserYn">
          										<option value="">전체</option>
          										<option value="N" <c:if test="${searchVO.sBadUserYn == 'N'}">selected</c:if>>일반고객</option>
          										<option value="Y" <c:if test="${searchVO.sBadUserYn == 'Y'}">selected</c:if>>블랙리스트</option>
          									</select>
										</td>
       								</tr>
									<c:if test="${ssPartnerCode eq 'tamnao'}">
       								<tr>
       									<th scope="row">파트너코드</th>
          								<td>
          									<select id="sPartnerCd" name="sPartnerCd">
          										<option value="">전체</option>
          										<option value="CHSN" <c:if test="${searchVO.sPartnerCd == 'CHSN'}">selected</c:if>>조선일보</option>
          									</select>
										</td>
       								</tr>
									</c:if>
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
                    </div>
                </div>
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>번호</th>
							<th>사용자아이디</th>
							<th>고객명</th>
							<th>연락처</th>
							<th>권한</th>
							<th>SNS여부</th>
							<th>업체관리자</th>
							<th>마케팅 수신여부</th>
							<th>최종 로그인 일시</th>
							<th>가입 일시</th>
							<th>블랙리스트</th>
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
								<td class="align_ct"><c:out value="${userInfo.userId}" /></td>
								<td class="align_ct"><c:out value="${userInfo.userNm}" /></td>
								<td class="align_ct"><c:out value="${userInfo.telNum}" /></td>
								<td class="align_ct">
									<c:if test="${userInfo.authNm=='USER'}">일반사용자</c:if>
									<c:if test="${userInfo.authNm=='ADMIN'}">관리자</c:if>
								</td>
								<td class="align_ct">
									<c:if test="${fn:contains(userInfo.snsDiv, 'N')}"><img src="/images/web/sns/info/naver.png"></c:if>
									<c:if test="${fn:contains(userInfo.snsDiv, 'K')}"><img src="/images/web/sns/info/kakao.png"></c:if>
								</td>
								<td class="align_ct">
									<c:if test="${userInfo.corpAdmYn=='Y'}"><img src="<c:url value='/images/oss/icon/icon_admin.png'/>" alt="입점업체관리자" /></c:if>
								</td>
								<td class="align_ct"><c:out value="${userInfo.marketingRcvAgrYn }" /></td>
								<td class="align_ct"><c:out value="${userInfo.lastLoginDttm}" /></td>
								<td class="align_ct"><c:out value="${userInfo.frstRegDttm}" /></td>
								<td class="align_ct"><c:if test="${userInfo.badUserYn=='Y'}">불량</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<c:if test="${ssPartnerCode eq 'tamnao'}">
				<ul class="btn_rt01">
					<li class="btn_sty02">
						<a href="javascript:fn_SaveExcel()">이메일 목록 엑셀저장</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_InsUser()">등록</a>
					</li>
				</ul>
				</c:if>
			</div>
			</form>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>