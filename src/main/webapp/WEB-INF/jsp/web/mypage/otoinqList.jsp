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
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">


function fn_otoinqDelete(otoinqNum){
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	
	document.frm.otoinqNum.value = otoinqNum;
	document.frm.action = "<c:url value='/web/mypage/otoinqDelete.do'/>";
	document.frm.submit();
}

$(document).ready(function () {
    $('div.memoWrap').click(function(event) {
        if ($(this).parents('ul').next('.re-comment').css('display') == 'none') {
            $('.re-comment').css('display', 'none');
            $(this).parents('ul').next('.re-comment').css('display', 'block');
        } else {
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
                <span>마이페이지</span> <span class="gt">&gt;</span>
                <span>나의 게시글 모음</span> <span class="gt">&gt;</span>
                <span>1:1문의</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="mypage sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                            	<jsp:include page="/web/mypage/left.do?menu=otoinq" flush="false"></jsp:include>
                            	
                                <div class="rContents smON">
                                    <h3 class="mainTitle">1:1 문의내역</h3>                                    
                                    <form name="frm" id="frm" method="post" onSubmit="return false;">
										<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
										<input type="hidden" id="otoinqNum" name="otoinqNum" value=""/>
										<ul class="order_lst">
											<li class="commCo2 list_tb myPoint2">
												<div class="in-td myPoin3__col1">번호</div>
												<div class="in-td myPoin3__col2">내용</div>
												<div class="in-td myPoin3__col3">진행상태/작성일</div>
											</li>
											<c:if test="${fn:length(otoinqList) != 0}">
												<c:forEach var="data" items="${otoinqList}" varStatus="status">
													<li class="commCo2 list_tb tbOption">
														<div class="goods_brand">
															<div class="goods_row">
																<div class="in-td myPoin3__col1 table-heght2">
																	<div class="number"><c:out value="${ totalCnt - (status.count + searchVO.pageSize*(searchVO.pageIndex-1) )  +1 }"/></div>
																</div>
																<div class="in-td myPoin3__col2 table-heght2">
																	<div class="memoWrap">
																		<div class="memoWrap--img">
																			<p class="product">${data.corpNm}</p>
																			<p class="title"><c:out value="${data.subject}"/></p>
																		</div>
																		<p class="memo">
																			<c:out value="${data.contents}" escapeXml="false"/>
																		</p>
																		<c:if test="${data.ansContents != '' }">
																		<div class="answerWrap--img">

																			<div class="memoWrap">
																				<p class="memo">
																					[${data.corpNm} 관리자]

																				</p>
																				<p class="memo">${data.ansContents}</p>
																			</div>
																		</div>
																		</c:if>
																	</div>
																</div>
																<div class="in-td myPoin3__col3 table-heght2">
																	<div class="progress">
																		<c:if test="${data.ansContents == '' }">
																			<p class="comment-count--red">답변대기</p>
																		</c:if>
																		<c:if test="${data.ansContents != '' }">
																			<p class="comment-count--blue">답변완료</p>
																		</c:if>
																		<p></p>
																		<p class="date"> ${data.frstRegDttm}</p>
																		<a href="<c:out value="/web/mypage/otoinqUpdateView.do"/>?otoinqNum=${data.otoinqNum}" class="coment-editBT">수정</a>
																		<a href="javascript:fn_otoinqDelete('${data.otoinqNum}')" class="coment-delBT">삭제</a>
																	</div>
																</div>
															</div>
														</div>
													</li>
													<c:if test="${data.ansContents != '' }">
														<ul class="commCo2 list_tb question re-comment">
															<li class="in-td myPoin3__col1 table-heght2"></li>
															<li class="in-td myPoin3__col2 table-heght2">
																<div class="memoWrap answer--line">
																	<div class="answerWrap--img">
																		<p class="memo answer"><c:out value="${data.ansContents}" escapeXml="false"/></p>
																	</div>
																</div>
															</li>
															<li class="in-td myPoin3__col3 table-heght2">
																<div>
																	<p class="date"> ${data.ansLastModDttm} </p>
																</div>
															</li>
														</ul>
													</c:if>
												</c:forEach>
											</c:if>
										</ul>

	                                    <!--콘텐츠 없을 시-->
	                                    <c:if test="${fn:length(otoinqList) == 0}">
	                                    	<p class="no-content">1:1 문의 내역이 없습니다.</p>
	                                    </c:if>
									</form>
                                
                                    <div class="pageNumber">
										<p class="list_pageing">
										<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
										</p>
									</div>
                                </div> <!--//rContents-->
                            </div> <!--//tbWrap-->
                        </div> <!--//inner-->
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