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
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_ChangeYear(){
	var optHtml = "";
	var chkMonth = 13;
	if($("#sFromYear").val() == "${nowYear}"){
		chkMonth = parseInt("${nowMonth}");
	}
	for(var i=1;i<chkMonth;i++){
		optHtml += "<option value=\"" + i + "\">" + i + "월</option>";
	}
	$("#sFromMonth").html(optHtml);
	fn_Search();
}

function fn_Search(){
	document.frm.action = "<c:url value='/oss/anls04.do'/>";
	document.frm.submit();
}

$(document).ready(function() {

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=anls" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=anls&sub=anls06" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<!-- <div class="btn_rt01">
					<div class="btn_sty04">
						<a href="javascript:fn_ExcelDown();">엑셀다운로드</a>
					</div>
				</div> -->
				<div id="menu_depth3">
					<ul>
						<li class="on"><a class="menu_depth3" href="<c:url value='/oss/anls06.do'/>">매출통계</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/anls05.do'/>">고객통계</a></li>
						<li><a class="menu_depth3" href="<c:url value='/oss/anls03.do'/>">일별현황</a></li>
					</ul>
				</div>
				<form name="frm" method="post">
					<input type="hidden" id="sToDt" name="sToDt" />
                <div>
                    <select id="sFromYear" name="sFromYear" style="width:60px;" onchange="fn_Search();">
                    	<c:forEach begin="2016" end="${nowYear}" step="1" var="vYear">
                   			<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}</option>
                    	</c:forEach>
                    </select>
                    <select id="sFromMonth" name="sFromMonth" style="width:60px;" onchange="fn_Search();">
                    	<c:forEach begin="1" end="12" step="1" var="vMonth">
                    		<c:if test="${vMonth < 10}">
                    			<c:set var="fromMonth_v" value="0${vMonth}" />
                    		</c:if>
                    		<c:if test="${vMonth >= 10}">
                    			<c:set var="fromMonth_v" value="${vMonth}" />
                    		</c:if>
                   			<option value="${fromMonth_v}" <c:if test="${fromMonth_v == searchVO.sFromMonth}">selected="selected"</c:if>>${vMonth}월</option>
                    	</c:forEach>
                    </select>
                </div>
                </form>
                <div class="list margin-top5 margin-btm15">
				<table class="table01">
					<colgroup>
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th>상품구분</th>
							<th>총 매출</th>
							<th>판매건수</th>
							<th>구매고객수</th>
							<th>개인별 평균 매출</th>
							<th>개인 별 구매건수</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="align_ct">전체</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.totalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.totalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.userCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.avgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.avgCnt}"/></fmt:formatNumber></td>
						</tr>
						<tr>
							<td class="align_ct">숙소</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.adTotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.adTotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.adUserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.adAvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">렌터카</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.rcTotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.rcTotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.rcUserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.rcAvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">골프패키지</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c170TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c170TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c170UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c170AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">버스/택시관광</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c160TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c160TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c160UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c160AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">카텔</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c130TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c130TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c130UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c130AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">에어카텔</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c120TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c120TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c120UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c120AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">에어카</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c140TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c140TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c140UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c140AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">에어텔</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c150TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c150TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c150UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c150AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">테마여행</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c180TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c180TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c180UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c180AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">할인특가항공</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c110TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c110TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c110UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c110AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">관광지/레저</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c200TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c200TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c200UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c200AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
						<tr>
							<td class="align_ct">음식/뷰티</td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c300TotalAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c300TotalCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c300UserCnt}"/></fmt:formatNumber></td>
							<td class="align_ct"><fmt:formatNumber><c:out value="${rsvAnls.c300AvgAmt}"/></fmt:formatNumber></td>
							<td class="align_ct"></td>
						</tr>
					</tbody>
				</table>	
				</div>
				<h4 class="title03">취소 통계</h4>
				<a name="list"></a>
                <div class="list margin-top5 margin-btm15">
                	<table class="table01">
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<thead>
							<tr>
								<th>상품구분</th>
								<th>총 취소금액</th>
								<th>취소건수</th>
								<th>당월취소건수</th>
								<th>당월이전취소건수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="align_ct">전체</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.totalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.totalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.nmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.omCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">숙소</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.adTotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.adTotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.adNmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.adOmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">렌터카</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.rcTotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.rcTotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.rcNmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.rcOmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">골프패키지</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c170TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c170TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c170NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c170OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">버스/택시관광</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c160TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c160TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c160NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c160OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">카텔</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c130TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c130TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c130NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c130OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">에어카텔</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c120TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c120TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c120NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c120OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">에어카</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c140TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c140TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c140NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c140OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">에어텔</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c150TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c150TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c150NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c150OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">테마여행</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c180TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c180TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c180NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c180OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">할인특가항공</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c110TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c110TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c110NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c110OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">관광지/레저</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c200TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c200TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c200NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c200OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
							<tr>
								<td class="align_ct">음식/뷰티</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c300TotalCancelAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c300TotalCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c300NmCancelCnt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${cancelRsvAnls.c300OmCancelCnt}"/></fmt:formatNumber></td>
							</tr>
						</tbody>
					</table>
                </div>
                
                <%-- <div>
                    <select id="" name="" style="width:60px;">
                        <option value="">2015</option>
                    </select>
                    
                    <select id="" name="" style="width:60px;">
                        <option value="">1월</option>
                    </select>
                </div>
                <div class="list margin-top5">
				<table class="table01 list_tb">
					<colgroup>
						<col width="*" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
					</colgroup>
					<thead>
						<tr>
							<th>일</th>
							<th>총 예약건수</th>
							<th>총 판매금액</th>
							<th>취소건수</th>
                            <th>총 환불금액</th>
							<th>총 취소수수료</th>
							<th>실매출액<br />
								(취소수수료포함)
                            </th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td class="align_ct">1일</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
							</tr>
                            <tr>
								<td class="align_ct">2일</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
							</tr>
                            <tr>
								<td class="align_ct">3일</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
								<td class="align_ct">&nbsp;</td>
							</tr>
					</tbody>
				</table>	
				</div> --%>
			</div>
		</div>
	</div>
</div>
</body>
</html>