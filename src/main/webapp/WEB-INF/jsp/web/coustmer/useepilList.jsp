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

<head>
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 이용후기"/>
    <jsp:param name="description" value="제주도 항공권, 숙박, 렌터카, 관광지 최저가예약 관련 이용후기. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 이용후기">
<meta property="og:url" content="https://www.tamnao.com/web/coustmer/useepilList.do">
<meta property="og:description" content="제주도 항공권, 숙박, 렌터카, 관광지 최저가예약 관련 이용후기. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<script type="text/javascript">
	
	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex){
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/web/coustmer/useepilList.do'/>";
		document.frm.submit();
	}
	
	function fn_Ins(){
		document.frm.action = "<c:url value='/web/coustmer/viewInsertUseepil.do'/>";
		document.frm.submit();
	}
	
	//이용후기 사진뷰
	function review_photo(useEpilNum) {
		$.ajax({
			type:"post",
			url:"<c:url value='/web/cmm/useepilImgListDiv.ajax'/>",
			data:"useEpilNum=" + useEpilNum ,
			success:function(data){
				var review_img = "";
				review_img += "<div class='img-preview'>- 이미지 미리보기<a class='photo_close' href='javascript:void(0)' onclick='review_close();'><img src='/images/web/icon/close3.png' alt='닫기'></a></div>";
				review_img += "<div class='custom-container gallery-view2 detail-view1'>";
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
	
	
	$(document).ready(function(){
	    var speed = 300;
	    $('a.reduction').click(function(event) {
	        if ($(this).parents('tr').next('.re-comment').css('display')=='none') {
	            $('.re-comment').css('display', 'none');
	            $(this).parents('tr').next('.re-comment').css('display', 'table-row');
	        }
	        else {
	            $('.re-comment').css('display', 'none');
	        }
	    });
	});
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
                                   	<form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
	                                    <div class="commBoard-wrap">
	                                        <div class="board-list">
	                                            <div class="bdSearch">
	                                                <p class="cmTitle cmInfo">총 <span>${totalCnt }</span>개의 게시물이 있습니다.</p>
	                                                <div class="searchForm">
	                                                	<%--
	                                                    <select id="search">
	                                                        <option value="">작성자</option>
	                                                        <option value="" selected>제목</option>
	                                                        <option value="">내용</option>
	                                                    </select>
	                                                     --%>
	                                                    <input class="int" type="text" id="sSubject" name="sSubject" value="<c:out value='${searchVO.sSubject}'/>">
	                                                    <input class="button" type="image" src="<c:url value='/images/web/board/search.png'/>" alt="검색" onclick="javascript:fn_Search('1')">
	                                                </div>
	                                            </div>
	                                            <div class="bdList">
	                                                <table class="commCol review-list">
	                                                    <thead>
	                                                        <tr>
	                                                            <th class="title1">번호</th>
	                                                            <th class="title2">제목</th>
	                                                            <th class="title3">작성자</th>
	                                                            <th class="title4">등록일</th>
	                                                        </tr>
	                                                    </thead>
	                                                    <tbody>
	                                                    	<c:if test="${fn:length(useepilList) == 0}">
	                                                    		<tr>
		                                                            <td colspan="4" class="no-content">검색결과가 존재하지 않습니다.</td>
		                                                        </tr>
	                                                    	</c:if>
	                                                    	<c:forEach var="data" items="${useepilList}" varStatus="status">

		                                                        <tr>
		                                                            <td><c:out value="${ totalCnt - (status.count + searchVO.pageSize*(searchVO.pageIndex-1) )  +1 }"/></td>
		                                                            <td class="left">
		                                                                <a class="reduction" id="useepil-title">
		                                                                    <span>[</span><span class="product"><c:out value="${data.subjectHeder}"/></span><span>]</span> <c:out value="${data.subject}"/>
		                                                                </a>
		                                                            </td>
		                                                            <td><c:out value="${data.email}" /></td>
		                                                            <td>${fn:substring(data.frstRegDttm,0,10)}</td>
		                                                        </tr>
		                                                        <!-- 이용후기 추가 -->
		                                                        <tr class="re-comment">
		                                                            <td colspan="4">
		                                                                <dl class="default-accordion2 reviews-ad">
		                                                                    <dt>
		                                                                        <ul class="tbOption">
		                                                                            <li class="memoWrap">
																						<c:if test="${fn:length(data.imgList) != 0 }">
			                                                                            	<div class="photo-area"> <!-- 사진 없을 시 div 삭제 -->
										                                                    	<div class="photo-wrap">
										                                                    		<p class="photo"><img src="<c:url value='${data.imgList[0].savePath }thumb/${data.imgList[0].saveFileNm }'/>" alt="review"></p>
										                                                    		<div class="over-rap">
										                                                    			<%-- <a class="add-btn" href="javascript:void(0)" onclick="review_photo('${data.useEpilNum}');">+${fn:length(data.imgList) }</a> --%>
										                                                    			<span class="add-btn" onclick="review_photo('${data.useEpilNum}');" style="cursor: pointer;">+${fn:length(data.imgList) }</span>
										                                                    		</div>
									                                                    		</div>
										                                                </c:if>
																							<div class="text-area">
																								<p class="user-info">
																									<span class="heart">
																										<c:if test="${data.gpa >= 1 }"><img src="<c:url value='/images/web/icon/star_on.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa < 1 }"><img src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa >= 2 }"><img src="<c:url value='/images/web/icon/star_on.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa < 2 }"><img src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa >= 3 }"><img src="<c:url value='/images/web/icon/star_on.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa < 3 }"><img src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa >= 4 }"><img src="<c:url value='/images/web/icon/star_on.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa < 4 }"><img src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa >= 5 }"><img src="<c:url value='/images/web/icon/star_on.png'/>" alt="좋아요"></c:if>
																										<c:if test="${data.gpa < 5 }"><img src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></c:if>
																									</span>
																									<span class="date">|&nbsp;&nbsp;</span>
																									<span class="date">${data.frstRegDttm}</span>
																									<c:if test="${isLogin=='Y' && data.userId == userInfo.userId}">
																										<a href="<c:url value='/web/coustmer/viewUdateUseepil.do'/>?useEpilNum=${data.useEpilNum}">[ 수정 ]</a>
																									</c:if>
																								</p>
																								<%-- <h5 class="user-title">제주 신라호텔로 떠난 힐리여행♥ 강추합니다</h5>--%>
																								<p class="user-memo">
																									<c:out value="${data.contents}" escapeXml="false"/>
																									<span class="comment-count">(${data.cmtCnt})</span>
																								</p>
																							</div>
																							</div>
		                                                                            </li>
		                                                                        </ul>
		                                                                    </dt>
		                                                                    <c:if test="${fn:length(data.cmtList) != 0}">
			                                                                    <dd>
			                                                                    	<c:forEach var="dataCmt" items="${data.cmtList}" varStatus="status">
				                                                                        <ul class="re_comment">
				                                                                            <li class="ic2"><img src="<c:url value='/images/web/mypage/answer.png'/>" alt="re"></li>
				                                                                            <li class="re">
				                                                                                <c:out value="${dataCmt.contents}" escapeXml="false"/>
				                                                                            </li>
				                                                                        </ul>
				                                                                    </c:forEach>
			                                                                    </dd>
			                                                            	</c:if>
		                                                                </dl>
		                                                            </td>
		                                                        </tr>
		                                                    </c:forEach>
															<%--
	                                                        <tr>

	                                                            <td>1</td>
	                                                            <td class="left">
	                                                                <span>[</span><span class="product">상품명</span><span>]</span> 자주 하시는 질문들을 한방에~
	                                                            </td>
	                                                            <td>김철수</td>
	                                                            <td>2015-12-31</td>
	                                                        </tr>
	                                                         --%>
	                                                    </tbody>
	                                                </table>

	                                                <!-- 이용후기 사진 레이어 팝업 (클릭시 호출) -->
													<div class="detail-gallery review-gallery"></div> <!--//review-gallery-->
	                                            </div> <!--//bdList-->
												<c:if test="${isLogin=='Y'}">
	                                            	<div class="boardBT"><a href="javascript:fn_Ins()">글쓰기</a></div>
	                                            </c:if>
	                                        </div> <!--//board-list-->
	                                    </div> <!--//commBoard-wrap-->
	                            	</form>

	                            	<c:if test="${fn:length(useepilList) != 0}">
		                            	<div class="pageNumber">
											<p class="list_pageing">
												<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
											</p>
										</div>
	                            	</c:if>
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