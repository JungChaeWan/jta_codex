<!DOCTYPE html>
<html lang="ko">
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
<head>

    <jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main4.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/layerPopup.css'/>" />


<style>


    .wrap {
        position: absolute;
        top: 50%;
        margin-top: -530px;
        margin-left: 200px;
        text-align: center;
    }

    a {
        -webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
        -moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
        -ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
        -o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
        transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);

        margin: 20px auto;
        max-width: 180px;
        text-decoration: none;
        border-radius: 4px;
        padding: 38px 45px;
    }

    a.button {
        color: rgba(30, 22, 54, 0.6);
        box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
    }

    a.button:hover {
        color: rgba(255, 255, 255, 0.85);
        box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
    }

</style>
</head>
<body>

<main id="main">
    <div class="mapLocation">
        <div class="inner">
            <span>TL Lincoln Booking TEST</span>
        </div>
    </div>

    <form name="frm" id="frm" method="post">
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents" style="margin-left: 200px">

            <div class="bdList">
                <table class="commCol notice-list">
                    <thead>
                    <tr>
                        <th class="title1" style="width: 200px">전송구분</th>
                        <td style="width: 10px;"></td>
                        <td class="title2">
                            <input type="radio" name="rdoRsvStatus" value="Start"  id="status1" checked="checked"><label for="status1">예약</label> &nbsp;&nbsp;
                            <input type="radio" name="rdoRsvStatus" value="End" id="status2"><label for="status2">취소</label>

                        </td>
                    </tr>
                    <tr>
                        <th class="title1" id="rsvNumText">예약 번호(RSV_NUM)</th>
                        <td></td>
                        <td class="title2"><input type="text" name="rsvNum" id="rsvNum" placeholder="예약번호 입력"></td>
                    </tr>
                    <tr>
                        <th class="title1">최종결과</th>
                        <td></td>
                        <td class="title2" id="finalResut"></td>
                    </tr>
                    <tr>
                        <td class="title1"></td>
                        <td></td>
                        <td class="title2">
                            <div class="wrap" id="btnSend">
                                <a href="javascript:sendBooking();" class="button">예약전송</a>
                            </div>
                        </td>
                    </tr>
                    </thead>
                </table>

                <table class="commCol notice-list" style="margin-top:80px">

                    <thead>
                    <tr>
                        <td colspan="2"><a href="https://prettydiff.com/?m=beautify" target="_blank">xml 태그 정렬 사이트 바로가기</a></td>
                    </tr>
                    <tr>
                        <th>성공여부</th>
                        <th id="rsvResult0"></th>
                    </tr>
                    <tr>
                        <th class="title1" style="width: 400px">
                            Send XML
                            <a name="copySendXml0" id="copySendXml0" >(copy)</a>
                        </th>
                        <th class="title2" style="width: 400px">
                           Return XML
                            <a name="copyRetrunXml0" id="copyReturnXml0" >(copy)</a>
                        </th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td style="vertical-align: top">
                            <textarea  id="sendXml0" rows="5"></textarea>
                        </td>
                        <td style="vertical-align: top">
                            <textarea  id="returnXml0" rows="5"></textarea>
                        </td>
                    </tr>
                    </tbody>

                </table>
                <table class="commCol notice-list" style="margin-top:80px">
                    <thead>
                    <tr>
                        <th>성공여부</th>
                        <th id="rsvResult1"></th>
                    </tr>
                    <tr>
                        <th class="title1" style="width: 400px">
                            Send XML
                            <a name="copySendXml1" id="copySendXml1" >(copy)</a>
                        </th>
                        <th class="title2" style="width: 400px">
                            Return XML
                            <a name="copyRetrunXml1" id="copyReturnXml1" >(copy)</a>
                        </th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td style="vertical-align: top">
                            <textarea  id="sendXml1" rows="5"></textarea>
                        </td>
                        <td style="vertical-align: top">
                            <textarea  id="returnXml1" rows="5"></textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <table class="commCol notice-list" style="margin-top:80px">
                    <thead>
                    <tr>
                        <th>성공여부</th>
                        <th id="rsvResult2"></th>
                    </tr>
                    <tr>
                        <th class="title1" style="width: 400px">
                            Send XML
                            <a name="copySendXml2" id="copySendXml2" >(copy)</a>
                        </th>
                        <th class="title2" style="width: 400px">
                            Return XML
                            <a name="copyRetrunXml2" id="copyReturnXml2" >(copy)</a>
                        </th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td style="vertical-align: top">
                            <textarea  id="sendXml2" rows="5"></textarea>
                        </td>
                        <td style="vertical-align: top">
                            <textarea  id="returnXml2" rows="5"></textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
    </form>
</main>
<script type="text/javascript">

    //예약
    function sendBooking(){
        const parameters = "rdoRsvStatus=Start&rsvNum="+$("#rsvNum").val();
        $.ajax({
            type:"post",
            url:"<c:url value='/api/tl/bookingSend.ajax'/>",
            data:parameters ,
            success:function(data){
                //console.log(data.bookingLogVO);
                let fail = true;
                for (let i=0; i<data.bookingLogVO.length;i++) {
                    $("#sendXml"+i).text(data.bookingLogVO[i].rsvXml);
                    $("#returnXml"+i).text(data.bookingLogVO[i].returnXml);
                    $("#rsvResult"+i).text(data.bookingLogVO[i].rsvResult + " (" + data.bookingLogVO[i].faultReason + ")");

                    if(data.bookingLogVO[i].rsvResult == "N" ){
                        fail = false;
                    }
                }

                if (fail){
                    $("#finalResut").text("성공");
                }else {
                    $("#finalResut").text("실패");
                }

            },
            error:fn_AjaxError
        });
    }

    //취소
    function cancelBooking(){
        const parameters = "rdoRsvStatus=End&adRsvNum="+$("#rsvNum").val();
        $.ajax({
            type:"post",
            url:"<c:url value='/api/tl/bookingCancel.ajax'/>",
            data:parameters ,
            success:function(data){
                console.log(data);
                $("#sendXml0").text(data.bookingLogVO.rsvXml);
                $("#returnXml0").text(data.bookingLogVO.returnXml);
                $("#rsvResult0").text(data.bookingLogVO.rsvResult + " (" + data.bookingLogVO.faultReason + ")");

                if (data.bookingLogVO.rsvResult == "Y"){
                    $("#finalResut").text("성공");
                }else {
                    $("#finalResut").text("실패");
                }
            },
            error:fn_AjaxError
        });
    }

    $( "#copySendXml0" ).click(
        function() {
            const urlbox = document.getElementById( 'sendXml0' );
            urlbox.select();
            document.execCommand( 'Copy' );
        }
    );

    $( "#copyReturnXml0" ).click(
        function() {
            const urlbox = document.getElementById( 'returnXml0' );
            urlbox.select();
            document.execCommand( 'Copy' );
        }
    );

    $(document).ready(function(){
        $('input[name="rdoRsvStatus"]').change(function(){
            if ($(this).val() == "Start"){
                $("#rsvNumText").text("예약 번호(RSV_NUM)");
                $("#btnSend").html(
                    '<a href="javascript:sendBooking();" class="button">예약전송</a>'
                );
            }else{
                $("#rsvNumText").text("숙소 예약 번호(AD_RSV_NUM)");
                $("#btnSend").html(
                    '<a href="javascript:cancelBooking();" class="button">취소전송</a>'
                );
            }
        });
    })


</script>


</body>
</html>