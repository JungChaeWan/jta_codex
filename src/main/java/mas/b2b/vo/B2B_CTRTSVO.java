package mas.b2b.vo;

import oss.cmm.vo.pageDefaultVO;

public class B2B_CTRTSVO extends pageDefaultVO{


	private String sCorpId;
	private String sOwnCorpId;
	private String sOwnCorpCd;
	private String sCorpNm;
	private String sCorpCd;
	private String sStatusCd;
	private String sFromDt;
	private String sToDt;
	
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
	public String getsStatusCd() {
		return sStatusCd;
	}
	public void setsStatusCd(String sStatusCd) {
		this.sStatusCd = sStatusCd;
	}
	public String getsFromDt() {
		return sFromDt;
	}
	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}
	public String getsToDt() {
		return sToDt;
	}
	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}
	public String getsOwnCorpId() {
		return sOwnCorpId;
	}
	public void setsOwnCorpId(String sOwnCorpId) {
		this.sOwnCorpId = sOwnCorpId;
	}
	public String getsOwnCorpCd() {
		return sOwnCorpCd;
	}
	public void setsOwnCorpCd(String sOwnCorpCd) {
		this.sOwnCorpCd = sOwnCorpCd;
	}
	public String getsCorpCd() {
		return sCorpCd;
	}
	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}
	
}
