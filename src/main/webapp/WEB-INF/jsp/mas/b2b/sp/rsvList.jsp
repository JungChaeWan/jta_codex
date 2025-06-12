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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Search(){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/b2b/rsvList.do'/>";
	document.frm.submit();
}

/**
 * 상품 단건 취소요청
 */
function fn_ReqCancelPop(prdtRsvNum){
	if (window.confirm("해당 상품을 취소요청 하시겠습니까?")){
		var parameters = "prdtRsvNum=" + prdtRsvNum;
		
		$.ajax({
			type:"post", 
			dataType:"json",
			// async:false,
			url:"<c:url value='/web/reqCancel.ajax'/>",
			data:parameters ,
			success:function(data){
				location.reload();
			}
		});
	}
	
}

$(document).ready(function() {
	
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
			<div id="contents">
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
          								<th scope="row">예약번호</th>
          								<td>
          									<input type="text" id="sRsvNum" class="input_text13" name="sRsvNum" value="${searchVO.sRsvNum}" title="검색하실 예약번호를 입력하세요." maxlength="20" />
          								</td>
          								<th scope="row">예약상태</th>
               							<td>
               								<select name="sRsvStatusCd" style="width:100%">
               									<option value="">전체</option>
               									<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>예약</option>
               									<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
               									<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청</option>
               									<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>취소완료</option>
               									<option value="${Constant.RSV_STATUS_CD_CCOM2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM2}">selected="selected"</c:if>>환불완료</option>
               									<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>사용완료</option>
               								</select>
               							</td>
       								</tr>
	     							<tr>
          								<th scope="row">사&nbsp;용&nbsp;자</th>
          								<td><input type="text" id="sUseNm" class="input_text13" name="sUseNm" value="${searchVO.sUseNm}" title="검색하실 사용자를 입력하세요." maxlength="20" /></td>
          								<th scope="row">상품구분</th>
          								<td>
          									<select name="sPrdtCd" style="width:100%">
          										<option value="">전체</option>
          										<option value="${Constant.ACCOMMODATION}" <c:if test="${Constant.ACCOMMODATION eq searchVO.sPrdtCd}">selected="selected"</c:if>>숙박</option>
          										<option value="${Constant.RENTCAR}" <c:if test="${Constant.RENTCAR eq searchVO.sPrdtCd}">selected="selected"</c:if>>렌터카</option>
          										<option value="${Constant.GOLF}" <c:if test="${Constant.GOLF eq searchVO.sPrdtCd}">selected="selected"</c:if>>골프</option>
          										<option value="${Constant.CATEGORY_PACKAGE}" <c:if test="${Constant.CATEGORY_PACKAGE eq searchVO.sPrdtCd}">selected="selected"</c:if>>패키지 할인상품</option>
          										<option value="${Constant.CATEGORY_TOUR}" <c:if test="${Constant.CATEGORY_TOUR eq searchVO.sPrdtCd}">selected="selected"</c:if>>관광지/레저</option>
          										<option value="${Constant.CATEGORY_ETC}" <c:if test="${Constant.CATEGORY_ETC eq searchVO.sPrdtCd}">selected="selected"</c:if>>음식/뷰티</option>
          									</select>
          								</td>
       								</tr>
       								<tr>
          								<th scope="row">업&nbsp;체&nbsp;명</th>
          								<td><input type="text" id="sCorpNm" class="input_text13" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명를 입력하세요." maxlength="20" /></td>
          								<th scope="row">상&nbsp;품&nbsp;명</th>
          								<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." maxlength="13" /></td>
       								</tr>
	     						</tbody>
	               			</table>
	               		</div>
	               		<div class="search-wrap">
				            <span class="btn">
								<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
				            
			            </div>
						
	              	</div>
	            </div>
	            <div id="searchResult">
	            	<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> 
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <col width="10%" />
                        <col />
                        <col width="7%" />
                        <col width="220px" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="7%" />
                        <col width="7%" />
                    </colgroup>
					<thead>
						<tr>
							<th>예약번호</th>
                            <th>예약정보</th>
                            <th>예약상태</th>
                            <th>결제금액</th>
                            <th>예약일시</th>
                            <th>사용자</th>
                            <th>기능툴</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="9" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach items="${resultList}" var="rsvInfo" varStatus="stauts">
	                		<tr style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.rsvNum}')">
	                			<td class="align_ct">${rsvInfo.rsvNum}</td>
	                			<td class="align_lt">
	                				<h5 style="font-size: 12px;">[<c:out value="${rsvInfo.prdtCdNm}"/>] 
									<span class="cProduct"><c:out value="${rsvInfo.corpNm}"/> <c:out value="${rsvInfo.prdtNm}"/></span></h5>
									<p><c:out value="${rsvInfo.prdtInf}"/></p>
	                			</td>
	                			<td class="align_ct">
	                				<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약처리중</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">
                						<span class="font02">취소요청</span>
                						(<c:out value="${rsvInfo.cancelRequestDttm}"/>)
                					</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}"><span class="font02">환불요청</span></c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료(<c:out value="${rsvInfo.cancelCmplDttm}"/>)</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}"><span class="font02">부분환불요청</span></c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료
                					<c:if test="${rsvInfo.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
											(<c:out value="${rsvInfo.useDttm}"/>)
									</c:if>
                					</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">
                					사용완료
                					<c:if test="${rsvInfo.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
											(<c:out value="${rsvInfo.useDttm}"/>)
									</c:if>
                					</c:if>
                					<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
	                			</td>
	                			<td class="align_rt">
                                    <fmt:formatNumber>${rsvInfo.saleAmt}</fmt:formatNumber>원
	                			</td>
	                			<td class="align_ct">
	                				<c:out value='${rsvInfo.regDttm}'/>
	                			</td>
	                			<td class="align_ct">
	                				<p><c:out value='${rsvInfo.useNm}'/></p>
	                				<p>(<c:out value='${rsvInfo.useTelnum}'/>)</p>
	                			</td>
	                			<td class="align_ct">
	                				<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
	                					<div class="btn_sty09">
	                						<span><a href="javascript:fn_ReqCancelPop('${rsvInfo.prdtRsvNum}');">취소요청</a></span>
                            			</div>
                                    </c:if>
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
			</form>
		</div>
	</div>
</div>

</body>
</html>