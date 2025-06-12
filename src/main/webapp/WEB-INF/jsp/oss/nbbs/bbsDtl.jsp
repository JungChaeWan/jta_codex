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
<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="BBSGRPINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

function fn_DownloadFile(Id){
	frmFileDown.location = "<c:url value='/oss/nbbs/bbsFileDown.do?bbsNum=${notice.bbsNum}" + "&noticeNum=${notice.noticeNum}" + "&fileNum=" + Id +"'/>";
}

function fn_Udt(){
	if('${authModYn}'!='Y'){
		alert("권한이 없습니다.");
		return;
	}
	document.frm.action = "<c:url value='/oss/nbbs/bbsModView.do'/>";
	document.frm.submit();
}

function fn_Del(){
	
	if('${nBBSAuthDel}'=='N'){
		alert('권한이 없습니다.');	
		return;	
	}
		
	if('${notice.cmtCnt}'!='0'){
		alert('댓글이 있어서 삭제 할 수 없습니다.');
		return;	
	}
	
	if('${reCnt}' != '0'){
		alert('답글이 있어서 삭제 할 수 없습니다.');
		return;	
	}
	
	if(confirm("게시글은 물론 관련 정보들도 같이 삭제됩니다.\n게시글을 삭제 하시겠습니까?")){
		document.frm.hrkNoticeNum.value = "";
		document.frm.ansNum.value = "";
		document.frm.ansSn.value = "";
		document.frm.action = "<c:url value='/oss/nbbs/bbsDel.do'/>";
		document.frm.submit();
	}
}


function fn_Ans(){
	document.frm.action = "<c:url value='/oss/nbbs/bbsRegView.do'/>";
	document.frm.submit();
}


function fn_cmtInsert(){
	//alert($("#unCmtContents").val());
	if( $("#unCmtContents").val() == ""){
		alert("댓글내용을 입력 하세요.");
		return;
	}
	
	document.frm.cmtContents.value = $("#unCmtContents").val();
	document.frm.action = "<c:url value='/oss/nbbs/bbsRegCmt.do'/>";
	document.frm.submit();
}

function fn_cmtDel(cmtSn){
	if(confirm("댓글을 삭제 하시겠습니까?")){
		document.frm.cmtSn.value = cmtSn;
		document.frm.action = "<c:url value='/oss/nbbs/bbsDelCmt.do'/>";
		document.frm.submit();
	}
}

function fn_cmtModToggle(cmtSn){
	$("#ueCmtDiv"+cmtSn).toggle();
}

function fn_cmtMod(cmtSn){
	if( $("#unCmtContents"+cmtSn).val() == ""){
		alert("댓글내용을 입력 하세요.");
		return;
	}
	
	document.frm.cmtSn.value = cmtSn;
	document.frm.cmtContents.value = $("#unCmtContents"+cmtSn).val();
	document.frm.action = "<c:url value='/oss/nbbs/bbsModCmt.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	if('${authDtlYn}'!='Y'){
		alert("권한이 없습니다.");
		location.href = "<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
		
	}
});


</script>
</head>
<body>
<div id="wrapper"> 
	<c:choose>
		<c:when test="${bbs.bbsNum=='MASNOTI' || bbs.bbsNum=='MASQA'}">
			<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
		</c:when>
		<c:when test="${bbs.bbsNum=='NOTICE' || bbs.bbsNum=='NEWS' || bbs.bbsNum=='GRACOM' || bbs.bbsNum=='DESIGN'}">
			<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
		</c:when>
		<c:when test="${bbs.bbsNum=='FNREQ'}">
			<jsp:include page="/oss/head.do?menu=support" flush="false"></jsp:include>
		</c:when>
	</c:choose>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<c:choose>
			<c:when test="${bbs.bbsNum=='MASNOTI' || bbs.bbsNum=='MASQA'}">
				<jsp:include page="/oss/left.do?menu=corp&sub=bbs${bbs.bbsNum}" flush="false"></jsp:include>
			</c:when>
			<c:when test="${bbs.bbsNum=='NOTICE' || bbs.bbsNum=='NEWS' || bbs.bbsNum=='GRACOM' || bbs.bbsNum=='DESIGN'}">
				<jsp:include page="/oss/left.do?menu=community&sub=bbs${bbs.bbsNum}" flush="false"></jsp:include>
			</c:when>
			<c:when test="${bbs.bbsNum=='FNREQ'}">
				<jsp:include page="/oss/left.do?menu=support&sub=bbs${bbs.bbsNum}" flush="false"></jsp:include>
			</c:when>
		</c:choose>
		<div id="contents_area"> 
			<div id="contents">
			
				<!-- --------------------------------------------------- -->
		
				<div class="register_area">
					<h4 class="title03"><c:out value="${bbs.bbsNm }"/>	</h4>
					
	
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<th>제목<span class="font_red"></span></th>
	                    	<td colspan="3">
	                    		<c:out value="${notice.subject}"/>
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th>작성자<span class="font_red"></span></th>
	                    	<td colspan="3">
	                    		<c:out value="${notice.writer}"/> / <c:out value="${notice.frstRegDttm}"/>
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<th>내용</th>
	                    	<td colspan="3">
	                    		<c:forEach var="data" items="${notiImgList}" varStatus="status">
	                            	<img src="${data.savePath}${data.saveFileNm}.${data.ext}" alt="">
	                        	</c:forEach>
	                        	<br/>
	                            <c:out value='${notice.contents}' escapeXml='false' />
	                    	</td>
	                    </tr>
		                <tr>
		                   	<th>첨부파일</th>
		                   	<td>
		                    	<c:forEach var="data" items="${notiFileList}" varStatus="status">
		                    		<img class="fileIcon" src="<c:url value='/images/web/board/file.jpg'/>" alt="첨부파일">
		                    		<span><a href="javascript:fn_DownloadFile('${data.fileNum}')" title="${data.realFileNm }">(붙임${status.index+1 }) <c:out value="${data.realFileNm }"/> </a></span>
		   	                	</c:forEach>
		                   	</td>
		               	</tr>
	                    <c:if test="${bbs.bbsNum=='FNREQ'}">
	                    <tr>
	                    	<th>상태</th>
	                    	<td>
	                    		<c:choose>
	                    		<c:when test="${notice.statusDiv eq Constant.STATUS_DIV_01 }">
	                    			<fmt:parseDate value="${notice.cmplRequestDt}" var="cmplRequestDt" pattern="yyyyMMdd"/>
	                    			요청 (완료요청일 : <fmt:formatDate value="${cmplRequestDt}" pattern="yyyy-MM-dd"/>)
	                    		</c:when>
	                    		<c:when test="${notice.statusDiv eq Constant.STATUS_DIV_02 }">
	                    			<fmt:parseDate value="${notice.cmplItdDt}" var="cmplItdDt" pattern="yyyyMMdd"/>
	                    			접수 (완료예정일 : <fmt:formatDate value="${cmplItdDt}" pattern="yyyy-MM-dd"/>)
	                    		</c:when>
	                    		<c:when test="${notice.statusDiv eq Constant.STATUS_DIV_03 }">
	                    			기각
	                    		</c:when>
	                    		<c:when test="${notice.statusDiv eq Constant.STATUS_DIV_04 }">
	                    			<fmt:parseDate value="${notice.cmplDt}" var="cmplDt" pattern="yyyyMMdd"/>
	                    			완료 (완료일 : <fmt:formatDate value="${cmplDt}" pattern="yyyy-MM-dd"/>)
	                    		</c:when>
	                    		</c:choose>
	                    	</td>
	                    </tr>
	                    </c:if>
	                 </table>
	                 
	                 <iframe name="frmFileDown" style="display:none"></iframe>
					
					<ul class="btn_rt01">
						<c:if test= "${notice.bbsNum ne 'DESIGN'}">
							<c:if test="${ bbs.ansYn == 'Y' && authAnsYn=='Y' }"><%--답글 권한 있는사용자만 --%>
								<li class="btn_sty04">
									<a href="javascript:fn_Ans()">답글</a>
								</li>
							</c:if>
						</c:if>
						<%--
						[${authModYn=='Y'}][${isLogin=='Y' && notice.userId == userInfo.userId}][${notice.userId }][${userInfo.userId }]
						 --%>
						<c:if test="${(authModYn == 'Y' && (isLogin=='Y' && notice.userId == userInfo.userId)) || userInfo.authNm=='ADMIN'}">
							<li class="btn_sty02">
	                    		<a href="javascript:fn_Udt()">수정</a>
	                    	</li>
	                    </c:if>
	                    <c:if test="${(authDelYn == 'Y' && (isLogin=='Y' && notice.userId == userInfo.userId)) || userInfo.authNm=='ADMIN'}">
	                    	<li class="btn_sty03">
	                    		<a href="javascript:fn_Del()">삭제</a>
	                    	</li>
	                    </c:if>
						
						<li class="btn_sty01">
							<a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}">목록</a>
						</li>
					</ul>
					
					<c:if test="${bbs.cmtYn == 'Y'}">
						<h4 class="title03">댓글</h4>
		
						<c:if test="${isLogin=='Y'}">
							<table border="1" class="table02">
								<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                    </colgroup>
		                    
								<tr>
									<th>댓글 추가</th>
									<td colspan="3">
										<textarea id="unCmtContents" name="unCmtContents" cols="70" rows="5"></textarea>
										<ul class="btn_rt01">
											<li class="btn_sty02">
					                    		<a href="javascript:fn_cmtInsert()">추가</a>
					                    	</li>
					                   	</ul>
									</td>
								</tr>
							</table>
						
						</c:if>
						
						<table border="1" class="table02">
							<colgroup>
		                        <col width="200" />
		                        <col width="*" />
		                        <col width="200" />
		                        <col width="*" />
		                    </colgroup>
			                <c:if test="${fn:length(cmtList) == 0}">
								<tr>
									<td colspan="10" class="align_ct">
										댓글이 없습니다.
									</td>
								</tr>
							</c:if>
							<c:forEach var="cmt" items="${cmtList}" varStatus="status">
								<tr>
									<td colspan="4">
										<!-- No.${cmt.cmtSn} -->
										<!-- [ID: <c:out value="${cmt.regId}"/> ] -->
										[E-Mail: <c:out value="${cmt.email}"/> ]
										[시간: <c:out value="${cmt.regDttm}"/> ]
										<c:if test="${(isLogin=='Y' && cmt.regId == userInfo.userId) || userInfo.authNm=='ADMIN'}">
											<a href="javascript:fn_cmtModToggle('${cmt.cmtSn}');">[수정]</a>
											<a href="javascript:fn_cmtDel('${cmt.cmtSn}');">[삭제]</a>
										</c:if>
										
										<br/>
										<c:out value="${cmt.cmtContents}" escapeXml="false"/>
										
										<c:if test="${(isLogin=='Y' && cmt.regId == userInfo.userId) || userInfo.authNm=='ADMIN'}">
											<div id="ueCmtDiv${cmt.cmtSn}" style="display: none;">
												<textarea id="unCmtContents${cmt.cmtSn}" name="unCmtContents${cmt.cmtSn}" cols="70" rows="5">${cmt.cmtContentsOrg}</textarea>
												<li class="btn_sty02">
						                    		<a href="javascript:fn_cmtMod('${cmt.cmtSn}');">수정</a>
						                    	</li>
						                    	<li class="btn_sty02">
						                    		<a href="javascript:fn_cmtModToggle('${cmt.cmtSn}');">취소</a>
						                    	</li>
											</div>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
					
				</div>
				
				
				
				<form name="frm" id="frm" method="post" onSubmit="return false;">
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input name="sKey" type="hidden" value="<c:out value='${searchVO.sKey}'/>"/>
					<input name="sKeyOpt" type="hidden" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
					
					<input type="hidden" name="bbsNum" id="bbsNum" value="<c:out value='${notice.bbsNum}'/>"/>
					<input type="hidden" name="noticeNum" id="noticeNum" value="<c:out value='${notice.noticeNum}'/>"/>
					<input type="hidden" name="hrkNoticeNum" value="${notice.hrkNoticeNum}"/>
					<input type="hidden" name="ansNum" value="${notice.ansNum}"/>
					<input type="hidden" name="ansSn" value="${notice.ansSn}"/>
					
					<input name="fileNum" id="fileNum" type="hidden" value=""/>
					
					<input name="cmtSn" id="cmtSn" type="hidden" value=""/>
					<input name="cmtContents" id="cmtContents" type="hidden" value=""/>
					<input name="gpa" id="gpa" type="hidden" value=""/>
					<input type="hidden" name="sStatusDiv" id="sStatusDiv" value="${searchVO.sStatusDiv}" />
	           </form>
					
					<!-- --------------------------------------------------- -->
					
			</div>
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>