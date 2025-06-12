package web.product.vo;

import oss.cmm.vo.pageDefaultVO;

public class CARTVO extends pageDefaultVO {

	/** 사용가능여부 */
	private String ableYn;
	/** 카트 순번 */
	private Integer cartSn;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 상품구분 명 */
	private String prdtDivNm;
	/** 총판매금액 */
	private String totalAmt;
	/** 정상금액 */
	private String nmlAmt;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 판매가 */
	private String saleAmt;
	/** 할인율 */
	private String disPer;

	/** 예약시작일 */
	private String fromDt;
	/** 예약종료일 */
	private String toDt;
	/** 예약시작시분 */
	private String fromTm;
	/** 예약종료시분 */
	private String toTm;
	/** 추가금액 */
	private String addAmt;
	/** 자차보험구분 */
	private String insureDiv;

	// 소셜 상품
	/**  카테고리 명 */
	private String ctgrNm;
	/** 옵션명 */
	private String optNm;
	/** 수량 */
	private String qty;
	/** 소셜상품 옵션 순번 */
	private String spOptSn;
	/** 소셜상품 구분 순번 */
	private String spDivSn;
	/** 재고갯수 */
	private String stockNum;
	/** 마감 여부 */
	private String ddlYn;
	/** 적용 일자 */
	private String aplDt;
	/**  추가옵션명 */
	private String addOptNm;
	/** 추가옵션 가격 */
	private String addOptAmt;

	//-----숙소----------------------------

	//private String prdtNum; 	//상품번호  - 있는거 사용
	//private String fromDt;	//예약 시작 일 - 있는거 사용
	private String startDt;	//예약 시작 일

	/** 몇박 */
	private String night;

	/** 성인 수  */
	private String adultCnt;

	/** 소아 수  */
	private String juniorCnt;

	/** 유아 수  */
	private String childCnt;
	
	/** 인원 추가 요금  */
	private String adOverAmt;

	//성인
	private String addAdultAmt;
	//소아
	private String addJuniorAmt;
	//유아
	private String addChildAmt;

	//기준인원
	private String stdMem;		
	
	//성인 추가 인원
	private String addAdultCnt;		
	//소인 추가 인원
	private String addJuniorCnt;	
	//유아 추가 인원
	private String addChildCnt;
	//--------------------------------


	//-----골프----------------------------

	//private String startDt;	//예약 시작 일
	/** 시간 */
	private String tm;

	/** 사용수 */
	private String memCnt;

	/** 업체세부코드 */
	private String ctgr;

	//--------------------------------

	// 관광지 기념품
	private String svOptSn;
	private String svDivSn;
	private String dlvAmtDiv;
	private String dlvAmt;
    private String inDlvAmt;
    private String outDlvAmt;
	private String maxiBuyNum;
	private String aplAmt;
	private String directRecvYn;
	private String localAreaYn;

	/**장바구니 이미지 추가 **/
	private String imgPath;

	/**생산자별 묶음배송을 위해 추가 **/
	private  String prdc;

	/**  현대캐피탈 렌터카(전기) one-card 이벤트 추가 */
	private String hcOneCardYn;
	
	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getPrdtDivNm() {
		return prdtDivNm;
	}
	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}
	public String getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
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
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getDisPer() {
		return disPer;
	}
	public void setDisPer(String disPer) {
		this.disPer = disPer;
	}
	public String getFromDt() {
		return fromDt;
	}
	public void setFromDt(String fromDt) {
		this.fromDt = fromDt;
	}
	public String getToDt() {
		return toDt;
	}
	public void setToDt(String toDt) {
		this.toDt = toDt;
	}
	public String getFromTm() {
		return fromTm;
	}
	public void setFromTm(String fromTm) {
		this.fromTm = fromTm;
	}
	public String getToTm() {
		return toTm;
	}
	public void setToTm(String toTm) {
		this.toTm = toTm;
	}
	public String getOptNm() {
		return optNm;
	}
	public void setOptNm(String optNm) {
		this.optNm = optNm;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getSpOptSn() {
		return spOptSn;
	}
	public void setSpOptSn(String spOptSn) {
		this.spOptSn = spOptSn;
	}
	public String getSpDivSn() {
		return spDivSn;
	}
	public void setSpDivSn(String spDivSn) {
		this.spDivSn = spDivSn;
	}
	public Integer getCartSn() {
		return cartSn;
	}
	public void setCartSn(Integer cartSn) {
		this.cartSn = cartSn;
	}
	public String getAddAmt() {
		return addAmt;
	}
	public void setAddAmt(String addAmt) {
		this.addAmt = addAmt;
	}
	public String getInsureDiv() {
		return insureDiv;
	}
	public void setInsureDiv(String insureDiv) {
		this.insureDiv = insureDiv;
	}
	public String getNight() {
		return night;
	}
	public void setNight(String night) {
		this.night = night;
	}
	public String getAdultCnt() {
		return adultCnt;
	}
	public void setAdultCnt(String adultCnt) {
		this.adultCnt = adultCnt;
	}
	public String getJuniorCnt() {
		return juniorCnt;
	}
	public void setJuniorCnt(String juniorCnt) {
		this.juniorCnt = juniorCnt;
	}
	public String getChildCnt() {
		return childCnt;
	}
	public void setChildCnt(String childCnt) {
		this.childCnt = childCnt;
	}	
	public String getAdOverAmt() {
		return adOverAmt;
	}
	public void setAdOverAmt(String adOverAmt) {
		this.adOverAmt = adOverAmt;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getCtgrNm() {
		return ctgrNm;
	}
	public void setCtgrNm(String ctgrNm) {
		this.ctgrNm = ctgrNm;
	}
	public String getStockNum() {
		return stockNum;
	}
	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}
	public String getDdlYn() {
		return ddlYn;
	}
	public void setDdlYn(String ddlYn) {
		this.ddlYn = ddlYn;
	}
	public String getAplDt() {
		return aplDt;
	}
	public void setAplDt(String aplDt) {
		this.aplDt = aplDt;
	}
	public String getAddOptNm() {
		return addOptNm;
	}
	public void setAddOptNm(String addOptNm) {
		this.addOptNm = addOptNm;
	}
	public String getAddOptAmt() {
		return addOptAmt;
	}
	public void setAddOptAmt(String addOptAmt) {
		this.addOptAmt = addOptAmt;
	}
	public String getTm() {
		return tm;
	}
	public void setTm(String tm) {
		this.tm = tm;
	}
	public String getMemCnt() {
		return memCnt;
	}
	public void setMemCnt(String memCnt) {
		this.memCnt = memCnt;
	}
	public String getAbleYn() {
		return ableYn;
	}
	public void setAbleYn(String ableYn) {
		this.ableYn = ableYn;
	}
	public String getSvOptSn() {
		return svOptSn;
	}
	public void setSvOptSn(String svOptSn) {
		this.svOptSn = svOptSn;
	}
	public String getSvDivSn() {
		return svDivSn;
	}
	public void setSvDivSn(String svDivSn) {
		this.svDivSn = svDivSn;
	}
	public String getDlvAmtDiv() {
		return dlvAmtDiv;
	}
	public void setDlvAmtDiv(String dlvAmtDiv) {
		this.dlvAmtDiv = dlvAmtDiv;
	}
	public String getDlvAmt() {
		return dlvAmt;
	}
	public void setDlvAmt(String dlvAmt) {
		this.dlvAmt = dlvAmt;
	}
	public String getMaxiBuyNum() {
		return maxiBuyNum;
	}
	public void setMaxiBuyNum(String maxiBuyNum) {
		this.maxiBuyNum = maxiBuyNum;
	}
	public String getAplAmt() {
		return aplAmt;
	}
	public void setAplAmt(String aplAmt) {
		this.aplAmt = aplAmt;
	}
	@Override
	public String toString() {
		return "CARTVO [cartSn=" + cartSn + ", prdtNum=" + prdtNum + ", prdtNm=" + prdtNm + ", corpId=" + corpId
				+ ", dlvAmtDiv=" + dlvAmtDiv + ", dlvAmt=" + dlvAmt + "]";
	}
	public String getDirectRecvYn() {
		return directRecvYn;
	}
	public void setDirectRecvYn(String directRecvYn) {
		this.directRecvYn = directRecvYn;
	}
	public String getAddAdultAmt() {
		return addAdultAmt;
	}
	public void setAddAdultAmt(String addAdultAmt) {
		this.addAdultAmt = addAdultAmt;
	}
	public String getAddJuniorAmt() {
		return addJuniorAmt;
	}
	public void setAddJuniorAmt(String addJuniorAmt) {
		this.addJuniorAmt = addJuniorAmt;
	}
	public String getAddChildAmt() {
		return addChildAmt;
	}
	public void setAddChildAmt(String addChildAmt) {
		this.addChildAmt = addChildAmt;
	}
	public String getStdMem() {
		return stdMem;
	}
	public void setStdMem(String stdMem) {
		this.stdMem = stdMem;
	}
	public String getAddAdultCnt() {
		return addAdultCnt;
	}
	public void setAddAdultCnt(String addAdultCnt) {
		this.addAdultCnt = addAdultCnt;
	}
	public String getAddJuniorCnt() {
		return addJuniorCnt;
	}
	public void setAddJuniorCnt(String addJuniorCnt) {
		this.addJuniorCnt = addJuniorCnt;
	}
	public String getAddChildCnt() {
		return addChildCnt;
	}
	public void setAddChildCnt(String addChildCnt) {
		this.addChildCnt = addChildCnt;
	}

	public String getLocalAreaYn() {
		return localAreaYn;
	}

	public void setLocalAreaYn(String localAreaYn) {
		this.localAreaYn = localAreaYn;
	}

    public String getInDlvAmt() {
        return inDlvAmt;
    }

    public void setInDlvAmt(String inDlvAmt) {
        this.inDlvAmt = inDlvAmt;
    }

    public String getOutDlvAmt() {
        return outDlvAmt;
    }

    public void setOutDlvAmt(String outDlvAmt) {
        this.outDlvAmt = outDlvAmt;
    }

	public String getPrdc() {
		return prdc;
	}

	public void setPrdc(String prdc) {
		this.prdc = prdc;
	}

	public String getHcOneCardYn() {
		return hcOneCardYn;
	}

	public void setHcOneCardYn(String hcOneCardYn) {
		this.hcOneCardYn = hcOneCardYn;
	}

	public String getCtgr() {
		return ctgr;
	}

	public void setCtgr(String ctgr) {
		this.ctgr = ctgr;
	}
}
