<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<aside id="sub-leftMenu" class="smON">
    <h4 class="title">
        <a href="<c:url value='/web/coustmer/qaList.do'/>" class="title-text">고객센터</a>
    </h4>
    <div class="pdWrap">
        <section>
            <a href="<c:url value='/web/coustmer/qaList.do'/>">
               <h3 <c:if test="${param.menuIndex eq '0'}">class="select"</c:if>>자주하는 문의(FAQ)</h3>
            </a>
        </section>
        <section>
            <a href="<c:url value='/web/coustmer/useepilList.do?menuIndex=1'/>">
                <h3 <c:if test="${param.menuIndex eq '1'}">class="select"</c:if>>이용후기</h3></a>
            </a>
        </section>
        <section>
            <a href="<c:url value='/web/coustmer/viewCorpPns.do?menuIndex=2'/>">
                <h3 <c:if test="${param.menuIndex eq '2'}">class="select"</c:if>>입점/제휴 안내</h3></a>
            </a>
        </section>
        <section>
            <a href="<c:url value='/web/bbs/bbsList.do?bbsNum=NOTICE&menuIndex=3'/>">
                <h3 <c:if test="${param.menuIndex eq '3'}">class="select"</c:if>>공지사항</h3>
            </a>
        </section>
    </div>
</aside>
<aside class="lnb_cs">
    <!-- 0718 채널(상담톡) 오픈 -->
<%--    <article class="operation_guide">--%>
<%--        <a href="#" onclick="fn_ChannelTalkOpen()">--%>
<%--            <dl class="operation_guide_chat" aria-label="채널톡이용">--%>
<%--                <dt>--%>
<%--                    1:1 채팅상담 <br><span>채널톡 상담 바로가기</span>--%>
<%--                </dt>--%>
<%--                <dd>--%>
<%--                    * 평일 09~18시 (점심시간 12~13시) <br> <span class="closed">주말/공휴일 휴무</span>--%>
<%--                </dd>--%>
<%--            </dl>--%>
<%--        </a>--%>
<%--    </article>--%>
    <!-- //0718 채널(상담톡) 오픈 -->
</aside>

<!-- Channel Plugin Scripts -->
<script type="text/javascript">
    (function () {
        var w = window;
        if (w.ChannelIO) {
            return (window.console.error || window.console.log || function () {
            })('ChannelIO script included twice.');
        }
        var ch = function () {
            ch.c(arguments);
        };
        ch.q = [];
        ch.c = function (args) {
            ch.q.push(args);
        };
        w.ChannelIO = ch;

        function l() {
            if (w.ChannelIOInitialized) {
                return;
            }
            w.ChannelIOInitialized = true;
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.async = true;
            s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
            s.charset = 'UTF-8';
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
        }

        if (document.readyState === 'complete') {
            l();
        } else if (window.attachEvent) {
            window.attachEvent('onload', l);
        } else {
            window.addEventListener('DOMContentLoaded', l, false);
            window.addEventListener('load', l, false);
        }
    })();
    ChannelIO('boot', {
        "pluginKey": "62a3a6fb-54cf-4be8-a55e-81525bfefd17",
        "memberId" : "${userId}",
        "profile"  : {
            "name" : "${userNm}",
            "email": "${email}",
            "mobileNumber" : "${mobileNumber}"
            // "CUSTOM_VALUE_1": "VALUE_1", //any other custom meta data
            // "CUSTOM_VALUE_2": "VALUE_2"
        },
        "hideChannelButtonOnBoot": true
    });

    function fn_ChannelTalkOpen() {
        if ('${channelTalkOutDayCnt}' != '0'){
            alert("현재 1:1채팅 상담이 가능하지 않습니다.");
            return;
        }

        ChannelIO('showMessenger');
    }
</script>
