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
           

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="author" content="넥스트이지" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />

	<title>관리자페이지</title>
	<!-- css -->	
	<link rel="stylesheet" href="<c:url value='/css/comm/jquery-ui.css'/>" />
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/comm_default.css'/>" />
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/comm_style.css'/>" />
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/frame.css'/>" />
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/style.css'/>" />
	
	<!-- script -->
	<script src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
	<script src="<c:url value='/js/jquery-ui-1.11.4.js'/>"></script>
	<script src="<c:url value='/js/adm_mw/html_comm.js'/>"></script>
	<script src="<c:url value='/js/adm_mw/html_style.js'/>"></script>


	<script type="text/javascript">
	
	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex){
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/mw/mas/rc/rsvList.do'/>";
		document.frm.submit();
	}
	
	function fn_DetailRsv(svRsvNum){
		$("#rcRsvNum").val(svRsvNum);
		document.frm.action = "<c:url value='/mw/mas/rc/detailRsv.do'/>";
		document.frm.submit();
	}
	
	$(document).ready(function() {
		$("#sRentStartDtView").datepicker({
			dateFormat : "yy-mm-dd",
			minDate : "${today}",
			maxDate : '+1y'
		});
		
		$('#sRentStartDtView').change(function() {
			$('#sRentStartDt').val($('#sRentStartDtView').val().replace(/-/g, ''));
		});
		
		$("#sStartDt").datepicker({
			dateFormat : "yy-mm-dd"
		});
		$("#sEndDt").datepicker({
			dateFormat : "yy-mm-dd"
		});
	});
	
	</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/mw/mas/head.do?menu=rsv" flush="false"></jsp:include>
		<main id="main">
			<section class="contents-wrap">
                <!--change content-->
				<div class="search-form">
					 <form name="frm" method="post" onSubmit="return false;">
						<input type="hidden" id="rsvNum" name="rsvNum" />
						<input type="hidden" id="rcRsvNum" name="rcRsvNum" />
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
						<dl>
							<dt>예약일자</dt>
							<dd>
								<div class="date-container">
									<span class="date-wrap"><input class="datepicker" type="text" id="sStartDt" name="sStartDt" value="${searchVO.sStartDt}" title="검색시작일" readonly></span>
									<span class="date-guide">~</span>
									<span class="date-wrap"><input class="datepicker" type="text" id="sEndDt" name="sEndDt"  title="검색종료일"  readonly value="${searchVO.sEndDt}"></span>
								</div>
							</dd>
						</dl>
						<dl>
							<dt>예약상태</dt>
							<dd>
								<select title="예약상태 선택" name="sRsvStatusCd" class="width100">
									<option value="">전체</option>
   									<%-- <option value="${Constant.RSV_STATUS_CD_READY}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_READY}">selected="selected"</c:if>>예약처리중</option> --%>
   									<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>예약</option>
   									<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
   									<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청</option>
   									<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>취소완료</option>
   									<%-- <option value="${Constant.RSV_STATUS_CD_SREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">selected="selected"</c:if>>부분환불요청</option>
   									<option value="${Constant.RSV_STATUS_CD_SCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">selected="selected"</c:if>>부분환불완료</option>
   									<option value="${Constant.RSV_STATUS_CD_ACC}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">selected="selected"</c:if>>자동취소</option> --%>
   									<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>사용완료</option>
   									<%-- <option value="${Constant.RSV_STATUS_CD_ECOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">selected="selected"</c:if>>기간만료</option> --%>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>상품</dt>
							<dd>
								<select title="상품 선택" class="width100" id="sPrdtNum" name="sPrdtNum">
									<option value="">전체</option>
									<c:forEach items="${prdtList}" var="prdt" varStatus="status">
										<option value="${prdt.prdtNum}" <c:if test="${searchVO.sPrdtNum == prdt.prdtNum}">selected="selected"</c:if>>${prdt.prdtNm}</option>
									</c:forEach>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>대여일</dt>
							<dd>
								<input type="hidden" name="sRentStartDt" id="sRentStartDt" value="${searchVO.sRentStartDt}" />
								<div class="date-container">
									<span class="date-wrap width100"><input class="datepicker" type="text" id="sRentStartDtView" name="sRentStartDtView" value="${searchVO.sRentStartDtView}" title="검색하실 대여일을 입력하세요." maxlength="10"></span>
								</div>
							</dd>
						</dl>
						<dl>
							<dt>예약자</dt>
							<dd>
								<input type="text" class="width100" id="sRsvNm" name="sRsvNm" value="${searchVO.sRsvNm}"  maxlength="20" placeholder="이름">
							</dd>
						</dl>
						<dl>
							<dt>전화번호</dt>
							<dd>
								<input type="tel" class="width100" id="sRsvTelnum" name="sRsvTelnum" value="${searchVO.sRsvTelnum}" maxlength="13" placeholder="전화번호">
							</dd>
						</dl>
						
						<div class="btn-wrap">
							<button type="button" class="btn blue" onclick="javascript:fn_Search('1')">검색</button>
						</div>
					</form>
				</div>
				<p class="cap-memo">※ 고객이 유선상으로 예약 취소 의사를 밝혔을 경우, 시스템 상 ‘취소처리’진행이 꼭 필요합니다.</p>
			
				<h3 class="title2">검색결과 <small>[총 <strong class="text-blue">${totalCnt}</strong>건]</small></h3>
                <ul class="rese-list">
                	<c:forEach var="rsvInfo" items="${resultList}" varStatus="status">
                	<c:if test="${fn:length(resultList) == 0}">
						<li>
							<spring:message code="common.nodata.msg" />
						</li>
					</c:if>
				    <li>
                        <table class="table-row">
                            <colgroup>
                                <col style="width: 32%">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th rowspan="4">
                                        <div class="rese-number">
                                            <p class="number"><strong>${rsvInfo.rsvNum}</strong></p>
                                            
                                            <c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}"><p class="msg">(예약대기)</p></c:if>								
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}"><p class="msg">(예약불가)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}"><p class="msg">(예약)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><p class="msg text-red">(취소요청)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}"><p class="msg">(환불요청)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}"><p class="msg">(취소)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}"><p class="msg">(사용완료)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}"><p class="msg">(기간만료)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}"><p class="msg">(자동취소)</p></c:if>	
                                            <c:if test="${rsvInfo.rsvIdtYn == 'Y'}">
											<p class="icon"><img src="<c:url value='/images/adm_mw/icon/temp/blue_check.png'/>" alt="예약확인"></p>
											</c:if>
											
											<div class="btn-wrap">
												<p><a href="javascript:fn_DetailRsv('${rsvInfo.rcRsvNum}')" class="btn white">상세보기</a></p>
											</div>
                                        </div>
                                    </th>
                                    <td>
                                        <dl class="rese-detail">
                                            <dt>상품정보</dt>
                                            <dd>
                                            	<fmt:parseDate value='${rsvInfo.rentStartDt}${rsvInfo.rentStartTm}' var='fromDttm' pattern="yyyyMMddHHmm" scope="page"/>
                                            	<fmt:parseDate value='${rsvInfo.rentEndDt}${rsvInfo.rentEndTm}' var='toDttm' pattern="yyyyMMddHHmm" scope="page"/>
                                            	<p><c:out value="${rsvInfo.prdtNm}" /></p>
												<p><fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${toDttm}" pattern="yyyy-MM-dd HH:mm"/></p>
                                            </dd>
                                        </dl>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dl class="rese-detail">
                                            <dt>예약자</dt>
                                            <dd>
                                                <p>${rsvInfo.rsvNm} / ${rsvInfo.rsvTelnum}</p>
                                            </dd>
                                        </dl>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dl class="rese-detail">
                                            <dt>사용자</dt>
                                            <dd>
                                                <p>${rsvInfo.useNm} / ${rsvInfo.useTelnum }</p>
                                            </dd>
                                        </dl>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dl class="rese-detail">
                                            <dt>판매금액</dt>
                                            <dd>
                                                <p><fmt:formatNumber>${rsvInfo.nmlAmt}</fmt:formatNumber> 원</p>
                                            </dd>
                                        </dl>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
				    </li>
				    </c:forEach>
				</ul>
				
				<div class="paging-wrap">
					<ul>
						<ui:pagination paginationInfo="${paginationInfo}" type="masMw" jsFunction="fn_Search" />
					</ul>
				</div>
                <!--//change content-->
				
			</section> <!--//contents-wrap-->
		</main>

		<footer id="footer">
			
		</footer>
	</div>
</body>
</html>