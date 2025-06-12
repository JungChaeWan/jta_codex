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
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
	
	<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

	<script type="text/javascript">
	
	/**
	 * 취소요청 처리
	 */
	function fn_CancelRsvReq(){
		if(confirm("취소 하시겠습니까?")){
			if(isNull($("#cmssAmt").val())){
				alert("수수료 금액이 입력되지 않았습니다.");
				$("#cmssAmt").focus();
				return;
			}
			// 입력 최대 금액 체크
			if(parseInt($("#cmssAmt").val()) > parseInt("${resultVO.nmlAmt}")){
				alert("상품 금액보다 수수료금액이 더 많습니다.");
				$("#cmssAmt").focus();
				return;
			}
			var parameters = "rsvNum=${resultVO.rsvNum}&svRsvNum=${resultVO.svRsvNum}&payDiv=${resultVO.payDiv}&cmssAmt=" + $("#cmssAmt").val()+"&cancelInf=" + $("#cancelInf").val();
			$.ajax({
				type:"post", 
				dataType:"json",
				async:false,
				url:"<c:url value='/mas/sv/cancelRsv.ajax'/>",
				data:parameters ,
				success:function(data){
					if(data.cancelDiv == "1"){
						if(data.success == "Y"){
							alert("자동취소가 정상적으로 처리 되었습니다.");
							document.frm.action = "<c:url value='/mw/mas/sv/detailRsv.do'/>";
							document.frm.submit();
						}else{
							alert(data.payResult.payRstInf);
						}
					}else{
						alert("자동취소 메세지 : " + data.payResult.payRstInf + "\n환불요청이 정상적으로 처리 되었습니다.");
						document.frm.action = "<c:url value='/mw/mas/sv/detailRsv.do'/>";
						document.frm.submit();
					}
				},
				error : fn_AjaxError
			});
		}
	}

	/**
	 * 목록
	 */
	function fn_List(){
		document.frm.action = "<c:url value='/mw/mas/sv/rsvList.do'/>";
		document.frm.submit();
	}
	</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/mw/mas/head.do?menu=rsv" flush="false"></jsp:include>
		<main id="main">
			<section class="contents-wrap">
			    <form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
					<input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}" />
					<input type="hidden" name="sRsvNm" id="sRsvNm" value="${searchVO.sRsvNm}" />
					<input type="hidden" name="sRsvTelnum" id="sRsvTelnum" value="${searchVO.sRsvTelnum}" />
					<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}" />
					<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}" />
					<input type="hidden" name="svRsvNum" id="svRsvNum" value="${resultVO.svRsvNum}" />
					<input type="hidden" name="sRsvStatusCd" id="sRsvStatusCd" value="${searchVO.sRsvStatusCd}" />
				</form>
                <!--change content-->
                <h3 class="title3">구매정보</h3>
                <ul class="rese-list">
				    <li>
                        <table class="table-row">
                            <colgroup>
                                <col style="width: 32%">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>구매번호</th>
									<td><c:out value="${resultVO.rsvNum}" /></td>
                                </tr>
                                <tr>
                                    <th>구매상태</th>
									<td>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">미결제</c:if>								
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}"></c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">결제완료</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">고객취소요청</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">구매확정</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
										<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">배송중</c:if>
									</td>
                                </tr>
                                <tr>
                                    <th rowspan="3">구매자 정보</th>
									<td><c:out value="${resultVO.rsvNm}" /></td>
                                </tr>
                                <tr>
									<td><c:out value="${resultVO.rsvTelnum}" /></td>
                                </tr>
                                <tr>
									<td><c:out value="${resultVO.rsvEmail}" /></td>
                                </tr>
                            </tbody>
                        </table>
				    </li>
				</ul>
				<h3 class="title3">배송지정보</h3>
                <ul class="rese-list">
				    <li>
                        <table class="table-row">
                            <colgroup>
                                <col style="width: 32%">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>이름</th>
									<td><c:out value="${resultVO.useNm}" /></td>
                                </tr>
                                <tr>
                                	<th>휴대폰</th>
									<td><c:out value="${resultVO.useTelnum}" /></td>
                                </tr>
                                <tr>
                                	<th>배송지 주소</th>
									<td>(<c:out value="${resultVO.postNum}"/>)<c:out value="${resultVO.roadNmAddr}"/> <c:out value="${resultVO.dtlAddr}"/></td>
                                </tr>
                                <tr>
                                	<th>배송시 요청사항</th>
				                    <td><c:out value="${resultVO.dlvRequestInf}"/></td>
				                </tr>
				                <tr>
				                	<th>택배사 정보</th>
									<td>
	                    		    	<c:if test="${not empty resultVO.dlvNum}">
			                	        	<c:out value="${resultVO.dlvCorpNm}"/> / <c:out value="${resultVO.dlvNum}"/>
			                        	</c:if>
			                        </td>
			                    </tr>
                            </tbody>
                        </table>
				    </li>
				</ul>
               
                <h3 class="title3">상품정보</h3>
                <ul class="rese-list">
                    <li>
                        <table class="table-row">
                            <colgroup>
                                <col style="width: 32%">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>상품명</th>
									<td><c:out value="${resultVO.prdtNm}" /></td>
                                </tr>
                                <tr>
                                    <th>상품정보</th>
									<td><c:out value="${resultVO.prdtInf}" /></td>
                                </tr>
                                <tr>
                                    <th>상품금액</th>
									<td><fmt:formatNumber><c:out value="${resultVO.nmlAmt}" /></fmt:formatNumber> 원</td>
                                </tr>
								<tr>
									<th>결제금액</th>
									<td><fmt:formatNumber><c:out value="${resultVO.saleAmt}" /></fmt:formatNumber> 원</td>
								</tr>
								<tr>
									<th>할인금액</th>
									<td><fmt:formatNumber><c:out value="${resultVO.disAmt}" /></fmt:formatNumber> 원</td>
								</tr>
								<tr>
									<th>취소금액</th>
									<td><fmt:formatNumber><c:out value="${resultVO.cancelAmt}" /></fmt:formatNumber> 원</td>
								</tr>
								<tr>
									<th>취소수수료금액</th>
									<td><fmt:formatNumber><c:out value="${resultVO.cmssAmt}" /></fmt:formatNumber> 원</td>
								</tr>
								<tr>
									<th>예약일시</th>
									<td><c:out value="${resultVO.regDttm}" /></td>
								</tr>
								<tr>
									<th>정산여부</th>
									<td>${resultVO.adjYn}</td>
								</tr>
								<tr>
									<th>정산일자</th>
									<td>${resultVO.adjDt}</td>
								</tr>
								<c:if test="${	(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or
									(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or
									(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM)}">
                                <!--취소상태일경우 추가-->
                                <tr>
                                    <th>취소요청일시</th>
									<td>${resultVO.cancelRequestDttm}</td>
                                </tr>
                                <tr>
                                    <th>고객취소사유</th>
									<td>${resultVO.cancelRsn}</td>
                                </tr>
                                </c:if>
                                <c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">
                                <tr>
                                    <th>취소사유</th>
                                    <td>${resultVO.cancelInf}</td>
                                </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </li>
                </ul>
                
                <div class="btn-wrap">
                    <!--사용완료/취소상태일경우-->
                    <!--<a href="" class="btn blue">예약확인</a>
                    <a href="" class="btn">목록</a>-->
                    
                    <c:if test="${resultVO.rsvIdtYn == 'N'}">
                    <!--고객취소요청 상태일 경우-->
                    <a href="javascript:fn_RsvIdt();" class="btn blue">예약확인</a>
                    </c:if>
                    <c:if test="${resultVO.adjYn == 'N'}">
						<c:if test="${(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM) or (resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ)}">
                    <a href="javascript:void(0)" class="btn red" onclick="layer_popup('#targetID');">취소처리</a>
                    	</c:if>
                    </c:if>
                    <a href="javascript:fn_List()" class="btn">목록</a>
                </div>
                
                <!--layer popup-->
                <div id="targetID" class="layer-popup">
                    <div class="content-wrap">
                        <div class="content">
                            <div class="head">
                                <h3 class="title">취소처리</h3>
                                <button type="button" class="close"><img src="<c:url value='/images/adm_mw/icon/basic/popup_close.png'/>" alt="닫기"></button>
                            </div>

                            <div class="main">
                                <div class="scroll" style="height: auto">
                                    <table class="table-row">
                                        <colgroup>
                                            <col style="width: 40%">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th>상품금액</th>
                                                <td><fmt:formatNumber><c:out value="${resultVO.nmlAmt}" /></fmt:formatNumber> 원</td>
                                            </tr>
                                            <tr>
                                                <th>할인금액</th>
                                                <td><fmt:formatNumber><c:out value="${resultVO.disAmt}" /></fmt:formatNumber> 원</td>
                                            </tr>
                                            <tr>
                                                <th>결제금액</th>
                                                <td><fmt:formatNumber><c:out value="${resultVO.saleAmt}" /></fmt:formatNumber> 원</td>
                                            </tr>
                                            <tr>
                                                <th>취소수수료금액</th>
                                                <td>
                                                    <p class="int-price"><input type="text" name="cmssAmt" id="cmssAmt" maxlength="11" onkeydown="javascript:fn_checkNumber();" placeholder="금액을 입력해주세요"> 원</p>
                                                    <p class="cap-form text-blue">※ 전액환불 시 0원 입력</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>취소사유</th>
                                                <td>
                                                    <textarea name="cancelInf" id="cancelInf" rows="4" class="width100"></textarea>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="foot">
                                <button type="button" class="btn red" onClick="fn_CancelRsvReq();">취소요청</button>
                                <button type="button" class="close btn">닫기</button>
                            </div>
                        </div>
                    </div>
                </div> <!--//layer-popup-->
                <!--//change content-->
				
			</section> <!--//contents-wrap-->
		</main>

		<footer id="footer">
			
		</footer>
	</div>
</body>
</html>