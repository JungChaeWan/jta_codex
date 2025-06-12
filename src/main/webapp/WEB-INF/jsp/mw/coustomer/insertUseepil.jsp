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

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">	
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
<jsp:include page="/mw/head.do">
	<jsp:param name="headTitle" value="이용후기 작성"/>
</jsp:include>

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
			$("#ue_like"+i).attr("src", "<c:url value='/images/mw/icon/star_on.png'/>" );
		}else{
			//console.log("#ue_like"+i +"<="+ nGpa + ":x");
			$("#ue_like"+i).attr("src", "<c:url value='/images/mw/icon/star_off.png'/>" );
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
	document.frm.action = "<c:url value='/mw/coustomer/insertUseepil.do'/>";
	document.frm.submit();		
}
</script>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>이용후기</h2>
	</div>
	<div class="sub-content">

		<!-- 리뷰 프로모션 배너롤링 -->
		<div class="review_content__banner">
			<div class="main-top-slider">
				<div id="main_top_slider" class="swiper-container swiper-container-horizontal">
					<ul class="swiper-wrapper">
						<li class="swiper-slide">
							<div class="Fasten">
								<a class="inner--link" href="https://m.site.naver.com/1CMBk" target="_blank">
									<img src="/images/mw/from/banner/review_banner.png" alt="리뷰이벤트">
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="board">
			<dl class="txt-box">
				<dt>이용후기 쓰기</dt>
				<dd>주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</dd>
				<dd>고객님께서 상품을 이용하신 후 2개월 내 등록이 가능합니다.</dd>
			</dl>
			<form name="frm" method="post" onSubmit="return false;" enctype="multipart/form-data">
			
				<table class="write bt-none">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th><label for="product">상품</label></th>
						<td class="cate">
							<select id="prdtInf" name="prdtInf">
                               	<option value="">-선택하세요-</option>
                               	<c:forEach var="data" items="${rsvepilList}" varStatus="status">
                               		<option value="${data.corpId},${data.prdtNum},${data.prdtRsvNum}" <c:if test="${data.selectYn=='Y'}">selected="selected"</c:if> >${data.dpNm }</option>
                               	</c:forEach>
                            </select>
                                                                    	
						</td>
					</tr>
					<tr>
						<th><label for="product">평점</label></th>
						<td class="cate">
							<span>
								<a href="javascript:fn_useepilChageLike(1)"><img id="ue_like1" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(2)"><img id="ue_like2" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(3)"><img id="ue_like3" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(4)"><img id="ue_like4" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(5)"><img id="ue_like5" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요" ></a>
								<input type="hidden" name="gpa" id="gpa" value="0" />
							</span>
						</td>
					</tr>
					<tr>
						<th><label for="reviewType">유형</label></th>
						<td class="cate">
							<select id="reviewType" name="reviewType">
								<option value="">-선택하세요-</option>
								<c:forEach var="rvtp" items="${cdRvtp}" varStatus="status">
									<option value="${rvtp.cdNum}"  >${rvtp.cdNm }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><label for="title">제목</label></th>
						<td class="full">
							<input type="text" id="title" id="subject" name="subject">
						</td>
					</tr>
					<tr>
						<th><label for="con">내용</label></th>
						<td><textarea id="con" cols="45" rows="5" id="contents" name="contents" maxlength="500"></textarea></td>
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
				</table>
				<p class="btn-list">
					<a href="#" onclick="fn_Ins()" class="btn btn1">저장</a>
					<a href="javascript:history.back();" class="btn btn2">취소</a>
				</p>
				
			</form>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>