<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/findPrmt.do'/>";
	document.frm.target = "findUser";
	window.name = "findUser";
	document.frm.submit();
}

function fn_SelectUser(prmtNum, prmtNm){
	window.opener.fn_Select(prmtNum, prmtNm);
	parent.window.close();
}
</script>
</head>

<body>
<div id="popup_wrapper"> 
    <div id="popup_contents"> 
        <!--컨텐츠-->
        <form name="frm" method="post" onSubmit="return false;">
            <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
            <input type="hidden" name="sUserId" id="sUserId" />
            <input type="hidden" name="sUserNm" id="sUserNm" />
            <input type="hidden" name="prmtDiv" value="${searchVO.prmtDiv}"/>
            <!--검색폼-->
            <div class="search_area">
                <div class="search_form" style="width:410px; padding-left:50px;">
                    <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다.">
                        <caption>검색조건</caption>
                        <tbody>
                            <tr>
                                <td style="width:auto;">
                                    <select id="sKeyOpt" name="sKeyOpt">
                                        <option value="1" <c:if test="${searchVO.sKeyOpt == '1'}">selected="selected"</c:if> >프로모션명</option>
                                        <option value="2" <c:if test="${searchVO.sKeyOpt == '2'}">selected="selected"</c:if> >업체명</option>
                                    </select>
                                </td>
                                <td style="width:auto;">
                                    <input type="text" name="sKey" id="sKey" class="input_text20" value="${searchVO.sKey}" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <span class="search_btn"><input type="image" src="/images/oss/btn/search_btn04.gif" alt="검색" onclick="fn_Search(1)" /></span>
                </div>
            </div>
            <!--//검색폼-->
            <div style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <td valign="top"><h2 class="title02">검색결과</h2></td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top" width="43%" style="text-align:center;">
                                <div style="height:400px; overflow:auto;">
                                    <table width="100%" border="1" class="table01 list_tb">
                                        <colgroup>
                                            <col width="100" />
                                            <col width="200" />
                                            <col width="100" />
                                            <col width="150" />
                                            <col width="50" />
                                        </colgroup>
                                        <tr>
                                            <th scope="col">번호</th>
                                            <th scope="col">프로모션명</th>
                                            <th scope="col">업체명</th>
                                            <th scope="col">적용기간</th>
                                            <th scope="col"></th>
                                        </tr>
                                        <!-- 데이터 없음 -->
                                        <c:if test="${fn:length(resultList) == 0}">
                                            <tr>
                                                <td colspan="5">
                                                    <spring:message code="common.nodata.msg" />
                                                </td>
                                            </tr>
                                        </c:if>

                                        <c:forEach var="prmt" items="${resultList}" varStatus="status">
                                            <tr>
                                                <td>${prmt.prmtNum}</td>
                                                <td><c:out value="${prmt.prmtNm}"/></td>
                                                <td><c:out value="${prmt.corpNm}"/></td>
                                                <td>
                                                    <fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
                                                    <fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
                                                    <fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
                                                </td>
                                                <td>
                                                    <div class="btn_sty06"><span><a href="javascript:fn_SelectUser('${prmt.prmtNum}', '${prmt.prmtNm}');">추가</a></span></div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>

                <ul class="btn_rt01">
                    <li class="btn_sty01"><a href="javascript:parent.window.close()">닫기</a></li>
                </ul>

                <div style="clear: both;"></div>
            </div>
        </form>
	</div>
</div>
</body>
</html>