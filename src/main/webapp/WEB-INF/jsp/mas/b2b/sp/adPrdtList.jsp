<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>


            	<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> 
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
						<col width="5%" />
						<col />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>업체명</th>
							<th>유형</th>
							<th>지역</th>
							<th>명칭</th>
							<th>기준인원(최대)</th>
							<th>조식포함</th>
							<th>요금정보</th>
							<th>예약</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="11" class="align_ct">
									<spring:message code="common.nodata.msg" />
								</td>
							</tr>
						</c:if>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct"><c:out value="${result.adNm}" /></td>
								<td class="align_ct"><c:out value="${result.adDivNm}" /></td>
								<td class="align_ct"><c:out value="${result.adAreaNm}" /></td>
								<td class="align_ct"><c:out value="${result.prdtNm}" /></td>
								<td class="align_ct">
									<c:out value="${result.stdMem}" />(<c:out value="${result.maxiMem}" />)</td>
								<td class="align_ct"><c:out value="${result.breakfastYn}" /></td>
								<td class="align_ct">
									<fmt:formatNumber><c:out value="${result.totalSaleAmt}" /></fmt:formatNumber>
								</td>
								<td class="align_ct">
									<a onclick="fn_InstantBuy('${result.prdtNum}')" class="btn sm blue">예약</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>

