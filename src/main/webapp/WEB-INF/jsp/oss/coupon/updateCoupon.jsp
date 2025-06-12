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
<style>.ui-widget-content{top:50%;left:20%;height:300px;overflow-y: scroll}</style>

<title></title>
<script type="text/javascript">
//쿠폰수정
function fn_updateCoupon() {
    // 콤마 제거
    delCommaFormat();

    <c:if test="${cpVO.statusCd ne Constant.STATUS_CD_COMPLETE}">
        if(!validateCPVO(document.CPVO)) {
            return;
        }
        // 할인율 체크
        if($("#disDivRate").prop("checked") && Number($("#disPct").val()) > 100) {
            alert("<spring:message code='errors.lessthan' arguments='할인율, 100%' />");
            $("#disPct").focus();
            return;
        }
        // 구매최소금액 >= 할인금액
        if($('#disDivPrice').prop('checked') && Number($("#buyMiniAmt").val()) < Number($("#disAmt").val())) {
            alert("<spring:message code='errors.morethan' arguments='구매최소금액, 할인금액' />");
            $("#disAmt").focus();
            return;
        }
        if(Number($("#corpDisAmt").val()) > Number($("#disAmt").val())) {
            alert("<spring:message code='errors.morethan' arguments='할인금액, 업체할인부담금 ' />");
            $("#corpDisAmt").focus();
            return;
        }

        // 유형지정
        if($("#aplprdtDivType").prop("checked") && $(":checkbox[name=prdtCtgrList]:checked").length == 0) {
            alert("<spring:message code='errors.productCategory.check' />");
            return;
        }
        // 상품지정
        if($("#aplprdtDivPrdt").prop("checked") || $("#disDivFree").prop("checked")) {
            var prdtNumList = [];

            $("input[name='prdtNum']").each(function() {
                prdtNumList.push($(this).val());
            });
            if(prdtNumList.length == 0) {
                alert("<spring:message code='errors.product.add' />");
                return;
            }
            $("#prdtNumList").val(prdtNumList.toString());
        }
        // 업체지정
        if($("#aplprdtDivCorp").prop("checked")) {
            if ($("input[name='corpNum']").length === 0){
                alert("업체를 선택 해 주세요.");
                return;
            }
        }
        //구매자동발급 쿠폰일 경우, 구매상품 선택
        if($("#cpDiv option:selected").val() == "BAAP" && $(":checkbox[name=buyCtgrList]:checked").length == 0){
        	alert("구매자동발급쿠폰 일 경우, 구매상품을 선택해 주세요.");
        	return;
        }
        
        // 발급대상
        if($("#tgtDivVip").prop("checked") || $("#tgtDivBest").prop("checked")) {
            // 자동발행쿠폰은 전체 사용자 대상만 가능
            if($("#cpDiv").val() != "AEVT") {
                alert("<spring:message code='info.target.all' />");
                return;;
            }
            var userIds = [];

            $("input[name='userId']").each(function() {
                userIds.push($(this).val());
            });
            if(userIds.length == 0) {
                alert("<spring:message code='errors.user.add' />");
                return;
            }
        }
        $("#aplStartDt").val($("#aplStartDt").val().replace(/-/g, ""));
        $("#aplEndDt").val($("#aplEndDt").val().replace(/-/g, ""));

        if($("#outsideSupportDivY").prop("checked") || ($("#outsideSupportDivN").prop("checked") && confirm("정산의 미지원이 맞습니까?"))) {
            document.CPVO.action= "<c:url value='/oss/updateCoupon.do'/>";
            document.CPVO.submit();
        }
    </c:if>

    document.CPVO.action= "<c:url value='/oss/updateCoupon.do'/>";
    document.CPVO.submit();
}

var userPopup;

function fn_FindUser() {
    if($("#tgtDivAll").prop("checked")) {
        alert("<spring:message code='info.target.all' />");
        return;
    }
    userPopup = window.open("<c:url value='/oss/findUserSMSMail.do'/>?type=email", "findUser", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectUer(userId, userNm, tel, email) {
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
    user += "&nbsp;&nbsp;<a href='#'><span class='del'><img src=\"<c:url value='/images/web/icon/close5.gif'/>\" alt='삭제'></span></a>&nbsp;";
    user += "["+ userId + "] [" + userNm + "] [" + tel + "] [" + email + "]";
    user += "<input type='hidden' name='userId' value='" + userId + "' />";
    user += "</li>";

    $("#selectUser ul").append(user);
}

function fn_aplPct() {
    if($("#aplPctBtn").hasClass("disabled")) {
        return false;
    }
    if($("#aplPct").val() != 0) {
        var saleMinAmt = Number($("#disAmt").val()) * (100 / Number($("#aplPct").val()));

        $("#buyMiniAmt").val(saleMinAmt);
    } else {
        $("#buyMiniAmt").val(0);
    }
}

var prdtPopup;

function fn_viewSelectProduct() {
    prdtPopup = window.open("<c:url value='/oss/findPrdt.do'/>", "findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSpProduct() {
    prdtPopup = window.open("<c:url value='/oss/findSpPrdt.do'/>", "findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSvProduct() {
    prdtPopup = window.open("<c:url value='/oss/findSvPrdt.do'/>", "findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

var webUrl = location.protocol + "//" + location.host + "/web/";

function fn_selectProduct(prdtId, corpNm, prdtNm) {
    var isA = true;

    $("input[name='prdtNum']").each(function(){
        if($(this).val() == prdtId) {
            isA = false;
            return;
        }
    });

    if(isA == false) {
        prdtPopup.alert("<spring:message code='errors.common.exist' />");
        return;
    }
    var strHtml = "<li>";
    strHtml += "<a href='javascript:void(0)'><span class='del'><img src='/images/web/icon/close5.gif' alt='삭제'></span></a> ";
    strHtml += "[" + prdtId + "] [" + corpNm + "] [" + prdtNm + "] ";

    // 무료(특정 상품)
    if ($("#disDivFree").prop("checked")) {
        var prdtCd = prdtId.substring(0, 2);
        var li_length = $("#selectProduct ul li").length + 1;

        if(prdtCd == "${Constant.SOCIAL}" || prdtCd == "${Constant.SV}") {	//소셜 & 기념품이면 옵션 선택..
            strHtml += "<select id='selOptSn" + li_length + "' name='optSn' onchange=\"getSecondOption('" + prdtId  + "', this.value, " + li_length + ", '');\">";

            $.ajax({
                url: webUrl + prdtCd.toLowerCase() + "/getDivInfList.ajax",
                data: "prdtNum=" + prdtId,
                success:function(data) {
                    var optionStr = "<option value=''>상품 선택</option>";

                    $.each(data.list, function(){
                        var opt_key = prdtCd == "${Constant.SOCIAL}" ? this.spDivSn : this.svDivSn;
                        optionStr += "<option value='" + opt_key + "'>" + this.prdtDivNm + "</option>";
                    });

                    $("#selOptSn" + li_length).append(optionStr);
                },
                error: fn_AjaxError
            });
            strHtml += "</select> ";
            strHtml += "<select name='optDivSn' id='optDivSn" + li_length + "'><option value=''>옵션 선택</option></select> ";
        } else {
            strHtml += "<input type='hidden' name='optSn' value=''>";
            strHtml += "<input type='hidden' name='optDivSn' value=''>";
        }
        var cnt_str = "개";
        var cnt_num = 10;
        var cnt_term = 1;

        if(prdtCd == "${Constant.ACCOMMODATION}") {	// 숙박 상품이면..
            cnt_str = "박";
            cnt_num = 5;
        } else if (prdtCd == "${Constant.RENTCAR}") {	// 렌터카 상품이면..
            cnt_str = "시간";
            cnt_num = 5;
            cnt_term = 24;
        }
        strHtml += "<select name='prdtUseNum'>";

        for(var cnt = 1; cnt <= cnt_num; cnt++) {
            strHtml += "<option value='" + (cnt * cnt_term) + "'>" + (cnt * cnt_term) + " " + cnt_str + "</option>";
        }
        strHtml += "</select> ";
    }
    strHtml += "<input type='hidden' name='prdtNum' value='"+ prdtId + "'/>";
    strHtml += "</li>";

    $("#selectProduct ul").append(strHtml);
}

function getSecondOption(prdtNum, divSn, opt_index, selKey) {
    $("#optSn" + opt_index).empty();

    if(divSn == "") {
        return false;
    }
    var prdtCd = prdtNum.substring(0, 2);

    $.ajax({
        url: webUrl + prdtCd.toLowerCase() + "/getOptionList.ajax",
        data: "prdtNum=" + prdtNum + "&" + prdtCd.toLowerCase() + "DivSn=" + divSn + "&aplDt=",
        success:function(data) {
            var optionStr = "<option value=''>옵션 선택</option>";

            $.each(data.list, function(){
                var opt_key = (prdtCd == "${Constant.SOCIAL}") ? this.spOptSn : this.svOptSn;
                optionStr += "<option value='" + opt_key + "'";

                if(selKey == opt_key) {
                    optionStr += " selected";
                }
                optionStr += ">" + this.optNm;

                if((this.stockNum > 0 && this.ddlYn == "N") == false) {
                    optionStr += " [품절]";
                }
                optionStr += "</option>";
            });

            $("#optSn" + opt_index).append(optionStr);
        },
        error: fn_AjaxError
    });
}
// 쿠폰코드 생성
function fn_getCpCode() {
    var code = "";

    for(var i=0; i<10; i++) {
        var rndVal = Math.floor(Math.random() * 30);

        if(rndVal < 10) {
            code += rndVal;     // 숫자
        } else {
            code += String.fromCharCode((Math.random() * 26) + 65);     // 대문자
        }
    }
    $("#cpCode").val(code);
}

$(function(){
    let availableAttributes = new Array();
    <c:forEach items="${resultList}" var="item">
        availableAttributes.push("${item.cpId}" + "|" + "${item.cpNm}" + "|" + "${item.aplStartDt}"+ "~" + "${item.aplEndDt}");
    </c:forEach>

    $("#rCpId").bind("keydown", function(event){

    }).autocomplete({
        source: availableAttributes,
        select : function(event, ui) { // item 선택 시 이벤트
            console.log(ui.item.value);
            let tempStr = ui.item.value.split("|");
            event.preventDefault();
            console.log(tempStr[0]);
            $(this).val(tempStr[0]);
        },
        position: {
        my: "left top",   // 자동완성 목록의 기준점
        at: "left bottom", // 입력 필드 기준점
        collision: "none"  // 뷰포트 경계를 벗어나지 않도록 조정
    }
    });

    $("#aplStartDt").datepicker({
        minDate: "today",
        onClose: function(selectedDate) {
            $("#aplEndDt").datepicker("option", "minDate", selectedDate);
        }
    });

    $("#aplEndDt").datepicker({
        minDate: "today",
        onClose : function(selectedDate) {
            $("#sSaleStartDt").datepicker("option", "maxDate", selectedDate);
        }
    });
	
	<c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_TYPE}">
		//적용상품
        var check_prdtCtgrList = "${cpVO.prdtCtgrList}";
        var split_prdtCtgrList = check_prdtCtgrList.split(",");
        for(var idx in split_prdtCtgrList) {
            $("input[name=prdtCtgrList][value=" + split_prdtCtgrList[idx] + "]").attr("checked", true);
        }
	</c:if>
	
    //구매상품
    var check_buyCtgrList = "${cpVO.buyCtgrList}";
    if (check_buyCtgrList !== "") {
        var split_buyCtgrList = check_buyCtgrList.split(",");
        for (var idx in split_buyCtgrList) {
            $("input[name=buyCtgrList][value=" + split_buyCtgrList[idx] + "]").attr("checked", true);
        }
    }
    
	$("#selectUser").on("click", ".del", function() {
		$(this).parents("li").remove();
	});
	
	$("#selectProduct").on("click", ".del", function() {
		$(this).parents("li").remove();

		var prdtNumList = [];

		$("input[name='prdtNum']").each(function () {
			prdtNumList.push($(this).val());
		});
		$("#prdtNumList").val(prdtNumList.toString());
	});
	
	$("#disDivPrice").click(function(){
        $("#disAmt").val(0).removeClass("disabled").attr("readonly", false);
        $("#aplPctBtn").removeClass("disabled");
        $("#disPct").val(0).addClass("disabled").attr("readonly", true);
        $("#aplprdtDivType").removeClass("disabled").attr("disabled", false);
		
		if("${cpVO.disDiv}" != "${Constant.CP_DIS_DIV_PRICE}") {
			$("#disAmt").val(0);
		} else {
			$("#disAmt").val("${cpVO.disAmt}");
		}
	});
	
	$("#disDivRate").click(function(){
        $("#disAmt").val(0).addClass("disabled").attr("readonly", true);
        $("#aplPctBtn").addClass("disabled");
        $("#disPct").val(0).removeClass("disabled").attr("readonly", false);
        $("#aplprdtDivType").removeClass("disabled").attr("disabled", false);
		
		if ("${cpVO.disDiv}" != "${Constant.CP_DIS_DIV_RATE}") {
			$("#disPct").val(0);
		} else {
			$("#disPct").val("${cpVO.disPct}");
		}
	});
	
	$('#disDivFree').click(function() {
        $("#disAmt").val(0).addClass("disabled").attr("readonly", true);
        $("#aplPctBtn").addClass("disabled");
        $("#disPct").val(0).addClass("disabled").attr("readonly", true);
        $("#aplprdtDivType").addClass("disabled").attr("disabled", true);
        $("#aplprdtDivCorp").addClass("disabled").attr("disabled", true);
        $("#aplprdtDivPrdt").prop("checked", true).click();
	});
	
	$("#aplprdtDivType").click(function() {
        $("#selTypeBtn").show();
        $("#selPrdtBtn").hide();
        $("#selectProduct").hide();
        $("#selCorpBtn").hide();
        $("#selectCorp").hide();
	});	
	$("#aplprdtDivPrdt").click(function() {
        $("#selTypeBtn").hide();
        $("#selPrdtBtn").show();
        $("#selectProduct").show();
        $("#selCorpBtn").hide();
        $("#selectCorp").hide();
	});

    /** 적용상품 : 업체지정 추가 2024. 10. 31 chaewan.jung*/
    $("#aplprdtDivCorp").click(function () {
        $("#selTypeBtn").hide();
        $("#selPrdtBtn").hide();
        $("#selectProduct").hide();
        $("#selCorpBtn").show();
        $("#selectCorp").show();
    });

    $("#selectCorp").on("click", ".del", function () {
        $(this).parents("li").remove();
        var corpIdList = [];

        $("input[name='corpNum']").each(function () {
            corpIdList.push($(this).val());
        });
        $("#corpIdList").val(corpIdList.toString());
    });

	if("${cpVO.disDiv}" == "${Constant.CP_DIS_DIV_PRICE}") {
	    $("#disDivPrice").click();
    } else if("${cpVO.disDiv}" == "${Constant.CP_DIS_DIV_RATE}") {
	    $("#disDivRate").click();
    } else if("${cpVO.disDiv}" == "${Constant.CP_DIS_DIV_FREE}") {
	    $("#disDivFree").click();
    }
	
	if("${cpVO.aplprdtDiv}" == "${Constant.CP_APLPRDT_DIV_TYPE}") {
	    $("#aplprdtDivType").click();
    } else if ("${cpVO.aplprdtDiv}" == "${Constant.CP_APLPRDT_DIV_PRDT}") {
	    $("#aplprdtDivPrdt").click();
    } else if ("${cpVO.aplprdtDiv}" == "${Constant.CP_APLPRDT_DIV_CORP}") {
        $("#aplprdtDivCorp").click();
    }
	
	<c:forEach var="prdt" items="${cpPrdtList}" varStatus="status">
        <c:set var="prdtCd" value="${fn:substring(prdt.prdtNum, 0, 2)}" />

        <c:if test="${(prdtCd eq Constant.SOCIAL) or (prdtCd eq Constant.SV)}">
            // 소셜 & 기념품의 상품 select
            $.ajax({
                url: "<c:url value='/web/${fn:toLowerCase(prdtCd)}/getDivInfList.ajax' />",
                data: "prdtNum=${prdt.prdtNum}",
                success:function(data) {
                    var optionStr = "<option value=''>상품 선택</option>";

                    $.each(data.list, function() {
                        var opt_key = "${prdtCd }" == "${Constant.SOCIAL}" ? this.spDivSn : this.svDivSn;
                        optionStr += "<option value='" + opt_key + "'";

                        if(opt_key == "${prdt.optDivSn }") {
                            optionStr += " selected";
                        }
                        optionStr += ">" + this.prdtDivNm + "</option>";
                    });

                    $("#optDivSn${status.index }").append(optionStr);
                },
                error: fn_AjaxError
            });
            //소셜 & 기념품의 옵션 select
            getSecondOption("${prdt.prdtNum }", "${prdt.optDivSn }", "${status.index }", "${prdt.optSn}");
        </c:if>
    </c:forEach>

    $("#limitType").change(function(){
        if($(this).val() == "UNLI") {
            $("#spanLimitCnt").hide();
            $("#limitCnt").val("0");
        } else {
            $("#spanLimitCnt").show();
        }
    });

    if(${cpVO.limitType == "UNLI"}) {
        $("#spanLimitCnt").hide();
    }
});

let corp_pop;
function fn_viewSelectCorp() {
    corp_pop = window.open("<c:url value='/oss/findCorp.do'/>","findCorp", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectCorp(corpId, corpNm, corpCd, corpAliasNm){
    var isA = true;

    $("input[name='corpNum']").each(function(){
        if($(this).val() == corpId) {
            isA = false;
            return;
        }
    });

    if(isA == false) {
        corp_pop.alert("<spring:message code='errors.common.exist' />");
        return;
    }

    const corpCdMap = {
        "AD": "숙소",
        "SV": "특산/기념품",
        "SP": "소셜상품",
        "RC": "렌트카"
    };
    let corpCdNm = corpCdMap[corpCd] || "";

    var strHtml = "<li>";
    strHtml += "<a href='javascript:void(0)'><span class='del'><img src='/images/web/icon/close5.gif' alt='삭제'></span></a> ";
    strHtml += "[" + corpId + "] [" + corpNm + "] [" + corpCdNm + "] ";
    strHtml += "<input type='hidden' name='corpNum' value='"+ corpId + "'/>";
    strHtml += "</li>";

    $("#selectCorp ul").append(strHtml);
}
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=coupon" />

		<div id="contents_area">
            <div id="contents">
                <h4 class="title03">쿠폰 수정</h4>

                <form:form commandName="CPVO" name="CPVO" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="cpId" id="cpId" value="${cpVO.cpId}"/>
                    <input type="hidden" name="cpDiv" id="cpDiv" value="${cpVO.cpDiv}"/>

                    <table border="1" class="table02">
                        <colgroup>
                            <col width="200" />
                            <col width="*" />
                            <col width="200" />
                            <col width="*" />
                        </colgroup>
                        <tr>
                            <th>쿠폰 ID</th>
                            <td>${cpVO.cpId}</td>
                            <th>발행 상태</th>
                            <td>
                                <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_READY}">
                                    발행대기
                                </c:if>
                                <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_COMPLETE}">
                                    발행완료
                                </c:if>
                                <form:hidden path="statusCd" value="${cpVO.statusCd}" />
                            </td>
                        </tr>
                        <tr>
                            <th>쿠폰명<span class="font02">*</span></th>
                            <td colspan="3">
                                <form:input path="cpNm" class="width35" value="${cpVO.cpNm}" disabled="${cpVO.statusCd eq Constant.STATUS_CD_COMPLETE ? true : false}" />
                            </td>
                        </tr>
                        <c:if test="${cpVO.statusCd ne Constant.STATUS_CD_COMPLETE}">
                            <tr>
                                <th>간략 설명</th>
                                <td colspan="3"><textarea name="simpleExp" id="simpleExp" rows="3"  style="width:97%">${cpVO.simpleExp}</textarea></td>
                            </tr>
                            <tr>
                                <th>적용 기간<span class="font02">*</span></th>
                                <td colspan="3">
                                    <form:input path="aplStartDt" class="input_text4 center"  title="적용시작일" readonly="true" value="${fn:substring(cpVO.aplStartDt,0,4)}-${fn:substring(cpVO.aplStartDt,4,6)}-${fn:substring(cpVO.aplStartDt,6,8)}" />
                                     ~ <form:input path="aplEndDt" class="input_text4 center" title="적용종료일" readonly="true" value="${fn:substring(cpVO.aplEndDt,0,4)}-${fn:substring(cpVO.aplEndDt,4,6)}-${fn:substring(cpVO.aplEndDt,6,8)}"  />
                                </td>
                            </tr>
                            <tr>
                                <th>정산<span class="font02">*</span></th>
                                <td>
                                    <input type="radio" name="outsideSupportDiv" id="outsideSupportDivY" value="${Constant.FLAG_Y}" <c:if test="${cpVO.outsideSupportDiv eq Constant.FLAG_Y}">checked</c:if>> 지원</input>&nbsp;
                                    <input type="radio" name="outsideSupportDiv" id="outsideSupportDivN" value="${Constant.FLAG_N}" <c:if test="${cpVO.outsideSupportDiv eq Constant.FLAG_N}">checked</c:if>> 미지원</input>
                                </td>
                                <th>업체할인부담금<span class="font02">*</span></th>
                                <td>
                                    <form:input path="corpDisAmt" id="corpDisAmt" class="input_text4 right numFormat" value="${cpVO.corpDisAmt}"/> 원
                                </td>
                            </tr>
                            <tr>
                                <th>할인 방식<span class="font02">*</span></th>
                                <td colspan="3">
                                    <input type="radio" name="disDiv" id="disDivPrice" value="${Constant.CP_DIS_DIV_PRICE}" <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_PRICE}">checked</c:if>> 금액</input>&nbsp;
                                    <form:input path="disAmt" id="disAmt" class="input_text4 right numFormat" value="${cpVO.disAmt}"/> 원&nbsp;
                                    <input type="radio" name="disDiv" id="disDivRate" value="${Constant.CP_DIS_DIV_RATE}" <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_RATE}">checked</c:if>> 할인율</input>&nbsp;
                                    <form:input path="disPct" id="disPct" class="input_text4 right" value="${cpVO.disPct}"/> %&nbsp;
                                    <input type="radio" name="disDiv" id="disDivFree" value="${Constant.CP_DIS_DIV_FREE}" <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_FREE}">checked</c:if>> 무료 (특정 상품에 대한 무료 이용)</input>
                                </td>
                            </tr>
                            <tr>
                                <th>구매 최소금액</th>
                                <td colspan="3">
                                    <form:input path="buyMiniAmt" id="buyMiniAmt" class="input_text10 right numFormat" value="${cpVO.buyMiniAmt}"/> 원
                                </td>
                            </tr>
                            <tr>
	                            <th>할인 최대금액(할인율)</th>
	                            <td colspan="3">
	                                <form:input path="limitAmt" id="limitAmt" class="input_text10 right numFormat" value="${cpVO.limitAmt}"/> 원&nbsp;&nbsp;(* 할인율 적용 및 금액이 0원 이상일 경우 적용됩니다.)
	                            </td>
	                        </tr>
                            <tr>
                                <th rowspan="3">적용 상품<span class="font02">*</span></th>
                                <td>
                                <input type="radio" name="aplprdtDiv" id="aplprdtDivType" value="${Constant.CP_APLPRDT_DIV_TYPE}" <c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_TYPE}">checked</c:if>>
                                    <label for="aplprdtDivType">유형지정</label>
                                    <span id="selTypeBtn">
                                        (&nbsp;
                                            <input type="checkbox" name="prdtCtgrList" value="AD" style="" /> 숙소
                                            <input type="checkbox" name="prdtCtgrList" value="RC" style="" /> 렌트카
                                            <input type="checkbox" name="prdtCtgrList" value="C100" style="" /> 여행사 상품
                                            <input type="checkbox" name="prdtCtgrList" value="C200" style="" /> 관광지/레져
                                            <input type="checkbox" name="prdtCtgrList" value="C300" style="" /> 맛집
                                            <input type="checkbox" name="prdtCtgrList" value="C400" style="" /> 여행사 단품
                                            <input type="checkbox" name="prdtCtgrList" value="C500" style="" /> 유모차/카시트
                                            <input type="checkbox" name="prdtCtgrList" value="SV" style="" /> 특산/기념품
                                        )
                                    </span>
                                </td>
                                <th rowspan="2">구매 상품<span class="font02">*</span></th>
                                <td>
                                    <input type="radio" name="aplprdtDiv2" id="aplprdtDivType2" checked>
                                    <label for="selTypeBtn2">유형지정</label>
									<span id="selTypeBtn2">
										<input type="checkbox" name="buyCtgrList" value="AD" style="" /> 숙소
                                        <input type="checkbox" name="buyCtgrList" value="RC" style="" /> 렌트카
                                        <input type="checkbox" name="buyCtgrList" value="C100" style="" /> 여행사 상품
                                        <input type="checkbox" name="buyCtgrList" value="C200" style="" /> 관광지/레져
                                        <input type="checkbox" name="buyCtgrList" value="C300" style="" /> 맛집
                                        <input type="checkbox" name="buyCtgrList" value="C400" style="" /> 여행사 단품
                                        <input type="checkbox" name="buyCtgrList" value="C500" style="" /> 유모차/카시트
                                        <input type="checkbox" name="buyCtgrList" value="SV" style="" /> 특산/기념품
									</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="radio" name="aplprdtDiv" id="aplprdtDivPrdt" value="${Constant.CP_APLPRDT_DIV_PRDT}" <c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_PRDT}">checked</c:if>>
                                    <label for="aplprdtDivPrdt">상품지정</label>
                                    <span id="selPrdtBtn">
                                        <div class="btn_sty04">
                                            <span><a href="javascript:void(0);" onclick="javascript:fn_viewSelectProduct();">실시간상품 검색</a></span>
                                        </div>
                                        <div class="btn_sty04">
                                            <span><a href="javascript:void(0);" onclick="javascript:fn_viewSelectSpProduct();">소셜상품 검색</a></span>
                                        </div>
                                        <div class="btn_sty04">
                                            <span><a href="javascript:void(0);" onclick="javascript:fn_viewSelectSvProduct();">기념품 검색</a></span>
                                        </div>
                                    </span>
                                    <div id="selectProduct">
                                        <ul>
                                            <c:forEach var="prdt" items="${cpPrdtList }" varStatus="status" >
                                                <li>
                                                    &nbsp;&nbsp;<a href="javascript:void(0)"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
                                                    [ ${prdt.prdtNum} ] [ ${prdt.corpNm} ] [ ${prdt.prdtNm} ]
                                                    <c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                                        <c:set var="prdtCd" value="${fn:substring(prdt.prdtNum, 0, 2)}" />

                                                        <c:if test="${(prdtCd eq Constant.SOCIAL) or (prdtCd eq Constant.SV)}">
                                                            <select name="optDivSn" id="optDivSn${status.index}" onchange="getSecondOption('${prdt.prdtNum}', '${prdt.optDivSn}', '${status.index }', '')">
                                                            </select>&nbsp;
                                                            <select name="optSn" id="optSn${status.index}">
                                                                <option value="">옵션 선택</option>
                                                            </select>&nbsp;
                                                        </c:if>
                                                        <c:if test="${not ((prdtCd eq Constant.SOCIAL) or (prdtCd eq Constant.SV))}">
                                                            <input type="hidden" name="optDivSn" value="">
                                                            <input type="hidden" name="optSn" value="">
                                                        </c:if>

                                                        <c:set var="cnt_str" value="개" />
                                                        <c:set var="cnt_num" value="10" />
                                                        <c:set var="cnt_term" value="1" />

                                                        <c:if test="${prdtCd eq Constant.ACCOMMODATION }">
                                                            <c:set var="cnt_str" value="박" />
                                                            <c:set var="cnt_num" value="5" />
                                                        </c:if>
                                                        <c:if test="${prdtCd eq Constant.RENTCAR }">
                                                            <c:set var="cnt_str" value="시간" />
                                                            <c:set var="cnt_num" value="5" />
                                                            <c:set var="cnt_term" value="24" />
                                                        </c:if>
                                                        <select name="prdtUseNum">
                                                            <c:forEach begin="1" end="${cnt_num}" var="cnt">
                                                                <option value="${cnt * cnt_term}" <c:if test="${cnt eq prdt.prdtUseNum}">selected</c:if> >${cnt * cnt_term} ${cnt_str}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </c:if>
                                                    <input type="hidden" name="prdtNum" value="${prdt.prdtNum}"/>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </td>
                                <td>
                                <input type="radio" name="aplprdtDiv2" id="aplprdtDiv2" value="${Constant.CP_APLPRDT_DIV_PRDT}">
                                <label for="aplprdtDiv2">쿠폰지정</label>
                                <input id="rCpId" name="rCpId" class="input_text4 width40" type="text" value="${cpVO.rCpId}" autocomplete="on">
                            </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <input type="radio" name="aplprdtDiv" id="aplprdtDivCorp" value="${Constant.CP_APLPRDT_DIV_CORP}" <c:if test="${cpVO.aplprdtDiv eq Constant.CP_APLPRDT_DIV_CORP}">checked</c:if>>
                                    <label for="aplprdtDivCorp">업체지정</label>
                                    <span id="selCorpBtn">
                                    <div class="btn_sty04">
                                        <span><a href="javascript:void(0);" onclick="javascript:fn_viewSelectCorp();">업체 검색</a></span>
                                    </div>
                                </span>
                                    <div id="selectCorp">
                                        <ul>
                                            <c:forEach var="corp" items="${cpCorpList }" varStatus="status" >
                                                <li>
                                                    <a href="javascript:void(0)"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
                                                    [ ${corp.corpId} ] [ ${corp.corpNm} ] [
                                                        <c:if test="${corp.corpCd == 'SV'}">특산/기념품</c:if>
                                                        <c:if test="${corp.corpCd == 'AD'}">숙소</c:if>
                                                        <c:if test="${corp.corpCd == 'RC'}">렌트카</c:if>
                                                        <c:if test="${corp.corpCd == 'SP'}">소셜</c:if>
                                                    ]
                                                    <input type="hidden" name="corpNum" value="${corp.corpId}"/>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>발급 대상</th>
                                <td colspan="3">
                                    <div style="display: inline-block; vertical-align: middle;">
                                        <input type="radio" name="tgtDiv" id="tgtDivAll" value="ALL" <c:if test="${cpVO.tgtDiv eq 'ALL'}">checked</c:if>> 전체</input>&nbsp;
                                        <input type="radio" name="tgtDiv" id="tgtDivVip" value="VIP" <c:if test="${cpVO.tgtDiv eq 'VIP'}">checked</c:if>> VIP</input>&nbsp;
                                        <input type="radio" name="tgtDiv" id="tgtDivBest" value="BEST" <c:if test="${cpVO.tgtDiv eq 'BEST'}">checked</c:if>> 우수고객</input>
                                    </div>
                                    <div class="btn_sty04" style="display: inline-block; vertical-align: middle;">
                                        <span><a href="javascript:void(0);" onclick="javascript:fn_FindUser();">사용자 검색</a></span>
                                    </div>
                                    <div id="selectUser">
                                        <ul>
                                            <c:forEach items="${userList}" var="data">
                                                <li>
                                                    <input type="hidden" name="userId" value="${data.userId}" />
                                                    &nbsp;&nbsp;<a href="javascript:void(0)"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
                                                    [${data.userId}] [${data.userNm}] [${data.telNum}] [${data.email}]
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>쿠폰 코드</th>
                                <td colspan="3">
                                    <div style="display:inline-block; vertical-align: middle;">
                                        <input type="text" name="cpCode" id="cpCode" class="input_text12" value="${cpVO.cpCode}" />
                                    </div>
                                    <div style="display:inline-block; vertical-align: middle;">
                                        <span class="btn_sty04"><a href="javascript:void(0);" onclick="javascript:fn_getCpCode();">코드 생성</a></span>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <th>수량 제한 타입</th>
                            <td colspan="3">
                                <select name="limitType" id="limitType" <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_COMPLETE}">disabled</c:if>>
                                    <c:forEach var="limitType" items="${limitTypeList}">
                                        <option value="${limitType.cdNum}" <c:if test="${limitType.cdNum == cpVO.limitType}">selected</c:if>>${limitType.cdNm}</option>
                                    </c:forEach>
                                </select>
                                <span id="spanLimitCnt"> [ 제한 수량 <form:input path="limitCnt" id="limitCnt" class="input_text3 right numFormat" value="${cpVO.limitCnt}" /> ]</span>
                            </td>
                        </tr>
                        <c:if test="${cpVO.statusCd eq Constant.STATUS_CD_COMPLETE}">
                            <tr>
                                <th>발급 수량</th>
                                <td>${cpVO.issueCnt}</td>
                                <th>사용 수량</th>
                                <td>${cpVO.useCnt}</td>
                            </tr>
                        </c:if>
                        <tr>
                            <th>등록시각</th>
                            <td>${cpVO.regDttm} [ ${cpVO.regId} ]</td>
                            <th>수정시각</th>
                            <td>${cpVO.modDttm} [ ${cpVO.modId} ]</td>
                        </tr>
                    </table>
                </form:form>

                <ul class="btn_rt01 align_ct">
                    <li class="btn_sty04"><a href="javascript:void(0);" onclick="javascript:fn_updateCoupon();">저장</a></li>
                    <li class="btn_sty01"><a href="javascript:history.back();">뒤로</a></li>
                </ul>
            </div>
        </div>
	<!--//Contents 영역--> 
    </div>
</div>
</body>
</html>
		