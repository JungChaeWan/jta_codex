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
	document.frm.action = "<c:url value='/mas/b2b/ad/corpGrpList.do'/>";
	document.frm.submit();
}

function fn_RegGrpPop(){
	show_popup($("#regGrpPop"));
}

/**
 * 그룹 등록
 */
function fn_RegGrp(){
	var parameters = "amtNm=" + $("#amtNm").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mas/b2b/ad/insertAmtGrp.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("그룹이 등록되었습니다.");
			location.href = "<c:url value='/mas/b2b/ad/corpGrpList.do' />";
		}
	});
}

/**
 * 그룹 삭제
 */
function fn_DelGrp(amtGrpNum){
	if(confirm("해당 그룹을 삭제하시겠습니까?")){
		var parameters = "amtGrpNum=" + amtGrpNum;
		
		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/mas/b2b/ad/deleteAmtGrp.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "Y"){
					alert("그룹이 삭제 되었습니다.");
					location.href = "<c:url value='/mas/b2b/ad/corpGrpList.do' />";
				}else{
					alert(data.rtnMsg);
				}
			}
		});
	}
}

function fn_ModGrpPop(amtGrpNum, amtNm){
	$("#modAmtNm").val(amtNm);
	$("#modAmtGrpNum").val(amtGrpNum);
	show_popup($("#modGrpPop"));
}

/**
 * 그룹 수정
 */
function fn_ModGrp(){
	var parameters = "amtNm=" + $("#modAmtNm").val();
	parameters += "&amtGrpNum=" + $("#modAmtGrpNum").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mas/b2b/ad/updateAmtGrp.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("그룹명이 수정되었습니다.");
			location.href = "<c:url value='/mas/b2b/ad/corpGrpList.do' />";
		}
	});
}

function fn_ModCorpGrpPop(corpNm, ctrtNum, amtGrpNum){
	if("${fn:length(amtGrpList)}" == 0){
		alert("그룹을 먼저 추가해주세요.");
		return;
	}else{
		$("#grp_CorpNm").text(corpNm);
		$("#grp_CtrtNum").val(ctrtNum);
		$("#grp_AmtGrpNum").val(amtGrpNum);
		show_popup($("#modCorpGrpPop"));
	}
}

/**
 * 업체 그룹 설정
 */
function fn_ModCorpGrp(){
	var parameters = "ctrtNum=" + $("#grp_CtrtNum").val();
	parameters += "&amtGrpNum=" + $("#grp_AmtGrpNum").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mas/b2b/ad/updateCorpGrp.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("업체 그룹이 수정되었습니다.");
			location.href = "<c:url value='/mas/b2b/ad/corpGrpList.do' />";
		}
	});
}

function fn_GrpListClick(obj){
	$("#sAmtGrpNum").val($(obj).parents().children("input[name=amtGrpNum]").val());
	fn_Search("1");
}

$(document).ready(function(){

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
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpList.do'/>">그룹관리</a></li>
						<c:if test="${Constant.ACCOMMODATION eq masLoginVO.corpCd}">
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/${fn:toLowerCase(masLoginVO.corpCd)}/corpGrpAmtList.do'/>">그룹요금관리</a></li>
						</c:if>
						<c:if test="${Constant.RENTCAR eq masLoginVO.corpCd}">
						<li><a class="menu_depth3"
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
						                	<li <c:if test="${empty searchVO.sAmtGrpNum}">class="active"</c:if>>
						                		<input type="hidden" name="amtGrpNum" value="" />
						                		<div class="l-box"><a href="javascript:void(0)" onclick="fn_GrpListClick(this);">전체보기</a></div>
						                	</li>
						                	<c:forEach items="${amtGrpList}" var="amtGrp" varStatus="status">
						                		<li <c:if test="${amtGrp.amtGrpNum eq searchVO.sAmtGrpNum}">class="active"</c:if>>
						                			<input type="hidden" name="amtGrpNum" value="${amtGrp.amtGrpNum}" />
							                    	<div class="l-box"><a href="javascript:void(0)" onclick="fn_GrpListClick(this);"><c:out value="${amtGrp.amtNm}" /></a></div>
							                    	<div class="r-box">
							                    		<a href="javascript:fn_ModGrpPop('${amtGrp.amtGrpNum}', '${amtGrp.amtNm}');" class="btn blue">수정</a>
							                    		<a href="javascript:fn_DelGrp('${amtGrp.amtGrpNum}')" class="btn red">삭제</a>
							                    	</div>
						                    	</li>
						                	</c:forEach>
						                </ul>
					                </div>
				                </div> <!--//nav-wrap-->
				            </div> <!--//scroll-->
				            
				            <!--추가/삭제-->
				            <div class="btn-wrap">
				            	<a href="javascript:fn_RegGrpPop();" class="btn blue">그룹추가</a>
				            	<!-- <a href="" class="btn red">그룹삭제</a> -->
				            </div>
				        </div> <!--//l-area-->
				        <div class="r-area">
				        	<div class="scroll">
				        		<div class="side-wrap1">
									<!-- <h4 class="title08">업체 전체 보기</h4> -->
									<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
									<div class="side-box">
										<span class="name">업체명 검색</span>
										<input type="hidden" name="sAmtGrpNum" id="sAmtGrpNum" />
										<input type="text" name="sCorpNm" id="sCorpNm" value="${searchVO.sCorpNm }" />
										<a href="javascript:fn_Search('1')" class="btn blue">검색</a>
									</div>
									</form>
								</div>
								<div class="list">
									<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							        	<colgroup>
							        		<col />
							        		<col width="15%" />
							        		<col width="10%" />
							        		<col width="10%" />
							        		<col width="15%" />
							        		<col width="10%" />
							        		<col width="10%" />
							        	</colgroup>
							            <thead>
							                <tr>
							                    <th>업체명</th>
							                    <th>대표자명</th>
							                    <th>담당자명</th>
							                    <th>전화번호</th>
							                    <th>그룹설정일</th>
							                    <th>그룹</th>
							                    <th>그룹</th>
							                </tr>
							            </thead>
							            <tbody>
							            	<c:if test="${fn:length(resultList) == 0}">
												<tr>
													<td colspan="7" class="align_ct">
														<spring:message code="common.nodata.msg" />
													</td>
												</tr>
											</c:if>
											<c:forEach items="${resultList}" var="result" varStatus="status">
												<tr>
							                    	<td class="align_ct"><c:out value="${result.corpNm}" /></td>
							                    	<td class="align_ct"><c:out value="${result.ceoNm}" /></td>
							                    	<td class="align_ct"><c:out value="${result.admNm}" /></td>
							                    	<td class="align_ct"><c:out value="${result.rsvTelNum}" /></td>
							                    	<td class="align_ct"><c:out value="${result.modDttm}" /></td>
							                    	<td class="align_ct">
							                    		<c:out value="${result.amtNm}" />
							                    	</td>
							                    	<td class="align_ct">
							                    		<a href="javascript:fn_ModCorpGrpPop('${result.corpNm}', '${result.ctrtNum}', '${result.amtGrpNum}');" class="btn blue sm">수정</a>
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
<!-- 그룹추가 레이어 -->
<div id="regGrpPop" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#regGrpPop'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" >
  				<caption class="tb01_title">그룹추가<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
       				<tr>
						<th>그룹명<span class="font02">*</span></th>
						<td>
							<input type="text" class="input_text20" name="amtNm" id="amtNm" maxlength="30" />
						</td>
					</tr>
			</table>
		</li>
	</ul>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_RegGrp();">그룹추가</a></span>
    </div>
</div>
<!-- 그룹수정 레이어 -->
<div id="modGrpPop" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#modGrpPop'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" >
  				<caption class="tb01_title">그룹명 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
       				<tr>
						<th>그룹명<span class="font02">*</span></th>
						<td>
							<input type="hidden" name="modAmtGrpNum" id="modAmtGrpNum" />
							<input type="text" class="input_text20" name="amtNm" id="modAmtNm" maxlength="30" />
						</td>
					</tr>
			</table>
		</li>
	</ul>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_ModGrp();">그룹수정</a></span>
    </div>
</div>
<!-- 업체 그룹수정 레이어 -->
<div id="modCorpGrpPop" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#modCorpGrpPop'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" >
  				<caption class="tb01_title">그룹 설정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>업체명</th>
						<td id="grp_CorpNm"></td>
					</tr>
       				<tr>
						<th>그룹<span class="font02">*</span></th>
						<td>
							<input type="hidden" name="grp_CtrtNum" id="grp_CtrtNum" />
							<select id="grp_AmtGrpNum" name="grp_AmtGrpNum">
								<option value="">그룹설정안함</option>
								<c:forEach items="${amtGrpList}" var="amtGrp" varStatus="status">
									<option value="${amtGrp.amtGrpNum}"><c:out value="${amtGrp.amtNm}" /></option>
								</c:forEach>
							</select>
						</td>
					</tr>
			</table>
		</li>
	</ul>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_ModCorpGrp();">수정</a></span>
    </div>
</div>
</body>
</html>