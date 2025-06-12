<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/mas/sp/productList.do'/>";
		document.frm.submit();
	}

	/**
	 * 상품 정보 상세보기
	 */
	function fn_detailSocial(prdtNum) {
		document.frm.prdtNum.value = prdtNum;
		document.frm.action = "<c:url value='/mas/sp/detailSocial.do'/>";
		document.frm.submit();
	}

	/**
	 * 상품 수정 화면 가기
	 */
	function fn_UdtSocial(prdtNum) {
		document.frm.prdtNum.value = prdtNum;
		document.frm.action = "<c:url value='/mas/sp/viewUpdateSocial.do'/>";
		document.frm.submit();
	}

	/**
	 * 상품 삭제하기
	 */
	function fn_DelSocial(prdtNum) {
		$.ajax({
			url : "<c:url value='/mas/sp/checkExsistPrdt.ajax'/>",
			dataType:"json",
			data : "sPrdtNum=" + prdtNum,
			success: function(data) {
				if(data.chkInt > 0){
					alert("판매되었던 상품은 삭제할 수 없습니다.");
					return;
				}else{
					if(confirm("<spring:message code='common.delete.msg'/>")) {
						document.frm.prdtNum.value = prdtNum;
						document.frm.action = "<c:url value='/mas/sp/deleteSocial.do'/>";
						document.frm.submit();
					}
				}
			},
			error : function(request, status, error) {
				fn_AjaxError(request, status, error);
			}
		});
	}

	/**
	 * 상품 등록 화면 가기
	 */
	function fn_insertProduct() {
		document.frm.action = "<c:url value='/mas/sp/viewInsertSocial.do'/>";
		document.frm.submit();
	}

	/**
	 * 상품 승인취소
	 */
	function fn_approvalCancelSocial(prdtNum) {
		$.ajax({
			url : "<c:url value='/mas/sp/approvalCancelSocial.ajax'/>",
			data : "prdtNum=" + prdtNum,
			dataType:"json",
			success: function(data) {
				fn_Search(document.frm.pageIndex.value);
			},
			error : fn_AjaxError
		})
	}

	/**
	 * 상품 판매중지
	 */
	function fn_SaleStopSocial(prdtNum) {
		$.ajax({
			url : "<c:url value='/mas/sp/saleStopSocial.ajax'/>",
			data : "prdtNum=" + prdtNum,
			dataType:"json",
			success: function(data) {
				fn_Search(document.frm.pageIndex.value);
			},
			error : fn_AjaxError
		})
	}

	/**
	 * 상품 판매전환
	 */
	function fn_SaleStartSocial(prdtNum) {
		$.ajax({
			url : "<c:url value='/mas/sp/saleStartSocial.ajax'/>",
			data : "prdtNum=" + prdtNum,
			dataType:"json",
			success: function(data) {
				fn_Search(document.frm.pageIndex.value);
			},
			error : fn_AjaxError
		})
	}
	
	/**
	 * 상품 복제하기
	 */
	function fn_copyProduct(prdtNum) {
		if (window.confirm("해당 상품을 복제하시겠습니까?")) {
			document.frm.prdtNum.value = prdtNum;
			document.frm.action = "<c:url value='/mas/sp/copyProduct.do'/>";
			document.frm.submit();
		}
	}
	
	//마라톤 관리
	function fn_mrtnProduct(corpId, prdtNum) {
		var url = "/mas/sp/mrtnUserList.do"+"?corpId=" + corpId +"&prdtNum="+prdtNum;
		var mrtnPopup = window.open("<c:url value='"+url+"'/>", "mrtnUser", "width=1700, height=700, scrollbars=yes, status=no, toolbar=no;");
	}
	
	function fn_goPreview(prdtNum, prdtDiv, optCnt) {
		
		if(optCnt == 0 && prdtDiv != "${Constant.SP_PRDT_DIV_FREE}") {
			alert(" 옵션을 등록해 주세요.");
			return ;
		}		
		window.open("<c:url value='/mas/preview/spDetailProduct.do?prdtNum="+prdtNum +"&prdtDiv=" +prdtDiv + "'/> ", "_blank"); 
	}

	$(function() {
		$("#sSaleStartDt").datepicker({
			onClose : function(selectedDate) {
				$("#sSaleEndDt").datepicker("option", "minDate", selectedDate);
			}
		});
		$("#sSaleEndDt").datepicker({
			onClose : function(selectedDate) {
				$("#sSaleStartDt").datepicker("option", "maxDate",selectedDate);
			}
		});
	});
</script>

</head>
<body>
	<div id="wrapper">
		<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
		<!--Contents 영역-->
		<div id="contents_wrapper">
			<div id="contents_area">
				<form name="frm" method="get" onSubmit="return false;">
					<input type="hidden" id="prdtNum" name="prdtNum" /> 
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />
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
		       								<%-- <tr>
		       									<th scope="row">차량구분</th>
		          								<td colspan="3">
		          									<select name="sCarDivCd" id="sCarDivCd">
		          										<option value="">전체</option>
		          										<c:forEach items="${carDivCd}" var="carDiv" varStatus="status">
		          											<option value="${carDiv.cdNum}" <c:if test="${searchVO.sCarDivCd eq carDiv.cdNum}">selected="selected"</c:if>>${carDiv.cdNm}</option>
		          										</c:forEach>
		          									</select>
		          								</td>
		       								</tr> --%>
		       							</tbody>
		                 			</table>
		                 		</div>
								<span class="btn">
									<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
								</span>
		                    </div>
		                </div>
						<p class="search_list_ps">상품 목록 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
						 <div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="table01 list_tb">
							<thead>
								<tr>
									<th>상품번호</th>
									<th>상품명</th>
									<th>카테고리</th>
									<th>형태</th>
									<th>판매기간</th>
									<th>거래상태</th>
									<th>등록일</th>
									<th>수정일자</th>
									<th>관리자툴</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="9" class="align_ct"><spring:message
												code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="spPrdtInfo" items="${resultList}"	varStatus="status">
									<tr style="cursor: pointer;">
										<td class="align_ct"><c:out value="${spPrdtInfo.prdtNum}" /></td>
										<td><c:out value="${spPrdtInfo.prdtNm}"/></td>
										<td class="align_ct"><c:out value="${spPrdtInfo.ctgrNm}" /></td>
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
										</td>
										<td class="align_ct"><fmt:parseDate value="${spPrdtInfo.saleStartDt}" var="saleStartDt"	pattern="yyyyMMdd" />
											<fmt:parseDate value="${spPrdtInfo.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd" /> <fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd" />~<c:if test="${spPrdtInfo.saleEndDt ne '99990101'}"><fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd" /></c:if></td>
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
												판매중지요청
											</c:if>
										</td>
										<td class="align_ct"><fmt:parseDate value="${spPrdtInfo.frstRegDttm}" var="frstRegDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd" /></td>
										<td class="align_ct"><fmt:parseDate value="${spPrdtInfo.lastModDttm}" var="lastModDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${lastModDttm}" pattern="yyyy-MM-dd" /></td>											
										<td class="align_ct">
												<div class="btn_sty06"><span><a href="javascript:fn_UdtSocial('${spPrdtInfo.prdtNum}')">수정</a></span></div>
											<c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInfo.tradeStatus || Constant.TRADE_STATUS_EDIT eq spPrdtInfo.tradeStatus}">
												<%-- <div class="btn_sty06"><span><a href="javascript:fn_UdtSocial('${spPrdtInfo.prdtNum}')">수정</a></span></div>--%>
												<div class="btn_sty09"><span><a href="javascript:fn_DelSocial('${spPrdtInfo.prdtNum}')">삭제</a></span></div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq spPrdtInfo.tradeStatus }">
												<%-- <div class="btn_sty06"><span><a href="javascript:fn_UdtSocial('${spPrdtInfo.prdtNum}')">수정</a></span></div> --%>
												<div class="btn_sty06"><span><a href="javascript:fn_approvalCancelSocial('${spPrdtInfo.prdtNum}')">요청취소</a></span></div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInfo.tradeStatus }">
												<%--<div class="btn_sty06"><span><a href="javascript:fn_detailSocial('${spPrdtInfo.prdtNum}')">상세</a></span></div> --%>
												<div class="btn_sty06">
													<%-- <span><a href="javascript:fn_SaleStopSocial('${spPrdtInfo.prdtNum}')">판매중지</a></span> --%>
													<span><a href="javascript:fn_copyProduct('${spPrdtInfo.prdtNum}');">복제</a></span>
												</div>
											</c:if>
											<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInfo.tradeStatus || Constant.TRADE_STATUS_APPR_REJECT eq spPrdtInfo.tradeStatus}">
												<%--<div class="btn_sty06"><span><a href="javascript:fn_detailSocial('${spPrdtInfo.prdtNum}')">상세</a></span></div> --%>
												<div class="btn_sty06">
													<%-- <span><a href="javascript:fn_SaleStartSocial('${spPrdtInfo.prdtNum}')">판매전환</a></span> --%>
													<span><a href="javascript:fn_copyProduct('${spPrdtInfo.prdtNum}');">복제</a></span>
												</div>
											</c:if>
											<c:if test="${fn:substring(spPrdtInfo.corpId, 0, 4) eq 'CSPM'}">
												<%--<div class="btn_sty06"><span><a href="javascript:fn_detailSocial('${spPrdtInfo.prdtNum}')">상세</a></span></div> --%>
												<div class="btn_sty06">
													<%-- <span><a href="javascript:fn_SaleStartSocial('${spPrdtInfo.prdtNum}')">판매전환</a></span> --%>
													<span><a href="javascript:fn_mrtnProduct('${spPrdtInfo.corpId}', '${spPrdtInfo.prdtNum}');">마라톤관리</a></span>
												</div>
											</c:if>
											<div class="btn_sty06"><span><a href="javascript:fn_goPreview('${spPrdtInfo.prdtNum}','${spPrdtInfo.prdtDiv}', '${spPrdtInfo.optCnt}')">미리보기</a></span></div>
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
							<li class="btn_sty04"><a
								href="javascript:fn_insertProduct()">등록</a></li>
						</ul>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>