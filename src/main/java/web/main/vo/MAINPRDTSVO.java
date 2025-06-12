package web.main.vo;

import oss.cmm.vo.pageDefaultVO;

public class MAINPRDTSVO extends pageDefaultVO{
	
	private String sCtgr;
	private String sAdDiv;
	private String sCarDiv;
	private String sNum;
	private String sSuperbSvYn;

	public String getsCtgr() {
		return sCtgr;
	}

	public void setsCtgr(String sCtgr) {
		this.sCtgr = sCtgr;
	}

	public String getsAdDiv() {
		return sAdDiv;
	}

	public void setsAdDiv(String sAdDiv) {
		this.sAdDiv = sAdDiv;
	}

	public String getsCarDiv() {
		return sCarDiv;
	}

	public void setsCarDiv(String sCarDiv) {
		this.sCarDiv = sCarDiv;
	}

	public String getsNum() {
		return sNum;
	}

	public void setsNum(String sNum) {
		this.sNum = sNum;
	}

	public String getsSuperbSvYn() {
		return sSuperbSvYn;
	}

	public void setsSuperbSvYn(String sSuperbSvYn) {
		this.sSuperbSvYn = sSuperbSvYn;
	}
}
