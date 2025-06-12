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
	document.frm.action = "<c:url value='/oss/corpLevel.do'/>";
	document.frm.submit();
}

function fn_Category(category) {
	// form reset
	$('form').each(function() {
		this.reset();
	});
	<c:if test="${searchVO.sCategory != '' && searchVO.sCategory != 'RC' }">	
	$('#sType0').prop("checked", true);
	</c:if>
	<c:if test="${searchVO.sCategory != 'SV' }">	
	$('select[name=sType]').val('');
	</c:if>
	document.frm.sCorpNm.value = "";
	document.frm.pageIndex.value = 1;
	document.frm.sCategory.value = category;
	document.frm.action = "<c:url value='/oss/corpLevel.do'/>";
	document.frm.submit();
}

function fn_Level(corpId){
	var parameters = "corpId=" + corpId;
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/getCorpLevel.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#corpId").val(data.levelInfo.corpId);
			$("#corpNm").html(data.levelInfo.corpNm);
			$("#complainLevel").val(data.levelInfo.complainLevel);
			$("#joinLevel").val(data.levelInfo.joinLevel);
			$("#amtLevel").val(data.levelInfo.amtLevel);
			
			show_popup($("#lay_popup"));
		}
	});
	
	return;
}

function fn_LevelMod(){
	var parameters = "corpId=" + $("#corpId").val();
	parameters += "&complainLevel=" + $("#complainLevel").val();
	parameters += "&joinLevel=" + $("#joinLevel").val();
	parameters += "&amtLevel=" + $("#amtLevel").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/updateLevelModInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			document.frm.action = "<c:url value='/oss/corpLevel.do'/>";
			document.frm.submit();
		}
	});
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/corpSaveExcel.do?"+ parameters +"'/>";

}

$(function() {	
	$('select[name=sType]').change(function() {
		// 기존 subType 제거
		$('select[name=sGubun]').find('option').each(function() {
			$(this).remove();	
		});
		
		$('select[name=sGubun]').show();
		
		$('select[name=sGubun]').append("<option value=''>= 2depth =</option>");
		
		var parameters = "cdNum=" + $(this).val();
		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/getCodeList.ajax'/>",
			data:parameters ,
			success:function(data){
				var cdList = data['cdList'];
				for (var i=0, e=cdList.length; i<e; i++) {
					var selectedStr = '';
					if ("${searchVO.sGubun}" == cdList[i].cdNum)
						selectedStr = ' selected';
					
					$('select[name=sGubun]').append("<option value='" + cdList[i].cdNum + "'" + selectedStr + ">" + cdList[i].cdNm + "</option>");							
				}
			}
		});		
	});	
	$('select[name=sType]').change();
});

</script>

</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corpLevel" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<h4 class="title03"><c:out value="입점업체지수"/></h4><br/>
				
				<!-- change contents -->
	            <!-- 3Depth menu -->
	               <div id="menu_depth3">
					<ul>					
						<li<c:if test="${searchVO.sCategory eq 'AD' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('AD');">숙소</a></li>
						<li<c:if test="${searchVO.sCategory eq 'RC' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('RC');">렌터카</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPC' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SPC');">관광지/레저</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPF' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SPF');">맛집</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPT' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SPT');">여행사 상품</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SV' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SV');">제주특산/기념품</a></li>
					</ul>
				</div>
				
				<!-- 검색옵션 -->
				<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="sCategory" name="sCategory" value="${searchVO.sCategory}" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<div class="search_box">
			        <div class="search_form">
			            <div class="tb_form">
			                <table width="100%" border="0">
			                    <colgroup>
			                        <col style="widht: 100px" />
			                        <col />
			                    </colgroup>
			                    <tbody>
			                    	<c:if test="${searchVO.sCategory eq 'AD' }">
			                    	<tr>
			                            <th scope="row">유형</th>
			                            <td>
			                                <label class="lb"><input type="radio" id="sType0" name="sType"<c:if test="${empty searchVO.sType }" >checked="checked"</c:if> value="" /> <span>전체</span></label>
			                                <c:forEach var="data" items="${categoryList}" varStatus="status">
	                                           	<label class="lb"><input id="sType${status.index+1}" type="radio" name="sType" value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">checked="checked"</c:if>><label for="sType${status.index+1}">${data.cdNm }</label></label>
	                                           </c:forEach>
			                            </td>
			                        </tr>
			                        </c:if>			                        
			                        <c:if test="${searchVO.sCategory eq 'SPT' }">
			                    	<tr>
			                            <th scope="row">유형</th>
			                            <td>
			                                <label class="lb"><input type="radio" id="sType0" name="sType"<c:if test="${empty searchVO.sType }" >checked="checked"</c:if> value="" /> <span>전체</span></label>
			                                <c:forEach var="data" items="${categoryList}" varStatus="status">
	                                           	<label class="lb"><input id="sType${status.index+1}" type="radio" name="sType" value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">checked="checked"</c:if>><label for="sType${status.index+1}">${data.cdNm }</label></label>
	                                           </c:forEach>
			                            </td>
			                        </tr>
			                        </c:if>
			                        <c:if test="${searchVO.sCategory eq 'SPF' }">
			                    	<tr>
			                            <th scope="row">유형</th>
			                            <td>
			                                <label class="lb"><input type="radio" id="sType0" name="sType"<c:if test="${empty searchVO.sType }" >checked="checked"</c:if> value="" /> <span>전체</span></label>
			                                <c:forEach var="data" items="${categoryList}" varStatus="status">
	                                           	<label class="lb"><input id="sType${status.index+1}" type="radio" name="sType" value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">checked="checked"</c:if>><label for="sType${status.index+1}">${data.cdNm }</label></label>
	                                           </c:forEach>
			                            </td>
			                        </tr>
			                        </c:if>
			                        <c:if test="${searchVO.sCategory eq 'SPC' }">
			                    	<tr>
			                            <th scope="row">유형</th>
			                            <td>
			                                <label class="lb"><input type="radio" id="sType0" name="sType"<c:if test="${empty searchVO.sType }" >checked="checked"</c:if> value="" /> <span>전체</span></label>
			                                <c:forEach var="data" items="${categoryList}" varStatus="status">
	                                           	<label class="lb"><input id="sType${status.index+1}" type="radio" name="sType" value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">checked="checked"</c:if>><label for="sType${status.index+1}">${data.cdNm }</label></label>
	                                           </c:forEach>
			                            </td>
			                        </tr>
			                        </c:if>	
			                        <c:if test="${searchVO.sCategory eq 'SV' }">
			                    	<tr>
			                            <th scope="row">유형</th>
			                            <td>
			                            	<select id="sType" name="sType">
			                            		<option value="">= 1depth =</option>
			                            		<c:forEach var="data" items="${categoryList}" varStatus="status">
			                            		<option value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">selected</c:if>>${data.cdNm}</option>
			                            		</c:forEach>
			                            	</select>
			                            	
			                            	 - 
			                            	 
			                            	 <select id="sGubun" name="sGubun">
			                            		<option value="">= 2depth =</option>
			                            	</select>
			                            </td>
			                        </tr>
			                        </c:if>		                        
			                        <tr>
			                            <th scope="row">업체명</th>
			                            <td>
			                                <input type="text" name="sCorpNm" placeholder="업체명을 입력해주세요." style="width: 245px" value="${searchVO.sCorpNm }" />
			                            </td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
			            <span class="btn"><input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1', 'search')" /></span>
			        </div>
			    </div>
			    </form>		    
				
				<div id="contents">
				
	            <%-- <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> --%>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<thead>
						<tr>
						  <c:if test="${searchVO.sCategory ne 'SV' }">
						    <c:set var="titleStr" value="예약" />
						  </c:if>
						  <c:if test="${searchVO.sCategory eq 'SV' }">
						    <c:set var="titleStr" value="구매" />
						  </c:if>
							<th>순위</th>
							<th>업체명</th>
							<th>업체지수</th>
							<th>${titleStr }</th>
							<th>${titleStr }율</th>
							<th>${titleStr }지수</th>
							<th>취소건수</th>
							<th>취소율</th>
							<th>취소지수</th>
							<th>평점</th>
							<th>이용후기</th>
							<th>후기등록율</th>
							<th>후기지수</th>
							<th>SNS공유</th>
							<th>재구매</th>
							<th>재구매율</th>
							<th>재구매지수</th>
							<!-- <th>컴플레인</th>
							<th>관리도</th>
							<th>가격경쟁력</th> -->
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="13" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="corpInfo" items="${resultList}" varStatus="status">
							<tr style="cursor:pointer;" onclick="fn_Level('${corpInfo.corpId}');">
								<td class="align_ct"><c:out value="${corpInfo.rk}"/></td>							
								<td class="align_ct"><c:out value="${corpInfo.corpNm}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.corpLevel}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.rsvCnt}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.rsvPct}"/>
								<td class="align_ct"><c:out value="${corpInfo.rsvLevel}"/>
								<td class="align_ct"><c:out value="${corpInfo.cancelCnt}"/>
								<td class="align_ct"><c:out value="${corpInfo.cancelPct}"/>
								<td class="align_ct"><c:out value="${corpInfo.cancelLevel}"/>
								<td class="align_ct"><c:out value="${corpInfo.gpa}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.useepilCnt}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.useepilRegpct}"/>
								<td class="align_ct"><c:out value="${corpInfo.useepilLevel}"/>
								<td class="align_ct"><c:out value="${corpInfo.snsPublicnum}"/></td>
								<td class="align_ct"><c:out value="${corpInfo.duplBuyCnt}"/>
								<td class="align_ct"><c:out value="${corpInfo.duplBuyPct}"/>
								<td class="align_ct"><c:out value="${corpInfo.duplBuyLevel}"/>
								<%-- <td class="align_ct"><c:out value="${corpInfo.complainLevel}"/>
								<td class="align_ct"><c:out value="${corpInfo.joinLevel}"/>
								<td class="align_ct"><c:out value="${corpInfo.amtLevel}"/> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<!-- <ul class="btn_rt01">
					<li class="btn_sty02">
						<a href="javascript:fn_SaveExcel()">엑셀저장</a>
					</li>				
				</ul> -->
				</div>
			</div>
		</div>
	</div>
</div>
<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" id="cntLay">
 					<caption class="tb01_title">평가지수 반영</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
                <input type='hidden' id="corpId" />
                <tr>
					<th>업체명</th>
					<td id="corpNm"></td>
				</tr>
				<tr>
					<th>컴플레인 (-)</th>
					<td><input type="text" name="complainLevel" id="complainLevel" /></td>
				</tr>
				<tr>
					<th>관리도</th>
					<td><input type="text" name="joinLevel" id="joinLevel" /></td>
				</tr>
				<tr>
					<th>가격경쟁력</th>
					<td><input type="text" name="amtLevel" id="amtLevel" /></td>
				</tr>				
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty03" id="btnResist"><a href="javascript:fn_LevelMod()">평가지수 반영</a></span>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>