<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<script>
	$(document).keyup(function(event) {
    if (event.which === 13) {
        fn_InsertProductAppr();
    }
	});
</script>
<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#div_ProductAppr'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
<ul class="form_area">
	<li>
		<form:form commandName="CM_CONFHISTVO"  name="CM_CONFHISTVO" method="post">
			<input type="hidden" name="linkNum" value="${resultVO.linkNum}"/>
			<input type="hidden" name="corpId" value="${resultVO.corpId}"/>
			<input type="hidden" name="prdtNm" value="${resultVO.prdtNm}"/>

			<h5 class="title06">상품 승인</h5>
			<table border="1" cellpadding="0" cellspacing="0" class="table02">
				<colgroup>
					<col width="150" />
					<col width="*" />
				</colgroup>
				<tr>
					<th>업체명</th>
					<td><span><c:out value="${resultVO.corpNm}" /></span></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><span><c:out value="${resultVO.prdtNm}"/></span></td>
				</tr>
				<c:if test="${Constant.SV eq fn:substring(resultVO.linkNum,0,2)}">
					<tr>
						<th>JQ인증 상품</th>
						<td>
							<input type="checkbox" id="jqYn" name="jqYn" value="${resultVO.jqYn}" <c:if test="${resultVO.jqYn eq 'Y'}">checked</c:if>/>&nbsp;
							<img src="<c:url value='/images/oss/icon/jq.png'/>" width="20px" />
						</td>
					</tr>
					<tr>
						<th>제주관광기념품공모전 수상작</th>
						<td>
							<input type="checkbox" id="superbSvYn" name="superbSvYn" value="${resultVO.superbSvYn}" <c:if test="${resultVO.superbSvYn eq 'Y'}">checked</c:if>/>&nbsp;
							<img src="<c:url value='/images/oss/icon/superb_sv.png'/>" width="20px" />
						</td>
					</tr>
				</c:if>
				<c:if test="${Constant.SV eq fn:substring(resultVO.linkNum,0,2) || Constant.SOCIAL eq fn:substring(resultVO.linkNum,0,2) }">
				<tr>
					<th>6차산업인증 카테고리</th>
					<td>
						<select name="sixCertiCate">
							<option value="">-------선택-------</option>
							<c:forEach items="${tsCdList}" var="tsCd">
								<option value="${tsCd.cdNum}" <c:if test="${tsCd.cdNum eq resultVO.sixCertiCate}">selected="selected"</c:if>><c:out value="${tsCd.cdNm}" /></option>
							</c:forEach>
						</select>

					</td>
				</tr>
				</c:if>
				<tr>
					<th>상태</th>
					<td>
						<form:select path="tradeStatus">
							<option value="${Constant.TRADE_STATUS_APPR}" <c:if test="${Constant.TRADE_STATUS_APPR eq resultVO.tradeStatus}">selected="selected"</c:if>>승인</option>
							<option value="${Constant.TRADE_STATUS_APPR_REJECT}" <c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq resultVO.tradeStatus}">selected="selected" </c:if>>승인거절</option>
							<option value="${Constant.TRADE_STATUS_STOP}" <c:if test="${Constant.TRADE_STATUS_STOP eq resultVO.tradeStatus}">selected="selected" </c:if>>판매중지</option>
							<option value="${Constant.TRADE_STATUS_EDIT}" <c:if test="${Constant.TRADE_STATUS_EDIT eq resultVO.tradeStatus}">selected="selected" </c:if>>수정요청</option>
						</form:select>
						<input type="radio" name="msgSendYn" value="Y">MMS전송
						<input type="radio" name="msgSendYn" value="N" checked>MMS미전송
					</td>
				</tr>
				<tr>
					<th>전달사항</th>
					<td><textarea name="msg" id="msg" rows="10"  style="width:97%">${resultVO.msg}</textarea></td>
				</tr>
			</table>
		</form:form>
	</li>
</ul>
<div class="btn_ct01"><span class="btn_sty04"><a href="javascript:fn_InsertProductAppr();">적용</a></span></div>
