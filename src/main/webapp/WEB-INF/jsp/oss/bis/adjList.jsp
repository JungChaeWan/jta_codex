<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<table class="table01 right">
  <colgroup>
      <col />
      <col width="16%" />
      <col width="16%" />
      <col width="16%" />
      <col width="16%" />
      <col width="16%" />
  </colgroup>
  <thead>
      <tr>
          <th>업체명</th>
          <th>총 판매금액</th>
          <th>할인금액</th>
          <th>취소 수수료</th>
          <th>판매 수수료</th>
          <th>정산대상금액</th>
      </tr>
  </thead>
  <tbody>
  	<c:forEach items="${adjList }" var="adj">
      <tr>
          <td class="center" style="cursor:pointer;" onclick="fn_adjDtl('${adj.corpId}')"><b>${adj.corpNm }</b></td>		                
          <td><fmt:formatNumber value="${adj.saleAmt }" /></td>			                
          <td><fmt:formatNumber value="${adj.cmssAmt }" /></td>
          <td><fmt:formatNumber value="${adj.disAmt }" /></td>
          <td><fmt:formatNumber value="${adj.saleCmssAmt }" /></td>
          <td><fmt:formatNumber value="${adj.adjAmt }" /></td>
      </tr>
      </c:forEach>			            
      <c:if test="${fn:length(adjList) == 0 }">
      <tr>
          <td colspan="7">
          	<div class="not-content">검색된 결과가 없습니다.</div>
          </td>
      </tr>
      </c:if>
    </tbody>
</table>
<p class="list_pageing">
    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Paging" />
</p>