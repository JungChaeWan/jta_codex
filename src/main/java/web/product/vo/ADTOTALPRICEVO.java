package web.product.vo;

public class ADTOTALPRICEVO {
	private String prdtNum;
	private String sFromDt;
	private int iNight;
	private int iMenAdult;
	private int iMenJunior;
	private int iMenChild;
	private int iTotalPrice;
	private int iTotalNmlAmt;
	private int iTotalOverAmt;

	/**캘린더 예약 합계구하는 식 2022.01.04 chaewan.jung**/
	private int iAdultAddAmt;
	private int iChildAddAmt;
	private int iJuniorAddAmt;
	private int iBasePrice;

	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getsFromDt() {
		return sFromDt;
	}
	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}
	public int getiNight() {
		return iNight;
	}
	public void setiNight(int iNight) {
		this.iNight = iNight;
	}
	public int getiMenAdult() {
		return iMenAdult;
	}
	public void setiMenAdult(int iMenAdult) {
		this.iMenAdult = iMenAdult;
	}
	public int getiMenJunior() {
		return iMenJunior;
	}
	public void setiMenJunior(int iMenJunior) {
		this.iMenJunior = iMenJunior;
	}
	public int getiMenChild() {
		return iMenChild;
	}
	public void setiMenChild(int iMenChild) {
		this.iMenChild = iMenChild;
	}
	public int getiTotalPrice() {
		return iTotalPrice;
	}
	public void setiTotalPrice(int iTotalPrice) {
		this.iTotalPrice = iTotalPrice;
	}
	public int getiTotalNmlAmt() {
		return iTotalNmlAmt;
	}
	public void setiTotalNmlAmt(int iTotalNmlAmt) {
		this.iTotalNmlAmt = iTotalNmlAmt;
	}
	public int getiTotalOverAmt() {
		return iTotalOverAmt;
	}
	public void setiTotalOverAmt(int iTotalOverAmt) {
		this.iTotalOverAmt = iTotalOverAmt;
	}

	public int getiAdultAddAmt() {
		return iAdultAddAmt;
	}

	public void setiAdultAddAmt(int iAdultAddAmt) {
		this.iAdultAddAmt = iAdultAddAmt;
	}

	public int getiChildAddAmt() {
		return iChildAddAmt;
	}

	public void setiChildAddAmt(int iChildAddAmt) {
		this.iChildAddAmt = iChildAddAmt;
	}

	public int getiJuniorAddAmt() {
		return iJuniorAddAmt;
	}

	public void setiJuniorAddAmt(int iJuniorAddAmt) {
		this.iJuniorAddAmt = iJuniorAddAmt;
	}

	public int getiBasePrice() {
		return iBasePrice;
	}

	public void setiBasePrice(int iBasePrice) {
		this.iBasePrice = iBasePrice;
	}
}
