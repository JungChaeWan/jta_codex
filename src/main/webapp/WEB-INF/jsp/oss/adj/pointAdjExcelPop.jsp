<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

    <script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
    <title></title>
    <script type="text/javascript">
        $(document).ready(function() {

            const max_fields      = 20; //maximum input boxes allowed
            const wrapper         = $(".input_fields_wrap"); //Fields wrapper
            const add_button      = $(".add_field_button"); //Add button ID

            let x = 1; //text box count
            let availableAttributes = new Array();
            <c:forEach items="${resultList}" var="item">
                availableAttributes.push("${item.partnerCode}" + "|" + "${item.cpNm}");
            </c:forEach>

            $(add_button).click(function(e){ //on add input button click
                e.preventDefault();
                if(x < max_fields){ //max input box setting
                    x++; //text box count
                    $(wrapper).append('<div class="btn_lt01">&nbsp;<input type="text" name="couponText" style="width: 550px"/><a href="#" class="remove_field">삭제</a></div>');

                    $(wrapper).find('input[type=text]:last').autocomplete({
                        source: availableAttributes
                    });
                    //add input box
                }
            });

            $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
                e.preventDefault(); $(this).parent('div').remove(); x--;
            })

            $("input[name^='couponText']").autocomplete({
                source: availableAttributes
            });

        });

        function fn_ExcelDown(){
            document.frm.action = "<c:url value='/oss/adjustExcelDown6.do' />";
            document.frm.target = "frmFileDown";
            document.frm.submit();
        }

        function fn_DtlExcelDown(){
            document.frm.action = "<c:url value='/oss/adjustExcelDown7.do' />";
            document.frm.target = "frmFileDown";
            document.frm.submit();

        }        
    </script>
</head>
<body style="overflow-x: hidden">
<div id="wrapper">
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <div id="contents_area">
            <div id="contents">
                <form name="frm" method="post" target="frmFileDown">
                <div class="input_fields_wrap">
                    <div class="btn_sty03 add_field_button  btn_rt01" ><a href="#">쿠폰추가</a></div><br/>
                    <div class="btn_lt01">&nbsp;<input type="text" name="couponText" style="width: 598px;"></div>
                </div>
                <input type="hidden" name="sAdjDt" value="${searchVO.sAdjDt}" />
                <input type="hidden" name="sFromYear" value="${searchVO.sFromYear}" />
                <input type="hidden" name="sFromMonth" value="${searchVO.sFromMonth}" />
                <input type="hidden" name="sOrder" value="CORP_NM" />
                <input type="hidden" name="sDirection" value="ASC" />
                </form>
            </div>
        </div>
        <br/><br/>
        <div class="btn_ct01">
        <div class="btn_sty04" ><a href="javascript:fn_ExcelDown();">엑셀다운로드(업체별)</a></div>
        <c:if test="${empty searchVO.sFromYear}">
        <div class="btn_sty04" ><a href="javascript:fn_DtlExcelDown();">엑셀다운로드(건별)</a></div>
        </c:if>
        </div>
    </div>
</div>
<style>
    .ui-helper-hidden-accessible {
        display: none;
    }

    .ui-state-focus {
        background-color: #ffa8a8 !important;
        border: none !important;}


    .ui-menu{
        background-color: #ffffff !important;
    }

</style>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>