
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<script type="text/javascript">

function fn_List(){	
	document.frm.action = "<c:url value='/mas/${corpCd}/otoinqList.do'/>";
	document.frm.submit();
}

function fn_Udt(){
	if(document.frm.ansContents.value == ""){
		alert("답변 내용을 입력 하세요.");
		return;
	}
	document.frm.action = "<c:url value='/mas/otoinq/updateOtoinq.do'/>";
	document.frm.submit();
}

</script>


			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="otoinqNum" name="otoinqNum" value='<c:out value="${data.otoinqNum}" />' />
				<input type="hidden" id="printYn" name="printYn" value="0"/>
				
					<h4 class="title03">1:1문의 상세</h4>
					
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">No.</th>
							<td colspan="3"><c:out value="${data.otoinqNum}" /></td>
						</tr>
						<c:if test="${!(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOLF) }">
							<tr>
								<th>상품</th>
								<td colspan="3"><c:out value="${data.prdtNm}" />(<c:out value="${data.prdtNum}" />)</td>
							</tr>
						</c:if>
						<tr>
							<th>사용자아이디</th>
							<td><c:out value="${data.writer}" /></td>
							<th>E-Mail</th>
							<td><c:out value="${data.email}" /></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><c:out value="${userVO.userNm}" /></td>
							<th>전화번호</th>
							<td><c:out value="${userVO.telNum}" /></td>
						</tr>
						<tr>
							<th>시간</th>
							<td ><c:out value="${data.lastModDttm}" /></td>
							<th>표시여부</th>
							<td>
								<c:if test="${data.printYn=='Y'}">표시</c:if>
								<c:if test="${data.printYn=='N'}"><font color="#980000">차단</font></c:if>
							</td>
						</tr>
						<tr>
							<th >제목</th>
							<td colspan="3">
								<c:out value="${data.subject}"/>
							</td>
						</tr>
								
						
						<tr>
							<th>내용</th>
							<td colspan="3">
								<c:out value="${data.contents}" escapeXml="false"/>
							</td>
						</tr>
						
					</table>
					<br/>			
					
					<h4 class="title03">답글</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th>답변아이디</th>
							<td><c:out value="${data.ansWriter}" /></td>
							<th>답변E-Mail</th>
							<td><c:out value="${data.ansEmail}" /></td>
						</tr>
						<tr>
							<th>시간</th>
							<td ><c:out value="${data.ansLastModDttm}" /></td>
							<th>업체명</th>
							<td><c:out value="${data.corpNm}" /></td>
						</tr>
						<tr>
							<th>답변</th>
							<td colspan="3">
								<textarea name="ansContents" id="ansContents" cols="70" rows="5" style="width: 100%"><c:out value="${data.ansContents}" escapeXml="false"/></textarea>
							</td>
						</tr>
						
					</table>
					
					
					<ul class="btn_rt01">
						<li class="btn_sty04">
							<a href="javascript:fn_Udt()">답변 수정</a>
						</li>
						<li class="btn_sty01">
							<a href="javascript:fn_List()">목록</a>
						</li>
					</ul>
			</form>

