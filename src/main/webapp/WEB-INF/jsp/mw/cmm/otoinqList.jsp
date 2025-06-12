<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<input type="hidden" name="otoTotalCnt" value="${paginationInfo.totalRecordCount}" />
<input type="hidden" name="otoTotalPageCnt" value="${paginationInfo.totalPageCount}" />
<c:if test="${searchVO.pageIndex eq 1}">
	<div class="title-type3">1:1 문의</div>
	<div class="con-box counsel-form">
		<dl>
			<dt>상품에 대한 궁금한 점 남겨주시면 답변드립니다.</dt>
			<dd>구매한 상품의 취소/환불은 마이페이지를 이용해 주세요.<br>
			상품과 관계없는 광고, 욕설, 비방 등의 글은 사전 예고 없이 삭제처리 됩니다.</dd>
		</dl>
		
		<form name="otoinqFrm" id="otoinqFrm" method="post" onSubmit="return false;">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<input type="hidden" name="corpId" id="corpId" value="${OTOINQVO.corpId}" />
			<input type="hidden" name="prdtNum" id="prdtNum" value="${OTOINQVO.prdtNum}" />
			<input type="hidden" name="corpCd" id="corpCd" value="${searchVO.corpCd}" />
			<input type="hidden" name="subject" id="subject" value="" />
			<input type="hidden" name="contents" id="contents" value="" />
			<input type="hidden" name="otoinqNum" id="otoinqNum" value="" />
		</form>
		
		<c:if test="${isLogin=='Y'}">
			<input type="text" id="oto_subject" value="" class="title-int" placeholder="제목을 입력해 주세요">
			<textarea id="oto_contents" name="textarea" id="textarea" cols="45" rows="5" class="focus-value" placeholder="궁금한 점을 남겨주세요"></textarea>
			<p><a href="#" class="btn btn-submit" onclick="fn_otoinqInsert();">등록</a></p>
		</c:if>
	</div>
	<div class="counsel-list">
		
	<c:if test="${fn:length(otoinqList) == 0}">
		<div class="area">
			<div class="text">
				<br>
				<p class="title">1:1문의가 없습니다.</p>
			</div>
		</div>
	</c:if>
</c:if>
<c:forEach var="data" items="${otoinqList}" varStatus="status">
	<dl>
		<dt class="area">
			<div class="icon"><em>Q</em></div>
			<div class="text">
				<p class="user"><span class="user-id"><c:out value="${data.email}"/></span> <span class="user-date">${data.frstRegDttm}</span></p>
				<p class="title"><c:out value="${data.subject}"/></p>
				<p class="memo"><c:out value="${data.contents}" escapeXml="false"/></p>
				<c:if test="${isLogin=='Y' && data.writer == userInfo.userId}"> 
					<!--수정-->
					<p class="editBT">
						<a href="javascript:fn_otoinqEditSH('${data.otoinqNum}')" class="btn btn-reply">수정</a>
						<a href="javascript:fn_otoinqDelete('${data.otoinqNum}')" class="btn btn-reply">삭제</a>
					</p>
					
					<div id="otoContEditDiv${data.otoinqNum}" style="display: none;">						
						<input type="text" id="oto_SubjectEdit${data.otoinqNum}" name=otoSubjectEdit${data.otoinqNum}" value="<c:out value='${data.subject}'/>" class="title-int" placeholder="제목을 입력해 주세요">
						<textarea name="textarea" id="oto_contentsEdit${data.otoinqNum}" cols="45" rows="5" class="focus-value" placeholder="궁금한 점을 남겨주세요"><c:out value="${data.contentsOrg}"/></textarea>
						<p><a href="javascript:fn_otoinqUpdate('${data.otoinqNum}')" class="btn btn-submit">수정</a></p>
					</div>
				</c:if>
			</div>								
		</dt>
		<c:if test="${data.ansContents != '' }">
			<dd class="area">
				<div class="icon"><em>A</em></div>
				<div class="text">
					<p class="user"><span class="user-id"><c:out value="${data.corpNm}"/></span> <span class="user-date">${data.ansFrstRegDttm}</span></p>
					<!-- <p class="title">제목 출력 제목 출력제목 출력제목 출력제목 출력제목 출력 제목 출력 제목 출력</p> -->
					<p class="memo"><c:out value="${data.ansContents}" escapeXml="false"/></p>
				</div>
			</dd>
		</c:if>
	</dl>
</c:forEach>
<c:if test="${searchVO.pageIndex eq 1}">
	</div>
	
	<c:if test="${fn:length(otoinqList) ne 0}">
    <div class="paging-wrap" id="otoMoreBtn">
	    <a href="javascript:fn_otoinqSearch()" class="mobile" id="otoMoreBtnLink">더보기 <span id="otoCurPage">1</span>/<span id="otoTotPage">1</span></a>
	</div>
	</c:if>
</c:if>