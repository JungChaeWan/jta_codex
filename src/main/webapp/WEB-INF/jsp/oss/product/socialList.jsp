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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

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
	document.frm.action = "<c:url value='/oss/socialProductList.do'/>";
	document.frm.submit();
}

function fn_viewProductAppr(prdtNum) {	
	$.ajax({
		type:"post", 
		url:"<c:url value='/oss/viewPrdtAppr.ajax'/>",
		data:"linkNum=" + prdtNum ,
		success:function(data){
			$("#div_ProductAppr").html(data);
			show_popup($("#div_ProductAppr"));
		},
		error : fn_AjaxError
	});
}

function fn_InsertProductAppr() {
	
	var parameter = $("#CM_CONFHISTVO").serialize();
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/oss/productAppr.ajax'/>",
		data:parameter,
		success:function(data){
			fn_Search($("#pageIndex").val());
		},
		error : fn_AjaxError
	});
}

function fn_LoginMas(corpId){
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				window.open("<c:url value='/mas/home.do'/>", '_blank');
			}else{
				alert("업체 로그인에 실패하였습니다.");
			}
		}
	});
}

function fn_goExprPrdtList(type) {

	//기간만료 예정상품
	if (type == "expr"){
		$("#sExprYn").val("Y");
	}

	//유효만료 예정상품
	if ( type == "exprEnd") {
		$("#sExprEndYn").val("Y");
	}

	document.frm.action = "<c:url value='/oss/socialExprProductList.do'/>";
	document.frm.submit();
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/socialProductListExcel.do?"+ parameters +"'/>";

}


$(function() {
	$("#sSaleStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sSaleEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
	$("#sConfStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sConfEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sConfStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
	
	$('select[name=sCtgr]').change(function() {
		var cateArray = ['${Constant.CATEGORY_PACKAGE}', '${Constant.CATEGORY_TOUR}', '${Constant.CATEGORY_ETC}', '${Constant.CATEGORY_ADRC}'];
		if (cateArray.indexOf($(this).val()) != -1) {						
			// 기존 subCd 제거
			$('select[name=sSubCtgr]').find('option').each(function() {
				$(this).remove();	
			});
			
			$('select[name=sSubCtgr]').show();
			
			$('select[name=sSubCtgr]').append("<option value=''>전체</option>");
			if ($(this).val() != '${Constant.CATEGORY_ADRC}') {
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
							if ("${searchVO.sSubCtgr}" == cdList[i].cdNum)
								selectedStr = ' selected';
							
							$('select[name=sSubCtgr]').append("<option value='" + cdList[i].cdNum + "'" + selectedStr + ">" + cdList[i].cdNm + "</option>");							
						}
					}
				});
			} else {
				var selectedAd = '';
				var selectedRc = '';
				if ("${searchVO.sSubCtgr}" == '${Constant.CATEGORY_PACK_AD}')
					selectedAd = ' selected';
				else if ("${searchVO.sSubCtgr}" == '${Constant.CATEGORY_PACK_RC}')
					selectedRc = ' selected';
				
				$('select[name=sSubCtgr]').append("<option value='${Constant.CATEGORY_PACK_AD}'" + selectedAd + ">숙소</option>");
				$('select[name=sSubCtgr]').append("<option value='${Constant.CATEGORY_PACK_RC}'" + selectedRc + ">렌터카</option>");
			}
		} else {
			$('select[name=sSubCtgr]').hide();
		}
	});
	$('select[name=sCtgr]').change();
});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=social" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
				<input type="hidden" id="sExprYn" name="sExprYn" />
				<input type="hidden" id="sExprEndYn" name="sExprEndYn" />

			<div id="contents">
				<!--검색-->
                <div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="850" border="0">
								<colgroup>
									<col width="55" />
									<col width="300" />
                                    <col width="55" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
               							<th scope="row">처리상태</th>
               							<td colspan="3">
               								<input type="radio" name="sTradeStatus" value=""   <c:if test='${empty searchVO.sTradeStatus}'>checked</c:if>> 전체</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REQ}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REQ}'>checked</c:if>> 승인요청</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR}'>checked</c:if>> 승인</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REJECT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REJECT}'>checked</c:if>> 승인거절</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_STOP}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_STOP}'>checked</c:if>> 판매중지</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_STOP_REQ}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_STOP_REQ}'>checked</c:if>> 판매중지 요청</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_EDIT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_EDIT}'>checked</c:if>> 수정요청</input>&nbsp;
               							</td>
               						</tr>
               						<tr>
               							<th scope="row">승인일</th>
               							<td><input type="text" id="sConfStartDt" class="input_text4 center" name="sConfStartDt" value="${searchVO.sConfStartDt}"  title="승인시작일" /> ~ <input type="text" id="sConfEndDt" class="input_text4 center" name="sConfEndDt"  title="승인종료일"   value="${searchVO.sConfEndDt}"/></td>
          								<th scope="row">판매일</th>
          								<td><input type="text" id="sSaleStartDt" class="input_text4 center" name="sSaleStartDt" value="${searchVO.sSaleStartDt}"  title="판매시작일" /> ~ <input type="text" id="sSaleEndDt" class="input_text4 center" name="sSaleEndDt"  value="${searchVO.sSaleEndDt}" title="판매종료일" /></td>
       								</tr>
       								<tr>
       									<th scope="row">업체명</th>
       									<td><input type="text" id="sCorpNm" name="sCorpNm" class="input_text15" value="${searchVO.sCorpNm}"/></td>
       									<th scope="row">상품명</th>
       									<td><input type="text" id="sPrdtNm" name="sPrdtNm" class="input_text15" value="${searchVO.sPrdtNm}"/></td>
       								</tr>
       								<tr>
       									<th scope="row">카테고리</th>
       									<td>
       										<select id="sCtgr" name="sCtgr">
       											<option value="" <c:if test="${empty searchVO.sCtgr}">selected</c:if>>전   체 </option>
       											<c:forEach items="${spCtgrList}" var="cd">
       											<option value="${cd.cdNum}" <c:if test="${searchVO.sCtgr eq cd.cdNum}">selected</c:if>>${cd.cdNm}</option>
       											</c:forEach>
       										</select>
       										<select name="sSubCtgr" style="width: 110px; display: none;"></select>
       									</td>
       									<th scope="row">업종</th>
       									<td>
       										<select id="sCorpSubCd" name="sCorpSubCd">
       											<option value="" <c:if test="${empty searchVO.sCorpSubCd}">selected</c:if>>전   체 </option>
       											<option value="${Constant.SOCIAL_TOUR}" <c:if test="${Constant.SOCIAL_TOUR eq searchVO.sCorpSubCd}">selected</c:if>>여행사</option>
       											<option value="${Constant.SOCIAL_TICK}" <c:if test="${Constant.SOCIAL_TICK eq searchVO.sCorpSubCd}">selected</c:if>>관광지/레저</option>
       											<option value="${Constant.SOCIAL_FOOD}" <c:if test="${Constant.SOCIAL_FOOD eq searchVO.sCorpSubCd}">selected</c:if>>음식/뷰티</option>
       										</select>
       										<select name="sDisplayYn" id="sDisplayYn">
	        									<option value="">노출여부</option>
	        									<option value="${Constant.FLAG_Y}" <c:if test="${searchVO.sDisplayYn eq Constant.FLAG_Y}">selected="selected"</c:if>>노출</option>
	        									<option value="${Constant.FLAG_N}" <c:if test="${searchVO.sDisplayYn eq Constant.FLAG_N}">selected="selected"</c:if>>비노출</option>
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
               	 <p class="search_list_ps title-btn">[총 <strong><fmt:formatNumber value="${totalCnt}" type="number" /></strong>건]
               	 <span class="side-wrap">
<%--               	 	[기간만료예정 상품 총 <strong><fmt:formatNumber value="${exprCnt}" type="number" /></strong>건]--%>
               		<c:if test="${exprCnt > 0}">
               		 	<a class="btn_sty04" href="javascript:fn_goExprPrdtList('expr');">판매기간만료 예정상품 보기(2주)</a>
               	 	</c:if>
               		<c:if test="${exprCnt eq 0}">
						<a class="btn_sty02" href="#">판매기간만료 예정상품 없음</a>
					</c:if>

               		<c:if test="${exprEndYn > 0}">
						<a class="btn_sty04" href="javascript:fn_goExprPrdtList('exprEnd');">유효기간만료 예정상품 보기(1달)</a>
					</c:if>
					 <c:if test="${exprEndYn eq 0}">
						 <a class="btn_sty02" href="#">유효기간만료 예정상품 없음</a>
					 </c:if>
               	 </span>
               	 </p>
				 <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">										
					<thead>
						<tr>
							<th width="75">번호</th>
							<th>상품번호</th>
							<th>상태</th>
							<th>형태</th>
							<th>업체명</th>							
							<th>상품명</th>
							<th>판매기간</th>
							<th>요청일</th>
							<th>승인일</th>
							<th width="210">기능틀</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="10" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="spPrdtInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct"><c:out value="${spPrdtInfo.prdtNum}"/></td>
								<td class="align_ct">
									<c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInfo.tradeStatus}">
										등록중
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq spPrdtInfo.tradeStatus}">
										승인요청
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInfo.tradeStatus}">
										승인
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq spPrdtInfo.tradeStatus}">
										승인거절
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInfo.tradeStatus}">
										판매중지
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_EDIT eq spPrdtInfo.tradeStatus}">
										수정요청
									</c:if>
									<c:if test="${Constant.TRADE_STATUS_STOP_REQ eq spPrdtInfo.tradeStatus}">
										판매중지 요청
									</c:if>
								</td>
								<td class="align_ct">
									<c:if test="${Constant.SP_PRDT_DIV_TOUR eq spPrdtInfo.prdtDiv}">
									여행상품
									</c:if>
									<c:if test="${Constant.SP_PRDT_DIV_COUP eq spPrdtInfo.prdtDiv}">
									쿠폰상품
									</c:if>
									<c:if test="${Constant.SP_PRDT_DIV_FREE eq spPrdtInfo.prdtDiv}">
									무료쿠폰
									</c:if>
									<c:if test="${Constant.SP_PRDT_DIV_SHOP eq spPrdtInfo.prdtDiv}">
									쇼핑상품
									</c:if>
								</td>
								<td class="align_ct"><a href="javascript:fn_layerDetailCorp('${spPrdtInfo.corpId}');"><c:out value="${spPrdtInfo.corpNm}" /></a></td>
								<td class="align_ct"><c:out value="${spPrdtInfo.prdtNm}" /></td>
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.saleStartDt}" var="saleStartDt" pattern="yyyyMMdd"/>
									<fmt:parseDate value="${spPrdtInfo.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd"/>
									<fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.confRequestDttm}" var="confRequestDttm" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${confRequestDttm}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<fmt:parseDate value="${spPrdtInfo.confDttm}" var="confDttm" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${confDttm}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="align_ct">
									<div class="btn_sty08"><span><a href="<c:url value='/oss/preview/spDetailProduct.do?prdtNum=${spPrdtInfo.prdtNum}&prdtDiv=${spPrdtInfo.prdtDiv}'/>" target="_blank">상세보기</a></span></div>
									<div class="btn_sty06"><span><a href="javascript:fn_viewProductAppr('${spPrdtInfo.prdtNum}');">승인관리</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_LoginMas('${spPrdtInfo.corpId}');">업체페이지</a></span></div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_rt01">
					<li class="btn_sty02">
						<a href="javascript:fn_SaveExcel()">엑셀저장</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_ProductAppr" class="lay_popup lay_ct"  style="display:none;">
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>