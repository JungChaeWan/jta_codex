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

			    <table class="table01 center" style="border-top: none;">
			        <colgroup>
			            <col />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			        </colgroup>
			        <thead>
			            <tr>
			                <th>구분</th>
			                <th>전체상품</th>
			                <th>등록중</th>
			                <th>승인요청</th>
			                <th>승인</th>
			                <th>승인거절</th>
			                <th>판매중지</th>
			                <th>수정요청</th>
			                <th>거래중지</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<c:forEach items="${dayCorpList}" var="dayCorp" varStatus="status">
			        		<tr>
			        			<td><c:out value="${dayCorp.prdtDivNm}"/></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.totalPrdtCnt}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt01}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt02}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt03}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt04}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt05}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt06}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.prdtCnt07}"/></fmt:formatNumber></td>
			        		</tr>
			        	</c:forEach>
			        </tbody>
			    </table>
