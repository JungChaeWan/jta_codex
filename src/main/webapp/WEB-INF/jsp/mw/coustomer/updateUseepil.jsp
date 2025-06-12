<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />

<head>
	<meta name="robots" content="noindex, nofollow">
	<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css'/>">
<script type="text/javascript">

</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>

<script type="text/javascript">

function fn_useepilChageLike(nGpa){
	var i=0;
	for(i=1; i<=5 ;i++){
		if(i <= nGpa){
			$("#ue_like"+i).attr("src", "<c:url value='/images/mw/icon/star_on.png'/>" );
		}else{
			//console.log("#ue_like"+i +"<="+ nGpa + ":x");
			$("#ue_like"+i).attr("src", "<c:url value='/images/mw/icon/star_off.png'/>" );
		}
	}
	$("#gpa").val(nGpa);
}


function fn_Mod(){
	//입력 검사
	
	if(document.frm.gpa.value==0){
		alert("평점을 선택 하세요.");
		return;
	}
	
	if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
	//if($("#contents").val().length == 0){
	if(document.frm.contents.value.length==0){
		alert("이용 후기를 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.frm.contents.value.length >= 500){
		alert("이용 후기의 길이는 500자 이하 입니다.");
		document.frm.contents.focus();
		return;
	}
	
	document.frm.action = "<c:url value='/mw/coustomer/udateUseepil.do'/>";
	document.frm.submit();
		
}

function fn_useepilImgDelete(pos, useEpilNum, imgNum) {
	if (confirm('첨부 이미지를 삭제하겠습니까?')) {
		$.ajax({
			type:"post", 
			url:"<c:url value='/web/cmm/useepilImgDelete.ajax'/>",
			data:"useEpilNum=" + useEpilNum + "&imgNum=" + imgNum ,
			success:function(data){
				if (data.Status == 'success') {
					alert('파일을 삭제 했습니다.');
					$('#imgTool_' + pos).html('<input type="file" name="img' + (pos+1) + '" accept="image/*">');
				}
			},
			error : fn_AjaxError
		});
	}
}

$(document).ready(function(){
	fn_useepilChageLike(${useepil.gpa});
});



</script>


</header>
<!-- 헤더 e -->


<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>이용후기</h2>
	</div>
	<div class="sub-content">

		<div class="board">
			<dl class="txt-box">
				<dt>이용후기 수정</dt>
				<dd>주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</dd>
			</dl>
			<form name="frm" method="post" onSubmit="return false;" enctype="multipart/form-data">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="useEpilNum" name="useEpilNum" value="${useepil.useEpilNum}"/>
				<input type="hidden" id="corpId" name="corpId" value="${useepil.corpId}"/>
				<input type="hidden" id="prdtnum" name="prdtnum" value="${useepil.prdtnum}"/>
			
				<table class="write bt-none">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<!-- 
					<tr>
						<th>작성자</th>
						<td>00000</td>
					</tr>
					<tr>
						<th><label for="email">이메일</label></th>
						<td class="email">
							<input type="text" id="email">
							@
							<input type="text" id="email2">
							<select name="email" id="email3">
								<option value="직접입력">직접입력</option>
							</select>
						</td>
					</tr>
					-->
					<tr>
						<th><label for="product">상품</label></th>
						<td class="cate">
							<c:out value="${useepil.subjectHeder}"/>                                                                   	
						</td>
					</tr>
					<tr>
						<th><label for="product">평점</label></th>
						<td class="cate">
							<span>
								<a href="javascript:fn_useepilChageLike(1)"><img id="ue_like1" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(2)"><img id="ue_like2" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(3)"><img id="ue_like3" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(4)"><img id="ue_like4" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요"></a>
								<a href="javascript:fn_useepilChageLike(5)"><img id="ue_like5" src="<c:url value='/images/mw/icon/star_off.png'/>" alt="좋아요" ></a>
								<input type="hidden" name="gpa" id="gpa" value="0" />
							</span>
						</td>
					</tr>
					<tr>
						<th><label for="reviewType">유형</label></th>
						<td class="cate">
							<select id="reviewType" name="reviewType">
								<option value="">-선택하세요-</option>
								<c:forEach var="rvtp" items="${cdRvtp}" varStatus="status">
									<option value="${rvtp.cdNum}"  <c:if test="${rvtp.cdNum eq useepil.reviewType}">selected="selected"</c:if>>${rvtp.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><label for="title">제목</label></th>
						<td class="full">
							<input type="text" id="title" id="subject" name="subject" maxlength="50" value="${useepil.subject}">
						</td>
					</tr>
					<tr>
						<th><label for="con">내용</label></th>
						<td><textarea id="con" cols="45" rows="5" id="contents" name="contents" maxlength="500">${useepil.contents}</textarea></td>
					</tr>
					<tr>
                    	<th>이미지</th>
                    	<td class="attachments">
                    		<c:forEach items="${imgList }" var="img" varStatus="stat">
                    		<p class="file" id="imgTool_${stat.index }">${img.realFileNm } <a href="javascript:fn_useepilImgDelete('${stat.index }', '${img.useEpilNum}', '${img.imgNum}')">[삭제]</a></p>
                    		</c:forEach>                                                    		
                    		<c:forEach var="i" begin="${fn:length(imgList)+1 }" end="5">
                    		<p class="file"><input type="file" name="img${i}" accept="image/*"></p>
                    		</c:forEach>
                    		<p class="label">* 이미지는 5개까지 첨부 가능 합니다.</p>
                    	</td>
                    </tr>
				</table>
				<p class="btn-list">
					<a href="#" onclick="fn_Mod()" class="btn btn1">저장</a> 
					<a href="javascript:history.back();" class="btn btn2">취소</a>
				</p>
				
			</form>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->



<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>
