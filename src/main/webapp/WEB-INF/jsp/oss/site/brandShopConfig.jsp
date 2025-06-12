<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

    <script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/common.js?version=${nowDate}'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.minicolors.min.js'/>"></script>

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery.minicolors.css'/>" />

    <title></title>

    <script type="text/javascript">
        var urlPrdtIndex = "${fn:length(mainUrlList)}";
        var areaPrdtIndex = "${fn:length(mainAreaList)}";
        var ctgrRcmdndex = 0;
        var brandSetIndex = "${fn:length(mainBrandSet)}";
        var prdtGubun = '';
        var ctgrFlag = false;
        var selSortClass = '';
        var prdtArray = Array('AD', 'RC', 'C200', 'C300', 'C100', 'SV');

        <%--function fn_viewSelectProduct(gubun, ctgr) {--%>
        <%--    prdtGubun = gubun;--%>
        <%--    ctgrFlag = ctgr;--%>

        <%--    window.open("<c:url value='/oss/findPrdt.do?sPrdtCd=" + gubun + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewSelectSoProduct(gubun, ctgr) {--%>
        <%--    prdtGubun = gubun;--%>
        <%--    ctgrFlag = ctgr;--%>

        <%--    window.open("<c:url value='/oss/findSpPrdt.do?sCtgr=" + gubun + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewSelectSvProduct(ctgr) {--%>
        <%--    prdtGubun = 'SV';--%>
        <%--    ctgrFlag = ctgr;--%>

        <%--    window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewSelectPrmtProduct() {--%>
        <%--    window.open("<c:url value='/oss/findPrmt.do?prmtDiv=${Constant.PRMT_DIV_PLAN}'/>","findPrdt", "width=1000, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewSelectKwaProduct() {--%>
        <%--    prdtGubun = "Url";--%>

        <%--    window.open("<c:url value='/oss/findKwa.do'/>","findPrdt", "width=1000, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewSelectMdsProduct() {--%>
        <%--    prdtGubun = "Url";--%>

        <%--    window.open("<c:url value='/oss/mdsPickListFind.do'/>","findPrdt", "width=1000, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewAdSelectProduct(area) {--%>
        <%--    prdtGubun = area;--%>

        <%--    window.open("<c:url value='/oss/findPrdt.do?sPrdtCd=AD&sAreaCd=" + area + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>

        <%--function fn_viewSelectSpProduct(area, ctgr) {--%>
        <%--    prdtGubun = area;--%>

        <%--    window.open("<c:url value='/oss/findSpPrdt.do?sCtgr=" + ctgr + "&sAreaCd=" + area + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");--%>
        <%--}--%>
        let corp_pop;
        function fn_viewSelectCorp() {
            corp_pop = window.open("<c:url value='/oss/findCorp.do?sCorpCd2=SV'/>","findCorp", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
        }

        // function fn_selectProduct(prdtId, corpNm, prdtNm, corpId) {
        //     if (prdtGubun == 'AD' || prdtGubun == 'RC' || prdtGubun == 'SV' || prdtGubun.indexOf('C') != -1) {
        //         fn_selectHotProduct(prdtId, corpNm, prdtNm);
        //     } else {
        //         fn_selectAreaProduct(prdtId, corpNm, prdtNm);
        //     }
        // }
        //
        // function fn_selectHotProduct(prdtId, corpNm, prdtNm) {
        //     var chckFlag = true;
        //     $('.selMainPrdtNum').each(function() {
        //         if ($(this).val() == prdtId) {
        //             chckFlag = false;
        //             /*return false;*/
        //         }
        //     });
        //
        //     var strHtml = "";
        //
        //     if (ctgrFlag == false) {
        //         strHtml = '<li>';
        //         strHtml += '[' + prdtId + '] [' + corpNm + '] [' + prdtNm + '] ';
        //         strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + ctgrRcmdndex + '].prdtDiv" value="' + prdtGubun + '"/>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + ctgrRcmdndex + '].prdtNum" value="' + prdtId + '"/>';
        //         strHtml += '</li>';
        //
        //         $("#select"+ prdtGubun + "Product ul").append(strHtml);
        //         ctgrRcmdndex++;
        //     } else {
        //         var chkPrdtFlag = false;
        //         // var ctgrSort = $('.ctgr' + prdtGubun + 'Sort').length + 1;
        //
        //         $('.selCtgrPrdtNum').each(function() {
        //             if ($(this).val() == prdtId) {
        //                 chkPrdtFlag = true;
        //                 return false;
        //             }
        //         });
        //
        //         if (chkPrdtFlag == false) {
        //             strHtml = '<li>';
        //             strHtml += '[' + prdtId + '] [' + corpNm + '] [' + prdtNm + '] ';
        //             strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
        //             strHtml += '<input type="hidden" name="mainCtgrRcmd[' + ctgrRcmdndex + '].prdtDiv" value="' + prdtGubun + '"/>';
        //             strHtml += '<input type="hidden" name="mainCtgrRcmd[' + ctgrRcmdndex + '].prdtNum" class="selCtgrPrdtNum" value="' + prdtId + '"/>';
        //             strHtml += '</li>';
        //
        //             $("#selectC"+ prdtGubun + "Product ul").append(strHtml);
        //             ctgrRcmdndex++;
        //         }
        //     }
        //
        // }

        // function fn_selectAreaProduct(prdtId, corpNm, prdtNm) {
        //     var chkPrdt = false;
        //
        //     $('.selAreaPrdtNum').each(function() {
        //         if ($(this).val() == prdtId) {
        //             chkPrdt = true;
        //             return false;
        //         }
        //     });
        //
        //     if (chkPrdt == false) {
        //         var strHtml = '<li>';
        //         strHtml += '[' + prdtId + '] [' + corpNm + '] [' + prdtNm + '] ';
        //         strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
        //         strHtml += '<input type="hidden" name="mainAreaPrdt[' + areaPrdtIndex + '].prdtDiv" class="areaPrdt" value="' + prdtId.substring(0, 2) + '"/>';
        //         strHtml += '<input type="hidden" name="mainAreaPrdt[' + areaPrdtIndex + '].areaDiv" value="' + prdtGubun + '"/>';
        //         strHtml += '<input type="hidden" name="mainAreaPrdt[' + areaPrdtIndex + '].prdtNum" class="selAreaPrdtNum" value="' + prdtId + '"/>';
        //         strHtml += '</li>';
        //
        //         $("#select"+ prdtGubun + "Product ul").append(strHtml);
        //         areaPrdtIndex++;
        //     }
        //
        // }

        // function fn_Select(prmtNum, prmtNm){
        //     var chkPrdt = false;
        //
        //     $('.selHotPrdtNum').each(function() {
        //         if ($(this).val() == prmtNum) {
        //             chkPrdt = true;
        //             return false;
        //         }
        //     });
        //
        //     if (chkPrdt == false) {
        //         var strHtml = '<li>';
        //         strHtml += '[' + prmtNum + '] [' + prmtNm + '] ';
        //         strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtDiv" value="PL"/>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtNum" class="selHotPrdtNum" value="' + prmtNum + '"/>';
        //         strHtml += '</li>';
        //
        //         $("#selectUrlProduct ul").append(strHtml);
        //         urlPrdtIndex++;
        //
        //     }
        // }

        // function fn_SelectKw(num, location, nm) {
        //     var chkPrdt = false;
        //
        //     $('.selHotPrdtNum').each(function() {
        //         if ($(this).val() == num) {
        //             chkPrdt = true;
        //             return false;
        //         }
        //     });
        //
        //     if (chkPrdt == false) {
        //         var strHtml = '<li>';
        //         strHtml += '[' + num + '] [' + location + '] [' + nm + '] ';
        //         strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtDiv" value="KW"/>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtNum" class="selHotPrdtNum" value="' + num + '"/>';
        //         strHtml += '</li>';
        //
        //         $("#selectUrlProduct ul").append(strHtml);
        //         urlPrdtIndex++;
        //     }
        // }

        // function fn_SelectMd(num, location, nm) {
        //     var chkPrdt = false;
        //
        //     $('.selHotPrdtNum').each(function() {
        //         if ($(this).val() == num) {
        //             chkPrdt = true;
        //             return false;
        //         }
        //     });
        //
        //     if (chkPrdt == false) {
        //         var strHtml = '<li>';
        //         strHtml += '[' + num + '] [' + location + '] [' + nm + '] ';
        //         strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtDiv" value="MD"/>';
        //         strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtNum" class="selHotPrdtNum" value="' + num + '"/>';
        //         strHtml += '</li>';
        //
        //         $("#selectUrlProduct ul").append(strHtml);
        //         urlPrdtIndex++;
        //     }
        // }

        function fn_Dummay(sortClass, curSort){
            if (sortClass != 'undefined') {
                $('.' + sortClass).each(function(index) {
                    if ($(this).attr('id') != $.selId) {
                        $(this).val(index+1);
                        $('#' + $(this).attr('id') + '_sort').val($(this).val());
                    }
                });
            }
        }

        // function fn_selSortClass(classNm) {
        //     selSortClass = classNm;
        // }


        function fn_selectCorp(corpId, corpNm, corpCd, corpAliasNm) {
            var chckFlag = false;

            $('.selBrandCorpNm').each(function() {
                if ($(this).val() == corpId) {
                    chckFlag = true;
                    return false;
                }
            });

            if(corpAliasNm == null || corpAliasNm == ""){
                corpAliasNm = corpNm;
            }

            let strHtml = "";
            if (chckFlag == false) {
                strHtml = '<li>';
                strHtml += '    <table class="table03" > ';
                strHtml += '        <tr>';
                strHtml += '            <td>';
                strHtml += '            </td>';
                strHtml += '            <td>';
                strHtml += '                [' + corpId + '] [' + corpNm + '] ';
                strHtml += '                <input type="text" name="mainBrandSet[' + brandSetIndex + '].corpAliasNm" value="' + corpAliasNm + '"/>';
                strHtml += '                <a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
                strHtml += '                <input type="hidden" name="mainBrandSet[' + brandSetIndex + '].corpId" class="selBrandCorpNm"  value="' + corpId + '"/>';
                strHtml += '                <input type="hidden" name="mainBrandSet[' + brandSetIndex + '].corpCd" value="' + corpCd + '"/>';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '        <tr>';
                strHtml += '            <td>로고이미지</td>';
                strHtml += '            <td>';
                strHtml += '                <input type="file" name="mainBrandSet[' + brandSetIndex + '].logoImg" >';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '        <tr>';
                strHtml += '            <td>카드이미지</td>';
                strHtml += '            <td>';
                strHtml += '                <input type="file" name="mainBrandSet[' + brandSetIndex + '].cardImg" >';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '        <tr>';
                strHtml += '            <td>카드 슬로건</td>';
                strHtml += '            <td>';
                strHtml += '                <input type="text" name="mainBrandSet[' + brandSetIndex + '].cardSlogan" class="input_text50" /><br/>';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '        <tr>';
                strHtml += '            <td>카드 제목</td>';
                strHtml += '            <td>';
                strHtml += '                <input type="text" name="mainBrandSet[' + brandSetIndex + '].cardTitle" class="input_text50"  /><br/>';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '        <tr>';
                strHtml += '            <td>카드 내용</td>';
                strHtml += '            <td>';
                strHtml += '                <textarea name="mainBrandSet[' + brandSetIndex + '].cardContent" cols="30" rows="4" maxlength="500" style="width: 510px">${rcmd.corpAliasNm }</textarea>';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '        <tr>';
                strHtml += '            <td>카드 색상</td>';
                strHtml += '            <td>';
                strHtml += '                <input type="text" class="cardColor" name="mainBrandSet[' + brandSetIndex + '].cardColor" style="height: 28px" data-control="hue" value="#ffffff" size="7"><br/>';
                strHtml += '            </td>';
                strHtml += '        </tr>';
                strHtml += '    </table>';
                strHtml += '</li>';

                $("#selectBrandProduct ul").prepend(strHtml);
                brandSetIndex++;
                // alert("추가 되었습니다.");
                // corp_pop.close();

            }
        }
        $(document).ready(function(){
            ctgrRcmdndex = $('.selCtgrPrdtNum').length;
            brandSetIndex = $('.selBrandCorpNm').length;

            $(".selectProduct").on("click", ".del", function(index) {
                $(this).parents("li").remove();
            });

            $(".selectLiProduct").on("click", ".del", function(index) {
                $(this).parents("li").remove();
            });

            // 출력 순서의 자동 정렬
            $('.printBrandtgr').change(function() {
                $.selSort = eval($(this).val());
                $.selId = $(this).attr('id');
                $.curVal = eval($('#' + $.selId + '_sort').val());

                if ($.selSort > $.curVal) {
                    $('.printBrandtgr').each(function() {
                        if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
                            $(this).val($(this).val() - 1);
                            $('#' + $(this).attr('id') + '_sort').val($(this).val());
                        }
                    });
                } else if ($.selSort < $.curVal) {
                    $('.printBrandtgr').each(function() {
                        if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
                            $(this).val(eval($(this).val()) + 1);
                            $('#' + $(this).attr('id') + '_sort').val($(this).val());
                        }
                    });
                }
                $('#' + $.selId + '_sort').val($(this).val());
            });

            $('.cardColor').each( function() {
                $(this).minicolors({});
            });
        });

        //동적 추가 된 리스트 처리
        $(document).on("mouseover",".cardColor",function(){
            $(this).minicolors({});
        });

        function fn_viewImg(getPath) {
            const imgPath = '/data/brand/'+getPath;
            window.open(imgPath, 'cardImg', 'width=600, height=400, scrollbars=yes, status=no, toolbar=no;')
        }
    </script>

</head>
<body>
<div id="wrapper">
    <jsp:include page="/oss/head.do?menu=site" />
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=site&sub=brandShop" />

        <div id="contents_area">
            <div id="contents">
                <h4 class="title03 margin-top45">브랜드 설정</h4>

                <form:form commandName="mainBrandList" name="brandFrm" method="post" action="/oss/actionBrandSet.do" enctype="multipart/form-data">
                    <table border="1" class="table02">
                        <colgroup>
                            <col width="200" />
                            <col width="*" />
                        </colgroup>
                        <c:set var="brandLength" value="${fn:length(mainBrandList) }" />
                        <tr>

                            <td>
                                <div class="btn_sty04">
                                    <span><a href="javascript:fn_viewSelectCorp();">업체 검색</a></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="selectBrandProduct" class="selectLiProduct">
                                    <ul>
                                        <c:forEach items="${mainBrandList}" var="rcmd" varStatus="status">
                                            <input type="hidden" id="${rcmd.corpId}_sort" class="ctgrBrandSort" value="${rcmd.printSn }" />
                                            <li>
                                                <table class="table03" >
                                                    <tr>
                                                        <td>
                                                            <select class="printBrandtgr" id="${rcmd.corpId}" name="mainBrandSet[${status.index }].printSn">
                                                            <c:forEach var="cnt" begin="1" end="${fn:length(mainBrandList) }">
                                                                <option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
                                                            </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            [${rcmd.corpId}] [${rcmd.corpNm}]
                                                            <input type="text" name="mainBrandSet[${status.index }].corpAliasNm"  value="${rcmd.corpAliasNm }"  />
                                                            <a href="javascript:fn_Dummay('printBrandtgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
                                                            <input type="hidden" name="mainBrandSet[${status.index }].corpId" class="selBrandCorpNm" value="${rcmd.corpId }"/>
                                                            <input type="hidden" name="mainBrandSet[${status.index }].corpCd" value="${rcmd.corpCd }"/>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>로고이미지</td>
                                                        <td>
                                                            <input type="file" name="mainBrandSet[${status.index }].logoImg">
                                                            <c:if test="${not empty rcmd.logoImgFileNm}">
                                                            기존 이미지 : ${rcmd.logoImgFileNm}
                                                            <button type="button" class="btn sm" onclick="fn_viewImg('${rcmd.logoImgFileNm}');">보기</button>
                                                            </c:if>
                                                            <input type="hidden" name="mainBrandSet[${status.index }].oldLogoImg" value="${rcmd.logoImgFileNm}">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>카드이미지</td>
                                                        <td>
                                                            <input type="file" name="mainBrandSet[${status.index }].cardImg">
                                                            <c:if test="${not empty rcmd.cardImgFileNm}">
                                                            기존 이미지 : ${rcmd.cardImgFileNm}
                                                            <button type="button" class="btn sm" onclick="fn_viewImg('${rcmd.cardImgFileNm}');">보기</button>
                                                            </c:if>
                                                            <input type="hidden" name="mainBrandSet[${status.index }].oldCardImg" value="${rcmd.cardImgFileNm}">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>카드 슬로건</td>
                                                        <td>
                                                            <input type="text" name="mainBrandSet[${status.index }].cardSlogan" class="input_text50" value="${rcmd.cardSlogan }"  /><br/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>카드 제목</td>
                                                        <td>
                                                            <input type="text" name="mainBrandSet[${status.index }].cardTitle" class="input_text50" value="${rcmd.cardTitle }"  /><br/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>카드 내용</td>
                                                        <td>
                                                            <textarea name="mainBrandSet[${status.index }].cardContent" cols="30" rows="4" maxlength="500" style="width: 510px">${rcmd.cardContent }</textarea>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>카드 색상</td>
                                                        <td>
                                                            <input type="text" class="cardColor" name="mainBrandSet[${status.index }].cardColor" style="height: 28px" data-control="hue" value="${rcmd.cardColor }" size="7"><br/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form:form>

                <ul class="btn_rt01 align_ct">
                    <li class="btn_sty04"><a href="javascript:document.brandFrm.submit();">적용</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>