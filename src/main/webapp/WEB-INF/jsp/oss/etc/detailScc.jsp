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
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_ListScc(){
	document.frm.action = "<c:url value='/oss/etc/sccList.do'/>";
	document.frm.submit();
}

function fn_UdtScc(){
	document.frm.action = "<c:url value='/oss/etc/viewUpdateScc.do'/>";
	document.frm.submit();
}

function fn_DelScc(){
	document.frm.action = "<c:url value='/oss/etc/deleteScc.do'/>";
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
			<form id="frm"  name="frm" method="post">
				<input type="hidden" name="noticeNum" id="noticeNum" value="${sccVO.noticeNum}" />
			<div id="contents">
					
				<h4 class="title03 margin-top45">홍보영상 등록</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">제목</th>
						<td>
							<c:out value="${sccVO.subject}" />
						</td>
					</tr>
					<tr>
						<th scope="row">간략설명</th>
						<td>
							<c:out value="${sccVO.simpleExp}" />
						</td>
					</tr>
					<tr>
						<th scope="row">유투브 아이디</th>
						<td>
							<c:out value="${sccVO.youtubeId}" />
						</td>
					</tr>
					<tr>
						<th scope="row">영상</th>
						<td>
							<div class="view-content">
					        	<div class="video">
					            	<iframe width="741" height="415" src="https://www.youtube.com/embed/${sccVO.youtubeId}" frameborder="0" allowfullscreen></iframe>
					            </div>
					        </div>
						</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td>
							<c:out value="${sccVO.contents}"  escapeXml="FALSE" />
							<%-- <textarea name="contents" id="contents" cols="70" rows="7" ><c:out value="${sccVO.contents}" escapeXml="false" /></textarea> --%>
						</td>
					</tr>
					<tr>
						<th scope="row">노출여부</th>
						<td>
							<c:if test="${sccVO.viewYn == 'Y'}">노출</c:if>
							<c:if test="${sccVO.viewYn == 'N'}">미노출</c:if>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtScc()">수정</a>
					</li>
					<li class="btn_sty03">
						<a href="javascript:fn_DelScc()">삭제</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_ListScc()">목록</a>
					</li>
				</ul>
						
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>