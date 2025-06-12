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
            <form name="frm" id="frm" method="post" >
                <input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
                <input type="hidden" id="partnerCode" name="partnerCode" />
                <div id="contents">

                    <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
                    <div class="list">
                        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                            <thead>
                            <tr>
                                <th width="100">파트너코드</th>
                                <th width="150">파트너사 명칭</th>
                                <th>쿠폰명</th>
                                <th width="170">쿠폰사용기간</th>
                                <th width="170">예약가능일</th>
                                <th width="100">예산액</th>
                                <th width="100">발행금액</th>
                                <th width="100">등록금액</th>
<%--                                <th width="80">외부정산</th>--%>
                                <th width="80">업체제한</th>
                                <th width="80">업체포인트<br/>한도설정</th>
                                <th width="150">등록일</th>
                                <th width="220">기능툴</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 없음 -->
                            <c:if test="${fn:length(pointCpList) == 0}">
                            <tr>
                                <td colspan="11" class="align_ct">
                                    <spring:message code="common.nodata.msg" />
                                </td>
                            </tr>
                            </c:if>
                            <c:forEach var="cpInfo" items="${pointCpList}" varStatus="status">
                            <tr>
                                <td class="align_ct">${cpInfo.partnerCode}</td>
                                <td class="align_ct">${cpInfo.partnerNm}</td>
                                <td class="align_lt">${cpInfo.cpNm}</td>
                                <td class="align_ct">${cpInfo.aplStartDt} ~ ${cpInfo.aplEndDt}</td>
                                <td class="align_ct">${cpInfo.useStartDt} ~ ${cpInfo.useEndDt}</td>
                                <td class="align_ct"><fmt:formatNumber value="${cpInfo.partnerBudget}"></fmt:formatNumber></td>
                                <td class="align_ct"><fmt:formatNumber value="${cpInfo.cpCnt}"></fmt:formatNumber></td>
                                <td class="align_ct"><fmt:formatNumber value="${cpInfo.cpRegCnt}"></fmt:formatNumber></td>
<%--                                <td class="align_ct">${cpInfo.outsideSupportDiv}</td>--%>
                                <td class="align_ct">${cpInfo.corpFilterYn}</td>
                                <td class="align_ct">${cpInfo.corpPointLimitYn}</td>
                                <td class="align_ct">${cpInfo.regDttm}</td>
                                <td class="align_ct">
                                    <div class="btn_sty01">
                                        <a href="javascript:fn_GoAdmin('${cpInfo.partnerCode}');">관리자</a>
                                    </div>
                                    <div class="btn_sty04">
                                        <a href="javascript:fn_GoCpNum('${cpInfo.partnerCode}');">코드발급</a>
                                    </div>
                                    <div class="btn_sty04">
                                        <a href="javascript:fn_EditCoupon('${cpInfo.partnerCode}');">수정</a>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <ul class="btn_rt01">
                        <li class="btn_sty04"><a href="javascript:void(0)" onclick="javascript:fn_EditCoupon('');">등록</a></li>
                    </ul>
                    <p class="list_pageing">
                        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
                    </p>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="blackBg"></div>
<div id="createCouponPop" class="lay_popup lay_ct"  style="display:none;"></div>

<script type="text/javascript">
    function fn_GoCpNum(partnerCode){
        $("#pageIndex").val(1);
        $("#partnerCode").val(partnerCode);
        $("#frm").serialize();
        $("#frm").attr("action","/oss/point/couponPublishingList.do").submit();
    }

    function fn_EditCoupon(partnerCode){
        $.ajax({
            type:"post",
            data:"partnerCode=" + partnerCode,
            url:"<c:url value='/oss/point/couponCreatePop.ajax'/>",
            success:function(data){
                $("#createCouponPop").html(data);
                show_popup($("#createCouponPop"));
            },
            error : fn_AjaxError
        });
    }

    function fn_Search(pageIndex){
        document.frm.pageIndex.value = pageIndex;
        document.frm.action = "<c:url value='/oss/point/couponList.do'/>";
        document.frm.submit();
    }

    function fn_GoAdmin(partnerCode){
        const result = confirm(partnerCode + "파트너관리자로 이동 합니다.\n 이동 후 통합관리자는 로그아웃 됩니다. \n 이동하시겠습니까? ");
        if (result) {
            $("#partnerCode").val(partnerCode);

            document.frm.action = "<c:url value='/oss/actionOssLogin.do'/>";
            document.frm.submit();
        }
    }
</script>

</body>
</html>