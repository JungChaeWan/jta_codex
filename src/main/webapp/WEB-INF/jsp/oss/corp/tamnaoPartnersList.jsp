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
	document.frm.action = "<c:url value='/oss/tamnaoPartners.do'/>";
	document.frm.submit();
}

function fn_UdtTamnaoPartner(partnerCd){
	var parameters = "partnerCd=" + partnerCd;

	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/selectTamnaoPartner.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#udtPartnerCd").val(data.result.partnerCd);
			$("#udtPartnerNm").val(data.result.partnerNm);
		}
	});
	show_popup($("#lay_popup2"));
}

function fn_UdtPartner(){
	if(isNull($("#udtPartnerCd").val())){
		alert("파트너코드를 입력하세요");
		$("#udtPartnerCd").focus();
		return;
	}

	if(isNull($("#udtPartnerNm").val())){
		alert("파트너명을 입력하세요");
		$("#udtPartnerNm").focus();
		return;
	}
	
	var parameters = "partnerCd=" + $("#udtPartnerCd").val();
	parameters += "&partnerNm=" + $("#udtPartnerNm").val();

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/updateTamnaoPartner.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("수정 되었습니다.");
			document.frm.action = "<c:url value='/oss/tamnaoPartners.do'/>";
			document.frm.submit();
		}
	});
}

function fn_DelTamnaoPartner(partnerCd){
	if(confirm("삭제 하시겠습니까?")){
		var parameters = "partnerCd=" + partnerCd;

		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/deleteTamnaoPartner.ajax'/>",
			data:parameters ,
			success:function(data){
				alert("삭제 되었습니다.");

				document.frm.action = "<c:url value='/oss/tamnaoPartners.do'/>";
				document.frm.submit();
			}
		});
	}
}

function fn_InsTamnaoPartner(){
	show_popup($("#lay_popup"));
}

function fn_InsPartner(){
	
	if(isNull($("#partnerCd").val())){
		alert("파트너코드를 입력해주세요.");
		$("#partnerCd").focus();
		return;
	}

	if(isNull($("#partnerNm").val())){
		alert("파트너명을 입력해주세요.");
		$("#partnerNm").focus();
		return;
	}
	
	var parameters = "partnerCd=" + $("#partnerCd").val();
	parameters += "&partnerNm=" + $("#partnerNm").val();

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/insertTamnaoPartner.ajax'/>",
		data:parameters ,
		success:function(data){
			alert(data.resultMsg);
			document.frm.action = "<c:url value='/oss/tamnaoPartners.do'/>";
			document.frm.submit();
		}
	});
}

function fn_partnerAnls(partnerCd){
	
	var parameters = "partnerCd=" + partnerCd;
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/partnerAnls.ajax'/>",
		data:parameters ,
		success:function(data){
			
			var partnerAnlsHtml = "";
			partnerAnlsHtml += "<table border='1' class='table02'>";
			partnerAnlsHtml += "<caption class='tb01_title'>월별 접속현황</caption>";
			partnerAnlsHtml += "<colgroup>";
			partnerAnlsHtml += "<col width='170' />";
			partnerAnlsHtml += "<col width='*' />";
			partnerAnlsHtml += "</colgroup>";
			partnerAnlsHtml += "<tr><th>접속년월</th><td>접속수</td></tr>";
			
			for(var i=0;i < data.resultList.length;i++){
				partnerAnlsHtml += "<tr><th>"+data.resultList[i].year+"-"+data.resultList[i].mm+"</th><td>"+data.resultList[i].accessCnt+"</td></tr>";
			}
			
			partnerAnlsHtml += "</table>";	
			$("#partnerAnls").html(partnerAnlsHtml);
		}
	});
	show_popup($("#lay_popup3"));
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
				<h4 class="title03">파트너사 관리</h4>
				<!--검색-->
				<p class="search_list_ps"></p>
				<p class="search_list_ps">-탐나오 파트너사 URL : https://www.tamnao.com/?partner={파트너코드} </p>
				<p class="search_list_ps">-수집정보 : 회원가입/예약(구매) 시 파트너코드 수집 </p>
				<p class="search_list_ps"></p>
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
							<th>번호</th>
							<th>파트너코드</th>
							<th>파트너명</th>
							<th>접속횟수</th>
							<th>기능툴</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="5" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">${result.partnerCd}</td>
								<td class="align_ct">${result.partnerNm}</td>
								<td class="align_ct">${result.totalAccessCnt}</td>
								<td class="align_ct">
									<div class="btn_sty07"><span><a href="javascript:fn_partnerAnls('${result.partnerCd}')">접속현황</a></span></div>
									<div class="btn_sty06"><span><a href="javascript:fn_UdtTamnaoPartner('${result.partnerCd}')">수정</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_DelTamnaoPartner('${result.partnerCd}')">삭제</a></span></div>
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
						<a href="javascript:fn_InsTamnaoPartner();">등록</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="lay_popup" class="lay_popup lay_ct" style="display:none;">
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
						<th>파트너코드<span class="font02">*</span></th>
						<td>
							<input type="text" name="partnerCd" id="partnerCd" class="input_text5" maxlength="20" placeholder="영어20자" />
						</td>
					</tr>
					<tr>
						<th>파트너명<span class="font02">*</span></th>
						<td>
							<input type="text" name="partnerNm" id="partnerNm" class="input_text5" maxlength="25" placeholder="한글25자" />
						</td>
					</tr>
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_InsPartner()">저장</a></span>
    </div>
</div>

<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<form name="udtCmssFrm">
		<ul class="form_area">
			<li>
				<table border="1" class="table02" >
  					<caption class="tb01_title">수수료관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="170" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>파트너코드</th>
						<td>
							<input type="text" name="udtPartnerCd" id="udtPartnerCd" class="input_text5 center" maxlength="20" value="${searchVO.partnerCd}" readonly />
						</td>
					</tr>
					<tr>
						<th>파트너명</th>
						<td>
							<input type="text" name="udtPartnerNm" id="udtPartnerNm" class="input_text5 center" maxlength="20" value="${searchVO.partnerNm}" />
						</td>
					</tr>
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:fn_UdtPartner()">수정</a></span>
    </div>
</div>

<div id="lay_popup3" class="lay_popup lay_ct" style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup3'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<form name="udtCmssFrm">
		<ul class="form_area">
			<li>
				
				<div id="partnerAnls"/>
       		</li>
       </ul>
    </form>
</div>

</body>
</html>