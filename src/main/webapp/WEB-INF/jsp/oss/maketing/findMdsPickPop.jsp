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
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/mdsPickListFind.do'/>";
	document.frm.target = "findUser";
	window.name = "findUser";
	document.frm.submit();
}

function fn_SelectUser(rcmdNum, corpNm, subject){
	window.opener.fn_SelectMd(rcmdNum, corpNm, subject);
	parent.window.close();
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
            <div class="search_form" style="width:390px; padding-left:50px;">
                <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다.">
                    <caption>
                    검색조건
                    </caption>
                    <tbody>
                        <tr>
                            <td style="width:auto;">
                            	<select id="prdtNum" name="prdtNum">
                                    <option value="subject" <c:if test="${searchVO.prdtNum eq 'subject'}">selected</c:if>>제목</option>
                                    <option value="corpNm" <c:if test="${searchVO.prdtNum eq 'corpNm'}">selected</c:if> >업체명</option>
                                </select>
                            </td>
                            <td style="width:auto;"><input type="text" name="prdtNm" id="prdtNm" class="input_text20" value="${searchVO.prdtNm}" /></td>
                        </tr>
                    </tbody>
                </table>
                <span class="search_btn">
                <input type="image" name="" src="<c:url value='/images/oss/btn/search_btn04.gif'/>" alt="검색" onclick="fn_Search(1)" />
                </span> 
            </div>
        </div>
        <!--//검색폼-->
        
        	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<input name="sUserId" id="sUserId" type="hidden" />
        	<input name="sUserNm" id="sUserNm" type="hidden" />
        	
        <div style="padding-bottom:35px;">
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
			                        <col width="150" />
			                        <col width="350" />
			                        <col width="50" />
			                    </colgroup>
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">업체명</th>
                                    <th scope="col">Md's Pick 제목</th>
                                    <th scope="col"> </th>
                                </tr>
                                <!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="4">
											<spring:message code="common.nodata.msg" />
										</td>
									</tr>
								</c:if>
								<c:forEach var="mds" items="${resultList}" varStatus="status">
								<tr>
                                    <td>${mds.rcmdNum}</td>
                                    <td><c:out value="${mds.corpNm}"/></td>
                                    <td><c:out value="${mds.subject}"/></td>                                    
                                    <td>
                               			<div class="btn_sty06"><span><a href="javascript:fn_SelectUser('${mds.rcmdNum}', '${mds.corpNm}', '${mds.subject}');">추가</a></span></div>
                                    </td>
                                </tr>
								</c:forEach>
                            </table></div></td>
                    </tr>
                </tbody>
            </table>
            <p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			</p>
			
			<ul class="btn_rt01">
				<li class="btn_sty01">
					<a href="javascript:parent.window.close()">닫기</a>
				</li>
			</ul>
			
			<div style="clear: both;"></div>
        </div>
        </form>
	</div>		
</body>
</html>