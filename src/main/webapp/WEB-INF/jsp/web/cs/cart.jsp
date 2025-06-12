<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant"/>
<head>
<meta name="robots" content="noindex, nofollow">

    <jsp:include page="/web/includeJs.do"/>

    <script type="text/javascript" src="<c:url value='/js/adDtlCalendar.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/glDtlCalendar.js'/>"></script>

    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/rc.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/cart_n.css'/>"/>

    <script type="text/javascript">

        function layerP1() {
            $('.layer-1').click(function () {
                $(this).next('.layerP1').css('display', 'block');
            });
            $('.layerP1-close').click(function () {
                $('.layerP1').css('display', 'none');
            });
        };

        /***************************************************
         * 렌터카 script
         ****************************************************/
        function fn_OnchangeTime() {
            $("#sFromTm").val($("#vFromTm :selected").val());
            $("#sToTm").val($("#vToTm :selected").val());

            fn_CalRent();
        }

        /**
         * 대여기간 텍스트 변경
         */
        function fn_ChangeRange() {
            $("#info_sDt").html($("#sFromDtView").val());
            $("#info_sTm").html($("#vFromTm :selected").text().substring(0, 2) + "시");
            $("#info_eDt").html($("#sToDtView").val());
            $("#info_eTm").html($("#vToTm :selected").text().substring(0, 2) + "시");
        }

        /**
         * 총합계 노출...
         */
        function fn_TotalCmt() {
            $("#totalAmt").val(parseInt($("#insuSaleAmt").val()) + parseInt($("#carSaleAmt").val()));
            $("#vTotalAmt").html(commaNum($("#totalAmt").val()));
        }

        /**
         * 선택사항 변경 시
         */
        function fn_OptChange(obj) {
            $("#insuSaleAmt").val($(obj).val());
            $("#vInsuSaleAmt").html(commaNum($(obj).val()));
            fn_TotalCmt();
        }

        function fn_CalRent() {
            if (!checkByFromTo($('#sFromDtView').val(), $("#sToDtView").val(), "Y")) {
                $("#errorMsg").html("대여일의 범위가 올바르지 않습니다.");
                $("#divAbleNone").show();
                $("#divAble").hide();
                $("#totalAmt").val('0');
                $("#vTotalAmt").html('0');
                return;
            }
            var parameters = "sPrdtNum=" + $("#prdtNum").val();
            parameters += "&sFromDt=" + $("#sFromDt").val();
            parameters += "&sFromTm=" + $("#sFromTm").val();
            parameters += "&sToDt=" + $("#sToDt").val();
            parameters += "&sToTm=" + $("#sToTm").val();

            $.ajax({
                type    : "post",
                dataType: "json",
                // async:false,
                url    : "<c:url value='/web/rentcar/calRent.ajax'/>",
                data   : parameters,
                success: function (data) {
                    fn_ChangeRange();
                    // alert(data.prdtInfo.ableYn);
                    $(".info1 .comm-color1").html(data.prdtInfo.rsvTm + "시간");
                    $("#carSaleAmt").val(data.prdtInfo.saleAmt);
                    $("#vCarSaleAmt").html(commaNum(data.prdtInfo.saleAmt));
                    $("#insuSaleAmt").val($("#payOption :selected").val());
                    $("#vInsuSaleAmt").html(commaNum($("#insuSaleAmt").val()));
                    $("#nmlAmt").val(data.prdtInfo.nmlAmt);

                    fn_TotalCmt();

                    if (data.prdtInfo.ableYn == "Y") {
                        $("#divAbleNone").hide();
                        $("#divAble").show();
                    } else {
                        $("#errorMsg").html("예약마감");
                        $("#divAbleNone").show();
                        $("#divAble").hide();
                    }
                },
                error  : fn_AjaxError
            });
        }

        function changeOptionCartRC(cartSn) {
            var cart = {
                prdtNum  : $("#prdtNum").val(),
                fromDt   : $("#sFromDt").val(),
                toDt     : $("#sToDt").val(),
                fromTm   : $("#sFromTm").val(),	// 대여시간
                toTm     : $("#sToTm").val(),	// 반납시간
                insureDiv: $("#payOption :selected").val(),
                addAmt   : $("#insuSaleAmt").val(),
                cartSn   : cartSn
            };

            $.ajax({
                type       : "post",
                dataType   : "json",
                contentType: "application/json",
                url        : "<c:url value='/web/changeCart.ajax'/>",
                data       : JSON.stringify(cart),
                success    : function (data) {
                    alert("옵션이 변경됐습니다.");
                    $('.option-wrap').html('');
                    close_popup($('.option-wrap'));
                    location.reload();
                },
                error      : fn_AjaxError
            });
        }

        /***************************************************
         * 렌터카 script_End
         ****************************************************/

        /***************************************************
         * 쇼셜 script
         ****************************************************/
        function getCalOption() {
            var calP = $("#spCalendarForm").serialize();

            $.ajax({
                url    : "<c:url value='/web/sp/getCalOptionList.ajax'/>",
                data   : calP,
                success: function (data) {
                    $('.comm-select .select-list-option').css('display', 'none');
                    $('.opCal .calendar').html(data);
                    $('.packCalendar').css('display', 'block');
                    $("#iYear").val($(".calY1").text().replace(".", ""));
                    $("#iMonth").val($(".calM1").text());
                },
                error  : fn_AjaxError
            });
        }

        /**
         * 달력 옵션 선택시
         */
        function selectCalOption(selectDay, obj) {
            $(".opCal-title span").text("(" + getDayFormat(selectDay, "-") + ")");
            $(".packCalendar table>tbody>tr>td>a").removeClass("select");
            $(obj).addClass("select");
            $(".packCalendar").css('display', 'none');

            getSecondOption(selectDay);
        }

        function getSecondOption(aplDt) {
            $("#secondOptionList").empty();

            var parameters = "prdtNum=" + $("#prdtNum").val() + "&spDivSn=" + $("#spDivSn").val() + "&aplDt=" + aplDt;

            $.ajax({
                url    : "<c:url value='/web/sp/getOptionList.ajax'/>",
                data   : parameters,
                success: function (data) {
                    var list = data.list;
                    var dataArr;
                    var inx = 0, count = 1;

                    if (list != "") {
                        $(list).each(function () {
                            if (this.stockNum > 0 && this.ddlYn == 'N') {
                                dataArr = '<li>';
                                dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.optNm + '">';
                                dataArr += '<p class="product">';
                                dataArr += '<span>[선택' + count + ']</span>';
                                dataArr += '<span>' + fn_addDate(this.aplDt) + " " + this.optNm + '</span>';
                                dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
                                dataArr += '</p>';
                                dataArr += '<p class="price">' + commaNum(this.saleAmt) + '</p>';
                                dataArr += '</a>';
                                dataArr += '</li>';
                            } else {
                                dataArr = '<li>';
                                dataArr += '<p class="product">';
                                dataArr += '<span>[선택' + count + ']</span>';
                                dataArr += '<span>' + fn_addDate(this.aplDt) + " " + this.optNm + '</span>';
                                // dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
                                dataArr += '</p>';
                                dataArr += '<p class="price">품절</p>';
                                dataArr += '</li>';
                            }
                            count++;
                            $("#secondOptionList").append(dataArr);
                            $("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
                            inx++;
                        });

                        $('.comm-select .select-list-option').css('display', 'none');
                        $("#secondOptionList").css('display', 'block');
                        $('.opCal').removeClass('open');
                        $('.comm-select2').addClass('open');
                    }
                },
                error  : fn_AjaxError
            });
        }

        function loadSecondOption() {
            $("#secondOptionList").empty();

            var parameters = "prdtNum=" + $("#prdtNum").val() + "&spDivSn=" + $("#spDivSn").val() + "&aplDt=" + $("#aplDt").val();

            $.ajax({
                url    : "<c:url value='/web/sp/getOptionList.ajax'/>",
                data   : parameters,
                success: function (data) {
                    var list = data.list;
                    var text;
                    var count = 1;

                    if (list != "") {
                        $(list).each(function () {
                            if (this.spOptSn == $("#spOptSn").val()) {
                                text = '<span>[선택' + count + ']</span>';
                                text += '<span>' + fn_addDate(this.aplDt) + ' ' + this.optNm + '</span>';

                                if (this.stockNum > 0 && this.ddlYn == 'N') {
                                    text += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
                                }
                                $(".comm-select2 .select-button").html(text);
                                $(".comm-select2 .select-button").attr("data-raw", JSON.stringify(this));
                                $("#addOptionList").attr("data-raw", JSON.stringify(this));
                                if ($('.opCal').css('display') != "block") {
                                    $(".comm-select2").addClass("open");
                                }
                                return false;
                            }
                            count++;
                        });
                    }
                },
                error  : fn_AjaxError
            });
        }

        function addition() {
            var dataRaw = jQuery.parseJSON($(".comm-select2 .select-button").attr("data-raw"));
            var stockNum = parseInt(dataRaw.stockNum);
            var num = parseInt($("#qty").val()) + 1;

            if (num <= stockNum) {
                $("#qty").val(num);

                selectedItemSaleAmt();
            }
        }

        function substract() {
            var num = parseInt($("#qty").val()) - 1;

            if (num >= 1) {
                $("#qty").val(num);

                selectedItemSaleAmt();
            }
        }

        // 금액 변경
        function selectedItemSaleAmt() {
            var dataRaw = "";

            if ($("#addOptListLength").val() == 0) {
                dataRaw = jQuery.parseJSON($(".comm-select2 .select-button").attr("data-raw"));
            } else {
                dataRaw = jQuery.parseJSON($(".comm-select3 .select-button").attr("data-raw"));
            }
            var price = parseInt(dataRaw.saleAmt) * Number($("#qty").val());

            $("#vTotalAmt").html(commaNum(price));
        }

        // 카트 정보에 옵션 중복 체크.
        function checkDupOption(newData) {
            var result = false;
            $("input[name='spCart']").each(function () {
                var cartSn = $(this).val();

                if ($("input[name='" + cartSn + "_prdtNum']").val() == $("#prdtNum").val()) {
                    // 내꺼는 다시 선택해도 괜찮다.
                    if ($("#spDivSn").val() == newData.spDivSn && $("#spOptSn").val() == newData.spOptSn) {
                        result = false;
                        return false;
                    } else if ($("input[name='" + cartSn + "_optSn']").val() == newData.spOptSn && $("input[name='" + cartSn + "_divSn']").val() == newData.spDivSn) {
                        result = true;
                        return false;
                    }
                }
            });
            return result;
        }

        /** 추가옵션선택시 */
        function getAddOption() {
            if ($("#addOptionList").css('display') == 'block') {
                $('.comm-select .select-list-option').css('display', 'none');
                return;
            }

            if ($("#addOptionList li").length > 0) {
                if ($("#addOptionList").css('display') == 'none') {
                    $('.comm-select .select-list-option').css('display', 'none');
                    $('.packCalendar').css('display', 'none');
                    $("#addOptionList").css('display', 'block')
                }
                $('.comm-select').removeClass('open');
                $('.opCal').removeClass('open');
                $('.comm-select3').addClass('open');
                return false;
            }
            var b_data = {
                addOptNm : '',
                addOptAmt: 0,
                addOptSn : ''
            };

            $.ajax({
                url    : "<c:url value='/web/sp/getAddOptList.ajax'/>",
                data   : "prdtNum=" + $("#prdtNum").val(),
                success: function (data) {
                    var dataArr = '<li><a href="javascript:void(0)" data-raw="" title=""><p class="product"><span>선택안함</span></p></a></li>';

                    $("#addOptionList").append(dataArr);

                    var list = data.list;
                    var inx = 1;

                    if (list != "") {
                        $(list).each(function () {
                            dataArr = '<li>';
                            dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.addOptNm + '">';
                            dataArr += '<p class="product"><span>' + this.addOptNm + '</span></p>';
                            dataArr += '<p class="price">' + commaNum(this.addOptAmt) + '</p>';
                            dataArr += '</a>';
                            dataArr += '</li>';

                            $("#addOptionList").append(dataArr);
                            $("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
                            inx++;
                        });
                        $("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data));
                    }
                },
                error  : fn_AjaxError
            });
            $('.comm-select').removeClass('open');
            $('.opCal').removeClass('open');
            $('.comm-select3').addClass('open');
            $('.comm-select .select-list-option').css('display', 'none');
            $("#addOptionList").css('display', 'block');
        }

        //변경 완료 버튼 클릭 시 카트 다시 담기.
        function changeOptionCart(cartSn) {
            // validation에 따라 바뀔수 있음.
            var cart = {
                prdtNum  : $("#prdtNum").val(),
                qty      : $("#qty").val(),
                spOptSn  : $("#spOptSn").val(),
                spDivSn  : $("#spDivSn").val(),
                cartSn   : cartSn,
                addOptAmt: $("#addOptAmt").val(),
                addOptNm : $("#addOptNm").val()
            };

            $.ajax({
                type       : "post",
                dataType   : "json",
                contentType: "application/json",
                url        : "<c:url value='/web/changeCart.ajax'/>",
                data       : JSON.stringify(cart),
                success    : function (data) {
                    alert("옵션이 변경됐습니다.");
                    $('.option-wrap').html('');
                    close_popup($('.option-wrap'));
                    location.reload();
                },
                error      : fn_AjaxError
            });
        }

        function nextCalendar() {
            $("#sPrevNext").val("next");

            getCalOption();
        }

        function prevCalendar() {
            $("#sPrevNext").val("prev");

            getCalOption();
        }

        /***************************************************
         * 소셜 script_End
         ****************************************************/


        /***************************************************
         * 숙소 script
         ****************************************************/

        //변경 완료 버튼 클릭 시 카트 다시 담기.
        function changeOptionCartAD(cartSn) {
            // validation에 따라 바뀔수 있음.
            var cart = {
                prdtNum  : $("#prdtNum").val(),
                startDt  : $("#sFromDt").val(),
                night    : $("#adCalNight").val(),
                adultCnt : $("#adCalMen1").val(),
                juniorCnt: $("#adCalMen2").val(),
                childCnt : $("#adCalMen3").val(),
                cartSn   : cartSn
            };

            $.ajax({
                type       : "post",
                dataType   : "json",
                contentType: "application/json",
                url        : "<c:url value='/web/changeCart.ajax'/>",
                data       : JSON.stringify(cart),
                success    : function (data) {
                    alert("옵션이 변경됐습니다.");
                    $('.option-wrap').html('');
                    close_popup($('.option-wrap'));
                    location.reload();
                },
                error      : fn_AjaxError
            });
        }

        /***************************************************
         * 숙소 script_End
         ****************************************************/

        /***************************************************
         * 기념품 script
         ****************************************************/
        function getSvSecondOption() {
            $("#secondOptionList").empty();

            var parameters = "prdtNum=" + $("#prdtNum").val() + "&svDivSn=" + $("#svDivSn").val();

            $.ajax({
                url    : "<c:url value='/web/sv/getOptionList.ajax'/>",
                data   : parameters,
                success: function (data) {
                    var list = data.list;
                    var dataArr;
                    var inx = 0, count = 1;

                    if (list != "") {
                        $(list).each(function () {
                            if (this.stockNum > 0 && this.ddlYn == 'N') {
                                dataArr = '<li>';
                                dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.optNm + '">';
                                dataArr += '<p class="product">';
                                dataArr += '<span>[선택' + count + ']</span>';
                                dataArr += '<span>' + this.optNm + '</span>';
                                dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
                                dataArr += '</p>';
                                dataArr += '<p class="price">' + commaNum(this.saleAmt) + '</p>';
                                dataArr += '</a>';
                                dataArr += '</li>';
                            } else {
                                dataArr = '<li>';
                                dataArr += '<p class="product">';
                                dataArr += '<span>[선택' + count + ']</span>';
                                dataArr += '<span>' + this.optNm + '</span>';
                                // dataArr += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
                                dataArr += '</p>';
                                dataArr += '<p class="price">품절</p>';
                                dataArr += '</li>';
                            }
                            count++;
                            $("#secondOptionList").append(dataArr);
                            $("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
                            inx++;
                        });

                        $('.comm-select .select-list-option').css('display', 'none');
                        $("#secondOptionList").css('display', 'block');
                        $('.comm-select2').addClass('open');
                    }
                },
                error  : fn_AjaxError
            });
        }

        function SvLoadSecondOption() {
            $("#secondOptionList").empty();

            var parameters = "prdtNum=" + $("#prdtNum").val() + "&svDivSn=" + $("#svDivSn").val();

            $.ajax({
                url    : "<c:url value='/web/sv/getOptionList.ajax'/>",
                data   : parameters,
                success: function (data) {
                    var list = data.list;
                    var text;
                    var count = 1;

                    if (list != "") {
                        $(list).each(function () {
                            if (this.svOptSn == $("#svOptSn").val()) {
                                text = '<span>[선택' + count + ']</span>';
                                text += '<span>' + fn_addDate(this.aplDt) + ' ' + this.optNm + '</span>';

                                if (this.stockNum > 0 && this.ddlYn == 'N') {
                                    text += '<span class="count"> | 잔여 : ' + commaNum(this.stockNum) + '개</span>';
                                }
                                $(".comm-select2 .select-button").html(text);
                                $(".comm-select2 .select-button").attr("data-raw", JSON.stringify(this));
                                $("#addOptionList").attr("data-raw", JSON.stringify(this));
                                $(".comm-select2").addClass("open");

                                var dataRaw = this;
                                var saleAmt = Number(this.saleAmt) + Number($("#addOptAmt").val());
                                this.saleAmt = saleAmt;
                                $(".comm-select3 .select-button").attr("data-raw", JSON.stringify(dataRaw));
                                return false;
                            }
                            count++;
                        });
                    }
                },
                error  : fn_AjaxError
            });
        }

        function SvAddition() {
            var dataRaw = jQuery.parseJSON($(".comm-select2 .select-button").attr("data-raw"));
            var stockNum = Number(dataRaw.stockNum);
            var num = Number($("#qty").val()) + 1;

            if (num <= stockNum) {
                $("#qty").val(num);

                selectedItemSaleAmt();
            }
            // 개별 배송비 로직 변경 2021.05.21 chaewan.jung
            <%--if (dataRaw.dlvAmtDiv == "${Constant.DLV_AMT_DIV_MAXI}") {--%>
            <%--    if (Number(dataRaw.maxiBuyNum) < num) {--%>
            <%--        //alert(data.maxiBuyNum + "까지 구매하실수 있습니다.");--%>
            <%--        $("#qty").val(dataRaw.maxiBuyNum);--%>

            <%--        selectedItemSaleAmt();--%>
            <%--    }--%>
            <%--}--%>
        }

        function SvSubstract() {
            var num = parseInt($("#qty").val()) - 1;

            if (num >= 1) {
                $("#qty").val(num);

                selectedItemSaleAmt();
            }
        }

        // 카트 정보에 옵션 중복 체크.
        function SvCheckDupOption(newData) {
            var result = false;

            $("input[name='svCart']").each(function () {
                var cartSn = $(this).val();

                if ($("input[name='" + cartSn + "_prdtNum']").val() == $("#prdtNum").val()) {
                    // 내꺼는 다시 선택해도 괜찮다.
                    if ($("#svDivSn").val() == newData.svDivSn && $("#svOptSn").val() == newData.svOptSn) {
                        result = false;
                        return false;
                    } else if ($("input[name='" + cartSn + "_optSn']").val() == newData.svOptSn && $("input[name='" + cartSn + "_divSn']").val() == newData.svDivSn) {
                        result = true;
                        return false;
                    }
                }
            });

            return result;
        }

        /** 추가옵션선택시 */
        function getSvAddOption() {
            if ($("#addOptionList").css('display') == 'block') {
                $('.comm-select .select-list-option').css('display', 'none');
                return;
            }

            if ($("#addOptionList li").length > 0) {
                if ($("#addOptionList").css('display') == 'none') {
                    $('.comm-select .select-list-option').css('display', 'none');
                    $('.packCalendar').css('display', 'none');
                    $("#addOptionList").css('display', 'block')
                }
                $('.comm-select').removeClass('open');
                $('.comm-select3').addClass('open');
                return false;
            }
            var b_data = {
                addOptNm : '',
                addOptAmt: 0,
                addOptSn : ''
            };

            $.ajax({
                url    : "<c:url value='/web/sv/getAddOptList.ajax'/>",
                data   : "prdtNum=" + $("#prdtNum").val(),
                success: function (data) {
                    var dataArr = '<li><a href="javascript:;" data-raw="" title=""><p class="product"><span>선택안함</span></p></a></li>';

                    $("#addOptionList").append(dataArr);

                    var list = data.list;
                    var inx = 1;

                    if (list != "") {
                        $(list).each(function () {
                            dataArr = '<li>';
                            dataArr += '<a href="javascript:void(0)" data-raw="" title="' + this.addOptNm + '">';
                            dataArr += '<p class="product"><span>' + this.addOptNm + '</span></p>';
                            dataArr += '<p class="price">' + commaNum(this.addOptAmt) + '</p>';
                            dataArr += '</a>';
                            dataArr += '</li>';

                            $("#addOptionList").append(dataArr);
                            $("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
                            inx++;
                        });

                        $("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data));
                    }
                },
                error  : fn_AjaxError
            });

            $('.comm-select').removeClass('open');
            $('.comm-select3').addClass('open');
            $('.comm-select .select-list-option').css('display', 'none');
            $("#addOptionList").css('display', 'block');
        }

        //변경 완료 버튼 클릭 시 카트 다시 담기.
        function changeOptionCartSv(cartSn) {
            // validation에 따라 바뀔수 있음.
            var cart = {
                prdtNum     : $("#prdtNum").val(),
                qty         : $("#qty").val(),
                svOptSn     : $("#svOptSn").val(),
                svDivSn     : $("#svDivSn").val(),
                cartSn      : cartSn,
                addOptAmt   : $("#addOptAmt").val(),
                addOptNm    : $("#addOptNm").val(),
                directRecvYn: $("select[name=directRecvYn]").val()
            };

            $.ajax({
                type       : "post",
                dataType   : "json",
                contentType: "application/json",
                url        : "<c:url value='/web/changeCart.ajax'/>",
                data       : JSON.stringify(cart),
                success    : function (data) {
                    alert("옵션이 변경됐습니다.");
                    $('.option-wrap').html('');
                    close_popup($('.option-wrap'));
                    location.reload();
                },
                error      : fn_AjaxError
            });
        }

        /***************************************************
         * 제주특산품 script_End
         ****************************************************/

        function fn_ShowLayer(cartSn, divCd) {
            var parameters = "cartSn=" + cartSn;

            $.ajax({
                type      : "post",
                url       : "<c:url value='/web/cartOptionLayer.ajax'/>",
                data      : parameters,
                beforeSend: function () {
                    if ("${fn:length(cartList) == 0}" == "true") {
                        alert("장바구니에 담긴 상품이 없습니다.");
                        location.reload();
                        return false;
                    }
                },
                success   : function (data) {
                    $('.option-wrap').html(data);

                    /***************************************************
                     * 렌터카
                     ****************************************************/
                    if (divCd == 'rc') {
                        $("#sFromDtView").datepicker({
                            dateFormat : "yy-mm-dd",
                            minDate    : "${SVR_TODAY}",
                            defaultDate: fn_addDate($("#sFromDt").val()),
                            onSelect   : function (selectedDate) {
                                $('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));

                                $('#sToDtView').datepicker("destroy");

                                $("#sToDtView").datepicker({
                                    dateFormat : "yy-mm-dd",
                                    minDate    : "${SVR_TODAY}",
                                    defaultDate: fn_NexDay(selectedDate),
                                    onSelect   : function (selectedDate) {
                                        $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

                                        fn_CalRent();
                                    }
                                });

                                $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

                                fn_CalRent();
                            }
                        });

                        $("#sToDtView").datepicker({
                            dateFormat : "yy-mm-dd",
                            minDate    : "${SVR_TODAY}",
                            defaultDate: fn_addDate($("#sToDt").val()),
                            onSelect   : function (selectedDate) {
                                $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

                                fn_CalRent();
                            }
                        });

                        fn_CalRent();

                    } else if (divCd == "sp") {
                        /***************************************************
                         * 소셜
                         ****************************************************/
                        $('.opCal-title').click(function () {
                            if ($('.packCalendar').css('display') == 'block') {
                                $('.packCalendar').css('display', 'none');

                                if ($("#secondOptionList li").length > 0 && $('.comm-select2').css('display') == 'block') {
                                    $(".opCal").removeClass('open');
                                    $(".comm-select2").addClass('open');
                                }
                            } else {
                                if ($(".calendar div").length > 0) {
                                    $('.packCalendar').css('display', 'block');
                                    $('.comm-select2').removeClass("open");
                                    $('.opCal').addClass("open");
                                } else {
                                    getCalOption();
                                }
                            }
                        });

                        $('.comm-select2 .select-button').click(function () {
                            if ($("#secondOptionList").css('display') == 'block') {
                                $("#secondOptionList").css('display', 'none');
                            } else {
                                if ($("#secondOptionList li").length > 0) {
                                    $("#secondOptionList").css('display', 'block');
                                } else {
                                    if ("${Constant.SP_PRDT_DIV_TOUR}" != $("#prdtDiv").val()) {
                                        getSecondOption('');
                                    }
                                }
                            }
                        });

                        $('.comm-select3 .select-button').click(function () {
                            if ($(".comm-select3 .select-list-option").css('display') == 'block') {
                                $(".comm-select3 .select-list-option").css('display', 'none');
                            } else {
                                if ($("#addOptionList li").length > 0) {
                                    $(".comm-select3 .select-list-option").css('display', 'block');
                                } else {
                                    if ("${Constant.SP_PRDT_DIV_TOUR}" != $("#prdtDiv").val()) {
                                        getAddOption();
                                    }
                                }
                            }
                        });

                        // 옵션 클릭시.
                        $("#secondOptionList").on("click", "li>a", function () {
                            var data = jQuery.parseJSON($(this).attr("data-raw"));
                            // 중복체크.
                            if (checkDupOption(data)) {
                                alert("<spring:message code='fail.product.duplication'/>");
                                return false;
                            }
                            if ($("#addOptListLength").val() == 0) {
                                $(".comm-select .select-button").attr("data-raw", $(this).attr("data-raw"))
                                $('.comm-select .select-list-option').css('display', 'none');
                                $(".comm-select .select-button").html($(this).find(".product").html());
                                $("#spOptSn").val(data.spOptSn);

                                if ($('.opCal').css('display') == "block") {
                                    $(".comm-select").removeClass("open");
                                    $('.opCal').addClass("open");
                                }
                                selectedItemSaleAmt();
                            } else {
                                getAddOption();

                                $("#spOptSn").val(data.spOptSn);
                                $("#addOptionList").attr("data-raw", $(this).attr("data-raw"));
                                $(".comm-select2 .select-button").html($(this).find(".product").html());
                            }
                        });

                        //추가옵션 클릭시
                        $("#addOptionList").on('click', "li>a", function () {
                            var dataRaw = jQuery.parseJSON($("#addOptionList").attr("data-raw"));
                            var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));
                            var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);

                            dataRaw.saleAmt = saleAmt;

                            var ori_dataRaw = JSON.stringify(dataRaw);

                            $('.comm-select .select-list-option').css('display', 'none');
                            $(".comm-select3 .select-button").attr("data-raw", ori_dataRaw)
                            $(".comm-select3 .select-button").html($(this).find(".product").html());

                            $("#addOptNm").val(thisDataRaw.addOptNm);
                            $("#addOptAmt").val(thisDataRaw.addOptAmt);

                            if ($('.opCal').css('display') == "block") {
                                $(".comm-select").removeClass("open");
                                $('.opCal').addClass("open");
                            } else {
                                $('.comm-select').removeClass('open');
                                $('.comm-select2').addClass('open');
                            }
                            selectedItemSaleAmt();
                        });

                        $(".qtyWrap").on("keyup", "#qty", function () {
                            var dataRaw = jQuery.parseJSON($(".comm-select2 .select-button").attr("data-raw"));
                            var stockNum = parseInt(dataRaw.stockNum);
                            $(this).val($(this).val().replace(/[^0-9]/gi, ""));

                            if ($(this).val() > stockNum) {
                                $(this).val(stockNum);
                            }
                            selectedItemSaleAmt();
                        });
                        // 초기화.
                        loadSecondOption();

                    } else if (divCd == "ad") {
                        /***************************************************
                         * 숙소
                         ****************************************************/
                    } else if (divCd == "sv") {
                        /***************************************************
                         * 제주특산품
                         ****************************************************/
                        $('.comm-select2 .select-button').click(function () {
                            if ($("#secondOptionList").css('display') == 'block') {
                                $("#secondOptionList").css('display', 'none');
                            } else {
                                if ($("#secondOptionList li").length > 0) {
                                    $("#secondOptionList").css('display', 'block');
                                } else {
                                    getSvSecondOption();
                                }
                            }
                        });

                        $('.comm-select3 .select-button').click(function () {
                            if ($(".comm-select3 .select-list-option").css('display') == 'block') {
                                $(".comm-select3 .select-list-option").css('display', 'none');
                            } else {
                                if ($("#addOptionList li").length > 0) {
                                    $(".comm-select3 .select-list-option").css('display', 'block');
                                } else {
                                    getSvAddOption();
                                }
                            }
                        });

                        // 옵션 클릭시.
                        $("#secondOptionList").on("click", "li>a", function () {
                            var data = jQuery.parseJSON($(this).attr("data-raw"));
                            // 중복체크.
                            if (SvCheckDupOption(data)) {
                                alert("<spring:message code='fail.product.duplication'/>");
                                return false;
                            }
                            if ($("#addOptListLength").val() == 0) {
                                $(".comm-select .select-button").attr("data-raw", $(this).attr("data-raw"))
                                $('.comm-select .select-list-option').css('display', 'none');
                                $(".comm-select .select-button").html($(this).find(".product").html());
                                $("#svOptSn").val(data.svOptSn);

                                selectedItemSaleAmt();
                            } else {
                                getSvAddOption();

                                $("#svOptSn").val(data.svOptSn);
                                $("#addOptionList").attr("data-raw", $(this).attr("data-raw"));
                                $(".comm-select2 .select-button").html($(this).find(".product").html());
                            }
                        });

                        //추가옵션 클릭시
                        $("#addOptionList").on('click', "li>a", function () {
                            var dataRaw = jQuery.parseJSON($("#addOptionList").attr("data-raw"));
                            var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));
                            var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);

                            dataRaw.saleAmt = saleAmt;

                            var ori_dataRaw = JSON.stringify(dataRaw);

                            $('.comm-select .select-list-option').css('display', 'none');
                            $(".comm-select3 .select-button").attr("data-raw", ori_dataRaw)
                            $(".comm-select3 .select-button").html($(this).find(".product").html());

                            $("#addOptNm").val(thisDataRaw.addOptNm);
                            $("#addOptAmt").val(thisDataRaw.addOptAmt);

                            $('.comm-select').removeClass('open');
                            $('.comm-select2').addClass('open');

                            selectedItemSaleAmt();
                        });

                        $(".qtyWrap").on("keyup", "#qty", function () {
                            var dataRaw = jQuery.parseJSON($(".comm-select2 .select-button").attr("data-raw"));
                            var stockNum = parseInt(dataRaw.stockNum);
                            $(this).val($(this).val().replace(/[^0-9]/gi, ""));

                            if ($(this).val() > stockNum) {
                                $(this).val(stockNum);
                            }
                            if (dataRaw.dlvAmtDiv == "${Constant.DLV_AMT_DIV_MAXI}") {
                                if (Number(dataRaw.maxiBuyNum) < Number($(this).val())) {
                                    //alert(data.maxiBuyNum + "까지 구매하실수 있습니다.");
                                    $(this).val(dataRaw.maxiBuyNum);
                                }
                            }
                            selectedItemSaleAmt();
                        });
                        // 초기화.
                        SvLoadSecondOption();
                    }
                    //옵션 닫기
                    $('.option-close').click(function () {
                        close_popup($('.option-wrap'));
                        $('.option-wrap').html("");
                    });

                    show_popup($('.option-wrap'));
                },
                error     : fn_AjaxError
            });
        }

        function fn_TotalJumunAmt() {
            var totalJumunAmt = 0;

            $("input:checkbox[name=chk]").each(function (index) {
                if ($(this).is(":checked")) {
                    totalJumunAmt += parseInt($("input[name=cartTotalAmt]").eq(index).val());
                }
            });

            $("#totalJumunAmt").html(commaNum(totalJumunAmt));
        }

        /**
         묶음배송비 개념 추가
         2021.04.16 chaewan.jung
         **/
            //Dom 삭제 전 리스트 cartSn 저장
        let orgCartSn = [];
        $(document).ready(function () {
            $("input:checkbox[name=sv_chk]").each(function () {
                if ($(this).is(":checked")) {
                    orgCartSn.push($(this).val());
                }
            });
        })

        function fn_TotalSvJumunAmt() {
            let prdtAmt = 0;
            let dlvAmt = 0;

            //상품가격 sum-----------------------
            $("input:checkbox[name=sv_chk]").each(function (index) {
                if ($(this).is(":checked")) {
                    prdtAmt += parseInt($("input[name=sv_cartTotalAmt]").eq(index).val());
                }
            });

            //배송비 sum--------------------------
            let totGroupDlvAmt = 0;

            //배송(묶음)상품 개수만큼 loop
            for (let i = 2; i <= $("#lastGroupKey").val(); i++) {

                //상품(묶음) 개수
                const groupLen = $("input[name='sv_groupKey" + i + "']").data('row')
                //group check 상태. 하나라도 check면 check.
                let groupChk = false;

                //상품개수가 1보다 크면 묶음상품 배송비
                if (groupLen > 1) {
                    //묶음 상품별 loop
                    for (let y = 1; y <= groupLen; y++) {
                        //체크박스 시작 id
                        const startId = orgCartSn.indexOf($("input[name='sv_groupKey" + i + "']").val());
                        //체크박스 마지막 id
                        const lastId = startId + parseInt(groupLen);
                        //console.log(startId + "to" + lastId);

                        //startId 부터 groupLen 까지
                        for (let z = startId; z < lastId; z++) {
                            if ($("#chk" + orgCartSn[z]).is(":checked")) {
                                groupChk = true;
                            }
                        }
                    }

                    if (groupChk) {
                        totGroupDlvAmt += parseInt($("#dlvAmt" + i).val());
                    }

                } else { //단일 상품 배송비
                    const id = $("input[name='sv_groupKey" + i + "']").val();
                    if ($("#chk" + id).is(":checked")) {
                        dlvAmt += parseInt($("#dlvAmt" + i).val());
                    }
                }
            }

            dlvAmt = dlvAmt + totGroupDlvAmt;

            $("#sv_totalPrdtAmt").html(commaNum(prdtAmt));
            $("#sv_totalDlvAmt").html(commaNum(dlvAmt));
            $("#sv_totalJumunAmt").html(commaNum(prdtAmt + dlvAmt));
        }

        /**
         flag = selDel : 개별삭제, chkDel 선택삭제
         val = checkbox id value
         2021.04.14 chaewan.jung
         **/
        function fn_DelCart(flag, val) {
            const cartSn = [];

            if (flag == "selDel") {
                cartSn.push(val);
            } else {
                $("input:checkbox[name=chk]").each(function () {
                    if ($(this).is(":checked")) {
                        cartSn.push($(this).val());
                    }
                });
            }

            if (cartSn.length == 0) {
                alert("선택된 상품이 없습니다.");
                return;
            } else {
                const parameters = "cartSn=" + cartSn;

                $.ajax({
                    type      : "post",
                    url       : "<c:url value='/web/deleteCart.ajax'/>",
                    data      : parameters,
                    beforeSend: function () {
                        if ("${fn:length(cartList) == 0}" == "true") {
                            alert("장바구니에 담긴 상품이 없습니다.");
                            location.reload();
                            return false;
                        }
                    },
                    success   : function (data) {

                        if (flag == "selDel") {
                            $("input:checkbox[id='chk" + val + "']").parent().remove();
                        } else {
                            for (var i = $("#cartTbody>li").length; i >= 0; i--) {
                                if ($("input:checkbox[name=chk]").eq(i - 1).is(":checked")) {
                                    $("#cartTbody>li").eq(i - 1).remove();
                                }
                            }
                        }

                        if ($("#cartTbody>li").length == 0) {
                            $("#tourCartWrap").css("display", "none");

                            if ($("#sv_cartTbody>li").length == 0) {
                                $("#emptyCart").css("display", "block");
                            }
                        }
                        $("#headCartCnt").html(data.cartCnt);

                        fn_TotalJumunAmt();
                    },
                    error     : fn_AjaxError
                });
            }
        }

        /**
         flag = selDel : 개별삭제, chkDel 선택삭제
         val = checkbox id value
         index = 리스트 번호. 묶음배송 상품 삭제시 controll 하기위해 사용.
         2021.04.15 chaewan.jung
         **/
        function fn_SvDelCart(flag, val, index) {
            const cartSn = [];

            if (flag == "selDel") {
                cartSn.push(val);
            } else {
                $("input:checkbox[name=sv_chk]").each(function (index) {
                    if ($(this).is(":checked")) {
                        cartSn.push($(this).val());
                    }
                });
            }

            if (cartSn.length == 0) {
                alert("선택된 상품이 없습니다.");
                return;
            } else {
                const parameters = "cartSn=" + cartSn;

                $.ajax({
                    type      : "post",
                    url       : "<c:url value='/web/deleteCart.ajax'/>",
                    data      : parameters,
                    beforeSend: function () {
                        if ("${fn:length(cartList) == 0}" == "true") {
                            alert("장바구니에 담긴 상품이 없습니다.");
                            location.reload();
                            return false;
                        }
                    },
                    success   : function (data) {

                        if (flag == "selDel") {
                            //묶음배송 상품 삭제 시 배송비 전달 처리
                            for (let i = 1; i < $('li.select').length; i++) {
                                if ($("#shipping_fee" + (index + i)).length > 0) {

                                    if ($.trim($("#shipping_fee" + (index)).text()) != "묶음배송" && $.trim($("#shipping_fee" + (index + i)).text()) == "묶음배송") {
                                        $("#shipping_fee" + (index + i)).html($("#shipping_fee" + index).html());
                                    }
                                    break;
                                }
                            }
                            $("input:checkbox[id='chk" + val + "']").parent().remove();

                        } else {
                            $("input:checkbox[name=sv_chk]").each(function () {
                                if ($(this).is(":checked")) {
                                    //묶음배송 상품 삭제 시 배송비 전달 처리
                                    for (let i = 1; i < $('li.select').length; i++) {
                                        if ($("#shipping_fee" + ($(this).data('index') + i)).length > 0) {

                                            if ($.trim($("#shipping_fee" + ($(this).data('index'))).text()) != "묶음배송" && $.trim($("#shipping_fee" + ($(this).data('index') + i)).text()) == "묶음배송") {
                                                $("#shipping_fee" + ($(this).data('index') + i)).html($("#shipping_fee" + $(this).data('index')).html());
                                            }
                                            break;
                                        }
                                    }
                                    $("input:checkbox[id='chk" + $(this).val() + "']").parent().remove();

                                }
                            });
                        }

                        if ($("#sv_cartTbody>li").length == 0) {
                            $("#svCartWrap").css("display", "none");

                            if ($("#cartTbody>li").length == 0) {
                                $("#emptyCart").css("display", "block");
                            }
                        }
                        $("#headCartCnt").html(data.cartCnt);

                        fn_TotalSvJumunAmt();

                    },
                    error     : fn_AjaxError
                });
            }
        }

        function fn_Reservation(val) {
            var cartSn = [];

            if (val == '') {
                $("input:checkbox[name=chk]").each(function (index) {
                    if ($(this).is(":checked")) {
                        cartSn.push($(this).val());
                    }
                });
            } else {   //즉시예약(구매) 2021.04.14 chaewan.jung
                cartSn.push(val);
            }

            if (cartSn.length == 0) {
                alert("선택된 상품이 없습니다.");
                return;
            } else {
                $.ajax({
                    type      : "post",
                    url       : "<c:url value='/web/reservationChk.ajax'/>",
                    beforeSend: function () {
                        if ("${fn:length(cartList) == 0}" == "true") {
                            alert("장바구니에 담긴 상품이 없습니다.");
                            location.reload();
                            return false;
                        }
                    },
                    success   : function (data) {
                        var errorCnt = 0;

                        jQuery.each(data.cartList, function (index, onerow) {
                            if (onerow["ableYn"] == "N") {
                                if ($("#chk" + onerow["cartSn"]).is(":checked")) {
                                    errorCnt++;
                                }
                            }
                        });

                        if (errorCnt > 0) {
                            alert("예약이 불가능한 상품이 존재합니다.");
                            return;
                        } else {
                            location.href = "<c:url value='/web/order01.do?cartSn=' />" + cartSn + "&rsvDiv=${Constant.RSV_DIV_C}";
                        }
                    },
                    error     : fn_AjaxError
                });
            }
        }

        function fn_SvReservation(val) {
            var cartSn = [];

            if (val == '') {
                $("input:checkbox[name=sv_chk]").each(function (index) {
                    if ($(this).is(":checked")) {
                        cartSn.push($(this).val());
                    }
                });
            } else {
                cartSn.push(val);
            }

            if (cartSn.length == 0) {
                alert("선택된 상품이 없습니다.");
                return;
            } else {
                $.ajax({
                    type      : "post",
                    url       : "<c:url value='/web/reservationChk.ajax'/>",
                    beforeSend: function () {
                        if ("${fn:length(cartList) == 0}" == "true") {
                            alert("장바구니에 담긴 상품이 없습니다.");
                            location.reload();
                            return false;
                        }
                    },
                    success   : function (data) {
                        var errorCnt = 0;

                        jQuery.each(data.cartList, function (index, onerow) {
                            if (onerow["ableYn"] == "N") {
                                if ($("#chk" + onerow["cartSn"]).is(":checked")) {
                                    errorCnt++;
                                }
                            }
                        });

                        if (errorCnt > 0) {
                            alert("예약이 불가능한 상품이 존재합니다.");
                            return;
                        } else {
                            location.href = "<c:url value='/web/order01.do?cartSn=' />" + cartSn + "&rsvDiv=${Constant.RSV_DIV_C}";
                        }
                    },
                    error     : fn_AjaxError
                });
            }
        }

        $(document).ready(function () {

            $("#all_check").click(function () {
                if ($(this).is(":checked")) {
                    $("input:checkbox[name=chk]").prop("checked", true);
                } else {
                    $("input:checkbox[name=chk]").prop("checked", false);
                }

                fn_TotalJumunAmt();
            });

            $("input:checkbox[name=chk]").click(function () {

                //체크박스 하나 풀었을때 '전체체크박스' 해제 2021.04.14 chaewan.jung
                if ($("input:checkbox[name=chk]:checked").length == $("#cartTbody>li").length) {
                    $("#all_check").prop("checked", true);
                } else {
                    $("#all_check").prop("checked", false);
                }

                fn_TotalJumunAmt();
            });

            $("#sv_all_check").click(function () {
                if ($(this).is(":checked")) {
                    $("input:checkbox[name=sv_chk]").prop("checked", true);
                } else {
                    $("input:checkbox[name=sv_chk]").prop("checked", false);
                }
                fn_TotalSvJumunAmt();
            });

            $("input:checkbox[name=sv_chk]").click(function () {

                //체크박스 하나 풀었을때 '전체체크박스' 해제 2021.04.14 chaewan.jung
                if ($("input:checkbox[name=sv_chk]:checked").length == $("#sv_cartTbody>li").length) {
                    $("#sv_all_check").prop("checked", true);
                } else {
                    $("#sv_all_check").prop("checked", false);
                }

                fn_TotalSvJumunAmt();
            });

            fn_TotalJumunAmt();
            fn_TotalSvJumunAmt();

            /** 열고닫기  */
            $(".store_name span").click(function () {
                $(this).closest(".item-list");
                let index = $(".item-list").index($(this).closest(".item-list"));
                if ($(".item-list:eq(" + index + ")").hasClass("open")) {
                    $(".item-list:eq(" + index + ")").removeClass("open");
                    $(".item-list:eq(" + index + ")").attr("attr-value", "0");
                } else {
                    $(".item-list:eq(" + index + ")").addClass("open");
                    $(".item-list:eq(" + index + ")").attr("attr-value", "1");
                }
                ;
                let itemMenuCd = "";
                $("[attr-value]").each(function () {
                    let compVal = $(this).attr("attr-value");
                    $(this).attr("attr-value", compVal);
                    itemMenuCd += compVal;
                });
                localStorage.setItem("itemMenuCd", itemMenuCd);
            });
        });


    </script>

</head>
<body>
<header id="header">
    <jsp:include page="/web/head.do"></jsp:include>
</header>
<main id="main">
    <div class="mapLocation">
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span> <span>장바구니</span>
        </div>
    </div>

    <!-- quick banner -->
    <jsp:include page="/web/left.do"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents">

            <!-- new contents -->
            <div class="cart">
                <div class="bgWrap2">
                    <div class="inner">

                        <!-- 장바구니 -->
                        <div class="comm_pay">
                            <!-- order_header -->
                            <div class="pay-title">
                                <div class="order_header">
                                    <div class="order_title">
                                        <div class="order_header_text cart_wrap_title">장바구니</div>
                                        <div class="commList1">
                                            <div>· 장바구니에 저장된 상품은 비로그인 상태에서 사이트를 닫으면 삭제됩니다.</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="order_select">
                                <div class="order_content_wrap">
                                    <div class="a_order_content">

                                        <!-- 장바구니 목록 있을 시 -->
                                        <!-- table -->
                                        <c:if test="${not empty cartList}"> <c:set var="cartSize" value="0"/>
                                        <c:set var="sv_cartSize" value="0"/>

                                        <c:forEach var="cart" items="${cartList}" varStatus="status"> <c:choose>
                                            <c:when test="${fn:substring(cart.prdtNum, 0, 2) eq Constant.SV}">
                                                <c:set var="sv_cartSize" value="${sv_cartSize + 1}"/> </c:when>
                                            <c:otherwise> <c:set var="cartSize" value="${cartSize + 1}"/> </c:otherwise>
                                        </c:choose> </c:forEach>
                                        <!-- 관광상품 -->
                                        <c:if test="${cartSize > 0}">
                                            <div id="tourCartWrap" class="order_cart_wrap" style="display: block">
                                                <div class="cart-section">
                                                    <h4 class="title">관광상품</h4>
                                                    <div class="order_cart_top">
                                                        <button type="button" class="btn_remove_selected"
                                                                onclick="fn_DelCart('chkDel','');">선택삭제
                                                        </button>
                                                    </div>
                                                </div>

                                                <section id="cartList" class="product-info item-list open"
                                                         attr-value="1">
                                                    <div class="order_store">
                                                        <input id="all_check" type="checkbox" checked="checked">
                                                        <label class="order_checkbox_part" for="all_check"></label>

                                                        <ul class="title">
                                                            <li class="img-domain">이미지</li>
                                                            <li class="division">구분</li>
                                                            <li class="info">상품정보</li>
                                                            <li class="sum">금액</li>
                                                            <li class="remark">비고</li>
                                                        </ul>
                                                        <div class="store_name">
                                                            <span>
                                                                <a href=""></a>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="cartTbody order_cart_list half">
                                                        <ul id="cartTbody">

                                                            <c:forEach items="${cartList}" var="cart" varStatus="status">
                                                                <c:set var="category" value="${fn:substring(cart.prdtNum, 0, 2)}"/> <!--NO Image 처리-->
                                                                <c:set var="imgPath" value="${cart.imgPath eq '' ? '/images/web/cart/no-image.png':cart.imgPath}"/>

                                                                <c:choose>
                                                                    <c:when test="${category eq Constant.SOCIAL}">
                                                                        <input type="hidden" name="spCart" value="${cart.cartSn}"/>
                                                                        <input type="hidden" name="${cart.cartSn}_prdtNum" value="${cart.prdtNum}"/>
                                                                        <input type="hidden" name="${cart.cartSn}_optSn" value="${cart.spOptSn}"/>
                                                                        <input type="hidden" name="${cart.cartSn}_divSn" value="${cart.spDivSn}"/>

                                                                        <li class="select">
                                                                            <input type="hidden" name="cartSn" value="${cart.cartSn}">
                                                                            <input type="checkbox" class="ch" name="chk" id="chk${cart.cartSn}" value="${cart.cartSn}"
                                                                                   <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
                                                                            <label class="order_checkbox_part" for="chk${cart.cartSn}"></label>
                                                                            <div class="cart_info_box">
                                                                                <div class="order_prd_row">
                                                                                    <div class="cart_thumb_box">
                                                                                        <span class="order_thumb">
                                                                                            <img src="${imgPath}" alt="">
                                                                                        </span>
                                                                                    </div>
                                                                                    <!-- 구분 -->
                                                                                    <div class="order_prd_price item_qty_wrap">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <dt class="skip">구분</dt>
                                                                                                <dd>
                                                                                                    <i class="division">${cart.ctgrNm}</i>
                                                                                                </dd>
                                                                                            </div>
                                                                                        </dl>
                                                                                    </div> <!-- //구분 -->
                                                                                    <div class="left order_prd">
                                                                                        <div class="product prd_name">
                                                                                            <span class="cProduct">
                                                                                                [${cart.corpNm}] ${cart.prdtNm}
                                                                                            </span>
                                                                                        </div>
                                                                                        <input type="hidden">
                                                                                        <div class="order_prd_option">
                                                                                            <ul class="infoText">
                                                                                                <li>${cart.prdtDivNm} | ${cart.optNm}
                                                                                                    <c:if test="${not empty cart.addOptNm}"> | ${cart.addOptNm}</c:if>
                                                                                                </li>
                                                                                                <c:if test="${not empty cart.aplDt}">
                                                                                                    <li>
                                                                                                        <fmt:parseDate var='aplDt' value='${cart.aplDt}' pattern="yyyyMMdd" scope="page"/>
                                                                                                        <span><fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd"/> </span><br>
                                                                                                    </li>
                                                                                                </c:if>
                                                                                                <li>수량 : ${cart.qty}</li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="order_prd_price sub_item_price">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">

                                                                                                <input type="hidden" name="cartTotalAmt" value="${cart.totalAmt}">
                                                                                                <dt class="skip">총금액가</dt>
                                                                                                <dd>
                                                                                                    <c:if test="${cart.totalAmt == '-2'}">
                                                                                                        <span class="nt impossible">
                                                                                                            <img src="/images/web/cart/info.png" alt="">
                                                                                                            상품정보 변경으로 예약불가입니다 <br>옵션을 다시 선택해주세요
                                                                                                        </span>
                                                                                                    </c:if>
                                                                                                    <c:if test="${cart.totalAmt != '-2'}">
                                                                                                        <i class="number">
                                                                                                            <fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber> </i> 원
                                                                                                    </c:if>
                                                                                                </dd>

                                                                                            </div>
                                                                                        </dl>
                                                                                    </div>
                                                                                    <div class="order_pick">
                                                                                        <a class="order_btn type2"
                                                                                           href="javascript:fn_Reservation(${cart.cartSn});"> <span>즉시예약</span>
                                                                                        </a>
                                                                                        <a href="javascript:fn_ShowLayer('${cart.cartSn}','sp')"
                                                                                           class="btn2 room_option optionBT order_btn">
                                                                                            <span>옵션변경</span> </a>
                                                                                    </div>

                                                                                    <button type="button" class="bt_del"
                                                                                            onclick="fn_DelCart('selDel',${cart.cartSn});">
                                                                                        <i class="order_btn_remove ">삭제하기</i>
                                                                                    </button>

                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                    </c:when>
                                                                    <c:when test="${category eq Constant.ACCOMMODATION}">
                                                                        <li class="select">

                                                                            <input type="hidden" name="cartSn" value="${cart.cartSn}">
                                                                            <input type="checkbox" class="ch" name="chk" id="chk${cart.cartSn}" value="${cart.cartSn}" <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
                                                                            <label class="order_checkbox_part" for="chk${cart.cartSn}"></label>
                                                                            <div class="cart_info_box">
                                                                                <div class="order_prd_row">
                                                                                    <div class="cart_thumb_box">
                                                                            <span class="order_thumb">
                                                                                <img src="${imgPath}" alt="">
                                                                            </span>
                                                                                    </div>
                                                                                    <!-- 구분 -->
                                                                                    <div class="order_prd_price item_qty_wrap">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <dt class="skip">구분</dt>
                                                                                                <dd>
                                                                                                    <i class="division">${cart.prdtDivNm}</i>
                                                                                                </dd>
                                                                                            </div>
                                                                                        </dl>
                                                                                    </div> <!-- //구분 -->
                                                                                    <div class="left order_prd">
                                                                                        <div class="product prd_name">
                                                                                            <span class="cProduct">
                                                                                                [${cart.corpNm}] ${cart.prdtNm}
                                                                                            </span>
                                                                                        </div>
                                                                                        <input type="hidden">
                                                                                        <div class="order_prd_option">
                                                                                            <ul class="infoText">
                                                                                                <li>
                                                                                                    <fmt:parseDate value='${cart.startDt}' var='fromDttm' pattern="yyyyMMdd" scope="page"/>
                                                                                                    <fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd"/> 부터 ${cart.night}박
                                                                                                </li>
                                                                                                <li>성인 ${cart.adultCnt}
                                                                                                    <c:if test="${cart.juniorCnt > 0}">, 소아 ${cart.juniorCnt}</c:if>
                                                                                                    <c:if test="${cart.childCnt > 0}">, 유아 ${cart.childCnt}</c:if>
                                                                                                </li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="order_prd_price sub_item_price">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <input type="hidden"
                                                                                                       name="cartTotalAmt"
                                                                                                       value="${cart.totalAmt}">
                                                                                                <dt class="skip">총금액가
                                                                                                </dt>
                                                                                                <dd>
                                                                                                    <c:if test="${cart.totalAmt == '-2'}">
                                                                                        <span class="nt impossible">
                                                                                            <img src="/images/web/cart/info.png" alt="" >
                                                                                            상품정보 변경으로 예약불가입니다 <br>옵션을 다시 선택해주세요
                                                                                        </span> </c:if>
                                                                                                    <c:if test="${cart.totalAmt != '-2'}">
                                                                                                        <i class="number">
                                                                                                            <fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber> </i> 원
                                                                                                    </c:if>
                                                                                                </dd>

                                                                                            </div>
                                                                                        </dl>
                                                                                    </div>
                                                                                    <div class="order_pick">
                                                                                        <a class="order_btn type2"
                                                                                           href="javascript:fn_Reservation(${cart.cartSn});">
                                                                                            <span>즉시예약</span> </a>
                                                                                        <a href="javascript:fn_ShowLayer('${cart.cartSn}','ad')"
                                                                                           class="btn2 room_option optionBT order_btn">
                                                                                            <span>옵션변경</span> </a>
                                                                                    </div>
                                                                                    <button type="button" class="bt_del"
                                                                                            onclick="fn_DelCart('selDel',${cart.cartSn});">
                                                                                        <i class="order_btn_remove ">삭제하기</i>
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                    </c:when>
                                                                    <c:when test="${category eq Constant.RENTCAR}">
                                                                        <li class="select">
                                                                            <input type="hidden" name="cartSn" value="${cart.cartSn}">
                                                                            <input type="checkbox" name="chk" id="chk${cart.cartSn}" class="ch" value="${cart.cartSn}" <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
                                                                            <label class="order_checkbox_part" for="chk${cart.cartSn}"></label>
                                                                            <div class="cart_info_box">
                                                                                <div class="order_prd_row">
                                                                                    <div class="cart_thumb_box">
                                                                                        <span class="order_thumb">
                                                                                            <img src="${imgPath}" alt="">
                                                                                        </span>
                                                                                    </div>
                                                                                    <!-- 구분 -->
                                                                                    <div class="order_prd_price item_qty_wrap">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <dt class="skip">구분</dt>
                                                                                                <dd>
                                                                                                    <i class="division">${cart.prdtDivNm}</i>
                                                                                                </dd>
                                                                                            </div>
                                                                                        </dl>
                                                                                    </div> <!-- //구분 -->
                                                                                    <c:set var="prdtNms" value="${fn:split(cart.prdtNm, '/')}"/>
                                                                                    <div class="left order_prd">
                                                                                        <div class="product prd_name">
                                                                                            <span class="cProduct">
                                                                                                [${cart.corpNm}] ${prdtNms[0]}
                                                                                            </span>
                                                                                        </div>
                                                                                        <input type="hidden">
                                                                                        <div class="order_prd_option">
                                                                                            <ul class="infoText">
                                                                                                <li> ${prdtNms[1]} | ${prdtNms[2]}</li>
                                                                                                <li>
                                                                                                    <fmt:parseDate value='${cart.fromDt}${cart.fromTm}' var='fromDttm' pattern="yyyyMMddHHmm" scope="page"/>
                                                                                                    <fmt:parseDate value='${cart.toDt}${cart.toTm}' var='toDttm' pattern="yyyyMMddHHmm" scope="page"/>
                                                                                                    <fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd HH:mm"/> ~
                                                                                                    <fmt:formatDate value="${toDttm}" pattern="yyyy-MM-dd HH:mm"/>
                                                                                                </li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="order_prd_price sub_item_price">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <input type="hidden" name="cartTotalAmt" value="${cart.totalAmt}">
                                                                                                <dt class="skip">총금액가
                                                                                                </dt>
                                                                                                <dd>
                                                                                                    <c:if test="${cart.totalAmt == '-2'}">
                                                                                        <span class="nt impossible">
                                                                                            <img src="/images/web/cart/info.png" alt="">
                                                                                            상품정보 변경으로 예약불가입니다 <br>옵션을 다시 선택해주세요
                                                                                        </span> </c:if>
                                                                                                    <c:if test="${cart.totalAmt != '-2'}">
                                                                                                        <i class="number">
                                                                                                            <fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber> </i> 원
                                                                                                    </c:if>
                                                                                                </dd>

                                                                                            </div>
                                                                                        </dl>
                                                                                    </div>
                                                                                    <div class="order_pick">
                                                                                        <a class="order_btn type2"
                                                                                           href="javascript:fn_Reservation(${cart.cartSn});"> <span>즉시예약</span>
                                                                                        </a>
                                                                                    </div>
                                                                                    <button type="button" class="bt_del"
                                                                                            onclick="fn_DelCart('selDel',${cart.cartSn});">
                                                                                        <i class="order_btn_remove ">삭제하기</i>
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                    </c:when> </c:choose> </c:forEach>
                                                            <!-- 기본케이스/관광상품 주문합계 -->
                                                            <div class="order_cart_total_price">
                                                                <div class="sub-price">
                                                                    <div class="applicable">
                                                                        <span class="sale">할인</span> 예약페이지에서 할인쿠폰 선택하기 확인
                                                                    </div>
                                                                    <div class="order_total_price">
                                                                        <h5 class="title">관광상품 예약합계</h5>
                                                                        <div class="price_detail">
                                                                            <dl>
                                                                                <div class="total_price">
                                                                                    <strong> <i id="totalJumunAmt" class="number">0</i> 원</strong>
                                                                                </div>
                                                                            </dl>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="order_button">
                                                                    <button class="select btn_order"
                                                                            onclick="fn_Reservation('')">예약하기
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </ul>
                                                    </div>
                                                </section>
                                            </div>
                                        </c:if>
                                        <!-- 제주특산품 (상품없을 시 통으로 삭제) -->
                                        <c:if test="${sv_cartSize > 0}">
                                            <div id="svCartWrap" class="order_cart_wrap">
                                                <div class="cart-section">
                                                    <h4 class="title">
                                                        특산/기념품
                                                    </h4>
                                                    <div class="order_cart_top">
                                                        <button type="button" class="btn_remove_selected" onclick="fn_SvDelCart('chkDel','','');">
                                                            선택삭제
                                                        </button>
                                                    </div>
                                                </div>
                                                <section id="sv_cartList" class="item-list open" attr-value="1">
                                                    <div class="order_store">
                                                        <input type="checkbox" id="sv_all_check" checked="checked">
                                                        <label class="order_checkbox_part" for="sv_all_check"></label>
                                                        <ul class="title">
                                                            <li class="img-domain">이미지</li>
                                                            <li class="division">구분</li>
                                                            <li class="info">상품정보</li>
                                                            <li class="sum">금액</li>
                                                            <li class="shipping_fee">배송비</li>
                                                            <li class="remark">비고</li>
                                                        </ul>
                                                        <div class="store_name">
                                                                <span>
                                                                    <a href=""></a>
                                                                </span>
                                                        </div>
                                                    </div>
                                                    <div class="order_cart_list half">
                                                        <ul id="sv_cartTbody">

                                                            <c:set var="sv_dlvAmtDiv" value="NULL"/>
                                                            <c:set var="sv_corpId" value="NULL"/>
                                                            <c:set var="group_key" value="1"/>
                                                            <c:set var="sv_prdc" value="NULL"/>

                                                            <c:forEach var="cart" items="${cartList}" varStatus="status">
                                                                <c:choose>
                                                                    <c:when test="${fn:substring(cart.prdtNum, 0, 2) eq Constant.SV}">
                                                                        <c:set var="sv_dlvAmt" value="0"/>
                                                                        <c:set var="imgPath" value="${cart.imgPath eq '' ? '/images/web/cart/no-image.png':cart.imgPath}"/><!--NO Image 처리-->

                                                                        <input type="hidden" name="svCart" value="${cart.cartSn}"/>
                                                                        <input type="hidden" name="${cart.cartSn}_prdtNum" value="${cart.prdtNum}"/>
                                                                        <input type="hidden" name="${cart.cartSn}_optSn" value="${cart.svOptSn}"/>
                                                                        <input type="hidden" name="${cart.cartSn}_divSn" value="${cart.svDivSn}"/>

                                                                        <li class="select">
                                                                            <input type="hidden" name="cartSn" value="${cart.cartSn}">
                                                                            <input type="checkbox" class="ch" name="sv_chk" data-index="${status.count}" id="chk${cart.cartSn}" value="${cart.cartSn}"
                                                                                   <c:if test="${cart.totalAmt != '-2'}">checked="checked"</c:if>>
    <%--                                                                        <label for="chk${cart.cartSn}"></label>--%>
                                                                            <label class="order_checkbox_part" for="chk${cart.cartSn}"></label>
                                                                            <div class="cart_info_box">
                                                                                <div class="order_prd_row">
                                                                                    <div class="cart_thumb_box">
                                                                                <span class="order_thumb">
                                                                                    <img src="${imgPath}" alt="" >
                                                                                </span>
                                                                                    </div>
                                                                                    <!-- 구분 -->
                                                                                    <div class="order_prd_price item_qty_wrap">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <dt class="skip">구분</dt>
                                                                                                <dd>
                                                                                                    <i class="division">특산/기념품</i>
                                                                                                </dd>
                                                                                            </div>
                                                                                        </dl>
                                                                                    </div> <!-- //구분 -->
                                                                                    <div class="left order_prd">
                                                                                        <div class="product prd_name">
                                                                                                <span class="cProduct">
                                                                                                    [${cart.corpNm}] ${cart.prdtNm}<span class="nt" id="nt${cart.cartSn}" style="display:none;">주문불가</span>
                                                                                                </span>
                                                                                        </div>
                                                                                        <div class="order_prd_option">
                                                                                            <ul class="infoText">
                                                                                                <li>${cart.prdtDivNm} | ${cart.optNm}
                                                                                                    <c:if test="${not empty cart.addOptNm}"> | ${cart.addOptNm}</c:if></li>
                                                                                                <li>수량 : ${cart.qty}</li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="order_prd_price">
                                                                                        <input type="hidden" name="sv_cartTotalAmt" value="${cart.totalAmt}">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <dt class="skip">총금액가</dt>
                                                                                                <dd>
                                                                                                    <c:if test="${cart.totalAmt == '-2'}">
                                                                                                        <span class="nt impossible">
                                                                                                            <img src="/images/web/cart/info.png" alt="">
                                                                                                            상품정보 변경으로 예약불가입니다 <br>옵션을 다시 선택해주세요
                                                                                                        </span>
                                                                                                    </c:if>
                                                                                                    <c:if test="${cart.totalAmt != '-2'}">
                                                                                                        <i class="number"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber> </i> 원
                                                                                                    </c:if>
                                                                                                </dd>
                                                                                            </div>
                                                                                        </dl>
                                                                                    </div>

                                                                                    <!-- 배송비 노출 -->
                                                                                    <div class="order_prd_price delivery---table" id="shipping_fee${status.count}">
                                                                                        <dl class="price_box">
                                                                                            <div class="total_price">
                                                                                                <dt class="skip"></dt>
                                                                                                <dd>
                                                                                                    <c:choose>
                                                                                                        <%--생산자별 묶음배송으로 로직 변경 (prdc 조건 추가) 2021.06.03 chaewan.jung --%>
                                                                                                        <c:when test="${(cart.corpId ne sv_corpId) or ((cart.corpId eq sv_corpId) and ((cart.dlvAmtDiv ne sv_dlvAmtDiv) or (cart.directRecvYn ne sv_directRecvYn) or (cart.prdc ne sv_prdc) )) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI)}">
                                                                                                            <c:set var="group_key" value="${group_key + 1}"/>
                                                                                                            <c:set var="c_row" value="0"/>
                                                                                                            <c:set var="c_SaleAmt" value="0"/>
                                                                                                            <%--조건부무료 or 무료 or 기본 배송비 일 경우 --%>
                                                                                                            <c:if test="${(cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV)}">
                                                                                                                <c:forEach var="sub_cart" items="${cartList}" varStatus="sub_status">
                                                                                                                    <c:if test="${(fn:substring(sub_cart.prdtNum, 0, 2) eq Constant.SV) and (sub_cart.corpId eq cart.corpId) and (sub_cart.dlvAmtDiv eq cart.dlvAmtDiv) and (sub_cart.directRecvYn eq cart.directRecvYn) and (sub_cart.prdc eq cart.prdc)}">
                                                                                                                        <c:set var="c_row" value="${c_row + 1}"/>
                                                                                                                        <c:set var="c_SaleAmt" value="${c_SaleAmt + sub_cart.totalAmt}"/>
                                                                                                                    </c:if>
                                                                                                                </c:forEach>
                                                                                                            </c:if>
                                                                                                            <c:if test="${c_row > 1 }">
                                                                                                            <span class="bundle_label">
                                                                                                            <i class="label_text">묶음배송</i>
                                                                                                            </span>
                                                                                                            </c:if>
                                                                                                            <input type="hidden" data-row="${c_row}" name="sv_groupKey${group_key}" value="${cart.cartSn}"/>
                                                                                                            <span class="shipping_fee">
                                                                                                            <c:choose>
                                                                                                                <c:when test="${cart.directRecvYn == 'Y'}"> 무료<br>(직접수령) </c:when>
                                                                                                                <c:when test="${Constant.DLV_AMT_DIV_DLV eq cart.dlvAmtDiv}">
                                                                                                                    <c:set var="sv_dlvAmt" value="${cart.dlvAmt}"/>
                                                                                                                    <img src="/images/web/cart/plus.png" alt="" >
                                                                                                                    <i class="svDlvAmt" data-cartsn="${cart.cartSn}"><fmt:formatNumber>${cart.dlvAmt}</fmt:formatNumber></i> 원
                                                                                                                </c:when>
                                                                                                                <c:when test="${Constant.DLV_AMT_DIV_APL eq cart.dlvAmtDiv}">
                                                                                                                    <c:if test="${c_SaleAmt >= cart.aplAmt}"> 무료 </c:if>
                                                                                                                    <c:if test="${c_SaleAmt < cart.aplAmt}">
                                                                                                                        <c:set var="sv_dlvAmt" value="${cart.dlvAmt}"/>
                                                                                                                        <img src="/images/web/cart/plus.png" alt="" >
                                                                                                                        <i class="svDlvAmt" data-cartsn="${cart.cartSn}"><fmt:formatNumber>${cart.dlvAmt}</fmt:formatNumber></i> 원
                                                                                                                    </c:if>
                                                                                                                    <p class="txt---add">
                                                                                                                        <span class="free">배송</span><fmt:formatNumber>${cart.aplAmt}</fmt:formatNumber>원 이상 상품 <i>추가 주문시 무료배송</i>
                                                                                                                    </p>
                                                                                                                </c:when>
                                                                                                                <%--개별 배송비 로직 추가 2021.05.21 chaewan.jung--%>
                                                                                                                <c:when test="${Constant.DLV_AMT_DIV_MAXI eq cart.dlvAmtDiv}">
                                                                                                                    <img src="/images/web/cart/plus.png" alt="" >
                                                                                                                    <i class="svDlvAmt" data-cartsn="${cart.cartSn}"><fmt:formatNumber>${cart.dlvAmt}</fmt:formatNumber></i> 원
                                                                                                                    <c:set var="sv_dlvAmt" value="${cart.dlvAmt}"/>
                                                                                                                    <%--<p class="txt---add">--%>
                                                                                                                    <%--<i>${cart.maxiBuyNum} 개당<fmt:formatNumber>${cart.outDlvAmt}</fmt:formatNumber>원</i>--%>
                                                                                                                    <%--</p>--%>
                                                                                                                </c:when>
                                                                                                                <c:when test="${Constant.DLV_AMT_DIV_FREE eq cart.dlvAmtDiv}"> 무료 </c:when>
                                                                                                            </c:choose>
                                                                                                            </span>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>
                                                                                                            <input type="hidden" data-row="${c_row}" name="sv_groupKey${group_key}" value="${cart.cartSn}"/>
                                                                                                            <span class="bundle_label">
                                                                                                                <i class="label_text">묶음배송</i>
                                                                                                            </span>
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>

                                                                                                </dd>

                                                                                            </div>
                                                                                        </dl>
                                                                                    </div>
                                                                                    <div class="order_pick">
                                                                                        <a class="order_btn type2"
                                                                                           href="javascript:fn_SvReservation(${cart.cartSn})">
                                                                                            <span>즉시구매</span> </a>
                                                                                        <a href="javascript:fn_ShowLayer('${cart.cartSn}','sv')"
                                                                                           class="btn2 room_option optionBT order_btn">
                                                                                            <span>옵션변경</span> </a>
                                                                                    </div>
                                                                                    <button type="button" class="bt_del"
                                                                                            onclick="fn_SvDelCart('selDel',${cart.cartSn},${status.count});">
                                                                                        <i class="order_btn_remove ">삭제하기</i>
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                        <!-- //배송비 노출 -->
                                                                        <input type="hidden" name="sv_dlvAmt" id="dlvAmt${group_key}" value="${sv_dlvAmt}">
                                                                       <c:set var="sv_corpId" value="${cart.corpId}"/>
                                                                       <c:set var="sv_dlvAmtDiv" value="${cart.dlvAmtDiv}"/>
                                                                       <c:set var="sv_directRecvYn" value="${cart.directRecvYn}"/>
                                                                       <c:set var="sv_prdc" value="${cart.prdc}"/>
                                                                    </c:when>
                                                                </c:choose>
                                                            </c:forEach>
                                                            <input type="hidden" id="lastGroupKey" name="lastGroupKey"
                                                                   value="${group_key}"/>
                                                            <!-- 기본케이스/관광상품 주문합계 -->
                                                            <div class="order_cart_total_price">
                                                                <div class="sub-price">
                                                                    <div class="applicable">
                                                                        <span class="sale">할인</span> 구매페이지에서 할인쿠폰 선택하기 확인
                                                                    </div>
                                                                    <div class="order_total_price">
                                                                        <h5 class="title">특산/기념품 구매합계</h5>
                                                                        <div class="price_detail">
                                                                            <dl> 상품구매 <strong id="sv_totalPrdtAmt">0</strong></dl>
                                                                            원 ＋
                                                                            <dl> 배송비 <strong id="sv_totalDlvAmt">0</strong></dl>
                                                                            원 =
                                                                            <dl>
                                                                                <div class="total_price">
                                                                                    <strong> <i id="sv_totalJumunAmt" class="number">0</i>원</strong>
                                                                                </div>
                                                                            </dl>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="order_button">
                                                                    <button class="select btn_order" onclick="fn_SvReservation('');">구매하기</button>
                                                                </div>
                                                            </div>
                                                        </ul>
                                                    </div>
                                                </section>
                                            </div>
                                            <!-- //table --> </c:if>
                                        <!-- //장바구니 목록 있을 시 -->
                                    </div><!-- a_order_content -->
                                    </c:if>
                                          <!-- 장바구니 목록 없을 시 -->
                                    <div id="emptyCart" class="cart-section"
                                         <c:if test="${not empty cartList}">style="display:none;"</c:if>>
                                        <table class="commCol product-info">
                                            <tr>
                                                <td class="no-content">
                                                    <img src="/images/web/cart/mark.png" alt="빈 장바구니">
                                                    <p>장바구니에 담긴 상품이 없습니다.</p>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                          <!-- //장바구니 목록 없을 시 -->

                                          <!-- 옵션변경 -->
                                    <div class="option-wrap" style="display:none;">
                                    </div>

                                </div><!-- //order_content_wrap -->
                            </div><!-- //order_select -->
                        </div><!--//comm_pay-->
                    </div><!-- //inner -->
                </div><!-- //bgWrap2 -->
            </div><!-- //cart -->
        </div><!-- //subContents -->
    </div><!-- //subContainer -->
</main>

<jsp:include page="/web/foot.do"></jsp:include>

</body>
</html>