<!DOCTYPE html>
<html lang="ko" style="height: 0px">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
    <jsp:include page="/web/includeJs.do"></jsp:include>
    <meta property="og:title" content="제주여행 공공플랫폼 탐나오" />
    <meta property="og:description" content="실시간 항공, 숙박, 렌터카, 관광지, 맛집, 특산기념품 할인!" />
    <meta property="og:image" content="https://www.tamnao.com${prmtList[0].listImg}" />
    
	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
    
<%--    <script src="<c:url value='/js/multiple-select.js?version=${nowDate}'/>"></script>--%>
    <script src="<c:url value='/js/air_step1.js?version=${nowDate}'/>"></script>
<%--    <script src="<c:url value='/js/cycle.js?version=${nowDate}'/>"></script>--%>
<%--    <script src="<c:url value='/js/freewall.js?version=${nowDate}'/>"></script>--%>
<%--    <script src="/js/polyfill.js?version=${nowDate}" async defer></script>--%>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main.css?version=${nowDate}'/>" />
<%--    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />--%>
    <link rel="canonical" href="https://www.tamnao.com">
    <link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw">
	
    <script>
		let prevIndex = 0;
        let domain = "https://www.tamnao.com";
		if ( "<c:out value='${Constant.FLAG_INIT}'/>"  == "local"){
            domain = "http://localhost:8080/";
        }

        function fn_RcSearch(){
            $('#sFromDt').val($('.sRcFromDtView').val().replace(/-/g, ''));
            $('#sToDt').val($('.sRcToDtView').val().replace(/-/g, ''));
            $("#sCorpId").val($("select[name=vCorpId] option:selected").val());
            $("#sIsrDiv").val($("select[name=vIsrDiv] option:selected").val());
            document.rcSearchFrm.target ="_blank";
            document.rcSearchFrm.action = domain + "/web/rentcar/car-list.do";
            document.rcSearchFrm.submit();
            
        	++prevIndex;
        	history.replaceState($("#_wrap").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
        	currentState = history.state;            
        }

        function fn_AdSearch(type){
            $("#sSearchYn").val('Y');
            $("#pageIndex").val(1);
            $("#sResEnable").val($("input:radio[name=vResEnable]:checked").val());
            $("#sAdDiv").val($("select[name=sAdDivSel]:selected").val());
            $("#sPriceSe").val($("select[name=sPriceSeSel]:selected").val());
            $("#sPrdtNm").val($("#vPrdtNm").val());
            $('#sAdFromDt').val($('.sAdFromDtView').val().replace(/-/g, ''));
            $('#sAdToDt').val($('.sAdToDtView').val().replace(/-/g, ''));
            $('#sFromDtMap').val($('.sAdFromDtView').val());
            $('#sToDtMap').val($('.sAdToDtView').val());
            document.adSearchFrm.target = "_blank";
            if(type == "main"){
                $('#type').val("main");
                document.adSearchFrm.action = domain + "/web/stay/jeju.do";
            }else{
                $('#type').val("map");
                document.adSearchFrm.action = domain + "/web/stay/jeju.do?type=map";
            }
            document.adSearchFrm.submit();
            
        	++prevIndex;
        	history.replaceState($("#_wrap").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
        	currentState = history.state;
        }

        var adMaxDate = "+12m";
        var rcMaxDate = "+6m";

        // 객실수 및 인원 정보 수정
        function modify_room_person() {
            var str =  "성인 " + $('#AdultNum').text();
            if ($('#ChildNum').text() > 0) {
                str += ", 소아 " + $('#ChildNum').text();
            }
            if ($('#BabyNum').text() > 0) {
                str += ", 유아 " + $('#BabyNum').text();
            }
            $('#room_person_str').text(str);
        }

        // 인원수 변경 이벤트
        function ad_chg_person(type, gubun) {
            var num = 0;
            
            if (type == '+') {
                num = eval($('#' + gubun + 'Num').text()) + 1;
            } else {
                num = eval($('#' + gubun + 'Num').text()) - 1;
            }
            // 최저 인원 수 - 성인 : 1, 소아&유아 : 0
            if (gubun == 'Adult') {
                if (num < 1) {
                    num = 1;
                } else if (num > 9) {
                    num = 9;
                }
            } else {
                if (num < 0) {
                    num = 0;
                } else if (num > 8) {
                    num = 8;
                }
            }
            $('#' + gubun + 'Num').text(num);
            $('input[name=s' + gubun + 'Cnt]').val(num);

            var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
            $('#sMen').val(sMen);

            modify_room_person();
        }

        $(document).ready(function(){
        	var currentState = history.state;
        	if(currentState){
            	$("#_wrap").html(currentState);
            	let tabIndex = $("#product_search li.active a").attr("href");
        		let tabActive = 0;

        		if(tabIndex == "#tabs-1"){ //렌터카
        			tabActive = 0
        		}else if(tabIndex == "#tabs-2"){ //숙소
        			tabActive = 1
        		}else if(tabIndex == "#tabs-3"){ //항공
        			tabActive = 2
        		}
        		
              	tabPanel2({
            		container: "#product_search",
            		firstItem: tabIndex,
            		active : tabActive
            	});
              	
        	}else{
                //실시간 검색 탭패널
                tabPanel2({
                    container: "#product_search",
                    firstItem: "#tabs-1"
                }); 
        	}
        	
            $(".category-tab a").click(function(){
                $(".tx").removeClass();
                $(this).addClass("tx");
            })

            $("#_wrap .hasDatepicker ").removeClass(function(index){
                $(this).removeClass("hasDatepicker");
            })

            //datepicker
            $("#avSearchFrm").find("input[name=start_date]").datepicker({
                dateFormat: "yy-mm-dd",
                minDate: "${SVR_TODAY}",
                onSelect: function(dateText, inst) {
                    $("#avSearchFrm").find("input[name=end_date]").datepicker('option', 'minDate', $("#avSearchFrm").find("input[name=start_date]").val() );
                }
            });

            $("#avSearchFrm").find("input[name=end_date]").datepicker({
                dateFormat: "yy-mm-dd",
                minDate: "${SVR_TODAY}"
            });

            $(".sAdFromDtView").datepicker({
                showOn: "both",
                buttonImage: "/images/web/icon/calendar_icon01.gif",
                buttonImageOnly: true,
                showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
                numberOfMonths: [1, 2],									//여러개월 달력 표시
                stepMonths: 2, 												//좌우 선택시 이동할 개월 수
                dateFormat: "yy-mm-dd",
                minDate: "${SVR_TODAY}",
                maxDate: adMaxDate,
                onClose : function(selectedDate) {
                    var fromDt = new Date(selectedDate);

                    $("#sAdFromDt").val("" + fromDt.getFullYear() + (fromDt.getMonth() + 1) + fromDt.getDate());

                    fromDt.setDate(fromDt.getDate() + 1);
                    selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
                    $(".sAdToDtView").datepicker("option", "minDate", selectedDate);

                    var toDt = new Date($(".sAdToDtView").val());
                    fromDt.setDate(fromDt.getDate() - 1);

                    var nightNum = (toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24);
                    if(nightNum < 1) {
                        nightNum = 1;
                    }
                    $("#sNights").val(nightNum);
                }
            });

            $(".sAdToDtView").datepicker({
                showOn: "both",
                buttonImage: "/images/web/icon/calendar_icon01.gif",
                buttonImageOnly: true,
                showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
                numberOfMonths: [1, 2],									//여러개월 달력 표시
                stepMonths: 2, 												//좌우 선택시 이동할 개월 수
                dateFormat: "yy-mm-dd",
                minDate: "${SVR_TODAY}",
                maxDate: adMaxDate,
                onClose : function(selectedDate) {
                    var toDt = new Date(selectedDate);
                    var fromDt = new Date($(".sAdFromDtView").val());

                    $("#sToDt").val("" + toDt.getFullYear() + (toDt.getMonth() + 1) + toDt.getDate());
                    $("#sNights").val((toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24));
                }
            });

   			$(".sRcFromDtView").datepicker({
                   showOn: "both",
                   buttonImage: "/images/web/icon/calendar_icon01.gif",
                   buttonImageOnly: true,
                   showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
                   numberOfMonths: [1, 2],									//여러개월 달력 표시
                   stepMonths: 2, 												//좌우 선택시 이동할 개월 수
                   dateFormat: "yy-mm-dd",
                   minDate: "${SVR_TODAY}",
                   maxDate: rcMaxDate,
                   onClose : function(selectedDate) {
                       if(selectedDate >=  $(".sRcToDtView").val()){
                           $(".sRcToDtView").val(fn_NexDay(selectedDate)).datepicker("option", "minDate", selectedDate);
                       }
                   }
              });   

             $(".sRcToDtView").datepicker({
                 showOn: "both",
                 buttonImage: "/images/web/icon/calendar_icon01.gif",
                 buttonImageOnly: true,
                 showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
                 numberOfMonths: [1, 2],									//여러개월 달력 표시
                 stepMonths: 2, 												//좌우 선택시 이동할 개월 수
                 dateFormat: "yy-mm-dd",
                 minDate: "${SVR_TODAY}",
                 maxDate: rcMaxDate,
                 onClose : function(selectedDate) {
                     // $("#sFromDtView").datepicker("option", "maxDate", selectedDate);
                 }
             });   

            $('.sRcFromDtView').change(function() {
                $('#sRcFromDt').val($('.sRcFromDtView').val().replace(/-/g, ''));
            });
            $('.sRcToDtView').change(function() {
                $('#sRcToDt').val($('.sRcToDtView').val().replace(/-/g, ''));
            });

            tabPanel({container:"#tabs"});
            tabPanel({container:"#item_menu_1"});

            //실시간 검색 탭패널 > 상단 고정바
            tabPanel2({
                container: "#product_top_search",
                firstItem: "#tabs-33",
                allHide: 1
            });

            /** 항공 관련  */
            // 출발지 선택
            $(document).on("click", 'input[name=start_region]', function() {
                $("#start_region_str").text($("label[for=" + $(this).attr('id') + "]").text() + "(" + $(this).val() + ")");
                optionClose($("#air_departure"));
            });

            /** 도착지 선택 */
            $(document).on("click", 'input[name=end_region]', function() {
                $("#end_region_str").text($("label[for=" + $(this).attr('id') + "]").text() + "(" + $(this).val() + ")");
                optionClose($("#air_arrival"));
            });

            modify_seat_person();

            /** 숙박 관련 */
            // 지역 선택
            $(document).on("click", 'input[name=sAdAdarChk]', function() {
                $("#area_str").text($("label[for=" + $(this).attr('id') + "]").text());
                $("#sAdAdar").val($(this).val());
                optionClose($("#hotel_zone"));
            });

            /** 렌터카 관련 */
            $(document).on("click", 'input[name=sCarDivCdStr]', function() {
                $('#sCarDivCd').val($(this).val());
                $('#carDivStr').text($("label[for=" + $(this).attr('id') + "]").text());
                optionClose($("#rent_zone"));
            });

         	// 출발지 <> 도착지 체인지
          	$(' .change').on('click', function() {
        		let startReg = "";
                let endReg = "";
        		startReg = $("input[name=start_region]:checked").val();
                endReg = $("input[name=end_region]:checked").val();

        		$("input[name=start_region]").each(function(index) {
        			if(endReg == $("#air_test"+index).val()){
        				$("#air_test"+index).prop("checked", true);
        				$("input[name=start_region]:checked").click();
        				return;
        			}
        			if(startReg == $("#air_test"+index).val()){
        				$("#air_test"+index).prop("checked", false);
        				return;
        			}
        		});

        		$("input[name=end_region]").each(function(index) {
        			index = index + 13;
                  	if(startReg == $("#air_test"+index).val()){
                    	$("#air_test"+index).prop("checked", true);
                     	$("input[name=end_region]:checked").click();
                     	return;
                  	}
                 	if(endReg == $("#air_test"+index).val()){
                    	$("#air_test"+index).prop("checked", false);
                     	return;
                  	}
               	});
        	});
        });

        /* tab panel (detailTabMenu1) */
        function tabPanel(params) {
            var defaults = {
                container:"#tabs", //item wrap id
                firstItem:"#tabs-1" //first show item
            };

            for(var def in defaults) { //array object 확인
                if(typeof params[def] == 'undefined') {
                    params[def] = defaults[def];
                } else if(typeof params[def] == 'object') {
                    for(var deepDef in defaults[def]) {
                        if(typeof params[def][deepDef] == 'undefined') {
                            params[def][deepDef] = defaults[def][deepDef];
                        }
                    }
                }
            };

            var item = params.container + " ";
            $(item + ' .tabPanel').css('display', 'none');
            $(item).children(".tabPanel").eq(0).css('display', 'block');

            // alert($(item+'.menuList a').length);

            $(item + '.menuList a').each(function(index){
                $(item + '.menuList a').eq(index).click(function(){
                    var show = $(this).attr('href');

                    $(item + '.menuList a').removeClass('select');
                    $(this).addClass('select');

                    $(item + ' .tabPanel').css('display', 'none');
                    $(show).css('display', 'block');

                    return false;
                });
            });
        }

        // 여백 클릭 시 팝업 닫기
        $(document).mouseup(function(e){
            var divPop = $(".popup-typeA");
            if(divPop.has(e.target).length == 0){
                divPop.hide();
                return;
            }
        });
    </script>

</head>
<body style="height: 0px">

    <!-- quick-area -->
    <div class="quick-area" style="top:0px">
        <div class="product-search-area" style="width: 1200px;">
            <div id="product_search" class="nav-tabs1">
                <div class="new-quick-wrap">
                    <ul class="nav-menu">
                        <li class="rent"><a href="#tabs-1">렌터카</a></li>
                        <li class="hotel"><a href="#tabs-2">숙소</a></li>
                        <li class="air"><a href="#tabs-3">항공</a></li>
                    </ul>
                </div>
                <div id="tabs-1" class="tabPanel">
                <form name="rcSearchFrm" id="rcSearchFrm" method="get" onSubmit="return false;">
                    <input type="hidden" name="pageIndex" value="${rcSearchVO.pageIndex}" />
                    <input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${rcSearchVO.sCarDivCdView}" />
                    <input type="hidden" name="orderCd" value="${rcSearchVO.orderCd}" />
                    <input type="hidden" name="orderAsc" value="${rcSearchVO.orderAsc}" />
                    <input type="hidden" name="mYn" id="mYn" value="${rcSearchVO.mYn}" />
                    <input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_Y}" />
                    <input type="hidden" name="prdtNum" id="prdtNum" />
                    <input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${rcSearchVO.sIsrDiv}" />	<!-- 보험여부 -->
                    <input type="hidden" name="sCorpId" id="sCorpId" value="${rcSearchVO.sCorpId}" /> <!-- 렌터카회사 -->
                    <input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${rcSearchVO.sCarDivCd}" /> <!-- 차량 유형 검색 -->
                    <input type="hidden" name="sMakerDivCd" id="sMakerDivCd" value="${rcSearchVO.sMakerDivCd}" /> <!-- 제조사 검색 -->
                    <input type="hidden" name="sUseFuelDiv" id="sUseFuelDiv" value="${rcSearchVO.sUseFuelDiv}" /> <!-- 사용연료 검색 -->
                    <input type="hidden" name="sModelYear" id="sModelYear" value="${rcSearchVO.sModelYear}" /> <!-- 연식 검색 -->
                    <div class="pd-wrap">
                        <!-- 코드중복(include) -->
                        <div class="form-area">
                            <div class="search-area rent">
                                <div class="area date">
                                    <dl>
                                        <dt>대여일</dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-time-area">
                                                    <input type="hidden" name="sFromDt" id="sFromDt" value="${rcSearchVO.sFromDt}">
                                                    <div class="date-container">
                                                    <span class="date-wrap">
                                                        <input class="datepicker sRcFromDtView" type="text" name="sFromDtView" placeholder="대여일 선택" value="${rcSearchVO.sFromDtView}" onclick="optionClose('.popup-typeA')">
                                                    </span>
                                                    </div>
                                                    <div class="time-area">
                                                        <select name="sFromTm" id="sFromTm" title="시간선택">
                                                            <c:forEach begin="8" end="20" step="1" var="fromTime">
                                                                <c:if test='${fromTime < 10}'>
                                                                    <c:set var="fromTime_v" value="0${fromTime}00" />
                                                                    <c:set var="fromTime_t" value="0${fromTime}:00" />
                                                                </c:if>
                                                                <c:if test='${fromTime > 9}'>
                                                                    <c:set var="fromTime_v" value="${fromTime}00" />
                                                                    <c:set var="fromTime_t" value="${fromTime}:00" />
                                                                </c:if>
                                                                <option value="${fromTime_v}" <c:if test="${rcSearchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                    <span class="guide"></span>
                                    <dl>
                                        <dt>반납일</dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-time-area">
                                                    <input type="hidden" name="sToDt" id="sToDt" value="${rcSearchVO.sToDt}">
                                                    <div class="date-container">
                                                    <span class="date-wrap">
                                                        <input class="datepicker sRcToDtView" type="text" name="sToDtView" placeholder="반납일 선택" value="${rcSearchVO.sToDtView}" onclick="optionClose('.popup-typeA')">
                                                    </span>
                                                    </div>
                                                    <div class="time-area">
                                                        <select name="sToTm" id="sToTm" title="시간선택">
                                                            <c:forEach begin="8" end="20" step="1" var="toTime">
                                                                <c:if test='${toTime < 10}'>
                                                                    <c:set var="toTime_v" value="0${toTime}00" />
                                                                    <c:set var="toTime_t" value="0${toTime}:00" />
                                                                </c:if>
                                                                <c:if test='${toTime > 9}'>
                                                                    <c:set var="toTime_v" value="${toTime}00" />
                                                                    <c:set var="toTime_t" value="${toTime}:00" />
                                                                </c:if>
                                                                <option value="${toTime_v}" <c:if test="${rcSearchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area type select">
                                    <dl>
                                        <dt>렌터카 유형</dt>
                                        <dd>
                                            <div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#rent_zone', this)" id="carDivStr">전체</a></div>
                                            <div id="rent_zone" class="popup-typeA rent-zone">
                                                <ul class="select-menu col3">
                                                    <li><a href="javascript:void(0)"></a>
                                                        <div class="lb-box">
                                                            <input type="radio" id="sCarDivCd0" name="sCarDivCdStr" value="" checked>
                                                            <label for="sCarDivCd0">전체</label>
                                                        </div>
                                                    </li>
                                                    <c:forEach var="code" items="${carDivCd}" varStatus="status">
                                                        <li><a href="javascript:void(0)"></a>
                                                            <div class="lb-box">
                                                                <input type="radio" id="sCarDivCd${status.count}" name="sCarDivCdStr" value="${code.cdNum}">
                                                                <label for="sCarDivCd${status.count}">${code.cdNm}</label>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area name">
                                    <dl>
                                        <dt>차 이름</dt>
                                        <dd>
                                            <div class="value-text">
                                                <input type="text" name="sPrdtNm" id="sPrdtNm" class="full" placeholder="차명을 입력해 주세요" onclick="optionClose('.popup-typeA');">
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area search">
                                    <!-- form 사용시 submit 변경 -->
                                    <button type="button" class="btn red" onclick="fn_RcSearch()">검색</button>
                                </div>
                            </div> <!-- //search-area -->
                        </div> <!-- //form-area -->

                        <!-- //코드중복(include) -->
                    </div>
                </form>
            </div> <!-- //tabs-1 -->
                <div id="tabs-2" class="tabPanel">
                    <form name="adSearchFrm" id="adSearchFrm" method="get" onSubmit="return false;">
                        <input type="hidden" name="sSearchYn" id="sSearchYn" value="${Constant.FLAG_Y}" />
                        <input type="hidden" name="pageIndex" id="pageIndex" value="${adSearchVO.pageIndex}" />
                        <input type="hidden" name="sAdAdar" id="sAdAdar" value="${adSearchVO.sAdAdar}" />
                        <input type="hidden" name="sAdDiv" id="sAdDiv" value="${adSearchVO.sAdDiv}" />
                        <input type="hidden" name="sPriceSe" id="sPriceSe" value="${adSearchVO.sPriceSe}" />
                        <input type="hidden" name="prdtNum" />
                        <input type="hidden" name="sPrdtNum" id="sPrdtNum" />
                        <input type="hidden" name="sFromDt" id="sAdFromDt" value="${adSearchVO.sFromDt}">
                        <input type="hidden" name="sToDt" id="sAdToDt" value="${adSearchVO.sToDt}">
                        <input type="hidden" name="sFromDtMap" id="sFromDtMap" value="${adSearchVO.sFromDtMap}">
                        <input type="hidden" name="sToDtMap" id="sToDtMap" value="${adSearchVO.sToDtMap}">
                        <input type="hidden" name="sNights" id="sNights" value="1">
                        <input type="hidden" name="sMen" id="sMen" value="${adSearchVO.sMen}">
                        <input type="hidden" name="searchWord" id="searchWord" value="${adSearchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
                        <input type="hidden" name="type" id="type" value="main"/>

                        <div class="pd-wrap">
                            <!-- 코드중복(include) -->
                            <div class="form-area">
                                <div class="search-area hotel">
                                    <div class="area date">
                                        <dl>
                                            <dt>입실일</dt>
                                            <dd>
                                                <div class="value-text">
                                                    <div class="date-container">
                                                    <span class="date-wrap">
                                                        <input class="datepicker sAdFromDtView" type="text" name="sFromDtView" value="${adSearchVO.sFromDtView}" placeholder="입실일 선택" onclick="optionClose('.popup-typeA')">
                                                    </span>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                        <span class="line"><img src="../../images/web/r_main/line.png" alt="변경"></span>
                                        <dl>
                                            <dt>퇴실일</dt>
                                            <dd>
                                                <div class="value-text">
                                                    <div class="date-container">
                                                    <span class="date-wrap">
                                                        <input class="datepicker sAdToDtView" type="text" name="sToDtView" value="${adSearchVO.sToDtView}" placeholder="퇴실일 선택" onclick="optionClose('.popup-typeA')">
                                                    </span>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="area zone select">
                                        <dl>
                                            <dt>지역</dt>
                                            <dd>
                                                <div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#hotel_zone', this)" id="area_str">제주도 전체</a></div>
                                                <div id="hotel_zone" class="popup-typeA hotel-zone">
                                                    <ul class="select-menu col3">
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="adArea0" name="sAdAdarChk" value="" type="radio" checked>
                                                                <label for="adArea0">전체</label>
                                                            </div>
                                                        </li>
                                                        <c:forEach items="${cdAdar }" var="area" varStatus="status">
                                                            <li>
                                                                <div class="lb-box">
                                                                    <input id="adArea${status.count }" name="sAdAdarChk" type="radio" value="${area.cdNum }">
                                                                    <label for="adArea${status.count }">${area.cdNm }</label>
                                                                </div>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="area count select">
                                        <dl>
                                            <dt>인원선택<!--투숙객 , 객실 --></dt>
                                            <dd>
                                                <div class="value-text">
                                                    <a href="javascript:void(0)" onclick="optionPopup('#hotel_count', this)" id="room_person_str">성인 2</a>
                                                </div>
                                                <div id="hotel_count" class="popup-typeA hotel-count">
                                                    <div class="detail-area">
                                                        <input type="hidden" name="sRoomNum" id="sRoomNum" value="1">
                                                    </div>
                                                    <div class="detail-area counting-area">
                                                        <div class="counting">
                                                            <div class="l-area">
                                                                <strong class="sub-title">성인</strong>
                                                                <span class="memo">만 13세 이상</span>
                                                            </div>
                                                            <div class="r-area">
                                                                <input type="hidden" name="sAdultCnt" value="2" />
                                                                <button type="button" class="counting-btn" onclick="ad_chg_person('-', 'Adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                <span class="counting-text" id="AdultNum">2</span>
                                                                <button type="button" class="counting-btn" onclick="ad_chg_person('+', 'Adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                            </div>
                                                        </div>
                                                        <div class="counting">
                                                            <div class="l-area">
                                                                <strong class="sub-title">소아</strong>
                                                                <span class="memo">만 2 ~ 13세 미만</span>
                                                            </div>
                                                            <div class="r-area">
                                                                <input type="hidden" name="sChildCnt" value="0" />
                                                                <button type="button" class="counting-btn" onclick="ad_chg_person('-', 'Child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                <span class="counting-text" id="ChildNum">0</span>
                                                                <button type="button" class="counting-btn" onclick="ad_chg_person('+', 'Child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                            </div>
                                                        </div>
                                                        <div class="counting">
                                                            <div class="l-area">
                                                                <strong class="sub-title">유아</strong>
                                                                <span class="memo">만 2세(24개월) 미만</span>
                                                            </div>
                                                            <div class="r-area">
                                                                <input type="hidden" name="sBabyCnt" value="0" />
                                                                <button type="button" class="counting-btn" onclick="ad_chg_person('-', 'Baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                <span class="counting-text" id="BabyNum">0</span>
                                                                <button type="button" class="counting-btn" onclick="ad_chg_person('+', 'Baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="detail-area info-area">
                                                        <ul class="list-disc sm">
                                                            <li>업체별로 연령 기준은 다를 수 있습니다.</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="area search">
                                        <!-- form 사용시 submit 변경 -->
                                        <button type="button" class="btn red" onclick="fn_AdSearch('main')">검색</button>
                                        <a href='javascript:void(0)' onclick="fn_AdSearch('map')" class="btn dark-gray">지도 검색</a>
                                    </div>
                                </div> <!-- //search-area -->
                            </div> <!-- //form-area -->
                            <!-- //코드중복(include) -->
                        </div>
                    </form>
                </div> <!-- //tabs-2 -->
                <div id="tabs-3" class="tabPanel">
                    <div class="pd-wrap">
                        <!-- 코드중복(include) -->
                        <div class="form-area">
                            <form name="air_search_form" id="avSearchFrm" action="/web/av/productList.do" target="_blank" onsubmit="return check_air_seach_form();">
                                <input type="hidden" name="page_type" value="main" />
                                <div class="check-area">
                                    <div class="air_btn">
                                        <input id="air_typeRT" type="radio" name="trip_type" value="RT" checked="checked" onclick="airtype_click();">
                                        <label for="air_typeRT">왕복</label>
                                    </div>
                                    <div class="air_btn">
                                        <input id="air_typeOW" type="radio" name="trip_type" value="OW" onclick="airtype_click();">
                                        <label for="air_typeOW">편도</label>
                                    </div>
                                </div>

                                <div class="search-area air">
                                    <div class="area zone">
                                        <dl>
                                            <dt>출발지</dt>
                                            <dd>
                                                <div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#air_departure', this)" id="start_region_str">김포(GMP)</a></div>
                                                <div id="air_departure" class="popup-typeA air-zone">
                                                    <ul class="select-menu col4">
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test0" name="start_region" type="radio" value="GMP" checked="checked">
                                                                <label for="air_test0">김포</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test1" name="start_region" type="radio" value="CJU">
                                                                <label for="air_test1">제주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test2" name="start_region" type="radio" value="PUS">
                                                                <label for="air_test2">부산</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test3" name="start_region" type="radio" value="TAE">
                                                                <label for="air_test3">대구</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test4" name="start_region" type="radio" value="KWJ">
                                                                <label for="air_test4">광주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test5" name="start_region" type="radio" value="CJJ">
                                                                <label for="air_test5">청주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test6" name="start_region" type="radio" value="MWX">
                                                                <label for="air_test6">무안</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test7" name="start_region" type="radio" value="RSU">
                                                                <label for="air_test7">여수</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test8" name="start_region" type="radio" value="USN">
                                                                <label for="air_test8">울산</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test9" name="start_region" type="radio" value="HIN">
                                                                <label for="air_test9">진주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test10" name="start_region" type="radio" value="KUV">
                                                                <label for="air_test10">군산</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test11" name="start_region" type="radio" value="KPO">
                                                                <label for="air_test11">포항</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test12" name="start_region" type="radio" value="WJU">
                                                                <label for="air_test12">원주</label>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </dd>
                                        </dl>
                                        <a href="javascript:void(0)" class="change"><img src="<c:url value='/images/web/main/form/change.png' />" alt="변경"></a>
                                        <dl>
                                            <dt>도착지</dt>
                                            <dd>
                                                <div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#air_arrival', this)" id="end_region_str">제주(CJU)</a></div>
                                                <div id="air_arrival" class="popup-typeA air-zone">
                                                    <ul class="select-menu col4">
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test13" name="end_region" type="radio" value="GMP">
                                                                <label for="air_test13">김포</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test14" name="end_region" type="radio" value="CJU" checked="checked">
                                                                <label for="air_test14">제주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test15" name="end_region" type="radio" value="PUS">
                                                                <label for="air_test15">부산</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test16" name="end_region" type="radio" value="TAE">
                                                                <label for="air_test16">대구</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test17" name="end_region" type="radio" value="KWJ">
                                                                <label for="air_test17">광주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test18" name="end_region" type="radio" value="CJJ">
                                                                <label for="air_test18">청주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test19" name="end_region" type="radio" value="MWX">
                                                                <label for="air_test19">무안</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test20" name="end_region" type="radio" value="RSU">
                                                                <label for="air_test20">여수</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test21" name="end_region" type="radio" value="USN">
                                                                <label for="air_test21">울산</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test22" name="end_region" type="radio" value="HIN">
                                                                <label for="air_test22">진주</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test23" name="end_region" type="radio" value="KUV">
                                                                <label for="air_test23">군산</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test24" name="end_region" type="radio" value="KPO">
                                                                <label for="air_test24">포항</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="air_test25" name="end_region" type="radio" value="WJU">
                                                                <label for="air_test25">원주</label>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="area Date">
                                        <dl>
                                            <dt>가는날</dt>
                                            <dd>
                                                <div class="value-text">
                                                    <div class="date-container">
                                                    <span class="date-wrap">
                                                        <input class="datepicker" type="text" name="start_date" value="${SVR_TODAY}" placeholder="가는날 선택" onclick="optionClose('.popup-typeA')">
                                                    </span>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                        <span class="guide"></span>
                                        <dl>
                                            <dt>오는날</dt>
                                            <dd>
                                                <div class="value-text">
                                                    <div class="date-container">
                                                    <span class="date-wrap">
                                                        <input class="datepicker" type="text" name="end_date" value="${SVR_TODAY}" placeholder="오는날 선택" onclick="optionClose('.popup-typeA')">
                                                    </span>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="area count select">
                                        <dl>
                                            <dt>좌석 등급 및 인원 선택</dt>
                                            <dd>
                                                <div class="value-text">
                                                    <a href="javascript:void(0)" onclick="optionPopup('#air_count', this)" id="seat_person_str">전체 | 성인 1</a>
                                                </div>
                                                <div id="air_count" class="popup-typeA air-count">
                                                    <div class="detail-area">
                                                        <strong class="sub-title">좌석 등급</strong>
                                                        <select class="full" name="seat_type" id="seat_type" title="등급 선택" onchange="modify_seat_person();">
                                                            <option value="N@S@B" selected>전체</option>
                                                            <option value="N">일반석</option>
                                                            <option value="S">할인석</option>
                                                            <option value="B">비즈니스석</option>
                                                        </select>
                                                    </div>
                                                    <div class="detail-area counting-area">
                                                        <div class="counting">
                                                            <div class="l-area">
                                                                <strong class="sub-title">성인</strong>
                                                                <span class="memo">만 13세 이상</span>
                                                            </div>
                                                            <div class="r-area">
                                                                <input type="hidden" name="adult_cnt" value="1" />
                                                                <button type="button" class="counting-btn" onclick="chg_person('-', 'adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                <span class="counting-text" id="adult_num">1</span>
                                                                <button type="button" class="counting-btn" onclick="chg_person('+', 'adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                            </div>
                                                        </div>
                                                        <div class="counting">
                                                            <div class="l-area">
                                                                <strong class="sub-title">소아</strong>
                                                                <span class="memo">만 2 ~ 13세 미만</span>
                                                            </div>
                                                            <div class="r-area">
                                                                <input type="hidden" name="child_cnt" value="0" />
                                                                <button type="button" class="counting-btn" onclick="chg_person('-', 'child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                <span class="counting-text" id="child_num">0</span>
                                                                <button type="button" class="counting-btn" onclick="chg_person('+', 'child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                            </div>
                                                        </div>
                                                        <div class="counting">
                                                            <div class="l-area">
                                                                <strong class="sub-title">유아</strong>
                                                                <span class="memo">만 2세(24개월) 미만</span>
                                                            </div>
                                                            <div class="r-area">
                                                                <input type="hidden" name="baby_cnt" value="0" />
                                                                <button type="button" class="counting-btn" onclick="chg_person('-', 'baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                <span class="counting-text" id="baby_num">0</span>
                                                                <button type="button" class="counting-btn" onclick="chg_person('+', 'baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="detail-area info-area">
                                                        <ul class="list-disc sm">
                                                            <li>나이는 가는날/오는날 기준으로 적용됩니다.</li>
                                                            <li>유아 선택 시 성인은 꼭 포함되어야 합니다.</li>
                                                            <li>유아는 보호자 1인당 1명만 예약이 가능합니다.</li>
                                                            <li>항공사별로 기준 나이는 상이할 수 있습니다.</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="area search">
                                        <!-- form 사용시 submit 변경 -->
                                        <button type="submit" class="btn red">검색</button>
                                    </div>
                                </div>
                            </form>
                        </div> <!-- //form-area -->
                        <!-- //코드중복(include) -->
                    </div>
    			</div> <!-- //tabs-3 -->
            </div> <!-- //nav-tabs1 -->
        </div>
    </div>
    <!-- //quick-area -->



</body>
</html>