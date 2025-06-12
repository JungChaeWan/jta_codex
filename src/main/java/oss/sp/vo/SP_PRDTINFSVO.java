package oss.sp.vo;

import oss.cmm.vo.pageDefaultVO;

public class SP_PRDTINFSVO extends pageDefaultVO {

	// 업체 ID
	private String sCorpId;
	// 판매일자
	private String sSaleStartDt;
	// 쇼셜상품번호
	private String sprdtNum;

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsSaleStartDt() {
		return sSaleStartDt;
	}

	public void setsSaleStartDt(String sSaleStartDt) {
		this.sSaleStartDt = sSaleStartDt;
	}

	public String getsprdtNum() {
		return sprdtNum;
	}

	public void setsprdtNum(String sprdtNum) {
		this.sprdtNum = sprdtNum;
	}

}
