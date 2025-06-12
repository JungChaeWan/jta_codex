<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui"      uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<script type="text/javascript">

$(document).ready(function(){
    $(".item-list h3").click(function () {
        $(this).closest(".item-list");
        let index = $(".item-list").index($(this).closest(".item-list"));
        if ($(".item-list:eq(" + index + ")").hasClass("open")) {
            $(".item-list:eq(" + index + ")").removeClass("open");
            $(".item-list:eq(" + index + ")").attr("attr-value","0");
        }else{
            $(".item-list:eq(" + index + ")").addClass("open");
            $(".item-list:eq(" + index + ")").attr("attr-value","1");
        };
        let itemMenuCd = "";
        $("[attr-value]").each(function() {
        	let compVal = $(this).attr("attr-value");
        	$(this).attr("attr-value",compVal);
			itemMenuCd += compVal;
    	});
        localStorage.setItem("itemMenuCd", itemMenuCd);
    });

    /** 메뉴 토글 상태 유지  */
	if(localStorage.getItem("itemMenuCd")){
		$(".item-list h3").each(function(index) {
			tempStr = localStorage.getItem("itemMenuCd").substring(index, index+1);
			if (Number(tempStr)) {
				$(".item-list:eq(" + index + ")").addClass("open");
				$(".item-list:eq(" + index + ")").attr("attr-value","1");
			} else {
				$(".item-list:eq(" + index + ")").removeClass("open");
				$(".item-list:eq(" + index + ")").attr("attr-value","0");
			};
		});
	};

	if($(".item-list a.select").text().length > 0){
		$(".item-list a.select").parents('section').find('h3').addClass("select")
	}else{
		$("#sub-leftMenu section a h3:eq(0)").addClass("select");
	}
});

</script>
<aside id="sub-leftMenu" class="smON">
	<h4 class="title">
		<a class="title-text">마이페이지</a>
	</h4>
    <%-- <p class="hi"><img src="<c:url value='/images/web/mypage/hi.gif'/>" alt="hi"> ${userNm}님 반갑습니다.</p> --%>
    <div class="pdWrap">
		<section>
			<a href="<c:url value='/web/mypage/rsvList.do'/>"><h3>나의 예약/구매 내역</h3></a>
		</section>   
		<section class="item-list open" attr-value="1">
			<h3>나의 혜택정보</h3>
			<ul class="depth1 half">
				<li><a href="<c:url value='/web/mypage/couponList.do'/>"<c:if test="${menu eq 'coupon'}"> class="select"</c:if>>탐나오쿠폰 내역보기</a></li>
				<%--<li><a href="<c:url value='/web/mypage/freeCouponList.do'/>"<c:if test="${menu eq 'freeCoupon'}"> class="select"</c:if>>할인쿠폰 보관함</a></li>--%>
			</ul>
		</section>	
		<section class="item-list open" attr-value="1">
			<h3>나의 게시글 모음</h3>
			<ul class="depth1 half">
				<li><a href="<c:url value='/web/mypage/otoinqList.do'/>"<c:if test="${menu eq 'otoinq'}"> class="select"</c:if>>1:1 문의내역</a></li>
				<li><a href="<c:url value='/web/mypage/useepilList.do'/>"<c:if test="${menu eq 'useepil'}"> class="select"</c:if>>이용후기 내역</a></li>
			</ul>
		</section>	
		<section class="item-list open" attr-value="1">
			<h3>나의 정보</h3>
			<ul class="depth1 half">
				<li><a href="<c:url value='/web/mypage/viewUpdateUser.do'/>"<c:if test="${menu eq 'updateUser'}"> class="select"</c:if>>개인정보수정</a></li>
				<li><a href="<c:url value='/web/mypage/viewRefundAccNum.do'/>"<c:if test="${menu eq 'refund'}"> class="select"</c:if>>환불계좌관리</a></li>
                <c:if test="${!empty pwd}">
                    <li><a href="<c:url value='/web/mypage/viewChangePw.do'/>"<c:if test="${menu eq 'changePw'}"> class="select"</c:if>>비밀번호 변경</a></li>
                </c:if>
				<li><a href="<c:url value='/web/mypage/viewDropUser.do'/>"<c:if test="${menu eq 'dropUser'}"> class="select"</c:if>>회원탈퇴</a></li>
			</ul>
		</section>	
    </div>
</aside>
