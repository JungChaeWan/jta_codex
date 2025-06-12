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
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

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
function fn_List(){
	
	//document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/otoinqList.do'/>";
	document.frm.submit();
}

function fn_printYnOnchange(obj){
	document.frm.printYn.value   = obj.value;
	document.frm.action = "<c:url value='/oss/otoinqUpdatePrint.do'/>";
	document.frm.submit();
}



</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=community&sub=otoinq" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="otoinqNum" name="otoinqNum" value='<c:out value="${data.otoinqNum}" />' />
				<input type="hidden" id="printYn" name="printYn" value="0"/>
				
				<div id="contents">
					<h4 class="title03">1:1문의 상세</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">No.</th>
							<td colspan="3"><c:out value="${data.otoinqNum}" /> </td>
						</tr>
						
						<c:set var="corpCdUp" value="${fn:substring(data.prdtNum,0,2)}"/>
						<c:if test="${!(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOLF) }">
							<tr>
								<th>업체</th>
								<td><c:out value="${data.corpNm2}" /> (<c:out value="${data.corpId}" />)</td>
								<th>상품</th>
								<td><c:out value="${data.prdtNm}" /> (<c:out value="${data.prdtNum}" />)</td>
							</tr>
						</c:if>
						<c:if test="${(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOL) }">
							<tr>
								<th>업체</th>
								<td colspan="3"><c:out value="${data.corpNm2}" /> (<c:out value="${data.corpId}" />)</td>
							</tr>
						</c:if>
						<%--
						<tr>
							<th>업체</th>
							<td><c:out value="${data.corpNm2}" /> (<c:out value="${data.corpId}" />)</td>
							<th>상품</th>
							<td><c:out value="${data.prdtNm}" /> (<c:out value="${data.prdtNum}" />)</td>
						</tr>
						 --%>
						<tr>
							<th>사용자아이디</th>
							<td><c:out value="${data.writer}" /></td>
							<th>E-Mail</th>
							<td><c:out value="${data.email}" /></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><c:out value="${userVO.userNm}" /></td>
							<th>전화번호</th>
							<td><c:out value="${userVO.telNum}" /></td>
						</tr>
						
						<tr>
							<th>시간</th>
							<td ><c:out value="${data.lastModDttm}" /></td>
							<th>표시여부</th>
							<td>
								<select onchange="fn_printYnOnchange(this)">
									<option value="Y" <c:if test="${data.printYn=='Y'}">selected="selected"</c:if>>표시</option>
									<option value="N" <c:if test="${data.printYn=='N'}">selected="selected"</c:if>>차단</option>
								</select>
							</td>
						</tr>
						<tr>
							<th >제목</th>
							<td colspan="3">
								<c:out value="${data.subject}"/>
							</td>
						</tr>
								
						
						<tr>
							<th>내용</th>
							<td colspan="3">
								<c:out value="${data.contents}" escapeXml="false"/>
							</td>
						</tr>
						
					</table>
					<br/>
					<h4 class="title03">답글</h4>
					
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th>답변아이디</th>
							<td><c:out value="${data.ansWriter}" /></td>
							<th>답변E-Mail</th>
							<td><c:out value="${data.ansEmail}" /></td>
						</tr>
						<tr>
							<th>시간</th>
							<td ><c:out value="${data.ansLastModDttm}" /></td>
							<th>업체명</th>
							<td><c:out value="${data.corpNm}" /></td>
						</tr>
						<tr>
							<th>답변</th>
							<td colspan="3">
								<c:out value="${data.ansContents}" escapeXml="false" />
							</td>
						</tr>
						
					</table>
					
					
					
					<ul class="btn_rt01">
						<li class="btn_sty01">
							<a href="javascript:fn_List()">목록</a>
						</li>
					</ul>
						
				</div>
			</form>
		
		</div>
	</div>
</div>
</body>
</html>