
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

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	//alert(document.frm.sBbsNm.value);
	
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/${corpCd}/otoinqList.do'/>";
	document.frm.submit();
}

/**
 * 업체 정보 상세보기
 */
function fn_Dtl(otoinqNum){
	document.frm.otoinqNum.value = otoinqNum;
	document.frm.action = "<c:url value='/mas/${corpCd}/detailOtoinq.do'/>";
	document.frm.submit();
}

</script>

			<h4 class="title03">1:1문의</h4><br/>
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="otoinqNum" name="otoinqNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				
				<!--검색-->
				<div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
          								<th scope="row">
          									<span class="tb_search_title"><select name="sKeyOpt" id="sKeyOpt" style="width:100px">
												<!-- <option value="1" <c:if test="${searchVO.sKeyOpt == '1'}">selected="selected"</c:if>>업체아이디</option> -->
												<c:if test="${!(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOLF) }">
													<option value="2" <c:if test="${searchVO.sKeyOpt == '2'}">selected="selected"</c:if>>상품번호</option>
												</c:if>
												<option value="3" <c:if test="${searchVO.sKeyOpt == '3'}">selected="selected"</c:if>>E-Mail</option>
												<option value="4" <c:if test="${searchVO.sKeyOpt == '4'}">selected="selected"</c:if>>제목</option>
											</select></span>
										</th>
          								<td>
          									<input type="text" id="sKey" class="input_text_full" name="sKey" value="${searchVO.sKey}" title="검색하실 코드명를 입력하세요." />
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
                
                <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p> 
	                <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>No.</th>
								<!-- <th>업체아이디</th> -->
								<c:if test="${!(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOLF) }">
									<th>상품</th>
								</c:if>
								<!-- <th>사용자ID</th> -->
								<th>E-Mail</th>
								<th>제목</th>
		                        <th>답변</th>
		                        <th>표시</th>
		                        <th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="18" align="center">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="data" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer; <%--<c:if test="${data.printYn=='N'}">background-color: #BDBDBD;</c:if> --%>" onclick="fn_Dtl('${data.otoinqNum}')">
									<td class="align_ct">${data.otoinqNum}</td>
									<!-- <td class="align_ct"><c:out value='${data.corpId}'/></td> -->
									<c:if test="${!(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOLF) }">
										<td class="align_ct"><c:out value='${data.prdtNm}'/>(<c:out value='${data.prdtNum}'/>)</td>
									</c:if>
									<!-- <td class="align_ct"><c:out value='${data.writer}'/></td> -->
									<td class="align_ct"><c:out value='${data.email}'/></td>
									<td class="align_ct"><c:out value='${data.subject}'/></td>
									<td class="align_ct">
										<c:if test="${!(data.ansContents == '' || data.ansContents == null) }">있음</c:if>
										<c:if test="${  data.ansContents == '' || data.ansContents == null  }">없음</c:if>
									</td>
									<td class="align_ct">
										<c:if test="${data.printYn=='Y'}">표시</c:if>
										<c:if test="${data.printYn=='N'}"><font color="#980000">차단</font></c:if>
									</td>
									<td class="align_ct"><c:out value='${data.lastModDttm}'/></td>								
								</tr>						
							</c:forEach>
							
						</tbody>
					</table>
				
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
			
			</form>
		

