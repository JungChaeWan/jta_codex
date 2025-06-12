<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
	<meta name="robots" content="noindex, nofollow">
	<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>

	<script type="text/javascript">
	/**
	 * 조회
	 */
	function fn_Search(){

		if($("#blogsUrl").val() == ""){
			alert("URL을 입력 하세요.");
			$("#blogsUrl").focus();
			return;
		}



		document.frm.action = "<c:url value='/web/cmm/insBLOG.do'/>";
		document.frm.target = "findPrdt";
		window.name = "findPrdt";
		document.frm.submit();
	}

	function fn_Ins(){

		if($("#blogsUrl").val() == ""){
			alert("URL을 입력 하세요.");
			$("#blogsUrl").focus();
			return;
		}

		if($("#blogSitename").val() == ""){
			$("#blogSitename").focus();
			return;
		}

		if($("#blogTitle").val() == ""){
			alert("제목을 입력하세요.");
			$("#blogTitle").focus();
			return;
		}

		if($("#blogDate").val() == ""){
			alert("날짜를 입력하세요.");
			$("#blogDate").focus();
			return;
		}

		if($("#blogDate").val().length != 8){
			alert("날짜를 20010101형태로 입력하세요.");
			$("#blogDate").focus();
			return;
		}



		document.frm.action = "<c:url value='/web/cmm/insBLOGproc.do'/>";
		document.frm.submit();

	}

	</script>

	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<!-- css -->
	<link rel="stylesheet" href="<c:url value='/css/web/common.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/web/style.css'/>">
</head>
<body>

<div id="wrap">

    <div class="popup-wrap">
    	<div class="blog-write">
    		<p class="caption-typeA"><!-- 홍보 또는 비방 목적의 게시글인 경우, 별도 고지 없이 삭제될 수 있습니다. --></p>

    		<form name="frm" method="post" onSubmit="return false;" enctype="multipart/form-data">
    			<input type="hidden" name="prdtNum" value="<c:out value="${prdtNum}"/>">
    			<input type="hidden" name="corpCd" value="<c:out value="${corpCd}"/>">
    			<input type="hidden" name="blogImageLinkYn" value="N">

	    		<table class="table-row">
				    <caption>블로그 올리기</caption>
				    <colgroup>
				        <col style="width: 20%">
				        <col>
				    </colgroup>
				    <tbody>
				        <tr>
				            <th>URL*</th>
				            <td class="input-btn-area">
				            	<input type="text" class="int" name="blogsUrl" id="blogsUrl" value="${blogUrl}">
				            	<button type="button" class="comm-btn" onclick="fn_Search();">확인</button>
				            	<c:if test="${error=='Y' }"><br>주소가 잘못 되었거나 서버가 응답하지 않습니다.</c:if>
				            </td>
				        </tr>
				        <tr>
				            <th>블로그 제목*</th>
				            <td>
				            	<input type="text" class="full" name="blogSitename" id="blogSitename" value="<c:out value="${blogSitename}"/>">
				            </td>
				        </tr>
				        <tr>
				            <th>제목*</th>
				            <td>
				            	<input type="text" class="full" name="blogTitle" id="blogTitle" value="<c:out value="${blogTitle}"/>">
				            </td>
				        </tr>
				        <tr>
				            <th>내용</th>
				            <td>
				            	<textarea rows="10" class="full" name="blogDescription" id="blogDescription">${blogDescription}</textarea>
				            </td>
				        </tr>
				        <tr>
				            <th>포스팅날짜*</th>
				            <td>
				            	<div class="date-container">
								    <span class="date-wrap">
								        <input type="text" placeholder="(20110101형식)" name="blogDate" id="blogDate" value="${blogDate}" maxlength="8">
								    </span>
								</div>
				            </td>
				        </tr>
				        <tr>
				            <th>이미지</th>
				            <td>
				            	<%-- <input type="text" class="full" name="blogImage" id="blogImage" value="<c:out value="${blogImage}"/>"> --%>
				            	<input type="file" accept="image/*" id="blogImageFile" name="blogImageFile" class="full">
				            	<br>※대표 이미지는 직접 등록 해야 합니다.
				            </td>
				        </tr>
				    </tbody>
				</table>
			</form>

			<div class="btn-wrap">
			    <button type="button" class="comm-btn red" onclick="fn_Ins();">등록</button>
			    <button type="button" class="comm-btn" onclick="window.close();">취소</button>
			</div>
    	</div> <!-- //blog-write -->
    </div> <!-- //popup-wrap -->

</div> <!--//wrap-->






</body>
</html>