package web.product.vo;

public class CARTVO2 {
	/** 사용자 아이디 */
	private String userId;
	/** 장바구니 순번 */
	private String cartSn;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 상품 구분 명 */
	private String prdtDivNm;
	/** 시작 일자 */
	private String startDt;
	/** 박수 */
	private String night;
	/** 성인 수량 */
	private String adultCnt;
	/** 소인 수량 */
	private String juniorCnt;
	/** 유아 수량 */
	private String childCnt;
	/** 숙박 추가 금액 */
	private String adAddAmt;
	/** 종료 일자 */
	private String endDt;
	/** 총 금액 */
	private String totalAmt;
	/** 정상 금액 */
	private String nmlAmt;
	/** 시작 시간 */
	private String startTm;
	/** 종료 시간 */
	private String endTm;
	/** 보험 구분 */
	private String isrDiv;
	/** 수량 */
	private String cnt;
	/** 옵션 순번 */
	private String optSn;
	/** 구분 순번 */
	private String divSn;
	/** 추가 옵션 명 */
	private String addOptNm;
	/** 추가 옵션 금액 */
	private String addOptAmt;
	/** 직접 수령 여부 */
	private String directRecvYn;
	/** 등록 일시 */
	private String regDttm;

	/**장바구니 이미지 추가 **/
	private String imgPath;

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	/**
	 * @return 사용자 아이디
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * @param 사용자 아이디
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * @return 장바구니 순번
	 */
	public String getCartSn() {
		return cartSn;
	}

	/**
	 * @param 장바구니 순번
	 */
	public void setCartSn(String cartSn) {
		this.cartSn = cartSn;
	}

	/**
	 * @return 상품 번호
	 */
	public String getPrdtNum() {
		return prdtNum;
	}

	/**
	 * @param 상품 번호
	 */
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	/**
	 * @return 상품 명
	 */
	public String getPrdtNm() {
		return prdtNm;
	}

	/**
	 * @param 상품 명
	 */
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}

	/**
	 * @return 업체 아이디
	 */
	public String getCorpId() {
		return corpId;
	}

	/**
	 * @param 업체 아이디
	 */
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	/**
	 * @return 업체 명
	 */
	public String getCorpNm() {
		return corpNm;
	}

	/**
	 * @param 업체 명
	 */
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}

	/**
	 * @return 상품 구분 명
	 */
	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	/**
	 * @param 상품 구분 명
	 */
	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	/**
	 * @return 시작 일자
	 */
	public String getStartDt() {
		return startDt;
	}

	/**
	 * @param 시작 일자
	 */
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	/**
	 * @return 박수
	 */
	public String getNight() {
		return night;
	}

	/**
	 * @param 박수
	 */
	public void setNight(String night) {
		this.night = night;
	}

	/**
	 * @return 성인 수량
	 */
	public String getAdultCnt() {
		return adultCnt;
	}

	/**
	 * @param 성인 수량
	 */
	public void setAdultCnt(String adultCnt) {
		this.adultCnt = adultCnt;
	}

	/**
	 * @return 소인 수량
	 */
	public String getJuniorCnt() {
		return juniorCnt;
	}

	/**
	 * @param 소인 수량
	 */
	public void setJuniorCnt(String juniorCnt) {
		this.juniorCnt = juniorCnt;
	}

	/**
	 * @return 유아 수량
	 */
	public String getChildCnt() {
		return childCnt;
	}

	/**
	 * @param 유아 수량
	 */
	public void setChildCnt(String childCnt) {
		this.childCnt = childCnt;
	}

	/**
	 * @return 숙박 추가 금액
	 */
	public String getAdAddAmt() {
		return adAddAmt;
	}

	/**
	 * @param 숙박 추가 금액
	 */
	public void setAdAddAmt(String adAddAmt) {
		this.adAddAmt = adAddAmt;
	}

	/**
	 * @return 종료 일자
	 */
	public String getEndDt() {
		return endDt;
	}

	/**
	 * @param 종료 일자
	 */
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	/**
	 * @return 총 금액
	 */
	public String getTotalAmt() {
		return totalAmt;
	}

	/**
	 * @param 총 금액
	 */
	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	/**
	 * @return 정상 금액
	 */
	public String getNmlAmt() {
		return nmlAmt;
	}

	/**
	 * @param 정상 금액
	 */
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}

	/**
	 * @return 시작 시간
	 */
	public String getStartTm() {
		return startTm;
	}

	/**
	 * @param 시작 시간
	 */
	public void setStartTm(String startTm) {
		this.startTm = startTm;
	}

	/**
	 * @return 종료 시간
	 */
	public String getEndTm() {
		return endTm;
	}

	/**
	 * @param 종료 시간
	 */
	public void setEndTm(String endTm) {
		this.endTm = endTm;
	}

	/**
	 * @return 보험 구분
	 */
	public String getIsrDiv() {
		return isrDiv;
	}

	/**
	 * @param 보험 구분
	 */
	public void setIsrDiv(String isrDiv) {
		this.isrDiv = isrDiv;
	}

	/**
	 * @return 수량
	 */
	public String getCnt() {
		return cnt;
	}

	/**
	 * @param 수량
	 */
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	/**
	 * @return 옵션 순번
	 */
	public String getOptSn() {
		return optSn;
	}

	/**
	 * @param 옵션 순번
	 */
	public void setOptSn(String optSn) {
		this.optSn = optSn;
	}

	/**
	 * @return 구분 순번
	 */
	public String getDivSn() {
		return divSn;
	}

	/**
	 * @param 구분 순번
	 */
	public void setDivSn(String divSn) {
		this.divSn = divSn;
	}

	/**
	 * @return 추가 옵션 명
	 */
	public String getAddOptNm() {
		return addOptNm;
	}

	/**
	 * @param 추가 옵션 명
	 */
	public void setAddOptNm(String addOptNm) {
		this.addOptNm = addOptNm;
	}

	/**
	 * @return 추가 옵션 금액
	 */
	public String getAddOptAmt() {
		return addOptAmt;
	}

	/**
	 * @param 추가 옵션 금액
	 */
	public void setAddOptAmt(String addOptAmt) {
		this.addOptAmt = addOptAmt;
	}

	/**
	 * @return 직접 수령 여부
	 */
	public String getDirectRecvYn() {
		return directRecvYn;
	}

	/**
	 * @param 직접 수령 여부
	 */
	public void setDirectRecvYn(String directRecvYn) {
		this.directRecvYn = directRecvYn;
	}

	/**
	 * @return 등록 일시
	 */
	public String getRegDttm() {
		return regDttm;
	}

	/**
	 * @param 등록 일시
	 */
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
}
