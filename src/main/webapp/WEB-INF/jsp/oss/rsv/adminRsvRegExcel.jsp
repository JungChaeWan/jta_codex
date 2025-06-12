<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant"/>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Content-Type" content="text/html" charset="utf-8"/>
    <meta http-equiv="Cache-Control" content="no-cache; no-store; no-save"/>

    <script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>"/>

    <title></title>
</head>
<body>
<div id="wrapper">
    <jsp:include page="/oss/head.do?menu=rsv"/>
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=rsv&sub=adminRsvReg"/>
        <div id="contents_area">
            <div id="contents">
                <!--본문-->
                <!--상품 목록-->
                <ul class="form_area">
                    <li>
                        <div class="line2">
                            <form name="frmRsv" id="frmRsv" onSubmit="return false;">
                            <input type="hidden" name="groupNo" value="${groupNo}">
                            <article class="payArea userWrap1">
                                <h5 class="title">1. 예약 구분</h5>
                                <select id="corpDiv" name="corpDiv" onchange="fn_CorpDiv_Change();">
                                    <option value="SV" <c:if test="${corpDiv eq 'SV'}">selected</c:if>>특산/기념품</option>
                                    <option value="SP" <c:if test="${corpDiv eq 'SP'}">selected</c:if>>관광지/레저,체험,맛집</option>
                                    <option value="AD" <c:if test="${corpDiv eq 'AD'}">selected</c:if>>숙소</option>
                                </select>
                            </article>
                            </form>
                        </div>
                    </li>
                    <li>
                        <div class="line2">
                            <article class="payArea userWrap1">
                                <h5 class="title">2. 구매 정보 업로드</h5>
                                <form id="form1" name="form1" method="POST" enctype="multipart/form-data" action ="/oss/adminRsvRegExcelUp.do">
                                    <input type="file" id="excelUpFile" name="excelUpFile">
                                    <input type="hidden" name="corpDiv" value="${corpDiv}">
                                    <p class="btn_sty01"><a href="javascript:void(0)" onclick="fn_Admin_Rsv_Excelup();">업로드</a></p>
                                    <p class="btn_sty01"><a href="/oss/adminRsvRegExcel.do?groupNo=${lastGroupNo}&corpDiv=${corpDiv}">마지막 업로드 불러오기</a></p>
                                </form>
                            </article>
                        </div>
                    </li>
                    <c:if test="${allCnt > 0}">
                    <li>
                        <div class="line2">
                            <article class="payArea userWrap1">
                                <h5 class="title">3. 네이버 <-> 탐나오 매핑(신규상품이 아닐경우, 상품코드 개발자에게 확인필요)</h5>
                            </article>
                        </div>
                        <div class="list">
                            <form name="matchForm" id="matchForm">
                            <input type="hidden" name="groupNo" value="${groupNo}">
                            <table width="40%" border="1" cellspacing="0" cellpadding="0" class="list_tb">
                                <tr>
                                    <td>
                                    <select name="sPrdtOptNm">
                                        <c:forEach var="selNm" items="${sPrdtOptNmList}" varStatus="stauts">
                                        <option>${selNm.sPrdtOptNm}</option>
                                        </c:forEach>
                                    </select>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="align_ct">
                                        상품코드 : <input type="text" name="prdtNum"> <br />
                                        옵션구분코드 :
                                        <select name="divSn">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                        <br />
                                        옵션코드 :
                                        <select name="optSn">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>

                                        </select>
                                        <br />
                                        추가옵션 코드 :
                                        <select name="addOptSn">
                                            <option value="">선택</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                        </select><br />
                                        배송비 : <input type="text" name="dlvAmt" value="0" onkeydown="return fn_checkNumber3(event)" > <br />
                                        결제구분 :
                                        <select name="payDiv">
                                        <option value="">선택</option>
                                        <option value="N210" selected>라이브커머스</option>
                                        <option value="N200">스마트스토어</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr><td><p class="btn_sty04"><a href="javascript:void(0)" onclick="fn_Admin_Rsv_Match();">매핑</a></p></td></tr>
                            </table>
                            </form>
                        </div>
                    </li>
                    </c:if>
                    <li>
                        <p class="search_list_ps">3-1. 검증 완료:<strong>${verifyCnt}</strong>건 / 엑셀 업로드:<strong>${allCnt}</strong>건</p>
                        <div class="list">
                            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
                                <colgroup>
                                    <col width="250" />
                                    <col width="*" />
                                    <col width="250" />
                                    <col width="150" />
                                    <col width="150" />
                                    <col width="300" />
                                    <col width="100" />
                                    <col width="80" />
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>네이버 상품명</th>
                                    <th>탐나오 상품명</th>
                                    <th>상품금액</th>
                                    <th>구매자</th>
                                    <th>수취인</th>
                                    <th>배송지</th>
                                    <th>결제구분</th>
                                    <th>예약완료_YN</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- 데이터 없음 -->
                                <c:if test="${fn:length(resultList) == 0}">
                                    <tr>
                                        <td colspan="8" class="align_ct">검증 된 데이터가 없습니다.</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="rsvInfo" items="${resultList}" varStatus="stauts">
                                    <tr>
                                        <td class="align_lt">
                                            <p> <c:out value="${rsvInfo.sPrdtOptNm}"/></p>
                                        </td>
                                        <td class="align_lt">
                                            <p> <c:out value="${rsvInfo.corpNm}"/></p>
                                            <p class="product"><strong><c:out value="${rsvInfo.prdtNm}"/></strong></p>
                                            <p class="infoText">${rsvInfo.prdtDivNm} ${rsvInfo.optNm} | ${rsvInfo.addOptNm}</p>
                                        </td>
                                        <td class="align_rt">
                                            <div class="price-wrap">
                                                <p>
                                                    <span class="text">구매금액</span>
                                                    <span class="price"><fmt:formatNumber>${rsvInfo.saleAmt}</fmt:formatNumber>원</span>
                                                </p>
                                                <p>
                                                    <span class="text">(+)&nbsp;추가옵션비</span>
                                                    <span class="price"><fmt:formatNumber>${rsvInfo.addOptAmt}</fmt:formatNumber>원</span>
                                                </p>
                                                <p>
                                                    <span class="text">(x)&nbsp;구매수량</span>
                                                    <span class="price"><fmt:formatNumber>${rsvInfo.buyNum}</fmt:formatNumber>개</span>
                                                </p>
                                                <p>
                                                    <span class="text">(+) 배송비</span>
                                                    <span class="price"><fmt:formatNumber>${rsvInfo.dlvAmt}</fmt:formatNumber>원</span>
                                                </p>
                                                <p class="total">
                                                    <span class="text"><strong>결제금액</strong></span>
                                                    <span class="price font03"><fmt:formatNumber>${((rsvInfo.saleAmt+rsvInfo.addOptAmt) * rsvInfo.buyNum) + rsvInfo.dlvAmt}</fmt:formatNumber>원</span>
                                                </p>
                                            </div>
                                        </td>
                                        <td class="align_ct">
                                            <p><c:out value='${rsvInfo.rsvNm}'/></p>
                                            <p>(<c:out value='${rsvInfo.rsvTelnum}'/>)</p>
                                        </td>
                                        <td class="align_ct">
                                            <p><c:out value='${rsvInfo.useNm}'/></p>
                                            <p>(<c:out value='${rsvInfo.useTelnum}'/>)</p>
                                        </td>
                                        <td class="align_lt">
                                            <p><c:out value='${rsvInfo.postNum}'/></p>
                                            <p><c:out value='${rsvInfo.roadNmAddr}'/> <c:out value='${rsvInfo.dtlAddr}'/>
                                        </td>
                                        <td class="align_ct">
                                            <c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_SI}">스마트스토어</c:if>
                                            <c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_LI}">라이브커머스</c:if>
                                        </td>
                                        <td class="align_ct">
                                           ${rsvInfo.rsvCompleteYn}
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </li>
                </ul>
                <!--//상품목록-->
                <!--//본문-->
                <ul class="btn_rt01">
                    <li class="btn_sty01"><a href="javascript:void(0)" onclick="fn_ListRsv();">목록</a></li>
                    <li class="btn_rt01 btn_sty03"><a href="javascript:fn_RsvConfirm();" onclick="">4. 예약하기</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!--//Contents 영역-->
</div>
<script type="text/javascript">
    /* 중복 SUBMIT 방지 */
    var doubleSubmitFlag = false;

    function doubleSubmitCheck() {
        if(doubleSubmitFlag) {
            return doubleSubmitFlag;
        } else {
            doubleSubmitFlag = true;
            return false;
        }
    }

    //업로드 -> Table저장
    function fn_Admin_Rsv_Excelup(){
        var fileInput = document.getElementById('excelUpFile');
        var file = fileInput.files[0];

        if (!file) {
            alert('엑셀파일을 선택 해주세요.');
            return;
        }

        if (file.name.indexOf('.xlsx') > 0 || file.name.indexOf('.xls') > 0) {
            // Check file size (1MB = 1048576 bytes)
            if (file.size > 500 * 1024) {
                alert('파일 크기는 500KB 이하로 제한됩니다.');
                return;
            }

            document.form1.submit();
        } else {
            alert('엑셀파일을 선택 해주세요.');
            return;
        }
    }

    //매칭시키기
    function fn_Admin_Rsv_Match(){
        $.ajax({
            type: "post",
            url: "/oss/adminRsvMatch.ajax",
            data : $("#matchForm").serialize(),
            success:function (){
                location.reload();
            },
            error : fn_AjaxError
        });
    }

    //예약하기
    function fn_RsvConfirm() {
        if(doubleSubmitFlag) {
            return;
        }

        if("${allCnt}" != "${verifyCnt}"){
            alert("엑셀 업로드 Data와 검증 된 Data 개수가 다릅니다.\n 검증 후 다시 예약 하세요.");
            return;
        }

        if("${allCnt}" <= "0" ){
            alert("엑셀 Data를 업로드 해 주세요.");
            return;
        }

        doubleSubmitCheck();

        document.frmRsv.action = "<c:url value='/oss/adminRsvRegExcelOrder.do'/>";
        document.frmRsv.submit();
    }

    //예약구분 변경
    function fn_CorpDiv_Change(){
        document.frmRsv.action = "<c:url value='/oss/adminRsvRegExcel.do'/>";
        document.frmRsv.submit();
    }
</script>
</body>
</html>