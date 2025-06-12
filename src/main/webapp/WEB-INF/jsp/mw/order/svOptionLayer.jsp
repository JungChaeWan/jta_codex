<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<div class="option-change option-change4">
	<div class="option-wrap">
		<div class="option-title">변경할 옵션을 선택해주세요</div>
		<p class="goods-info">
			<form id="svCalendarForm">
				<input type="hidden" name="saleStartDt" id="saleStartDt" value="${prdtInfo.saleStartDt }" />
				<input type="hidden" name="saleEndDt" id="saleEndDt" value="${prdtInfo.saleEndDt}" />
				<input type="hidden" name="svDivSn" id="svDivSn" value="${cartInfo.svDivSn}" />
				<input type="hidden" name="svOptSn" id="svOptSn" value="${cartInfo.svOptSn}" />
				<input type="hidden" name="prdtNum" id="prdtNum" value="${prdtInfo.prdtNum}" />
				<input type="hidden" name="addOptAmt" id="addOptAmt" value="${cartInfo.addOptAmt}" />
				<input type="hidden" name="addOptNm" id="addOptNm" value="${cartInfo.addOptNm}" />
				<input type="hidden" name="addOptListLength" id="addOptListLength" value="${fn:length(addOptList)}" />
			</form>
<%--			<img src="${prdtInfo.savePath}thumb/${prdtInfo.saveFileNm}" width="95" alt="${prdtInfo.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">--%>
<%--			<strong>${prdtInfo.prdtNm}</strong>--%>
			${prdtInfo.prdtInf}
		</p>
        <dl class="view-select comm-select comm-select3">
            <dt title="옵션 선택">옵션 선택</dt>
            <dd class="in in2" style="display:none">
                <ul class="select-list-option" id="secondOptionList">
                </ul>
            </dd>
        </dl>
        <c:if test="${fn:length(addOptList) > 0}">
            <dl class="view-select comm-select comm-select4">
                <dt title="추가옵션 선택">
                    <c:if test="${empty cartInfo.addOptNm}">추가옵션 선택</c:if>
                    <c:if test="${not empty cartInfo.addOptNm}"><c:out value="${cartInfo.addOptNm}" /></c:if>
                </dt>
                <dd class="in in2" style="display:none">
                    <ul class="select-list-option" id="addOptionList">
                    </ul>
                </dd>
            </dl>
        </c:if>
        <div class="receipt-option-area">
            <select name="directRecvYn" >
                <c:if test="${prdtInfo.deliveryYn == 'Y'}">
                    <option value="N" <c:if test="${cartInfo.directRecvYn != 'Y'}">selected="selected"</c:if> >일반 택배</option>
                </c:if>
                <c:if test="${prdtInfo.directRecvYn == 'Y'}">
                    <option value="Y" <c:if test="${cartInfo.directRecvYn == 'Y'}">selected="selected"</c:if> >직접 수령</option>
                </c:if>
            </select>
        </div>
		<div class="comm-qtyWrap" id="selectedItemWrapper">
			<ul>
				<li class="qty-list">
					<ol>
						<li class="list1"></li>
						<li class="list2">
							<input type="text" id="qty" value="${cartInfo.qty}">
							<button class="addition" onclick="SvAddition(); return false;">
								<img src="/images/mw/cart/plus.png" alt="더하기">
							</button>
							<button class="subtract" onclick="SvSubstract(); return false;">
								<img src="/images/mw/cart/minus.png" alt="빼기">
							</button>
						</li>
					</ol>
				</li>
			</ul>
		</div>
		<p class="price">합계 <strong id="vTotalAmt"><fmt:formatNumber>${cartInfo.totalAmt}</fmt:formatNumber></strong>원</p>
		<div class="option-btn">
			<p class="btn-close"><a href="#">취소</a></p>
			<p class="btn-right"><a href="javascript:changeOptionCartSv(${cartInfo.cartSn})" class="btn btn1">변경</a></p>
		</div>
	</div>
</div> <!--//option-box(렌터카)-->
