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
	//alert(document.frm.sBbsNm.value);
	
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/bbsList.do'/>";
	document.frm.submit();
}

/**
 * 업체 정보 상세보기
 */
function fn_Udt(bbsNum){
	document.frm.bbsNum.value = bbsNum;
	document.frm.action = "<c:url value='/oss/viewUpdateBbs.do'/>";
	document.frm.submit();
}


function fn_Ins(){
	document.frm.action = "<c:url value='/oss/viewInsertBbs.do' />";
	document.frm.submit();
}
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=setting"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=bbs"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="bbsNum" name="bbsNum" />
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
								</colgroup>
               					<tbody>
               						<tr>
          								<th scope="row">
          									<select name="sKeyOpt" id="sKeyOpt" style="width:100px">
												<option value="1" <c:if test="${searchVO.sKeyOpt == '1'}">selected="selected"</c:if>>게시판 ID</option>
												<option value="2" <c:if test="${searchVO.sKeyOpt == '2'}">selected="selected"</c:if>>게시판 이름</option>
											</select>
										</th>
          								<td colspan="3">
          									<input type="text" id="sKey" class="input_text_full" name="sKey" value="${searchVO.sKey}" title="검색하실 코드명를 입력하세요." />
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
	                
	                
	                <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>ID</th>
							<th>이름</th>
							<th>구분</th>
							<th>관리자</th>
							<th>답변 (삭제)</th>
	                        <th>댓글 (삭제)</th>
	                        <th>에디터</th>
	                        <th>첨부파일 수</th>
	                        <th>공지글</th>
	                        <th>익명글</th>
	                        <th>평점</th>
	                        <th>목록권한</th>
							<th>상세권한</th>
							<th>등록권한</th>
							<th>수정권한</th>
							<th>삭제권한</th>
							<th>답변권한</th>
							<th>댓글권한</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="18" align="center">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="data" items="${resultList}" varStatus="status">
							<tr style="cursor:pointer;" onclick="fn_Udt('${data.bbsNum}')">
								<td class="align_ct">${data.bbsNum}</td>
								<td class="align_ct"><c:out value='${data.bbsNm}'/></td>
								<td>
									<c:choose>
										<c:when test="${data.bbsDiv==0}">List</c:when>
										<c:when test="${data.bbsDiv==1}">Grid</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								<td><c:out value='${data.admId}' /></td>
									<td>${data.ansYn}(${data.ansDelYn})</td>
									<td>${data.cmtYn}(${data.cmtDelYn})</td>
								<td>${data.edtYn}</td>
								<td>
									<c:choose>
										<c:when test="${data.atcFileNum == 0}">사용안함</c:when>
										<c:otherwise>${data.atcFileNum}</c:otherwise>
									</c:choose>
								</td>
								<td>${data.anmUseYn}</td>
								<td>${data.annmYn}</td>
								<td>${data.gpaUseYn}</td>
							
								<td>
									<c:choose>
										<c:when test="${data.listAuth==7}">관리</c:when>
										<c:when test="${data.listAuth==5}">업체</c:when>
										<c:when test="${data.listAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${data.dtlAuth==7}">관리</c:when>
										<c:when test="${data.dtlAuth==5}">업체</c:when>
										<c:when test="${data.dtlAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${data.regAuth==7}">관리</c:when>
										<c:when test="${data.regAuth==5}">업체</c:when>
										<c:when test="${data.regAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose></td>
								<td>
									<c:choose>
										<c:when test="${data.modAuth==7}">관리</c:when>
										<c:when test="${data.modAuth==5}">업체</c:when>
										<c:when test="${data.modAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose></td>
								<td>
									<c:choose>
										<c:when test="${data.delAuth==7}">관리</c:when>
										<c:when test="${data.delAuth==5}">업체</c:when>
										<c:when test="${data.delAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${data.ansAuth==7}">관리</c:when>
										<c:when test="${data.ansAuth==5}">업체</c:when>
										<c:when test="${data.ansAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${data.cmtAuth==7}">관리</c:when>
										<c:when test="${data.cmtAuth==5}">업체</c:when>
										<c:when test="${data.cmtAuth==1}">일반</c:when>
										<c:otherwise>익명</c:otherwise>
									</c:choose>
								</td>
							</tr>						
						</c:forEach>
						
					</tbody>
				</table>
				
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_Ins()">등록</a>
					</li>
				</ul>
					
			
				</div>
			</form>
		
		</div>
	</div>
</div>
</body>
</html>