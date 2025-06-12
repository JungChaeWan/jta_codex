package mas.b2b.vo;

import oss.cmm.vo.pageDefaultVO;

public class B2B_AD_AMTSVO extends pageDefaultVO{

	private String sCorpId;
	private String sCorpNm;
	private String sAmtGrpNum;
	private String sPrdtNum;
	private String sAplDt;

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

	public String getsAmtGrpNum() {
		return sAmtGrpNum;
	}

	public void setsAmtGrpNum(String sAmtGrpNum) {
		this.sAmtGrpNum = sAmtGrpNum;
	}

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getsAplDt() {
		return sAplDt;
	}

	public void setsAplDt(String sAplDt) {
		this.sAplDt = sAplDt;
	}


}
