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
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<title></title>

<script type="text/javascript">


</script>
</head>
<body>
<div id="wrapper"> 
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents"> 
			<!--본문-->
			<!--상품 등록-->
			<form name="corp" method="post">
			<div class="register_area">
				<p class="title01">입점업체 등록</p>
				<h2 class="title02">업체 정보</h2>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
					<tr>
						<th scope="row">업체아이디<span class="font02">*</span></th>
						<td>
							<input type="hidden" id="corpId" name="corpId" value="${corpInfo.corpId}" />
							${corpInfo.corpId}
						</td>
						<th>연계여부</th>
						<td>
							<input type="hidden" id="corpLinkYn" name="corpLinkYn" value="${corpInfo.corpLinkYn}" />
							<input type="checkbox" id="corpLinkYn_chk" name="corpLinkYn_chk" <c:if test="${corpInfo.corpLinkYn=='Y'}">checked="checked"</c:if> /> 연계
							
						</td>
					</tr>
					<tr>
						<th>업체명</th>
						<td>
							<input type="text" id="corpNm" name="corpNm" value="${corpInfo.corpNm}" />
						</td>
						<th>업체구분</th>
						<td>
							<select id="corpCd" name="corpCd">
								<option value="AD">숙소</option>
								<option value="RC">렌트카</option>
								<option value="GL">골프</option>
								<option value="SP">소셜상품</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td>
							<input type="text" id="coRegNum" name="coRegNum" />
						</td>
						<th>대표자명</th>
						<td>
							<input type="text" id="ceoNm" name="ceoNm" />
						</td>
					</tr>
					<tr>
						<th>대표전화번호</th>
						<td>
							<input type="text" id="ceoTelNum" name="ceoTelNum" />
						</td>
						<th>예약전화번호</th>
						<td>
							<input type="text" id="rsvTelNum" name="rsvTelNum" />
						</td>
					</tr>
					<tr>
						<th>업체이메일</th>
						<td>
							<input type="text" id="corpEmail" name="corpEmail" />
						</td>
						<th>홈페이지주소</th>
						<td>
							<input type="text" id="hmpgAddr" name="hmpgAddr" />
						</td>
					</tr>
					<tr>
						<th>업체주소</th>
						<td colspan="3">
							<a href="javascript:openDaumPostcode()" title="우편번호 찾기">주소검색</a>
							<input type="text" id="roadNmAddr" name="roadNmAddr" readonly="readonly" />
							<input type="text" id="dtlAddr" name="dtlAddr" />
						</td>
					</tr>
					<tr>
						<th>위도/경도</th>
						<td colspan="3">
							<a href="javascript:fn_FindLocation()">좌표찾기</a>
							위도 : <input type="text" id="lat" name="lat" />
							경도 : <input type="text" id="lon" name="lon" />
						</td>

					</tr>
				</table>
			</div>
			</form>
			<!--//상품등록--> 
			<!--//본문--> 
			<ul class="button_right">
				<li class="button_rt02"><a href="javascript:fn_InsCorp()">저장</a></li>
				<li class="button_rt02"><a href="javascript:fn_ListCorp()">목록</a></li>
			</ul>
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>