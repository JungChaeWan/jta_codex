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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/taggle.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="code" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="/css/common/taggle.css">
<title></title>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>

<script type="text/javascript">
var hrkCodeItem = [];

function fn_InsCode(){
	// validation 체크
	if(!validateCode(document.code)){
		return;
	}
	$("#cdNmLike").val(taggle.getTagValues());
	if ($("#cdNmLike").val().indexOf("'") > 0){
		alert("코드명 유의어에 '특수문자는 사용 할 수 없습니다.");
		return;
	}
	document.code.action = "<c:url value='/oss/insertCode.do' />";
	document.code.submit();
}

function fn_getHrkCode(){
	var parameters = "";
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/getHrkCode.ajax'/>",
		data:parameters ,
		success:function(data){
			// 코드 배열
			var arrayItem = [];
//				alert(JSON.stringify(data));
			jQuery.each(data.cdList, function(index, onerow) {
				hrkCodeItem[index] = {label:onerow["cdNum"] + "(" + onerow["cdNm"] + ")", value:onerow["cdNum"]};
			});
			
			function split( val ){
//				return val.split( /,\s*/ );
				return val.split(",");
			}    
			function extractLast( term ){      
				return split( term ).pop();    
			}     
			
			// 상위코드
			$( "#hrkCdNum").bind( "keydown", function( event ) {
				if ( event.keyCode == $.ui.keyCode.TAB && $( this ).data( "ui-autocomplete" ).menu.active ) {
					event.preventDefault();
				}      
			}).autocomplete({        
				minLength: 0,
				source: function( request, response ) {
				// delegate back to autocomplete, but extract the last term          
					response( $.ui.autocomplete.filter(
							hrkCodeItem, extractLast( request.term ) ) 
					);
				},        
				focus: function() {
					// prevent value inserted on focus          
					return false;        
				},        
				select: function( event, ui ) {
					this.value = ui.item.value;
					return false;
				}      
			}).blur(function(){
				var strVal = this.value;
				if(strVal.substr(strVal.length-1, strVal.length) == ","){
					strVal = strVal.substr(0, strVal.length-1);
					this.value = strVal;
				} 
			});
		}
	});
}

function fn_ListCode(){
	document.code.action = "<c:url value='/oss/codeList.do' />";
	document.code.submit();
}

$(document).ready(function(){
	fn_getHrkCode();
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=setting" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=setting&sub=code" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="code" name="code" method="post">
				<input type="hidden" name="sCdNm" value="${searchVO.sCdNm}" />
				<input type="hidden" name="sHrkCdNum" value="${searchVO.sHrkCdNum}" />
				<input type="hidden" name="sCdNum" value="${searchVO.sCdNum}" />
				<input type="hidden" name="sHrkCdNm" value="${searchVO.sHrkCdNm}" />
			<div id="contents">
				<h4 class="title03">코드 등록</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                    	<th>코드<span class="font02">*</span></th>
                    	<td >
                    		<form:input path="cdNum" id="cdNum" value="${code.cdNum}" class="input_text10" placeholder="코드를 입력하세요." maxlength="4" />
                    		<form:errors path="cdNum"  cssClass="error_text" />
                    	</td>
                    </tr>
					<tr>
						<th scope="row">코드명<span class="font02">*</span></th>
						<td>
							<form:input path="cdNm" id="cdNm" value="${code.cdNm}" class="input_text10" placeholder="코드명을 입력하세요." maxlength="20" />
							<form:errors path="cdNm"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th scope="row">코드명 유의어</th>
						<td>
							<div id="divCdNmLike"></div>
							<script>
								let taggle  = new Taggle('divCdNmLike');
							</script>
							<input type="hidden" name="cdNmLike" id="cdNmLike">
						</td>
					</tr>
					<tr>
						<th>상위코드</th>
						<td>
							<form:input path="hrkCdNum" id="hrkCdNum" value="${code.hrkCdNum}" class="input_text10" placeholder="상위코드를 검색하세요." maxlength="4" />
							<form:errors path="hrkCdNum"  cssClass="error_text" />
						</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_InsCode()">저장</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_ListCode()">목록</a>
					</li>
				</ul>
			</div>
			</form:form>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>