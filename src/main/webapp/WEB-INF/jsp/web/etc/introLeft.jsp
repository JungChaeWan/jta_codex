<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<aside id="sub-leftMenu" class="smON">
    <h4 class="title">
        <a href="<c:url value='/web/etc/introduction.do'/>" class="title-text">회사소개</a>
    </h4>
    <div class="pdWrap">
        <section>
            <a href="<c:url value='/web/etc/introduction.do'/>">
                <h3 <c:if test="${param.menuIndex eq '0'}">class="select"</c:if>>회사소개</h3>
            </a>
        </section>
        <section>
            <a href="<c:url value='/web/etc/socialContribution.do?menuIndex=1'/>">
                <h3 <c:if test="${param.menuIndex eq '1'}">class="select"</c:if>>사회공헌</h3>
            </a>
        </section>
        <section>
            <a href="<c:url value='/web/etc/sccList.do?menuIndex=2'/>">
                <h3 <c:if test="${param.menuIndex eq '2'}">class="select"</c:if>>홍보영상</h3>
            </a>
        </section>
    </div>
</aside>

