package mas.b2b.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class B2B_AD_PRDTSVO extends pageDefaultVO{

	private String sPrdtNum;
	private String sCorpId;
	private String sCorpNm;
	private String sAdultMem;
	private String sJuniorMem;
	private String sChildMem;
	private String sStartDt;
	private String sStartDtView;
	private String sEndDt;
	private String sEndDtView;
	private String sAdDiv;
	private String sAdArea;
	private String sSaleAgcCorpId;
	private List<String> sIconCd;
	
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
	public String getsAdultMem() {
		return sAdultMem;
	}
	public void setsAdultMem(String sAdultMem) {
		this.sAdultMem = sAdultMem;
	}
	public String getsJuniorMem() {
		return sJuniorMem;
	}
	public void setsJuniorMem(String sJuniorMem) {
		this.sJuniorMem = sJuniorMem;
	}
	public String getsChildMem() {
		return sChildMem;
	}
	public void setsChildMem(String sChildMem) {
		this.sChildMem = sChildMem;
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
	public String getsAdDiv() {
		return sAdDiv;
	}
	public void setsAdDiv(String sAdDiv) {
		this.sAdDiv = sAdDiv;
	}
	public String getsAdArea() {
		return sAdArea;
	}
	public void setsAdArea(String sAdArea) {
		this.sAdArea = sAdArea;
	}
	public List<String> getsIconCd() {
		return sIconCd;
	}
	public void setsIconCd(List<String> sIconCd) {
		this.sIconCd = sIconCd;
	}
	public String getsStartDtView() {
		return sStartDtView;
	}
	public void setsStartDtView(String sStartDtView) {
		this.sStartDtView = sStartDtView;
	}
	public String getsEndDtView() {
		return sEndDtView;
	}
	public void setsEndDtView(String sEndDtView) {
		this.sEndDtView = sEndDtView;
	}
	public String getsSaleAgcCorpId() {
		return sSaleAgcCorpId;
	}
	public void setsSaleAgcCorpId(String sSaleAgcCorpId) {
		this.sSaleAgcCorpId = sSaleAgcCorpId;
	}
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}
	
}
