<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<%-- 큐레이션 메인 --%>
<c:if test="${'Y' eq searchVO.sCrtnMainYn}">
	<ul>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<c:if test="${!empty result.saveFileNm }">
			<li <c:if test="${(paginationInfo.currentPageNo eq 1) and (status.count eq 1)}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if>>
		        <div class="social-photo">
					<div class="bxLabel">
						<c:if test="${result.eventCnt > 0}">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${result.couponCnt > 0}">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${result.jqYn eq 'Y'}">
							<span class="main_label back-red">JQ 인증</span>
						</c:if>
						<c:if test="${result.superbSvYn eq 'Y'}">
							<span class="main_label back-purple">공모전 수상작</span>
						</c:if>
						<c:if test="${result.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<!-- 20211214 탐나는전 label 추가 -->
						<c:if test="${result.tamnacardYn eq 'Y'}">
							<span class="main_label yellow">탐나는전</span>
						</c:if>
					</div>
		            <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${result.prdtNum}'/>">
		                <img src="${result.savePath}thumb/${result.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
		            </a>
		        </div>		
	            <div class="text">
	                <div class="title"><c:out value='${result.prdtNm}' /></div>
	                <div class="info">
	                    <dl>
	                    	<dt></dt>
	                        <dd>
	                            <div class="price">
	                                <strong><fmt:formatNumber value="${result.saleAmt}" type="number"/>원</strong>
	                            </div>
	                        </dd>
	                    </dl>
	                </div>
	            </div>
			</li>
			</c:if>
		</c:forEach>
	</ul>
  	<c:if test="${fn:length(resultList) == 0}">
		<div class="item-noContent" id="pageInfoCnt" totalCnt="0" totalPageCnt="0">
			<p><img src="/images/mw/sub_common/warning.png" alt="경고"></p>
			<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
		</div>
  	</c:if>
</c:if>
<%-- 큐레이션 메인 X --%>
<c:if test="${'Y' ne searchVO.sCrtnMainYn}">
	<%-- 통합검색 X --%>
	<c:if test="${'Y' ne totSch}">
		<!--intro 화면 리스트 수 제한-->
		<ul>
			<c:set var="endCount" value="${'SVIntro' eq totSch ? '3' : '9999'}" />
			<c:forEach items="${resultList}" var="result" varStatus="status" end="${endCount}" >
				<c:if test="${!empty result.saveFileNm }">
				<li <c:if test="${(paginationInfo.currentPageNo eq 1) and (status.count eq 1)}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if>>
					<a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${result.prdtNum}'/>">
						<div class="social-photo">
							<div class="bxLabel">
								<c:if test="${result.eventCnt > 0}">
									<span class="main_label eventblue">이벤트</span>
								</c:if>
								<c:if test="${result.couponCnt > 0}">
									<span class="main_label pink">할인쿠폰</span>
								</c:if>
								<c:if test="${result.jqYn eq 'Y'}">
									<span class="main_label back-red">JQ 인증</span>
								</c:if>
								<c:if test="${result.superbSvYn eq 'Y'}">
									<span class="main_label back-purple">공모전 수상작</span>
								</c:if>
								<c:if test="${result.superbCorpYn == 'Y' }">
									<span class="main_label back-red">우수관광사업체</span>
								</c:if>
								<!-- 20211214 탐나는전 label 추가 -->
								<c:if test="${result.tamnacardYn eq 'Y'}">
									<span class="main_label yellow">탐나는전</span>
								</c:if>
							</div>
							<img src="${result.savePath}thumb/${result.saveFileNm}" alt="${result.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">
						</div>
						<div class="text">
							<c:if test="${'SVIntro' eq totSch}">
							<div class="prd_name">${result.prdtInf}</div>
							</c:if>
							<div class="title"><c:out value='${result.prdtNm}' /></div>
							<div class="info">
								<dl>
									<dt></dt>
									<dd>
										<div class="price">
											<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/><span class="won">원</span></strong>
											<c:if test="${result.saleAmt ne result.nmlAmt}">
												<del><fmt:formatNumber value="${result.nmlAmt}" type="number"/>원</del>
											</c:if>
										</div>
									</dd>
								</dl>
							</div>
						</div>
					</a>
				</li>
				</c:if>
			</c:forEach>
		</ul>
		<c:if test="${fn:length(resultList) == 0}">
			<div class="item-noContent" id="pageInfoCnt" totalCnt="0" totalPageCnt="0">
				<p><img src="/images/mw/sub_common/warning.png" alt="경고"></p>
				<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
			</div>
		</c:if>
  	</c:if>
	<%-- 통합검색 --%>
 	<c:if test="${'Y' eq totSch}">
		<div class="prdt-wrap">
			<c:forEach items="${resultList}" var="result" varStatus="status">
				<c:if test="${!empty result.saveFileNm }">
				<c:if test="${!(totSch == 'Y' && status.index >= 8)}"><%-- 통합검색에서 온거면 8개만 --%>
					<div class="goods-list">
						<a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${result.prdtNum}'/>">
							<div class="goods-image goods-image1">
								<ul class="view">
									<li><img src="${result.savePath}thumb/${result.saveFileNm}" alt="${result.prdtNm}"></li>
								</ul>
							</div>
							<p class="info">
								<span class="txt">
									<em><c:out value="${result.prdtInf}"/></em>
									<strong><c:out value='${result.prdtNm}' /></strong>
								</span>
								<span class="price">
									<strong><fmt:formatNumber value="${result.saleAmt}" type="number"/>원</strong>
									<c:if test="${result.saleAmt ne result.nmlAmt}">
										<del><fmt:formatNumber value="${result.nmlAmt}" type="number"/></del>
									</c:if>
								</span>
								<span class="bxLabel">
									<c:if test="${result.eventCnt > 0}">
										<span class="main_label eventblue">이벤트</span>
									</c:if>
									<c:if test="${result.couponCnt > 0}">
										<span class="main_label pink">할인쿠폰</span>
									</c:if>
									<c:if test="${result.jqYn eq 'Y'}">
										<span class="main_label back-red">JQ 인증</span>
									</c:if>
									<c:if test="${result.superbSvYn eq 'Y'}">
										<span class="main_label back-purple">공모전 수상작</span>
									</c:if>
									<c:if test="${result.superbCorpYn == 'Y' }">
										<span class="main_label back-red">우수관광사업체</span>
									</c:if>
									<!-- 20211214 탐나는전 label 추가 -->
									<c:if test="${result.tamnacardYn eq 'Y'}">
										<span class="main_label yellow">탐나는전</span>
									</c:if>
								</span>
							</p>
						</a>
					</div>
				</c:if>
				</c:if>
			</c:forEach>
		</div>

  		<c:if test="${fn:length(resultList) == 0}">
			<div class="item-noContent">
				<p class="icon"><img src="/images/mw/sub_common/warning.png" alt="경고"></p>
				<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
			</div>
  		</c:if>
  	</c:if>
</c:if>
