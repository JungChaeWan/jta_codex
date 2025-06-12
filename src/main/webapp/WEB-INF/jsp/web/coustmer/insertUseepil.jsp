<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
 


<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">

/* 중복 SUBMIT 방지 */
var doubleSubmitFlag = false;

$(document).ready(function() {
    //상품 선택 시 유형 동적 변경
    $('#prdtInf').change(function() {
        const selectedValue = $(this).val();

        //초기화
        $('#reviewType').empty();
        $('#reviewType').append('<option value="">-선택하세요-</option>');

        if (selectedValue !== "") {
            const arrValue = selectedValue.split(',');
            const hrkCode = arrValue[1].substring(0,2) + "RV";

            $.ajax({
                url     : "<c:url value='/web/cmm/getReviewType.ajax'/>",
                data    : "hrkCode=" + hrkCode,
                dataType: "json",
                success : function (data) {
                    $.each(data.reviewTypeList, function(index, item) {
                        $('#reviewType').append('<option value="' + item.cdNum + '">' + item.cdNm + '</option>');
                    });
                },
                error: function(xhr, status, error) {
                    console.log("AJAX Error: " + error);
                }
            })
        }
    })
})

function doubleSubmitCheck() {
    if(doubleSubmitFlag) {
        return doubleSubmitFlag;
    } else {
        doubleSubmitFlag = true;
        return false;
    }
}

function fn_useepilChageLike(nGpa){
	var i=0;
	for(i=1; i<=5 ;i++){
		if(i <= nGpa){
			$("#ue_like"+i).attr("src", "<c:url value='/images/web/icon/star_on.png'/>" );
		}else{
			//console.log("#ue_like"+i +"<="+ nGpa + ":x");
			$("#ue_like"+i).attr("src", "<c:url value='/images/web/icon/star_off.png'/>" );
		}
	}
	$("#gpa").val(nGpa);
}


function fn_Ins(){

    if(doubleSubmitFlag) {
        return;
    }

	//입력 검사
	if(document.frm.prdtInf.value.length==0){
		alert("상품을 선택 하세요.");
		document.frm.prdtInf.focus();
		return;
	}

	if(document.frm.gpa.value==0){
		alert("평점을 선택 하세요.");
		return;
	}

    if(document.frm.reviewType.value.length==0){
        alert("유형을 선택 하세요.");
        document.frm.reviewType.focus();
        return;
    }

	if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
	//if($("#contents").val().length == 0){
	if(document.frm.contents.value.length==0){
		alert("이용 후기를 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.frm.contents.value.length >= 500){
		alert("이용 후기의 길이는 500자 이하 입니다.");
		document.frm.contents.focus();
		return;
	}

    doubleSubmitCheck();
	document.frm.action = "<c:url value='/web/coustmer/insertUseepil.do'/>";
	document.frm.submit();
		
}
</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>고객센터</span> <span class="gt">&gt;</span>
                <span>이용후기</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="service-center sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                            	<jsp:include page="/web/coustmer/left.do?menu=otoinq" flush="false"></jsp:include>
                            
                                <div class="rContents smON">
                                    <h3 class="mainTitle">이용후기</h3>
                                    <!--<form:form commandName="frm" name="frm" method="post" enctype="multipart/form-data" onSubmit="return false;">-->
                                    <form name="frm" method="post" onSubmit="return false;" enctype="multipart/form-data" >
                                   	<div class="commBoard-wrap">

                                        <!-- 리뷰 프로모션 배너롤링 -->
                                        <div class="review_content__banner">
                                            <div class="main-top-slider">
                                                <div id="main_top_slider" class="swiper-container swiper-container-horizontal">
                                                    <ul class="swiper-wrapper">
                                                        <li class="swiper-slide">
                                                            <div class="Fasten">
                                                                <a href="https://m.site.naver.com/1CMBk" target="_blank">
                                                                    <img src="/images/web/mypage/review_banner.png" alt="리뷰이벤트">
                                                                </a>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <div id="main_top_navi" class="swiper-pagination"></div>
                                                </div>
                                            </div> <!-- //top-slider -->
                                        </div>

                                        <div class="cmTitle-group">
                                            <p class="cmTitle">* 주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</p>
                                            <p class="cmTitle">* 고객님께서 상품을 이용하신 후 2개월 내 등록이 가능합니다.</p>
                                        </div>
                                        <div class="board-write">                                            
                                            <table class="commRow">
                                                <tbody>
                                                    <tr>
                                                        <th>상품</th>
                                                        <td class="category">
                                                            <ul class="ctOption">
                                                                <!--불필요한 카테고리는 삭제-->
                                                                <li>
                                                                	<c:if test="${fn:length(rsvepilList) == 0}">
                                                                		<!-- 이용후기 작성은 고객님께서 상품을 이용하신 후에 작성하실 수 있습니다.
                                                                		<input type="hidden" id="prdtInf" name="prdtInf" maxlength="50"> -->
                                                                		
                                                                		<select id="prdtInf" name="prdtInf" onclick="alert('이용후기 작성은 고객님께서 상품을 이용하신 후에 작성하실 수 있습니다.');">
	                                                                    	<option value="">-선택하세요-</option>
	                                                                    </select>
                                                                	</c:if>

																	<c:if test="${fn:length(rsvepilList) != 0}">
	                                                                    <select id="prdtInf" name="prdtInf">
	                                                                    	<option value="">-선택하세요-</option>
	                                                                    	<c:forEach var="data" items="${rsvepilList}" varStatus="status">
	                                                                    		<option value="${data.corpId},${data.prdtNum},${data.prdtRsvNum}" <c:if test="${param.sPrdtNum eq data.prdtRsvNum}">selected="selected"</c:if> >${data.dpNm }</option>
	                                                                    	</c:forEach>
	                                                                    </select>
	                                                               </c:if>
<%--                                                                    <c:if test="${userInfo.authNm eq 'ADMIN'}">
                                                                        <select id="prdtInf" name="prdtInf">
                                                                            <option value="${param.corpId},${param.prdtnum},' '">상품번호 : ${param.prdtnum} </option>
                                                                        </select>
                                                                    </c:if>--%>
                                                                </li>
                                                            </ul>                                                            
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>좋아요</th>
                                                        <td>
                                                            <div class="like">
                                                            	<a href="javascript:fn_useepilChageLike(1)"><img id="ue_like1" src="<c:url value='/images/web/icon/star_on.png'/>" alt="좋아요"></a>
													            <a href="javascript:fn_useepilChageLike(2)"><img id="ue_like2" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
													            <a href="javascript:fn_useepilChageLike(3)"><img id="ue_like3" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
													            <a href="javascript:fn_useepilChageLike(4)"><img id="ue_like4" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
													            <a href="javascript:fn_useepilChageLike(5)"><img id="ue_like5" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
													            <input type="hidden" name="gpa" id="gpa" value="0" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>유형</th>
                                                        <td class="category">
                                                            <ul class="ctOption">
                                                                <li>
                                                                    <select id="reviewType" name="reviewType">
                                                                        <option value="">-선택하세요-</option>
                                                                        <c:forEach items="${cdRvtp}" var="rvtp" varStatus="status">
                                                                            <%--<c:if test="${rvtp.cdNum eq data.rvtp}">selected="selected"</c:if>--%>
                                                                            <option value="${rvtp.cdNum}"  >${rvtp.cdNm }</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>제목</th>
                                                        <td class="title">
                                                            <input type="text" id="subject" name="subject" placeholder="최대 50자 까지 자유롭게 입력가능하십니다." maxlength="50">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>내용</th>
                                                        <td class="memo">
                                                            <textarea placeholder="한글 500자까지 자유롭게 입력가능하십니다." id="contents" name="contents" maxlength="500"></textarea>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    	<th>이미지</th>
                                                    	<td class="attachments">
                                                    		<c:forEach var="i" begin="1" end="5">
                                                    		<p class="file"><input type="file" name="img${i}" accept="image/*"></p>
                                                    		</c:forEach>
                                                    		<p class="label">* 이미지는 5개까지 첨부 가능 합니다.</p>
                                                    	</td>
                                                    </tr>
                                                    <%--
                                                    <tr>
                                                        <th>답변수단선택</th>
                                                        <td>
                                                            <input id="re_email" type="radio" name="answer"><label for="re_email">E-mail로 답변받기</label>
                                                            <input id="re_sms" type="radio" name="answer"><label for="re_sms">E-mail+SMS 알림수신 받기</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>답변 받으실 E-mail</th>
                                                        <td class="email">
                                                            <input id="member_email" type="text">
                                                            <span>@</span>
                                                            <select id="mail_option">
                                                                <option value="">선택하세요</option>
                                                                <option value="">네이트</option>
                                                            </select>
                                                            <!--직접입력시-->
                                                            <!--<input id="member_email_last" class="mgL commWidth" type="text">-->                                                            
                                                            <input id="directly" class="mgL" type="checkbox"><label for="directly">직접입력</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>연락 받으실 휴대폰</th>
                                                        <td class="phone-number">
                                                            <select id="phone" class="phone">
                                                                <option value="">010</option>
                                                            </select>
                                                            <input class="phone" type="text">
                                                            <input class="phone" type="text">
                                                        </td>
                                                    </tr>
                                                     --%>
                                                </tbody>
                                            </table>
                                            <div class="boardBT2 comm-button2">
                                                <a class="color1" onclick="fn_Ins()">확인</a>
                                                <a class="color0" href="javascript:history.back();">취소</a>
                                            </div>
                                        </div> <!--//board-write-->
                                    </div> <!--//commBoard-wrap-->
                                    </form:form>

                                </div> <!--//rContents-->
                                
								
                                
                                 
                                
                                
                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>