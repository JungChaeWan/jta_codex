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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

/**
 * 수정 폼 validator 체크
 */
function fn_UdtCorp(){

	if(confirm("업체광고정보를 수정하시겠습니까?")){
		document.CORPADTMMNGVO.action = "<c:url value='/mas/updateCorpAdtm.do' />";
		document.CORPADTMMNGVO.submit();
	}

}


</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="CORPADTMMNGVO" name="CORPADTMMNGVO" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpId" name="corpId" value='<c:out value="${corpId}" />' />

			<div id="contents">

				<!--업체 정보-->
				<h4 class="title03">업체 광고 정보<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

				<table border="1" class="table02">
                    <tr>
						<th>한줄소개</th>
						<td>
							<form:input path="corpRptExp" class="input_text_full" value="${corpAdtmMngVO.corpRptExp}" maxlength="60"/>
							<br /><span class="font_red">글자 수는 60자 제한입니다.</span>
						</td>
					</tr>
					<tr>
						<th>회사 대표 이미지</th>
						<td>
							<c:if test="${not empty corpAdtmMngVO.corpRptImgFileNm}">
							<div id="d_img">
								<img src="<c:url value='${corpAdtmMngVO.corpRptImgPath}${corpAdtmMngVO.corpRptImgFileNm}'/>" alt="" style="margin-bottom: 10px; max-width: 100%;" />
							</div>
							</c:if>
							<input type="file" id="adtmImgFile" name="adtmImgFile" accept="image/*" style="width: 70%;  <c:if test="${not empty corpInfo.adtmImg}">display:none</c:if>" />
							<!-- <br /><span class="font_red">가로 90 pixel * 세로 60 pixel 크기에 최적화 되었습니다.</span> -->
							<input type="hidden" id="adtmImg"  name="adtmImg" class="input_text5" value="${corpInfo.adtmImg}" />
		         		<c:if test="${not empty fileError}"><br/>Error:<c:out value="${fileError}"/></c:if>
						</td>
					</tr>
				</table>

				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtCorp()">수정</a>
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