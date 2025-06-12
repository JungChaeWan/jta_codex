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
        <jsp:include page="/oss/left.do?menu=mntr&sub=tlCorpList" flush="false"></jsp:include>

        <div id="contents_area">
            <div id="contents">
                <p class="search_list_ps">TL린칸 연동 업체 리스트</p>
                <div class="list">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                        <colgroup>
                            <col width="120" />
                            <col />
                            <col width="200" />
                            <col width="200" />
                            <col width="160" />
                            <col width="160" />
                            <col width="100" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>연동아이디</th>
                            <th>호텔정보</th>
                            <th>소아 매핑</th>
                            <th>유아 매핑</th>
                            <th>금액연동기준</th>
                            <th>예약전송기준</th>
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
                            <tr  <c:if test="${empty rsvInfo.juniorAgeStdApicode || empty rsvInfo.childAgeStdApicode }">style="background-color: #4897dc"</c:if>>
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
        //어린이 type 매핑 update
        $("#juniorAgeStdApicode, #childAgeStdApicode").change(function (){
            const sel = $(this);
            const param = "corpId="+sel.data("corpid")+"&ageType="+sel.context.id+"&apiCode="+sel.val();
            $.ajax({
                type:"post",
                dataType:"json",
                async:false,
                url:"/oss/updateTlChildType.ajax",
                data: param,
                success:function(data){
                    if (data.Status == "success"){
                        alert("변경 되었습니다.");
                        if (sel.val() == ''){
                            sel.closest('tr').css('background-color','#4897dc');
                        }else{
                            sel.closest('tr').css('background-color','');
                        }
                    }else {
                        alert("실패 하였습니다.");
                    }
                }
            });
        });
    });

    //금액연동기준 설정
    function fn_selTllPrice(xCorpId, xPriceLink, xRsvLink){
        const param = "corpId="+xCorpId+"&tllPriceLink="+xPriceLink+"&tllRsvLink="+xRsvLink;
        $.ajax({
            type:"post",
            dataType:"json",
            async:false,
            url:"/oss/updateTlPriceLink.ajax",
            data: param,
            success:function(data){
                if (data.Status == "success"){
                    alert("변경 되었습니다.");
                }else {
                    alert("실패 하였습니다.");
                }
            }
        });
    }
</script>
</body>
</html>
