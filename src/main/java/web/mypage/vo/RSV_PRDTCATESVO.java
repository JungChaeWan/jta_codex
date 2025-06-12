package web.mypage.vo;

import oss.cmm.vo.pageDefaultVO;

public class RSV_PRDTCATESVO extends pageDefaultVO {
	private String sUserId;
	
	private String sRsvNm;
	
	private String sRsvTelnum;
	
	private String sEvntStartDt;
	
	private String sEvntEndDt;

	public String getsUserId() {
		return sUserId;
	}

	public void setsUserId(String sUserId) {
		this.sUserId = sUserId;
	}

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

	public String getsEvntStartDt() {
		return sEvntStartDt;
	}

	public void setsEvntStartDt(String sEvntStartDt) {
		this.sEvntStartDt = sEvntStartDt;
	}

	public String getsEvntEndDt() {
		return sEvntEndDt;
	}

	public void setsEvntEndDt(String sEvntEndDt) {
		this.sEvntEndDt = sEvntEndDt;
	}
	
	
}
