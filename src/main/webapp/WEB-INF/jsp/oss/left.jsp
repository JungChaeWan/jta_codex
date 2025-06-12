<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui"      uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";

$(document).ready(function(){


});

</script>

<div id="side_area" class="d-none d-lg-block col-lg-2">
    <!--사이드메뉴-->
    <div class="side_menu">
        <c:choose>
            <c:when test="${menuNm=='setting'}">
                <h3>환경설정</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='logo'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/logoManage.do' />">로고 설정</a></li>
                    <li <c:if test="${subNm=='site'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/siteManage.do' />">운영 설정</a></li>
                    <li <c:if test="${subNm=='code'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/codeList.do' />">코드 관리</a></li>
                    <li <c:if test="${subNm=='cmss'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/cmssList.do' />">수수료 관리</a></li>
                    <li <c:if test="${subNm=='cmssPg'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/cmssPgList.do' />">PG사 수수료 관리</a></li>
                    <li <c:if test="${subNm=='channelTalk'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/channelTalkManage.do' />">채널톡 관리</a></li>
                    <li <c:if test="${subNm=='bbs'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/bbsList.do' />">게시판 관리</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='user'}">
                <h3>고객관리</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='user'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/userList.do' />">사용자 관리</a></li>
                    <li <c:if test="${subNm=='dropUser'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/dropUserList.do'/>">탈퇴사용자 관리</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='corp'}">
                <h3>업체/제휴관리</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='corp'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/corpList.do' />">입점업체 관리</a></li>
                    <li <c:if test="${subNm=='corpapp'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/corpPnsReqList.do' />">입점신청 관리</a></li>
                    <%-- <li <c:if test="${subNm=='b2bReq'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/b2bReqList.do' />">B2B 신청관리</a></li>
                    <li <c:if test="${subNm=='b2bCtrt'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/b2bCtrtList.do' />">B2B 계약관리</a></li> --%>
                    <li <c:if test="${subNm=='bbsMASNOTI'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASNOTI">업체 공지사항</a></li>
                    <li <c:if test="${subNm=='bbsMASQA'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASQA">업체 Q&amp;A 게시판</a></li>
                    <li <c:if test="${subNm=='corpLevel'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/corpLevel.do'/>">입점업체 지수</a></li>
                    <li <c:if test="${subNm=='visitjeju'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/visitjejuList.do'/>">비짓제주 연동</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='product'}">
                <h3>상품관리</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='product'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/prdtList.do' />">상품 관리</a></li>
                    <li <c:if test="${subNm=='social'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/socialProductList.do' />">소셜상품 관리</a></li>
                    <li <c:if test="${subNm=='sv'}">class="on list-group-item"</c:if>><a href="<c:url value="/oss/svPrdtList.do"/>">제주특산/기념품 관리</a></li>
                    <li <c:if test="${subNm=='chckPrdtExpire'}">class="on list-group-item"</c:if>><a href="<c:url value="/oss/chckPrdtExpireList.do"/>">상품 기한 관리</a></li>
                    <li <c:if test="${subNm=='coupon'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/couponList.do' />">탐나오쿠폰</a></li>
                    <li <c:if test="${subNm=='prmt'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/promotionList.do' />">프로모션 승인 관리</a></li>
                    <li <c:if test="${subNm=='cardiv'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/cardivList.do' />">차종 관리</a></li>
                    <li <c:if test="${subNm=='point'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/point/couponList.do' />">포인트관리</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='community'}">
                <h3>커뮤니티</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='otoinq'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/otoinqList.do' />">1:1 문의</a></li>
                    <li <c:if test="${subNm=='useepil'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/useepilList.do' />">상품평 관리</a></li>
                    <li <c:if test="${subNm=='useepilAdd'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/useepilAdd.do' />">상품평 추가</a></li>
                    <li <c:if test="${subNm=='bbsNOTICE'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=NOTICE">공지사항</a></li>
                    <li <c:if test="${subNm=='scc'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/etc/sccList.do'/>">홍보영상</a></li>
                    <li <c:if test="${subNm=='bbsNEWS'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=NEWS">보도자료</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='rsv'}">
                <h3>예약/구매관리</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='rsv'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/rsvList.do' />">예약 관리</a></li>
                    <li <c:if test="${subNm=='rsvSv'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/rsvSvList.do' />">제주특산/기념품 구매 관리</a></li>
                    <li <c:if test="${subNm=='rsv2'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/rsvAtPrdtList.do' />">상품별 예약 관리</a></li>
                    <li <c:if test="${subNm=='refund'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/refundRsvList.do' />">환불요청 예약 관리</a></li>
                    <li <c:if test="${subNm=='adminRsvReg'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/adminRsvRegExcel.do?corpDiv=SV' />">관리자 예약(EXCEL)</a></li>
<%--                    <li <c:if test="${subNm=='rsvAv'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/rsvAvList.do' />"><del>항공 예약 관리</del></a></li>--%>
                </ul>
            </c:when>
            <c:when test="${menuNm=='maketing'}">
                <h3>마케팅 관리</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='sms'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/smsForm.do' />">문자 전송</a></li>
                    <li <c:if test="${subNm=='email'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/emailForm.do' />">E-Mail 전송</a></li>
                    <li <c:if test="${subNm=='evnt'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/evntInfList.do' />">이벤트 정보 관리</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='site'}">
                <h3>사이트 관리</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='main'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/mainConfig.do' />">메인 관리</a></li>
                    <li <c:if test="${subNm=='brandShop'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/brandShopConfig.do' />">브랜드 관리</a></li>
                    <li <c:if test="${subNm=='event'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/eventList.do' />">프로모션</a></li>
                    <li <c:if test="${subNm=='curation'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/svCrtnList.do' />">제주특산/기념품 큐레이션</a></li>
                    <li <c:if test="${subNm=='kwa'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/kwaList.do' />">해시태그 광고 관리</a></li>
                    <li <c:if test="${subNm=='bestprdt'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/bestprdtList.do' />">베스트상품 관리</a></li>
                    <li <c:if test="${subNm=='pick'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/mdsPickList.do' />">MD's Pick 관리</a></li>
                    <li <c:if test="${subNm=='banner'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/bannerList.do' />">배너 관리</a></li>
                    <li <c:if test="${subNm=='file'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/fileList.do' />">파일 관리</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='adjust'}">
                <h3>정산</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='adj'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/adjList.do' />">정산 관리</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='anls'}">
            <%-- <h3>통계</h3>
            <ul class="list-group mb-3">
                <li <c:if test="${subNm=='anls06'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/anls06.do' />">매출통계</a></li>
                <li <c:if test="${subNm=='anls05'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/anls05.do' />">고객통계</a></li>
                <li <c:if test="${subNm=='anls03'}">class="on list-group-item"</c:if>><a href="<c:url value='/oss/anls03.do' />">일별현황</a></li>
            </ul> --%>
            </c:when>
            <c:when test="${menuNm=='bis'}">
                <h3>BI시스템</h3>
                <ul class="list-group mb-3">
                    <%--<li <c:if test="${subNm=='cusUse'}">class="on list-group-item"</c:if>><a href="/oss/bisCusUse.do">고객이용 통계</a></li>--%>
                    <li <c:if test="${subNm=='corp'}">class="on list-group-item"</c:if>><a href="/oss/bisCorp.do">입점업체 통계</a></li>
                    <li <c:if test="${subNm=='dayCorp'}">class="on list-group-item"</c:if>><a href="/oss/bisDayCorpAnls.do">입점업체 현황</a></li>
                    <li <c:if test="${subNm=='day'}">class="on list-group-item"</c:if>><a href="/oss/bisDayPresentCondition.do">일일 현황</a></li>
                    <li <c:if test="${subNm=='sale'}">class="on list-group-item"</c:if>><a href="/oss/bisSaleYear.do">판매 통계</a></li>
                    <li <c:if test="${subNm=='prdtSale'}">class="on list-group-item"</c:if>><a href="/oss/bisSaleYear.do">상품별 판매통계</a></li>
                    <li <c:if test="${subNm=='adj'}">class="on list-group-item"</c:if>><a href="/oss/bisAdj.do">정산 통계</a></li>
                </ul>
            </c:when>
            <c:when test="${menuNm=='mntr'}">
                <h3>모니터링</h3>
                <ul class="list-group mb-3">
                    <li <c:if test="${subNm=='tlCancelErrList'}">class="on list-group-item"</c:if>><a href="/oss/tlCancelErrList.do">TL린칸 취소전송 오류</a></li>
                    <li <c:if test="${subNm=='tlCorpList'}">class="on list-group-item"</c:if>><a href="/oss/tlCorpList.do">TL린칸 연동 업체</a></li>
                    <li <c:if test="${subNm=='lsProductList'}">class="on list-group-item"</c:if>><a href="/oss/lsProductList.do">관광지API상품현황</a></li>
                    <li <c:if test="${subNm=='lsCompanyList'}">class="on list-group-item"</c:if>><a href="/oss/lsCompanyList.do">관광지API업체현황</a></li>
                    <li <c:if test="${subNm=='pointRsvErrList'}">class="on list-group-item"</c:if>><a href="/oss/pointRsvErrList.do">포인트 결제 오류</a></li>
                </ul>
            </c:when>
        </c:choose>
    </div>
    <!--//사이드메뉴-->
    <!--접속정보-->
    <div class="side_log">
        <!--닫혀있을 때-->
        <%-- <div class="close_lay lay_none"> <strong>접속정보</strong><span class="btn"><a href="#"><img src="<c:url value='/images/btn/open_btn01.gif' />" alt="열기" /></a></span> </div> --%>
        <!--//닫혀있을 때-->
        <!--열려있을 때-->
        <div class="open_lay">
            <dl>
                <dt>메일:</dt>
                <dd>${loginInfo.email}</dd>
                <dt>성명:</dt>
                <dd>${loginInfo.userNm}</dd>
                <dt>접속:</dt>
                <dd>${loginInfo.lastLoginIp}</dd>
            </dl>
            <%-- <p class="btn"><a href="#"><img src="<c:url value='/images/oss/btn/close_btn01.gif'/>" alt="닫기" /></a></p> --%>
        </div>
        <!--//열려있을 때-->
    </div>
    <!--//접속정보-->
    <!--사이트바로가기-->
    <!-- <ul class="side_go_link">
        <li class="list-group-item">
            <select name="g_link_url" class="full" onchange="MM_openNewWindow(this.value);">
                <option value="">== 사이트 바로가기 ==</option>
                <option value="">바로가기 사이트 추가</option>
            </select>
        </li>
    </ul> -->
    <!--//사이트바로가기-->
</div>

<div id="div_blank" class="lay_popup lay_ct" style="display:none;">
    <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_blank'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
    <div id="div_blank_htnl"></div>
</div>