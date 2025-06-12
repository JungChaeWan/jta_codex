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

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/b2b/ad/corpGrpDisPerList.do'/>";
	document.frm.submit();
}

function fn_GrpListClick(obj, disPerNm, disPerGrpNum){
	$("#sDisPerGrpNum").val($(obj).parents().children("input[name=disPerGrpNum]").val());
	$("#grpTitle").text(disPerNm);
	$("#grpListUl>li").removeClass("active");
	$(obj).parents().addClass("active");
	$("#disPerGrpNum").val(disPerGrpNum);
}

function fn_DisPer(prdtNum){
	document.frm.prdtNum.value = prdtNum;
	document.frm.action = "<c:url value='/mas/b2b/rc/corpGrpDisPer.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	if("${fn:length(disPerGrpList)}" == 0){
		alert("그룹을 먼저 추가해주세요. 그룹관리 메뉴로 이동합니다.");
		location.href = "<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpList.do' />";
	}else{
		$("#grpListUl>li").eq(0).children(".l-box").children("a").trigger("click");
	}
});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<div id="contents">
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpList.do'/>">그룹관리</a></li>
						<c:if test="${Constant.ACCOMMODATION eq masLoginVO.corpCd}">
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpAmtList.do'/>">그룹요금관리</a></li>
						</c:if>
						<c:if test="${Constant.RENTCAR eq masLoginVO.corpCd}">
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpDisPerList.do'/>">그룹할인율관리</a></li>
						</c:if>
					</ul>
				</div>
			<!--본문-->
				<div class="split-screen">
					<div class="col2-wrap">
						<div class="l-area">
				        	<!--검색-->
				        	<!-- <div class="form-wrap">
			                	<input type="text" />
			                	<a href="#" class="btn blue">검색</a>
			                </div> -->
			                
			                <!--menu list-->
				            <div class="scroll">
				                <div class="nav-wrap">
					                <div class="nav-group">
					                	<!-- <h3 class="g-title"><a href="javascript:void(0)">기본그룹</a></h3> -->
						                <ul class="nav-list" id="grpListUl">
						                	<c:forEach items="${disPerGrpList}" var="disPerGrp" varStatus="status">
						                		<li <c:if test="${disPerGrp.disPerGrpNum eq disPerGrpSVO.sDisPerGrpNum}">class="active"</c:if>>
							                    	<div class="l-box"><a href="javascript:void(0)" onclick="fn_GrpListClick(this, '${disPerGrp.disPerNm}', '${disPerGrp.disPerGrpNum}');"><c:out value="${disPerGrp.disPerNm}" /></a></div>
							                    	<%-- <div class="r-box">
							                    		<a href="javascript:fn_ModGrpPop('${amtGrp.amtGrpNum}', '${amtGrp.amtNm}');" class="btn blue">수정</a>
							                    		<a href="javascript:fn_DelGrp('${amtGrp.amtGrpNum}')" class="btn red">삭제</a>
							                    	</div> --%>
						                    	</li>
						                	</c:forEach>
						                </ul>
					                </div>
				                </div> <!--//nav-wrap-->
				            </div> <!--//scroll-->
				            
				        </div> <!--//l-area-->
				        <div class="r-area">
				        	<div class="scroll">
				        		<div class="side-wrap1">
									<h4 class="title08" id="grpTitle"></h4>
									<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
										<input type="hidden" name="disPerGrpNum" id="disPerGrpNum" />
										<input type="hidden" name="prdtNum" id="prdtNum" />
									</form>
								</div>
								<div class="list">
									<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							        	<colgroup>
							        		<col />
							        		<col width="15%" />
							        		<col width="10%" />
							        		<col width="10%" />
							        		<col width="10%" />
							        		<col width="15%" />
							        		<col width="10%" />
							        	</colgroup>
							            <thead>
							                <tr>
							                    <th>명칭</th>
							                    <th>차량구분</th>
							                    <th>사용연료</th>
							                    <th>정원</th>
							                    <th>노출순번</th>
							                    <th>상태</th>
							                    <th></th>
							                </tr>
							            </thead>
							            <tbody>
							            	<c:if test="${fn:length(resultList) == 0}">
												<tr>
													<td colspan="6" class="align_ct">
														<spring:message code="common.nodata.msg" />
													</td>
												</tr>
											</c:if>
											<c:forEach items="${resultList}" var="result" varStatus="status">
												<tr>
													<td class="align_ct"><c:out value="${result.prdtNm}" /></td>
													<td class="align_ct">
														<c:forEach var="code" items="${carDivCd}" varStatus="status">
															<c:if test="${result.carDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
														</c:forEach>
													</td>
													<td class="align_ct">
														<c:forEach var="code" items="${fuelCd}" varStatus="status">
															<c:if test="${result.useFuelDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
														</c:forEach>
													</td>
													<td class="align_ct"><c:out value="${result.maxiNum}" /></td>
													<td class="align_ct"><c:out value="${result.viewSn}" /></td>
													<td class="align_ct">
														<c:forEach var="code" items="${tsCd}" varStatus="status">
															<c:if test="${result.tradeStatus==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
														</c:forEach>
													</td>
													<td class="align_ct">
														<div class="btn_sty06"><span><a href="javascript:fn_DisPer('${result.prdtNum}')">할인율 관리</a></span></div>
													</td>
												</tr>
											</c:forEach>
							            </tbody>
							         </table>
								</div>
								<p class="list_pageing">
									<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
								</p>
				        	</div>
				        </div>
					</div>
				</div>
			</div>
			 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>

<div class="blackBg"></div>
</body>
</html>