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
<script type="text/javascript">
// 조회 & 페이징
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/couponList.do'/>";
	document.frm.submit();
}

// 쿠폰추가 이동
function fn_viewInsertCoupon() {
	document.frm.action = "<c:url value='/oss/viewInsertCoupon.do'/>";
	document.frm.submit();
}

// 쿠폰 수정 이동.
function fn_viewUpdateCoupon(cpId) {
	document.frm.cpId.value = cpId;
	document.frm.action="<c:url value='/oss/viewUpdateCoupon.do'/>";
	document.frm.submit();
}

// 쿠폰 상세
function fn_viewCoupon(cpId) {
	document.frm.cpId.value = cpId;
	document.frm.action="<c:url value='/oss/detailCoupon.do'/>";
	document.frm.submit();
}

// 쿠폰 발행
function fn_CompleteCoupon(cpId) {
    if(confirm("<spring:message code='confirm.coupon.complete'/>")) {
        document.frm.cpId.value = cpId;
        document.frm.action="<c:url value='/oss/completeCoupon.do'/>";
        document.frm.submit();
    }
}

// 쿠폰 취소
function fn_CancelCoupon(cpId) {
    if(confirm("<spring:message code='confirm.coupon.cancel'/>")) {
        document.frm.cpId.value = cpId;
        document.frm.action="<c:url value='/oss/cancelCoupon.do'/>";
        document.frm.submit();
    }
}

// 쿠폰 삭제
function fn_deleteCoupon(cpId) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
            url: "<c:url value='/oss/deleteCoupon.ajax'/>",
            data: "cpId=" + cpId,
            dataType: "json",
            success: function(data) {
                if(data.resultCode == "${Constant.JSON_SUCCESS}") {
                    fn_Search(document.frm.pageIndex.value);
                } else if(data.resultCode == "${Constant.JSON_FAIL}") {
                    alert("<spring:message code='fail.common.delete'/>");
                }
            },
            error: fn_AjaxError
		});
	}
}

$(function(){
    $("#cpDiv").change(function () {
        fn_Search(1);
    });
})

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=coupon" />
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
				<input type="hidden" id="cpId" name="cpId" />

                <div id="contents">
                    <!--검색-->
                    <div class="search_area">
                        <select name="cpDiv" id="cpDiv">
                            <option value="">전체</option>
                            <option value="${Constant.USER_CP_DIV_AEVT}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_AEVT}">selected="selected"</c:if>>이벤트쿠폰</option>
                            <option value="${Constant.USER_CP_DIV_EPIL}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_EPIL}">selected="selected"</c:if>>회원가입</option>
                            <option value="${Constant.USER_CP_DIV_UAPP}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_UAPP}">selected="selected"</c:if>>앱다운로드</option>
                            <option value="${Constant.USER_CP_DIV_UEPI}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_UEPI}">selected="selected"</c:if>>이용후기</option>
                            <option value="${Constant.USER_CP_DIV_VIMO}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_VIMO}">selected="selected"</c:if>>재방문</option>
                            <option value="${Constant.USER_CP_DIV_ACNR}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_ACNR}">selected="selected"</c:if>>자동취소(실시간상품)</option>
                            <option value="${Constant.USER_CP_DIV_ACNV}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_ACNV}">selected="selected"</c:if>>자동취소(특산/기념품)</option>
                            <option value="${Constant.USER_CP_DIV_BAAP}" <c:if test="${CPVO.cpDiv == Constant.USER_CP_DIV_BAAP}">selected="selected"</c:if>>구매자동발급쿠폰</option>
                        </select>
                    </div>

                    <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
                    <div class="list">
                        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                            <thead>
                                <tr>
                                    <th width="100">쿠폰번호</th>
                                    <th width="80">상태</th>
                                    <th>쿠폰명</th>
                                    <th width="180">적용기간</th>
                                    <th width="120">할인방식</th>
                                    <th width="100">최소구매금액</th>
                                    <th width="100">최대할인금액</th>
                                    <th width="80">대상지정</th>
                                    <th width="80">적용상품</th>
                                    <c:if test="${(empty CPVO.cpDiv) or (CPVO.cpDiv eq Constant.USER_CP_DIV_AEVT)}">
                                        <th width="100">수량제한</th>
                                    </c:if>
                                    <c:if test="${(not empty CPVO.cpDiv) and (CPVO.cpDiv ne Constant.USER_CP_DIV_AEVT)}">
                                        <th width="140">상품카테고리</th>
                                    </c:if>
                                    <th width="80">정산지원</th>
                                    <th width="160">기능툴</th>
                                </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 없음 -->
                            <c:if test="${fn:length(resultList) == 0}">
                                <tr>
                                    <td colspan="11" class="align_ct">
                                        <spring:message code="common.nodata.msg" />
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="cpInfo" items="${resultList}" varStatus="status">
                                <tr>
                                    <td class="align_ct"><c:out value="${cpInfo.cpId}"/></td>
                                    <td class="align_ct">
                                        <c:if test="${cpInfo.statusCd eq Constant.STATUS_CD_READY}">발행대기</c:if>
                                        <c:if test="${cpInfo.statusCd eq Constant.STATUS_CD_COMPLETE}">발행완료</c:if>
                                        <c:if test="${cpInfo.statusCd eq Constant.STATUS_CD_CANCEL}">발행취소</c:if>
                                    </td>
                                    <td class="align_lt"><c:out value="${cpInfo.cpNm}" /></td>
                                    <td class="align_ct">
                                        <fmt:parseDate value="${cpInfo.aplStartDt}" var="aplStartDt" pattern="yyyyMMdd"/>
                                        <fmt:parseDate value="${cpInfo.aplEndDt}" var="aplEndDt" pattern="yyyyMMdd"/>
                                        <fmt:formatDate value="${aplStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${aplEndDt}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td class="align_ct">
                                        <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                            [금액] <fmt:formatNumber>${cpInfo.disAmt}</fmt:formatNumber> 원
                                        </c:if>
                                        <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                            [할인율] <fmt:formatNumber>${cpInfo.disPct}</fmt:formatNumber> %
                                        </c:if>
                                        <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                            무료
                                        </c:if>
                                    </td>
                                    <td class="align_ct">
                                        <fmt:formatNumber>${cpInfo.buyMiniAmt}</fmt:formatNumber> 원
                                    </td>
                                    <td class="align_ct">
                                        <fmt:formatNumber>${cpInfo.limitAmt}</fmt:formatNumber> 원
                                    </td>
                                    <td class="align_ct">
                                        <c:if test="${cpInfo.tgtDiv eq 'ALL'}">전체</c:if>
                                        <c:if test="${cpInfo.tgtDiv eq 'VIP'}">VIP</c:if>
                                        <c:if test="${cpInfo.tgtDiv eq 'BEST'}">우수고객</c:if>
                                    </td>
                                    <td class="align_ct">
                                        <c:if test="${cpInfo.aplprdtDiv eq Constant.CP_APLPRDT_DIV_TYPE}">유형지정</c:if>
                                        <c:if test="${cpInfo.aplprdtDiv eq Constant.CP_APLPRDT_DIV_PRDT}">상품지정</c:if>
                                        <c:if test="${cpInfo.aplprdtDiv eq Constant.CP_APLPRDT_DIV_CORP}">업체지정</c:if>
                                    </td>
                                    <c:if test="${(empty CPVO.cpDiv) or (CPVO.cpDiv eq Constant.USER_CP_DIV_AEVT)}">
                                        <td class="align_ct">
                                            <c:if test="${(not empty cpInfo.limitType) and (cpInfo.limitType ne 'UNLI')}">
                                                ${limitTypeMap[cpInfo.limitType]}
                                            </c:if>
                                        </td>
                                    </c:if>
                                    <c:if test="${(not empty CPVO.cpDiv) and (CPVO.cpDiv ne Constant.USER_CP_DIV_AEVT)}">
                                        <td>
                                            <c:set var="ctgr" value="${fn:replace(cpInfo.prdtCtgrList, Constant.ACCOMMODATION, '숙박')}"/>
                                            <c:set var="ctgr" value="${fn:replace(ctgr, Constant.RENTCAR, '렌터카')}"/>
                                            <c:set var="ctgr" value="${fn:replace(ctgr, Constant.SOCIAL, '소셜상품')}"/>
                                            <c:set var="ctgr" value="${fn:replace(ctgr, Constant.SV, '제주특산/기념품')}"/>
                                            ${ctgr}
                                        </td>
                                    </c:if>
                                    <td class="align_ct">
                                        <c:if test="${cpInfo.outsideSupportDiv eq Constant.FLAG_Y}">지원</c:if>
                                        <c:if test="${cpInfo.outsideSupportDiv eq Constant.FLAG_N}">미지원</c:if>
                                    </td>
                                    <td class="align_ct">
                                        <c:if test="${cpInfo.statusCd eq Constant.STATUS_CD_READY}">
                                            <div class="btn_sty06"><span><a href="javascript:void(0)" onclick="javascript:fn_viewUpdateCoupon('${cpInfo.cpId}');">수정</a></span></div>
                                            <div class="btn_sty06"><span><a href="javascript:void(0)" onclick="javascript:fn_CompleteCoupon('${cpInfo.cpId}');">쿠폰발행</a></span></div>
                                            <div class="btn_sty09"><span><a href="javascript:void(0)" onclick="javascript:fn_deleteCoupon('${cpInfo.cpId}');">삭제</a></span></div>
                                        </c:if>
                                        <c:if test="${cpInfo.statusCd eq Constant.STATUS_CD_COMPLETE}">
                                            <div class="btn_sty06"><span><a href="javascript:void(0)" onclick="javascript:fn_viewCoupon('${cpInfo.cpId}');">상세</a></span></div>
                                            <c:if test="${cpInfo.limitType eq 'USAG' or cpInfo.limitType eq 'ISSU'}">
                                                <div class="btn_sty06"><span><a href="javascript:void(0)" onclick="javascript:fn_viewUpdateCoupon('${cpInfo.cpId}');">수정</a></span></div>
                                            </c:if>
                                            <div class="btn_sty06"><span><a href="javascript:void(0)" onclick="javascript:fn_CancelCoupon('${cpInfo.cpId}');">발행취소</a></span></div>
                                        </c:if>
                                        <c:if test="${cpInfo.statusCd eq Constant.STATUS_CD_CANCEL}">
                                            <div class="btn_sty06"><span><a href="javascript:void(0)" onclick="javascript:fn_viewCoupon('${cpInfo.cpId}');">상세</a></span></div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>
                    <ul class="btn_rt01">
                        <li class="btn_sty04"><a href="javascript:void(0)" onclick="javascript:fn_viewInsertCoupon();">쿠폰추가</a></li>
                    </ul>
			    </div>
			</form>
		</div>
	</div>
</div>
</body>
</html>