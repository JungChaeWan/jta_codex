
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

/**
 * 목록
 */
 function fn_PrdtList(){
	document.prdtImg.action = "<c:url value='/mas/${corpCd}/productList.do'/>";
	document.prdtImg.submit();
}

</script>
            <!--본문-->
            <!--상품 등록-->
            <form:form commandName="prdtImg" name="prdtImg" method="post" enctype="multipart/form-data">
	            <div class="register_area">
	                <!-- <h2 class="title02">상품 이미지 관리</h2> -->
						<input type="hidden" name="newSn" value="0"/>
						<input type="hidden" name="oldSn" value="0"/>
						<input type="hidden" name="linkNum" value="<c:out value='${CM_DTLIMGVO.linkNum}'/>"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="imgNum" />
						<input type="hidden" name="pcImgYn" value=""/>
						<input type="hidden" name="imgSn" value=""/>
						
	             </div>
	             <div class="register_area">
	             	
	             	<h4 class="title02">PC용 이미지</h4>
		            <table border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>파일순번</th>
								<th>파일명</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(imgListPC) == 0}">
								<tr>
									<td colspan="3" class="align_ct">
										<spring:message code="info.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${imgListPC}" varStatus="status">
								<tr>
									<td class="align_ct">
										${result.imgSn}
									</td>
									<td class="align_ct">
										<c:out value="${result.realFileNm}"/> 
									</td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="${result.savePath}${result.saveFileNm}" target="_blank">보기</a></span></div>
									</td>
								</tr>
							</c:forEach>
						
						</tbody>
						
					</table>
		             
	             </div>
	            
	            <div class="register_area">
	             	
	             	<h4 class="title02">모바일용 이미지</h4>
		            <table border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>파일순번</th>
								<th>파일명</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(imgListM) == 0}">
								<tr>
									<td colspan="3" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${imgListM}" varStatus="status">
								<tr>
									<td class="align_ct">
										${result.imgSn}
									</td>
									<td class="align_ct">
										<c:out value="${result.realFileNm}"/>
									</td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="${result.savePath}${result.saveFileNm}" target="_blank">보기</a></span></div>
									</td>
								</tr>
							</c:forEach>
						
						</tbody>
						
					</table>
		             
	             </div>
            
            	<div class="register_area">
	                <ul class="btn_rt01">
		                    <li class="btn_sty02"><a href="javascript:fn_PrdtList()">목록</a></li>
	                </ul>
	            </div>
            
            
            </form:form>
            <!--//상품등록--> 
            <!--//본문--> 
