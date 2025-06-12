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
        a.download = 'lsApiProductList'+'.xls';
        a.click();
    }

	</script>

</head>
<body>
<div id="wrapper">
    <jsp:include page="/oss/head.do?menu=mntr" flush="false"></jsp:include>
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=mntr&sub=lsProductList" flush="false"></jsp:include>

        <div id="contents_area">
            <div id="contents">
                <p class="search_list_ps">엘에스 연동 상품 리스트</p>
                <p class="search_list_ps title-btn"><strong>미연동 옵션 개수 : ${resultList.noOptCnt}</strong>
                <span class="side-wrap">
                <a class="btn_sty04" href="javascript:tableToExcel();">엑셀다운로드</a>
                <a class="btn_sty04" href="javascript:fn_productListSync();">데이터연동하기</a>
                </span>
                </p>
                <div class="list">
                    <table id="productList01" width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                        <colgroup>
                            <col style="width:30px" />
                            <col style="width:200px" />
                            <col style="width:50px" />
                            <col style="width:50px" />
                            <col style="width:500px" />
                            <col style="width:500px" />
                            <col style="width:500px" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>순번</th>
                            <th>상품명</th>
                            <th>LS컴퍼니 상품번호</th>
                            <th>이미지정보</th>
                            <th colspan="3">옵션정보</th>
<%--                            <th>option</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 데이터 없음 -->
                        <c:if test="${fn:length(resultList.list) == 0}">
                            <tr>
                                <td colspan="6" class="align_ct"><spring:message code="common.nodata.msg" /></td>
                            </tr>
                        </c:if>
                        <c:forEach items="${resultList.list}" var="listInfo" varStatus="stauts">
                            <tr>
                                <td class="align_ct" <c:if test="${listInfo.product_match ne 'Y'}"> style="color: #ff8f87"</c:if>>
                                    ${stauts.count}
                                </td>
                                <td class="align_ct" <c:if test="${listInfo.product_match ne 'Y'}"> style="color: #ff8f87"</c:if>>
                                    <c:if test="${listInfo.product_match ne 'Y'}">**</c:if>${listInfo.product_name}
                                </td>
                                <td class="align_ct" <c:if test="${listInfo.product_match ne 'Y'}"> style="color: #ff8f87"</c:if>>${listInfo.product_code}</td>
                                <td class="align_ct" <c:if test="${listInfo.product_match ne 'Y'}"> style="color: #ff8f87"</c:if>>
                                    <c:forEach items="${listInfo.images}" var="imagesInfo" varStatus="stauts">
                                        ${imagesInfo.imageUri}
                                    </c:forEach>
                                </td>
                                <td class="align_lt" style="vertical-align: text-top">
                                    <c:forEach items="${listInfo.option}" var="optionInfo" varStatus="stauts">
                                        <c:if test="${stauts.index%3 == 0}">
                                        <p <c:if test="${optionInfo.option_match ne 'Y'}"> style="color: #ff8f87"</c:if>>
                                            <c:if test="${optionInfo.option_match ne 'Y'}">**</c:if>LS컴퍼니 옵션번호 : ${optionInfo.optionId}<br>
                                            옵션명 : ${optionInfo.name}<br>
                                            판매시작일 : ${optionInfo.startDate}<br>
                                            판매종료일 : ${optionInfo.endDate}<br>
                                            유효기간타입 : ${optionInfo.expireType}<br>
                                            유효기간 시작일 : ${optionInfo.expireStartDate}<br>
                                            유효기간 종료일 : ${optionInfo.expireEndDate}<br>
                                            유효기간 설정일 : ${optionInfo.expireDay}<br>
                                            정상가 : ${optionInfo.normalPrice}<br>
                                            판매가 : ${optionInfo.salePrice}<br>
                                            상품분류 : ${optionInfo.classify}<br>
                                            <br>
                                        </p>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td class="align_lt" style="vertical-align: text-top">
                                    <c:forEach items="${listInfo.option}" var="optionInfo" varStatus="stauts">
                                        <c:if test="${stauts.index%3 == 1}">
                                        <p <c:if test="${optionInfo.option_match ne 'Y'}"> style="color: #ff8f87"</c:if>>
                                             <c:if test="${optionInfo.option_match ne 'Y'}">**</c:if>LS컴퍼니 옵션번호 : ${optionInfo.optionId}<br>
                                            옵션명 : ${optionInfo.name}<br>
                                            판매시작일 : ${optionInfo.startDate}<br>
                                            판매종료일 : ${optionInfo.endDate}<br>
                                            유효기간타입 : ${optionInfo.expireType}<br>
                                            유효기간 시작일 : ${optionInfo.expireStartDate}<br>
                                            유효기간 종료일 : ${optionInfo.expireEndDate}<br>
                                            유효기간 설정일 : ${optionInfo.expireDay}<br>
                                            정상가 : ${optionInfo.normalPrice}<br>
                                            판매가 : ${optionInfo.salePrice}<br>
                                            상품분류 : ${optionInfo.classify}<br>
                                            <br>
                                        </p>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td class="align_lt" style="vertical-align: text-top">
                                    <c:forEach items="${listInfo.option}" var="optionInfo" varStatus="stauts">
                                        <c:if test="${stauts.index%3 == 2}">
                                        <p <c:if test="${optionInfo.option_match ne 'Y'}"> style="color: #ff8f87"</c:if>>
                                             <c:if test="${optionInfo.option_match ne 'Y'}">**</c:if>LS컴퍼니 옵션번호 : ${optionInfo.optionId}<br>
                                            옵션명 : ${optionInfo.name}<br>
                                            판매시작일 : ${optionInfo.startDate}<br>
                                            판매종료일 : ${optionInfo.endDate}<br>
                                            유효기간타입 : ${optionInfo.expireType}<br>
                                            유효기간 시작일 : ${optionInfo.expireStartDate}<br>
                                            유효기간 종료일 : ${optionInfo.expireEndDate}<br>
                                            유효기간 설정일 : ${optionInfo.expireDay}<br>
                                            정상가 : ${optionInfo.normalPrice}<br>
                                            판매가 : ${optionInfo.salePrice}<br>
                                            상품분류 : ${optionInfo.classify}<br>
                                            <br>
                                        </p>
                                        </c:if>
                                    </c:forEach>
                                </td>
                            </tr>
                            <%--<tr  <c:if test="${empty rsvInfo.juniorAgeStdApicode || empty rsvInfo.childAgeStdApicode }">style="background-color: #4897dc"</c:if>>
                                <td class="align_ct">${rsvInfo.corpId}</td>
                                <td class="align_lt">
                                    <p><strong><c:out value="${rsvInfo.corpNm}"/></strong></p>
                                    <p class="product">예약전화번호 : <c:out value="${rsvInfo.rsvTelNum}"/></p>
                                    <p class="product">담당자전화번호 : <c:out value="${rsvInfo.admMobile}"/></p>
                                    <p class="infoText"><c:out value="${rsvInfo.addr}"/></p>
                                <td>
                                    <p >탐나오 기준 : ${rsvInfo.juniorAgeStd}</p>
                                    <select name="juniorAgeStdApicode" id="juniorAgeStdApicode" data-corpid="${rsvInfo.corpId}">
                                        <option value="">--TL린칸기준--</option>
                                        <option value="CHILDA" <c:if test="${rsvInfo.juniorAgeStdApicode == 'CHILDA'}">selected="selected"</c:if>>성인과 동일한 식사 및 침구 (CHILDA)</option>
                                        <option value="CHILDB" <c:if test="${rsvInfo.juniorAgeStdApicode == 'CHILDB'}">selected="selected"</c:if>>어린이 전용 식사 및 침구 또는 어린이 전용 식사 (CHILDB)</option>
                                        <option value="CHILDC" <c:if test="${rsvInfo.juniorAgeStdApicode == 'CHILDC'}">selected="selected"</c:if>>침구 만 (CHILDC)</option>
                                        <option value="CHILDD" <c:if test="${rsvInfo.juniorAgeStdApicode == 'CHILDD'}">selected="selected"</c:if>> 식사와 침구는 필요하지 않음 (CHILDD)</option>
                                    </select>
                                </td>
                                <td>
                                    <p >탐나오 기준 : ${rsvInfo.childAgeStd}</p>
                                    <select name="childAgeStdApicode" id="childAgeStdApicode" data-corpid="${rsvInfo.corpId}">
                                        <option value="">--TL린칸기준--</option>
                                        <option value="CHILDA" <c:if test="${rsvInfo.childAgeStdApicode == 'CHILDA'}">selected="selected"</c:if>>성인과 동일한 식사 및 침구 (CHILDA)</option>
                                        <option value="CHILDB" <c:if test="${rsvInfo.childAgeStdApicode == 'CHILDB'}">selected="selected"</c:if>>어린이 전용 식사 및 침구 또는 어린이 전용 식사 (CHILDB)</option>
                                        <option value="CHILDC" <c:if test="${rsvInfo.childAgeStdApicode == 'CHILDC'}">selected="selected"</c:if>>침구 만 (CHILDC)</option>
                                        <option value="CHILDD" <c:if test="${rsvInfo.childAgeStdApicode == 'CHILDD'}">selected="selected"</c:if>> 식사와 침구는 필요하지 않음 (CHILDD)</option>
                                    </select>
                                </td>
                                <td class="align_ct">
                                    <label><input type="radio" name="tllPriceLink${stauts.count}" value="SELL" <c:if test="${rsvInfo.tllPriceLink == 'SELL'}">checked="checked"</c:if> onclick="fn_selTllPrice('${rsvInfo.corpId}', 'SELL','');"/>판매가</label>
                                    <label><input type="radio" name="tllPriceLink${stauts.count}" value="NET" <c:if test="${rsvInfo.tllPriceLink == 'NET'}">checked="checked"</c:if> onclick="fn_selTllPrice('${rsvInfo.corpId}', 'NET','');" />입금가</label>
                                </td>
                                <td class="align_ct">
                                    <label><input type="radio" name="tllPriceRsv${stauts.count}" value="SELL" <c:if test="${rsvInfo.tllRsvLink == 'SELL'}">checked="checked"</c:if> onclick="fn_selTllPrice('${rsvInfo.corpId}','', 'SELL');"/>판매가</label>
                                    <label><input type="radio" name="tllPriceRsv${stauts.count}" value="NET" <c:if test="${rsvInfo.tllRsvLink == 'NET'}">checked="checked"</c:if> onclick="fn_selTllPrice('${rsvInfo.corpId}','', 'NET');" />입금가</label>
                                </td>
                                <td class="align_ct">
                                    <div class="btn_sty08"><span><a href="/oss/detailCorp.do?corpId=${rsvInfo.corpId}" target="_blank">호텔상세보기</a></span></div>
                                </td>
                            </tr>--%>
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
