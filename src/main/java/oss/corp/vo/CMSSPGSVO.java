package oss.corp.vo;

import oss.cmm.vo.pageDefaultVO;

public class CMSSPGSVO extends pageDefaultVO{
	/* 결제 구분 */
	private String sPgDiv;
	/* 수수료 구분 */
	private String sPgCmssDiv;
	
	public String getsPgDiv() {
		return sPgDiv;
	}

	public void setsPgDiv(String sPgDiv) {
		this.sPgDiv = sPgDiv;
	}

	public String getsPgCmssDiv() {
		return sPgCmssDiv;
	}

	public void setsPgCmssDiv(String sPgCmssDiv) {
		this.sPgCmssDiv = sPgCmssDiv;
	}
	
}
