<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

$(document).ready(function(){
});

//이용후기 사진뷰
function review_photo(useEpilNum) {
	$.ajax({
		type:"post",
		url:"<c:url value='/web/cmm/useepilImgListDiv.ajax'/>",
		data:"useEpilNum=" + useEpilNum ,
		success:function(data){
			var review_img = "";
			review_img += "<div class='custom-container gallery-view2 detail-view1'>";
			review_img += "    <a class='photo_close' href='javascript:void(0)' onclick='review_close();'><img src='/images/web/icon/close3.gif' alt='닫기'></a>";
			review_img += "    <div class='mid'>";
			review_img += "        <img src='" + data.imgList[0].savePath + data.imgList[0].saveFileNm + "'>";
			review_img += "    </div>";
			review_img += "    <div class='carousel'>";
			review_img += "        <ul>";
			for (var i=0, end=data.imgList.length; i<end; i++) {
				review_img += "            <li";
				if (i==0) review_img += " class='select'";
				review_img += "><img src='" + data.imgList[i].savePath + "thumb/" + data.imgList[i].saveFileNm + "'></li>";
			}
			review_img += "        </ul>";
			review_img += "    </div>";
			review_img += "    <div class='clear'></div>";
			review_img += "</div>";

			$('body').after('<div class="lock-bg"></div>');							//lock bg open
			$('.review-gallery').addClass('active');								//gallery block
			$('.review-gallery').html(review_img);									//html tag add

			$(".review-gallery .carousel").jCarouselLite({							//slide start
		        visible: 5,
		        circular: false
		    });

		    $(".review-gallery .carousel img").click(function() { 					//썸네일 이미지 변경
		        $(".review-gallery .mid img").attr("src", $(this).attr("src"));
		    });

		    $('.review-gallery .carousel li').click(function(){ 					//class add
		        $('.review-gallery .carousel li').removeClass('select');
		        $(this).addClass('select');
		    });
		},
		error : fn_AjaxError
	});
}

function review_close() {													//close event
	$('.lock-bg').remove();													//lock bg hide
	$('.review-gallery').removeClass('active');								//gallery none
	$('.review-gallery').html('');											//html tag remove
}

function fn_chkLogin() {
	alert('회원은 로그인 후 이용후기를 작성하실 수 있고,\n비회원은 이용후기를 작성할 수 없습니다.');
	return;
}
</script>

<!--이용후기-->
<section class="_review" id="adReview">
	<div class="_info-title">이용후기</div>
	<div>
		<div class="review-List">
			<div class="top-wrap">
                <p>상품평은 구매한 고객님만 작성이 가능하십니다.</p>
                <p>상품 문의는 1:1문의 게시판, 취소 및 환불은 마이페이지를 이용해 주세요.</p>
                <c:if test="${isLogin=='Y'}">
                <a href="<c:url value='/web/coustmer/viewInsertUseepil.do'/>?corpId=${USEEPILVO.corpId}&prdtnum=${USEEPILVO.prdtnum}" class="comm-btn gray">
                </c:if>
                <c:if test="${isLogin!='Y'}">
                <a class="comm-btn gray" href="javascript:fn_chkLogin();">
                </c:if>
                        이용후기 작성</a>
			</div>
			<c:if test="${fn:length(useepilList) == 0}">
			<div>
				<p class="noComment">상품평이 없습니다.</p>
			</div>
			</c:if>
			<c:forEach var="data" items="${useepilList}" varStatus="status">
			<div class="Review-comment">
				<div class="review_user">
					<div class="review_left">
						<div class="user_f">
							<c:if test="${data.userId eq 'U160103745'}">
							<img class="ico-emoji" src="/images/comm/icons/ico-tamnarubang.png" alt="탐나르방">
							</c:if>
							<c:if test="${data.userId ne 'U160103745'}">
								<c:if test="${data.gpa > 3}">
							<img class="ico-emoji" src="/images/comm/icons/ico-emoji-5.png" width="40" height="40" alt="좋아요5">
								</c:if>
								<c:if test="${data.gpa < 4}">
							<img class="ico-emoji" src="/images/comm/icons/ico-emoji-3.png" width="40" height="40" alt="좋아요3">
								</c:if>
							</c:if>
						</div>
						<div class="user_info">
							<div>
								<c:if test="${data.userId eq 'U160103745'}">
								<div class="user_id">탐나르방</div>
								</c:if>
								<c:if test="${data.userId ne 'U160103745'}">
								<div class="user_id">${data.email}</div>
								<div class="score-area">
									<c:forEach var="i" begin="1" end="5">
										<c:if test="${i-1 < data.gpa }">
											<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:currentColor">
												<path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
											</svg>
										</c:if>
									</c:forEach>
								</div>
								</c:if>
								<div class="date">${data.frstRegDttm}</div>
							</div>
						</div>
					</div>
					<div class="review_right">
						<div class="reviewCom">
							<div class="_title">${data.subject}</div>
							<div class="_comment">
                            <c:if test="${fn:length(data.imgList) != 0 }">
                            <!-- 오픈형 개럴리 추가(20170821) -->
                            <div id="review_gallery${status.count}" class="review-gallery-area"> <!-- ID값 변경 / 갤러리 없을 시 삭제 -->
                                <div class="photo-area">
                                    <div class="mid">
                                         <img src="<c:url value='${data.imgList[0].savePath }thumb/${data.imgList[0].saveFileNm }'/>" loading="lazy" alt="${status.count}">
                                    </div>
                                    <div class="carousel">
                                         <ul>
                                            <c:forEach var="imgdata" items="${data.imgList}" varStatus="status1">
                                                <c:if test="${status1.count==1}"><li class="select"></c:if>
                                                <c:if test="${status1.count!=1}"><li></c:if>
                                                <img src="<c:url value='${imgdata.savePath }thumb/${imgdata.saveFileNm }'/>" loading="lazy" alt="review" onerror="this.src='/images/web/other/no-image.jpg'"></li>
                                            </c:forEach>
                                         </ul>
                                    </div>
                                    <div class="clear"></div>
								</div>
								<script>
									$('#review_gallery${status.count} .carousel').jCarouselLite({
										visible: 5,
										circular: false
									});
									$('#review_gallery${status.count} .carousel li').click(function() {
										$('#review_gallery${status.count} .mid img').attr("src", $(this).find('img').attr("src"));
										$('#review_gallery${status.count} .carousel li').removeClass('select');
										$(this).addClass('select');
									});
								</script>
                            </div>
                            <!-- //오픈형 개럴리 추가(20170821) -->
                            </c:if>
								<c:out value="${data.contents}" escapeXml="false"/>
							</div>
                            <c:if test="${isLogin=='Y'}">
                            <!-- 로그인 한 사람만 -->
                            <%--<a class="comment-int">
                                <span class="comment" onclick="fn_useepilCmtSH('${data.useEpilNum}');">답글달기</span>
                            </a>--%>
                            </c:if>
                            <!--답글폼-->
                            <c:if test="${isLogin=='Y'}">
                            <!-- 로그인 한 사람만 -->
                            <div class="int_comment" style="display: none;" id="ueContCmtDiv${data.useEpilNum}">
                                <textarea class="comment-t" id="ueContCmt${data.useEpilNum}" ></textarea>
                                <a href="javascript:fn_useepilCmtInsert('${data.useEpilNum}')" alt="등록" class="commentBT4">등록</a>
                            </div>
                            </c:if>
						</div>
						<c:forEach var="dataCmt" items="${data.cmtList}" varStatus="status">
						<div class="re_comment">
						   <div class="re">
								<c:out value="${dataCmt.contents}" escapeXml="false"/>
								<c:if test="${isLogin=='Y' && dataCmt.userId == userInfo.userId}">
									<!-- 답글 글쓴사람만 수정/삭제 가능 -->
									<div class="login_BT">
										<a href="javascript:fn_useepilCmtEditSH('${dataCmt.cmtSn}', '${dataCmt.useEpilNum}')" class="coment-editBT">수정</a>
										<a href="javascript:fn_useepilCmtDelete('${dataCmt.cmtSn}', '${dataCmt.useEpilNum}')" class="coment-delBT">삭제</a>
									</div>

									<div class="int_comment" style="display: none;" id="ueContCmtEditDiv${dataCmt.cmtSn}_${dataCmt.useEpilNum}">
										<textarea class="comment-t" id="ueContCmtEdit${dataCmt.cmtSn}_${dataCmt.useEpilNum}" cols="120" ><c:out value="${dataCmt.contentsOrg}"/></textarea>
										<a href="javascript:fn_useepilCmtUpdate('${dataCmt.cmtSn}', '${dataCmt.useEpilNum}')" class="commentBT3">수정</a>
									</div>
								</c:if>
						   </div>
						</div>
					   </c:forEach>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		<div class="pageNumber">
			<p class="list_pageing">
				<ui:pagination paginationInfo="${useepilPaginationInfo}" type="web" jsFunction="fn_useepilSearch" />
			</p>
		</div>
	</div>
</section>
<form name="useepilFrm" id="useepilFrm" method="post" onSubmit="return false;">
				<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" name="corpId" value="${USEEPILVO.corpId}" />
				<input type="hidden" name="prdtnum" value="${USEEPILVO.prdtnum}" />
				<input type="hidden" name="corpCd" value="${searchVO.corpCd}" />
				<input type="hidden" name="useEpilNum" id="useEpilNum" value="" />
				<input type="hidden" name="subject" value="" />
				<input type="hidden" name="contents" value="" />
				<input type="hidden" name="cmtSn" id="cmtSn" value="" />
				<input type="hidden" name="gpa" id="gpa" value="0" />
</form>








