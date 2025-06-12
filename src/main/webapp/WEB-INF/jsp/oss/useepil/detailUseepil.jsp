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
function fn_List(){

	//document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/useepilList.do'/>";
	document.frm.submit();
}

function fn_printYnOnchange(obj){
	document.frm.printYn.value   = obj.value;
	//document.frm.useEpilNum.value       = useEpilNum;
	document.frm.action = "<c:url value='/oss/useepiUpdatePrint.do'/>";
	document.frm.submit();
}

function fn_printYnCmtOnchange(obj, cmtSn){
	document.frm.printYn.value   = obj.value;
	document.frm.cmtSn.value      = cmtSn;
	document.frm.action = "<c:url value='/oss/useepiCmtUpdateCPrint.do'/>";
	document.frm.submit();
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=community&sub=useepil" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="useEpilNum" name="useEpilNum" value='<c:out value="${data.useEpilNum}" />' />
				<input type="hidden" id="printYn" name="printYn" value="0"/>
				<input type="hidden" id="cmtSn" name="cmtSn" value=""/>
				<input type="hidden" id="corpId" name="corpId" value="${data.corpId}"/>
				<input type="hidden" id="prdtnum" name="prdtnum" value="${data.prdtnum}"/>


				<div id="contents">
					<h4 class="title03">상품평 상세</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">No.</th>
							<td>
								<c:out value="${data.useEpilNum}" />
							</td>
							<th scope="row">유형</th>
							<td>
								<c:forEach items="${cdRvtp}" var="rvtp">
									<c:if test="${rvtp.cdNum eq data.reviewType}">
										${rvtp.cdNm}
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>업체</th>
							<td><c:out value='${data.corpNm}'/> (<c:out value='${data.corpId}'/>)</td>
							<th>상품</th>
							<td colspan="3"><c:out value='${data.prdtNm}'/> (<c:out value='${data.prdtnum}'/>)</td>
						</tr>
						<tr>
							<th>사용자아이디</th>
							<td><c:out value="${data.userId}" /></td>
							<th>E-Mail</th>
							<td colspan="3"><c:out value="${data.email}" /></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><c:out value="${data.userNm}" /></td>
							<th>전화번호</th>
							<td><c:out value="${data.telNum}" /></td>
						</tr>
						<tr>
							<th>평점</th>
							<td><c:out value="${data.gpa}" /></td>
							<th>댓글 수</th>
							<td colspan="3"><c:out value="${data.cmtCnt}" /></td>
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

						<tr>
							<th>이미지</th>
							<td colspan="3">
								<c:forEach var="data" items="${imgList}" varStatus="status">
									<img src="${data.savePath}thumb/${data.saveFileNm}" style="width:120px " />
								</c:forEach>
							</td>
						</tr>

					</table>
					<br/>
					<h4 class="title03">댓글</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
		                <c:if test="${fn:length(cmtlist) == 0}">
							<tr>
								<td colspan="10" class="align_ct">
									댓글이 없습니다.
								</td>
							</tr>
						</c:if>
						<c:forEach var="cmt" items="${cmtlist}" varStatus="status">
							<tr>
								<td colspan="4">
									<!-- No.${cmt.cmtSn} -->
									[ID: <c:out value="${cmt.userId}"/> ]
									[E-Mail: <c:out value="${cmt.email}"/> ]
									[시간: <c:out value="${cmt.lastModDttm}"/> ]
									<select onchange="fn_printYnCmtOnchange(this, ${cmt.cmtSn})">
										<option value="Y" <c:if test="${cmt.printYn=='Y'}">selected="selected"</c:if>>표시</option>
										<option value="N" <c:if test="${cmt.printYn=='N'}">selected="selected"</c:if>><font color="#980000">차단</font></option>
									</select>
									<br/>
									<c:out value="${cmt.contents}" escapeXml="false"/>
								</td>
							</tr>
						</c:forEach>
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