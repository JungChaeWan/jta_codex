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

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<c:if test="${recPntYn=='Y' }">
	<script language='JavaScript' src='https://pgweb.tosspayments.com/WEB_SERVER/js/receipt_link.js'></script>
</c:if>
<title></title>

<script type="text/javascript">

/**
 * 취소처리
 */
function fn_CancelRsvView(){
    if("${resultVO.rsvStatusCd}" == "${Constant.RSV_STATUS_CD_COM}"){
		if(!confirm("고객님에게 취소사유를 안내해 주시기바랍니다. \n(취소를 진행하여 발생하는 이슈에 관한 책임은 업체에 있습니다.) \n계속진행하시겠습니까?" )){
		    return;
        }
    }
	show_popup($("#lay_popup"));
	return;
}

/**
 * 취소요청 처리
 */
function fn_CancelRsvReq(){
    /** 취소요청 UX변경 2019.05.16*/
	var cmssAmt = 0;
    if($("input[name=chkCmssAmt]:checked").val() == "1"){
		if(isNull($("#cmssAmt").val())){
			alert("수수료 금액이 입력되지 않았습니다.");
			$("#cmssAmt").focus();
			return;
		}
		if("${resultVO.corpId}" == "CSPT190003"){
				alert("전액환불만 가능합니다.");
		}
		cmssAmt = $("#cmssAmt").val()
	}else{
		cmssAmt = 0;
	}

	if(confirm("취소 수수료금액이 " + cmssAmt + "원이 맞습니까?\n취소진행을 원하시면 확인을 눌러주십시오.")){
		// 입력 최대 금액 체크
		if(parseInt($("#cmssAmt").val()) > parseInt("${resultVO.nmlAmt}")){
			alert("상품 금액보다 수수료금액이 더 많습니다.");
			$("#cmssAmt").focus();
			return;
		}
		var parameters = {};
		parameters["rsvNum"] = "${resultVO.rsvNum}";
		parameters["spRsvNum"] = "${resultVO.spRsvNum}";
		parameters["payDiv"] = "${resultVO.payDiv}";
		parameters["cmssAmt"] = cmssAmt;
		parameters["cancelInf"] = $("#cancelInf").val();
		parameters["LGD_RFBANKCODE"] = $("#LGD_RFBANKCODE").val();
		parameters["LGD_RFACCOUNTNUM"] = $("#LGD_RFACCOUNTNUM").val();
		parameters["LGD_RFCUSTOMERNAME"] = $("#LGD_RFCUSTOMERNAME").val();
		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			url:"<c:url value='/mas/sp/cancelRsv.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.cancelDiv == "1"){
					if(data.success == "Y"){
						alert("자동취소가 정상적으로 처리 되었습니다.");
						document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
						document.frm.submit();
					}else{
						alert(data.payResult.payRstInf);
					}
				}else{
					alert("자동취소 메세지 : " + data.payResult.payRstInf);
					document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
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
	document.frm.action = "<c:url value='/mas/sp/rsvList.do'/>";
	document.frm.submit();
}

/**
 * 관리자 메모 update
 */

 function fn_updateAdmMemo() {
	if(isNull($("#admMemo").val())) {
		alert("관리자 메모를 입력해 주세요.");
		return ;
	}
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/mas/sp/updateRsvAdmMemo.ajax'/>",
		data: $("#admMemoForm").serialize() ,
		success:function(data){
			document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
			document.frm.submit();
		},
		error : fn_AjaxError
	});
}

/**
 * 이용내역 insert
 */
 function fn_saveUsehist() {
		if(isNull($("#usehist").val())) {
			alert("내용을 입력해 주세요.");
			return ;
		}
		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			url:"<c:url value='/mas/sp/insertSpRsvhist.ajax'/>",
			data: $("#spRsvhist").serialize() ,
			success:function(data){
				document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
				document.frm.submit();
			},
			error : fn_AjaxError
		});
}

/**
 * 사용처리
 */
 function fn_spUseAppr() {
		var parameters = "spRsvNum=${resultVO.spRsvNum}";
		if(confirm("사용처리 하시겠습니까?")) {
			$.ajax({
				type:"post",
				dataType:"json",
				async:false,
				url:"<c:url value='/mas/sp/spUseAppr.ajax'/>",
				data:parameters ,
				success:function(data){
					if(data.exprOut == "Y"){
						alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
						return ;
					} else if(data.useAbleOut == "Y") {
						alert(data.useAbleDttm + "이 후 사용가능합니다.");
						return ;
					} else {
						if(data.success == '${Constant.JSON_SUCCESS}'){
							alert("사용처리가 정상적으로 처리 되었습니다.");
							document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
							document.frm.submit();
						}
					}
				},
				error : fn_AjaxError
			});

		}
	}

 function fn_RsvIdt(){
	if(confirm("예약확인처리하시겠습니까?")){
		var parameters = "prdtRsvNum=${resultVO.spRsvNum}";
		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			url:"<c:url value='/mas/rsvIdt.ajax'/>",
			data:parameters ,
			success:function(data){
				document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
				document.frm.submit();
			}
		});
	}
}

/** 취소요청 UX변경 2019.05.16*/
function altRadioChk(){
	$("input[name=chkCmssAmt][value='1']").prop("checked",true);
}

function focusCmssAmt(){
	$("#cmssAmt").focus();
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
			<!--예약정보-->
			<div id="contents">
				<form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
					<input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}" />
					<input type="hidden" name="sRsvNm" id="sRsvNm" value="${searchVO.sRsvNm}" />
					<input type="hidden" name="spRsvNum" id="spRsvNum" value="${resultVO.spRsvNum}" />
					<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}" />
					<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}" />
					<input type="hidden" name="sRsvStatusCd" id="sRsvStatusCd" value="${searchVO.sRsvStatusCd}" />
					<input type="hidden" name="sRsvTelnum" id="sRsvTelnum" value="${searchVO.sRsvTelnum}" />
				</form>
				<h4 class="title03">예약정보</h4>

				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
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
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
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
						<td><c:if test="${resultVO.lpointUsePoint > 0 }"><b> O </b</c:if><c:if test="${resultVO.lpointUsePoint <= 0 }"> X </c:if></td>
						<th scope="row">Point 사용</th>
						<td><c:if test="${resultVO.usePoint > 0 }"><b> O </b</c:if><c:if test="${resultVO.usePoint <= 0 }"> X </c:if></td>
					</tr>
				</table>
				<h5 class="title03 margin-top45">상품정보</h5>
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
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
						<th scope="row">구매수/사용수</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.buyNum}" /></fmt:formatNumber> / <fmt:formatNumber><c:out value="${resultVO.useNum}" /></fmt:formatNumber>
						</td>
						<th scope="row">
							<c:if test="${Constant.SP_PRDT_DIV_TOUR ne resultVO.prdtDiv}">유효일자</c:if>
							<c:if test="${Constant.SP_PRDT_DIV_TOUR eq resultVO.prdtDiv}">적용 일자</c:if>
							</th>
						<td>
							<c:if test="${Constant.SP_PRDT_DIV_TOUR ne resultVO.prdtDiv}">
								<fmt:parseDate value='${resultVO.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
								<fmt:parseDate value='${resultVO.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
								<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
							</c:if>
							<c:if test="${Constant.SP_PRDT_DIV_TOUR eq resultVO.prdtDiv}">
								<fmt:parseDate value='${resultVO.aplDt}' var='aplDt' pattern="yyyyMMdd" scope="page"/>
								<fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd"/>
							</c:if>
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
						<th scope="row">탐나오할인금액</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.disAmt}" /></fmt:formatNumber>원  <c:if test="${resultVO.corpDisAmt > 0 }">(업체할인부담금:<fmt:formatNumber>${resultVO.corpDisAmt}</fmt:formatNumber>원)</c:if>
						</td>
						<th scope="row" class="font_red">
							<c:if test="${resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM }">환불금액</c:if>
							<c:if test="${resultVO.rsvStatusCd ne Constant.RSV_STATUS_CD_SCOM }">취소금액</c:if>
						</th>
						<td class="font_red">
							<fmt:formatNumber><c:out value="${resultVO.cancelAmt}" /></fmt:formatNumber>원
						</td>
					</tr>
					<tr>
						<th scope="row">취소수수료금액</th>
						<td>
							<fmt:formatNumber><c:out value="${resultVO.cmssAmt}" /></fmt:formatNumber>원
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
					<c:if test="${resultVO.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
					<tr>
						<th scope="row">사용일</th>
						<td colspan="3">
							${resultVO.useDttm}
						</td>
					</tr>
					</c:if>
					<c:if test="${	(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or
									(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or
									(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM)}">

                    	<c:if test="${resultVO.cancelRequestDttm == resultVO.cancelCmplDttm}">
                    		<%-- 업체가 취소한경우 --%>
                    		<tr>
                    			<th scope="row">취소요청일시</th>
	                    		<td>업체취소</td>
	                    		<th scope="row">취소완료일시</th>
	                    		<td>${resultVO.cancelCmplDttm}</td>
	                    	</tr>
                   		</c:if>
                   		<c:if test="${resultVO.cancelRequestDttm != resultVO.cancelCmplDttm}">
                   			<%-- 사용자 요청으로 취소한경우 --%>
                   			<tr>
                    			<th scope="row">취소요청일시</th>
	                    		<td>${resultVO.cancelRequestDttm}</td>
	                    		<th scope="row">취소완료일시</th>
	                    		<td>${resultVO.cancelCmplDttm}</td>
	                    	</tr>
	                    	<tr>
	                    		<th scope="row" >고객취소사유</th>
	                    		<td  colspan="3">${resultVO.cancelRsn}</td>
                    		</tr>
                   		</c:if>
						<tr>
							<th scope="row" >고객 취소 증빙자료</th>
							<td>
								<c:if test="${fn:length(rsvFileList) == 0}">
									제출 된 증빙자료가 없습니다.
								</c:if>
								<c:forEach items="${rsvFileList}" var="file" varStatus="status">
									<a href="${file.savePath}${file.saveFileNm}" style="color:blue" download="${file.realFileNm}">${file.realFileNm}</a> <br/>
								</c:forEach>
							</td>
							<th scope="row" >탐나오 취소 증빙자료</th>
							<td>
								<c:if test="${fn:length(rsvFileList_OSS) == 0}">
									제출 된 증빙자료가 없습니다.
								</c:if>
								<c:forEach items="${rsvFileList_OSS}" var="file" varStatus="status">
									<a href="${file.savePath}${file.saveFileNm}" style="color:blue" download="${file.realFileNm}">${file.realFileNm}</a> <br/>
								</c:forEach>
							</td>
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
				<ul class="btn_rt01 margin-btm45">
					<c:if test="${resultVO.rsvIdtYn == 'N'}">
						<li class="btn_sty04">
							<a href="javascript:fn_RsvIdt();">예약확인</a>
						</li>
					</c:if>
					<c:if test="${resultVO.adjYn == 'N'}">
						<c:if test="${(resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM and resultVO.cancelAbltimeYn eq 'Y' ) or (resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ)}">
							<li class="btn_sty03"><a href="javascript:fn_CancelRsvView()">취소처리</a></li>
						</c:if>
					</c:if>
					<c:if test="${resultVO.prdtDiv eq Constant.SP_PRDT_DIV_COUP and resultVO.rsvStatusCd eq Constant.RSV_STATUS_CD_COM  and  empty resultVO.useDttm}">
					<li class="btn_sty04"><a href="javascript:fn_spUseAppr();">사용처리</a></li>
					</c:if>

					<c:if test="${recPntYn=='Y' }">
						<c:if test="${recPntType=='card' }">
							<li class="btn_sty02"><a href="javascript:showReceiptByTID('${LGD_MID}', '${LGD_TID}', '${authdata}')">영수증(카드)</a></li>
						</c:if>
						<c:if test="${recPntType=='cash' }">
							<li class="btn_sty02"><a href="javascript:showCashReceipts('${LGD_MID}', '${LGD_OID}', '001', '${cashType}', '${CST_PLATFORM}')">영수증(현금)</a></li>
						</c:if>
						<c:if test="${recPntType=='Nocash' }">
							<li class="btn_sty02"><a href="javascript:alert('현금영수증을 신청하지 않았습니다.')">영수증 미신청</a></li>
						</c:if>
					</c:if>

					<li class="btn_sty01"><a href="javascript:fn_List()">목록</a></li>
				</ul>
				<c:if test="${resultVO.prdtDiv eq Constant.SP_PRDT_DIV_TOUR || resultVO.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
				 <div style="clear:both;">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top" style="width:55%;">
                                <table border="1" class="table02">
                                    <colgroup>
	                                    <col width="145" />
	                                    <col width="*" />
                                    </colgroup>
                                    <tr>
                                        <th scope="row">상품이용내역<br />(고객 확인용)</th>
                                        <td class="align_lt">
                                        	<c:if test="${fn:length(spRsvhistList) == 0}">
												 <spring:message code="info.nodata.msg" />
											</c:if>
											<ul class="list_info01">
											<c:forEach items="${spRsvhistList}" var="resultList" varStatus="status">
												<li><strong>${resultList.regDttm}</strong> <c:out value="${resultList.usehist}" /></li>
											</c:forEach>
											</ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">이용내역<br />작성하기</th>
                                        <td class="align_lt02">
                                        	<form name="spRsvhist" id="spRsvhist" method="post">
											<input type="hidden" name="spRsvNum" id="spRsvNum" value="${resultVO.spRsvNum}" />
                                            <textarea name="usehist" id="usehist" cols="15" rows="4" style="width:78%; vertical-align:middle;"></textarea>
                                            <span class="btn_sty11" style="width:18%;"><input type="button" name="" value="등록" onClick="fn_saveUsehist(); return false;"/></span>
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="2%">&nbsp;</td>
                            <td valign="top" style="width:43%;">
                                <table border="1" class="table01">
                                    <tr>
                                        <th scope="row" class="align_ct01">입점업체 관리자 메모</th>
                                    </tr>
                                    <tr>
                                        <td class="align_lt02">
                                        	<form name="admMemoForm"  id="admMemoForm" method="post">
											<input type="hidden" name="spRsvNum" id="spRsvNum" value="${resultVO.spRsvNum}" />
                                            <textarea name="admMemo" id="admMemo" cols="15" rows="6" style="width:80%; vertical-align:middle;">${resultVO.admMemo}</textarea>
                                            <span class="btn_sty12" style="width:16%;"><input type="button" name="" value="저장" onclick="fn_updateAdmMemo(); return false;"/></span>
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                </table>
                </div>
                </c:if>
			</div>
			<!--//예약정보-->
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
                      <col width="160" />
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
					<th><span class="font02">필독</span></th>
					<td><span class="font02">
						취소처리 완료 후 복구불가하므로 수수료 입력시 주의 바랍니다. <br />
						잘못처리된 후 고객환불 및 탐나오 수수료 발생부분 등은 <br />
						업체에서 직접 처리해주셔야 하는점 안내드립니다. <br />
						※취소수수료 발생시 사전에 고객 안내 필수
						</span>
					</td>
				</tr>
				<tr>
					<th>취소수수료금액</th>
					<td>
						<input type="radio" name="chkCmssAmt" value="0" onclick="javascript:$('#cmssAmt').val('');" checked /> 취소수수료 없음 <br />
						<input type="radio" name="chkCmssAmt" value="1" onclick="javascript:focusCmssAmt()" /> 취소수수료 입력 &nbsp;<input type="text" name="cmssAmt" id="cmssAmt" maxlength="11" onkeydown="javascript:fn_checkNumber();altRadioChk();" onfocus="altRadioChk();" />원 <br />
						<!-- <span class="font02">※ 취소수수료 발생시 사전에 고객 안내 필수</span> -->
					</td>
				</tr>
				<c:if test="${LGD_CASFLAGY eq 'I'}">
				<tr>
					<th>무통장입금 환불</th>
					<td><p >
						환불은행 :
						<select name="LGD_RFBANKCODE" id="LGD_RFBANKCODE" style="width:132px;">
							<c:forEach items="${cdRfac}" var="code" varStatus="status">
								<option value="${code.cdNum}" <c:if test="${code.cdNum eq resultVO.refundBankCode}">selected="selected"</c:if>> ${code.cdNm}</option>
							</c:forEach>
						</select>
						</p>
						<p>
						계좌번호 : <input type="text" id="LGD_RFACCOUNTNUM" name="LGD_RFACCOUNTNUM" value="${resultVO.refundAccNum}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자만 입력가능" />
						</p>
						<p>
						예금주명 : <input type="text" id="LGD_RFCUSTOMERNAME" name="LGD_RFCUSTOMERNAME" value="${resultVO.refundDepositor}"/>
						</p>
					</td>
				</tr>
				</c:if>
				<tr>
					<th>취소사유</th>
					<td>
						<textarea name="cancelInf" id="cancelInf"  cols="15" rows="10" style="width:97%" placeholder=" 특수문자(%&+)는 사용하실 수 없습니다. "></textarea>
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