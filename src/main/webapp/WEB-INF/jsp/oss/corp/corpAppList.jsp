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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">


</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corpapp" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="corpId" name="corpId" />
			<div id="contents">
			<!--검색-->
            <div class="search_box">
            	<div class="search_form">
                	<div class="tb_form">
						<table width="100%" border="0">
							<colgroup>
								<col width="100" />
                                <col width="*" />
                                <col width="100" />
                                <col width="*" />
							</colgroup>
             				<tbody>
             					<tr>
        							<th scope="row">카테고리</th>
        							<td colspan="3">
        								<select>
        									<option>항공</option>
        									<option>여행사</option>
        									<option>숙박</option>
        									<option>렌터카</option>
        									<option>골프</option>
        									<option>관광지/레저</option>
        								</select>
        							</td>
        							<th scope="row">처리상태</th>
        							<td colspan="3">
        								<select>
        									<option>신청중</option>
        									<option>승인검토중</option>
        									<option>승인완료</option>
        									<option>입점불가</option>
        									<option>입점취소</option>
        								</select>
        							</td>
     							</tr>
     							<tr>
        							<th scope="row">신청일</th>
        							<td colspan="3">
        								<input type="text" id="startDtView" name="startDtView" class="input_text5 hasDatepicker" value="2015-11-10" readonly="readonly"> ~
        								<input type="text" id="startDtView" name="startDtView" class="input_text5 hasDatepicker" value="2015-11-10" readonly="readonly">
        								
        								
        							</td>
        							<th scope="row">업&nbsp;체&nbsp;명</th>
        							<td colspan="3"><input type="text" id="sCorpNm" class="input_text13" name="sCorpNm" value="" title="검색하실 고객명를 입력하세요." /></td>
     							</tr>
     						</tbody>
               			</table>
               		</div>
					<span class="btn">
						<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
					</span>
              	</div>
            </div>
            <p class="search_list_ps">[총 <strong>20</strong>건]</p> 
			<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				<thead>
					<tr>
						<th>번호</th>
						<th>상태</th>
						<th>업체명</th>
						<th>카테고리</th>
						<th>대표자명</th>
						<th>담당자명</th>
						<th>전화번호</th>
						<th>요청일</th>
						<th>처리일</th>
						<th> </th>
					</tr>
				</thead>
				<tbody>

												<tr style="cursor:pointer;" >
							<td class="align_ct">신청중</td>	<td class="align_ct">제주114</td>	<td class="align_ct">여행사</td>	<td class="align_ct">강주경</td>	<td class="align_ct">함경태</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">-</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">승인관리</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">승인검토중</td>	<td class="align_ct">넥스트이지</td>	<td class="align_ct">숙박</td>	<td class="align_ct">강주경</td>	<td class="align_ct">함경태</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-02</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">승인관리</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">승인완료</td>	<td class="align_ct">아트피큐</td>	<td class="align_ct">렌터카</td>	<td class="align_ct">오태현</td>	<td class="align_ct">임수진</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-03</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">상세보기</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">입점불가</td>	<td class="align_ct">관광협회</td>	<td class="align_ct">관광지/레저</td>	<td class="align_ct">김영진</td>	<td class="align_ct">장혜리</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-02</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">상세보기</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">입점불가</td>	<td class="align_ct">관광협회</td>	<td class="align_ct">관광지/레저</td>	<td class="align_ct">김영진</td>	<td class="align_ct">장혜리</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-02</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">상세보기</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">신청중</td>	<td class="align_ct">제주114</td>	<td class="align_ct">여행사</td>	<td class="align_ct">강주경</td>	<td class="align_ct">함경태</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">-</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">승인관리</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">승인검토중</td>	<td class="align_ct">넥스트이지</td>	<td class="align_ct">숙박</td>	<td class="align_ct">강주경</td>	<td class="align_ct">함경태</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-02</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">승인관리</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">승인완료</td>	<td class="align_ct">아트피큐</td>	<td class="align_ct">렌터카</td>	<td class="align_ct">오태현</td>	<td class="align_ct">임수진</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-03</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">상세보기</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">입점불가</td>	<td class="align_ct">관광협회</td>	<td class="align_ct">관광지/레저</td>	<td class="align_ct">김영진</td>	<td class="align_ct">장혜리</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-02</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">상세보기</a></span></div></td>
						</tr>
						<tr style="cursor:pointer;" >
							<td class="align_ct">입점불가</td>	<td class="align_ct">관광협회</td>	<td class="align_ct">관광지/레저</td>	<td class="align_ct">김영진</td>	<td class="align_ct">장혜리</td>	<td class="align_ct">721-8118</td>		<td class="align_ct">010-1234-5678</td>	<td class="align_ct">2015-10-01</td>	<td class="align_ct">2015-10-02</td>
							<td class="align_ct"><div class="btn_sty06"><span><a href="#">상세보기</a></span></div></td>
						</tr>
						

				</tbody>
			</table>
			<p class="list_pageing">
				<strong>1</strong>&#160;<span><a href="#" onclick="fn_Search(2); return false;">2</a></span>&#160;<span><a href="#" onclick="fn_Search(3); return false;">3</a></span>&#160;<span><a href="#" onclick="fn_Search(4); return false;">4</a></span>&#160;<span><a href="#" onclick="fn_Search(5); return false;">5</a></span>&#160;

			</p>


			</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>