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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
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
	document.frm.action = "<c:url value='/oss/etc/sccList.do'/>";
	document.frm.submit();
}


function fn_InsScc(){
	document.frm.action = "<c:url value='/oss/etc/viewInsertScc.do' />";
	document.frm.submit();
}

function fn_DtlScc(noticeNum){
	$("#noticeNum").val(noticeNum);
	
	document.frm.action = "<c:url value='/oss/etc/detailScc.do'/>";
	document.frm.submit();
}

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=community&sub=scc" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="noticeNum" id="noticeNum" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<input type="hidden" name="totalCnt" value="${paginationInfo.totalRecordCount}" />
			<input type="hidden" name="totalPageCnt" value="${paginationInfo.totalPageCount}" />
			<div id="contents">
			<!--검색-->
            <div class="search_box">
            	<div class="search_form">
                	<div class="tb_form">
						<table width="100%" border="0">
							<colgroup>
								<col width="100" />
                                <col width="*" />
								<col width="130" />
                                <col width="*" />
							</colgroup>
             				<tbody>
             					<tr>
        							<th scope="row">제&nbsp;목</th>
        							<td><input type="text" id="sSubject" class="input_text_full" name="sSubject" value="${searchVO.sSubject}" title="검색하실 제목을 입력하세요." /></td>
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
			<div class="bdList">
				<c:if test="${fn:length(resultList) == 0}">
					<div class="board-not">
						<img src="<c:url value='/images/web/board/not.png'/>" alt="">
                        <p>등록 된 홍보영상 게시물이 없습니다.</p>
                    </div> <!--//board-not-->
	        	</c:if>
		        <ul class="video-list">
		        	<c:forEach items="${resultList}" var="result" varStatus="status">
		        		<li>
			                <a href="javascript:fn_DtlScc('${result.noticeNum}');">
			                    <p class="photo"><img src="https://i.ytimg.com/vi/${result.youtubeId}/hqdefault.jpg?custom=true&amp;w=196&amp;h=110&amp;stc=true&amp;jpg444=true&amp;jpgq=90&amp;sp=68&amp;sigh=Bpb6hHtTQ5raB-zO7uitKuEEkdI" alt=""></p>
			                    <div class="text-wrap">
			                        <p class="title">${result.subject}</p>
			                        <p class="memo">${result.simpleExp }</p>
			                    </div>
			                </a>
			            </li>
		        	</c:forEach>
		        </ul>
			</div>
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			</p>
			<ul class="btn_rt01">
				<li class="btn_sty01">
					<a href="javascript:fn_InsScc();">등록</a>
				</li>
			</ul>
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>