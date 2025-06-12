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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.floatThead.min.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
$(document).ready(function(){
	var $table = $("#chartTable");
	$table.floatThead();	
});


function fn_Search(){
	document.frm.action = "<c:url value='/mas/rc/rsvChart.do'/>";
	document.frm.submit();
}

function fn_Rsv(dt, prdtNum){
	var parameters = "sUseDt=" + dt;
	parameters += "&sPrdtNum=" + prdtNum;
	
	$.ajax({
		type:"post", 
		url:"<c:url value='/mas/rc/rsvChartDtl.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#div_Rsv").html(data);
			show_popup($("#div_Rsv"));
		}
	});
}

function fn_DetailRsv(rcRsvNum){
	document.frm.action = "<c:url value='/mas/rc/detailRsv.do'/>?rcRsvNum=" + rcRsvNum;
	document.frm.submit();
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=rsv" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
				</div>
            	<h4 class="title03">예약현황</h4>
				<c:choose>
					<c:when test="${corpVO.corpLinkYn eq 'Y'}">
							<h2 class="align_ct">실시간 연계 사용 업체 입니다.</h2>
					</c:when>
					<c:otherwise>
						<form name="frm" method="post">
						<div class="title-wrap">
							<select id="sFromYear" name="sFromYear" style="width:60px;" onchange="fn_Search();">
								<c:forEach begin="${nowYear}" end="${nowYear + 1}" step="1" var="vYear">
									<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}</option>
								</c:forEach>
							</select>
							<select id="sFromMonth" name="sFromMonth" style="width:60px;" onchange="fn_Search();">
								<c:forEach begin="1" end="12" step="1" var="vMonth">
									<c:if test="${vMonth < 10}">
										<c:set var="vMonth_v" value="0${vMonth}" />
									</c:if>
									<c:if test="${vMonth >= 10}">
										<c:set var="vMonth_v" value="${vMonth}" />
									</c:if>
									<option value="${vMonth_v}" <c:if test="${vMonth_v eq searchVO.sFromMonth}">selected="selected"</c:if>>${vMonth}월</option>
								</c:forEach>
							</select>
							<select name="sTradeStatus" id="sTradeStatus" onchange="fn_Search();">
								<option value="">전체</option>
								<c:forEach items="${tsCd}" var="code" varStatus="status">
									<option value="${code.cdNum}" <c:if test="${code.cdNum eq searchVO.sTradeStatus}">selected="selected"</c:if>>${code.cdNm}</option>
								</c:forEach>
							</select>

							<!-- 색상정보 -->
							<div class="bg-info">
								<span><small class="blue"></small> 수량, 예약건 존재</span>
								<span><small class="green"></small> 수량 존재, 예약건 없음</span>
								<span><small class="yellow"></small> 예약건이 수량보다 많음</span>
								<span><small class="red"></small> 수량, 예약건 없음</span>
							</div>
						</div>
						</form>
						<div class="list margin-top5 margin-btm15">
						<table id="chartTable" class="table01 list_tb">
							<colgroup>
								<c:if test="${fn:length(chartListVO) > 0}">
									<col width="500px" />
									<c:forEach items="${chartListVO}" var="chart" varStatus="status">
										<c:if test="${status.index==0}">
											<c:set var="chkDt" value="${lastDay}" />
										</c:if>
									</c:forEach>
									<c:forEach items="${chartListVO}" var="chart" varStatus="status">
										<c:if test="${status.index < chkDt}">
											<col width="150px" />
										</c:if>
									</c:forEach>
								</c:if>
								<%-- <col width="15%" /> --%>
								<%-- <col width="15%" />
								<col width="*" />
								<col width="15%" />
								<col width="15%" />
								<col width="15%" />
								<col width="15%" /> --%>
							</colgroup>
							<thead>
								<c:if test="${fn:length(chartListVO) > 0}">
									<tr>
										<th class="br-r">상품명</th>
										<c:forEach items="${chartListVO}" var="chart" varStatus="status">
											<c:if test="${status.index < chkDt}">
												<th>${fn:substring(chart.dt, 6,8)}</th>
											</c:if>
										</c:forEach>
									</tr>
								</c:if>
							</thead>
							<tbody>
								<c:if test="${fn:length(chartListVO) == 0}">
								<tr>
									<td colspan="6" class="align_ct">
										상품이 존재하지 않습니다.
									</td>
								</tr>
								</c:if>
							  <c:if test="${corpVO.corpLinkYn eq 'N' }">
								<c:forEach items="${chartListVO}" var="chart" varStatus="status">
									<fmt:formatNumber value="${chart.totalCarNum}" type="number" var="totalCarNum" />
									<fmt:formatNumber value="${chart.useCnt}" type="number" var="useCnt" />
									<c:if test="${status.index % chkDt == 0}">
										<c:set var="chkDt2" value="${chkDt2 + chkDt}" />
										<tr>
										<td class="br-r">${chart.prdtNm}   /
										  <c:forEach var="code" items="${fuelCd}" varStatus="status">
												<c:if test="${chart.useFuelDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
											</c:forEach> /
										  <c:if test="${chart.isrDiv eq 'ID00' }">
										  자차자율
										  </c:if>
										  <c:if test="${chart.isrDiv eq 'ID10' }">
										  자차포함(
											<c:if test="${chart.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN }">
											일반자차
											</c:if>
											<c:if test="${chart.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX }">
											고급자차
											</c:if>
										  )
										  </c:if>
										  <c:if test="${chart.isrDiv eq 'ID20' }">
										  자차필수
										  </c:if>

										</td>
									</c:if>
										<td class="align_ct <c:if test='${(useCnt == 0) and (totalCarNum == 0)}'>red</c:if>
															<c:if test='${(useCnt == 0) and (totalCarNum > 0)}'>green</c:if>
															<c:if test='${(useCnt > 0)  and (totalCarNum - useCnt > 0)}'>blue</c:if>
															<c:if test='${(useCnt > 0)  and (totalCarNum - useCnt <= 0)}'>yellow</c:if>
										" >
											<c:if test="${useCnt > 0}"><a class="link" onclick="fn_Rsv('${chart.dt}', '${chart.prdtNum}')">${useCnt}</a> / ${totalCarNum}</c:if>
											<c:if test="${useCnt == 0}">${useCnt} / ${totalCarNum}</c:if>
										</td>
									<c:if test="${(status.index + 1) == chkDt2}">
									</tr>
									</c:if>
								</c:forEach>
							  </c:if>
								<%--
								<c:forEach items="${resultList}" var="result" varStatus="status">
									<tr style="cursor:pointer;" onclick="fn_DtlAdjList('${fn:substring(result.adjDt,0, 10)}')">
										<td class="align_ct"><strong>${fn:substring(result.adjDt,0, 10)}</strong></td>
										<td class="align_ct"><strong>${fn:substring(result.adjItdDt,0, 10)}</strong></td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${result.saleAmt}"/></fmt:formatNumber>원</td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${result.cmssAmt}"/></fmt:formatNumber>원</td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${result.saleCmss}"/></fmt:formatNumber>원</td>
										<td class="align_ct"><fmt:formatNumber><c:out value="${result.adjAmt}"/></fmt:formatNumber>원</td>
										<td class="align_ct">
											<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_READY}">정산대기</c:if>
											<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_COM}">정산완료(<c:out value="${result.adjCmplDt}"/>)</c:if>
										</td>
									</tr>
								</c:forEach> --%>
							</tbody>
						</table>
						</div>

					</c:otherwise>
				</c:choose>

			</div>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_Rsv" class="lay_popup lay_ct wide"  style="display:none;">
</div>

</body>
</html>