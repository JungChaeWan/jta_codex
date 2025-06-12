package api.vo;

public class ApiNextezPrcAdd {

	String vType;			/** VIEW/LIKE/SHARE/POINT */
	String vCtgr;		/** AD/RC/SP */
	String vPrdtNum;			/** detailPrdtNum */
	String vConectDeviceNm;		/** PC/MOBILE */
	String vVal1;		/** 공유채널/평점 */

	public String getvType() {
		return vType;
	}

	public void setvType(String vType) {
		this.vType = vType;
	}

	public String getvCtgr() {
		return vCtgr;
	}

	public void setvCtgr(String vCtgr) {
		this.vCtgr = vCtgr;
	}

	public String getvPrdtNum() {
		return vPrdtNum;
	}

	public void setvPrdtNum(String vPrdtNum) {
		this.vPrdtNum = vPrdtNum;
	}

	public String getvConectDeviceNm() {
		return vConectDeviceNm;
	}

	public void setvConectDeviceNm(String vConectDeviceNm) {
		this.vConectDeviceNm = vConectDeviceNm;
	}

	public String getvVal1() {
		return vVal1;
	}

	public void setvVal1(String vVal1) {
		this.vVal1 = vVal1;
	}
}
