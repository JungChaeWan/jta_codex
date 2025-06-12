package web.order.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class ORDERSVO extends pageDefaultVO{

	private String sRsvNm;
	private String sRsvTelnum;
	private String sPrdtRsvNum;
	private String sUserId;
	private String sPayDiv;
	private List<String> sPayDivs;
	
	private List<String> rsvNumList;
	private List<String> prdtRsvNumList;
	
	private String sRsvDiv;
	
	public String getsRsvNm() {
		return sRsvNm;
	}
	public void setsRsvNm(String sRsvNm) {
		this.sRsvNm = sRsvNm;
	}
	public String getsRsvTelnum() {
		return sRsvTelnum;
	}
	public void setsRsvTelnum(String sRsvTelnum) {
		this.sRsvTelnum = sRsvTelnum;
	}
	public String getsPrdtRsvNum() {
		return sPrdtRsvNum;
	}
	public void setsPrdtRsvNum(String sPrdtRsvNum) {
		this.sPrdtRsvNum = sPrdtRsvNum;
	}
	public String getsUserId() {
		return sUserId;
	}
	public void setsUserId(String sUserId) {
		this.sUserId = sUserId;
	}
	public List<String> getRsvNumList() {
		return rsvNumList;
	}
	public void setRsvNumList(List<String> rsvNumList) {
		this.rsvNumList = rsvNumList;
	}
	public List<String> getPrdtRsvNumList() {
		return prdtRsvNumList;
	}
	public void setPrdtRsvNumList(List<String> prdtRsvNumList) {
		this.prdtRsvNumList = prdtRsvNumList;
	}

	public String getsPayDiv() {
		return sPayDiv;
	}

	public void setsPayDiv(String sPayDiv) {
		this.sPayDiv = sPayDiv;
	}

	public List<String> getsPayDivs() {
		return sPayDivs;
	}

	public void setsPayDivs(List<String> sPayDivs) {
		this.sPayDivs = sPayDivs;
	}
	
	public String getsRsvDiv() {
		return sRsvDiv;
	}
	
	public void setsRsvDiv(String sRsvDiv) {
		this.sRsvDiv = sRsvDiv;
	}
	
}
