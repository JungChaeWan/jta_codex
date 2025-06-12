<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="utf-8">
<%--<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">--%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<c:if test="${empty seo.title}">
<title>제주여행 공공플랫폼 탐나오</title>
</c:if>
<c:if test="${!(empty seo.title)}">
<title>${seo.title}</title>
</c:if>
<c:if test="${empty seo.description}">
<meta name="description" content="제주 항공권, 숙소, 렌터카, 관광지 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다. 제주여행공공플랫폼 탐나오.">
</c:if>
<c:if test="${!(empty seo.description)}">
<meta name="description" content="<c:out value="${seo.description}"/>">
</c:if>
<c:if test="${empty seo.keywords}">
<meta name="keywords" content="제주도,제주,제주여행,제주도여행,제주숙소,제주도숙소,제주렌트카,제주도렌터카,제주렌트카,제주도렌트카,탐나오">
</c:if>
<c:if test="${!(empty seo.keywords)}">
<meta name="keywords" content="<c:out value="${seo.keywords}"/>">
</c:if>
<meta name="author" content="제주특별자치도관광협회">
<%--<meta name="robots" content="index, follow">--%>
<meta name="naver-site-verification" content="1c8604f5b0cef6f67a973ed41f11a1552a476c64">
<meta name="google-site-verification" content="wDsvLTLKE4X0TkTh_Z_hphDNIv1YtWa68bE0UEQ-Tfg">
<meta name="facebook-domain-verification" content="9uo3yrlefuv4stvgwx355jmotj8tc9">
<meta property="og:type" content="website">

<link rel="shortcut icon" href="/images/web/favicon/16.ico">
<link rel="shortcut icon" href="/images/web/favicon/32.ico">

<script src="/js/jquery-1.11.1.js"></script>
<%-- <script src="/js/jquery-ui-mw.js"></script> --%>
<script src="/js/mw_style.js"></script>
<script defer src="/js/swiper.js"></script>
<script defer src="/js/common.js"></script>
<%-- <script src="/js/jquery.bxslider.js"></script> --%>
<%-- <script src="/js/mw_iscroll.js"></script> --%>
<%-- <script src="/js/html_style.js"></script> --%>
<script src="/js/mw_common.js"></script>
<%-- <script src="/js/mw_layout.js"></script> --%>
<%-- <script src="/js/mw_slider.js"></script> --%>
<script defer src="/js/jquery.cookie.js"></script>
<script defer src="/js/cookie.js"></script>
<%-- <script src="/js/moment.min.js"></script>
<script src="/js/daterangepicker.js"></script> --%>

<%-- GDN --%>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10926637573"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'AW-10926637573');
</script>

<%--키워드 본예산--%>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-818795361"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'AW-818795361');
</script>

<%--키워드 기금예산--%>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10926598396"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'AW-10926598396');
</script>

<%-- GA4 --%>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-FTMM6J180S"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-FTMM6J180S');
</script>