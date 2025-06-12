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
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="RC_CNTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Search(pageIndex){
	document.frm.action = "<c:url value='/mas/rc/realTimeList.do'/>";
	document.frm.submit();
}

function fn_CntListSelect(prdtNum, obj){
	$("#prdtTable tr").removeClass("tr_on");

	$(obj).addClass("tr_on");

	fn_CntList(prdtNum);
}

function fn_CntList(prdtNum){
	$("#prdtNum").val(prdtNum);

	$.ajax({
		url : "<c:url value='/mas/rc/selectCntList.ajax'/>",
		dataType:"json",
		data : "prdtNum=" + prdtNum,
		success: function(data) {
			var addHtml = "";
			if(data.cntInfList.length == 0){
				addHtml += "<tr>";
				addHtml += "<td colspan='3'><spring:message code='common.nodata.msg' /></td>";
				addHtml += "</tr>";
			}else{
				jQuery.each(data.cntInfList, function(index, onerow) {
					addHtml += "<tr>";
					addHtml += "	<td width=\"150\">";
					addHtml += fn_addDate(onerow["aplDt"]);
					addHtml += "	</td>";
					addHtml += "	<td width=\"80\">";
					addHtml += onerow["totalCarNum"];
					addHtml += "	</td>";
					addHtml += "	<td>";
					addHtml += "		<div class=\"btn_sty06\">";
					addHtml += "			<span><a href=\"javascript:fn_OpenUdtPrdtCnt('" + onerow["prdtNum"] + "', '" + onerow["aplDt"] + "', '" + onerow["totalCarNum"] + "')\">수정</a></span></div>";
					addHtml += "		<div class=\"btn_sty09\">";
					addHtml += "			<span><a href=\"javascript:fn_DelPrdtCnt('" + onerow["prdtNum"] + "', '" + onerow["aplDt"] + "')\">삭제</a></span></div>";
					addHtml += "	</td>";
					addHtml += "</tr>";
				});
			}
			$("#cntTable").html(addHtml);
		},
		error : fn_AjaxError
	});
}

function fn_OpenUdtPrdtCnt(prdtNum, aplDt, totalCarNum){
	$("#prdtNum").val(prdtNum);
	$("#viewAplDt").datepicker("destroy");
	$("#aplDt").val(aplDt);
	$("#viewAplDt").val(fn_addDate(aplDt));
	$("#totalCarNum").val(totalCarNum);
	$("#gubun").val("U");

	$("#btnResist").hide();
	$("#btnUpdate").show();
	$("#btnUpdateAll").hide();

	show_popup($("#lay_popup"));

}

function fn_UdtPrdtCnt(){
	// validation 체크
	if(!validateRC_CNTINFVO(document.cntInf)){
		return;
	}
    var pPrdtNm = $("#sPrdtNm").val();
    var pCarDivCd = $("input[name='sCarDivCd']:checked").val();
    var pStadeStatus = $("input[name='sTradeStatus']:checked").val();
    document.cntInf.action = '/mas/rc/updatePrdtCnt.do?sPrdtNm='+ pPrdtNm + "&sCarDivCd=" + pCarDivCd + "&sTradeStatus=" + pStadeStatus;
	document.cntInf.submit();
}

function fn_DelPrdtCnt(prdtNum, aplDt){
	if(confirm("<spring:message code='common.delete.msg'/>")){
		$("#prdtNum").val(prdtNum);
		$("#aplDt").val(aplDt);

        var pPrdtNm = $("#sPrdtNm").val();
        var pCarDivCd = $("input[name='sCarDivCd']:checked").val();
        var pStadeStatus = $("input[name='sTradeStatus']:checked").val();
        document.cntInf.action = '/mas/rc/deletePrdtCnt.do?sPrdtNm='+ pPrdtNm + "&sCarDivCd=" + pCarDivCd + "&sTradeStatus=" + pStadeStatus;
		document.cntInf.submit();
	}
}

function fn_AddCnt(){
	if(isNull($("#prdtNum").val())){
		alert("상품을 선택해주세요.");
		return;
	}

	$("#viewAplDt").datepicker();

	// 입력 값 초기화
	$("#cntLay input:text").val("");

	$("#gubun").val("I");
	// 에러 문구값 초기화
	$(".error_text").text("");

	$("#btnResist").show();
	$("#btnUpdate").hide();
	$("#btnUpdateAll").hide();

	show_popup($("#lay_popup"));
}

function fn_InsPrdtCnt() {
	// validation 체크
	if(!validateRC_CNTINFVO(document.cntInf)){
		return;
	}

	$.ajax({
		url : "<c:url value='/mas/rc/insertPrdtCnt.ajax'/>",
		data : $("#cntInf").serialize(),
		dataType:"json",
		success: function(data) {
			if (data.error !="N"){
				if(data.error == "dupl"){
					alert('해당 적용일자는 등록 되어 있습니다.\n수정 버튼을 클릭하여 수량을 조절해 주세요.');
				} else{
					alert(data.error);
				}
				close_popup($('#lay_popup'));
				return;
			}
			location.href = "/mas/rc/realTimeList.do?sPrdtNum="+data.RC_CNTINFVO.prdtNum
		},
		error : fn_AjaxError
	})
}

function on_chkAll(){


	 $('input:checkbox[name="chkPrdts"]').each(function() {
		$(this).prop('checked', true);
	 });

	 $('#chkAllBtn').prop('checked', false);
}

function fn_AddCntAll(){

	if( $('input:checkbox[name="chkPrdts"]:checked').length <= 0 ){
		alert("상품을 1개 이상 선택해주세요.");
		return;
	}

	var strAllPrdts = "";
	$('input:checkbox[name="chkPrdts"]').each(function() {
		if(this.checked){
			strAllPrdts = strAllPrdts + $(this).val() +",";
		}
	 });
	$("#allPrdts").val(strAllPrdts);


	$("#viewAplDt").datepicker();

	// 입력 값 초기화
	$("#cntLay input:text").val("");

	$("#gubun").val("I");
	// 에러 문구값 초기화
	$(".error_text").text("");

	$("#btnResist").hide();
	$("#btnUpdate").hide();
	$("#btnUpdateAll").show();

	show_popup($("#lay_popup"));
}


function fn_UdtPrdtCntAll(){
	// validation 체크
	if(!validateRC_CNTINFVO(document.cntInf)){
		return;
	}
	var pPrdtNm = $("#sPrdtNm").val();
	var pCarDivCd = $("input[name='sCarDivCd']:checked").val();
	var pStadeStatus = $("input[name='sTradeStatus']:checked").val();
    document.cntInf.action = '/mas/rc/updatePrdtCntAll.do?sPrdtNm='+ pPrdtNm + "&sCarDivCd=" + pCarDivCd + "&sTradeStatus=" + pStadeStatus;
	document.cntInf.submit();
}


$(document).ready(function(){

	const elePrdtNum ="${searchVO.sPrdtNum}";
	if(!elePrdtNum){
		if (elePrdtNum) {
			$('#'+elePrdtNum).click();
		}
	}
	
	$("#viewAplDt").datepicker();

	$('#viewAplDt').change(function() {
		$('#aplDt').val($('#viewAplDt').val().replace(/-/g, ''));
	});

	if("${error}" == "Y"){
		if("${cntInfVO.gubun}" == "U"){
			$("#viewAplDt").datepicker("destroy");

			$("#btnResist").hide();
			$("#btnUpdate").show();
		}else if("${cntInfVO.gubun}" == "I"){
			$("#viewAplDt").datepicker();

			$("#btnResist").show();
			$("#btnUpdate").hide();
		}
		show_popup($("#lay_popup"));
	}

	if(elePrdtNum != ""){
		fn_CntList(elePrdtNum);
	}
});

</script>

</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=realtime" flush="false"></jsp:include>
    <div id="contents_wrapper">
    	<div id="contents_area">
        <!--컨텐츠-->
        	<div id="contents">
        		<form name="frm" method="post" onSubmit="return false;">
		        <!--검색폼-->
		        <div class="search_box">
		        	<div class="search_form">
		            	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
                                	<col width="*" />
								</colgroup>
		           				<tbody>
		           					<tr>
		      							<th scope="row">상&nbsp;품&nbsp;명</th>
		      							<td><input type="text" id="sPrdtNm" class="input_text_full" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
		   							</tr>
		   							<tr>
		      							<th scope="row">
		      							차량구분</th>
		      							<td>
		      								<input type="radio" name="sCarDivCd" value=""   <c:if test='${empty searchVO.sCarDivCd}'>checked</c:if>> 전체</input>&nbsp;
		      								<c:forEach var="code" items="${carDivCd}" varStatus="status">
               								<input type="radio" name="sCarDivCd"  value="${code.cdNum}" <c:if test='${searchVO.sCarDivCd eq code.cdNum}'>checked</c:if>> ${ code.cdNm}</input>&nbsp;
               								</c:forEach>
		      							</td>
		      						</tr>
		      						<tr>
		      							<th scope="row">거래상태</th>
		      							<td>
		      								<input type="radio" name="sTradeStatus" value=""   <c:if test='${empty searchVO.sTradeStatus}'>checked</c:if>> 전체</input>&nbsp;
		      								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR_REQ}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR_REQ}'>checked</c:if>> 승인요청</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_APPR}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_APPR}'>checked</c:if>> 승인</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_STOP}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_STOP}'>checked</c:if>> 판매중지</input>&nbsp;
               								<input type="radio" name="sTradeStatus"  value="${Constant.TRADE_STATUS_EDIT}" <c:if test='${searchVO.sTradeStatus eq  Constant.TRADE_STATUS_EDIT}'>checked</c:if>> 수정요청</input>&nbsp;
		      							</td>
		   							</tr>
		   						</tbody>
		             		</table>
		             	</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
						</span>
		            </div>
		        </div>
		        </form>
		        <!--//검색폼-->
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tbody>
	                    <tr>
	                        <td valign="top"><h2 class="title02">검색상품</h2> </td>
	                        <td align="right" valign="bottom" style="padding-bottom:4px;">
	                        	<!-- <span class="btn_sty01"><a href="#">버튼1</a></span><span class="btn_sty02"><a href="#">버튼2</a></span> -->
	                        </td>
	                    	<td rowspan="2" width="16" style="text-align:center;">
	                       		<br /><br /><br />
	                       		<!--
	                        	<span class="btn_sty01" style="width:80px;"><a href="#">&gt;&gt;</a></span><br /><br /><br />
	                        	<span class="btn_sty01" style="width:80px;"><a href="#">&lt;&lt;</a></span> -->
	                        </td>
	                        <td valign="top"><h2 class="title02">선택상품수량</h2></td>
	                        <td align="right" valign="bottom" style="padding-bottom:4px;">
	                        	<span class="btn_sty02"><a href="javascript:fn_AddCnt();">수량등록</a></span>
	                        	<!-- <span class="btn_sty03"><a href="#">버튼2</a></span> -->
	                        </td>
	                    </tr>
	                    <tr>
	                        <td colspan="2" valign="top" width="50%" style="background-color:#f9f9f9; border:solid 1px #ccc; text-align:center;">
	                        	<!-- <div style="height:400px; overflow:auto;"> -->
	                        	<table width="100%" border="1" class="table01" style="height:700px;">
	                        		<colgroup>
	                        			<col width="41" />
	                        			<col width="311" />
	                        			<col width="161" />
	                        			<col width="161" />
	                        			<col width="161" />
	                        			<col />
	                        		</colgroup>
	                        		<thead>
										<tr>
											<th scope="col"><input type="checkbox" id="chkAllBtn" onclick="on_chkAll()"></input></th>
											<th scope="col">상품명</th>
											<th scope="col">상품번호</th>
											<th scope="col">거래상태</th>
											<th scope="col">노출순번</th>
	                                    	<th scope="col" style="padding-right:10px;">차량구분</th>
	                                	</tr>
	                                </thead>
	                                <tbody>
	                                	<tr>
	                                		<td colspan="6" style="padding:0; overflow-y:scroll; text-align:center;">
	                                			<div style="height:700px; margin-left:-1px;">
													<table width="100%" id="prdtTable" border="1" cellpadding="0" cellspacing="0" class="list_tb">
													  <c:if test="${corpVO.corpLinkYn eq 'N' }">
														<c:forEach items="${prdtList}" var="prdtInf" varStatus="status">
															<tr <c:if test="${searchVO.sPrdtNum eq prdtInf.prdtNum}">class="tr_on"</c:if> style="cursor:pointer;" onclick="javascript:fn_CntListSelect('${prdtInf.prdtNum}', this);">
																<td width="30">
																	<input type="checkbox" id="chkPrdts" name="chkPrdts" value="${prdtInf.prdtNum}"></input>
																</td>
																<td width="300">
																	${prdtInf.prdtNm}  /
																  <%-- <c:forEach var="code" items="${fuelCd}" varStatus="status">
																		<c:if test="${prdtInf.useFuelDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
																	</c:forEach> --%>
																  <c:if test="${prdtInf.isrDiv eq 'ID00' }">
																  자차자율
																  </c:if>
																  <c:if test="${prdtInf.isrDiv eq 'ID10' }">
																  자차포함(
																    <c:if test="${prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN }">
																    일반자차
																    </c:if>
																    <c:if test="${prdtInf.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX }">
																    고급자차
																    </c:if>
																  )
																  </c:if>
																  <c:if test="${prdtInf.isrDiv eq 'ID20' }">
																  자차필수
																  </c:if>
																</td>
																<td id="${prdtInf.prdtNum}" width="150">${prdtInf.prdtNum}</td>
																<td width="150">
																	<c:forEach var="code" items="${tsCd}" varStatus="status">
																		<c:if test="${prdtInf.tradeStatus==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
																	</c:forEach>
																</td>
																<td width="150">${prdtInf.viewSn}</td>
																<td>
																	<c:forEach var="code" items="${carDivCd}" varStatus="status">
																		<c:if test="${prdtInf.carDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
																	</c:forEach>
																</td>
															</tr>														  
														</c:forEach>
													  </c:if>
													  <c:if test="${corpVO.corpLinkYn eq 'Y' }">
													    <tr>
													    	<td>실시간 연계 사용 업체 입니다.</td>
													    </tr>
													  </c:if>
													</table>
												</div>
											</td>
										</tr>
	                                </tbody>

	                            </table></td>
	                        <td colspan="2" valign="top" width="40%" style="background-color:#f9f9f9; border:solid 1px #ccc; text-align:center;">
	                        	<div style="height:700px; ">
		                        <table width="100%" border="1" class="table01 list_tb">
			                        <colgroup>
	                        			<col width="161" />
	                        			<col width="91" />
	                        			<col />
	                        		</colgroup>
		                        	<thead>
		                        		<tr>
		                                    <th scope="col">적용일자</th>
		                                    <th scope="col">수량</th>
		                                    <th scope="col"></th>
		                                </tr>
		                        	</thead>
	                                <tbody>
	                                	<tr>
	                                		<td colspan="3" style="padding:0; overflow-y:scroll; text-align:center;">
	                                			<div style="height:700px; margin-left:-1px;">
													<table width="100%" id="cntTable" border="1" cellpadding="0" cellspacing="0" class="list_tb">
													</table>
												</div>
	                                		</td>
	                                	</tr>
	                                </tbody>
	                            </table></td>
	                    </tr>
	                </tbody>
	            </table>

        	<div class="btn_lt01" style="margin-top:25px;">
	            <div>
	            	<span class="btn_sty01"><a href="javascript:on_chkAll()">상품 전부선택</a></span>
	            	<span class="btn_sty02"><a href="javascript:fn_AddCntAll()">선택 상품 수량등록</a></span>
	            </div>
	        </div>
		</div>
	</div>
</div>


<form:form commandName="RC_CNTINFVO" name="cntInf" id="cntInf" method="post" onSubmit="return false;">
<input type="hidden" name="prdtNum" id="prdtNum" />
<input type="hidden" name="gubun" id="gubun" />
<input type="hidden" name="allPrdts" id="allPrdts" />
<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct-->
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
		<ul class="form_area">
			<li>
				<table border="1" class="table02" id="cntLay">
  					<caption class="tb01_title">수량관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
  					<colgroup>
                       <col width="170" />
                       <col width="*" />
                   	</colgroup>
					<tr>
						<th>적용일자<span class="font02">*</span></th>
						<td>
							<form:input path="viewAplDt" id="viewAplDt" class="input_text6 center" readonly="true" value="" />
							<form:hidden path="aplDt" id="aplDt" value="" />
							<form:errors path="viewAplDt"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>차량 대수<span class="font02">*</span></th>
						<td>
							<form:input path="totalCarNum" id="totalCarNum" class="input_text4 center" value="${cntInfVO.totalCarNum}" maxlength="11" onkeydown="javascript:fn_checkNumber();" />
							<form:errors path="totalCarNum"  cssClass="error_text" />
						</td>
					</tr>
				</table>
       		</li>
		</ul>
		<div class="btn_rt01">
			<span class="btn_sty04" id="btnResist"><a href="javascript:fn_InsPrdtCnt()">등록</a></span>
			<span class="btn_sty04" id="btnUpdate"><a href="javascript:fn_UdtPrdtCnt()">수정</a></span>
			<span class="btn_sty04" id="btnUpdateAll"><a href="javascript:fn_UdtPrdtCntAll()">일괄수정</a></span>
		</div>
	</div>
</form:form>






</body>

</html>