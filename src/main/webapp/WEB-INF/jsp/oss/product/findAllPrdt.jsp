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
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/findAllPrdt.do'/>";
	document.frm.target = "findAllPrdt";
	window.name = "findAllPrdt";
	document.frm.submit();
}

function fn_Select(prdtId, corpNm, prdtNm, corpId) {
	window.opener.fn_selectProduct(prdtId, corpNm, prdtNm, corpId);
}

function fn_updateTamnacardPrdtYn(sCorpCd,sPrdtNum,sTamnacardPrdtYn){
    var parameters = {};
    parameters["sCorpCd"] = sCorpCd;
    parameters["sPrdtNum"] = sPrdtNum;
    parameters["sTamnacardPrdtYn"] = sTamnacardPrdtYn;
    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/oss/updateTamnacardPrdtYn.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.resultYn == "Y"){
                alert("정상적으로 적용되었습니다.");
            }else{
                alert("비정상적인 작동");
            }
        }
    });
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
        	<input name="sCorpId" type="hidden" value="<c:out value='${searchVO.sCorpId}'/>"/>
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
                                            <col width="90" />
                                            <col width="70" />
                                            <col width="180" />
                                            <col width="230" />
                                            <col width="130" />
                                        </colgroup>
                                        <tr>
                                            <th scope="col">상품번호</th>
                                            <th scope="col">상태</th>
                                            <th scope="col">업체명</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">탐나는전 적용여부</th>
                                        </tr>
                                        <!-- 데이터 없음 -->
                                        <c:if test="${fn:length(resultList) == 0}">
                                        <tr>
                                            <td colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        </tr>
                                        </c:if>
                                        <c:forEach var="corpInfo" items="${resultList}" varStatus="status">
                                        <tr>
                                            <td>${corpInfo.prdtNum}</td>
                                            <td>${corpInfo.tradeStatusNm}</td>
                                            <td>${corpInfo.corpNm}</td>
                                            <td>${corpInfo.prdtNm}</td>
                                            <td>
                                                Y <input type="radio" name="tamnacardMngYn${status.count}" value="Y" onclick="fn_updateTamnacardPrdtYn('${corpInfo.corpCd}','${corpInfo.prdtNum}','Y')" <c:if test="${corpInfo.tamnacardPrdtYn=='Y'}">checked</c:if>>
                                                N <input type="radio" name="tamnacardMngYn${status.count}" value="N" onclick="fn_updateTamnacardPrdtYn('${corpInfo.corpCd}','${corpInfo.prdtNum}','N')" <c:if test="${corpInfo.tamnacardPrdtYn=='N'}">checked</c:if>>
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