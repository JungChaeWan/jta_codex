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

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/nbbs/bbsList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.noticeNum.value = "";
	document.frm.action = "<c:url value='/oss/nbbs/bbsRegView.do'/>";
	document.frm.submit();
}


function fn_dtl(nIdx){
	document.frm.noticeNum.value = nIdx;	
	document.frm.action = "<c:url value='/oss/nbbs/bbsDtl.do'/>";
	document.frm.submit();
}


$(document).ready(function(){
	if('${authListYn}'!='Y'){
		alert("권한이 없습니다.");
		history.back();
	}
});

</script>
</head>
<body>
<div id="wrapper"> 
	<c:choose>
		<c:when test="${bbs.bbsNum=='MASNOTI' || bbs.bbsNum=='MASQA'}">
			<jsp:include page="/oss/head.do?menu=corp"></jsp:include>
		</c:when>
		<c:when test="${bbs.bbsNum=='NOTICE' || bbs.bbsNum=='NEWS' || bbs.bbsNum=='GRACOM' || bbs.bbsNum=='DESIGN'}">
			<jsp:include page="/oss/head.do?menu=community"></jsp:include>
		</c:when>
		<c:when test="${bbs.bbsNum=='FNREQ'}">
			<jsp:include page="/oss/head.do?menu=support"></jsp:include>
		</c:when>
	</c:choose>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<c:choose>
			<c:when test="${bbs.bbsNum=='MASNOTI' || bbs.bbsNum=='MASQA'}">
				<jsp:include page="/oss/left.do?menu=corp&sub=bbs${bbs.bbsNum}"></jsp:include>
			</c:when>
			<c:when test="${bbs.bbsNum=='NOTICE' || bbs.bbsNum=='NEWS' || bbs.bbsNum=='GRACOM' || bbs.bbsNum=='DESIGN'}">
				<jsp:include page="/oss/left.do?menu=community&sub=bbs${bbs.bbsNum}"></jsp:include>
			</c:when>
			<c:when test="${bbs.bbsNum=='FNREQ'}">
				<jsp:include page="/oss/left.do?menu=support&sub=bbs${bbs.bbsNum}"></jsp:include>
			</c:when>
		</c:choose>
		<div id="contents_area"> 
			<div id="contents">
			
				<!-- --------------------------------------------------- -->
		
				<h4 class="title03"><c:out value="${bbs.bbsNm }"/></h4><br/>
	
					<form name="frm" method="post" onSubmit="return false;">
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}"/>
						<input type="hidden" id="noticeNum" name="noticeNum" value=""/>
						
					
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
			          									<span class="tb_search_title"><select name="sKeyOpt" id="sKeyOpt" style="width:100px">
															<option value="2" <c:if test="${searchVO.sKeyOpt == 2 }">selected="selected"</c:if> >작성자</option>
		                                                    <option value="1" <c:if test="${searchVO.sKeyOpt == null || searchVO.sKeyOpt == 1 }">selected="selected"</c:if> >제목</option>
														</select></span>
													</th>
			          								<td>
			          									<input type="text" id="sKey" class="input_text_full" name="sKey" value="${searchVO.sKey}" title="검색하실 코드명를 입력하세요." />
			          								</td>
			       								</tr>
			       								<c:if test="${bbs.bbsNum=='FNREQ'}">
			       								<tr>
			       									<th scope="row">상태</th>
			       									<td>
			       										<select id="sStatusDiv" name="sStatusDiv">
			       											<option value="">전 체</option>
			       											<option value="${Constant.STATUS_DIV_01}" <c:if test="${Constant.STATUS_DIV_01 eq searchVO.sStatusDiv}">selected</c:if>>요청</option>
			       											<option value="${Constant.STATUS_DIV_02}" <c:if test="${Constant.STATUS_DIV_02 eq searchVO.sStatusDiv}">selected</c:if>>접수</option>
			       											<option value="${Constant.STATUS_DIV_03}" <c:if test="${Constant.STATUS_DIV_03 eq searchVO.sStatusDiv}">selected</c:if>>기각</option>
			       											<option value="${Constant.STATUS_DIV_04}" <c:if test="${Constant.STATUS_DIV_04 eq searchVO.sStatusDiv}">selected</c:if>>완료</option>
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
									<colgroup>
										<col width="8%" />
										<col width="*" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<c:if test="${bbs.bbsNum=='FNREQ'}"><col width="10%" /></c:if>
										<c:if test="${bbs.cmtYn == 'Y'}"><col width="5%" /></c:if>
									</colgroup>
	                                <tr>
	                                    <th >번호</th>
	                                    <th >제목</th>
	                                    <th >작성자</th>
	                                    <th >이메일</th>
	                                    <th >등록일</th>
	                                    <c:if test="${bbs.bbsNum=='FNREQ'}"><th>상태</th></c:if>
	                                    <c:if test="${bbs.cmtYn == 'Y'}"><th >댓글수</th></c:if>
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
	                                	<tr style="cursor:pointer;"
		                                	<c:if test="${ authDtlYn=='Y' || (isLogin=='Y' && data.userId == userInfo.userId)}"><%--글읽기 권한 있는사용자만 --%>
		                                		onclick="fn_dtl(${data.noticeNum})"
		                                	</c:if>
		                                    <c:if test="${ !(authDtlYn=='Y' || (isLogin=='Y' && data.userId == userInfo.userId) ) }"><%--글읽기 권한 없는 사람 --%>
		                                		onclick="alert('권한이 없습니다.')')"
		                                	</c:if>
		                                >
	                                    	<td class="center">
	                                    		<c:out value="${ totalCnt - (status.count + searchVO.pageSize*(searchVO.pageIndex-1) )  +1 }"/>
	                                    		<!-- (${data.noticeNum }) -->
	                                    	</td>
											<td class="left">
												<c:if test="${data.ansSn != '0'}"><%//답글 커서 표시 %>
													<c:forEach var="i" begin="1" end="${data.ansSn}">
														<c:if test="${data.ansSn != i}">&nbsp&nbsp</c:if>
														<c:if test="${data.ansSn == i}">└</c:if>
													</c:forEach>
												</c:if>
	                                            <c:if test="${data.anmYn == 'Y' }"><span>[공지]</span></c:if>
	                                            <c:out value="${data.subject}"/>
	                                        </td>
	                                        <td class="center"><c:out value="${data.writer}"/></td>
	                                        <td class="center"><c:out value="${data.email}"/></td>
	                                        <td class="center">${fn:substring(data.frstRegDttm,0,10)}</td>
	                                      	<c:if test="${bbs.bbsNum=='FNREQ'}">
	                                      		<td class="center">
	                                      			<c:choose>
	                                      				<c:when test="${data.statusDiv eq Constant.STATUS_DIV_01 }">
							                    			<fmt:parseDate value="${data.cmplRequestDt}" var="cmplRequestDt" pattern="yyyyMMdd"/>
							                    			요청 (완료요청일 : <fmt:formatDate value="${cmplRequestDt}" pattern="yyyy-MM-dd"/>)
							                    		</c:when>
							                    		<c:when test="${data.statusDiv eq Constant.STATUS_DIV_02 }">
							                    			<fmt:parseDate value="${data.cmplItdDt}" var="cmplItdDt" pattern="yyyyMMdd"/>
							                    			접수 (완료예정일 : <fmt:formatDate value="${cmplItdDt}" pattern="yyyy-MM-dd"/>)
							                    		</c:when>
							                    		<c:when test="${data.statusDiv eq Constant.STATUS_DIV_03 }">
							                    			기각
							                    		</c:when>
							                    		<c:when test="${data.statusDiv eq Constant.STATUS_DIV_04 }">
							                    			<fmt:parseDate value="${data.cmplDt}" var="cmplDt" pattern="yyyyMMdd"/>
							                    			완료 (완료일 : <fmt:formatDate value="${cmplDt}" pattern="yyyy-MM-dd"/>)
							                    		</c:when>
	                                      			</c:choose>
	                                      		</td>
	                                      	</c:if>
	                                        <c:if test="${bbs.cmtYn == 'Y'}"><td class="center"><c:out value="${data.cmtCnt}"/></td></c:if>
	                              		</tr>
									</c:forEach>
									
								</tbody>
							</table>
							
	                        <c:if test="${ authRegYn=='Y' }"><%--글쓰기 권한 있는사용자만 --%>
		                        <ul class="btn_rt01">
									<li class="btn_sty01">
										<a href="javascript:fn_Ins();">글쓰기</a>
									</li>
								</ul>
							</c:if>
						
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
	
					</form>
					
					<!-- --------------------------------------------------- -->
					
			</div>
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>