package oss.user.vo;

public class USERVO extends USERSVO{
	/** 순번 */
	private String rn;
	/** 사용자 아이디 */
	private String userId;
	/** 권한 명 */
	private String authNm;
	/** 사용자 명 */
	private String userNm;
	/** 이메일 */
	private String email;
	/** 이메일 호스트 */
	private String email_host;
	/** 전화 번호 */
	private String telNum;
	/** 패스워드 */
	private String pwd;
	/** 새로운 패스워드 */
	private String newPwd;
	/** 우편번호 */
	private String postNum;
	/** 도로명 주소 */
	private String roadNmAddr;
	/** 상세 주소 */
	private String dtlAddr;
	/** 이메일 수신 동의 여부 */
	private String emailRcvAgrYn;
	/** SMS 수신 동의 여부 */
	private String smsRcvAgrYn;
	/** 탈퇴 여부 */
	private String qutYn;
	/** 최종 로그인 일시 */
	private String lastLoginDttm;
	/** 최종 로그인 아이피 */
	private String lastLoginIp;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최종 수정 일시 */
	private String lastModDttm;
	/** SMS 인증 번호 */
	private String smsAuthNum;
	/** 탈퇴 사유 */
	private String qutRsn;

	/** 로그인 모드-"":회원/비회원 조회, "user":사용자, "pay":결제  */
	private String mode;

	// 업체로 로그인 시 필요 항목
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 업체 코드 */
	private String corpCd;
	/** 업체 서브 코드 */
	private String corpSubCd;
	/** 거래 상태 코드 */
	private String tradeStatusCd;
	/** 입점업체 관리자 여부 */
	private String corpAdmYn;
	/** 업체 이메일 */
	private String corpEmail;
	/** 예약 전화 번호 */
	private String rsvTelNum;

	private String badUserYn;
	private String badUserRsn;
	private String sex;
	private String bth;
	
	private String restYn;
	
	/** SNS 구분 */
	private String snsDiv;
	/** 로그인 키 */
	private String loginKey;
	private String token;
	/** 마케팅동의 여부*/
	private String marketingRcvAgrYn;

	/** 파트너코드*/
	private String partnerCd;
	/** 파트너명*/
	private String partnerNm;
	/** 파트너 접속횟수*/
	private String totalAccessCnt;
	/** 포인트 파트너코드*/
	private String partnerCode;
	/** 발급 포인트 */
	private int plusPoint;
	/** 사용 포인트 */
	private int minusPoint;

	/** 통계년도 */
	private String year;
	/** 통계월 */
	private String mm;
	/** 접속수 */
	private String accessCnt;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAuthNm() {
		return authNm;
	}
	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPostNum() {
		return postNum;
	}
	public void setPostNum(String postNum) {
		this.postNum = postNum;
	}
	public String getRoadNmAddr() {
		return roadNmAddr;
	}
	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}
	public String getDtlAddr() {
		return dtlAddr;
	}
	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}
	public String getEmailRcvAgrYn() {
		return emailRcvAgrYn;
	}
	public void setEmailRcvAgrYn(String emailRcvAgrYn) {
		this.emailRcvAgrYn = emailRcvAgrYn;
	}
	public String getSmsRcvAgrYn() {
		return smsRcvAgrYn;
	}
	public void setSmsRcvAgrYn(String smsRcvAgrYn) {
		this.smsRcvAgrYn = smsRcvAgrYn;
	}
	public String getQutYn() {
		return qutYn;
	}
	public void setQutYn(String qutYn) {
		this.qutYn = qutYn;
	}
	public String getLastLoginDttm() {
		return lastLoginDttm;
	}
	public void setLastLoginDttm(String lastLoginDttm) {
		this.lastLoginDttm = lastLoginDttm;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getEmail_host() {
		return email_host;
	}
	public void setEmail_host(String email_host) {
		this.email_host = email_host;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getTradeStatusCd() {
		return tradeStatusCd;
	}
	public void setTradeStatusCd(String tradeStatusCd) {
		this.tradeStatusCd = tradeStatusCd;
	}
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	public String getSmsAuthNum() {
		return smsAuthNum;
	}
	public void setSmsAuthNum(String smsAuthNum) {
		this.smsAuthNum = smsAuthNum;
	}
	public String getCorpSubCd() {
		return corpSubCd;
	}
	public void setCorpSubCd(String corpSubCd) {
		this.corpSubCd = corpSubCd;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCorpAdmYn() {
		return corpAdmYn;
	}
	public void setCorpAdmYn(String corpAdmYn) {
		this.corpAdmYn = corpAdmYn;
	}
	public String getQutRsn() {
		return qutRsn;
	}
	public void setQutRsn(String qutRsn) {
		this.qutRsn = qutRsn;
	}
	public String getCorpEmail() {
		return corpEmail;
	}
	public void setCorpEmail(String corpEmail) {
		this.corpEmail = corpEmail;
	}
	public String getRsvTelNum() {
		return rsvTelNum;
	}
	public void setRsvTelNum(String rsvTelNum) {
		this.rsvTelNum = rsvTelNum;
	}
	public String getBadUserYn() {
		return badUserYn;
	}
	public void setBadUserYn(String badUserYn) {
		this.badUserYn = badUserYn;
	}
	public String getBadUserRsn() {
		return badUserRsn;
	}
	public void setBadUserRsn(String badUserRsn) {
		this.badUserRsn = badUserRsn;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBth() {
		return bth;
	}
	public void setBth(String bth) {
		this.bth = bth;
	}
	public String getRestYn() {
		return restYn;
	}
	public void setRestYn(String restYn) {
		this.restYn = restYn;
	}
	public String getSnsDiv() {
		return snsDiv;
	}
	public void setSnsDiv(String snsDiv) {
		this.snsDiv = snsDiv;
	}
	public String getLoginKey() {
		return loginKey;
	}
	public void setLoginKey(String loginKey) {
		this.loginKey = loginKey;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getMarketingRcvAgrYn() {
		return marketingRcvAgrYn;
	}

	public void setMarketingRcvAgrYn(String marketingRcvAgrYn) {
		this.marketingRcvAgrYn = marketingRcvAgrYn;
	}

	public String getPartnerCd() {
		return partnerCd;
	}

	public void setPartnerCd(String partnerCd) {
		this.partnerCd = partnerCd;
	}

	public String getPartnerNm() {
		return partnerNm;
	}

	public void setPartnerNm(String partnerNm) {
		this.partnerNm = partnerNm;
	}

	public String getTotalAccessCnt() {
		return totalAccessCnt;
	}

	public void setTotalAccessCnt(String totalAccessCnt) {
		this.totalAccessCnt = totalAccessCnt;
	}

	public String getRn() {
		return rn;
	}

	public void setRn(String rn) {
		this.rn = rn;
	}

	public String getPartnerCode() {
		return partnerCode;
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}

	public int getPlusPoint() {
		return plusPoint;
	}

	public void setPlusPoint(int plusPoint) {
		this.plusPoint = plusPoint;
	}

	public int getMinusPoint() {
		return minusPoint;
	}

	public void setMinusPoint(int minusPoint) {
		this.minusPoint = minusPoint;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMm() {
		return mm;
	}
	public void setMm(String mm) {
		this.mm = mm;
	}
	public String getAccessCnt() {
		return accessCnt;
	}
	public void setAccessCnt(String accessCnt) {
		this.accessCnt = accessCnt;
	}
}
