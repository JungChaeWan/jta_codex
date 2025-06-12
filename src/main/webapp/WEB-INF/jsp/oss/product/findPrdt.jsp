<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

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
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {

	/*if($("#sOption option:selected").val() == "prdt") {
		$("#sPrdtNm").val($("#sInput").val());
		$("#sCorpNm").val("");
	} else {
		$("#sPrdtNm").val("");
		$("#sCorpNm").val($("#sInput").val());
	}*/
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/findPrdt.do'/>";
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
            <!--검색폼-->
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


        	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<input name="sPrdtCd" type="hidden" value="<c:out value='${searchVO.sPrdtCd}'/>"/>
        	<input name="sAreaCd" type="hidden" value="<c:out value='${searchVO.sAreaCd}'/>"/>
        	<%--<input name="sPrdtNm" id="sPrdtNm" type="hidden" />--%>
        	<%--<input name="sCorpNm" id="sCorpNm" type="hidden" />--%>
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
                                            <col width="70" />
                                            <col width="180" />
                                            <col width="230" />
                                            <col width="50" />
                                        </colgroup>
                                        <tr>
                                            <th scope="col">상품번호</th>
                                            <th scope="col">상태</th>
                                            <c:if test="${searchVO.sPrdtCd ne Constant.ACCOMMODATION }">
                                            <th scope="col">업체명</th>
                                            </c:if>
                                            <c:if test="${searchVO.sPrdtCd eq Constant.ACCOMMODATION }">
                                            <th scope="col">숙소명</th>
                                            </c:if>
                                            <th scope="col">상품명</th>
                                            <th scope="col"> </th>
                                        </tr>
                                        <!-- 데이터 없음 -->
                                        <c:if test="${fn:length(resultList) == 0}">
                                        <tr>
                                            <td colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        </tr>
                                        </c:if>
                                        <c:forEach var="userInfo" items="${resultList}" varStatus="status">
                                        <tr>
                                            <td>${userInfo.prdtNum} </td>
                                            <td>${userInfo.tradeStatusNm}</td>
                                            <td>${userInfo.corpNm}</td>
                                            <td>${userInfo.prdtNm}</td>
                                            <td>
                                                <div class="btn_sty06"><span><a href="#" onclick="javascript:fn_Select('${userInfo.prdtNum}', '${fn:replace(userInfo.corpNm, "\"", "")}', '${userInfo.prdtNm}', '${userInfo.corpId}');">추가</a></span></div>
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