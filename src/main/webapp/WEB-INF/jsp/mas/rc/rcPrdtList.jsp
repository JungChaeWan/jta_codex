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
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
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
	document.frm.action = "<c:url value='/mas/rc/productList.do'/>";
	document.frm.submit();
}

function fn_InsPrdt(){
	document.frm.action = "<c:url value='/mas/rc/viewInsertPrdt.do'/>";
	document.frm.submit();
}

function fn_DtlPrdt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/rc/detailPrdt.do'/>";
	document.frm.submit();
}

function fn_PrdtImg(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/rc/imgList.do'/>";
	document.frm.submit();
}

function fn_AmtPrdt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/rc/amtList.do'/>";
	document.frm.submit();
}

function fn_DisPerPrdt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mas/rc/disPerList.do'/>";
	document.frm.submit();
}

function fn_DelPrdt(prdtNum){
	$.ajax({
		url : "<c:url value='/mas/rc/checkExsistPrdt.ajax'/>",
		dataType:"json",
		data : "sPrdtNum=" + prdtNum,
		success: function(data) {
			if(data.chkInt > 0){
				alert("판매되었던 상품은 삭제할 수 없습니다.");
				return;
			}else{
				if(confirm("<spring:message code='common.delete.msg'/>")){
					$("#prdtNum").val(prdtNum);
					document.frm.action = "<c:url value='/mas/rc/deletePrdt.do'/>";
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
 * 할인율 일괄관리 페이지
 */
function fn_viewDisPer(){
	document.frm.action = "<c:url value='/mas/rc/disPerPackList.do' />";
	document.frm.submit();
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" />
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
										<th scope="row">상품번호</th>
										<td><input type="text" id="sPrdtNum" class="input_text13" name="sPrdtNum" value="${searchVO.sPrdtNum}" title="검색하실 상품명를 입력하세요." /></td>
       								</tr>
									<tr>
       									<th scope="row">차종코드</th>
          								<td><input type="text" id="sRcCardivNum" class="input_text13" name="sRcCardivNum" value="${searchVO.sRcCardivNum}" title="검색하실 상품명를 입력하세요." /></td>
										<th scope="row">보험구분</th>
										<td>
											<select name="sIsrTypeDiv">
												<option value="">전체</option>
												<option value="ID00" <c:if test="${'ID00' eq searchVO.sIsrTypeDiv}">selected="selected"</c:if>>자차자율</option>
												<option value="LUXY" <c:if test="${'LUXY' eq searchVO.sIsrTypeDiv}">selected="selected"</c:if>>고급자차</option>
												<option value="GENL" <c:if test="${'GENL' eq searchVO.sIsrTypeDiv}">selected="selected"</c:if>>일반자차</option>
											</select>
										</td>
       								</tr>
       								<tr>
       									<th scope="row">차량구분</th>
          								<td>
          									<select name="sCarDivCd" id="sCarDivCd">
          										<option value="">전체</option>
          										<c:forEach items="${carDivCd}" var="carDiv" varStatus="status">
          											<option value="${carDiv.cdNum}" <c:if test="${searchVO.sCarDivCd eq carDiv.cdNum}">selected="selected"</c:if>>${carDiv.cdNm}</option>
          										</c:forEach>
          									</select>
          								</td>
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
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
                    </div>
                </div>
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
                <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
						<%--번호--%>
                        <col style="width: 2%;" />
						<%--상품번호--%>
                        <col style="width: 5%;" />
						<%--차종코드--%>
						<col style="width: 5%;" />
						<%--상품명--%>
                        <col style="width: auto;"/>
						<%--보험구분--%>
                        <col style="width: 100px;" />
						<%--거래상태--%>
                        <col style="width: 5%;" />
						<%--차량구분--%>
                        <col style="width: 5%;" />
						<%--사용연료--%>
                        <col style="width: 5%;" />
						<%--정원--%>
                        <col style="width: 2%;" />
						<%--연식--%>
                        <col style="width: 3%;" />
						<c:if test="${corpResult.corpLinkYn eq 'Y'}">
						<%--차량연계ID--%>
                        <col style="width: 5%;" />
						<%--보험연계ID--%>
                        <col style="width: 5%;" />
						</c:if>
						<c:if test="${corpResult.corpLinkYn ne 'Y'}">
						<%--수량만료일--%>
                        <col style="width: 90px;" />
						<%--할인기간만료일--%>
						<col style="width: 90px;" />
						</c:if>
						<%--관리툴--%>
						<c:if test="${corpResult.corpLinkYn ne 'Y'}">
							<col style="width: 300px;" />
						</c:if>
						<c:if test="${corpResult.corpLinkYn ne 'N'}">
							<col style="width: 200px;" />
						</c:if>
                    </colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>상품번호</th>
							<th>차종코드</th>
							<th>상품명</th>							
							<th>보험구분</th>
							<th>거래상태</th>
							<th>차량구분</th>
							<th>사용연료</th>
							<th>정원</th>
							<th>연식</th>
							<c:if test="${corpResult.corpLinkYn eq 'Y'}">
							<th>차량연계ID</th>
							<th>보험연계ID</th>
							</c:if>
							<c:if test="${corpResult.corpLinkYn ne 'Y'}">
							<th>수량만료일</th>
							<th>기간할인종료일</th>
							</c:if>
							<th>관리툴</th>
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
						<c:forEach var="prdtInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">${prdtInfo.prdtNum}</td>
								<td class="align_ct">${prdtInfo.rcCardivNum}</td>
								<td>${prdtInfo.prdtNm} /
								  <c:forEach var="code" items="${fuelCd}" varStatus="status">
										<c:if test="${prdtInfo.useFuelDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
									</c:forEach>
								  <%-- / ${prdtInfo.modelYear} --%>
								</td>
								<td class="align_ct">
									<%--<c:forEach var="code" items="${isrDivCd}" varStatus="status">
										<c:if test="${prdtInfo.isrDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
									</c:forEach>--%>
									<c:if test="${prdtInfo.isrDiv=='ID00'}">
										자차자율
									</c:if>
									<c:if test="${prdtInfo.isrDiv=='ID10'}">
										<c:if test="${prdtInfo.isrTypeDiv=='LUXY'}">
										고급자차
										</c:if>
										<c:if test="${prdtInfo.isrTypeDiv=='GENL'}">
										일반자차
										</c:if>
									</c:if>
								</td>			
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
								<td class="align_ct">${prdtInfo.modelYear}</td>
								<c:if test="${corpResult.corpLinkYn eq 'Y'}">
								<td class="align_ct">${prdtInfo.linkMappingNum}</td>
								<td class="align_ct">${prdtInfo.linkMappingIsrNum}</td>
								</c:if>

								<fmt:parseDate value='${prdtInfo.cntAplDt}' var='cntAplDt' pattern="yyyymmdd"/>
								<c:if test="${corpResult.corpLinkYn ne 'Y'}">
								<td class="align_ct"><fmt:formatDate value="${cntAplDt}" pattern="yyyy-mm-dd"/></td>
								<fmt:parseDate value='${prdtInfo.disperEndDt}' var='disperEndDt' pattern="yyyymmdd"/>
								<td class="align_ct"><fmt:formatDate value="${disperEndDt}" pattern="yyyy-mm-dd"/></td>
								</c:if>
								<td>
									<div class="btn_sty06"><span><a href="javascript:fn_DtlPrdt('${prdtInfo.prdtNum}')">상세</a></span></div>
									<c:if test="${corpResult.corpLinkYn ne 'Y'}">
									<div class="btn_sty06"><span><a href="javascript:fn_AmtPrdt('${prdtInfo.prdtNum}')">요금관리</a></span></div>
									<div class="btn_sty06"><span><a href="javascript:fn_DisPerPrdt('${prdtInfo.prdtNum}')">할인율관리</a></span></div>
									</c:if>
									<%-- <div class="btn_sty06"><span><a href="javascript:fn_PrdtImg('${prdtInfo.prdtNum}')">이미지관리</a></span></div> --%>
									<c:if test="${prdtInfo.tradeStatus==Constant.TRADE_STATUS_REG}">
										<div class="btn_sty09"><span><a href="javascript:fn_DelPrdt('${prdtInfo.prdtNum}')">삭제</a></span></div>
									</c:if>
									<div class="btn_sty06"><span><a href="<c:url value='/mas/rc/previewRcPrdt.do'/>?prdtNum=${prdtInfo.prdtNum}" target="_blank">미리보기</a></span></div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
				<ul class="btn_lt01">
					<li class="btn_sty04"><a href="javascript:fn_viewDisPer();">할인율일괄관리</a></li>
				</ul>
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_InsPrdt()">등록</a>
					</li>
				</ul>
			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>