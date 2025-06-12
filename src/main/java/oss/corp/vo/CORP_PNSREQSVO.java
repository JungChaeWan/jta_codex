package oss.corp.vo;

import oss.cmm.vo.pageDefaultVO;

public class CORP_PNSREQSVO extends pageDefaultVO{
    
	private String sCorpCd;
	private String sStatusCd;
	private String sStartDt;
	private String sEndDt;
	private String sStartDt2;
	private String sEndDt2;
	private String sCorpNm;
	
	public String getsCorpCd() {
		return sCorpCd;
	}

	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}

	public String getsStatusCd() {
		return sStatusCd;
	}

	public void setsStatusCd(String sStatusCd) {
		this.sStatusCd = sStatusCd;
	}

	public String getsStartDt() {
		return sStartDt;
	}

	public void setsStartDt(String sStartDt) {
		this.sStartDt = sStartDt;
	}

	public String getsEndDt() {
		return sEndDt;
	}

	public void setsEndDt(String sEndDt) {
		this.sEndDt = sEndDt;
	}

	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

	public String getsStartDt2() {
		return sStartDt2;
	}

	public void setsStartDt2(String sStartDt2) {
		this.sStartDt2 = sStartDt2;
	}

	public String getsEndDt2() {
		return sEndDt2;
	}

	public void setsEndDt2(String sEndDt2) {
		this.sEndDt2 = sEndDt2;
	}
}
