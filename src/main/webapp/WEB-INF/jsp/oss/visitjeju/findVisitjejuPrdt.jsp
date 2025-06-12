<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<title>비짓제주 상품연동</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" async></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" async></script>
<script type="text/javascript">

	function fn_visitjejuApiMng(index){
		
		$("#visitNm_"+index+"").autocomplete({
			minLength: 1,
			source: function(request, response) {
				var parameters = "title=" + $("#visitNm_"+index+"").val();
				var visitJEJU = [];
	
				$.ajax({
					type:"post", 
					dataType:"json",
					async:false,
					url:"<c:url value='/oss/getVisitJeju.ajax'/>",
					data:parameters,
					success:function(data){
						// 코드 배열
						var arrayItem = [];
						jQuery.each(data.visitJejuList, function(index, onerow) {
							if(onerow["contentsid"] != null && onerow["contentsid"] != '') {
								var subStr = onerow["title"] + " [" + onerow["address"] + "]"
								visitJEJU[index] = {label:subStr, value:onerow["contentsid"]};
							}
						});
					
						if(visitJEJU.length == 0) {
							visitJEJU[0] = {label:'데이터가 없습니다.', value:'0000'};
						}
						response(visitJEJU);
					}
				});
			},        
			focus: function() {
				return false;        
			},        
			select: function(event, ui) {
				if (ui.item.value != "0000") {
					this.value = ui.item.label.substring(0, ui.item.label.indexOf("[", 0)).trim();
					$("#visitMappingId_"+index+"").val(ui.item.value);
					$("#visitMappingNm_"+index+"").val(this.value);
				}
				return false;
			}      
		}).blur(function(){			
			var strVal = this.value;
			if(strVal.substr(strVal.length - 1, strVal.length) == ",") {
				strVal = strVal.substr(0, strVal.length - 1);
				this.value = strVal;
			} 
		});
	}
	
	function fn_insertVisitjeju(corpId, corpCd, prdtNum, contentsid, contentsnm){
		
		if(contentsid == ""){
			alert("연동상품을 검색해주세요.");
			return;
		}
		
		let parameters = {};
		parameters["corpId"] = corpId;
		parameters["apiCorpYn"] = "N";
		parameters["corpCd"] = corpCd;
		parameters["prdtNum"] = prdtNum;
		parameters["contentsid"] = contentsid;
		parameters["contentsnm"] = contentsnm;
		
		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/oss/insertVisitjeju.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.resultYn == "Y"){
					alert("정상적으로 적용되었습니다.");
					fn_Search('${searchVO.pageIndex}');
				} else if(data.resultYn == "D"){
					alert("기존에 등록건이 존재 합니다.");
					fn_Search('${searchVO.pageIndex}');
				} else {
					alert("비정상적인 작동");
					fn_Search('${searchVO.pageIndex}');
				}
			},
			error: function(request, status, error) {
				if(request.status == "500") {
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				} else {
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			}
		});
	}
	
	function fn_deleteVisitjeju(corpId, corpCd, prdtNum, contentsid, contentsnm){
		
		if(contentsid == ""){
			alert("연동되어 있지 않습니다.");
			return;
		}
		
		let parameters = {};
		parameters["corpId"] = corpId;
		parameters["apiCorpYn"] = "N";
		parameters["corpCd"] = corpCd;
		parameters["prdtNum"] = prdtNum;
		parameters["contentsid"] = contentsid;
		parameters["contentsnm"] = contentsnm;
		
		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/oss/deleteVisitjeju.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.resultYn == "Y"){
					alert("정상적으로 적용되었습니다.");
					fn_Search('${searchVO.pageIndex}');
				} else {
					alert("비정상적인 작동");
					fn_Search('${searchVO.pageIndex}');
				}
			},
			error: function(request, status, error) {
				if(request.status == "500") {
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				} else {
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			}
		});
	}
	
	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/oss/findVisitjejuPrdt.do'/>";
		document.frm.target = "findVisitjejuPrdt";
		window.name = "findVisitjejuPrdt";
		document.frm.submit();
	}
	
	function fn_Select(prdtId, corpNm, prdtNm, corpId) {
		window.opener.fn_selectProduct(prdtId, corpNm, prdtNm, corpId);
	}

</script>

</head>
<body>
<div id="popup_wrapper">
    <div id="popup_contents">
        <!--컨텐츠-->

        <form name="frm" method="post" onSubmit="return false;">
            <!--검색폼-->
            <div class="search_area">
                <div class="search_form" style="width:395px; padding-left:50px;">
                    <table border="1" summary="검색할 해당 조건을 선택 및 입력 후 검색한다.">
                        <caption>
                        검색조건
                        </caption>
                        <tbody>
                            <tr>
                                <td style="width:auto;">
                                    상품명
                                </td>
                                <td style="width:auto;"><input type="text" name="sPrdtNm" id="sPrdtNm" class="input_text20" value="${searchVO.sPrdtNm}" /></td>
                            </tr>
                        </tbody>
                    </table>
                    <span class="search_btn">
                        <input type="image" name="" src="<c:url value='/images/oss/btn/search_btn04.gif'/>" alt="검색" onclick="fn_Search(1);" />
                    </span>
                </div>
            </div>
            <!--//검색폼-->

        	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
        	<input name="sCorpId" type="hidden" value="<c:out value='${searchVO.sCorpId}'/>"/>
            <div style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <td valign="top"><h2 class="title02">검색결과</h2></td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top" width="43%" style="background-color:#f9f9f9; border:solid 1px #ccc; text-align:center;">
                                <div style="height:4521x; overflow:auto;">
                                    <table width="100%" border="1" class="table01 list_tb">
                                        <colgroup>
                                            <col width="80" />
                                            <col width="70" />
                                            <col width="150" />
                                            <col width="230" />
                                            <col width="170" />
                                        </colgroup>
                                        <tr>
                                            <th scope="col">상품번호</th>
                                            <th scope="col">상태</th>
                                            <th scope="col">업체명</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">컨텐츠ID</th>
                                        </tr>
                                        <!-- 데이터 없음 -->
                                        <c:if test="${fn:length(resultList) == 0}">
                                        <tr>
                                            <td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                        </tr>
                                        </c:if>
                                        <c:forEach var="corpInfo" items="${resultList}" varStatus="status">
	                                        <tr style="cursor:pointer;">
	                                            <td>${corpInfo.prdtNum}</td>
	                                            <td>${corpInfo.tradeStatusNm}</td>
	                                            <td>${corpInfo.corpNm}</td>
	                                            <td>${corpInfo.prdtNm}</td>
	                                            <td>
	                                                <input type="text" name="visitNm_${status.index}" id="visitNm_${status.index}" onkeydown="fn_visitjejuApiMng(${status.index});" value="${corpInfo.contentsnm}" class="ui-autocomplete-input" autocomplete="off"/>
													<input type="hidden" name="visitMappingId_${status.index}" id="visitMappingId_${status.index}" value="${corpInfo.contentsid}" />
													<input type="hidden" name="visitMappingNm_${status.index}" id="visitMappingNm_${status.index}" value="${corpInfo.contentsnm}" />
													<li class="btn_sty01">
                        								<a onclick="javascript:fn_insertVisitjeju('${corpInfo.corpId}', '${corpInfo.corpCd}', '${corpInfo.prdtNum}', $('#visitMappingId_${status.index}').val(), $('#visitMappingNm_${status.index}').val());">연동</a>
                    								</li>
                    								<li class="btn_sty01">
                        								<a onclick="javascript:fn_deleteVisitjeju('${corpInfo.corpId}', '${corpInfo.corpCd}', '${corpInfo.prdtNum}', $('#visitMappingId_${status.index}').val(), $('#visitMappingNm_${status.index}').val());">해제</a>
                    								</li>
	                                            </td>
	                                        </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="list_pageing">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
                </p>
                <ul class="btn_rt01">
                    <li class="btn_sty01">
                        <a href="#" onclick="javascript:window.close();">닫기</a>
                    </li>
                </ul>
                <div style="clear: both;"></div>
            </div>
        </form>
    </div>
</div>
</body>
</html>