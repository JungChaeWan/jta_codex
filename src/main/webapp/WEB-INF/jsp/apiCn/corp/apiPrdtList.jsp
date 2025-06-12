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
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
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
	document.frm.action = "<c:url value='/apiCn/prdtLink.do'/>";
	document.frm.submit();
}

function fn_Use(prdtNum, flagYn){
	if(flagYn == "Y"){
		flagYn = "N";
	}else{
		flagYn = "Y";
	}
	
	$.ajax({
		url : "<c:url value='/apiCn/rc/changeLinkPrdt.ajax'/>",
		dataType:"json",
		data : "prdtNum=" + prdtNum + "&prdtLinkYn=" + flagYn,
		success: function(data) {
			if(flagYn == "Y"){
				alert("연계 설정 되었습니다.");
			}else{
				alert("연계 해제 되었습니다.");
			}
			fn_Search("1");
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

</script>

</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/apiCn/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<%-- <jsp:include page="/oss/left.do?menu=setting&sub=code" flush="false"></jsp:include> --%>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="apiId" name="apiId" />
				<input type="hidden" id="sCorpId" name="sCorpId" value="${searchVO.sCorpId}"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
									<col width="*" />
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
          								<th scope="row">상&nbsp;품&nbsp;명</th>
          								<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
          								<th scope="row">거래상태</th>
       									<td>
       										<select name="sTradeStatus">
       											<option value="">전체</option>
       											<c:forEach items="${tsCd}" var="code" varStatus="status">
       												<option value="${code.cdNum}" <c:if test="${code.cdNum eq searchVO.sTradeStatus}">selected="selected"</c:if>>${code.cdNm}</option>
       											</c:forEach>
       										</select>
       									</td>
       								</tr>
       								<tr>
       									<th scope="row">차량구분</th>
          								<td colspan="3">
          									<select name="sCarDivCd" id="sCarDivCd">
          										<option value="">전체</option>
          										<c:forEach items="${carDivCd}" var="carDiv" varStatus="status">
          											<option value="${carDiv.cdNum}" <c:if test="${searchVO.sCarDivCd eq carDiv.cdNum}">selected="selected"</c:if>>${carDiv.cdNm}</option>
          										</c:forEach>
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
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <col width="8%" />
                        <col width="9%" />
                        <col />                        
                        <col width="9%" />
                        <col width="9%" />
                        <col width="9%" />
                        <col width="9%" />
                        <col width="9%" />
                        <col width="9%" />
                        <col width="370" />
                    </colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>상품번호</th>
							<th>상품명</th>							
							<th>거래상태</th>
							<th>차량구분</th>
							<th>사용연료</th>
							<th>정원</th>
							<th>노출순번</th>
							<th>연계여부</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="8" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="prdtInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">${prdtInfo.prdtNum}</td>
								<td>${prdtInfo.prdtNm}</td>								
								<td class="align_ct">
									<c:forEach var="code" items="${tsCd}" varStatus="status">
										<c:if test="${prdtInfo.tradeStatus==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
									</c:forEach>
								</td>
								<td class="align_ct">
									<c:forEach var="code" items="${carDivCd}" varStatus="status">
										<c:if test="${prdtInfo.carDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
									</c:forEach>
								</td>
								<td class="align_ct">
									<c:forEach var="code" items="${fuelCd}" varStatus="status">
										<c:if test="${prdtInfo.useFuelDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
									</c:forEach>
								</td>
								<td class="align_ct">${prdtInfo.maxiNum}</td>
								<td class="align_ct">${prdtInfo.viewSn}</td>
								<td class="align_ct">
									<c:out value="${prdtInfo.prdtLinkYn}"/>
								</td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_Use('${prdtInfo.prdtNum}', '${prdtInfo.prdtLinkYn}')">연계사용/미사용</a></span></div>
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
			</form>
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
 					<caption class="tb01_title">연계업체등록</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
				<tr>
					<th>업체</th>
					<td>
						<div class="btn_sty07"><span><a href="javascript:fn_FindCorp();">업체검색</a></span></div>
						<input type="text" name="corpId" id="corpId" readonly="readonly" />
						<input type="text" name="corpNm" id="corpNm" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>인증키</th>
					<td>
						<div class="btn_sty07"><span><a href="javascript:fn_AuthKey();">재생성</a></span></div>
						<input type="text" name="authkey" id="authkey" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>연계여부</th>
					<td>
						<p>연계여부는 'N'(연계하지않음)으로 설정됩니다.</p>
						<p>연계 테스트 후 'Y'(연계)로 수정해 주세요.</p>
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty03" id="btnResist"><a href="javascript:fn_InsApiCorp();">연계업체등록</a></span>
	</div>
</div>
<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" id="cntLay">
 					<caption class="tb01_title">연계업체수정</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
				<tr>
					<th>업체</th>
					<td>
						<input type="hidden" name="modApiId" id="modApiId" />
						<input type="text" name="modCorpId" id="modCorpId" readonly="readonly" />
						<input type="text" name="modCorpNm" id="modCorpNm" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>인증키</th>
					<td>
						<div class="btn_sty07"><span><a href="javascript:fn_AuthKey();">재생성</a></span></div>
						<input type="text" name="modAuthkey" id="modAuthkey" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>연계여부</th>
					<td>
						<select id="linkYn" name="linkYn">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty04" id="btnResist"><a href="javascript:fn_UdtApiCorp();">수정</a></span>
	</div>
</div>
</body>
</html>