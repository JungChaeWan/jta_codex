<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
function fn_chkLogin() {
	alert('회원은 로그인 후 이용후기를 작성하실 수 있고,\n비회원은 이용후기를 작성할 수 없습니다.');
	return;
}

$(document).ready(function(){
	//이용후기 갤러리 다중 Slide
	if($(".review-slide").length >= 1) {
		$(".review-slide").each(function(index) {
			$(this).addClass("review-photo" + index);

			if($(".swiper-slide", this).length > 1) {
				new Swiper(".review-photo" + index, {
					slidesPerView: "auto",
					paginationClickable: true,
					spaceBetween: 10
				});
			}
		});
	}

});
</script>

<input type="hidden" name="useTotalCnt" id="useTotalCnt" value="${paginationInfo.totalRecordCount}" />
<input type="hidden" name="useTotalPageCnt" value="${paginationInfo.totalPageCount}" />

<c:if test="${searchVO.pageIndex eq 1}">
	<div class="title-type3">이용후기</div>
	<div class="con-box review-form">
		<form name="useepilFrm" id="useepilFrm" method="post" onSubmit="return false;">
			<input type="hidden" name="pageIndex" id="usePageIndex" value="${searchVO.pageIndex}"/>
			<input type="hidden" name="corpId" id="corpId" value="${USEEPILVO.corpId}" />
			<input type="hidden" name="prdtnum" id="prdtnum" value="${USEEPILVO.prdtnum}" />
			<input type="hidden" name="corpCd" id="corpCd" value="${searchVO.corpCd}" />
			<input type="hidden" name="useEpilNum" id="useEpilNum" value="" />
			<input type="hidden" name="subject" id="subject" value="" />
			<input type="hidden" name="contents" id="contents" value="" />
			<input type="hidden" name="cmtSn" id="cmtSn" value="" />
			<input type="hidden" name="gpa" id="gpa" value="0" />

			<dl>
				<dt>상품에 대한 이용후기를 작성해주세요.</dt>
				<dd>상품평은 구매한 고객님만 작성이 가능하십니다.<br>
					상품 문의는 1:1문의 게시판, 취소 및 환불은 마이페이지를 이용해주세요</dd>
			</dl>
			<p>
				<c:if test="${isLogin == 'Y'}">
					<a href="<c:url value='/mw/coustomer/viewInsertUseepil.do'/>?corpId=${USEEPILVO.corpId}&prdtnum=${USEEPILVO.prdtnum}" class="btn btn-submit">이용후기 작성</a>
				</c:if>
                <c:if test="${isLogin != 'Y'}">
                	<a href="javascript:fn_chkLogin();" class="btn btn-submit">이용후기 작성</a>
                </c:if>
			</p>

		</form>
	</div>
	<div class="review-list" id="reviewListWrap">
		<c:if test="${fn:length(useepilList) == 0}">
			<!-- <dl><dt>이용후기가 없습니다.</dt></dl> -->
		</c:if>
</c:if>
<c:set var="totalCnt" value="${fn:length(useepilList)}" />

<c:forEach var="data" items="${useepilList}" varStatus="status">
	<c:set var="reviewId" value="${status.count}" />
	<dl>
		<dt>
			<c:if test="${data.userId eq 'U160103745'}">
			<span>
				<img class = "ico-emoji" src="/images/mw/icon/ico-tamnarubang.png" alt="탐나르방">
			</span>
			<div class="bottom">
				<p class="user"><span class="user-id">탐나르방</span> <span class="date">(${data.frstRegDttm})</span></p>
			</div>
			</c:if>
			<c:if test="${data.userId ne 'U160103745'}">
			<c:if test="${data.gpa < 4 }">
			<span>
				<img class = "ico-emoji" src="/images/mw/icon/ico-emoji-3.png" alt="좋아요3">
			</span>
			</c:if>
			<c:if test="${data.gpa > 3}">
			<span>
				<img class = "ico-emoji" src="/images/mw/icon/ico-emoji-5.png" alt="좋아요5">
			</span>
			</c:if>
			<span class="like">
				<c:if test="${data.gpa < 1}"><img src="/images/mw/icon/star_off.png" alt="좋아요1_off" width="10"></c:if>
				<c:if test="${data.gpa >= 1}"><img src="/images/mw/icon/star_on.png" alt="좋아요1_on" width="10"></c:if>
				<c:if test="${data.gpa < 2}"><img src="/images/mw/icon/star_off.png" alt="좋아요2_off" width="10"></c:if>
				<c:if test="${data.gpa >= 2}"><img src="/images/mw/icon/star_on.png" alt="좋아요2_on" width="10"></c:if>
				<c:if test="${data.gpa < 3}"><img src="/images/mw/icon/star_off.png" alt="좋아요3_off" width="10"></c:if>
				<c:if test="${data.gpa >= 3}"><img src="/images/mw/icon/star_on.png" alt="좋아요3_on" width="10"></c:if>
				<c:if test="${data.gpa < 4}"><img src="/images/mw/icon/star_off.png" alt="좋아요4_off" width="10"></c:if>
				<c:if test="${data.gpa >= 4}"><img src="/images/mw/icon/star_on.png" alt="좋아요4_on" width="10"></c:if>
				<c:if test="${data.gpa < 5}"><img src="/images/mw/icon/star_off.png" alt="좋아요5_off" width="10"></c:if>
				<c:if test="${data.gpa >= 5}"><img src="/images/mw/icon/star_on.png" alt="좋아요5_on" width="10"></c:if>
				<em>${data.gpa}/5</em>
			</span>
			<div class="bottom">
				<p class="user"><span class="user-id">${data.email}</span> <span class="date">(${data.frstRegDttm})</span></p>
			</div>
			</c:if>
		</dt>
		<dd class="memo-wrap">
			<strong><c:out value="${data.subject}"/></strong>
			<div class="review-photo-list">
				<c:set var="totalImgCnt" value="${fn:length(data.imgList)}" />
				<c:if test="${totalImgCnt > 0 }">
					<div class="review-photo">
						<div class="swiper-container review-slide">
							<div class="swiper-wrapper">
								<c:forEach var="imgdata" items="${data.imgList}" varStatus="status1">
									<div class="swiper-slide">
										<%-- <a href="javascript:void(0);" onclick="fn_useepilImgList(${reviewId}, ${totalCnt})" > --%>
										<span onclick="fn_useepilImgList(${reviewId}, ${totalCnt});" >
											<img src="${imgdata.savePath}thumb/${imgdata.saveFileNm}" loading="lazy" alt="${data.subject}_${status1.count}">
										</span>
									</div>
								</c:forEach>
							</div>
							<div class="counting">${totalImgCnt}</div>
						</div>
					</div>

					<div id="useepil_detail_slider${reviewId}" class="detail-slider reviewPhoto">
						<%-- <a href="javascript:void(0);" onclick="useepilSlideClose(${reviewId})" class="close"> --%>
						<span onclick="useepilSlideClose(${reviewId})" class="close">
							<img src="/images/mw/common/side/close-white.png" style="width:33px;height:33px;" alt="닫기">
						</span>
						<div class="swiper-wrapper">
							<c:forEach var="imgdata" items="${data.imgList}" varStatus="status2">
								<div class="swiper-slide">
									<img src="${imgdata.savePath}thumb/${imgdata.saveFileNm}" loading="lazy" alt="${data.subject}_${status2.count}">
									<div class="img-caption">
										<p>${data.subject}_${status2.count}</p>
									</div>
								</div>
							</c:forEach>
						</div>
						<div id="useepil_detail_paging${reviewId}" class="swiper-pagination"></div>
						<div id="useepil_detail_arrow${reviewId}" class="arrow-area">
							<div id="useepil_detail_next${reviewId}" class="swiper-button-next"></div>
							<div id="useepil_detail_prev${reviewId}" class="swiper-button-prev"></div>
						</div>
					</div>
				</c:if>
				<p class="memo"><c:out value="${data.contents}" escapeXml="false"/></p>
			</div>
			<!-- 수정버튼 -->
			<c:if test="${(isLogin == 'Y') && (data.userId == userInfo.userId)}"> <!--글쓴 사람만 나오게 -->
				<c:if test="${isLogin == 'Y'}">
					<p class="editBT">
						<a href="<c:url value='/mw/coustomer/viewUdateUseepil.do'/>?useEpilNum=${data.useEpilNum}" class="btn btn-reply">수정</a>
					</p>
				</c:if>
			</c:if>

			<c:if test="${isLogin == 'Y'}">
				<!-- 답글버튼 -->
				<%--<dt>
					<p class="comment-write border-hide">
						<a href="javascript:void(0)" onclick="fn_useepilCmtSH(${data.useEpilNum});" class="btn btn-reply">답글달기</a>
					</p>
					<!--답글폼-->
					<div id="ueContCmtDiv${data.useEpilNum}" style="display:none;">
						<textarea name="textarea" id="ueContCmt${data.useEpilNum}" cols="45" rows="5" class="focus-value" placeholder="내용 입력"></textarea>
						<p><a href="javascript:void(0)" onclick="fn_useepilCmtInsert('${data.useEpilNum}');" class="btn btn-submit">등록</a></p>
					</div>
				</dt>--%>
			</c:if>

			<ul class="comment-wrap">
				<!--답글-->
				<c:forEach var="dataCmt" items="${data.cmtList}" varStatus="status">
					<li>
						<div class="comment-user">
							<span class="comment-id">${dataCmt.email}</span> <span class="comment-date">${dataCmt.frstRegDttm}</span>
						</div>
						<div class="comment-memo">
							<c:out value="${dataCmt.contents}" escapeXml="false"/>
							<!-- 답글수정 버튼 -->
							<c:if test="${(isLogin == 'Y') && (dataCmt.userId == userInfo.userId)}">
								<p class="editBT">
									<a href="javascript:void(0)" onclick="fn_useepilCmtEditSH('${dataCmt.cmtSn}', '${dataCmt.useEpilNum}');" class="btn btn-reply">수정</a>
									<a href="javascript:void(0)" onclick="fn_useepilCmtDelete('${dataCmt.cmtSn}', '${dataCmt.useEpilNum}');" class="btn btn-reply">삭제</a>
								</p>
								<!--답글폼-->
								<div id="ueContCmtEditDiv${dataCmt.cmtSn}_${dataCmt.useEpilNum}" style="display: none;">
									<textarea name="textarea" id="ueContCmtEdit${dataCmt.cmtSn}_${dataCmt.useEpilNum}" cols="45" rows="5" class="focus-value" placeholder="내용 입력"><c:out value="${dataCmt.contentsOrg}"/></textarea>
									<p><a href="javascript:void(0)" onclick="fn_useepilCmtUpdate('${dataCmt.cmtSn}', '${dataCmt.useEpilNum}');" class="btn btn-submit">등록</a></p>
								</div>
							</c:if>
						</div>
					</li>
				</c:forEach>
			</ul>
		</dd>
	</dl>
</c:forEach>

<c:if test="${searchVO.pageIndex eq 1}">
	</div>

  	<c:if test="${fn:length(useepilList) ne 0}">
		<div class="paging-wrap" id="useMoreBtn">
			<%--<a href="javascript:void(0)" class="mobile" id="useMoreBtnLink" onclick="fn_useepilSearch();">더보기 <span id="useCurPage">1</span>/<span id="useTotPage">1</span></a> --%>
			<span class="mobile" id="useMoreBtnLink" onclick="fn_useepilSearch();">더보기 <span id="useCurPage">1</span>/<span id="useTotPage">1</span></span>
		</div>
  	</c:if>
</c:if>


