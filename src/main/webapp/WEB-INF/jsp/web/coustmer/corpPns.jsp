<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator"	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<head>
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 입점/제휴 안내"/>
    <jsp:param name="description" value="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 판매 관련 입점/제휴 안내. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 입점/제휴 안내">
<meta property="og:url" content="https://www.tamnao.com/web/coustmer/viewCorpPns.do?menuIndex=2">
<meta property="og:description" content="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 판매 관련 입점/제휴 안내. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>
<script type="text/javascript">
	function goCorpPns() {
		location.href = "<c:url value='/web/coustmer/viewInsertCorpPns.do?menuIndex=2' />";
	}
</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation">
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>고객센터</span><span class="gt">&gt;</span>
			<span>입점/제휴 안내</span>
		</div>
	</div>
	<!-- quick banner -->

	<!-- //quick banner -->
	<div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
			<!-- new contents -->
			<div class="service-center sideON">
				<div class="bgWrap2">
					<div class="inner">
						<div class="tbWrap">
							<jsp:include page="/web/coustmer/left.do?menu=corpPns" />

							<div class="rContents smON">
								<h3 class="mainTitle">입점/제휴 안내</h3>
								<div class="notice_banner">
									<img src="/images/web/service/notice_banner.jpg" alt="사업자 대상 안내문, 슬기로운 비즈니스">
								</div>
								<div class="affiInfo">
									<img src="/images/web/service/affiliates.jpg" alt="회원가입, 입점/제휴신청, 심사후 담당자 연결, 프로모션 계약체결, 프로모션 개시">
								</div>
								<div class="commBoard-doc-wrap">
									<h5 class="listTitle1">입점 신청시 필요 서류</h5>
									<table class="commRow commRow-sub">
										<tr>
											<th>필요 서류</th>
											<td>
												<table class="licensee">
													<tr>
														<th>개인사업자</th>
														<th>법인사업자</th>
													</tr>
													<tr>
														<td>사업자등록증 사본 1부 <span class="necessary">*</span>
															사업자 또는 대표자 명의 통장 사본 1부 <span class="necessary">*</span>
															영업신고증 및 각종 허가증 (택1) <span class="necessary">*</span>
															통신판매업신고증 1부 (해당업체 제출)
														</td>
														<td>사업자등록증 사본 1부 <span class="necessary">*</span>
															법인 명의 통장 사본 1부 <span class="necessary">*</span>
															영업신고증 및 각종 허가증 (택1) <span class="necessary">*</span>
															통신판매업신고증 1부 (해당업체 제출)
														</td>
													</tr>
												</table>
												<dl class="side-memo">
													<h3>통신판매업 신고 방법</h3>
													<dd>
														<dt>방문신청</dt>
														<dd>시군구 / 특별자치도 / 공정거래위원회 접수 </dd>
													</dd>
													<dd>
														<dt>인터넷신청 <span>*공인인증서필요</span></dt>
														<dd>정부 24 <a href="https://www.gov.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A09006&CappBizCD=11300000006" target="_blank">https://www.gov.kr</a></dd>
													</dd>
													<div class="side-memo-rule">
														<div class="memo-title">
															※통신판매업 신고 면제 기준에 대한 고시 <span>*국가법령정보센터 <a href="https://www.law.go.kr/admRulLsInfoP.do?admRulSeq=2100000171369" target="_blank">http://www.law.go.kr</a></span>
														</div>
														<div class="scroll-wrap">
															<dl class="comm-rule">
																<dt>제2조(통신판매업 신고 면제 기준)</dt>
																<dd>① 다음 각 호의 하나에 해당하는 통신판매업자는 법 제12제1항에 따른 통신판매업 신고를 아니할 수 있다.
																	1. 직전년도 동안 통신판매의 거래횟수가 50회 미만인 경우
																	2. 「부가가치세법」 제2조제4호의 간이과세자인 경우
																	② 청약철회 등의 경우에는 제1항의 통신판매의 거래횟수 또는 거래규모에 산입하지 아니한다.
																</dd>
															</dl>
														</div>
													</div>
												</dl>
											</td>
										</tr>
									</table>
								</div> <!--//commBoard-doc-wrap-->

								<div class="boardBT2" id="sendCorpPns">
									<%-- <p class="button comm-btWrap"><a href="javascript:void(0)" onclick="goCorpPns();" class="comm-arrowBT comm-arrowBT2">입점/제휴 신청</a></p> --%>
									<p class="button comm-btWrap"><a id="go-corp-pns" onclick="goCorpPns();" class="comm-arrowBT comm-arrowBT2">입점/제휴 신청</a></p>
								</div>
							</div> <!--//rContents-->
						</div> <!--//tbWrap-->
					</div> <!--//Fasten-->
				</div> <!--//bgWrap2-->
			</div> <!-- //affiliates -->
			<!-- //new contents -->
		</div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<jsp:include page="/web/foot.do" />
</body>
</html>