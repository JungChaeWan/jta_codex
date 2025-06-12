
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
					<input type="hidden" name="linkNum" value="<c:out value='${CM_IMGVO.linkNum}'/>"/>
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="imgNum" />
                <ul class="gallery_list">
                    <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
					<c:if test="${fn:length(resultList) == 0}">
						<spring:message code="info.nodata.msg" />
					</c:if>
					<c:forEach var="result" items="${resultList}" varStatus="status">
          				<li><span class="photo"><img src="${result.savePath}thumb/${result.saveFileNm}" alt="" width="250" /></span></li>
       				</c:forEach>
                </ul>
             </div>
             <div class="register_area">
                <ul class="btn_rt01">
                    <li class="btn_sty02"><a href="javascript:fn_PrdtList()">목록</a></li>
                </ul>
            </div>
            </form:form>
            <!--//상품등록--> 
            <!--//본문--> 
