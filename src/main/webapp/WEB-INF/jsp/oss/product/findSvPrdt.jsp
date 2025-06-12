<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
// 조회 & 페이징
function fn_Search(pageIndex) {

	/*if($("#sOption option:selected").val() == "prdt") {
		$("#sPrdtNm").val($("#sInput").val());
		$("#sCorpNm").val("");
	} else {
		$("#sPrdtNm").val("");
		$("#sCorpNm").val($("#sInput").val());
	}
	$("#sSubCtgr").val($("#subCtgr").val());
	$("#sTradeStatus").val($("#tradeStatus").val());*/

	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/findSvPrdt.do'/>";
	document.frm.target = "findPrdt";
	window.name = "findPrdt";
	document.frm.submit();
}

function fn_Select(prdtId, corpNm, prdtNm, corpId) {
	window.opener.fn_selectProduct(prdtId, corpNm, prdtNm, corpId);
}

</script>

</head>
<body>
<div id="popup_wrapper">
    <div id="popup_contents">
        <!--컨텐츠-->

        <form name="frm" method="post" onSubmit="return false;">
            <div class="search_area">
                <div class="search_form" style="width:395px; padding-left:50px;">
                    <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다.">
                        <caption>
                        검색조건
                        </caption>
                        <tbody>
                            <tr>
                                <%--<c:choose>
                                    <c:when test="${!(empty searchVO.sPrdtNm)}">
                                        <c:set value="${searchVO.sPrdtNm}" var="sInput"/>
                                        <c:set value="1" var="sOption"/>
                                    </c:when>
                                    <c:when test="${!(empty searchVO.sCorpNm)}">
                                        <c:set value="${searchVO.sCorpNm}" var="sInput"/>
                                        <c:set value="2" var="sOption"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set value="" var="sInput"/>
                                        <c:set value="" var="sOption"/>
                                    </c:otherwise>
                                </c:choose>--%>
                                <td style="width:auto;">
                                    업체명
                                </td>
                                <td style="width:auto;"><input type="text" name="sCorpNm" id="sCorpNm" class="input_text20" value="${searchVO.sCorpNm}" /></td>
                            </tr>
                            <tr>
                                <td style="width:auto;">
                                    상품명
                                </td>
                                <td style="width:auto;"><input type="text" name="sPrdtNm" id="sPrdtNm" class="input_text20" value="${searchVO.sPrdtNm}" /></td>
                            </tr>
                        </tbody>
                    </table>
                    <span class="search_btn">
                        <input type="image" name="" src="<c:url value='/images/oss/btn/search_btn04.gif'/>" alt="검색" onclick="fn_Search(1);" />
                    </span>
                </div>
            </div>
            <!--//검색폼-->
        	<input type="hidden" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<%--<input type="hidden" name="sPrdtNm" id="sPrdtNm" />
        	<input type="hidden" name="sCorpNm" id="sCorpNm" />--%>
        	<input type="hidden" name="sSubCtgr" id="sSubCtgr" />
        	<input type="hidden" name="sTradeStatus" id="sTradeStatus" />
            <div style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <td valign="top"><h2 class="title02">검색결과</h2></td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top" width="43%" style="background-color:#f9f9f9; border:solid 1px #ccc; text-align:center;">
                                <div style="height:400px; overflow:auto;">
                                    <table width="100%" border="1" class="table01 list_tb">
                                        <colgroup>
                                            <col width="100" />
                                            <col width="60" />
                                            <col width="200" />
                                            <col width="200" />
                                            <col width="60" />
                                            <col width="50" />
                                        </colgroup>
                                        <tr>
                                            <th scope="col">상품번호</th>
                                            <th scope="col">상태</th>
                                            <th scope="col">업체명</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">구분</th>
                                            <th scope="col"> </th>
                                        </tr>
                                        <!-- 데이터 없음 -->
                                        <c:if test="${fn:length(resultList) == 0}">
                                        <tr>
                                            <td colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        </tr>
                                        </c:if>
                                        <c:forEach var="data" items="${resultList}" varStatus="status">
                                        <tr>
                                            <td>${data.prdtNum}</td>
                                            <td>
                                                <c:if test="${data.tradeStatus eq Constant.TRADE_STATUS_REG}">등록중</c:if>
                                                <c:if test="${data.tradeStatus eq Constant.TRADE_STATUS_APPR_REQ}">승인요청</c:if>
                                                <c:if test="${data.tradeStatus eq Constant.TRADE_STATUS_APPR}">승인</c:if>
                                                <c:if test="${data.tradeStatus eq Constant.TRADE_STATUS_APPR_REJECT}">승인거절</c:if>
                                                <c:if test="${data.tradeStatus eq Constant.TRADE_STATUS_STOP}">판매중지</c:if>
                                                <c:if test="${data.tradeStatus eq Constant.TRADE_STATUS_EDIT}">수정요청</c:if>
                                            </td>
                                            <td>${data.corpNm}</td>
                                            <td>${data.prdtNm}</td>
                                            <td>
                                                <c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">여행상품</c:if>
                                                <c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">쿠폰상품</c:if>
                                                <c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">무료쿠폰</c:if>
                                                <c:if test="${data.prdtDiv eq Constant.SP_PRDT_DIV_SHOP}">쇼핑상품</c:if>
                                            </td>
                                            <td>
                                                <div class="btn_sty06">
                                                    <span><a href="#" onclick="javascript:fn_Select('${data.prdtNum}', '${data.corpNm}', '${data.prdtNm}', '${data.corpId}');">추가</a></span>
                                                </div>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="list_pageing">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
                </p>
                <ul class="btn_rt01">
                    <li class="btn_sty01">
                        <a href="#" onclick="javascript:window.close();">닫기</a>
                    </li>
                </ul>
                <div style="clear: both;"></div>
            </div>
        </form>
    </div>
</div>
</body>
</html>