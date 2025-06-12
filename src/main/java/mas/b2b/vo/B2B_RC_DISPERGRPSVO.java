package mas.b2b.vo;

import oss.cmm.vo.pageDefaultVO;

public class B2B_RC_DISPERGRPSVO extends pageDefaultVO{

	private String sCorpId;
	private String sCorpNm;
	private String sDisPerGrpNum;

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

	public String getsDisPerGrpNum() {
		return sDisPerGrpNum;
	}

	public void setsDisPerGrpNum(String sDisPerGrpNum) {
		this.sDisPerGrpNum = sDisPerGrpNum;
	}


}
