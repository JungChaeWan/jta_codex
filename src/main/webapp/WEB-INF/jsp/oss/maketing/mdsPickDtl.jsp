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
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<validator:javascript formName="ADMRCMDVO" staticJavascript="false" xhtml="true" cdata="true"/>

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
	document.frm.action = "<c:url value='/oss/eventDtl.do'/>";
	document.frm.submit();
}

function fn_printYnCmtOnchange(obj, cmtSn){
	document.frm.printYn.value   = obj.value;
	document.frm.cmtSn.value      = cmtSn;
	document.frm.action = "<c:url value='/oss/eventCmtUpdateCPrint.do'/>";
	document.frm.submit();
}

$(document).ready(function(){

});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=pick" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<div id="contents">
				<h4 class="title03">프로모션</h4>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
                    <tr>
						<th scope="row">추천번호</th>
						<td colspan="3">
							<c:out value="${admRcmdVO.rcmdNum}"/>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3">
							<c:out value="${admRcmdVO.subject}"/>
						</td>
					</tr>
					<tr>
						<th>목록이미지</th>
						<td colspan="3">
							<c:out value="${admRcmdVO.listImgFileNm}" />
							<div class="btn_sty06">
								<span><a href="${admRcmdVO.listImgPath}" target="_blank">상세보기</a></span>
							</div>
						</td>
					</tr>
					<tr>
						<th>상세이미지</th>
						<td colspan="3">
							<c:out value="${admRcmdVO.dtlImgFileNm}" />
							<div class="btn_sty06">
								<span><a href="${admRcmdVO.dtlImgPath}" target="_blank">상세보기</a></span>
							</div>
						</td>
					</tr>
					<tr>
						<th>모바일이미지</th>
						<td colspan="3">
							<c:out value="${admRcmdVO.dtlMobileImgFileNm}" />
							<div class="btn_sty06">
								<span><a href="${admRcmdVO.dtlMobileImgPath}" target="_blank">상세보기</a></span>
							</div>
						</td>
					</tr>
					<tr>
						<th>배너이미지</th>
						<td colspan="3">
							<c:out value="${admRcmdVO.bannerImgFileNm}" />
							<div class="btn_sty06">
								<span><a href="${admRcmdVO.bannerImgPath}" target="_blank">상세보기</a></span>
							</div>
						</td>
					</tr>
					<tr>
						<th>노출 여부</th>
						<td colspan="3"><c:out value="${admRcmdVO.viewYn}"/></td>
					</tr>					
				</table>
					
				<ul class="btn_rt01 align_ct">
					<li class="btn_sty01">
						<a href="javascript:history.back();">목록</a>
					</li>
				</ul>
			</div>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>

	</div>
</div>
</body>
</html>