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
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 목록
 */
function fn_List(){
	document.calendar.action = "<c:url value='/mas/ad/realTimeList.do'/>";
	document.calendar.submit();
}

function fn_Calendar(sPrevNext){
		
	$("#sPrevNext").val(sPrevNext);
	
	document.calendar.action = "<c:url value='/mas/ad/cntList.do'/>";
	document.calendar.submit();
}

function fn_SetCalendar(){
	
	var objTot = document.calendar.totalRoomNum;
	var objUse = document.calendar.useRoomNum;
	var objDdl = document.calendar.ddlYn;
    var frmCnt = objTot.length;
    
    for (k = 0; k < frmCnt; k++) {
    	var bChkDdl = false;
        
        if( objTot[k].value != "" ){
        	if(isNaN(objTot[k].value) == true){
        		alert("총 객실 수 는 숫자만 입력이 가능합니다.("+(k+1)+"일)");
        		objTot[k].focus();
        		return;
        	}
        	if(objTot[k].value < 0){
        		alert("총 객실 수 양의 정수만 입력이 가능합니다.("+(k+1)+"일)");
        		objTot[k].focus();
        		return;
        	}
        	bChkDdl = true;
        }
        
        if(bChkDdl == true){
        	if(objDdl[k].value==""){
        		//alert("" + (k+1) + "일 마감/접수 여부를 선택 해 주세요.");
        		//objDdl[k].focus();
        		//return;
        		objDdl[k].value = 'N';
        	}	
        }
        
    }
	
	document.calendar.action = "<c:url value='/mas/ad/cntSetCal.do'/>";
	document.calendar.submit();
}


function fn_SimpleCal(){
	if($('#startDt').val() == ""){
		alert("적용 기간 시작 일자를 선택 하세요.");
		return;
	}
	if($('#endDt').val() == ""){
		alert("적용 기간 끝 일자를 선택 하세요.");
		return;
	}

	var nChkCnt = 0;
	var obj = document.calendar.wday;
    var frmCnt = obj.length;
    for (k = 0; k < frmCnt; k++) {
        if (obj[k].checked) {
        	nChkCnt++;
        }
    }
    if(nChkCnt==0){
    	alert("적용 요일을 선택 하세요.");
    	return;
    }
    
    
    var bInput = false;
	
	if(document.calendar.totalRoomNumSmp.value!=""){
		if(isNaN(document.calendar.totalRoomNumSmp.value) == true){
			alert("간편입력기에 총객실 수 를 숫자만 입력 하세요.");
			document.calendar.totalRoomNumSmp.focus();
			return;
		}
		if( document.calendar.totalRoomNumSmp.value < 0){
			alert("간편입력기에 총객실 수 를 숫자만 입력 하세요.");
			document.calendar.totalRoomNumSmp.focus();
			return;
		}
		bInput = true;
	}

	
	if(document.calendar.ddlYnSmp.value!=""){
		//alert("간편입력기에 접수/마감 를 선택 하세요.");
		//document.calendar.ddlYnSmp.focus();
		//return;
		
		bInput = true;
	}
	
	if(bInput == false){
		alert("적용 할 값을 입력 하세요.");
	}
	
	document.calendar.action = "<c:url value='/mas/ad/cntSetSimple.do' />";
	document.calendar.submit();
	
	
}

function fn_WdayAllSel(){
	
	var obj = document.calendar.wday;
    var frmCnt = obj.length;

    for (k = 0; k < frmCnt; k++) {
    	obj[k].checked= true;
    }

}

function fn_WdayInvSel(){
	
	var obj = document.calendar.wday;
    var frmCnt = obj.length;

    for (k = 0; k < frmCnt; k++) {
        if (obj[k].checked) {
        	obj[k].checked = false;
        }else{
        	obj[k].checked = true;
        }
    }

}


function fn_Cnt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.calendar.action = "<c:url value='/mas/ad/cntList.do'/>";
	document.calendar.submit();
}

$(document).ready(function(){
	
	if(${fn:length(prdtList)} == 0){
		alert("객실을 먼저 등록 하세요.");
		history.back();
	}


});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=realtime" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area" style="min-width:1300px;">
			<div id="contents"> 
	            <!--본문-->
	            
	            <form:form commandName="calendar" name="calendar" method="post" enctype="multipart/form-data">
	            
	            <!--상품요금 입력-->
	                <table width="100%" border="0">
	                     <tr>
	                    <%--    <td valign="top" width="290"><!--간편입력폼-->--%>
	                            <%-- 
	                            <h5 class="title03">${adPrdinf.prdtNm}</h5>
	                            <table class="quick_calendar" style="width:285px;">
	                                <col width="28%" />
	                                <col width="72%" />
	
	                                <tr>
	                                    <th>객실</th>
	                                    <td class="td_align_lt01">
	                                    	<select name="id2" onchange="fn_Cnt(this.value);" style="width:96%;">
	                                    		<c:forEach var="data" items="${prdtList}" varStatus="status">
		                                            <option value="${data.prdtNum}" <c:if test="${data.prdtNum==adPrdinf.prdtNum }">selected="selected"</c:if>>${data.prdtNm}</option>
		                                        </c:forEach>
	                                        </select>
	                                	</td>
	                                </tr>
	
	                            </table>
	                           	--%>
	                            <%-- <h5 class="title02">간편입력기-aa1</h5>--%>
	                            	<%-- 
		                            <table class="quick_calendar" style="width:285px;">
		                                <col width="28%" />
	                                	<col width="72%" />
		                                <!-- 
		                                <tr>
		                                    <th>가능기간</th>
		                                    <td class="td_align_lt01 a"><strong>2013-01-01 ~ 2016-12-31</strong></td>
		                                </tr>
		                                 -->
		                                <tr>
		                                    <th>적용기간</th>
		                                    <td class="td_align_lt01">
		                                    	<div style="display:inline-block;">
													<fmt:parseDate value='${calendarVO.startDt}' var='startDt'
														pattern="yyyymmdd" scope="page" />
													<input type="text" id="startDtView" name="startDtView"
														class="input_text3 center"
														value="<fmt:formatDate value="${startDt}" pattern="yyyy-mm-dd"/>"
														readonly="readonly" /> <input type="hidden" id="startDt"
														name="startDt" class="input_text3 center"
														value="${calendarVO.startDt}" />
												</div>
												<div style="display:inline-block;">
													~
													<fmt:parseDate value='${calendarVO.endDt}' var='endDt'
														pattern="yyyymmdd" scope="page" />
													<input type="text" id="endDtView" name="endDtView"
														class="input_text3 center"
														value="<fmt:formatDate value="${endDt}" pattern="yyyy-mm-dd"/>"
														readonly="readonly" /> <input type="hidden" id="endDt"
														name="endDt" class="input_text3 center"
														value="${calendarVO.endDt}" />
												</div>
		                                	</td>
		                                </tr>
		                                <tr>
		                                    <th>적용요일</th>
		                                    <td class="td_align_lt01">
		                                    	<table border="1" style="width:100%;">
		                                            <tr>
		                                                <td>
		                                                	<div class="btn_sty06"><span><a href="javascript:fn_WdayAllSel()">전체선택</a></span></div>
		                                                	<div class="btn_sty06"><span><a href="javascript:fn_WdayInvSel()">선택반전</a></span></div>
		                                            	</td>
		                                            </tr>
		                                            <tr>
		                                                <td style="line-height:1.9em;">
		                                                	<input type="checkbox" name="wday" class="required" id="wday_1" value="1" title="적용요일을 선택하세요." />
		                                                    <label for="wday_1" style="color:red">일요일</label>
		                                                    <br />
		                                                    <input type="checkbox" name="wday" id="wday_2" value="2" />
		                                                    <label for="wday_2">월요일</label>
		                                                    <br />
		                                                    <input type="checkbox" name="wday" id="wday_3" value="3" />
		                                                    <label for="wday_3">화요일</label>
		                                                    <br />
		                                                    <input type="checkbox" name="wday" id="wday_4" value="4" />
		                                                    <label for="wday_4">수요일</label>
		                                                    <br />
		                                                    <input type="checkbox" name="wday" id="wday_5" value="5" />
		                                                    <label for="wday_4">목요일</label>
		                                                    <br />
		                                                    <input type="checkbox" name="wday" id="wday_6" value="6" />
		                                                    <label for="wday_6">금요일</label>
		                                                    <br />
		                                                    <input type="checkbox" name="wday" id="wday_7" value="7" />
		                                                    <label for="wday_7" style="color:blue">토요일</label>
		                                           		</td>
		                                            </tr>
		                                        </table>
		                                	</td>
		                                </tr>
		                                <tr>
		                                    <th>총객실 수</th>
		                                    <td class="td_align_lt01">
		                                    	<input type="text" name="totalRoomNumSmp" class="full right" title="간편입력 판매가을 입력하세요." value="${calendarVO.totalRoomNumSmp}"/>
		                                    </td>
		                                </tr>
		                                <input type="hidden" name="useRoomNumSmp" class="full right" title="간편입력 정가을 입력하세요." value="${calendarVO.useRoomNumSmp}"/>
		                                <!-- 
		                                <tr>
		                                    <th>사용 객실 수</th>
		                                    <td class="td_align_lt01">
		                                    	<input type="text" name="useRoomNumSmp" class="full right" title="간편입력 정가을 입력하세요." value="${calendarVO.useRoomNumSmp}"/>
		                                    </td>
		                                </tr>
		                                 -->
		                                <tr>
		                                    <th>접수/마감</th>
		                                    <td class="td_align_lt01">
		                                    
		                                    	<select name="ddlYnSmp" id="ddlYnSmp">
		                                    		<option value="" selected="selected"></option>
		                                            <option value="N">접수</option>
		                                            <option value="Y">마감</option>
		                                        </select>
		                                    </td>
		                                </tr>
		                            </table>
		                            --%>
	                           <!--  </form:form> -->
	                            <%--
	                            <div class="btn_ct02">
	                               <li class="btn_sty04">
										<a href="javascript:fn_SimpleCal()">간편 입력 적용</a>
									</li>
	                            </div>
	                             --%>
	                            
	                         <%--  </td>--%>
	                            
	                        <!--//간편입력폼-->
	                        
	                        
	                        <td valign="top"><!--달력입력폼-->
	                        	
	                       <!--	<form:form commandName="calendar" name="calendar" method="post" enctype="multipart/form-data"> -->
	                       	
	                       		<input type="hidden" id="prdtNum" name="prdtNum" value='<c:out value="${adPrdinf.prdtNum}" />' />                       		
	                       		<input type="hidden" id="iYear" name="iYear" value='<c:out value="${calendarVO.iYear}" />' />
	                       		<input type="hidden" id="iMonth" name="iMonth" value='<c:out value="${calendarVO.iMonth}" />' />
	                       		<input type="hidden" id="iMonthLastDay" name="iMonthLastDay" value='<c:out value="${calendarVO.iMonthLastDay}" />' />
	                       		<input type="hidden" id="sPrevNext" name="sPrevNext" value='' />
	                       	
	                        
	                            <!-- <h5 class="title04">고스트하우스 - [17평 A타입/3층]</h5> -->
	                            <table border="0" class="calendar_form">
	                                <col width="25%" />
	                                <col width="25%" />
	                                <col width="25%" />
	                                <col width="25%" />
	                                <tr class="title">
	                                	<td align="left" style="border:0; padding-left:25px;">
	                                		
	                                		<select name="id2" onchange="fn_Cnt(this.value);" style="width:96%;">
	                                    		<c:forEach var="data" items="${prdtList}" varStatus="status">
		                                            <option value="${data.prdtNum}" <c:if test="${data.prdtNum==adPrdinf.prdtNum }">selected="selected"</c:if>>${data.prdtNm}</option>
		                                        </c:forEach>
	                              			</select>
	                                			<!-- 
	                                			<div class="btn_sty01">
	                                			<span>
	                                            <input type="button" value="수정값 변경 적용" onclick="fn_SetCalendar(); return false;" />
	                                            </span></div>
	                                             -->
	                                    </td>
	                                
	                                    <th onclick="fn_Calendar('prev'); return false;" style="cursor:pointer;">◀</th>
	                                    <th id="current_month">${calendarVO.iYear}-${calendarVO.iMonth}</th>
	                                    <th onclick="fn_Calendar('next'); return false;" style="cursor:pointer;">▶</th>
	                                    <!-- 
	                                    <td align="right" style="border:0; padding-left:25px;"><div class="btn_sty01"><span>
	                                            <input type="button" value="수정값 변경 적용" onclick="fn_SetCalendar(); return false;" />
	                                            </span></div></td>
	                                     -->
	                                </tr>
	                            </table>
	                            <div id="lay_calendar">
	                            <table width="100%" border="0" class="calendar">
	                                <col width="*" />
	                                <col width="14.2%" />
	                                <col width="14.2%" />
	                                <col width="14.2%" />
	                                <col width="14.2%" />
	                                <col width="14.2%" />
	                                <col width="14.2%" />
	                                <tr>
	                                    <th scope="col" class="font_red">일</th>
	                                    <th scope="col">월</th>
	                                    <th scope="col">화</th>
	                                    <th scope="col">수</th>
	                                    <th scope="col">목</th>
	                                    <th scope="col">금</th>
	                                    <th scope="col" class="font_blue">토</th>
	                                </tr>
	                                <tr>
	                                    <c:forEach var="i" begin="1" end="${calendarVO.iWeek-1}">
	                                    	<td><p><strong>&nbsp;</strong></p></td>
	                                    </c:forEach>
	                                    
	                                    <c:set var="ddlColor" value="#FAECC5"/>
	                                    
	                                    <c:forEach var="data" items="${calList}" varStatus="status">
	                                    	<fmt:parseNumber var="totalRoomNum" type="number" value="${data.totalRoomNum}" />
	                                    	<fmt:parseNumber var="useRoomNum" type="number" value="${data.useRoomNum}" />
	                                    	<td <c:if test="${data.ddlYn == 'Y' || totalRoomNum <= useRoomNum}">style="background-color: ${ddlColor}"</c:if> >
	                                    		<c:if test="${data.sHolidayYN == 'Y'}">
	                                    			<p class="font_red"><strong>${data.iDay}</strong><span class="day_sp">${data.sHolidayNm}</span></p>
	                                    		</c:if>
	                                    		<c:if test="${data.sHolidayYN == 'N'}">
								                   	<c:if test="${data.iWeek == 1}">
								                   		<p class="font_red"><strong>${data.iDay}</strong></p>
								                   	</c:if>	
								                   	<c:if test="${data.iWeek == 7}">
								                   		<p class="font_blue"><strong>${data.iDay}</strong></p>
								                   	</c:if>	
								                   	<c:if test="${!(data.iWeek == 1 || data.iWeek == 7)}">
								                    	<p><strong>${data.iDay}</strong></p>
								                   	</c:if>
								                </c:if>
		                                    	<div>
		                                        	<p class="calendar_price"><span>총</span> <input type="text" id="totalRoomNum" name="totalRoomNum" class="right" title="" value="${data.totalRoomNum}" <c:if test="${data.ddlYn == 'Y' || totalRoomNum <= useRoomNum}">style="background-color: ${ddlColor}"</c:if> readonly/></p>
		                                        	<p class="calendar_ipgum"><span>사</span> <input type="text" id="useRoomNum" name="useRoomNum" class="right" title="" value="${data.useRoomNum}" readonly style="background-color: #DCDCDC" /></p>
		                                            <p class="calendar_gubun">
		                                            	<select name="ddlYn" id="ddlYn" style="width:100%;<c:if test="${data.ddlYn == 'Y' || totalRoomNum <= useRoomNum}">background-color: ${ddlColor}</c:if>">
		                                            		<c:if test="${data.ddlYn == null}">
		                                            			<option value="" <c:if test="${data.ddlYn == null}">selected="selected"</c:if> ></option>
		                                            		</c:if>
				                                            <option value="N" <c:if test="${data.ddlYn == 'N'}">selected="selected"</c:if> >접수</option>
				                                            <option value="Y" <c:if test="${data.ddlYn == 'Y'}">selected="selected"</c:if> >마감</option>
				                                        </select>
				                                    </p>
		                                            
		                                        </div>
		                                    </td>
		                                    
		                                    <c:if test="${data.iWeek == 7 && data.iDay!=calendarVO.iMonthLastDay}">
		                                    	</tr>
		                                    	<tr>
		                                    </c:if>
		                                    
		                                    <c:set var="lastWeek" value="${data.iWeek}"/>
		                                    
		                                </c:forEach>
	                                    <c:forEach var="i" begin="${lastWeek+1}" end="7">
	                                    	<td><p><strong>&nbsp;</strong></p></td>
	                                    </c:forEach>
	                                   
	                                </tr>
	                                 
	                            </table>
	                            
	                            
	                            
	                            <!--<div style="width:100%;height:500px;text-align:center;font-size:16px;padding-top:100px;"> 로딩중입니다. 잠시만 기다려주세요... </div>-->
	                            </div> 
	                            
	                            <!--//달력입력폼--></td>
	                    </tr>
	                </table>
	                <!--//상품요금 입력-->
	                
	            <!--//본문--> 
	            </form:form>
	            
	        </div>
	        <%--
	        <ul class="btn_rt01">
	
				<li class="btn_sty01">
					<a href="javascript:fn_List()">목록</a>
				</li>
			</ul>
			 --%>
		</div>	 
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>