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
        <jsp:include page="/oss/left.do?menu=mntr&sub=tlCancelErrList" flush="false"></jsp:include>

        <div id="contents_area">
            <div id="contents">
                <p class="search_list_ps">탐나오에서는 취소 되었는데 TL린칸에 취소전송을 보내지 않은 리스트</p>
                <div class="list">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                        <colgroup>
                            <col width="120" />
                            <col />
                            <col width="220" />
                            <col width="100" />
                            <col width="300" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>예약번호</th>
                            <th>예약정보</th>
                            <th>예약일시</th>
                            <th>경과시간</th>
                            <th>기능툴</th>
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
                                <td class="align_ct">${rsvInfo.rsvNum} <br/> (${rsvInfo.adRsvNum})</td>
                                <td class="align_lt">
                                    <table class="product-list">
                                        <colgroup>
                                            <col />
                                            <col width="100" />
                                        </colgroup>

                                        <tr>
                                            <td class="left2">
                                                <p><c:out value="${rsvInfo.corpNm}"/></p>
                                                <p class="product"><strong><c:out value="${rsvInfo.prdtNm}"/></strong></p>
                                                <p class="infoText"><c:out value="${rsvInfo.prdtInf}"/></p>
                                            </td>
                                            <td>
                                                <c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
                                                <c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                                <td class="align_ct">
                                    <c:out value='${rsvInfo.regDttm}'/>
                                </td>
                                <td class="align_ct">
                                    <c:out value='${rsvInfo.modDttm}'/>분 경과
                                </td>
                                <td class="align_ct">
                                    <div class="btn_sty08"><span><a href="/oss/detailRsv.do?rsvNum=${rsvInfo.rsvNum}" target="_blank">예약상세보기</a></span></div>
                                    <c:if test="${rsvInfo.modDttm > 50}">
                                    <div class="btn_sty09"><span><a href="javascript:fn_BookingCancel('${rsvInfo.adRsvNum}');">TLL취소전송</a></span></div>
                                    </c:if>
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

    function  fn_BookingCancel(adRsvNum){
        $.ajax({
            type:"post",
            dataType:"json",
            async:false,
            url:"/oss/tlBookingCancel.ajax",
            data:"adRsvNum="+adRsvNum ,
            success:function(data){
                const cancelResult = data.cancelResult;
                if (cancelResult.rsvResult == "Y"){
                    alert("취소 전송이 완료 되었습니다.");
                    window.location.reload();
                }else {
                    alert("취소 전송이 실패 하였습니다.\n"+cancelResult.faultReason);
                }
            }
        });
    }

</script>


</body>
</html>
