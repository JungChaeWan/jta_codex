<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
    <jsp:include page="/web/includeJs.do" />
    <jsp:useBean id="today" class="java.util.Date" />
    <fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/main4.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>" />
</head>
<html>
<body>

<!-- 포인트 등록/레이어 팝업 -->
<div class="couponRegPop_2 pop-seller2">
    <div class="content-wrap">
        <div class="head">
            <a href="javascript:close_popup($('.couponRegPop_2'));" class="btn-close2" >
                <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
            </a>
            <h2>포인트 등록</h2>
        </div>
        <div class="main">
            <form name="frmPop" id="frmPop">
                <input type="hidden" name="partnerCode" value="${ssPartnerCode}">
                <input type="hidden" name="plusMinus" value="P">
                <input type="hidden" name="typesContent" value="">
                쿠폰번호 : <input type="text" name="cpNum" >
                <a href="javascript:fn_CouponReg()">등록</a>
            </form>
            <div class="pop-article">
                <ul>
                    <li>* 포인트 등록 시 철회가 불가능합니다.</li>
                    <li>* 포인트는 1회만 적립 가능합니다.</li>
                    <li>* 취소 수수료 부과 시 수수료 적용 순서는 아래와 같습니다.</li>
                    <li>포인트 → 결제금액 → 쿠폰 (수수료 발생 시 포인트부터 차감)</li>
                </ul>
            </div>
        </div>
    </div>
</div> <!--//포인트 등록/레이어 팝업-->

<script type="text/javascript">
    function fn_CouponReg(){
        //포인트, 수량 number 체크
        $.ajax({
            type:"post",
            url:"/web/point/couponReg.ajax",
            data: $("#frmPop").serialize(),
            dataType: "json",
            success:function(data){
                if (data.success == "Y"){
                    alert('쿠폰이 정상적으로 등록 되었습니다.');
                    location.reload();
                    //close_popup($('.couponRegPop_2'));
                }else{
                    if (data.success == "CP_NONE") {
                        alert('쿠폰번호가 존재하지 않습니다.');
                    }else if(data.success == "CP_USE"){
                        alert('해당 판매처의 포인트를 이미 등록하였습니다.');
                    }else if(data.success == "APL_NONE"){
                        alert('판매처의 포인트를 입력 가능 기간이 아닙니다.');
                    }else{
                        alert('알수 없는 오류로 등록에 실패 하였습니다.');
                    }
                    return;
                }
            },
            error : fn_AjaxError
        });
    }
</script>
</body>
</html>