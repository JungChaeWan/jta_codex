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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<title></title>

</head>
<body>

<!-- 숙소 상품 리스트 -->
<c:forEach items="${prdtAdList }" var="data">
&lt;&lt;&lt;begin&gt;&gt;&gt;</br>
&lt;&lt;&lt;mapid&gt;&gt;&gt;<c:out value="${data.prdtNum}"/></br>
&lt;&lt;&lt;pname&gt;&gt;&gt;<c:out value="${data.adNm}"/></br>
&lt;&lt;&lt;price&gt;&gt;&gt;<c:out value="${data.saleAmt}"/></br>
&lt;&lt;&lt;pgurl&gt;&gt;&gt;http://www.tamnao.com/web/ad/detailPrdt.do?pageIndex=1&orderCd=SALE&orderAsc=DESC&prdtNum=<c:out value="${data.prdtNum}"/>&sPrdtNum=<c:out value="${data.prdtNum}"/>&sFromDtView=<c:out value="${prdtAdSVO.sFromDtView}"/>&sFromDt=<c:out value="${prdtAdSVO.sFromDt}"/>&sNights=1&vNights=1</br>
&lt;&lt;&lt;mourl&gt;&gt;&gt;http://m.tamnao.com/mw/ad/detailPrdt.do?pageIndex=1&orderCd=SALE&orderAsc=DESC&prdtNum=<c:out value="${data.prdtNum}"/>&sPrdtNum=<c:out value="${data.prdtNum}"/>&sFromDtView=<c:out value="${prdtAdSVO.sFromDtView}"/>&sFromDt=<c:out value="${prdtAdSVO.sFromDt}"/>&sNights=1&vNights=1</br>
<!-- &lt;&lt;&lt;android_dp&gt;&gt;&gt;shoppingmall_androidapp://product/No=0000001 //안드로이드 앱 내 상품 링크</br>
&lt;&lt;&lt;ios_dp&gt;&gt;&gt; shoppingmall_iosapp://product/No=0000001 //iOS 앱 내 상품 링크</br> -->
&lt;&lt;&lt;igurl&gt;&gt;&gt;<c:out value="${data.savePath}thumb/${data.saveFileNm}"/></br>
&lt;&lt;&lt;cate1&gt;&gt;&gt;<c:out value="숙박"/></br>
&lt;&lt;&lt;cate2&gt;&gt;&gt;<c:out value="${adTypeMap[data.adDiv]}"/></br>
&lt;&lt;&lt;cate3&gt;&gt;&gt;<c:out value="${data.adAreaNm}"/></br>
<!-- &lt;&lt;&lt;cate3&gt;&gt;&gt;주방/청소세제 //카테고리명 (소분류)</br>
&lt;&lt;&lt;cate4&gt;&gt;&gt;주방세제 //카테고리명 (세분류)</br> -->
&lt;&lt;&lt;caid1&gt;&gt;&gt;<c:out value="AD"/></br>
&lt;&lt;&lt;caid2&gt;&gt;&gt;<c:out value="${data.adDiv}"/></br>
&lt;&lt;&lt;caid3&gt;&gt;&gt;<c:out value="${data.adArea}"/></br>
<!-- &lt;&lt;&lt;caid3&gt;&gt;&gt;A001B001C001 //카테고리ID (소분류)</br>
&lt;&lt;&lt;caid4&gt;&gt;&gt;A001B001C001D001 //카테고리ID (세분류)</br>
&lt;&lt;&lt;utime&gt;&gt;&gt;2017.03.29 15:40 //업데이트 시점</br>
&lt;&lt;&lt;selid&gt;&gt;&gt;430 //판매상품수</br>
&lt;&lt;&lt;deliv&gt;&gt;&gt;12 //베스트셀러 순위(상품판매순위)</br> -->
&lt;&lt;&lt;description&gt;&gt;&gt;<c:out value="${data.adSimpleExp}"/></br>
<!-- &lt;&lt;&lt;expire_time&gt;&gt;&gt;2017.03.29 15:40:01 //마감일(d-day 계산용)</br> -->
&lt;&lt;&lt;ftend&gt;&gt;&gt;</br>
</c:forEach>


<!-- 렌터카 상품 리스트 -->
<c:forEach items="${prdtRcList }" var="data">
&lt;&lt;&lt;begin&gt;&gt;&gt;</br>
&lt;&lt;&lt;mapid&gt;&gt;&gt;<c:out value="${data.prdtNum}"/></br>
&lt;&lt;&lt;pname&gt;&gt;&gt;<c:out value="${data.prdtNm}"/></br>
&lt;&lt;&lt;price&gt;&gt;&gt;<c:out value="${data.saleAmt}"/></br>
&lt;&lt;&lt;pgurl&gt;&gt;&gt;http://www.tamnao.com/web/rentcar/car-detail.do?pageIndex=1&orderCd=GPA&orderAsc=DESC&mYn=Y&prdtNum=<c:out value="${data.prdtNum}"/>&sFromDtView=<c:out value="${prdtRcSVO.sFromDtView}"/>&sFromDt=<c:out value="${prdtRcSVO.sFromDt}"/>&sFromTm=<c:out value="${prdtRcSVO.sFromTm}"/>&vFromTm=<c:out value="${prdtRcSVO.sFromTm}"/>&sToDtView=<c:out value="${prdtRcSVO.sToDtView}"/>&sToDt=<c:out value="${prdtRcSVO.sToDt}"/>&sToTm=<c:out value="${prdtRcSVO.sToTm}"/>&vToTm=<c:out value="${prdtRcSVO.sToTm}"/></br>
&lt;&lt;&lt;mourl&gt;&gt;&gt;http://m.tamnao.com/mw/rentcar/car-detail.do?pageIndex=1&orderCd=GPA&orderAsc=DESC&mYn=Y&prdtNum=<c:out value="${data.prdtNum}"/>&sFromDtView=<c:out value="${prdtRcSVO.sFromDtView}"/>&sFromDt=<c:out value="${prdtRcSVO.sFromDt}"/>&sFromTm=<c:out value="${prdtRcSVO.sFromTm}"/>&vFromTm=<c:out value="${prdtRcSVO.sFromTm}"/>&sToDtView=<c:out value="${prdtRcSVO.sToDtView}"/>&sToDt=<c:out value="${prdtRcSVO.sToDt}"/>&sToTm=<c:out value="${prdtRcSVO.sToTm}"/>&vToTm=<c:out value="${prdtRcSVO.sToTm}"/></br>
<!-- &lt;&lt;&lt;android_dp&gt;&gt;&gt;shoppingmall_androidapp://product/No=0000001 //안드로이드 앱 내 상품 링크</br>
&lt;&lt;&lt;ios_dp&gt;&gt;&gt; shoppingmall_iosapp://product/No=0000001 //iOS 앱 내 상품 링크</br> -->
&lt;&lt;&lt;igurl&gt;&gt;&gt;<c:out value="${data.savePath}thumb/${data.saveFileNm}"/></br>
&lt;&lt;&lt;cate1&gt;&gt;&gt;<c:out value="렌터카"/></br>
&lt;&lt;&lt;cate2&gt;&gt;&gt;<c:out value="${data.corpNm}"/></br>
&lt;&lt;&lt;cate3&gt;&gt;&gt;<c:out value="${rcFuelMap[data.useFuelDiv]}"/></br>
<!-- &lt;&lt;&lt;cate3&gt;&gt;&gt;주방/청소세제 //카테고리명 (소분류)</br>
&lt;&lt;&lt;cate4&gt;&gt;&gt;주방세제 //카테고리명 (세분류)</br> -->
&lt;&lt;&lt;caid1&gt;&gt;&gt;<c:out value="RC"/></br>
&lt;&lt;&lt;caid2&gt;&gt;&gt;<c:out value="${data.corpId}"/></br>
&lt;&lt;&lt;caid3&gt;&gt;&gt;<c:out value="${data.useFuelDiv}"/> ${fn:substring(data.useFuelDiv, 0, 2)}</br>
<!-- &lt;&lt;&lt;caid3&gt;&gt;&gt;A001B001C001 //카테고리ID (소분류)</br>
&lt;&lt;&lt;caid4&gt;&gt;&gt;A001B001C001D001 //카테고리ID (세분류)</br>
&lt;&lt;&lt;utime&gt;&gt;&gt;2017.03.29 15:40 //업데이트 시점</br>
&lt;&lt;&lt;selid&gt;&gt;&gt;430 //판매상품수</br>
&lt;&lt;&lt;deliv&gt;&gt;&gt;12 //베스트셀러 순위(상품판매순위)</br> -->
&lt;&lt;&lt;description&gt;&gt;&gt;</br>
<!-- &lt;&lt;&lt;expire_time&gt;&gt;&gt;2017.03.29 15:40:01 //마감일(d-day 계산용)</br> -->
&lt;&lt;&lt;ftend&gt;&gt;&gt;</br>
</c:forEach>


<!-- 관광지/레저 & 음식/뷰티 상품 리스트 -->
<c:forEach items="${prdtSpList }" var="data">
&lt;&lt;&lt;begin&gt;&gt;&gt;</br>
&lt;&lt;&lt;mapid&gt;&gt;&gt;<c:out value="${data.prdtNum}"/></br>
&lt;&lt;&lt;pname&gt;&gt;&gt;<c:out value="${data.prdtNm}"/></br>
&lt;&lt;&lt;price&gt;&gt;&gt;<c:out value="${data.saleAmt}"/></br>
&lt;&lt;&lt;pgurl&gt;&gt;&gt;http://www.tamnao.com/web/sp/detailPrdt.do?prdtNum=<c:out value="${data.prdtNum}"/>&prdtDiv=COUP</br>
&lt;&lt;&lt;mourl&gt;&gt;&gt;http://m.tamnao.com/mw/sp/detailPrdt.do?prdtNum=<c:out value="${data.prdtNum}"/>&prdtDiv=COUP</br>
<!-- &lt;&lt;&lt;android_dp&gt;&gt;&gt;shoppingmall_androidapp://product/No=0000001 //안드로이드 앱 내 상품 링크</br>
&lt;&lt;&lt;ios_dp&gt;&gt;&gt; shoppingmall_iosapp://product/No=0000001 //iOS 앱 내 상품 링크</br> -->
&lt;&lt;&lt;igurl&gt;&gt;&gt;<c:out value="${data.savePath}thumb/${data.saveFileNm}"/></br>
<c:set var="spCode">${fn:substring(data.ctgr, 0, 2) }00</c:set>
&lt;&lt;&lt;cate1&gt;&gt;&gt;<c:out value="${spCodeMap[spCode]}"/></br>
<c:if test="${fn:substring(data.ctgr, 0, 2) eq 'C2' }">
&lt;&lt;&lt;cate2&gt;&gt;&gt;<c:out value="${sp200Map[data.ctgr]}"/></br>
</c:if>
<c:if test="${fn:substring(data.ctgr, 0, 2) eq 'C3' }">
&lt;&lt;&lt;cate2&gt;&gt;&gt;<c:out value="${sp300Map[data.ctgr]}"/></br>
</c:if>
<!-- &lt;&lt;&lt;cate3&gt;&gt;&gt;주방/청소세제 //카테고리명 (소분류)</br>
&lt;&lt;&lt;cate4&gt;&gt;&gt;주방세제 //카테고리명 (세분류)</br> -->
&lt;&lt;&lt;caid1&gt;&gt;&gt;<c:out value="${spCode}"/></br>
&lt;&lt;&lt;caid2&gt;&gt;&gt;<c:out value="${data.ctgr}"/></br>
<!-- &lt;&lt;&lt;caid3&gt;&gt;&gt;A001B001C001 //카테고리ID (소분류)</br>
&lt;&lt;&lt;caid4&gt;&gt;&gt;A001B001C001D001 //카테고리ID (세분류)</br>
&lt;&lt;&lt;utime&gt;&gt;&gt;2017.03.29 15:40 //업데이트 시점</br>
&lt;&lt;&lt;selid&gt;&gt;&gt;430 //판매상품수</br>
&lt;&lt;&lt;deliv&gt;&gt;&gt;12 //베스트셀러 순위(상품판매순위)</br> -->
&lt;&lt;&lt;description&gt;&gt;&gt;<c:out value="${data.prdtInf}"/></br>
<!-- &lt;&lt;&lt;expire_time&gt;&gt;&gt;2017.03.29 15:40:01 //마감일(d-day 계산용)</br> -->
&lt;&lt;&lt;ftend&gt;&gt;&gt;</br>
</c:forEach>


<!-- 카텔 & 골프패키지 & 버스/택시관광 & 에어카텔 상품 리스트 -->
<c:forEach items="${prdtPkList }" var="data">
&lt;&lt;&lt;begin&gt;&gt;&gt;</br>
&lt;&lt;&lt;mapid&gt;&gt;&gt;<c:out value="${data.prdtNum}"/></br>
&lt;&lt;&lt;pname&gt;&gt;&gt;<c:out value="${data.prdtNm}"/></br>
&lt;&lt;&lt;price&gt;&gt;&gt;<c:out value="${data.saleAmt}"/></br>
&lt;&lt;&lt;pgurl&gt;&gt;&gt;http://www.tamnao.com/web/sp/detailPrdt.do?prdtNum=<c:out value="${data.prdtNum}"/>&prdtDiv=TOUR</br>
&lt;&lt;&lt;mourl&gt;&gt;&gt;http://m.tamnao.com/mw/sp/detailPrdt.do?prdtNum=<c:out value="${data.prdtNum}"/>&prdtDiv=TOUR</br>
<!-- &lt;&lt;&lt;android_dp&gt;&gt;&gt;shoppingmall_androidapp://product/No=0000001 //안드로이드 앱 내 상품 링크</br>
&lt;&lt;&lt;ios_dp&gt;&gt;&gt; shoppingmall_iosapp://product/No=0000001 //iOS 앱 내 상품 링크</br> -->
&lt;&lt;&lt;igurl&gt;&gt;&gt;<c:out value="${data.savePath}thumb/${data.saveFileNm}"/></br>
&lt;&lt;&lt;cate1&gt;&gt;&gt;<c:out value="${spCodeMap['C100']}"/></br>
&lt;&lt;&lt;cate2&gt;&gt;&gt;<c:out value="${sp100Map[data.ctgr]}"/></br>
<!-- &lt;&lt;&lt;cate3&gt;&gt;&gt;주방/청소세제 //카테고리명 (소분류)</br>
&lt;&lt;&lt;cate4&gt;&gt;&gt;주방세제 //카테고리명 (세분류)</br> -->
&lt;&lt;&lt;caid1&gt;&gt;&gt;<c:out value="C100"/></br>
&lt;&lt;&lt;caid2&gt;&gt;&gt;<c:out value="${data.ctgr}"/></br>
<!-- &lt;&lt;&lt;caid3&gt;&gt;&gt;A001B001C001 //카테고리ID (소분류)</br>
&lt;&lt;&lt;caid4&gt;&gt;&gt;A001B001C001D001 //카테고리ID (세분류)</br>
&lt;&lt;&lt;utime&gt;&gt;&gt;2017.03.29 15:40 //업데이트 시점</br>
&lt;&lt;&lt;selid&gt;&gt;&gt;430 //판매상품수</br>
&lt;&lt;&lt;deliv&gt;&gt;&gt;12 //베스트셀러 순위(상품판매순위)</br> -->
&lt;&lt;&lt;description&gt;&gt;&gt;<c:out value="${data.prdtInf}"/></br>
<!-- &lt;&lt;&lt;expire_time&gt;&gt;&gt;2017.03.29 15:40:01 //마감일(d-day 계산용)</br> -->
&lt;&lt;&lt;ftend&gt;&gt;&gt;</br>
</c:forEach>


<!-- 특산/기념품 상품 리스트 -->
<c:forEach items="${prdtSvList }" var="data">
&lt;&lt;&lt;begin&gt;&gt;&gt;</br>
&lt;&lt;&lt;mapid&gt;&gt;&gt;<c:out value="${data.prdtNum}"/></br>
&lt;&lt;&lt;pname&gt;&gt;&gt;<c:out value="${data.prdtNm}"/></br>
&lt;&lt;&lt;price&gt;&gt;&gt;<c:out value="${data.saleAmt}"/></br>
&lt;&lt;&lt;pgurl&gt;&gt;&gt;http://www.tamnao.com/web/sv/detailPrdt.do?prdtNum=<c:out value="${data.prdtNum}"/></br>
&lt;&lt;&lt;mourl&gt;&gt;&gt;http://m.tamnao.com/mw/sv/detailPrdt.do?prdtNum=<c:out value="${data.prdtNum}"/></br>
<!-- &lt;&lt;&lt;android_dp&gt;&gt;&gt;shoppingmall_androidapp://product/No=0000001 //안드로이드 앱 내 상품 링크</br>
&lt;&lt;&lt;ios_dp&gt;&gt;&gt; shoppingmall_iosapp://product/No=0000001 //iOS 앱 내 상품 링크</br> -->
&lt;&lt;&lt;igurl&gt;&gt;&gt;<c:out value="${data.savePath}thumb/${data.saveFileNm}"/></br>
&lt;&lt;&lt;cate1&gt;&gt;&gt;<c:out value="특산/기념품"/></br>
&lt;&lt;&lt;cate2&gt;&gt;&gt;<c:out value="${svCodeMap[data.ctgr]}"/></br>
&lt;&lt;&lt;cate3&gt;&gt;&gt;<c:out value="${svSubCodeMap[data.ctgr][data.subCtgr]}"/></br>
<!-- &lt;&lt;&lt;cate3&gt;&gt;&gt;주방/청소세제 //카테고리명 (소분류)</br>
&lt;&lt;&lt;cate4&gt;&gt;&gt;주방세제 //카테고리명 (세분류)</br> -->
&lt;&lt;&lt;caid1&gt;&gt;&gt;<c:out value="SV"/></br>
&lt;&lt;&lt;caid2&gt;&gt;&gt;<c:out value="${data.ctgr}"/></br>
&lt;&lt;&lt;caid3&gt;&gt;&gt;<c:out value="${data.subCtgr}"/></br>
<!-- &lt;&lt;&lt;caid3&gt;&gt;&gt;A001B001C001 //카테고리ID (소분류)</br>
&lt;&lt;&lt;caid4&gt;&gt;&gt;A001B001C001D001 //카테고리ID (세분류)</br>
&lt;&lt;&lt;utime&gt;&gt;&gt;2017.03.29 15:40 //업데이트 시점</br>
&lt;&lt;&lt;selid&gt;&gt;&gt;430 //판매상품수</br>
&lt;&lt;&lt;deliv&gt;&gt;&gt;12 //베스트셀러 순위(상품판매순위)</br> -->
&lt;&lt;&lt;description&gt;&gt;&gt;<c:out value="${data.prdtInf}"/></br>
<!-- &lt;&lt;&lt;expire_time&gt;&gt;&gt;2017.03.29 15:40:01 //마감일(d-day 계산용)</br> -->
&lt;&lt;&lt;ftend&gt;&gt;&gt;</br>
</c:forEach>


</body>
</html>