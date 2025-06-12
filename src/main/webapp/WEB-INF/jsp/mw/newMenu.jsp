<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<un:useConstants var="Constant" className="common.Constant" />
<c:if test="${isLogin ne 'N'}"><h1 class="visuallyhidden">제주여행공공플랫폼,탐나오</h1></c:if>
<aside id="side_menu" class="side-menu">
	<div class="side-all">
		<div class="sitemap-header">
			<c:if test="${isLogin eq 'N'}">
				<div class="sitemap-intro">
					<button type="button" id="frame_sideClose" class="close"><img src="/images/mw/common/side/top_bold_close.png" loading="lazy" alt="닫기"></button>
					<div class="sitemap-login">
						<h1 class="sitemap-intro-logo">
							<a href="<c:url value='https://www.tamnao.com/mw/evnt/detailPromotion.do?prmtNum=PM00001557&winsYn=N&type=evnt' />">
								<img src="/images/mw/sitemap/coupon_banner.png" loading="lazy" alt="탐나오 회원가입 할인쿠폰 지급 신규고객">
							</a>
						</h1>
						<button type="button" class="s-login-btn" onclick="javascript:fn_login();">로그인/회원가입</button>
					</div>
				</div>
			</c:if>
			<c:if test="${isLogin ne 'N'}">
				<button type="button" id="frame_sideClose2" class="close"><img src="/images/mw/common/side/top_bold_close.png" loading="lazy" alt="닫기"></button>

				<div class="affiliate-info-text">
					<img src="/images/mw/sub/mypage_character.png" alt="로그인 마이페이지 캐릭터">
					<ul>
						<c:if test="${isLogin eq 'Y'}">
							<li><b>${userNm}</b>님 환영합니다.</li>
						</c:if>
						<c:if test="${isLogin eq 'G'}">
							<li><b>게스트</b> 로그인상태입니다.</li>
						</c:if>
				<%--		<li class="r-btn">
							<a class="home" href="<c:url value='/mw/main.do'/>"><img src="/images/mw/sitemap/home.png" loading="lazy" alt="홈"></a>
							<a class="mypage" href="<c:url value='/mw/mypage/mainList.do' />"><img src="/images/mw/sitemap/mypage.png" loading="lazy" alt="마이탐나오"></a>
							<a class="r-like" href="<c:url value='/mw/mypage/pocketList.do?type=pocket' />"><img src="/images/mw/sitemap/like.png" loading="lazy" alt="찜한상품"></a>
						</li>--%>
					</ul>
				</div>
			</c:if>
		</div>
		<nav class="sitemap-quick-menu">
			<ul>
				<li class="quick-re"><a href="<c:url value='/mw/mypage/rsvList.do?type=rsv'/>">나의 예약/구매 내역</a></li>
                <li class="quick-cart"><a href="<c:url value='/mw/cart.do'/>">장바구니</a></li>
			</ul>
		</nav>
		<div class="sitemap-main-menu">
			<ul>
				<li class="sitemap-air"><a href="<c:url value='/mw/av/mainList.do' />">항공</a></li>
				<li class="sitemap-hotel"><a href="<c:url value='/mw/stay/jeju.do' />">숙소</a></li>
				<li class="sitemap-rentcar"><a href="<c:url value='/mw/rentcar/jeju.do' />">렌트카</a></li>
				<%--<li class="sitemap-ship"><a href="javascript:void(0);" onClick="alert('준비중입니다.')">선박</a></li>--%>
				<li class="sitemap-agriculture"><a href="<c:url value='/mw/sv/sixIntro.do' />">6차산업</a></li>
			</ul>
		</div>
		<div class="sitemap-menu">
			<div class="leisure">
				<a class="leisure title" href="<c:url value='/mw/tour/jeju.do?sCtgr=C200' />">
					<img src="/images/mw/sitemap/leisure.png" loading="lazy" alt="관광지/레저">
					<span>관광지/레저</span>
				</a>
				<%--<ul class="depth4">
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C210' />">전시/박물관</a></li>
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C220' />">테마공원</a></li>
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C250' />">스포츠/레저</a></li>
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C260' />">해양관광</a></li>
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C230' />">공연/쇼</a></li>
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C270' />">체험</a></li>
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C200&sTabCtgr=C280' />">뷰티/테라피</a></li>
				</ul>--%>
			</div>
			<div class="from-jeju">
				<a class="from-jeju title" href="<c:url value='/mw/goods/jeju.do' />">
					<img src="/images/mw/sitemap/fromjeju.png" loading="lazy" alt="특산/기념품">
					<span>특산/기념품</span>
				</a>
				<%--<ul class="depth4">
					<li><a href="<c:url value='/mw/sv/productList.do?sCtgr=S100' />">농/수/축산물</a></li>
					<li><a href="<c:url value='/mw/sv/productList.do?sCtgr=S400' />">가공식품</a></li>
					<li><a href="<c:url value='/mw/sv/productList.do?sCtgr=S500' />">화장품/미용</a></li>
					<li><a href="<c:url value='/mw/sv/productList.do?sCtgr=S600' />">제주기념품</a></li>
					<c:forEach items="${brandPrdtList}" var="brandList" varStatus="status">
						<c:if test="${status.first}">
							<li><a href="<c:url value='/mw/sv/productList.do?sCorpId=${brandList.corpId}&sFlag=Brd'/>">브랜드</a></li>
						</c:if>
					</c:forEach>
					<c:forEach items="${crtnList}" var="crtnList" varStatus="status">
						<c:if test="${status.first}">
							<li><a href="<c:url value='/mw/sv/crtnList.do?crtnNum=${crtnList.crtnNum}'/>">슬기로운<br>제주쇼핑</a></li>
						</c:if>
					</c:forEach>
					&lt;%&ndash; 제주유나이티드 임시 비노출(20191015) &ndash;%&gt;
					&lt;%&ndash;<li><a href="<c:url value='/mw/sv/productList.do?sCtgr=S700' />">제주유나이티드</a></li>&ndash;%&gt;
				</ul>--%>
			</div>
			<a class="carseat-t title" href="<c:url value='/mw/tour/jeju.do?sCtgr=C500' />">
				<img src="/images/mw/sitemap/carseat-icon.png" loading="lazy" alt="유모차/카시트">
				<span>유모차/카시트</span>
			</a>
			<%--<a class="jeju title" href="<c:url value='/mw/tour/jeju.do?sCtgr=C270' />"><img src="/images/mw/sitemap/jeju.png" loading="lazy" alt="체험">체험</a>--%>
			<a class="food title" href="<c:url value='/mw/tour/jeju.do?sCtgr=C300' />">
				<img src="/images/mw/sitemap/food.png" loading="lazy" alt="맛집">
				<span>맛집</span>
			</a>
			<div class="agency">
				<a class="agency title" href="<c:url value='/mw/sp/packageList.do' />">
					<img src="/images/mw/sitemap/agency.png" loading="lazy" alt="여행사상품">
					<span>여행사상품</span>
				</a>
				<%--<ul class="depth4">
					<li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C100&sCtgrTab=C160' />">버스/택시관광</a></li>
                    <li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C100&sCtgrTab=C420' />">렌트카</a></li>
                    <li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C100&sCtgrTab=C180' />">테마여행</a></li>
                    <li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C100&sCtgrTab=C170' />">골프패키지</a></li>
                    &lt;%&ndash; <li><a href="<c:url value='/mw/tour/jeju.do?sCtgr=C100&sCtgrTab=C190' />">선박</a></li> &ndash;%&gt;
					<li><a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=SP00002246' />">차량이동</a></li>
				</ul>--%>
			</div>
			<%--<div id="cctv">
				<a class="cctv title" href="<c:url value='/mw/cmm/cctvList.do' />"><img src="/images/mw/sitemap/cctv.png" loading="lazy" alt="관광지CCTV">관광지 CCTV</a>
			</div>--%>
			<a class="event2 title" href="<c:url value='/mw/evnt/prmtPlanList.do' />">
				<img src="/images/mw/sitemap/s-event2.png" loading="lazy" alt="기획전">
				<span>기획전</span>
			</a>
			<a class="event title" href="<c:url value='/mw/evnt/promotionList.do?finishYn=N&winsYn=N' />">
				<img src="/images/mw/sitemap/s-event.png" loading="lazy" alt="이벤트">
				<span>이벤트</span>
			</a>
			<a class="zoom_map title" href="<c:url value='/mustsee.do' />">
				<img src="/images/mw/sitemap/map.png" loading="lazy" alt="관광지/맛집">
				<span>내 손안의 제주 지도</span>
			</a>
			<a class="sitemap-rentcar title" href="<c:url value='/web/rentcar/jeju.do' />">
				<img src="/images/mw/sitemap/rentcar.png" loading="lazy" alt="제주도렌트카">
				<span>제주렌트카 가격비교</span>
			</a>
		</div>
		<div class="tamnao">
			<%--<a class="tamnao title" href="<c:url value='/mw/bbs/bbsList.do?bbsNum=NOTICE' />"><img src="/images/mw/sitemap/nao.png" loading="lazy" alt="탐나오">TAMNAO</a>--%>
			<%--<a class="tamnao title" /><img src="/images/mw/sitemap/nao.png" loading="lazy" alt="탐나오">TAMNAO</a>--%>
			<ul class="depth4">
				<li><a href="<c:url value='/mw/bbs/bbsList.do?bbsNum=NOTICE' />">공지사항</a></li>
				<li><a href="<c:url value='/mw/coustomer/qaList.do' />">자주하는질문</a></li>
				<li><a href="<c:url value='/mw/mypage/mainList.do' />">마이탐나오</a></li>
				<li><a href="<c:url value='/mw/etc/introduction.do' />">회사소개</a></li>
				<li><a href="<c:url value='/mw/evnt/prmtPlanList.do?sPrmtDiv=GOVA' />">공고신청</a></li>
				<c:if test="${isLogin ne 'Y'}">
					<li><a href="<c:url value='/mw/signUp00.do' />">회원가입</a></li>
				</c:if>
				<c:if test="${isLogin ne 'N'}">
					<li><a class="site-log-out" href="javascript:fn_logout();">로그아웃</a></li>
				</c:if>

			</ul>
		</div>
	</div>
</aside>

<!--검색 layer pop-->
<div class="search-cover">
	<div id="top_search" class="search-area-wrap">
		<button type="button" id="top_searchClose_inp" class="close"><img src="../../../images/mw/sub_common/delete.png" alt="닫기"></button>
		<div class="form-area-wrap">
			<form name="searchFrm" id="searchFrm" class="form-area" method="get" onsubmit="return false;">
				<input type="text" name="trova" id="search" placeholder="검색어를 입력해주세요." class="category-search" onkeydown="javascript:if(event.keyCode==13){fn_search();}">
				<button type="button" class="icon-search" title="검색" onclick="fn_search();"></button>
			</form>
		</div>
		<div class="all-search">
			<div class="condition">
				<div class="search_title">최근검색어</div>
				<div class="search_none_result" style="display: none">
					<p>최근 검색어 내역이 없습니다.</p>
				</div>
				<div class="search_latest_keyword">
					<ul id="searchLi"></ul>
					<div class="product-sub"><a href="javascript:fn_deleteSearchWord('')" id="allDelSrch">모두삭제</a></div>
				</div>
			</div>
			<%--<div class="keyword">
				<div class="search_title">인기검색어</div>
				<ul class="all-text">
					<c:forEach var="result" items="${kwaList}" varStatus="status">
						<li>
							<c:if test="${empty result.mobileUrl && result.prdtCnt == 0}">
								<a href="/mw/search.do?search=<c:out value="${result.kwaNm}"/>" ><c:out value="${result.kwaNm}"/></a>
							</c:if>
							<c:if test="${!empty result.mobileUrl}">
								<a href="${result.mobileUrl}" ><c:out value="${result.kwaNm}"/></a>
							</c:if>
							<c:if test="${empty result.mobileUrl && result.prdtCnt != 0}">
								<a href="/mw/kwaSearch.do?kwaNum=<c:out value="${result.kwaNum}"/>" ><c:out value="${result.kwaNm}"/></a>
							</c:if>
						</li>
					</c:forEach>
				</ul>
			</div>--%>
		</div>
	</div>
	<div class=""></div>
</div>
<!--검색 layer pop-->
<%--
<c:set var="chkInclude" value="${requestScope['javax.servlet.forward.servlet_path']}"/>
<c:if test="${(chkInclude eq '/mw/tour/jeju.do') || (chkInclude eq '/mw/stay/jeju.do') || (chkInclude eq '/mw/rentcar/jeju.do') || (chkInclude eq '/mw/goods/jeju.do') || (chkInclude eq '/mw/sv/sixIntro.do') || (chkInclude eq '/mw/sp/packageList.do')}">
	<div class="newMenuHeader">
		<div class="container">
			<div class="gnb_mall">
				<div class="logo">
					<a href="/mw/main.do" title="홈으로 가기">
						<img src="${logoUrl}" loading="lazy" alt="탐나오">
					</a>
				</div>
			</div>
		</div>
		<div class="r-area-side">
			<button type="button" id="frame_sideOpen2" class="side-btn" title="사이드메뉴 열기"></button>
		</div>
	</div>
</c:if>
 --%>

<div class="newMenuHeader" style="display: none">
	<div class="container">
		<div class="gnb_mall">
			<div class="logo">
				<a href="/mw/main.do" title="홈으로 가기">
					<img src="${logoUrl}" loading="lazy" alt="탐나오">
				</a>
			</div>
		</div>
	</div>
	<div class="r-area-side">
		<button type="button" id="frame_sideOpen2" class="side-btn" title="사이드메뉴 열기"></button>
	</div>
</div>
<script>
var getContextPath = "${pageContext.request.contextPath}";
var queryString = "${pageContext.request.queryString}";
var servlet_path = "${requestScope['javax.servlet.forward.servlet_path']}";
//가로 길이
var winWidth = window.innerWidth;
//window.outerWidth;
//세로길이
var winHeight = window.innerHeight;
//window.outerHeight;

//로그인 - 이전 url 정보포함
function fn_login() {
	if(servlet_path == "//index.jsp"){
		var ref = "<c:url value='/mw/viewLogin.do' />";
		location.href = ref;

	}else if(servlet_path != "/mw/viewLogin.do" && servlet_path != "/mw/actionLogin.do") {
		var ref = "<c:url value='/mw/viewLogin.do' />";
		ref += "?rtnUrl=" + servlet_path;
		if(queryString != "") {
			ref += "&" + queryString;
		}
		location.href = ref;
	}
}

//로그인 - 이전 url 정보포함 - 회원 전용
function fn_loginUser() {
	if(servlet_path != "/mw/viewLogin.do" && servlet_path != "/mw/actionLogin.do") {
		var ref = "<c:url value='/mw/viewLogin.do' />";
		ref += "?rtnUrl=" + servlet_path;
		ref += "&mode=user";

		if(queryString != "") {
			ref += "&" + queryString;
		}
		location.href = ref;
	}
}

//logout
function fn_logout() {
	if(confirm("<spring:message code='common.logout.confirm' />")) {
		var addParam = "";
		if(fn_AppCheck() == "IA"||fn_AppCheck() == "AA") {
			addParam = "?app_id_del=ok";
		}
		location.href = "<c:url value='/mw/logout.do'/>" + addParam;
	}
}

function show_popup(obj) {
	if($(obj).is(":hidden")) {
		$(obj).show();
		$("html, body").addClass("not_scroll");
		$('#code_popup').css('position', 'fixed');
		$('#code_popup').animate( {'top' : '40%'}, 200);
		$("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경
	} else {
		$(obj).hide();
		$('#code_popup').animate( {'top' : '40%'}, 200);
		$(".lock-bg").remove();
	}
}

//이미지 에러시 대체 이미지 처리
function OnErrorImageNull(obj) {
	if(obj != null) {
		obj.src = "<c:url value='/images/web/comm/no_img.jpg'/>";
	}
}

function itemSingleHide(obj){
	$(obj).hide();
	$('.lock-bg').remove();
	$("html, body").removeClass("not_scroll");
	$("#code_popup").fadeOut(100);
	$('#code_popup').css('top', 'auto');			//애니에 따른 추가
}

function close_popup(obj){
	$(obj).hide();
	$('.lock-bg').remove();
	$("html, body").removeClass("not_scroll");
	$("#code_popup").fadeOut(100);
	$('#code_popup').css('top', 'auto');			//애니에 따른 추가
}

function fn_AddCart(params){
	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json;",
		url:"<c:url value='/web/addCart.ajax'/>",
		data:JSON.stringify({cartList:params}),
		success:function(data){
			//alert("장바구니에 등록되었습니다.");
			$("#headCartCnt").html(data.cartCnt);

			if(confirm("장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?")) {
				location.href = "<c:url value='/mw/cart.do'/>";
			}
		},
		error:fn_AjaxError
	});
}

//찜한 상품
function fn_AddPocket(params, gubun, chgId) {
	<c:if test="${isLogin eq 'N' or isLogin eq 'G' }">
		if (confirm('로그인 후 상품을 찜할 수 있습니다.\n로그인 하시겠습니까?')) {
			fn_login();
		}
	</c:if>
	<c:if test="${isLogin eq 'Y' }">
		$.ajax({
			type:"post",
			dataType:"json",
			// processData:false,
			// contentType:false,
			// async:false,
			// traditional: true,
			contentType:"application/json;",
			url:"<c:url value='/web/mypage/addPocket.ajax'/>",
			data:JSON.stringify({pocketList:params}),
			success:function(data) {
				// 찜하기 개수 변경
				fn_PocketCnt();
				// 이미지 변경
				if (gubun == 'list') {
					$('#pocket' + chgId).attr("onclick", "").html('<img src="/images/mw/icon/product_like_on.png" alt="찜하기">');
				} else if(gubun == 'adDetail'){
					$('#pocketBtnId').attr("onclick", "").html('<img src="/images/mw/icon/r_product-like_on.png" alt="찜하기">');
				}else {
					$('#pocketBtnId').attr("onclick", "").html('<img src="/images/mw/icon/product_like2_on.png" alt="찜하기">');
				}
				alert("선택하신 상품을 찜 했습니다.");
			},
			error:fn_AjaxError2
		});
	</c:if>
}

// 각 상품 리스트에서 찜하기
function fn_listAddPocket(prdtDiv, corpId, prdtNum) {
	var pocket = [{
		prdtNum 	: prdtNum,
		prdtNm 		: ' ',
		corpId 		: corpId,
		corpNm		: ' ',
		prdtDiv 	: prdtDiv
	 }];

	var chgId = prdtNum != ' ' ? prdtNum : corpId;

	fn_AddPocket(pocket, 'list', chgId);
}

//즉시구매
function fn_InstantBuy(params) {
	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json;",
		url:"<c:url value='/web/instantBuy.ajax'/>",
		data:JSON.stringify({cartList :params}),
		success:function(data){
			if(data.result == "N") {
				alert("예약마감 또는 구매불가 상품입니다.");
				return;
			}
			if (data.chkPointBuyAble == "N"){
				alert("포인트 사용기간 또는 예산 한도가 초과되어 종료되었습니다.");
				return;
			}
			location.href = "<c:url value='/mw/order01.do?rsvDiv=i'/>";
		},
		error:fn_AjaxError
	});
}

function fn_PocketCnt() {
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/mypage/pocketCnt.ajax'/>",
		success:function(data){
			$("#headPocketCnt").html(data.pocketCnt);
			$("#headPocketCntOut").html(data.pocketCnt);
		}
	});
}

//최근검색어 Read
function fn_readSearchWord() {
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/mw/selSrchWords.ajax'/>",
		success:function(data) {
			var results = data.resultList;
			var addHtml = "";

			if ( results.length > 0 ){
				for(var i in results) {
					addHtml += "<li>";
					addHtml += "	<a href=\"javascript:fn_reSearch('" + results[i].srchWord + "')\">" + results[i].srchWord + "</a>";
					addHtml += "	<img src=\"../../../images/mw/sub_common/delete.png\" onclick=\"javascript:fn_deleteSearchWord('" + results[i].srchWord + "')\" >";
					addHtml += "</li>";
				}
			}else{
				$(".search_latest_keyword").hide();
				$(".search_none_result").show();
			}

			$("#searchLi").html(addHtml);

			if(results.length < 1) {
				$("#allDelSrch").text("");
				$(".search_none_result").show();
			}
		}
	});
}

//검색
let mwMainClickTime = 0;
function fn_search() {
	if($.trim($("#search").val()) == "") {
		alert("<spring:message code='errors.minlength' arguments='검색어, 1'/>");

		$("#search").focus();
		return false;
	} else {

		const currentTime = new Date().getTime();
	    const timeDiff = currentTime - mwMainClickTime;

	    if (timeDiff < 500) {
	        e.preventDefault();
	        return;
	    }

	    mwMainClickTime = currentTime;
	    
		document.searchFrm.action = "<c:url value='/mw/cerca.do'/>";
		document.searchFrm.submit();
	}
}

function fn_reSearch(data) {
	$("#search").val(data);

	fn_search();
}

//최근검색어 Delete
function fn_deleteSearchWord(srchWord) {
	var parameters = "srchWord=" + srchWord;

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/mw/delSrchWords.ajax'/>",
		data:parameters,
		success:function(data) {
			var results = data.resultList;
			var addHtml = "";

		    for(var i in results) {

				addHtml += "<li>";
				addHtml += "	<a href=\"javascript:fn_reSearch('" + results[i].srchWord + "')\">" + results[i].srchWord + "</a>";
				addHtml += "	<img src=\"../../../images/mw/sub_common/delete.png\" onclick=\"javascript:fn_deleteSearchWord('" + results[i].srchWord + "')\" >";
				addHtml += "</li>";
			}
			$("#searchLi").html(addHtml);

		    if(results.length < 1) {
				$("#allDelSrch").text("");
				$(".search_none_result").show();
			}
		}
	});
}

function fn_CouponRegPop() {
	$.ajax({
		type: "post",
		data: "isMobile=Y",
		url : "<c:url value='/web/point/couponRegPop.do'/>",
		success: function (data) {
			$(".couponRegPop_2").html(data);
			show_popup($(".couponRegPop_2"));
		},
		error  : fn_AjaxError
	});
}

function fn_PointHistoryPop() {
	$.ajax({
		type: "post",
		data: "isMobile=Y",
		url : "<c:url value='/web/point/pointHistoryPop.do'/>",
		success: function (data) {
			$(".couponRegPop_1").html(data);
			show_popup($(".couponRegPop_1"));
		},
		error  : fn_AjaxError
	});
}

//사이트맵 back 잠금
function frameSideMenu() {

	var closeObj = '#frame_sideClose';
	var closeObj2 = '#frame_sideClose2';
	var TargetObj = '#side_menu';

	$("#frame_sideOpen").on('click', function() {

		$(TargetObj).fadeToggle();
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
		$('body').addClass('not_scroll');
	});

	$(closeObj).on('click', function() {
		$(TargetObj).hide();
		$('.lock-bg').remove();
		$('.not_scroll').removeClass();
	});

	$(closeObj2).on('click', function() {
		$(TargetObj).hide();
		$('.lock-bg').remove();
		$('.not_scroll').removeClass();
	});
}

$(document).ready(function(){

	$("#frame_sideOpen2").on('click', function() {
		$("#side_menu").fadeToggle();
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
		$('body').addClass('not_scroll');
	});

	//로고 헤더 controll
	const chkInclude = $(location).attr('pathname');
	if(chkInclude.includes("/mw/tour/jeju.do") || chkInclude.includes("intro.do") || chkInclude.includes("jeju.do") || chkInclude.includes("sixIntro.do") || chkInclude.includes("/mw/sp/packageList.do") ) {
		$(".newMenuHeader").show();
	}
});
</script>