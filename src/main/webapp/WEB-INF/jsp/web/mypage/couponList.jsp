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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<%--
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />
--%>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>마이페이지</span> <span class="gt">&gt;</span>
            <span>나의 혜택정보</span> <span class="gt">&gt;</span>
            <span>탐나오쿠폰 내역</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" />
    <!-- //quick banner -->
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents">
            <!-- new contents -->
            <div class="mypage sideON">
                <div class="bgWrap2">
                    <div class="inner">
                        <div class="tbWrap">
                            <jsp:include page="/web/mypage/left.do?menu=coupon" />

                            <div class="rContents smON">
                                <h3 class="mainTitle">탐나오쿠폰 내역</h3>

                                <%--탐나오쿠폰 코드--%>
                                <form name="frm" method="post" onsubmit="return false;">
                                    <input type="hidden" name="cpNum" id="cpNum" />
                                    <input type="hidden" name="cpId" id="cpId" />

                                    <c:forEach var="result" items="${resultList}" varStatus="status">
                                        <%--코드 등록 전 쿠폰--%>
                                        <c:if test="${not empty result.cpCode and empty result.useYn}">
                                            <article class="comm-art3-record">
                                                <div class="sale-code">${result.cpNm} 쿠폰코드 입력</div>
                                                <p class="title-type3">
                                                    <input type="text" name="code" id="code${status.index}" class="width40" placeholder="쿠폰 코드" />
                                                    <button class="comm-btn gray" onclick="fn_couponCode('${result.cpNum}', '${result.cpId}', ${status.index});">입력</button>
                                                </p>
                                            </article>
                                        </c:if>
                                    </c:forEach>
                                </form>

								 <!-- 컨텐츠 없을 시에도 ul 부분은 유지 -->
                                 <ul class="order_lst">
                                     <li class="commCo2 list_tb myPoint2">
                                         <div class="in-td myPoin2__col1">쿠폰명</div>
                                         <div class="in-td myPoin2__col2">할인</div>
                                         <div class="in-td myPoin2__col3">사용대상/조건</div>
                                         <div class="in-td myPoin2__col4">유효기간</div>
                                         <div class="in-td myPoin2__col5">상태</div>
                                     </li>

	                                 <li class="commCo2 list_tb tbOption no_coupon">
                                     <c:forEach var="result" items="${resultList}" varStatus="status">
                                         <fmt:parseNumber var="limitCnt" value="${result.limitCnt}" />
                                         <fmt:parseNumber var="issueCnt" value="${result.issueCnt}" />
                                         <fmt:parseNumber var="useCnt" value="${result.useCnt}" />
                                         <c:set var="usableYn" value="Y" />
                                         <c:if test="${result.limitType eq 'USAG'}">
                                             <c:if test="${limitCnt <= useCnt}">
                                                 <c:set var="usableYn" value="N" />
                                             </c:if>
                                         </c:if>
                                         <c:if test="${result.limitType eq 'ISSU'}">
                                             <c:if test="${limitCnt <= issueCnt and result.cpNum eq 'ALL' }">
                                                 <c:set var="usableYn" value="N" />
                                             </c:if>
                                             <%--이미받은쿠폰--%>
                                             <c:if test="${result.cpNum ne 'ALL'}">
                                                 <c:set var="usableYn" value="Y" />
                                             </c:if>
                                         </c:if>
										<div class="goods_brand">
											<div class="goods_row">
                                                 <%--코드 등록전 쿠폰 제외--%>
                                             <c:if test="${(empty result.cpCode) or (not empty result.cpCode and not empty result.useYn)}">
                                                 <%-- 수량무제한, 수량이 unlimited, 제한수량보다 발급수량이 적을 때, 제한수량보다 사용수량이 적을 때   --%>
                                                 <%--<c:if test="${(empty result.limitType) or (result.limitType eq 'UNLI') or (result.useYn eq 'Y')}">--%>
                                                 <tr <c:if test="${(result.cpNum eq 'ALL') and (usableYn eq 'N')}">class="hide"</c:if>>
                                                     <div class="in-td myPoin2__col1 table-heght">
                                                         <div class="coupon-name">${result.cpNm}</div>
                                                     </div>
                                                     <div class="in-td myPoin2__col2 table-heght">
                                                         <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                                             <div class="sale-price"><fmt:formatNumber value="${result.disAmt}" type="number" /><span>원</span></div>
                                                         </c:if>
                                                         <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                                             <div class="sale-price">${result.disPct} %</div>
                                                         </c:if>
                                                         <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                                             <span class="coupon-info"><strong>무료</strong></span>
                                                         </c:if>
                                                     </div>
                                                     <div class="in-td myPoin2__col3 table-heght text-set">
                                                         <div class="left couponDetail">
                                                             <c:if test="${empty result.prdtCtgrList}">
                                                                 <c:if test="${empty result.aplprdtDiv}">
                                                                     <c:choose>
                                                                         <c:when test="${result.cpDiv == 'ACNR'}">
                                                                             <h5 class="product">항공, 제주특산/기념품을 제외한 모든 상품</h5>
                                                                         </c:when>
                                                                         <c:when test="${result.cpDiv == 'ACNV'}">
                                                                             <h5 class="product">제주특산/기념품</h5>
                                                                         </c:when>
                                                                         <c:otherwise>
                                                                             <h5 class="product">항공을 제외한 모든 상품</h5>
                                                                         </c:otherwise>
                                                                     </c:choose>
                                                                 </c:if>
                                                                 <c:if test="${result.aplprdtDiv eq 'AP02'}">
                                                                     <h5 class="product _couponDetail ">${productMap[result.cpId]}</h5>
                                                                     <div class="grayspace"></div>
                                                                     <div class="show-more">
                                                                         <span class="show-more">...더 보기</span>
                                                                     </div>
                                                                 </c:if>
                                                                 <c:if test="${result.aplprdtDiv eq 'AP03'}">
                                                                     <h5 class="product _couponDetail ">${productMap[result.cpId]}</h5>
                                                                     <div class="grayspace"></div>
                                                                     <div class="show-more">
                                                                         <span class="show-more">...더 보기</span>
                                                                     </div>
                                                                 </c:if>
                                                             </c:if>
                                                             <c:if test="${not empty result.prdtCtgrList}">
                                                                 <c:set var="prdtCtgrCnt" value="${fn:split(result.prdtCtgrList, ',')}" />
                                                                 <c:if test="${fn:length(prdtCtgrCnt) == 8}">
                                                                     <h5 class="product">항공을 제외한 모든 상품</h5>
                                                                 </c:if>
                                                                 <c:if test="${fn:length(prdtCtgrCnt) < 8}">
                                                                     <c:set var="ctgr" value="${fn:replace(result.prdtCtgrList, Constant.ACCOMMODATION, '숙소')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.RENTCAR, '렌터카')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_PACKAGE, '여행사 상품')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_TOUR, '관광지/레져')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_ETC, '맛집')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_ADRC, '여행사 단품')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.CATEGORY_BACS, '유모차/카시트')}"/>
                                                                     <c:set var="ctgr" value="${fn:replace(ctgr, Constant.SV, '제주특산/기념품')}"/>
                                                                     <h5 class="product">${fn:replace(ctgr, ',', ' | ')}</h5>
                                                                 </c:if>
                                                             </c:if>
                                                             <span class="coupon-info">
                                                                 <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                                                    (<fmt:formatNumber>${result.buyMiniAmt}</fmt:formatNumber>원</strong> 이상 구매시 사용 가능)
                                                                 </c:if>
                                                                 <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                                                    <c:if test="${result.limitAmt ne 0}">
                                                                    (최대 <fmt:formatNumber>${result.limitAmt}</fmt:formatNumber>원</strong> 까지 할인 가능)
                                                                    </c:if>
                                                                 </c:if>

                                                             </span>
                                                         </div>
                                                     </div>
                                                     <div class="in-td myPoin2__col4 table-heght">
                                                         <div class="Progress"><fmt:parseDate var="exprEndDt" value="${result.exprEndDt }" pattern="yyyyMMdd" />
                                                             ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd" /></div>
                                                     </div>
                                                     <div class="in-td myPoin2__col5 table-heght">
                                                         <c:if test="${(result.cpNum eq 'ALL') and (usableYn eq 'Y')}">
                                                             <div class="useYn${status.index} Progress">
                                                                 <a class="comm-btn sm" id="btnCoupon${status.index}"
                                                                         <c:choose>
                                                                             <c:when test="${fn:contains(result.cpNm,'빅할인이벤트2021')}">
                                                                                 onclick="javascript:ex_couponDownload('${result.cpId}', ${status.index});"
                                                                             </c:when>
                                                                             <c:otherwise>
                                                                                 onclick="javascript:fn_couponDownload('${result.cpId}', ${status.index});"
                                                                             </c:otherwise>
                                                                         </c:choose>
                                                                 >쿠폰받기<img src="/images/web/list/coupon_download.png" alt="쿠폰다운로드">
                                                                 </a>
                                                             </div>
                                                         </c:if>
                                                         <c:if test="${result.cpNum ne 'ALL'}">
                                                             <div class="useYn${status.index} Progress">
                                                                 <c:if test="${result.useYn eq 'N'}">
                                                                     <c:if test="${usableYn eq 'Y'}">미사용</c:if>
                                                                     <c:if test="${usableYn eq 'N'}"><span class="text-red">쿠폰마감</span></c:if>
                                                                 </c:if>
                                                                 <c:if test="${result.useYn eq 'Y'}">
                                                                     사용완료<br><span class="coupon-info">(${fn:substring(result.useDttm, 0, 10)})</span>
                                                                 </c:if>
                                                             </div>
                                                         </c:if>
                                                     </div>
                                                 </tr>
                                                 <%--</c:if>--%>
                                             </c:if>
											</div>
										</div>
                                     </c:forEach>
	                                 </li>
                                 </ul>

                                <!-- 유의사항 -->
                                <div class="info">
                                    <h4 class="tit">유의사항</h4>
                                    <div class="txt">
                                        ㆍ 발행된 탐나오쿠폰은 현금 환원이 불가하고, 발행단위로 사용(분할 활용불가).<br>
                                        ㆍ 상품 구매(예약) 전체 취소시 탐나오 쿠폰은 환원됨<br>
                                        ㆍ 상품 부분 취소시 부분 취소금액에서 탐나오쿠폰 금액을 제외하고 환불처리<br>
                                        ㆍ <strong class="comm-color1">회원탈퇴시 모든 쿠폰은 자동 소멸됨</strong><br>
                                    </div>
                                </div>
                            </div> <!--//rContents-->
                        </div> <!--//tbWrap-->
                    </div> <!--//inner-->
                </div> <!--//bgWrap2-->
            </div> <!-- //mypage2_2 -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
    <%--특별처리빅할인--%>
    <div id="main_popup" class="comm-layer-popup" style="position:fixed;left:20%;top:20%">
    <div class="content-wrap" style="width: 520px;">
        <div class="content">
            <div class="head">
            </div>
            <div class="main" >
                <img src="<c:url value="/images/web/etc/popupBigEvnt2020.jpg"/>" style="padding-top:5px;" alt="mainPopup">
                <div style="text-align: center">
                <button type="button" class="comm-btn blue" id="specialCp" value="" onclick="specialCp();">동의하고 쿠폰받기.</button>
                <button type="button" class="comm-btn" onclick="$('#main_popup').hide();">동의하지 않습니다.</button>
                </div>
            </div>
        </div>
    </div>
    </div>
</main>

<script type="text/javascript" src="<c:url value='/js/printThis.js?version=${nowDate}'/>"></script>
<script type="text/javascript">
	
	let webCouponClickTime = 0;

    // 쿠폰 받기
    function fn_couponDownload(cpId, idx) {
    	
    	const currentTime = new Date().getTime();
	    const timeDiff = currentTime - webCouponClickTime;

	    if (timeDiff < 500) {
	        e.preventDefault();
	        return;
	    }

	    webCouponClickTime = currentTime;
	    
        var parameters = "cpId=" + cpId;
        $.ajax({
            url:"<c:url value='/web/couponDownload.ajax'/>",
            data:parameters,
            async:false,
            success:function(data){
                if(data.result == "success") {
                    $("#btnCoupon" + idx).addClass("hide");
                    $(".useYn" + idx).html("미사용");
                    alert("<spring:message code='success.coupon.download'/>");
                } else if(data.result == "duplication") {
                	alert("이미 발급된 쿠폰 입니다.");
                } else {
                    alert("<spring:message code='fail.coupon.download'/>");
                }
            },
            error: fn_AjaxError
        })
    }

    function ex_couponDownload(cpId, idx) {
        $('#main_popup').show();
        $("#specialCp").val(cpId + "," + idx);
    }

    function specialCp() {
        var strArray =  $("#specialCp").val().split(",");
        var parameters = "cpId=" + strArray[0];
        $.ajax({
            url:"<c:url value='/web/couponDownload.ajax'/>",
            data:parameters,
            async:false,
            success:function(data){
                if(data.result == "success") {
                    $("#btnCoupon" + strArray[1]).addClass("hide");
                    $(".useYn" +  strArray[1]).html("미사용");
                    $('#main_popup').hide();
                    alert("<spring:message code='success.coupon.download'/>");
                } else {
                    alert("<spring:message code='fail.coupon.download'/>");
                }
            },
            error: fn_AjaxError
        })
    }

    // 쿠폰코드 등록
    function fn_couponCode(cpNum, cpId, idx) {
        var code = $("#code" + idx).val().toUpperCase();        // 대문자 변환

        if (code == null || code == "") {
            alert("<spring:message code='errors.required2' arguments='코드' />");
        } else {
            var parameters = "cpId=" + cpId + "&code=" + code;

            $.ajax({
                url: "<c:url value='/web/couponCodeCheck.ajax'/>",
                data: parameters,
                success: function (data) {
                    if (data.result == "success") {
                        alert("<spring:message code='success.coupon.download'/>");

                        $("#cpNum").val(cpNum);
                        $("#cpId").val(cpId);

                        document.frm.action = "<c:url value='/web/couponCode.do' />";
                        document.frm.submit();
                    } else {
                        alert("<spring:message code='fail.coupon.code'/>");
                    }
                },
                error: fn_AjaxError
            })
        }
    }

    $(document).ready(function() {

        /** 더보기 닫기 구현 hide*/

        for(let i=0; i<$(".couponDetail").length; ++i){
            $(".couponDetail:eq("+ i + ")").height();
            if( $(".couponDetail:eq("+ i + ")").height() > 110) {
                $(".couponDetail:eq("+ i + ")").children("._couponDetail").css("height", "75px");
                $(".couponDetail:eq("+ i + ") .show-more").css("display", "block");
            }else{
                $(".couponDetail:eq("+ i + ") .show-more").css("display", "none");
            }
        }

        $("span.show-more").click(function() {
            if ($(this).text() == "닫기") {
                $(this).text("...더 보기");
                $(this).parents(".couponDetail").children("._couponDetail").css("height","75px");
            } else {
                $(this).text("닫기");
                $(this).parents(".couponDetail").children("._couponDetail").css("height","");
            }
        })
    });

</script>                                
<jsp:include page="/web/foot.do" />
</body>
</html>