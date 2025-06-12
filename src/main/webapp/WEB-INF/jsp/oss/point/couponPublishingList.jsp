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
    <script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

    <title></title>
</head>
<body>
<div id="wrapper">
    <jsp:include page="/oss/head.do?menu=product" />
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=product&sub=point" />
        <div id="contents_area">
            <form name="frm" id="frm" method="post">
                <input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
                <input type="hidden" id="partnerCode" name="partnerCode" value="${partnerCode}" />

                <div id="contents">

                    <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
                    <div class="list">
                        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                            <thead>
                            <tr>
                                <th width="100">그룹코드</th>
                                <th>쿠폰코드</th>
                                <th width="180">포인트</th>
                                <th width="180">쿠폰발급일</th>
                                <th width="180">쿠폰등록ID</th>
                                <th width="180">쿠폰등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 없음 -->
                            <c:if test="${fn:length(cpPublishingList) == 0}">
                                <tr>
                                    <td colspan="6" class="align_ct">
                                        <spring:message code="common.nodata.msg" />
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="cpListInfo" items="${cpPublishingList}" varStatus="status">
                                <tr>
                                    <td class="align_ct">${cpListInfo.groupCode}</td>
                                    <td class="align_ct">${cpListInfo.cpNum}</td>
                                    <td class="align_ct">${cpListInfo.cpPoint}</td>
                                    <td class="align_ct">${cpListInfo.cpRegDttm}</td>
                                    <td class="align_ct">${cpListInfo.userId}</td>
                                    <td class="align_ct">${cpListInfo.useRegDttm}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>
                    <ul class="btn_rt01">
                        <li class="btn_sty04"><a href="javascript:void(0)" onclick="javascript:fn_GoCpList();">이전</a></li>
                        <li class="btn_sty03"><a href="javascript:void(0)" onclick="javascript:fn_SelfPublishing('${partnerCode}');">자체발급</a></li>
                    </ul>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="blackBg"></div>
<div id="selfPublishingPop" class="lay_popup lay_ct"  style="display:none;"></div>

<script type="text/javascript">
    function fn_SelfPublishing(partnerCode) {
        if(!partnerCode){
            alert('오류! 자체발급코드가 없습니다.');
            return;
        }

        $.ajax({
            type:"post",
            url:"<c:url value='/oss/point/selfPublishing.ajax'/>",
            data:"partnerCode=" + partnerCode,
            success:function(data){
                $("#selfPublishingPop").html(data);
                show_popup($("#selfPublishingPop"));
            },
            error : fn_AjaxError
        });
    }

    function fn_Search(pageIndex){
        $("#pageIndex").val(pageIndex);
        $("#frm").attr("action","/oss/point/couponPublishingList.do").submit();
    }

    function fn_GoCpList(){
        $("#frm").attr("action","/oss/point/couponList.do").submit();
    }

</script>

</body>
</html>