<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />
 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_Rsv'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
           	<form method="post">
			<h5 class="title06">예약 내역</h5>
			<div class="scroll-body">
	           <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<colgroup>
	                        <%-- <col width="5%" /> --%>
	                        <col width="10%" />
	                        <col width="8%" />
	                        <col />
	                        <col width="15%" />
	                        <col width="15%" />
	                        <col width="12%" />
	                        <col width="12%" />
	                        <col width="10%" />
	                        <%-- <col width="10%" /> --%>
	                    </colgroup>
						<thead>
							<tr>
								<!-- <th>번호</th> -->
								<th>예약번호</th>
								<th>예약상태</th>
								<th>상품명</th>							
								<th>예약자</th>
								<th>사용자</th>
								<th>대여일시</th>
								<th>반납일시</th>
								<th>판매금액</th>
								<!-- <th>예약일시</th> -->
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="9" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="rsvInfo" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;" onclick="fn_DetailRsv('${rsvInfo.rcRsvNum}')">
									<%-- <td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td> --%>
									<td class="align_ct">${rsvInfo.rsvNum}</td>
									<td class="align_ct">
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약대기</c:if>								
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">예약불가</c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><span class="font02">취소요청</span></c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
										<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
									</td>
									<td>${rsvInfo.prdtNm}</td>								
									<td class="align_ct">${rsvInfo.rsvNm} / ${rsvInfo.rsvTelnum}</td>
									<td class="align_ct">${rsvInfo.useNm} / ${rsvInfo.useTelnum }</td>
									<td class="align_ct">
										<fmt:parseDate value='${rsvInfo.rentStartDt}${rsvInfo.rentStartTm}' var='fromDttm' pattern="yyyyMMddHHmm" scope="page"/>
										<fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td class="align_ct">
										<fmt:parseDate value='${rsvInfo.rentEndDt}${rsvInfo.rentEndTm}' var='toDttm' pattern="yyyyMMddHHmm" scope="page"/>
										<fmt:formatDate value="${toDttm}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td class="align_ct">
										<fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber>
									</td>
									<%-- <td class="align_ct">${rsvInfo.regDttm}</td> --%>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
		</li>
	</ul>
