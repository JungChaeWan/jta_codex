<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<validator:javascript formName="CPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<c:set var="tgtDiv" value="${fn:trim(cpVO.tgtDiv)}" />

<title></title>
<script type="text/javascript">
function fn_sendMail() {
    if(confirm("<spring:message code='confirm.email.send'/>")) {
        $.ajax({
            url: "<c:url value='/oss/vipBestUserSendMail.ajax'/>",
            data: "cpId=${cpVO.cpId}",
            success:function(data) {
                alert("<spring:message code='success.email.send'/>")
            },
            error: fn_AjaxError
        });
    }
}

var webUrl = location.protocol + "//" + location.host + "/web/";

function getSecondOption(prdtNum, divSn, opt_index, selKey) {
	if(divSn == "") {
        return false;
    }
	var prdtCd = prdtNum.substring(0, 2);

	$.ajax({
		url: webUrl + prdtCd.toLowerCase() + "/getOptionList.ajax",
		data: "prdtNum=" + prdtNum + "&" + prdtCd.toLowerCase() + "DivSn=" + divSn + "&aplDt=",
		success: function(data) {
            $.each(data.list, function(){
                var opt_key = (prdtCd == "${Constant.SOCIAL}") ? this.spOptSn : this.svOptSn;
                var add_str = (this.stockNum > 0 && this.ddlYn == "N") ? "" : " [품절]";

                if(selKey == opt_key) {
                    $("#optSn_" + opt_index).html(" = " + this.optNm + add_str);
                }
            });
		},
		error: fn_AjaxError
	});
}

var userPopup;

function fn_FindUser(){
    if($("#tgtDivAll").prop("checked")) {
        alert("<spring:message code='info.target.all' />");
        return;
    }
	userPopup = window.open("<c:url value='/oss/findUserSMSMail.do'/>?type=email", "findUser", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectUer(userId, userNm, tel, email){
	var isA = true;

	$("input[name='userId']").each(function(){
		if($(this).val() == userId) {
			isA = false;
			return;
		}
	});

	if(isA == false) {
		userPopup.alert("<spring:message code='errors.common.exist' />");
		return;
	}
	var user = "<li>";
    user += "<input type='hidden' name='userId' value='" + userId + "' />";
    user += "&nbsp;&nbsp;<a href='javascript:void(0)'><span class='del'><img src='/images/web/icon/close5.gif' alt='삭제'></span></a>&nbsp;";
    user += "["+ userId + "] [" + userNm + "] [" + tel + "] [" + email + "]";
    user += "<a href='javascript:void(0);' onclick='javascript:fn_insertCoupon();'>저장</a>";
    user += "</li>";

	$("#selectUser ul").append(user);
}

function fn_insertCoupon() {
    let userId = $("input[name=userId]").val();
    let cpId = "${cpVO.cpId}";
    document.CPVO.action= "/oss/addUserCp.do?cpId=" + cpId + "&userId=" + userId ;
    document.CPVO.submit();
}

$(function(){
	<c:forEach var="prdt" items="${cpPrdtList}" varStatus="status">
        <c:set var="prdtCd" value="${fn:substring(prdt.prdtNum, 0, 2)}" />
        // 소셜 & 기념품의 상품 select
        <c:if test="${(prdtCd eq Constant.SOCIAL) or (prdtCd eq Constant.SV)}">
            $.ajax({
                url: "<c:url value='/web/${fn:toLowerCase(prdtCd)}/getDivInfList.ajax' />",
                data: "prdtNum=${prdt.prdtNum}",
                success: function(data) {
                    $.each(data.list, function(){
                        var opt_key = "${prdtCd}" == "${Constant.SOCIAL}" ? this.spDivSn : this.svDivSn;

                        if(opt_key == "${prdt.optDivSn}") {
                            $("#optDivSn_${status.index}").html(this.prdtDivNm);
                        }
                    });
                },
                error: fn_AjaxError
            });
            //소셜 & 기념품의 옵션 select
            getSecondOption("${prdt.prdtNum}", "${prdt.optDivSn}", "${status.index}", "${prdt.optSn}");
	    </c:if>
	</c:forEach>
});

$(function() {
    $("#selectUser").on("click", ".del", function(){
		$(this).parents("li").remove();
	});
});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=coupon" />

		<div id="contents_area">
			<form:form commandName="CPVO" name="CPVO" method="post" enctype="multipart/form-data">
                <input type="hidden" name="cpId" id="cpId" value="${cpVO.cpId}"/>
                <input type="hidden" name="cpDiv" id="cpDiv" value="${cpVO.cpDiv}"/>

                <div id="contents">
                    <h4 class="title03">쿠폰 상세</h4>
                    <table border="1" class="table02">
                        <colgroup>
                            <col width="200" />
                            <col width="*" />
                            <col width="200" />
                            <col width="*" />
                        </colgroup>
                        <tr>
                            <th>쿠폰 ID</th>
                            <td><c:out value="${cpVO.cpId}"/></td>
                            <th>발행상태</th>
                            <td>
                                <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_READY}">발행대기</c:if>
                                <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_COMPLETE}">발행완료</c:if>
                                <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_CANCEL}">발행취소</c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>쿠폰명</th>
                            <td colspan="3"><c:out value="${cpVO.cpNm}"/></td>
                        </tr>
                        <tr>
                            <th>간략 설명</th>
                            <td colspan="3">
                                <c:out value="${cpVO.simpleExp}" escapeXml="false"/>
                            </td>
                        </tr>
                        <tr>
                            <th>적용 기간</th>
                            <td colspan="3">
                                <c:out value="${fn:substring(cpVO.aplStartDt,0,4)}-${fn:substring(cpVO.aplStartDt,4,6)}-${fn:substring(cpVO.aplStartDt,6,8)}" />
                                 ~ <c:out value="${fn:substring(cpVO.aplEndDt,0,4)}-${fn:substring(cpVO.aplEndDt,4,6)}-${fn:substring(cpVO.aplEndDt,6,8)}"  />
                            </td>
                        </tr>
                        <tr>
                            <th>정산 지원</th>
                            <td colspan="3">
                                <c:if test="${cpVO.outsideSupportDiv eq Constant.FLAG_Y}">지원</c:if>
                                <c:if test="${cpVO.outsideSupportDiv eq Constant.FLAG_N}">미지원</c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>할인 방식</th>
                            <td colspan="3">
                                <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                    금액 : <fmt:formatNumber>${cpVO.disAmt}</fmt:formatNumber> 원
                                </c:if>
                                <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                    할인율 : <fmt:formatNumber>${cpVO.disPct}</fmt:formatNumber> %
                                </c:if>
                                <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                    무료 (특정 상품에 대한 무료 이용)
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>구매 최소금액</th>
                            <td colspan="3">
                                <fmt:formatNumber>${cpVO.buyMiniAmt}</fmt:formatNumber> 원
                            </td>
                        </tr>
                        <tr>
                            <th>할인 최대금액(할인율)</th>
                            <td colspan="3">
                                <fmt:formatNumber>${cpVO.limitAmt}</fmt:formatNumber> 원
                            </td>
                        </tr>
                        
                        <tr>
                            <th>총 사용금액(할인율)</th>
                            <td colspan="3">
                                <fmt:formatNumber>${PctSumAmt}</fmt:formatNumber> 원
                            </td>
                        </tr>
                        <tr>
                            <th>적용 상품</th>
                            <td>
                                <c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_TYPE}">
                                    <b>유형지정</b>
                                    <br>
                                    [
                                    <c:set var="ctgr" value="${fn:replace(cpVO.prdtCtgrList, Constant.AVIATION, '항공')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.ACCOMMODATION, '숙소')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.RENTCAR, '렌터카')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_PACKAGE, '여행사 상품')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_TOUR, '관광지/레져')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_ETC, '맛집')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_ADRC, '여행사 단품')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_BACS, '유모차/카시트')}"/>
                                    <c:set var="ctgr" value="${fn:replace(ctgr, Constant.SV, '제주특산/기념품')}"/>
                                    <c:out value="${ctgr}" />
                                    ]
                                </c:if>
                                <c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_PRDT}">
                                    <b>상품지정</b>
                                    <br>
                                    <c:forEach var="prdt" items="${cpPrdtList}" varStatus="status">
                                        <c:set var="prdtCd" value="${fn:substring(prdt.prdtNum, 0, 2)}" />

                                        [${prdt.prdtNum}] [${prdt.corpNm}] <b>${prdt.prdtNm}</b>

                                        <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                            <c:if test="${(prdtCd eq Constant.SOCIAL) or (prdtCd eq Constant.SV)}">
                                                - <span id="optDivSn_${status.index}"></span> <span id="optSn_${status.index}"></span>
                                            </c:if>

                                            <c:set var="cnt_str" value="개" />

                                            <c:if test="${prdtCd eq Constant.ACCOMMODATION}">
                                                <c:set var="cnt_str" value="박" />
                                            </c:if>
                                            <c:if test="${prdtCd eq Constant.RENTCAR}">
                                                <c:set var="cnt_str" value="시간" />
                                            </c:if>
                                            (${prdt.prdtUseNum}${cnt_str})
                                        </c:if>
                                        <br>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_CORP}">
                                    <b>업체지정</b>
                                    <br>
                                    <c:forEach var="corp" items="${cpCorpList}" varStatus="status">
                                        [ ${corp.corpId} ] [ ${corp.corpNm} ] [
                                        <c:if test="${corp.corpCd == 'SV'}">특산/기념품</c:if>
                                        <c:if test="${corp.corpCd == 'AD'}">숙소</c:if>
                                        <c:if test="${corp.corpCd == 'RC'}">렌트카</c:if>
                                        <c:if test="${corp.corpCd == 'SP'}">소셜</c:if>
                                        ]
                                        <br>
                                    </c:forEach>
                                </c:if>
                            </td>
                            <th>구매 상품</th>
                            <td>
                                <br>
                                [
                                <c:set var="ctgr" value="${fn:replace(cpVO.buyCtgrList, Constant.AVIATION, '항공')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.ACCOMMODATION, '숙소')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.RENTCAR, '렌터카')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_PACKAGE, '여행사 상품')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_TOUR, '관광지/레져')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_ETC, '맛집')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_ADRC, '여행사 단품')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_BACS, '유모차/카시트')}"/>
                                <c:set var="ctgr" value="${fn:replace(ctgr, Constant.SV, '제주특산/기념품')}"/>
                                <c:out value="${ctgr}" />
                                ]
                            </td>
                        </tr>
                        <tr>
                            <th>발급 대상</th>
                            <td colspan="3">
                                <b>
                                    <c:if test="${tgtDiv eq 'ALL'}">전체</c:if>
                                    <c:if test="${tgtDiv eq 'VIP'}">VIP</c:if>
                                    <c:if test="${tgtDiv eq 'BEST'}">우수고객</c:if>
                                </b>
                                <c:if test="${(cpVO.statusCd eq Constant.STATUS_CD_COMPLETE) and (cpVO.cpDiv eq Constant.USER_CP_DIV_AEVT)}">
                                    <div class="btn_sty04" style="display: inline-block; vertical-align: middle;">
                                        <span><a href="javascript:void(0);" onclick="javascript:fn_FindUser();">사용자 검색</a></span>
                                        <span><a href="javascript:void(0)" onclick="javascript:fn_sendMail();">E-mail 발송</a></span>
                                    </div>
                                </c:if>
                                <div id="selectUser">
                                    <ul>
                                        <c:forEach items="${userList}" var="data">
                                            <li>[${data.userId}] [${data.userNm}] [${data.telNum}] [${data.email}]</li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>쿠폰 코드</th>
                            <td colspan="3">${cpVO.cpCode}</td>
                        </tr>
                        <tr>
                            <th>수량 제한 타입</th>
                            <td colspan="3">
                                <c:forEach var="limitType" items="${limitTypeList}">
                                    <c:if test="${cpVO.limitType == limitType.cdNum}"><b>${limitType.cdNm}</b></c:if>
                                </c:forEach>
                                <c:if test="${(cpVO.limitType eq 'USAG') or (cpVO.limitType eq 'ISSU')}">
                                    <span> [ 제한 수량 : ${cpVO.limitCnt} ]</span>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>발급 수량</th>
                            <td>${cpVO.issueCnt}</td>
                            <th>사용 수량</th>
                            <td>${cpVO.useCnt}</td>
                        </tr>
                        <tr>
                            <th>등록시각</th>
                            <td>${cpVO.regDttm} [${cpVO.regId}]</td>
                            <th>수정시각</th>
                            <td>${cpVO.modDttm} [${cpVO.modId}]</td>
                         </tr>
                    </table>
                    <ul class="btn_rt01 align_ct">
                        <li class="btn_sty01"><a href="javascript:history.back();">뒤로</a></li>
                    </ul>
                </div>
		    </form:form>
	    </div>
	<!--//Contents 영역--> 
    </div>
</div>
</body>
</html>
		