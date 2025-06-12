package web.order.vo;

public class MRTNVO {
	
	/** 마라톤 CSPM */
	private String mrtnNum;			//참가신청번호
	private String apctNm;			//신청자 명
	private String birth;			//생년월일
	private String lrrn;			//주민등록번호7자리
	private String apctTelnum;		//신청자 전화번호 
	private String ageRange;		//나이대 
	private String gender;			//성별
	private String bloodType;		//혈액형
	private String region;			//거주지역
	private String apctPostNum;		//우편번호
	private String apctRoadNmAddr;	//도로명주소
	private String apctDtlAddr;		//상세주소
	private String fullAddr;		//전체주소
	private String apctEmail;		//신청자 이메일
	private String course;			//코스
	private String tshirts;			//티셔츠
	private String groupNm;			//그룹명
	private String regDttm;			//등록일시
	
	private String rsvNum;			//예약번호
	private String spRsvNum;		//소셜상품 예약 번호
	private String corpId;			//업체 아이디
	private String prdtNum;			//상품 번호
	private String txsCnt;			//XS수량
	private String tsCnt;			//S수량
	private String tmCnt;			//M수량
	private String tlCnt;			//L수량
	private String txlCnt;			//XL수량
	private String t2xlCnt;			//2XL수량
	private String t3xlCnt;			//3XL수량	
	
	private String chkTshirtsAble;	//티셔츠총수량체크
	private String totTshirtsCnt;	//티셔츠총수량
	private String txsUseCnt;		//XS사용수량
	private String tsUseCnt;		//S사용수량
	private String tmUseCnt;		//M사용수량
	private String tlUseCnt;		//L사용수량
	private String txlUseCnt;		//XL사용수량
	private String t2xlUseCnt;		//2XL사용수량
	private String t3xlUseCnt;		//3XL사용수량
	
	private String spOptSn;			//옵션순번

	private String cartCorpId;
	private String cartPrdtNum;
	
	private String sApctNm;
	private String sApctTelnum;

	private int index;
	
	private String[] sRrnList;				//주민번호배열
	
	public String getMrtnNum() {
		return mrtnNum;
	}

	public void setMrtnNum(String mrtnNum) {
		this.mrtnNum = mrtnNum;
	}

	public String getApctNm() {
		return apctNm;
	}

	public void setApctNm(String apctNm) {
		this.apctNm = apctNm;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getLrrn() {
		return lrrn;
	}

	public void setLrrn(String lrrn) {
		this.lrrn = lrrn;
	}

	public String getApctTelnum() {
		return apctTelnum;
	}

	public void setApctTelnum(String apctTelnum) {
		this.apctTelnum = apctTelnum;
	}

	public String getAgeRange() {
		return ageRange;
	}

	public void setAgeRange(String ageRange) {
		this.ageRange = ageRange;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBloodType() {
		return bloodType;
	}

	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getApctPostNum() {
		return apctPostNum;
	}

	public void setApctPostNum(String apctPostNum) {
		this.apctPostNum = apctPostNum;
	}

	public String getApctRoadNmAddr() {
		return apctRoadNmAddr;
	}

	public void setApctRoadNmAddr(String apctRoadNmAddr) {
		this.apctRoadNmAddr = apctRoadNmAddr;
	}

	public String getApctDtlAddr() {
		return apctDtlAddr;
	}

	public void setApctDtlAddr(String apctDtlAddr) {
		this.apctDtlAddr = apctDtlAddr;
	}

	public String getFullAddr() {
		return fullAddr;
	}

	public void setFullAddr(String fullAddr) {
		this.fullAddr = fullAddr;
	}

	public String getApctEmail() {
		return apctEmail;
	}

	public void setApctEmail(String apctEmail) {
		this.apctEmail = apctEmail;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public String getTshirts() {
		return tshirts;
	}

	public void setTshirts(String tshirts) {
		this.tshirts = tshirts;
	}

	public String getGroupNm() {
		return groupNm;
	}

	public void setGroupNm(String groupNm) {
		this.groupNm = groupNm;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getRsvNum() {
		return rsvNum;
	}

	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}

	public String getSpRsvNum() {
		return spRsvNum;
	}

	public void setSpRsvNum(String spRsvNum) {
		this.spRsvNum = spRsvNum;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public String getTxsCnt() {
		return txsCnt;
	}

	public void setTxsCnt(String txsCnt) {
		this.txsCnt = txsCnt;
	}

	public String getTsCnt() {
		return tsCnt;
	}

	public void setTsCnt(String tsCnt) {
		this.tsCnt = tsCnt;
	}

	public String getTmCnt() {
		return tmCnt;
	}

	public void setTmCnt(String tmCnt) {
		this.tmCnt = tmCnt;
	}

	public String getTlCnt() {
		return tlCnt;
	}

	public void setTlCnt(String tlCnt) {
		this.tlCnt = tlCnt;
	}

	public String getTxlCnt() {
		return txlCnt;
	}

	public void setTxlCnt(String txlCnt) {
		this.txlCnt = txlCnt;
	}

	public String getT2xlCnt() {
		return t2xlCnt;
	}

	public void setT2xlCnt(String t2xlCnt) {
		this.t2xlCnt = t2xlCnt;
	}

	public String getT3xlCnt() {
		return t3xlCnt;
	}

	public void setT3xlCnt(String t3xlCnt) {
		this.t3xlCnt = t3xlCnt;
	}

	public String getChkTshirtsAble() {
		return chkTshirtsAble;
	}

	public void setChkTshirtsAble(String chkTshirtsAble) {
		this.chkTshirtsAble = chkTshirtsAble;
	}

	public String getTotTshirtsCnt() {
		return totTshirtsCnt;
	}

	public void setTotTshirtsCnt(String totTshirtsCnt) {
		this.totTshirtsCnt = totTshirtsCnt;
	}

	public String getTxsUseCnt() {
		return txsUseCnt;
	}

	public void setTxsUseCnt(String txsUseCnt) {
		this.txsUseCnt = txsUseCnt;
	}

	public String getTsUseCnt() {
		return tsUseCnt;
	}

	public void setTsUseCnt(String tsUseCnt) {
		this.tsUseCnt = tsUseCnt;
	}

	public String getTmUseCnt() {
		return tmUseCnt;
	}

	public void setTmUseCnt(String tmUseCnt) {
		this.tmUseCnt = tmUseCnt;
	}

	public String getTlUseCnt() {
		return tlUseCnt;
	}

	public void setTlUseCnt(String tlUseCnt) {
		this.tlUseCnt = tlUseCnt;
	}

	public String getTxlUseCnt() {
		return txlUseCnt;
	}

	public void setTxlUseCnt(String txlUseCnt) {
		this.txlUseCnt = txlUseCnt;
	}

	public String getT2xlUseCnt() {
		return t2xlUseCnt;
	}

	public void setT2xlUseCnt(String t2xlUseCnt) {
		this.t2xlUseCnt = t2xlUseCnt;
	}

	public String getT3xlUseCnt() {
		return t3xlUseCnt;
	}

	public void setT3xlUseCnt(String t3xlUseCnt) {
		this.t3xlUseCnt = t3xlUseCnt;
	}

	public String getSpOptSn() {
		return spOptSn;
	}

	public void setSpOptSn(String spOptSn) {
		this.spOptSn = spOptSn;
	}

	public String getCartCorpId() {
		return cartCorpId;
	}

	public void setCartCorpId(String cartCorpId) {
		this.cartCorpId = cartCorpId;
	}

	public String getCartPrdtNum() {
		return cartPrdtNum;
	}

	public void setCartPrdtNum(String cartPrdtNum) {
		this.cartPrdtNum = cartPrdtNum;
	}

	public String getsApctNm() {
		return sApctNm;
	}

	public void setsApctNm(String sApctNm) {
		this.sApctNm = sApctNm;
	}

	public String getsApctTelnum() {
		return sApctTelnum;
	}

	public void setsApctTelnum(String sApctTelnum) {
		this.sApctTelnum = sApctTelnum;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String[] getsRrnList() {
		return sRrnList;
	}

	public void setsRrnList(String[] sRrnList) {
		this.sRrnList = sRrnList;
	}
}
