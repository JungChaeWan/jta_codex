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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

	<!--Vue.js include-->
	<script src="/js/vue.js?version=${nowDate}"></script>
	<script src="/js/axios.min.js?version=${nowDate}"></script>
	<script src="/js/vue/validate.js?version=${nowDate}"></script>
	<script src="/js/browser.js"></script>

	<meta charset="utf-8">
	<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

	<title></title>
	<script type="text/babel">

		Vue.use(CommonPlugin)
		const isState = "${user.userId}"=="" ? true:false;
		const wrapper = new Vue({
			el: "#wrapper",
			data() {
				return {
					errors: [],
					userNm: "${user.userNm}",
					telNum: "${user.telNum}",
					bth: "${user.bth}",
					telNumChk: isState ? "N":"Y",
					email: "${user.email}",
					email_host: "${user.email_host}",
					emailChk: isState ? "N":"Y",
					email_host_s: isState ? "etc":"${user.email_host}",
					pwd: "${user.pwd}",
					pwd_re: "${user.pwd}",
					badUserRsn: "${user.badUserRsn}",
					txt: {
						state: isState ? "등록":"수정",
					}
				}
			},
			methods: {
				//저장
				fn_InsUser: function() {
					//valuidation check
					console.log($("select[name=authNm]").val());
					console.log($("#partnerCode").val().length);
					if($("select[name=authNm]").val() == "USER" && $("#partnerCode").val() != ""){
						alert("파트너 코드 등록시 사용자 등급을 관리자로 설정해 주시기 바랍니다.");
						return;
					}
					validation_errors = [];// error count 초기화 / CommonPlugin에서 정의한 전역 변수
					//validate 파라미터 (필드값, id, 문구, maxlength)
					Vue.validate(this.userNm, "userNm", "사용자명을", 20)
					Vue.validate(this.telNum, "telNum", "연락처를", 13)
					Vue.validate(this.email + "@" + this.email_host, "이메일을", 50)
					Vue.validEmail(this.email + "@" + this.email_host)
					if(isState) Vue.validate(this.pwd, "pwd", "비밀번호를", 20)

					if (!validation_errors.length) {
						if (this.telNumChk == "N"){
							alert("연락처 중복체크를 해주세요.");
							$("#telNum").focus();
							return;
						}
						if (this.emailChk == "N"){
							alert("이메일 중복체크를 해주세요.")
							$("#email").focus()
							return
						}
						if (isState) {
							if (this.pwd != this.pwd_re) {
								alert("비밀번호가 일치하지 않습니다.");
								$("#pwd_re").focus();
								return;
							}
						}
						document.USERVO.submit();
					}
				},
				//이메일 중복 체크
				fn_EmailDuplicationChk: function() {
					//valuidation check
					validation_errors = [];
					Vue.validEmail(this.email + "@" + this.email_host)

					if (!validation_errors.length) {
						let params = new URLSearchParams();
						params.append('email', this.email + "@" + this.email_host);
						axios.post("/emailDuplication.ajax", params).then(function (response) {
							if (response.data.chk == "Y"){
								alert("이미 사용 중 입니다.")
							}else{
								this.emailChk = "Y"
								alert("사용 가능한 이메일 입니다.")
							}
						}.bind(this)).catch(function (e) {
							console.error(e)
						})
					}
				},
				//연락처 중복 체크
				fn_TelDuplicationChk: function() {
					//valuidation check
					validation_errors = [];
					Vue.validate(this.telNum, "telNum", "연락처를", 13)

					if (!validation_errors.length) {
						let params = new URLSearchParams();
						params.append('telNum', this.telNum);
						axios.post("/telDuplication.ajax", params).then(function (response) {
							if (response.data == 0){
								alert("이미 사용 중 입니다.")
							}else{
								this.telNumChk = "Y"
								alert("사용 가능한 전화 번호 입니다.")
							}
						}.bind(this)).catch(function (e) {
							console.error(e)
						})
					}
				},
				//이메일 변경
				fn_EmailOnchange: function() {
					this.emailChk = "N"
				},
				//연락처 변경
				fn_TelOnchange: function() {
					this.telNumChk = "N"
				},
				//selectbox email 호스트 변경
				fn_EmailHostOnchange: function(e) {
					this.email_host = this.email_host_s == "etc"? "":this.email_host_s
				},
				//목록
				fn_ListUser: function(){
					$("form").attr("action","/oss/userList.do").submit();
				}
			}
		});
	</script>
    <script type="text/javascript">

        /**
         * DAUM 연동 주소찾기
         */
        function openDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                    // document.getElementById('post1').value = data.postcode1;
                    // document.getElementById('post2').value = data.postcode2;
                    // 2015.08.01 부터 우편번호 5자리 실행
                    document.getElementById('postNum').value = data.zonecode;
                    document.getElementById('roadNmAddr').value = data.address;

                    //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
                    //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
                    //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
                    //document.getElementById('addr').value = addr;

                    document.getElementById('dtlAddr').focus();
                }
            }).open();
        }
    </script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=user" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=user&sub=user" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="USERVO" method="post" action="/oss/insertUser.do">
				<input type="hidden" name="sUserNm" value="${searchVO.sUserNm}" />
				<input type="hidden" name="sUserId" value="${searchVO.sUserId}" />
				<input type="hidden" name="sTelNum" value="${searchVO.sTelNum}" />
				<input type="hidden" name="sEmail" value="${searchVO.sEmail}" />
				<input type="hidden" name="sCorpAdminDiv" value="${searchVO.sCorpAdminDiv}" />
				<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}" />
				<input type="hidden" name="userId" value="${user.userId}" />
				<!--본문-->
				<!--상품 등록-->
				<div id="contents">
					<h4 class="title03">사용자 {{txt.state}}</h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>사용자 등급</th>
							<td >
								<select id="authNm" name="authNm">
									<option value="USER" <c:if test="${user.authNm == 'USER'}">selected="selected"</c:if>>일반사용자</option>
									<option value="ADMIN" <c:if test="${user.authNm == 'ADMIN'}">selected="selected"</c:if>>관리자</option>
								</select>
							</td>
							<th>파트너 코드</th>
							<td >
								<input id="partnerCode" name="partnerCode" class="input_text20" placeholder="파트너 코드를 입력 해 주세요." value="${user.partnerCode}" /> 탐나오직원은 tamnao 입력
							</td>
						</tr>
						<tr>
							<th scope="row">사용자명<span class="font02">*</span></th>
							<td>
								<input v-model="userNm" id="userNm" name="userNm" class="input_text10" placeholder="사용자명을 입력하세요." />
							</td>
							<th>연락처<span class="font02">*</span></th>
							<td>
								<input v-model="telNum" id="telNum" name="telNum" class="input_text10" placeholder="연락처를 입력하세요." @keyup="Vue.getPhoneMask('telNum',telNum)"  @input="fn_TelOnchange" />
								<div class="btn_sty07"><span><a href="#" @click.prevent="fn_TelDuplicationChk">중복체크</a></span></div>
							</td>
						</tr>
						<tr>
							<th scope="row">성별<span class="font02"></span></th>
							<td>
								<input type="radio" name="sex" id="sex1" value="M" <c:if test="${user.sex=='M'}">checked="checked"</c:if> /> <label for="sex1">남자</label>
								<input type="radio" name="sex" id="sex2" value="F" <c:if test="${user.sex=='F'}">checked="checked"</c:if> /> <label for="sex2">여자</label>
							</td>
							<th>생년월일<span class="font02"></span></th>
							<td>
								<input v-model="bth" id="bth" name="bth" class="input_text10" placeholder="생년월일을 입력하세요." maxlength="8" />(형식: 20001010)
							</td>
						</tr>
						<tr>
							<th>이메일<span class="font02">*</span></th>
							<td colspan="3">
								<input v-model="email" type="text" name="email" id="email" class="input_text10" @input="fn_EmailOnchange" /> @
								<input v-model="email_host" type="text" name="email_host" id="email_host" @input="fn_EmailOnchange" />
								<select v-model="email_host_s" name="email_host_s" class="input_text10" id="email_host_s" title="E-mail 호스트 주소를 선택합니다." @change="fn_EmailHostOnchange">
									<option value="etc">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
								</select>
								<div class="btn_sty07"><span><a href="#" @click.prevent="fn_EmailDuplicationChk">중복체크</a></span></div>
							</td>
						</tr>
						<tr v-if="txt.state == '등록'">
							<th>비밀번호<span class="font02">*</span></th>
							<td>
								<input v-model="pwd" id="pwd" name="pwd" type="password" class="input_text10" />
							</td>
							<th>비밀번호 확인<span class="font02">*</span></th>
							<td>
								<input v-model="pwd_re" id="pwd_re" name="pwd_re" type="password" class="input_text10" />
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
								<input id="postNum" name="postNum" readonly="readonly" class="input_text5" value="${user.postNum}" /> <br/>
								<input id="roadNmAddr" name="roadNmAddr" class="input_text15" value="${user.roadNmAddr}"  />
								<input id="dtlAddr" name="dtlAddr" class="input_text15" value="${user.dtlAddr}" />
							</td>
						</tr>
						<tr>
							<th>마케팅 수신여부</th>
							<td>
								<input type="radio" name="marketingRcvAgrYn" id="marketingRcvAgrYn1" value="Y" <c:if test="${user.marketingRcvAgrYn=='Y' or empty user.marketingRcvAgrYn}">checked="checked"</c:if> /> <label for="marketingRcvAgrYn1">동의</label>
								<input type="radio" name="marketingRcvAgrYn" id="marketingRcvAgrYn2" value="N" <c:if test="${user.marketingRcvAgrYn=='N'}">checked="checked"</c:if> /> <label for="marketingRcvAgrYn2">미동의</label>
							</td>
						</tr>
						<tr>
							<th>블랙리스트 여부</th>
							<td colspan="3">
								<input type="radio" name="badUserYn" id="badUserYn2" value="N" <c:if test="${user.badUserYn=='N' or empty user.badUserYn}">checked="checked"</c:if> /> <label for="badUserYn2">일반고객</label>
								<input type="radio" name="badUserYn" id="badUserYn1" value="Y" <c:if test="${user.badUserYn=='Y' }">checked="checked"</c:if> /> <label for="badUserYn1">블랙리스트</label>
							</td>
						</tr>
						<tr>
							<th>블랙리스트 사유</th>
							<td colspan="3">
								<textarea v-model="badUserRsn" name="badUserRsn" id="badUserRsn" rows="5" cols="10"></textarea>
							</td>
						</tr>
					</table>
					<ul class="btn_rt01">
						<li class="btn_sty04">
							<a href="#" @click.prevent="fn_InsUser">{{txt.state}}</a>
						</li>
						<li class="btn_sty01">
							<a href="#" @click.prevent="fn_ListUser()">목록</a>
						</li>
					</ul>
				</div>
			</form>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>