package web.bbs.vo;

import oss.cmm.vo.pageDefaultVO;

public class NOTICESVO extends pageDefaultVO{

	private String sBbsNum;

	private String sKey;
	private String sKeyOpt;
	
	private String sStatusDiv;
	
	private String sUserId;
	private String sAuthNm;
	
	public String getsKey() {
		return sKey;
	}
	public void setsKey(String sKey) {
		this.sKey = sKey;
	}
	public String getsKeyOpt() {
		return sKeyOpt;
	}
	public void setsKeyOpt(String sKeyOpt) {
		this.sKeyOpt = sKeyOpt;
	}
	public String getsBbsNum() {
		return sBbsNum;
	}
	public void setsBbsNum(String sBbsNum) {
		this.sBbsNum = sBbsNum;
	}
	public String getsStatusDiv() {
		return sStatusDiv;
	}
	public void setsStatusDiv(String sStatusDiv) {
		this.sStatusDiv = sStatusDiv;
	}
	public String getsUserId() {
		return sUserId;
	}
	public void setsUserId(String sUserId) {
		this.sUserId = sUserId;
	}
	public String getsAuthNm() {
		return sAuthNm;
	}
	public void setsAuthNm(String sAuthNm) {
		this.sAuthNm = sAuthNm;
	}
	
}
