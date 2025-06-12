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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
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
	document.frm.action = "<c:url value='/oss/b2bReqList.do'/>";
	document.frm.submit();
}

/**
 * 업체 정보 상세보기
 */
function fn_DtlCorp(corpId){
	document.frm.corpId.value = corpId;
	document.frm.action = "<c:url value='/oss/detailCorp.do'/>";
	document.frm.submit();
}

/**
 * 업체 추가정보 보기
 */
function fn_CorpDtlInfo(corpId){
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/corpDtlInfoChk.do'/>",
		data:parameters ,
		success:function(data){
			if(data.resultChk == "N"){
				alert("업체 추가정보가 등록되지 않았습니다.");
			}else{
				document.frm.corpId.value = corpId;
				document.frm.action = "<c:url value='/oss/corpDtlInfo.do'/>";
				document.frm.submit();				
			}
		},
		error : fn_AjaxError
	});
}

function fn_Rstr(corpId){
	var parameters = "sCorpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/selectB2bReqInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#rstrCorpId").val(data.corpConfVO.corpId);
			$("#rstrCorpNm").text(data.corpConfVO.corpNm);
			$("#rstr_confRequestDttm").text(data.corpConfVO.confRequestDttm);
			
			show_popup("#rstrPop");
		},
		error : fn_AjaxError
	});
}

function fn_CorpRstr(){
	if(confirm("해당 업체를 사용반려 하시겠습니까?")){
		var parameters = "corpId=" + $("#rstrCorpId").val();
		parameters += "&rstrContents=" + $("#rstrContents").val();
		
		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/oss/rstrB2bReq.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "${Constant.FLAG_N}"){
					alert(data.errorMsg);
					return;
				}else{
					alert("해당업체가 반려처리 되었습니다.");
					
					document.frm.action = "<c:url value='/oss/b2bReqList.do'/>";
					document.frm.submit();
				}
			},
			error : fn_AjaxError
		});
	}
}

function fn_DtlRstr(corpId){
	var parameters = "sCorpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/selectB2bReqInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#dtlRstr_rstrDttm").text(data.corpConfVO.rstrDttm);
			$("#dtlRstr_corpNm").text(data.corpConfVO.corpNm);
			$("#dtlRstr_memo").text(data.corpConfVO.rstrContents);
			
			show_popup("#dtlRstr");
		},
		error : fn_AjaxError
	});
}

function fn_Conf(corpId){
	if(confirm("해당업체를 승인처리 하시겠습니까?")){
		var parameters = "corpId=" + corpId;
		
		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/oss/b2bConf.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "${Constant.FLAG_N}"){
					alert(data.errorMsg);
					return;
				}else{
					alert("해당업체가 승인처리 되었습니다.");
					
					document.frm.action = "<c:url value='/oss/b2bReqList.do'/>";
					document.frm.submit();
				}
			},
			error : fn_AjaxError
		});
	}
}

$(document).ready(function() {
	$("#sFromDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sToDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=b2bReq" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="corpId" name="corpId" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
			<!--검색-->
            <div class="search_box">
            	<div class="search_form">
                	<div class="tb_form">
						<table width="100%" border="0">
							<colgroup>
								<col width="100" />
                                <col width="*" />
								<col width="100" />
                                <col width="*" />
							</colgroup>
             				<tbody>
             					<tr>
        							<th scope="row">업&nbsp;체&nbsp;명</th>
        							<td><input type="text" id="sCorpNm" class="input_text_full" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
        							<th scope="row">업체아이디</th>
        							<td><input type="text" id="sCorpId" class="input_text_full" name="sCorpId" value="${searchVO.sCorpId}" title="검색하실 업체아이디를 입력하세요." /></td>
     							</tr>
             					<tr>
             						<th scope="row">처리상태</th>
        							<td>
        								<select name="sStatusCd" id="sStatusCd">
        									<option value="">전 체</option>
        									<option value="${Constant.TRADE_STATUS_APPR_REQ}" <c:if test="${Constant.TRADE_STATUS_APPR_REQ eq searchVO.sStatusCd}">selected="selected"</c:if>>승인요청</option>
        									<option value="${Constant.TRADE_STATUS_APPR_REJECT}" <c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq searchVO.sStatusCd}">selected="selected"</c:if>>반려</option>
        									<option value="${Constant.TRADE_STATUS_APPR}" <c:if test="${Constant.TRADE_STATUS_APPR eq searchVO.sStatusCd}">selected="selected"</c:if>>승인</option>
        								</select>
        							</td>
        							<th scope="row">요청일</th>
        							<td>
        								<input type="text" id="sFromDt" class="input_text4 center" name="sFromDt" value="${searchVO.sFromDt}" title="검색시작일" /> ~ 
	               						<input type="text" id="sToDt" class="input_text4 center" name="sToDt"  title="검색종료일" value="${searchVO.sToDt}" />
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
            <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> 
			<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				<colgroup>
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>업체아이디</th>
						<th>업체명</th>
						<th>업체분류</th>
						<th>상태</th>
						<th>대표자명</th>
						<th>전화번호</th>
						<th>회원사</th>
						<th>승인요청일시</th>
						<th colspan="2">기능툴</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 없음 -->
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="11" class="align_ct">
								<spring:message code="common.nodata.msg" />
							</td>
						</tr>
					</c:if>
					<c:forEach var="corpInfo" items="${resultList}" varStatus="status">
						<tr>
							<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.corpId}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.corpNm}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.corpCdNm}"/></td>
							<td class="align_ct">
								<c:if test="${corpInfo.statusCd eq Constant.TRADE_STATUS_APPR_REQ}">승인요청</c:if>
								<c:if test="${corpInfo.statusCd eq Constant.TRADE_STATUS_APPR_REJECT}">반려(<c:out value='${corpInfo.rstrDttm}'/>)</c:if>
								<c:if test="${corpInfo.statusCd eq Constant.TRADE_STATUS_APPR}">승인(<c:out value='${corpInfo.confDttm}'/>)</c:if>
							</td>
							<td class="align_ct"><c:out value="${corpInfo.ceoNm}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.rsvTelNum}"/></td>
							<td class="align_ct">
								<c:if test="${corpInfo.asctMemYn == 'Y' }">회원사</c:if>
								<c:if test="${corpInfo.asctMemYn != 'Y' }">비회원</c:if>
							</td>
							<td class="align_ct"><c:out value="${corpInfo.confRequestDttm}"/></td>
							<td class="align_ct">
								<c:if test="${not empty corpInfo.rstrContents}">
									<div class="btn_sty06"><span><a href="javascript:fn_DtlRstr('${corpInfo.corpId}');">반려상세</a></span></div>
								</c:if>
							</td>
							<td class="align_ct">
								<c:if test="${corpInfo.statusCd eq Constant.TRADE_STATUS_APPR_REQ}">
									<div class="btn_sty06"><span><a href="javascript:fn_Conf('${corpInfo.corpId}');">승인</a></span></div>
									<div class="btn_sty06"><span><a href="javascript:fn_Rstr('${corpInfo.corpId}');">반려</a></span></div>
								</c:if>
								<c:if test="${(corpInfo.statusCd eq Constant.TRADE_STATUS_APPR_REJECT) or
												(corpInfo.statusCd eq Constant.TRADE_STATUS_APPR)}">
									<div class="btn_sty06 disabled"><span><a>승인</a></span></div>
									<div class="btn_sty06 disabled"><span><a>반려</a></span></div>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			</p>
			</div>
			</form>
		</div>
	</div>
</div>
<!-- layer popup  -->
<div class="blackBg"></div>

<div id="rstrPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">B2B시스템 사용등록 반려</h3>
                <button type="button" class="close" onclick="close_popup('#rstrPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<input type="hidden" name="rstrCorpId" id="rstrCorpId" />
            	<div class="info"><strong>요청업체 :</strong> <span id="rstrCorpNm"></span></div>
            	<div class="info"><strong>요청일시 :</strong> <span id="rstr_confRequestDttm"></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo">
                		<textarea id="rstrContents" name="rstrContents" rows="5" class="width90"></textarea>
					</div>
                </div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn red" onclick="fn_CorpRstr();">반려</a> 
            </div>
        </div>
    </div>
</div>

<div id="dtlRstr" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">B2B시스템 사용등록 반려</h3>
                <button type="button" class="close" onclick="close_popup('#dtlRstr');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<div class="info"><strong>반려업체 :</strong> <span>제주관광협회 탐나오</span></div>
            	<div class="info"><strong>반려일시 :</strong> <span id="dtlRstr_rstrDttm"></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo" id="dtlRstr_memo">
	                    
					</div>
                </div>
                
                <div class="info"><strong>요청업체 :</strong> <span id="dtlRstr_corpNm">신바람 여행사</span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
            	<a class="btn" onclick="close_popup('#dtlRstr');">확인</a>
            </div>
        </div>
    </div>
</div> <!--//layer-popup-->
</body>
</html>