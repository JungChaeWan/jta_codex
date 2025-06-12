<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"	uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


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
    <jsp:include page="/oss/head.do?menu=mntr" flush="false"></jsp:include>
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=mntr&sub=pointRsvErrList" flush="false"></jsp:include>

        <div id="contents_area">
            <div id="contents">
                <p class="search_list_ps">포인트 오류 - 꼭 확인 해 볼 것!</p>
                <div class="list">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                        <thead>
                        <tr>
                            <th>예약번호</th>
                            <th>파트너코드</th>
                            <th>RSV.사용포인트</th>
                            <th>POINT.사용(취소)포인트</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 데이터 없음 -->
                        <c:if test="${fn:length(resultList) == 0}">
                            <tr>
                                <td colspan="8" class="align_ct"><spring:message code="common.nodata.msg" /></td>
                            </tr>
                        </c:if>
                        <c:forEach items="${resultList}" var="rsvInfo" varStatus="stauts">
                            <tr >
                                <td class="align_ct">${rsvInfo.rsvNum} </td>
                                <td class="align_ct">${rsvInfo.partnerCode} </td>
                                <td class="align_ct">
                                    <c:out value='${rsvInfo.usePoint}'/>
                                </td>
                                <td class="align_ct">
                                    <c:out value='${rsvInfo.payPoint}'/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">

    $(document).ready(function(){

    });

</script>


</body>
</html>
