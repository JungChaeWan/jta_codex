<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
$(document).ready(function(){
	layerP1();
});
</script>


<div class="option-change option-change2">
		<p class="btn-close"><a href="#"><img src="<c:url value='/images/mw/sub_common/close2.png'/>" width="23" alt="닫기"></a></p>
		<p class="goods-info">
			<input type="hidden" name="prdtNum" id="prdtNum" value="${prdtInfo.prdtNum}" >
			<img src="${prdtInfo.savePath}thumb/${prdtInfo.saveFileNm}" width="95" alt="상품이미지">
			<strong>${prdtInfo.prdtNm}</strong>
			${prdtInfo.corpNm}
		</p>
		<div class="rent-cart">
			<dl class="view-select">
				<dt>선택조건</dt>
				<dd>
					<div class="form1 form1-2">
						<label for="sFromDtView">대여일</label>
						<span>
							<fmt:parseDate value='${cartInfo.fromDt}' var='fromDt' pattern="yyyyMMdd" scope="page"/>
							<input type="text" name="sFromDtView" id="sFromDtView" value="<fmt:formatDate value='${fromDt}' pattern='yyyy-MM-dd'/>" readonly>
							<input type="hidden" name="sFromDt" id="sFromDt" value="${cartInfo.fromDt}">
							<input type="hidden" name="sFromTm" id="sFromTm" value="${cartInfo.fromTm}">
						</span>
						<select name="vFromTm" id="vFromTm" onchange="javascript:fn_OnchangeTime()">
		                    <c:forEach begin="8" end="20" step="1" var="fromTime">
		                       	<c:if test='${fromTime < 10}'>
		                       		<c:set var="fromTime_v" value="0${fromTime}00" />
		                       		<c:set var="fromTime_t" value="0${fromTime}:00" />
		                       	</c:if>
		                       	<c:if test='${fromTime > 9}'>
		                       		<c:set var="fromTime_v" value="${fromTime}00" />
		                       		<c:set var="fromTime_t" value="${fromTime}:00" />
		                       	</c:if>
		                        <option value="${fromTime_v}" <c:if test="${cartInfo.fromDt == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
		                    </c:forEach>
	                   	</select>
					</div>
					<div class="form1 form1-2">
						<label for="out">반납일</label>
						<span>
							<fmt:parseDate value='${cartInfo.toDt}' var='toDt' pattern="yyyyMMdd" scope="page"/>
							<input type="text" name="sToDtView" id="sToDtView" value="<fmt:formatDate value='${toDt}' pattern='yyyy-MM-dd'/>" readonly>
							<input type="hidden" name="sToDt" id="sToDt" value="${cartInfo.toDt}">
							<input type="hidden" name="sToTm" id="sToTm" value="${cartInfo.toTm}">
						</span>
						<select name="vToTm" id="vToTm" onchange="javascript:fn_OnchangeTime()">
		                    <c:forEach begin="8" end="20" step="1" var="toTime">
		                    	<c:if test='${toTime < 10}'>
		                    		<c:set var="toTime_v" value="0${toTime}00" />
		                    		<c:set var="toTime_t" value="0${toTime}:00" />
		                    	</c:if>
		                    	<c:if test='${toTime > 9}'>
		                    		<c:set var="toTime_v" value="${toTime}00" />
		                    		<c:set var="toTime_t" value="${toTime}:00" />
		                    	</c:if>
		                    <option value="${toTime_v}" <c:if test="${cartInfo.toTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
		                 	</c:forEach>
	                	</select>
					</div>
					<div class="form1 form1-3">
						<input name="time" value="총 24시간 30분" readonly="readonly" type="text">
					</div>
					<div class="form1 form1-4">
						<select id="payOption" onchange="javascript:fn_OptChange(this);" style="display: none;">
		                    <option value="0" <c:if test="${cartInfo.insureDiv=='0'}">selected="selected"</c:if>>선택안함</option>
		                    <option value="50000" <c:if test="${cartInfo.insureDiv=='50000'}">selected="selected"</c:if>>차량손해면책제도(5만원)</option>
		                    <option value="100000" <c:if test="${cartInfo.insureDiv=='100000'}">selected="selected"</c:if>>완전자차(10만원)</option>
		                </select>
		                <strong class="title-text">차량보험&nbsp;&nbsp;</strong>
						<!-- <a href="" class="btn btn-detail layer-1">상세보기</a> -->
						<a class="layer-1"><img height="32" src="<c:url value='/images/web/button/detail.gif'/>" alt="상세보기"></a>
						<div class="layerP1 rent-detail" style="display: none;">
		                	<img class="bubble" src="<c:url value='/images/web/icon/bubble.gif'/>" alt="말풍선" height="7" width="11">
		                   	<h4 class="title">
		                       차량손해면책제도 안내
		                        <a><img class="layerP1-close" src="<c:url value='/images/web/icon/close2.gif'/>" alt="닫기"></a>
		                   	</h4>
		                   	<div class="scroll-wrap">
			                   	<h5 class="sub-title"><img src="<c:url value='/images/web/travel/sb.gif'/>" alt="말풍선"> 공통 보험 안내</h5>
			                   	<div class="memoMsg">
			                   		<c:out value="${prdtInfo.isrCmGuide}" escapeXml="false"/>
			                   	</div>
			                   
			                   	<h5 class="sub-title"><img src="<c:url value='/images/web/travel/sb.gif'/>" alt="말풍선"> 차량별 보험 안내</h5>
			                   	<div class="memoMsg">
			                   		<c:out value="${prdtInfo.isrAmtGuide}" escapeXml="false"/>
			                   	</div>
		                   	</div>
		                    <!-- <a><img class="layerP1-close" src="<c:url value='/images/web/icon/close2.gif'/>" alt="닫기"></a> -->
		                </div>
					</div>
				</dd>
			</dl>

			<input type="hidden" name="carSaleAmt" id="carSaleAmt" />
	        <input type="hidden" name="nmlAmt" id="nmlAmt" />
	        <input type="hidden" name="insuSaleAmt" id="insuSaleAmt" value="${cartInfo.addAmt}" />
	        <input type="hidden" name="totalAmt" id="totalAmt" />
			<div class="select-del5">
				<p class="date"><span id="info_sDt"></span> <span id="info_sTm"></span> 부터 <span id="info_eDt"></span> <span id="info_eTm"></span> 까지 <span></span></p>
				<p class="time">24시간</p>
				<p class="price">차량요금:<span id="vCarSaleAmt"></span>원 <span style="display: none;">/ 자차보험료:<span id="vInsuSaleAmt">150,000</span>원</p></span>
			</div>
		</div>

	<!--
		<div class="option2-result">
			<p><strong>2015.09.15 09:00부터~ 2015.09.16 09:00 24시간</strong></p>
			<div class="form1 form1-4">
				<select>
					<option value="선택사항">선택사항</option>
				</select>
			</div>
			<p class="txt">*차량요금:56,000원 / 자차보험료:50,000원</p>
		</div>
	-->
		<p class="price">합계 : <strong id="vTotalAmt"></strong>원</p>
		<p class="btn-right"><a href="javascript:changeOptionCartRC(${cartInfo.cartSn})" class="btn btn1">변경완료</a></p>

	</div> <!--//option-box(렌터카)-->                              
