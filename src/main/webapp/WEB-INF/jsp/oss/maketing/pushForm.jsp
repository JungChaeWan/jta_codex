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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_CheckMessageLen(obj){
	if(parseInt(strLengthCheck(obj.value)) > 120){
		$("#msgByte").css("color","#F00");
	}else{
		$("#msgByte").css("color","#333");
	}
	$("#msgByte").html(strLengthCheck(obj.value));
	
}

/**
 * file init
 */
function makeFileAttachment(){
	 var maxFileNum = 1;
	 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}


$(document).ready(function(){
	makeFileAttachment();
	
	$("#pushForm").ajaxForm({
		beforeSubmit:function(data,form,option){
			if(parseInt(strLengthCheck($("#trMsg").val())) == 0){
				alert("내용을 입력하세요.");
				$("#trMsg").focus();
				return false;
				
			}
			if(parseInt(strLengthCheck($("#trMsg").val())) > 120){
				alert("120Byte까지만 메시지를 전송하실수 있습니다.");
				$("#trMsg").focus();
				return false;
			}
		},
		success:function(response,status){
			alert("PUSH 전송처리 되었습니다.");
			
		},
		error:function(){
			
		}
	});
	
	$("input[name=urlChk]").click(function(){
		if($(this).is(":checked")){
			$("input[name=url]").hide();
		}else{
			$("input[name=url]").show();
		}
	});
	
});


</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=push" flush="false"></jsp:include>
		<div id="contents_area">
		
		
			<div id="contents">
            
            <form id="pushForm" name="pushForm" method="post" action="<c:url value='/oss/sendPush.do'/>" enctype="multipart/form-data">
				<div class="search_result" style="width: 970px;">
					<table border="1" class="table01">
						<tr>
							<th scope="row" width="233">메시지<span>*</span></th>
							<td colspan="3" class="align_lt01">
								<textarea name="trMsg" id="trMsg" cols="85" rows="5" title="PUSH 메시지를 입력하세요." onkeyup="javascript:fn_CheckMessageLen(this)"></textarea>
								<p style="text-align:right; padding:10px 35px 0 0;"><strong style="margin-right:4px;" id="msgByte">0</strong>Byte/<span style="margin-right:4px;">120</span>Byte</p>
							</td>
						</tr>
						<tr>
							<th scope="row" width="233">이미지</th>
							<td colspan="3" class="align_lt01">
								<div id="egovComFileList"></div>
								<input type="file" id="egovComFileUploader" name="file" accept="image/*" style="width: 70%;" />
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr>
						<tr>
							<th scope="row" width="233">URL</th>
							<td colspan="3" class="align_lt01">
								<label for="urlChk"><input type="checkbox" name="urlChk" id="urlChk" />일반알림</label><br/>
								http://m.tamnao.com/mw/<input type="text" name="url" class="input_text02" />
							</td>
						</tr>
					</table>
					<ul class="btn_rt01">
						<li class="btn_sty03"><input type="submit" value="전송" /></li>
					</ul>
				</div>
			</form>
		
		</div>

	</div>
</div>
</body>
</html>