package oss.prmt.vo;

import oss.cmm.vo.pageDefaultVO;

public class PRMTSVO extends pageDefaultVO {
	private String sTradeStatus;
	private String sConfRequestStartDt;
	private String sConfRequestEndDt;
	private String sStartDt;
	private String sEndDt;
	private String sCorpNm;
	private String sPrmtNm;
	
	public String getsTradeStatus() {
		return sTradeStatus;
	}
	public void setsTradeStatus(String sTradeStatus) {
		this.sTradeStatus = sTradeStatus;
	}
	public String getsConfRequestStartDt() {
		return sConfRequestStartDt;
	}
	public void setsConfRequestStartDt(String sConfRequestStartDt) {
		this.sConfRequestStartDt = sConfRequestStartDt;
	}
	public String getsConfRequestEndDt() {
		return sConfRequestEndDt;
	}
	public void setsConfRequestEndDt(String sConfRequestEndDt) {
		this.sConfRequestEndDt = sConfRequestEndDt;
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
	public String getsPrmtNm() {
		return sPrmtNm;
	}
	public void setsPrmtNm(String sPrmtNm) {
		this.sPrmtNm = sPrmtNm;
	}
}
