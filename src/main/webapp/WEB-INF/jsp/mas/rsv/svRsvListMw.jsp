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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="author" content="넥스트이지">
	<meta name="format-detection" content="telephone=no">
	<meta name="apple-mobile-web-app-capable" content="yes">

	<title>관리자페이지</title>
	<!-- css -->	
	<link rel="stylesheet" href="<c:url value='/css/comm/jquery-ui.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/comm_default.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/comm_style.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/frame.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/adm_mw/style.css'/>">
	
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
		document.frm.action = "<c:url value='/mw/mas/sv/rsvList.do'/>";
		document.frm.submit();
	}
	
	function fn_DetailRsv(svRsvNum){
		$("#svRsvNum").val(svRsvNum);
		document.frm.action = "<c:url value='/mw/mas/sv/detailRsv.do'/>";
		document.frm.submit();
	}
	
	function fn_ShowInsDlvNum(svRsvNum) {
		$("#dlvNum").val('');
		$("#SV_DLVINF input[name=svRsvNum]").val(svRsvNum);
		layer_popup($("#div_InsDlvNum"));
	}

	function fn_InsDlvNum() {
		$("#SV_DLVINF input[name=dlvCorpNm]").val($("#dlvCorpCd option:selected").text());
		
		var parameters =  $("#SV_DLVINF").serialize();
		var confirmText = "배송업체 : " + $("#dlvCorpCd option:selected").text() + "\n"
		+ "운송장번호 : " + $("#dlvNum").val() + "\n\n"
		+ "입력하신 정보가 정확한지 다시 한번 확인해 주세요. 등록을 완료하면 고객님께 운송장 정보가 전달됩니다. 등록하시겠습니까?";
		
		if(confirm(confirmText)) {
			$.ajax({
				type:"post",
				dataType:"json",
				url:"<c:url value='/mas/sv/insertDlvNum.ajax'/>",
				data: parameters,
				success : function(data) {
					fn_Search($("#pageIndex").val());
				}
			});
		}
	}
	
	$(document).ready(function() {
		$("#sStartDt").datepicker({
			dateFormat : "yy-mm-dd"
		});
		$("#sEndDt").datepicker({
			dateFormat : "yy-mm-dd"
		});
	});
	</script>
<body>
	<div id="wrap">
		<jsp:include page="/mw/mas/head.do?menu=rsv" flush="false"></jsp:include>
		<main id="main">
			<section class="contents-wrap">
                <!--change content-->
				<div class="search-form">
					 <form name="frm" method="post" onSubmit="return false;">
					 	<input type="hidden" id="rsvNum" name="rsvNum" />
						<input type="hidden" id="svRsvNum" name="svRsvNum" />
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
						<dl>
							<dt>구매일자</dt>
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
									<option value="" <c:if test="${empty searchVO.sRsvStatusCd}">selected</c:if>>전체</option>
    								<option value="${Constant.RSV_STATUS_CD_COM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_COM}">selected="selected"</c:if>>결제완료</option>
            						<option value="${Constant.RSV_STATUS_CD_CREQ}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">selected="selected"</c:if>>취소요청</option>
            						<option value="${Constant.RSV_STATUS_CD_CREQ2}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">selected="selected"</c:if>>환불요청</option>
            						<option value="${Constant.RSV_STATUS_CD_CCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">selected="selected"</c:if>>취소완료</option>
            						<option value="${Constant.RSV_STATUS_CD_DLV}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">selected="selected"</c:if>>배송중</option>
            						<option value="${Constant.RSV_STATUS_CD_UCOM}" <c:if test="${searchVO.sRsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">selected="selected"</c:if>>구매확정</option>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>상품</dt>
							<dd>
								<input type="text" class="width100" id="sPrdtNm" name="sPrdtNm" value="${searchVO.sPrdtNm}" placeholder="상품명을 입력하세요">
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
                                    <th rowspan="5">
                                        <div class="rese-number">
                                            <p class="number"><strong>${rsvInfo.rsvNum}</strong></p>
                                            
                                            <c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}"><p class="msg">(미결제)</p></c:if>								
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}"></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}"><p class="msg">(결제완료)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}"><p class="msg text-red">(고객취소요청)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}"><p class="msg">(환불요청)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}"><p class="msg">(취소)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}"><p class="msg">(구매확정)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}"><p class="msg">(기간만료)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}"><p class="msg">부분환불완료</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}"><p class="msg">(자동취소)</p></c:if>
											<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}"><p class="msg">(배송중)</p></c:if>	
                                            <c:if test="${rsvInfo.rsvIdtYn == 'Y'}">
											<p class="icon"><img src="<c:url value='/images/adm_mw/icon/temp/blue_check.png'/>" alt="예약확인"></p>
											</c:if>
											
											<div class="btn-wrap">
												<p><a href="javascript:fn_DetailRsv('${rsvInfo.svRsvNum}')" class="btn white">상세보기</a></p>
											</div>
                                        </div>
                                    </th>
                                    <td>
                                        <dl class="rese-detail">
                                            <dt>상품정보</dt>
                                            <dd>
                                            	<p><c:out value="${rsvInfo.prdtNm}" /></p>
												<p><c:out value="${rsvInfo.prdtInf}" /></p>
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
                                                <p><fmt:formatNumber>${rsvInfo.saleAmt}</fmt:formatNumber> 원</p>
                                            </dd>
                                        </dl>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dl class="rese-detail">
                                            <dt>운송장정보</dt>
                                            <dd>
                                            	<c:choose>
													<c:when test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
														<p><a href="javascript:fn_ShowInsDlvNum('${rsvInfo.svRsvNum}')" class="btn white sm">운송장등록</a></p>
													</c:when>
                                                	<c:when test="${not empty rsvInfo.dlvNum}">
                                                		<p><c:out value="${rsvInfo.dlvCorpNm}" /> / <c:out value="${rsvInfo.dlvNum}"/></p>
                                               	 	</c:when>
                                               	 	<c:otherwise>
                                               	 		<p>-</p>
                                               	 	</c:otherwise>
                                               	 </c:choose>
                                            </dd>
                                        </dl>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
				    </li>
				    </c:forEach>
				</ul>
                <!--//change content-->
				
				<!--layer popup-->
                <div id="div_InsDlvNum" class="layer-popup">
                    <div class="content-wrap">
                        <div class="content">
                            <div class="head">
                                <h3 class="title">운송장정보입력</h3>
                                <button type="button" class="close"><img src="<c:url value='/images/adm_mw/icon/basic/popup_close.png'/>" alt="닫기"></button>
                            </div>
							<form name="SV_DLVINF" id="SV_DLVINF" method="post" onSubmit="return false">
							<input type="hidden" name="svRsvNum" />
							<input type="hidden" name="dlvCorpNm" />
                            <div class="main">
                                <div class="scroll" style="height: auto">
                                    <table class="table-row">
                                        <colgroup>
                                            <col style="width: 40%">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th>택배사</th>
                                                <td>
                                                	<select id="dlvCorpCd" name="dlvCorpCd" style="width:300px">
									         			<c:forEach items="${dlvCorpList}" var="dlv" >
									         				<option value="${dlv.dlvCorpCd}"><c:out value="${dlv.dlvCorpNm}"/></option>
									         			</c:forEach>
									         		</select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>운송장번호</th>
                                                <td><input type="text" name="dlvNum"  id="dlvNum"  class="input_text_full" /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
							</form>
                            <div class="foot">
                                <button type="button" class="btn red" onClick="fn_InsDlvNum();">등록</button>
                                <button type="button" class="close btn">닫기</button>
                            </div>
                        </div>
                    </div>
                </div> <!--//layer-popup-->
                <div class="paging-wrap">
					<ul>
						<ui:pagination paginationInfo="${paginationInfo}" type="masMw" jsFunction="fn_Search" />
					</ul>
				</div>
			</section> <!--//contents-wrap-->
		</main>

		<footer id="footer">
			
		</footer>
	</div>
</body>
</html>