package mas.b2b.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class B2B_RC_PRDTSVO extends pageDefaultVO{

	private String sCorpId;
	private String sCorpNm;
	private String sPrdtNum;
	private String sPrdtNm;
	/** 검색시작시간 */
	private String sFromTm;
	/** 검색종료시간 */
	private String sToTm;
	private String sFromDt;
	private String sFromDtView;
	private String sToDt;
	private String sToDtView;
	private String sSaleAgcCorpId;
	private List<String> sIconCd;
	/** 차량코드 */
	private String sCarCd;
	private List<String> sCarCds;
	/** 차량구분코드 */
	private String sCarDivCd;
	private String sCarDivCdView;
	
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
	public List<String> getsIconCd() {
		return sIconCd;
	}
	public void setsIconCd(List<String> sIconCd) {
		this.sIconCd = sIconCd;
	}
	public String getsSaleAgcCorpId() {
		return sSaleAgcCorpId;
	}
	public void setsSaleAgcCorpId(String sSaleAgcCorpId) {
		this.sSaleAgcCorpId = sSaleAgcCorpId;
	}
	public String getsFromTm() {
		return sFromTm;
	}
	public void setsFromTm(String sFromTm) {
		this.sFromTm = sFromTm;
	}
	public String getsToTm() {
		return sToTm;
	}
	public void setsToTm(String sToTm) {
		this.sToTm = sToTm;
	}
	public String getsCarCd() {
		return sCarCd;
	}
	public void setsCarCd(String sCarCd) {
		this.sCarCd = sCarCd;
	}
	public List<String> getsCarCds() {
		return sCarCds;
	}
	public void setsCarCds(List<String> sCarCds) {
		this.sCarCds = sCarCds;
	}
	public String getsCarDivCd() {
		return sCarDivCd;
	}
	public void setsCarDivCd(String sCarDivCd) {
		this.sCarDivCd = sCarDivCd;
	}
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}
	public String getsCarDivCdView() {
		return sCarDivCdView;
	}
	public void setsCarDivCdView(String sCarDivCdView) {
		this.sCarDivCdView = sCarDivCdView;
	}
	public String getsPrdtNm() {
		return sPrdtNm;
	}
	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}
	public String getsFromDt() {
		return sFromDt;
	}
	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}
	public String getsFromDtView() {
		return sFromDtView;
	}
	public void setsFromDtView(String sFromDtView) {
		this.sFromDtView = sFromDtView;
	}
	public String getsToDt() {
		return sToDt;
	}
	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}
	public String getsToDtView() {
		return sToDtView;
	}
	public void setsToDtView(String sToDtView) {
		this.sToDtView = sToDtView;
	}
	
}
