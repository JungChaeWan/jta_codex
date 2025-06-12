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

	<div class="rent-option option-box">
      <div class="info-head">
          <h4 class="title">
              <c:out value="${prdtInfo.corpNm}"/>  <c:out value="${prdtInfo.prdtNm}"></c:out>
              <a class="option-close" onclick="close_popup('.option-wrap');"><img src="<c:url value='/images/web/cart/close.gif'/>" alt="닫기"></a>
          </h4>                                
          <!--달력-->
          <div class="calendarWrap">
              	<!--대여선택-->                                    
	            <div class="calendar">
	                <div class="datepicker" id="sFromDtView"></div>
	                <div class="calTime">
	                    <span><strong>대여시간</strong></span>
	                    <input type="hidden" name="sFromDt" id="sFromDt" value="${cartInfo.fromDt}">
						<input type="hidden" name="sFromTm" id="sFromTm" value="${cartInfo.fromTm}">
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
								<option value="${fromTime_v}" <c:if test="${cartInfo.fromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
							</c:forEach>
						</select>
	                </div>
	            </div>
	            <!--반납선택-->
	            <div class="calendar">
	                <div class="datepicker" id="sToDtView"></div>
	                <div class="calTime">
	                    <span><strong>반납시간</strong></span>
	                    <input type="hidden" name="sToDt" id="sToDt" value="${cartInfo.toDt}">
						<input type="hidden" name="sToTm" id="sToTm" value="${cartInfo.toTm}">
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
	            </div>
          </div> <!--//calendarWrap-->
          <!--//달력-->
      </div> <!--//info-head-->
      <div class="info-text">
          <div class="list-cell list-cell3">
              <p class="info1"><span id="info_sDt"></span> <span id="info_sTm"></span> 부터 <span id="info_eDt"></span> <span id="info_eTm"></span> 까지</p>
              <p class="info1">대여시간 : <span class="comm-color1"></span></p>
              <div class="info2">
              	<%-- 선택사항--%>
                <select id="payOption" onchange="javascript:fn_OptChange(this);" style="display: none;">
                    <option value="0" <c:if test="${cartInfo.insureDiv=='0'}">selected="selected"</c:if>>선택안함</option>
                    <option value="50000" <c:if test="${cartInfo.insureDiv=='50000'}">selected="selected"</c:if>>차량손해면책제도(5만원)</option>
                    <option value="100000" <c:if test="${cartInfo.insureDiv=='100000'}">selected="selected"</c:if>>완전자차(10만원)</option>
                </select>
                
                차량보험 :
                <a class="layer-1"><img height="32" src="<c:url value='/images/web/button/detail.gif'/>" alt="상세보기"></a>
                <div class="layerP1 rent-detail">
                	<img class="bubble" src="<c:url value='/images/web/icon/bubble2.gif'/>" alt="말풍선" height="7" width="11">
                   	<h4 class="title">
                       차량손해면책제도 안내
                        <a><img class="layerP1-close" src="<c:url value='/images/web/icon/close2.gif'/>" alt="닫기"></a>
                   	</h4>
                   	<h5 class="sub-title"><img src="<c:url value='/images/web/travel/sb.gif'/>" alt="말풍선"> 공통 보험 안내</h5>
                   	<div class="memoMsg">
                   		<c:out value="${prdtInfo.isrCmGuide}" escapeXml="false"/>
                   	</div>
                   
                   	<h5 class="sub-title"><img src="<c:url value='/images/web/travel/sb.gif'/>" alt="말풍선"> 차량별 보험 안내</h5>
                   	<div class="memoMsg">
                   		<c:out value="${prdtInfo.isrAmtGuide}" escapeXml="false"/>
                   	</div>
                    <a><img class="layerP1-close" src="<c:url value='/images/web/icon/close2.gif'/>" alt="닫기"></a>
                </div>
            </div>
          </div>
          <input type="hidden" name="carSaleAmt" id="carSaleAmt" />
          <input type="hidden" name="nmlAmt" id="nmlAmt" />
          <input type="hidden" name="insuSaleAmt" id="insuSaleAmt" value="${cartInfo.addAmt}" />
          <input type="hidden" name="totalAmt" id="totalAmt" />
          
          <input type="hidden" name="rco_prdtNum" id="rco_prdtNum" value="${prdtInfo.prdtNum}"/>
          <input type="hidden" name="rco_prdtNm" id="rco_prdtNm" value="${prdtInfo.prdtNm}"/>
          <input type="hidden" name="rco_corpId" id="rco_corpId" value="${prdtInfo.corpId}"/>
          <input type="hidden" name="rco_corpNm" id="rco_corpNm" value="${prdtInfo.corpNm}"/>

          <div class="priceInfo">                                                            
          	<p class="text">
            
                ＊차량요금 : <span id="vCarSaleAmt" class="comm-color1"></span>원<br>
                <span style="display: none;">＊자차보험료 : <span id="vInsuSaleAmt" class="comm-color1"></span>원<br></span>
                (유류할증료 / 제세공과금 포함)
            </p>
	      </div>
	      <div class="price-wrap">                                                            
	      	<p class="info4"><span class="plus">총합계</span> <strong id="vTotalAmt"></strong><span>원</span></p>
	      </div>
	      <div id="divAble">
	      	<p class="comm-button2">
	           <a class="color0" href="javascript:fn_addRc();">선택완료</a>
	       	</p>
	      	<!-- 
	        <p class="bt"><input type="image" src="<c:url value='/images/web/cart/change.gif'/>" alt="변경완료" onclick="fn_addRc()"></p>
	         -->
	      </div>
	      <div id="divAbleNone" class="comm-offMs" style="display:none;">
	      	<p class="not-ms"><img src="<c:url value='/images/web/icon/warning.png'/>" alt="경고">  <span id="errorMsg">대여일의 범위가 올바르지 않습니다.</span></p>
	      </div>
      </div>



