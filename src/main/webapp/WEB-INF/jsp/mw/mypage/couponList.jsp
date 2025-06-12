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
<jsp:include page="/mw/includeJs.do"></jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%-- 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">
--%>	
</head>
<body class="coup-body">
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="탐나오쿠폰 내역"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>탐나오쿠폰 내역보기</h2>
	</div>
	<div class="sub-content">
		<div class="mypage">
			<!--탐나오쿠폰내역-->
			<div class="t-coupon">
				<ul class="list">
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
                        <%--코드 등록전 쿠폰 제외--%>
                        <c:if test="${(empty result.cpCode) or (not empty result.cpCode and not empty result.useYn)}">
                            <%-- 수량무제한, 수량이 unlimited, 제한수량보다 발급수량이 적을 때, 제한수량보다 사용수량이 적을 때   --%>
                            <%--<c:if test="${(empty result.limitType) or (result.limitType eq 'UNLI') or (result.useYn eq 'Y') or (result.limitType eq 'ISSU' and result.limitCnt > result.issueCnt) or (result.limitType eq 'USAG' and limitCnt > useCnt)}">--%>
                                <li class="coupon_list <c:if test="${(result.cpNum eq 'ALL') and (usableYn eq 'N')}">hide</c:if>">
                                    <div class="coupon_info">
                                        <div class="coup_title">
                                            <span class="coup_name">${result.cpNm}</span>
                                            <span class="coup_dis">
                                                <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                                    <strong><fmt:formatNumber value="${result.disAmt}" type="number" /></strong>원 할인
                                                </c:if>
                                                <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                                    <strong>${result.disPct}</strong> % 할인
                                                </c:if>
                                                <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                                    <span class="coupon-info"><strong>무료</strong></span>
                                                </c:if>
                                            </span>
                                        </div>
                                        <div class="coup_date">
                                            <span class="coup_date_t">유효기간: </span>
                                            <span>
                                              <fmt:parseDate var="exprEndDt" value="${result.exprEndDt }" pattern="yyyyMMdd" />
                                              ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd" />
                                            </span>
                                        </div>
                                        <div class="coup_info couponDetail" >
                                            <c:if test="${empty result.prdtCtgrList}">
                                                <c:if test="${empty result.aplprdtDiv}">
                                                    <c:choose>
                                                        <c:when test="${result.cpDiv == 'ACNR'}">
                                                            <span>항공, 제주특산/기념품을 제외한 모든 상품</span>
                                                        </c:when>
                                                        <c:when test="${result.cpDiv == 'ACNV'}">
                                                            <span>제주특산/기념품</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>항공을 제외한 모든 상품</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                                <c:if test="${result.aplprdtDiv eq 'AP02'}">
                                                    <div class="_couponDetail">${productMap[result.cpId]}</div>
                                                    <div class="grayspace"></div>
                                                    <div class="show-more">
                                                        <span class="show-more">더 보기</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${result.aplprdtDiv eq 'AP03'}">
                                                    <div class="_couponDetail">${productMap[result.cpId]}</div>
                                                    <div class="grayspace"></div>
                                                    <div class="show-more">
                                                        <span class="show-more">더 보기</span>
                                                    </div>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${not empty result.prdtCtgrList}">
                                                <c:set var="prdtCtgrCnt" value="${fn:split(result.prdtCtgrList, ',')}" />
                                                <c:if test="${fn:length(prdtCtgrCnt) == 8}">
                                                    <span>항공을 제외한 모든 상품</span>
                                                    <%--<p>택배상품 구매시 배송비 별도</p>--%>
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

                                                    <span><c:out value="${fn:replace(ctgr, ',', ' | ')}" /></span>
                                                </c:if>
                                            </c:if>
                                            <br><span class="coupon-info"><strong>
                                                <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                                    <fmt:formatNumber>${result.buyMiniAmt}</fmt:formatNumber>원</strong> 이상 구매시 사용 가능
                                                </c:if>
                                                <c:if test="${result.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                                    <c:if test="${result.limitAmt ne 0}">
                                                        최대 <fmt:formatNumber>${result.limitAmt}</fmt:formatNumber>원</strong> 까지 할인 가능
                                                    </c:if>
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="coupon_btn">
                                        <div class="coup-t" id="useYn${status.index}">
                                            <c:if test="${(result.cpNum eq 'ALL') and (usableYn eq 'Y')}">
                                                <button class="comm-btn coup-btn" id="btnCoupon${status.index}"
                                                        onclick="javascript:fn_couponDownload('${result.cpId}', ${status.index});"
                                                >쿠폰받기</button>
                                            </c:if>
                                            <c:if test="${result.cpNum ne 'ALL'}">
                                                <span>
                                                    <c:if test="${result.useYn eq 'N'}">
                                                        <c:if test="${usableYn eq 'Y'}">미사용</c:if>
                                                        <c:if test="${usableYn eq 'N'}"><span class="text-red">쿠폰마감</span></c:if>
                                                    </c:if>
                                                    <c:if test="${result.useYn eq 'Y'}">
                                                        사용완료<br><span class="coupon-info">(${fn:substring(result.useDttm, 0, 10)})</span>
                                                    </c:if>
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </li>
                            <%--</c:if>--%>
                        </c:if>
					</c:forEach>
				</ul>

                <%--탐나오쿠폰 코드--%>
                <form name="frm" method="post" onsubmit="return false;">
                    <input type="hidden" name="cpNum" id="cpNum" />
                    <input type="hidden" name="cpId" id="cpId" />

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <%--코드 등록 전 쿠폰--%>
                        <c:if test="${not empty result.cpCode and empty result.useYn}">
                            <article class="info-wrap">
                                <h6>${result.cpNm} 쿠폰코드 입력</h6>
                                <div class="center">
                                    <input type="text" name="code" id="code${status.index}" placeholder="쿠폰 코드" />
                                    <button class="comm-btn red" onclick="fn_couponCode('${result.cpNum}', '${result.cpId}', ${status.index});">입력</button>
                                </div>
                            </article>
                        </c:if>
                    </c:forEach>
                </form>

				<article class="info-wrap">
					<h6>안내</h6>
					<ul>
						<li>발행된 탐나오쿠폰은 현금 환원이 불가하고, 발행단위로 사용(분할용불가)</li>
						<li>상품 구매(예약) 전체 취소 시 탐나오 쿠폰은 환원됨</li>
						<li>상품 부분 취소시 부분 취소금액에서 탐나오쿠폰 금액을 제외하고 환불 처리</li>
						<li><span class="comm-color1">회원 탈퇴 시 모든 쿠폰은 자동 소멸됨</span></li>
					</ul>
				</article>
			</div>
		</div>
	</div>
    <%-- 특별처리빅할인 --%>
    <div class="popup_con">
        <div class="popup_ad">
            <img src="/images/mw/etc/popupBigEvnt2020.jpg" alt=" 빅이벤트" border="0" onerror="this.src='/images/web/other/no-image.jpg'">
        </div>
        <div class="popup_close_set">
            <span class="popup_close2" id="specialCp" value="" onclick="specialCp();" style="font-size:15px;color:skyblue;border:1px solid;">동의하고 쿠폰받기</span>
            <span class="popup_close" style="font-size:15px;width:50%;border:1px solid;color:#b9b9b9;">동의하지 않습니다</span>
        </div>
    </div>

    <div class="popup_mask"></div> <!-- 이 부분이 배경 Dim 처리임/ 블랙 쉐도우 처리-->
</section>
<!-- 콘텐츠 e -->
<script type="text/javascript">

	let mwCouponClickTime = 0;
	
	// 쿠폰 받기
	function fn_couponDownload(cpId, idx) {
		
		const currentTime = new Date().getTime();
	    const timeDiff = currentTime - mwCouponClickTime;

	    if (timeDiff < 500) {
	        e.preventDefault();
	        return;
	    }

	    mwCouponClickTime = currentTime;
	    
	    var parameters = "cpId=" + cpId;
	    $.ajax({
	        url:"<c:url value='/mw/couponDownload.ajax'/>",
	        data:parameters,
	        async:false,
	        success:function(data){
	            if(data.result == "success") {
	                $("#btnCoupon" + idx).addClass("hide");
	                $("#useYn" + idx).html("미사용");
	
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

    /** 특별처리빅할인*/
	function ex_couponDownload(cpId, idx) {
	    $(".popup_con").show();
	    $(".popup_mask").show();
	
	    $("#specialCp").val(cpId + "," + idx);
	
	    // scroll touchmove mousewheel 방지
	    $("#wrap").on("scroll touchmove mousewheel", function (e) {
	        e.preventDefault();
	        e.stopPropagation();
	        return false;
	    });
	
	    /** 닫기 */
	    $(".popup_close").on("click", function() {
	        popupClose();
	    });
	    /*/!** 쿠폰받기 *!/
	    $(".popup_close2").on("click", function() {
	        console.log("클릭");
	        fn_couponDownload(cpId, idx)
	        popupClose();
	    });*/
	}
	
	function popupClose() {
	    $(".popup_con").hide();
	    $(".popup_mask").hide();
	
	    $("#wrap").off("scroll touchmove mousewheel");
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
	                $("#useYn" +  strArray[1]).html("미사용");
	                popupClose();
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
	    if(code == null || code == "") {
	        alert("<spring:message code='errors.required2' arguments='코드' />");
	    } else {
	        var parameters = "cpId=" + cpId + "&code=" + code;
	
	        $.ajax({
	            url:"<c:url value='/mw/couponCodeCheck.ajax'/>",
	            data:parameters,
	            success:function(data){
	                if(data.result == "success") {
	                    alert("<spring:message code='success.coupon.download'/>");
	
	                    $("#cpNum").val(cpNum);
	                    $("#cpId").val(cpId);
	
	                    document.frm.action = "<c:url value='/mw/couponCode.do' />";
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
        if($("._couponDetail").height() > 100) {
            $(".couponDetail .show-more").css("display", "block");
            $("._couponDetail").css("height", "38px");
        }
        $("span.show-more").click(function() {
            if ($(this).text() == "닫기") {
                $(this).text("더 보기");
                $(this).parents(".couponDetail").children("._couponDetail").css("height","40px");
            } else {
                $(this).text("닫기");
                $(this).parents(".couponDetail").children("._couponDetail").css("height","");
            }
        })
    });
</script>
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>