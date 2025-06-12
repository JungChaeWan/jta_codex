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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	if($("#sOption option:selected").val() == "name"){
		$("#sUserNm").val($("#sInput").val());
		$("#sUserId").val("");
	}else{
		$("#sUserNm").val("");
		$("#sUserId").val($("#sInput").val());
	}
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/findUser.do'/>";
	document.frm.target = "findUser";
	window.name = "findUser";
	document.frm.submit();
}

function fn_SelectUser(userId, userNm, telNum){
	window.opener.fn_SelectUer(userId, userNm, telNum);
	// parent.window.fn_SelectUer(userId);
	parent.window.close();
}
</script>
</head>
<body>
<div id="popup_wrapper">
    <div id="popup_contents">
        <!--검색폼-->
         <form name="frm" method="post" onSubmit="return false;">
        	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<input name="sUserId" id="sUserId" type="hidden" value=""/>
        	<input name="sUserNm" id="sUserNm" type="hidden" value=""/>
	        <div class="search_area">
				<div class="search_form" style="width:395px; padding-left:50px;">
	                <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다.">
	                    <caption>
	                    검색조건
	                    </caption>
	                    <tbody>
	                        <tr>
	                            <td style="width:auto;">
	                            	<select id="sOption" name="sOption">
	                                    <option <c:if test="${searchVO.sOption eq 'name'}">selected="selected"</c:if> value="name">이름</option>
	                                    <option <c:if test="${searchVO.sOption eq 'id'}">selected="selected"</c:if> value="id">아이디</option>
	                                </select>
	                            </td>
	                            <td style="width:auto;"><input type="text" name="sInput" id="sInput" value="${searchVO.sUserNm eq '' ? searchVO.sUserId : searchVO.sUserNm}" class="input_text20" /></td>
	                        </tr>
	                    </tbody>
	                </table>
	                <span class="search_btn">
	                <input type="image" name="" src="<c:url value='/images/oss/btn/search_btn04.gif'/>" alt="검색" onclick="fn_Search(1)" />
	                </span> 
				</div>
	        </div>
        </form>
        <!--//검색폼-->
       
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
				                        <col width="200" />
				                        <col width="*" />
				                        <col width="200" />
				                    </colgroup>
	                                <tr>
	                                    <th scope="col">사용자명</th>
	                                    <th scope="col">사용자아이디</th>
	                                    <th scope="col">이메일</th>
	                                </tr>
	                                <!-- 데이터 없음 -->
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="3">
												<spring:message code="common.nodata.msg" />
											</td>
										</tr>
									</c:if>
									<c:forEach var="userInfo" items="${resultList}" varStatus="status">
									<tr style="cursor:pointer;" onclick="fn_SelectUser('${userInfo.userId}', '${userInfo.userNm}', '${userInfo.telNum}')">
	                                    <td>${userInfo.userNm}</td>
	                                    <td>${userInfo.userId}</td>
	                                    <td>${userInfo.email}</td>
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
        </div>
	</div>
</body>
</html>