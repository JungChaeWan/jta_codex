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
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
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
	document.frm.action = "<c:url value='/oss/cmssList.do'/>";
	document.frm.submit();
}

function fn_UdtCmss(){
	if(isNull($("#udtAdjAplPct").val())){
		alert("수수료율을 입력하세요.");
		$("#udtAdjAplPct").focus();
		return;
	}
	
	var parameters = "cmssNum=" + $("#udtCmssNum").val();
	parameters += "&cmssNm=" + $("#udtCmssNm").val();
	parameters += "&adjAplPct=" + $("#udtAdjAplPct").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/updateCmss.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("수수료가 수정되었습니다.");
			document.frm.action = "<c:url value='/oss/cmssList.do'/>";
			document.frm.submit();
		}
	});
}

function fn_UdtCmssLay(cmssNum){
	$("#udtCmssNum").val(cmssNum);
	var parameters = "cmssNum=" + cmssNum;
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/selectByCmss.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#udtCmssNm").val(data.cmssVO.cmssNm);
			$("#udtAdjAplPct").val(data.cmssVO.adjAplPct);
			
			show_popup($("#lay_popup2"));
		}
	});
	
}

function fn_InsCmssLay(){
	show_popup($("#lay_popup"));
}

function fn_DelCmss(cmssNum){
	var parameters = "cmssNum=" + cmssNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/deleteChkCmss.ajax'/>",
		data:parameters ,
		success:function(data){
			
			if(data.chkVal > 0){
				alert("해당 수수료율이 설정된 업체가 존재합니다.");
				return;
			}else{
				if(confirm("삭제하시겠습니까?")){
					fn_DeleteCmss(cmssNum);
				}
			}
		}
	});
}

function fn_DeleteCmss(cmssNum){
	var parameters = "cmssNum=" + cmssNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/deleteCmss.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("수수료가 삭제 되었습니다.");
			
			document.frm.action = "<c:url value='/oss/cmssList.do'/>";
			document.frm.submit();
		}
	});
}

function fn_InsCmss(){
	
	if(isNull($("#insAdjAplPct").val())){
		alert("수수료율을 입력하세요.");
		$("#insAdjAplPct").focus();
		return;
	}
	
	var parameters = "cmssNm=" + $("#insCmssNm").val();
	parameters += "&adjAplPct=" + $("#insAdjAplPct").val();
	parameters += "&cmssDiv=" + $("#cmssDiv").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/insertCmss.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("수수료가 등록되었습니다.");
			document.frm.action = "<c:url value='/oss/cmssList.do'/>";
			document.frm.submit();
		}
	});
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=cmss" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<h4 class="title03">수수료 관리</h4>
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
	               						<th scope="row">수수료 구분</th>
	               						<td colspan="5">
	               							<select name="sCmssDiv" id="sCmssDiv">
	               								<option value="">전체</option>
	               								<option value="${Constant.CMSS_BTC}" <c:if test="${searchVO.sCmssDiv eq Constant.CMSS_BTC}">selected="selected"</c:if>>B2C 수수료</option>
	               								<option value="${Constant.CMSS_BTB}" <c:if test="${searchVO.sCmssDiv eq Constant.CMSS_BTB}">selected="selected"</c:if>>B2B 수수료</option>
	               							</select>
	               						</td>
	               					</tr>
	     						</tbody>
	               			</table>
	               		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
	              	</div>
	            </div>
				<!--검색-->
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>번호</th>
							<th>수수료명칭</th>
							<th>수수료구분</th>
							<th>수수료율</th>
							<th>등록일시</th>
							<th>기능툴</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="6" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">${result.cmssNm}</td>
								<td class="align_ct">
									<c:if test="${Constant.CMSS_BTC eq result.cmssDiv}">B2C 수수료</c:if>
									<c:if test="${Constant.CMSS_BTB eq result.cmssDiv}">B2B 수수료</c:if>
								</td>
								<td class="align_ct">${result.adjAplPct}%</td>
								<td class="align_ct">${result.regDttm}</td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_UdtCmssLay('${result.cmssNum}')">수정</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_DelCmss('${result.cmssNum}')">삭제</a></span></div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_InsCmssLay();">등록</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<form name="insCmssFrm">
		<ul class="form_area">
			<li>
				<table border="1" class="table02" >
  					<caption class="tb01_title">수수료관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>수수료 구분<span class="font02">*</span></th>
						<td>
							<select name="cmssDiv" id="cmssDiv">
   								<option value="${Constant.CMSS_BTC}">B2C 수수료</option>
   								<option value="${Constant.CMSS_BTB}">B2B 수수료</option>
   							</select>
						</td>
					</tr>
					<tr>
						<th>수수료 명칭<span class="font02">*</span></th>
						<td>
							<input type="text" name="cmssNm" id="insCmssNm" class="input_text30 center" maxlength="30" />
						</td>
					</tr>
					<tr>
						<th>수수료율<span class="font02">*</span></th>
						<td>
							<input type="text" name="adjAplPct" id="insAdjAplPct" class="input_text2 center" maxlength="8" onkeydown="javascript:fn_checkNumber2();" /> %
						</td>
					</tr>
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_InsCmss()">저장</a></span>
    </div>
</div>

<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<form name="udtCmssFrm">
		<input type="hidden" name="cmssNum" id="udtCmssNum" />
		<ul class="form_area">
			<li>
				<table border="1" class="table02" >
  					<caption class="tb01_title">수수료관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>수수료 명칭<span class="font02">*</span></th>
						<td>
							<input type="text" name="cmssNm" id="udtCmssNm" class="input_text30 center" maxlength="30" />
						</td>
					</tr>
					<tr>
						<th>수수료율<span class="font02">*</span></th>
						<td>
							<input type="text" name="adjAplPct" id="udtAdjAplPct" class="input_text2 center" maxlength="8" onkeydown="javascript:fn_checkNumber2();" /> %
						</td>
					</tr>
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_UdtCmss()">수정</a></span>
    </div>
</div>

</body>
</html>