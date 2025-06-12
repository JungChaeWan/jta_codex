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
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

/**
 * 취소처리
 */
function fn_CancelRsvView(){
	show_popup($("#lay_popup"));
	return;
}

/**
 * 취소요청 처리
 */
function fn_CancelRsvReq(){
	if(isNull($("#cmssAmt").val())){
		alert("수수료 금액이 입력되지 않았습니다.");
		$("#cmssAmt").focus();
		return;
	}
	
	if(confirm("취소 수수료금액이 " + $("#cmssAmt").val() + "원이 맞습니까?\n취소진행을 원하시면 확인을 눌러주십시오.")){
		// 입력 최대 금액 체크
		if(parseInt($("#cmssAmt").val()) > parseInt("${resultVO.nmlAmt}")){
			alert("상품 금액보다 수수료금액이 더 많습니다.");
			$("#cmssAmt").focus();
			return;
		}
		var parameters = "rsvNum=${resultVO.rsvNum}&glRsvNum=${resultVO.glRsvNum}&payDiv=${resultVO.payDiv}&cmssAmt=" + $("#cmssAmt").val()+"&cancelInf=" + $("#cancelInf").val();;
		$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/mas/gl/cancelRsv.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.cancelDiv == "1"){
					if(data.success == "Y"){
						alert("자동취소가 정상적으로 처리 되었습니다.");
						document.frm.action = "<c:url value='/mas/gl/detailRsv.do'/>";
						document.frm.submit();
					}else{
						alert(data.payResult.payRstInf);
					}
				}else{
					alert("자동취소 메세지 : " + data.payResult.payRstInf + "\n환불요청이 정상적으로 처리 되었습니다.");
					document.frm.action = "<c:url value='/mas/gl/detailRsv.do'/>";
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
	document.frm.action = "<c:url value='/mas/gl/rsvList.do'/>";
	document.frm.submit();
}

function fn_RsvIdt(){
	if(confirm("예약확인처리하시겠습니까?")){
		var parameters = "prdtRsvNum=${resultVO.glRsvNum}";
		$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/mas/rsvIdt.ajax'/>",
			data:parameters ,
			success:function(data){
				document.frm.action = "<c:url value='/mas/gl/detailRsv.do'/>";
				document.frm.submit();
			},
			error : fn_AjaxError
		});
	}
}
</script>
</head>
<body>
<div class="blackBg"></div>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=rsv" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<div id="contents">
				<form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
					<input type="hidden" name="sPrdtNum" id="sPrdtNum" value="${searchVO.sPrdtNum}" />
					<input type="hidden" name="sRentStartDt" id="sRentStartDt" value="${searchVO.sRentStartDt}" />
					<input type="hidden" name="sRsvNm" id="sRsvNm" value="${searchVO.sRsvNm}" />
					<input type="hidden" name="sRsvTelnum" id="sRsvTelnum" value="${searchVO.sRsvTelnum}" />
					<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}" />
					<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}" />
					<input type="hidden" name="glRsvNum" id="glRsvNum" value="${resultVO.glRsvNum}" />
				</form>
				<h4 class="title03">예약정보</h4>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">예약번호</th>
						<td>
							<c:out value="${resultVO.rsvNum}" />
						</td>
						<th scope="row">예약상태</th>
						<td>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약대기</c:if>								
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">예약불가</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">고객취소요청</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">예약자명</th>
						<td><c:out value="${resultVO.rsvNm}" /></td>
						<th scope="row">사용자명</th>
						<td><c:out value="${resultVO.useNm}" /></td>
					</tr>
					<tr>
						<th scope="row">예약자 Email</th>
						<td><c:out value="${resultVO.rsvEmail}" /></td>
						<th scope="row">사용자 Email</th>
						<td><c:out value="${resultVO.useEmail}" /></td>
					</tr>
					<tr>
						<th scope="row">예약자 전화번호</th>
						<td><c:out value="${resultVO.rsvTelnum}" /></td>
						<th scope="row">사용자 전화번호</th>
						<td><c:out value="${resultVO.useTelnum}" /></td>
					</tr>
					<tr>
						<th scope="row">L.Point 사용</th>
						<td colspan='3'><c:if test="${resultVO.lpointUsePoint > 0 }"><b> O </b</c:if><c:if test="${resultVO.lpointUsePoint <= 0 }"> X </c:if></td>
					</tr>
				</table>
				<h5 class="title03 margin-top45">상품정보</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">상품명</th>
						<td colspan="3">
							<c:out value="${resultVO.prdtNm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">상품정보</th>
						<td colspan="3"><c:out value="${resultVO.prdtInf}" /></td>
					</tr>
					<tr>
						<th scope="row">이용일자</th>
						<td>
							<fmt:parseDate value='${resultVO.useDt}' var='fromDttm' pattern="yyyyMMdd" scope="page"/>
							<fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd"/> <c:out value="${resultVO.useTm}" />시 대
						</td>
						<th scope="row">사용인원</th>
						<td>
							<c:out value="${resultVO.useMem}" />인 1조
						</td>
					</tr>
					<tr>
						<th scope="row">상품금액</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.nmlAmt}" /></fmt:formatNumber>원
						</td>
						<th scope="row">결제금액</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.saleAmt}" /></fmt:formatNumber>원 <c:if test="${resultVO.lpointSavePoint > 0 }">(<b>L.Point 적립 - </b><fmt:formatNumber maxFractionDigits="0"><c:out value="${resultVO.saleAmt * Constant.LPOINT_SAVE_PERCENT / 100}" /></fmt:formatNumber>원)</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">할인금액</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.disAmt}" /></fmt:formatNumber>원
						</td>
						<th scope="row">취소금액</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.cancelAmt}" /></fmt:formatNumber>원
						</td>
					</tr>
					<tr>
						<th scope="row">취소수수료금액</th>
						<td>
							<c:if test="${epRsvYn eq Constant.FLAG_N}">
							<fmt:formatNumber><c:out value="${resultVO.cmssAmt}" /></fmt:formatNumber>원
							</c:if>
							<!-- 황금빛 제주 -->
							<c:if test="${epRsvYn eq Constant.FLAG_Y}">
								<fmt:formatNumber><c:out value="${resultVO.disAmt - resultVO.disCancelAmt}" /></fmt:formatNumber>원
							</c:if>
						</td>
						<th scope="row">예약일시</th>
						<td>
							<c:out value="${resultVO.regDttm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">정산여부</th>
						<td>
							<c:if test="${resultVO.adjStatusCd eq '' or resultVO.adjStatusCd eq Constant.ADJ_STATUS_CD_READY }">예정</c:if>
							<c:if test="${resultVO.adjStatusCd eq Constant.ADJ_STATUS_CD_COM }">완료</c:if>
							<span class="font_red"> (<b>예상정산액 :</b> <fmt:formatNumber><c:out value="${resultVO.adjAmt}" /></fmt:formatNumber>원)</span>
						</td>
						<th scope="row">정산일자</th>
						<td>
							${resultVO.adjItdDt}
							<%--<c:if test="${resultVO.adjStatusCd eq Constant.ADJ_STATUS_CD_READY }">${resultVO.adjItdDt}</c:if>
							<c:if test="${resultVO.adjStatusCd eq Constant.ADJ_STATUS_CD_COM }">${resultVO.adjCmplDt}</c:if>--%>
						</td>
					</tr>
					<c:if test="${	(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or
									(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or
									(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM)}">
                    	<tr>
                    		<th scope="row">취소요청일시</th>
                    		<td>${resultVO.cancelRequestDttm}</td>
                    		<th scope="row">고객취소사유</th>
                    		<td>${resultVO.cancelRsn}</td>
                    	</tr>
                    </c:if>
					<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">
					<tr>
						<th scope="row">취소사유</th>
						<td colspan="3">
							<c:out value="${resultVO.cancelInf}"/>
						</td>
					</tr>
					</c:if>
				</table>
				 
				<ul class="btn_rt01">
					<c:if test="${resultVO.rsvIdtYn == 'N'}">
						<li class="btn_sty04">
							<a href="javascript:fn_RsvIdt();">예약확인</a>
						</li>
					</c:if>
					<c:if test="${resultVO.adjYn == 'N'}">
						<c:if test="${(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM) or (resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ)}">
							<li class="btn_sty03">
								<a href="javascript:fn_CancelRsvView()">취소처리</a>
							</li>
						</c:if>
					</c:if>
					<li class="btn_sty04">
						<a href="javascript:fn_List()">목록</a>
					</li>
				</ul>
			</div>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" id="cntLay">
 					<caption class="tb01_title">취소처리</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
				<tr>
					<th>상품금액</th>
					<td>
						<fmt:formatNumber><c:out value="${resultVO.nmlAmt}" /></fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<th>할인금액</th>
					<td>
						<fmt:formatNumber><c:out value="${resultVO.disAmt}" /></fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td>
						<fmt:formatNumber><c:out value="${resultVO.saleAmt}" /></fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<th>취소수수료금액</th>
					<td>
						<input type="text" name="cmssAmt" id="cmssAmt" maxlength="11" onkeydown="javascript:fn_checkNumber();" />원 <br />
						<span class="font02">※ 전액환불 시 0원 입력</span> <br />
						<span class="font02">※ 취소수수료 발생시 사전에 고객 안내 필수</span>
					</td>
				</tr>
				<tr>
					<th>취소사유</th>
					<td>
						<textarea name="cancelInf" id="cancelInf"  cols="15" rows="10" style="width:97%"></textarea>
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty03" id="btnResist"><a href="javascript:fn_CancelRsvReq()">취소요청</a></span>
	</div>
</div>
</body>
</html>