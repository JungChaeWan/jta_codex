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

	<script src="<c:url value='/js/mw_swiper.js'/>"></script>
<script type="text/javascript">

</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>

<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mw/coustomer/useepilList.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/mw/coustomer/viewInsertUseepil.do'/>";
	document.frm.submit();
}


function detail_photo() {

	var arrPrdtImg  = [];
	<c:forEach var="result" items="${prdtList}" varStatus="status">
		arrPrdtImg[${status.count-1}] = "";
		<c:forEach var="prdtImg" items="${result.imgList}" varStatus="status1">
			arrPrdtImg[${status.count-1}] +="<div class='swiper-slide'><img src='${prdtImg.savePath}thumb/${prdtImg.saveFileNm}' alt=''></div>";
		</c:forEach>
	</c:forEach>

	$("input:radio[name='room']").each(function(index) {

		if($(this).is(":checked")) {
			var detail_img = "";
			detail_img += "<div class='swiper-container'>";
			detail_img += "		<div class='swiper-wrapper'>";
			detail_img += arrPrdtImg[index];
			//detail_img += "			<div class='swiper-slide'><img src='../../images/mw/sub_common/p_img2.png' alt=''></div>";
			//detail_img += "			<div class='swiper-slide'><img src='../../images/mw/sub_common/p_img2.png' alt=''></div>";
			detail_img += "		</div>";

			detail_img += "		<div class='swiper-pagination'></div>";
			detail_img += "</div>";

			$('.detail-gallery').html('');
			$('.detail-gallery').eq(index).html(detail_img);

			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: true
			});
		}

	});

}
detail_photo();

//이용후기 사진뷰
function review_photo(useEpilNum) {
	$.ajax({
		type:"post",
		url:"<c:url value='/web/cmm/useepilImgListDiv.ajax'/>",
		data:"useEpilNum=" + useEpilNum ,
		success:function(data){
			$('#cover').show();										//bg block
			$('.review-gallery').addClass('active');				//gallery block

			var review_img = "";
			review_img += "<div class='swiper-container2'>";
			review_img += "	<div class='swiper-wrapper'>";

			for (var i=0, end=data.imgList.length; i<end; i++) {
				review_img += "		<div class='swiper-slide'><img src='" + data.imgList[i].savePath + data.imgList[i].saveFileNm + "' alt=''></div>";
			}

			review_img += "	</div>";
			review_img += "	<div class='swiper-pagination2'></div>";
			review_img += "	<a class='photo_close' href='javascript:void(0)' onclick='review_close();'><img src='/images/mw/icon/review_close.png' alt='닫기'></a>";
			review_img += "</div>";

			$('.review-gallery').html(review_img);					//html tag add

			var swiper = new Swiper('.swiper-container2', {			//slide start
				pagination: '.swiper-pagination2',
				paginationClickable: true
			});
		},
		error : fn_AjaxError
	});
}

function review_close() {									//close event
	$('#cover').hide();										//bg none
	$('.review-gallery').removeClass('active');				//gallery none

	$('.review-gallery').html('');							//html tag remove
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

		<div class="board">

			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div class="search">
					<input type="text" class="focus-value" id="sSubject" name="sSubject" value="<c:out value='${searchVO.sSubject}'/>">
					<a href="javascript:fn_Search('1')" class="btns btn-search">검색</a>

					<c:if test="${isLogin=='Y'}">
						<a href="javascript:fn_Ins()" class="btns btn-write">글쓰기</a>
					</c:if>
				</div>

				<p class="txt">총 <strong>${totalCnt }</strong>개의 게시물이 있습니다. </p>

				<ul class="list">
					<c:if test="${fn:length(useepilList) == 0}">
						<li>
							<strong>내역이 없습니다.</strong>
						</li>
					</c:if>
					<c:forEach var="data" items="${useepilList}" varStatus="status">
						<li>
							<!-- <a href=""> -->
								<strong>[<c:out value="${data.subjectHeder}"/>]&nbsp; <c:out value="${data.subject}"/></strong><br>
								<em><c:out value="${data.email}" /> &nbsp;&nbsp; ${data.frstRegDttm}</em>
							<!-- </a> -->

							 <div class="re-comment">
							 	<dl class="default-accordion2 reviews-ad">
			                        <dt>
			                              <ul class="tbOption">
			                                  <li class="memoWrap">
			                                  	<c:if test="${fn:length(data.imgList) != 0 }">
				                                  	<div class="photo-area"> <!-- 사진 없을 시 div 삭제 -->
														<div class="photo-wrap">
													        <p class="photo" onclick="review_photo('${data.useEpilNum}');"><img src="<c:url value='${data.imgList[0].savePath }thumb/${data.imgList[0].saveFileNm }'/>" alt="review"></p>
													    </div>
													</div>
												</c:if>


			                                      <p class="user-info">
			                                          <span class="heart">
			                                          		<c:if test="${data.gpa >= 1 }"><img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa < 1 }"><img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa >= 2 }"><img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa < 2 }"><img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa >= 3 }"><img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa < 3 }"><img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa >= 4 }"><img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa < 4 }"><img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa >= 5 }"><img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="좋아요"></c:if>
															<c:if test="${data.gpa < 5 }"><img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></c:if>
			                                          </span>
			                                          <c:if test="${isLogin=='Y' && data.userId == userInfo.userId}">
			                                          	<p class="editBT">
															<a href="<c:url value='/mw/coustomer/viewUdateUseepil.do'/>?useEpilNum=${data.useEpilNum}" class="btn btn-reply">수정</a>
											   			</p>
			                                          </c:if>
			                                      </p>
			                                      <p class="user-memo">
			                                          <c:out value="${data.contents}" escapeXml="false"/>
			                                          <span class="comment-count">(${data.cmtCnt})</span>
			                                      </p>
			                                  </li>


			                              </ul>
			                   		</dt>
			                        <c:if test="${fn:length(data.cmtList) != 0}">
										 <dd>
										 	<c:forEach var="dataCmt" items="${data.cmtList}" varStatus="status">
										      <ul class="re_comment">
										          <li class="ic2"><img src="<c:url value='/images/web/icon/re2.png'/>" alt="re"></li>
										          <li class="re">
										              <c:out value="${dataCmt.contents}" escapeXml="false"/>
										          </li>
										      </ul>
										  </c:forEach>
										 </dd>
									</c:if>
								</dl>
							 </div>
						</li>
					</c:forEach>
				</ul>

				<c:if test="${fn:length(useepilList) != 0}">
                    <div class="pageNumber">
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
						</p>
					</div>
				</c:if>

			</form>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 이용후기 사진 레이어 팝업 (클릭시 호출) -->
<div class="review-gallery"></div>


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
