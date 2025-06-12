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
	if($("#sOption option:selected").val() == "name") {
		$("#sUserNm").val($("#sInput").val());
		$("#sUserId").val("");
	} else {
		$("#sUserNm").val("");
		$("#sUserId").val($("#sInput").val());
	}
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/findUserSMSMail.do'/>";
	document.frm.target = "findUser";
	window.name = "findUser";
	document.frm.submit();
}

function fn_SelectUser(userId, userNm, tel, mail) {
	window.opener.fn_SelectUer(userId, userNm, tel, mail);
}
</script>

</head>
<body>
<div id="popup_wrapper"> 
    <div id="popup_contents"> 
        <!--컨텐츠--> 
        <!--검색폼-->
        <div class="search_area">
            <div class="search_form" style="width:395px; padding-left:50px;">
                <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다.">
                    <caption>검색조건</caption>
                    <tbody>
                        <tr>
                            <td style="width:auto;">
                            	<select id="sOption" name="sOption">
                                    <option value="name" <c:if test="${not empty searchVO.sUserNm}">selected</c:if>>이름</option>
                                    <option value="id" <c:if test="${not empty searchVO.sUserId}">selected</c:if>>아이디</option>
                                </select>
                            </td>
                            <c:if test="${not empty searchVO.sUserNm}">
                                <c:set var="keyword" value="${searchVO.sUserNm}"/>
                            </c:if>
                            <c:if test="${not empty searchVO.sUserId}">
                                <c:set var="keyword" value="${searchVO.sUserId}"/>
                            </c:if>
                            <td style="width:auto;"><input type="text" name="sInput" id="sInput" class="input_text20" value="${keyword}" /></td>
                        </tr>
                    </tbody>
                </table>
                <span class="search_btn">
                    <input type="image" name="" src="<c:url value='/images/oss/btn/search_btn04.gif'/>" alt="검색" onclick="fn_Search(1);" />
                </span>
            </div>
        </div>
        <!--//검색폼-->
        <form name="frm" method="post" onSubmit="return false;">
        	<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<input type="hidden" name="sUserId" id="sUserId" />
        	<input type="hidden" name="sUserNm" id="sUserNm" />
        	<input type="hidden" name="type" id="type" value="${type}"/>

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
                                            <col width="110" />
                                            <col width="110" />
                                            <col width="" />
                                            <col width="120" />
                                            <%--<col width="60" />--%>
                                            <col width="50" />
                                        </colgroup>
                                        <tr>
                                            <th scope="col">사용자명</th>
                                            <th scope="col">사용자아이디</th>
                                            <th scope="col">이메일</th>
                                            <th scope="col">전화번호</th>
                                            <%--<th scope="col">수신여부</th>--%>
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
                                                <td>${userInfo.userNm}</td>
                                                <td>${userInfo.userId}</td>
                                                <td>${userInfo.email}</td>
                                                <td>${userInfo.telNum}</td>
                                                <%--<td>
                                                    <c:if test="${fn:toLowerCase(type) == 'sms'}">${userInfo.smsRcvAgrYn}</c:if>
                                                    <c:if test="${fn:toLowerCase(type) != 'sms'}">${userInfo.emailRcvAgrYn}</c:if>
                                                </td>--%>
                                                <td>
                                                <c:if test="${fn:toLowerCase(type) == 'sms'}">
                                                    <%--<c:if test="${userInfo.smsRcvAgrYn == 'Y'}">--%>
                                                    <div class="btn_sty06">
                                                        <span><a href="javascript:void(0)" onclick="javascript:fn_SelectUser('${userInfo.userId}', '${userInfo.userNm}', '${userInfo.telNum}', '${userInfo.email}');">추가</a></span>
                                                    </div>
                                                    <%--</c:if>--%>
                                                </c:if>
                                                <c:if test="${fn:toLowerCase(type) != 'sms'}">
                                                    <%--<c:if test="${userInfo.emailRcvAgrYn == 'Y'}">--%>
                                                    <div class="btn_sty06">
                                                        <span><a href="javascript:void(0)" onclick="javascript:fn_SelectUser('${userInfo.userId}', '${userInfo.userNm}', '${userInfo.telNum}', '${userInfo.email}');">추가</a></span>
                                                    </div>
                                                    <%--</c:if>--%>
                                                </c:if>
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
                        <a href="javascript:void(0);" onclick="javascript:window.close();">닫기</a>
                    </li>
                </ul>
                <div style="clear: both;"></div>
            </div>
        </form>
    </div>
</div>
</body>
</html>