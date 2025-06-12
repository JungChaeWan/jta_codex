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
	document.frm.action = "<c:url value='/oss/findCorp.do'/>";
	document.frm.target = "업체검색";
	window.name = "업체검색";
	document.frm.submit();
}

function fn_SelectCorp(corpId, corpNm, corpCd, corpAliasNm){
	window.opener.fn_selectCorp(corpId, corpNm, corpCd, corpAliasNm);
	// parent.window.fn_SelectUer(userId);
	// parent.window.close();
	//window.close();
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
                <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다." class="pop-search">
                    <caption>
                    검색조건
                    </caption>
                    <colgroup>
                    	<col style="width: 20%">
                    	<col>
                    	<col style="width: 20%"> 
                    	<col>
                    </colgroup>
                    <tbody>
                    	<input type="hidden" name="sCorpCd" value="${searchVO.sCorpCd }" />
                    	<input type="hidden" name="sTradeStatusCd" value="${searchVO.sTradeStatusCd }" />                    	
                    	<input type="hidden" name="sSpCtgr" value="${searchVO.sSpCtgr }" />
                    	<tr>
                    		<th>업&nbsp;체&nbsp;명</th>
                    		<td colspan="3">
                    			<input type="text" id="sCorpNm" class="input_text_full" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." />
                    		</td>
                    	</tr>
                        <!-- <tr>
                            <td style="width:auto;">
                            	<select id="sOption" name="sOption">
                                    <option value="name">이름</option>
                                    <option value="id">아이디</option>
                                </select>
                            </td>
                            <td style="width:auto;"><input type="text" name="sInput" id="sInput" class="input_text20" /></td>
                        </tr> -->
                    </tbody>
                </table>
                <span class="search_btn">
                <input type="image" name="" src="<c:url value='/images/oss/btn/search_btn04.gif'/>" alt="검색" onclick="fn_Search(1)" />
                </span> </div>
        </div>
        <!--//검색폼-->
        	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<!-- <input name="sUserId" id="sUserId" type="hidden" />
        	<input name="sUserNm" id="sUserNm" type="hidden" /> -->
        <div style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <td valign="top"><h2 class="title02">검색결과</h2></td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="top" width="43%" style="border:solid 1px #ccc; text-align:center;">
                        	<div style="height:363px; overflow:auto;">
                        	<table width="100%" border="1" class="table01 list_tb">
                        		<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                        <col width="200" />
			                        <col width="70" />
			                    </colgroup>
                                <tr>
                                    <th scope="col">업체명</th>
                                    <th scope="col">업체아이디</th>
                                    <th scope="col">업체구분</th>
                                    <th scope="col"></th>
                                </tr>
                                <!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="3">
											<spring:message code="common.nodata.msg" />
										</td>
									</tr>
								</c:if>
								<c:forEach items="${resultList}" var="result" varStatus="status">
								<tr style="cursor:pointer;">
                                    <td>${result.corpNm}</td>
                                    <td>${result.corpId}</td>
                                    <td>
                                    	<c:if test="${result.corpCd eq Constant.ACCOMMODATION}">숙박</c:if>
										<c:if test="${result.corpCd eq Constant.RENTCAR}">렌트카</c:if>
										<c:if test="${result.corpCd eq Constant.SV}">툭산/기념품</c:if>
										<c:if test="${result.corpCd eq Constant.SOCIAL}">소셜상품</c:if>
                                    </td>
                                    <td>
                                        <div class="btn_sty06">
                                            <span><a href="#" onclick="javascript:fn_SelectCorp('${result.corpId}', '${result.corpNm}', '${result.corpCd}', '${result.corpAliasNm}');">추가</a></span>
                                        </div>
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
        </div>
        </form>
        <ul class="btn_rt01">
            <li class="btn_sty01">
                <a href="#" onclick="javascript:window.close();">닫기</a>
            </li>
        </ul>
		</div>		
</body>
</html>