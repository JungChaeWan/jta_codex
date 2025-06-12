
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>"/>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>"></script>

<table border="1" cellpadding="0" cellspacing="0" class="table03">

    <th scope="col">상품번호 : ${prdtInfo.prdtNum}
        <span class="font03"><a target="_blank" href="/web/sv/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}">[상품바로가기]</a></span>
    </th>
    <th scope="col" width="343">업체명 : ${prdtInfo.corpNm} <span class="font03">
            <a href="javascript:fn_LoginMas('${prdtInfo.corpId}');">[업체바로가기]</a>
        </span>
    </th>
    <th scope="col" width="300" ><div class="closePrdt" style="cursor:pointer; width: 10px">[X]</div></th>
    <tr>
        <td colspan="4">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
                <tr class="tr_line">
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="20%"/>
                                <col width="80%"/>
                            </colgroup>
                            <tr>
                                <th scope="col">ㆍ구매정보</th>
                                <td>
                                    <span class="font03">${prdtInfo.prdtNm}</span> <br/><br/>
                                    옵션 :
                                    <select name="selOptList" class="selOptList">
                                        <option value="">--옵션 선택--</option>
                                        <c:forEach items="${optionList}" var="optList">
                                            <c:if test="${empty optList.svOptSn}">
                                                <optgroup label="${optList.prdtDivNm}">
                                            </c:if>
                                                <c:if test="${not empty optList.svOptSn}">
                                                    <option value="${optList.svOptSn}" data-amt="${optList.saleAmt}" data-stocknum="${optList.stockNum}" data-divsn="${optList.svDivSn}">${optList.prdtDivNm} >>> ${optList.optNm}</option>
                                                </c:if>
                                            <c:if test="${empty optList.svOptSn}">
                                                </optgroup>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <input type="hidden" name="svDivSn" class="svDivSn" value="" >

                                    &nbsp;&nbsp;&nbsp;
                                    <c:if test="${fn:length(addOptList) > 0 }">
                                    추가옵션 :
                                    <select name="selAddOptList" class="selAddOptList">
                                        <option value="">--추가 옵션 선택--</option>
                                        <c:forEach items="${addOptList}" var="addOptList">
                                            <option value="${addOptList.addOptSn}" data-addamt="${addOptList.addOptAmt}" data-optdivsn="${addOptList.addOptSn}">${addOptList.addOptNm}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="hidden" name="svOptDivSn" class="svOptDivSn" value="" >
                                    </c:if>
                                    <c:if test="${fn:length(addOptList) <= 0 }">
                                        <input name="selAddOptList" type="hidden" value="" >
                                    </c:if>

                                    <br/><br/>
                                    수량 : <input type="number" name="cnt" class="cnt" min="0">
                                    택배비 : <input type="number" name="dlvAmt" class="dlvAmt" min="0" value="0">
                                    <input type="hidden" name="prdtNum" value="${prdtInfo.prdtNum}">
                                    <input type="hidden" name="CorpId" value="${prdtInfo.corpId}">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="20%"/>
                                <col width="80%"/>
                            </colgroup>
                            <tr>
                                <th scope="col">ㆍ최종금액</th>
                                <td>
                                    <b class="totalPrice" style="color:red">0</b>원
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

            </table>
        </td>
    </tr>
</table>
