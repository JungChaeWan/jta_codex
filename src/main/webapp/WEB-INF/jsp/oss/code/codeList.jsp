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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/codeList.do'/>";
	document.frm.submit();
}

/**
 * 코드 정보 상세보기
 */
function fn_UdtCode(cdNum){
	document.frm.cdNum.value = cdNum;
	document.frm.action = "<c:url value='/oss/viewUpdateCode.do'/>";
	document.frm.submit();
}

function fn_InsCode(){
	document.frm.action = "<c:url value='/oss/viewInsertCode.do' />";
	document.frm.submit();
}
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=code" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="cdNum" name="cdNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<!--검색-->
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
          								<th scope="row">코&nbsp;드&nbsp;명</th>
          								<td><input type="text" id="sCdNm" class="input_text_full" name="sCdNm" value="<c:out value='${searchVO.sCdNm}'/>" title="검색하실 코드명를 입력하세요." /></td>
          								<th scope="row">코&nbsp;&nbsp;드</th>
          								<td><input type="text" id="sCdNum" class="input_text_full" name="sCdNum" value="<c:out value='${searchVO.sCdNum}'/>" title="검색하실 코드를 입력하세요." /></td>
       								</tr>
               						<tr>
          								<th scope="row">상위코드명</th>
          								<td><input type="text" id="sHrkCdNm" class="input_text_full" name="sHrkCdNm" value="${searchVO.sHrkCdNm}" title="검색하실 상위코드명를 입력하세요." /></td>
          								<th scope="row">상위코드</th>
          								<td><input type="text" id="sHrkCdNum" class="input_text_full" name="sHrkCdNum" value="${searchVO.sHrkCdNum}" title="검색하실 상위코드를 입력하세요." /></td>
       								</tr>
									<tr>
										<th scope="row">사용여부</th>
										<td colspan="3">
											<select id="sUseYn" name="sUseYn">
												<option value="">전체</option>
												<option <c:if test="${searchVO.sUseYn eq 'Y'}">selected="selected"</c:if> value="Y">사용</option>
												<option <c:if test="${searchVO.sUseYn eq 'N'}">selected="selected"</c:if> value="N">미사용</option>
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
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>번호</th>
							<th>코드</th>
							<th>상위코드</th>
							<th>코드명</th>
							<th>코드명 유의어</th>
							<th>사용여부</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="5" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="codeInfo" items="${resultList}" varStatus="status">
							<tr style="cursor:pointer;" onclick="fn_UdtCode('${codeInfo.cdNum}')">
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">${codeInfo.cdNum}</td>
								<td class="align_ct">${codeInfo.hrkCdNum}</td>
								<td class="align_ct">${codeInfo.cdNm}</td>
								<td class="align_ct">${codeInfo.cdNmLike}</td>
								<td class="align_ct">${codeInfo.useYn}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_InsCode()">등록</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>