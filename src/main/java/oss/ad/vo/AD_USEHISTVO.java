package oss.ad.vo;

import java.util.List;

public class AD_USEHISTVO {
	private String adRsvNum;
	private String useDt;
	private String useAmt;
	private String prdtNum;
	
	private List<AD_USEHISTVO> useHistList;
	
	public String getAdRsvNum() {
		return adRsvNum;
	}
	public void setAdRsvNum(String adRsvNum) {
		this.adRsvNum = adRsvNum;
	}
	public String getUseDt() {
		return useDt;
	}
	public void setUseDt(String useDt) {
		this.useDt = useDt;
	}
	public String getUseAmt() {
		return useAmt;
	}
	public void setUseAmt(String useAmt) {
		this.useAmt = useAmt;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	
	public List<AD_USEHISTVO> getUseHistList() {
		return useHistList;
	}
	public void setUseHistList(List<AD_USEHISTVO> useHistList) {
		this.useHistList = useHistList;
	}
	
}
