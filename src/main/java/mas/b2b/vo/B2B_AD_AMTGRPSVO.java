package mas.b2b.vo;

import oss.cmm.vo.pageDefaultVO;

public class B2B_AD_AMTGRPSVO extends pageDefaultVO{

	private String sCorpId;
	private String sCorpNm;
	private String sAmtGrpNum;

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


}
