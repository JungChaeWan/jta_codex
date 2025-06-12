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

<section class="ad_qna">
<div class="type-bodyA">
	<dl class="typeA">
       <dt>1:1문의</dt>
       <dd>
	       <div class="prod-inquiry-list__emphasis">
				<ul>
					<c:if test="${isLogin!='Y'}">
					<li>1:1 문의는 로그인 후 서비스를 이용하실 수 있습니다.</li>
					</c:if>
					<li>구매한 상품의 취소/환불은 마이페이지를 이용해 주세요.</li>
					<li>상품과 관계없는 광고, 욕설, 비방 등의 글은 사전 예고 없이 삭제처리 됩니다.</li>
				</ul>
		    </div>
		    <!-- 기존코드 동일 -->
		    <div class="review-regi">
			    <form name="otoinqFrm" id="otoinqFrm" method="post" onsubmit="return false;">
			        <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="corpId" value="${OTOINQVO.corpId}" />
					<input type="hidden" name="prdtNum" value="${OTOINQVO.prdtNum}" />
					<input type="hidden" name="corpCd" value="${searchVO.corpCd}" />
					<input type="hidden" name="subject" value="" />
					<input type="hidden" name="contents" value="" />
					<input type="hidden" name="otoinqNum" id="otoinqNum" value="" />
			    </form>
			    <c:if test="${isLogin=='Y'}">
			    <div class="regi">
			        <div class="int">
			            <ul>
			                <li class="left">
			                    <input id="oto_subject" class="int-title" type="text" placeholder="제목을 입력해 주세요.">
			                    <textarea id="oto_contents" class="review-t" placeholder="문의 내용을 입력해 주세요. [500자 제한]"></textarea>
			                </li>
			                <li class="right">
			                    <input type="image" src="<c:url value='/images/web/button/regi.gif'/>" alt="등록" onclick="fn_otoinqInsert();">
			                </li>
			            </ul>
			        </div>
			    </div>
			    </c:if>
			</div>
		    <div class="review-list">
		        <ul>
		        	<c:if test="${fn:length(otoinqList) == 0}">
		    		<li class="commentWrap">
			           <div class="area-l">
			               <p class="user-info-2"></p>
			               <p class="title"><strong>1:1문의가 없습니다.</strong></p>
			           </div>                                               
			        </li>
			    	</c:if>
			    	<c:forEach var="data" items="${otoinqList}" varStatus="status">

		            <li class="commentWrap" <%--<c:if test='${status.count > 3}'>style="display:none"</c:if>--%> >
		                <div class="prod-inquiry-item">
							<em class="prod-inquiry-item__label">질문</em>
							<div class="prod-inquiry-item__wrap">
								<strong class="prod-inquiry-item__author">${data.email}</strong>
								<div class="prod-inquiry-item__title">${data.subject}</div>
								<div class="prod-inquiry-item__content"><c:out value="${data.contents}" escapeXml="false"/></div>
								<p class="user-info">
								  <c:if test="${isLogin=='Y' && data.writer == userInfo.userId}">
									<span>
										<a href="javascript:fn_otoinqEditSH('${data.otoinqNum}')" class="coment-editBT">수정</a>
										   <a href="javascript:fn_otoinqDelete('${data.otoinqNum}')" class="coment-delBT">삭제</a>
									</span>
								  </c:if>
								</p>
								<c:if test="${isLogin=='Y' && data.writer == userInfo.userId}">
								<div class="regi regi-edit" id="otoContEditDiv${data.otoinqNum}" style="display: none;">
									<div class="int">
										<ul>
											<li class="left">
												<input class="int-title" type="text" placeholder="제목을 입력해 주세요." id="oto_SubjectEdit${data.otoinqNum}" name=otoSubjectEdit${data.otoinqNum}" maxlength="255" value="<c:out value='${data.subject}'/>" />
												<textarea class="review-t" placeholder="문의 내용을 입력해 주세요. [500자 제한]" id="oto_contentsEdit${data.otoinqNum}"><c:out value="${data.contentsOrg}"/></textarea>
											</li>
											<li class="right">
												<a href="javascript:fn_otoinqUpdate('${data.otoinqNum}')" class="commentBT2">수정</a>
											</li>
										</ul>
									</div>
								</div>
								</c:if>
								<div class="prod-inquiry-item__time">${data.frstRegDttm}</div>
							</div>
							<c:if test="${data.ansContents != '' }">
		                    <div class="prod-inquiry-item__reply">
		                        <div class="ic"><img src="<c:url value='/images/web/icon/re2.png'/>" alt="re"></div>
								<em class="prod-inquiry-item__reply__label">답변</em>
		                        <div class="prod-inquiry-item__reply__wrap">
		                            <strong class="prod-inquiry-item__reply__author"><c:out value="${data.corpNm}"/></strong>
									<div class="prod-inquiry-item__reply__content"><c:out value="${data.ansContents}" escapeXml="false"/></div>
									<div class="prod-inquiry-item__reply__time">${data.ansFrstRegDttm}</div>
		                        </div>
		                    </div>
		                    </c:if>
		                </div>
		            </li>
		            </c:forEach>
		        </ul>
		        <div class="pageNumber">
		            <p class="list_pageing">
						<%--<a href="javascript:$('.commentWrap').show();$('.list_pageing').text('');">전체보기</a>--%>
						<ui:pagination paginationInfo="${otoinqPaginationInfo}" type="web" jsFunction="fn_otoinqSearch" />
		           	</p>
		        </div>
		    </div>
		</dd>
	</dl>
</div>
</section>