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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

function fn_OpenInsApi(linkDiv){
	$("#insLinkDiv").val(linkDiv);
	if(linkDiv == "O100"){
		$("#insLinkDivNm").val("예약현황요청 API");
	}else if(linkDiv == "O200"){
		$("#insLinkDivNm").val("예약가능여부 API");
	}else if(linkDiv == "O300"){
		$("#insLinkDivNm").val("예약처리요청 API");
	}else if(linkDiv == "O200"){
		$("#insLinkDivNm").val("예약취소요청 API");
	}
	show_popup($("#lay_popup"));
}

function fn_OpenModApi(linkDiv){
	var parameters = "apiId=" + $("#apiId").val();
	parameters += "&linkDiv=" + linkDiv;
	
	$.ajax({
		url : "<c:url value='/apiCn/selectByApiDtl.ajax'/>",
		data : parameters,
		dataType:"json",
		success: function(data) {
			$("#modLinkDiv").val(linkDiv);
			
			if(data.apiDtlVO.linkDiv == "O100"){
				$("#modLinkDivNm").val("예약현황요청 API");
			}else if(data.apiDtlVO.linkDiv == "O200"){
				$("#modLinkDivNm").val("예약가능여부 API");
			}else if(data.apiDtlVO.linkDiv == "O300"){
				$("#modLinkDivNm").val("예약처리요청 API");
			}else if(data.apiDtlVO.linkDiv == "O200"){
				$("#modLinkDivNm").val("예약취소요청 API");
			}
			$("#modSvcUrl").val(data.apiDtlVO.svcUrl);
			$("#modSvcExp").val(data.apiDtlVO.svcExp);
			
			show_popup($("#lay_popup2"));
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

/**
 * API 등록
 */
function fn_InsApi(){
	var parameters = "apiId=" + $("#apiId").val();
	parameters += "&linkDiv=" + $("#insLinkDiv").val();
	parameters += "&svcUrl=" + $("#insSvcUrl").val();
	parameters += "&svcExp=" + $("#insSvcExp").val();
	
	$.ajax({
		url : "<c:url value='/apiCn/insertApiDtl.ajax'/>",
		data : parameters,
		dataType:"json",
		success: function(data) {
			alert("API가 등록되었습니다.");
			document.frm.action = "<c:url value='/apiCn/apiContents.do'/>";
			document.frm.submit();
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

/**
 * API 수정
 */
function fn_UdtApi(){
	var parameters = "apiId=" + $("#apiId").val();
	parameters += "&linkDiv=" + $("#modLinkDiv").val();
	parameters += "&svcUrl=" + $("#modSvcUrl").val();
	parameters += "&svcExp=" + $("#modSvcExp").val();
	
	$.ajax({
		url : "<c:url value='/apiCn/updateApiDtl.ajax'/>",
		data : parameters,
		dataType:"json",
		success: function(data) {
			alert("API가 수정되었습니다.");
			document.frm.action = "<c:url value='/apiCn/apiContents.do'/>";
			document.frm.submit();
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

$(document).ready(function(){
	
});
</script>
</head>
<body>
<div class="blackBg"></div>
<div id="wrapper"> 
	<jsp:include page="/apiCn/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
		
			<div id="contents">
				<h4 class="title04">${apicnVO.corpNm}(${apicnVO.corpId}) API</h4>
				<h4 class="title03">예약처리 API</h4>
				<form name="frm" id="frm">
					<input type="hidden" name="apiId" id="apiId" value="${apicnVO.apiId}" />
				</form>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">서비스 URL</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'I100'}">
									${api.svcUrl}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">서비스 설명</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'I100'}">
									${api.svcExp}
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</table>
				<h4 class="title03 margin-top45">예약취소 API</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">서비스 URL</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'I200'}">
									${api.svcUrl}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">서비스 설명</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'I200'}">
									${api.svcExp}
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</table>
				<h4 class="title03 margin-top45">예약현황요청 API</h4>
				<c:set var="apiChk" value="N" />
				<c:forEach var="api" items="${apiList}" varStatus="status">
					<c:if test="${api.linkDiv eq 'O100'}">
						<c:set var="apiChk" value="Y" />		
					</c:if>
				</c:forEach>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
                    <c:if test="${apiChk == 'N'}">
                    <tr>
                    	<td colspan="2">API를 등록해주세요.</td>
                    </tr>
                </table>
                <div class="btn_rt01">
					<div class="btn_sty04"><a href="javascript:fn_OpenInsApi('O100');">API 등록</a></div>
				</div>
                    </c:if>
                    <c:if test="${apiChk == 'Y'}">
					<tr>
						<th scope="row">서비스 URL</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O100'}">
									${api.svcUrl}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">서비스 설명</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O100'}">
									${api.svcExp}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					</table>
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_OpenModApi('O100');">API 수정</a></div>
					</div>
					</c:if>
				<h4 class="title03 margin-top45">예약가능여부 API</h4>
				<c:set var="apiChk" value="N" />
				<c:forEach var="api" items="${apiList}" varStatus="status">
					<c:if test="${api.linkDiv eq 'O200'}">
						<c:set var="apiChk" value="Y" />		
					</c:if>
				</c:forEach>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
                    <c:if test="${apiChk == 'N'}">
                    <tr>
                    	<td colspan="2">API를 등록해주세요.</td>
                    </tr>
                    </table>
                <div class="btn_rt01">
					<div class="btn_sty04"><a href="javascript:javascript:fn_OpenInsApi('O200');">API 등록</a></div>
				</div>
                    </c:if>
                    <c:if test="${apiChk == 'Y'}">
					<tr>
						<th scope="row">서비스 URL</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O200'}">
									${api.svcUrl}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">서비스 설명</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O200'}">
									${api.svcExp}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					</table>
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_OpenModApi('O200');">API 수정</a></div>
					</div>
					</c:if>
				<h4 class="title03 margin-top45">예약처리요청 API</h4>
				<c:set var="apiChk" value="N" />
				<c:forEach var="api" items="${apiList}" varStatus="status">
					<c:if test="${api.linkDiv eq 'O300'}">
						<c:set var="apiChk" value="Y" />		
					</c:if>
				</c:forEach>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
                    <c:if test="${apiChk == 'N'}">
                    <tr>
                    	<td colspan="2">API를 등록해주세요.</td>
                    </tr>
                    </table>
                <div class="btn_rt01">
					<div class="btn_sty04"><a href="javascript:javascript:fn_OpenInsApi('O300');">API 등록</a></div>
				</div>
                    </c:if>
                    <c:if test="${apiChk == 'Y'}">
					<tr>
						<th scope="row">서비스 URL</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O300'}">
									${api.svcUrl}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">서비스 설명</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O300'}">
									${api.svcExp}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					</table>
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_OpenModApi('O300');">API 수정</a></div>
					</div>
					</c:if>
				<h4 class="title03 margin-top45">예약취소요청 API</h4>
				<c:set var="apiChk" value="N" />
				<c:forEach var="api" items="${apiList}" varStatus="status">
					<c:if test="${api.linkDiv eq 'O400'}">
						<c:set var="apiChk" value="Y" />		
					</c:if>
				</c:forEach>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                       	<col width="*" />
                    </colgroup>
                    <c:if test="${apiChk == 'N'}">
                    <tr>
                    	<td colspan="2">API를 등록해주세요.</td>
                    </tr>
                    </table>
                <div class="btn_rt01">
					<div class="btn_sty04"><a href="javascript:javascript:fn_OpenInsApi('O400');">API 등록</a></div>
				</div>
                    </c:if>
                    <c:if test="${apiChk == 'Y'}">
					<tr>
						<th scope="row">서비스 URL</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O400'}">
									${api.svcUrl}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">서비스 설명</th>
						<td>
							<c:forEach var="api" items="${apiList}" varStatus="status">
								<c:if test="${api.linkDiv eq 'O400'}">
									${api.svcExp}
								</c:if>
							</c:forEach>
						</td>
					</tr>
					</table>
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_OpenModApi('O400');">API 수정</a></div>
					</div>
					</c:if>
            </div>
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
 					<caption class="tb01_title">API 등록</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
				<tr>
					<th>연계 구분</th>
					<td>
						<input type="hidden" name="insLinkDiv" id="insLinkDiv" />
						<input type="text" class="input_text_full" name="insLinkDivNm" id="insLinkDivNm" readonly="readonly" /> 
					</td>
				</tr>
				<tr>
					<th>서비스 URL</th>
					<td>
						<input type="text" class="input_text_full" name="insSvcUrl" id="insSvcUrl" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th>서비스 설명</th>
					<td>
						<input type="text" class="input_text_full" name="insSvcExp" id="insSvcExp" maxlength="80" />
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty04" id="btnResist"><a href="javascript:fn_InsApi();">API등록</a></span>
	</div>
</div>

<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
		<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" id="cntLay">
 					<caption class="tb01_title">API 수정</caption>
 					<colgroup>
                      <col width="170" />
                      <col width="*" />
                  	</colgroup>
				<tr>
					<th>연계 구분</th>
					<td>
						<input type="hidden" name="modLinkDiv" id="modLinkDiv" />
						<input type="text" class="input_text_full" name="modLinkDivNm" id="modLinkDivNm" readonly="readonly" /> 
					</td>
				</tr>
				<tr>
					<th>서비스 URL</th>
					<td>
						<input type="text" class="input_text_full" name="modSvcUrl" id="modSvcUrl" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th>서비스 설명</th>
					<td>
						<input type="text" class="input_text_full" name="modSvcExp" id="modSvcExp" maxlength="80" />
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty03" id="btnResist"><a href="javascript:fn_UdtApi();">API수정</a></span>
	</div>
</div>
</body>
</html>