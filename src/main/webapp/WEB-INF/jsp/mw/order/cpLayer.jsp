<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<script>
    var couponAnnounceChk = true;
    $(document).ready(function() {
        $("input[name=cpChk]").click(function(){
            if($(this).parent().next().text().indexOf("탐나는전") > 0  ){
                if(!confirm("해당쿠폰은 탐나는전(지역화폐) 결제로만 가능한 쿠폰입니다.\r* 일반결제로는 사용할 수 없는 쿠폰입니다.\r쿠폰을 적용하시겠습니까?")){
                    $("input[name=cpChk]").prop("checked",false);
                }
            }else if(couponAnnounceChk){
                alert("할인쿠폰 사용 예약/구매 건의 경우 취소 시 쿠폰 반환을 우선으로 합니다.");
                couponAnnounceChk = false;
            }
            /*alert("할인쿠폰 사용 예약/구매 건의 경우 취소 시 쿠폰 반환을 우선으로 합니다.");
            couponAnnounceChk = false;*/
        });

        //checkbox → radio 기능
        $('input[type="checkbox"][name="cpChk"]').click(function(){

            if($(this).prop('checked')){

                $('input[type="checkbox"][name="cpChk"]').prop('checked',false);

                $(this).prop('checked',true);
            }
        });
    });
</script>
<!-- 팝업 -->
<a href="javascript:void(0)" class="btn btn7" onclick="fn_CpLayerClose(this);"></a>
<table>
    <thead>
        <tr>
            <th>선택</th>
            <th>쿠폰명</th>
            <th>금액</th>
            <th>유효기간</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${fn:length(cpList) == 0}">
            <tr>
                <td colspan="4">적용가능한 쿠폰이 없습니다.</td>
            </tr>
        </c:if>
    	<c:forEach var="cpInfo" items="${cpList}" varStatus="status">
            <c:if test="${cpInfo.useYn ne 'Y'}">
                <c:if test="${saleAmt >= cpInfo.buyMiniAmt}">
                    <fmt:parseNumber var="limitCnt" value="${cpInfo.limitCnt}" />
                    <fmt:parseNumber var="issueCnt" value="${cpInfo.issueCnt}" />
                    <fmt:parseNumber var="useCnt" value="${cpInfo.useCnt}" />
                    <c:set var="usableYn" value="Y" />
                    <c:if test="${cpInfo.limitType eq 'USAG'}">
                        <c:if test="${limitCnt <= useCnt}">
                            <c:set var="usableYn" value="N" />
                        </c:if>
                    </c:if>
                    <c:if test="${cpInfo.limitType eq 'ISSU'}">
                        <c:if test="${limitCnt <= issueCnt and cpInfo.cpNum eq 'ALL' }">
                            <c:set var="usableYn" value="N" />
                        </c:if>
                        <%--이미받은쿠폰--%>
                        <c:if test="${cpInfo.cpNum ne 'ALL'}">
                            <c:set var="usableYn" value="Y" />
                        </c:if>
                    </c:if>

                    <tr class="cpListTr <c:if test="${(empty cpInfo.useYn) and (usableYn eq 'N')}">hide</c:if>">
                        <td class="center memo-area">
                            <c:if test="${(empty cpInfo.useYn) and (usableYn eq 'Y')}">
                                <button class="comm-btn black" id="btnCoupon${status.index}" onclick="javascript:fn_couponDownload('${cpInfo.cpId}', ${status.index});">받기</button>
                            </c:if>
                            <input type="checkbox" name="cpChk" id="cpChk${status.index}" <c:if test="${(empty cpInfo.useYn) or (usableYn eq 'N')}">class="hide"</c:if>>
                            <c:if test="${usableYn eq 'N'}">
                                <span class="text-red">사용<br>마감</span>
                            </c:if>
                        </td>
                        <td>
                            <input type="hidden" name="cpNum" id="cpNum${status.index}" value="${cpInfo.cpNum}">
                            <c:set var="cpTypes">${Constant.CP_DIS_DIV_PRICE},${Constant.USER_CP_DIV_UEPI},${Constant.USER_CP_DIV_UAPP},${Constant.USER_CP_DIV_AEVT}</c:set>
                            <c:if test="${fn:contains(cpTypes, cpInfo.disDiv)}">
                                <input type="hidden" name="disAmt" value="${cpInfo.disAmt}" />
                            </c:if>
                            <c:if test="${fn:contains(cpTypes, cpInfo.disDiv) eq false}">
                            	<%-- AS-IS 할인율적용
                                <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                    <input type="hidden" name="disAmt" value="<fmt:formatNumber pattern="####" maxFractionDigits="0">${saleAmt * (cpInfo.disPct / 100)}</fmt:formatNumber>" />
                                </c:if>
                                --%>
                                <%-- 할인율적용 --%>
                                <c:if test="${(cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE) and (cpInfo.limitAmt eq 0)}">
                                	<input type="hidden" name="disAmt" value="<fmt:formatNumber pattern="####" maxFractionDigits="0">${saleAmt * (cpInfo.disPct / 100)}</fmt:formatNumber>" />
                                </c:if>
                                <%-- 최대할인금액적용(할인율) --%>
                                <c:if test="${(cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE) and (cpInfo.limitAmt > 0)}">
                                	<c:choose>
                            			<c:when test="${(saleAmt * (cpInfo.disPct / 100)) >=  cpInfo.limitAmt}">
                            				<input type="hidden" name="disAmt" value="<fmt:formatNumber pattern="####" maxFractionDigits="0">${cpInfo.limitAmt}</fmt:formatNumber>" />
                            			</c:when>
                            			<c:otherwise>
                            				<input type="hidden" name="disAmt" value="<fmt:formatNumber pattern="####" maxFractionDigits="0">${saleAmt * (cpInfo.disPct / 100)}</fmt:formatNumber>" />
                            			</c:otherwise>
                            		</c:choose>
                                </c:if>
                                <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                    <input type="hidden" name="disAmt" value="${saleAmt}" />
                                </c:if>
                                <c:if test="${fn:trim(cpInfo.disDiv) eq ''}">
                                    <input type="hidden" name="disAmt" value="0" />
                                </c:if>
                            </c:if>
                            <input type="hidden" name="cpNm" value="${cpInfo.cpNm}" />
                            <input type="hidden" name="cpDiv" value="${cpInfo.cpDiv}" />
                            <input type="hidden" name="buyMiniAmt" value="${cpInfo.buyMiniAmt}" />
                            <input type="hidden" name="prdtCtgrList" value="${cpInfo.prdtCtgrList}" />
                            <input type="hidden" name="disDiv" value="${cpInfo.disDiv}" />
                            <input type="hidden" name="disPct" value="${cpInfo.disPct}" />
                            <input type="hidden" name="aplprdtDiv" value="${cpInfo.aplprdtDiv}" />
                            <input type="hidden" name="useYn" value="${cpInfo.useYn}" />
                            <input type="hidden" name="cpCode" value="${cpInfo.cpCode}" />
                            <input type="hidden" name="prdtNum" value="${cpInfo.prdtNum}" />
                            <input type="hidden" name="corpId" value="${cpInfo.corpId}" />
                            <input type="hidden" name="prdtUseNum" value="${cpInfo.prdtUseNum}" />
                            <input type="hidden" name="optSn" value="${cpInfo.optSn}" />
                            <input type="hidden" name="optDivSn" value="${cpInfo.optDivSn}" />
							<input type="hidden" name="limit" value="${cpInfo.limitAmt}" />
                            <c:if test="${usableYn eq 'N'}"><del></c:if>
                            ${cpInfo.cpNm}
                            <c:if test="${usableYn eq 'N'}"></del></c:if>
                        </td>
                        <td class="center">
                            <c:if test="${usableYn eq 'N'}"><del></c:if>
                            <%-- 할인금액적용 --%>
                            <c:if test="${fn:contains(cpTypes, cpInfo.disDiv)}">
                                <fmt:formatNumber>${cpInfo.disAmt}</fmt:formatNumber>원
                                <c:if test="${cpInfo.buyMiniAmt > 0}">
                                    <br><span class="event-label text-red">(<fmt:formatNumber>${cpInfo.buyMiniAmt}</fmt:formatNumber>원 이상)</span>
                                </c:if>
                            </c:if>
                            <%-- AS-IS 할인율적용
                            <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE }">
                                <fmt:formatNumber>${saleAmt * (cpInfo.disPct / 100)}</fmt:formatNumber>원[${cpInfo.disPct}%]
                                <c:if test="${cpInfo.buyMiniAmt > 0}">
                                    <br><span class="event-label text-red">(<fmt:formatNumber>${cpInfo.buyMiniAmt}</fmt:formatNumber>원 이상)</span>
                                </c:if>
                            </c:if>
                            --%>
                            <c:choose>
                            	<%-- 할인율적용 --%>
                            	<c:when test="${(cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE) and (cpInfo.limitAmt eq 0)}">
	                                <fmt:formatNumber maxFractionDigits="0">${saleAmt * (cpInfo.disPct / 100)}</fmt:formatNumber>원[${cpInfo.disPct}%]
	                                <c:if test="${cpInfo.buyMiniAmt > 0}">
	                                    <br><span class="event-label text-red">(<fmt:formatNumber>${cpInfo.buyMiniAmt}</fmt:formatNumber>원 이상)</span>
	                                </c:if>
                            	</c:when>
                            	<%-- 최대금액적용(할인율)--%>
                            	<c:when test="${(cpInfo.disDiv eq Constant.CP_DIS_DIV_RATE) and (cpInfo.limitAmt > 0)}">
                            		<c:choose>
                            			<c:when test="${(saleAmt * (cpInfo.disPct / 100)) >=  cpInfo.limitAmt}">
                            				<fmt:formatNumber maxFractionDigits="0">${cpInfo.limitAmt}</fmt:formatNumber>원[${cpInfo.disPct}%]
                            			</c:when>
                            			<c:otherwise>
                            				<fmt:formatNumber maxFractionDigits="0">${saleAmt * (cpInfo.disPct / 100)}</fmt:formatNumber>원[${cpInfo.disPct}%]
                            			</c:otherwise>
                            		</c:choose>
                            		<c:choose>
                            			<c:when test="${(cpInfo.buyMiniAmt > 0) and (cpInfo.limitAmt eq 0)}">
                            				<br><span class="event-label text-red">(<fmt:formatNumber>${cpInfo.buyMiniAmt}</fmt:formatNumber>원 이상)</span>
                            			</c:when>
                            			<c:when test="${(cpInfo.buyMiniAmt eq 0) and (cpInfo.limitAmt > 0)}">
                            				<br><span class="event-label text-red">(<fmt:formatNumber>${cpInfo.limitAmt}</fmt:formatNumber>원 이하)</span>
                            			</c:when>
                            			<c:when test="${(cpInfo.buyMiniAmt > 0) and (cpInfo.limitAmt > 0)}">
                            				<br>
                            				<%--<span class="event-label text-red">(<fmt:formatNumber>${cpInfo.buyMiniAmt}</fmt:formatNumber>원 이상</span>--%>
                            				<span class="event-label text-red">(최대 <fmt:formatNumber>${cpInfo.limitAmt}</fmt:formatNumber>원)</span>
                            			</c:when>
                            		</c:choose>
                            	</c:when>
                            </c:choose>
                            <c:if test="${cpInfo.disDiv eq Constant.CP_DIS_DIV_FREE }">
                                	무료
                            </c:if>
                            <c:if test="${usableYn eq 'N'}"></del></c:if>
                        </td>
                        <td>
                            <fmt:parseDate var='startDt' value='${cpInfo.exprStartDt}' pattern="yyyyMMdd" scope="page"/>
                            <fmt:parseDate var='endDt' value='${cpInfo.exprEndDt}' pattern="yyyyMMdd" scope="page"/>
                            <c:if test="${usableYn eq 'N'}"><del></c:if>
                            <p> ~ <fmt:formatDate value="${endDt}" pattern="MM-dd"/></p>
                            <c:if test="${usableYn eq 'N'}"></del></c:if>
                        </td>
                    </tr>
                </c:if>
            </c:if>
    	</c:forEach>
    </tbody>
</table>
<p class="btn-center">
    <a href="javascript:void(0)" class="comm-btn red" onclick="fn_CpLayerOk('${selectSn}');">선택완료</a>
</p>
