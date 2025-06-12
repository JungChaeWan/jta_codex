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

    <title>API모니터링 LS상품목록</title>
    <script>
    function fn_productListSync() {
        if(confirm("데이터를 연동하시겠습니까?")){
            $.ajax({
            type: "post",
            dataType: "json",
            url: "/apiLs/productListSync.ajax",
            success: function (data) {
                $(".modal-spinner").hide();
                alert("데이터가 연동되었습니다.");
            },beforeSend:function(){
                $(".modal-spinner").show()
            }
        });
        }
    }

    function tableToExcel() {
        var data_type = 'data:application/vnd.ms-excel;charset=utf-8';
        var table_html = encodeURIComponent(document.getElementById('productList01').outerHTML);

        var a = document.createElement('a');
        a.href = data_type + ',%EF%BB%BF' + table_html;
        a.download = 'lsApiCompanyList'+'.xls';
        a.click();
    }
	</script>

</head>
<body>
<div id="wrapper">
    <jsp:include page="/oss/head.do?menu=mntr" flush="false"></jsp:include>
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=mntr&sub=lsCompanyList" flush="false"></jsp:include>

        <div id="contents_area">
            <div id="contents">
                <p class="search_list_ps">엘에스 연동 업체 리스트</p>
                <p class="search_list_ps title-btn">
                    <span class="side-wrap">
                    <a class="btn_sty04" href="javascript:tableToExcel();">엑셀다운로드</a>
                </span>
                </p>
                <div class="list">
                    <table id="productList01" width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                        <colgroup>
                            <col style="width:30px" />
                            <col style="width:100px" />
                            <col style="width:100px" />
                            <col style="width:200px" />
                            <col style="width:100px" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>순번</th>
                            <th>업체명</th>
                            <th>연락처/ 사업자번호</th>
                            <th>주소 / 우편번호</th>
                            <th>지역 / 지역세부</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 데이터 없음 -->
                        <c:if test="${fn:length(resultList.list) == 0}">
                            <tr>
                                <td colspan="4" class="align_ct"><spring:message code="common.nodata.msg" /></td>
                            </tr>
                        </c:if>
                        <c:forEach items="${resultList.list}" var="listInfo" varStatus="stauts">
                            <tr>
                                <td>
                                    ${stauts.count}
                                </td>
                                <td>
                                    ${listInfo.name}(${listInfo.nickName})
                                </td>
                                <td>
                                    ${listInfo.hp} / ${listInfo.bizNo}
                                </td>
                                <td>
                                    ${listInfo.address} / ${listInfo.zipCode}
                                </td>
                                <td>
                                    ${listInfo.areaName} / ${listInfo.areaDtlName}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-spinner" style="display: none;">
            <div class="popBg"></div>
                <div class="loading-popup">
                    <div class="spinner-con">
                        <strong class="spinner-txt">제주여행 공공 플랫폼 탐나오</strong>
                        <div class="spinner-sub-txt">
                            <span>상품연동중입니다.</span>
                            <p>썸네일/상세 이미지, 정상가/판매가 금액,<p>
                                <p>옵션명이 연동됩니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
