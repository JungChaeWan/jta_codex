package web.product.vo;

import oss.cmm.vo.pageDefaultVO;

import java.util.List;

public class WEB_SVSVO extends pageDefaultVO{
	/** 카테고리 */
	private String sCtgr;
	/** 서브 카테고리 */
	private String sSubCtgr;
	/** 정렬 조건 */
	private String orderCd;
	/** 업체아이디 */
	private String sCorpId;
	/** 위도 */
	private String sLAT;
	/** 경도 */
	private String sLON;
	/** 상품명 */
	private String sPrdtNm;
	
	private String sCtgrDiv;
	
	private String sPrmtNum;
	
	/** 이벤트 상품 */
	private List<String> prdtNumList;
	
	/** 지도 카테고리리스트 */
	private List<String> ctgrList;
	
	private String searchWord;	// 검색어
	
	/** 큐레이션 번호 */
	private String sCrtnNum;
	
	/** 큐레이션 메인 여부 */
	private String sCrtnMainYn;
	
	private String sCorpCd;

	/**생산자별 묶음배송을 위해 추가 2021.06.02 **/
	private String sPrdc;

	/**탐나는전*/
	private String sTamnacardYn;

	public String getsCtgr() {
		return sCtgr;
	}

	public void setsCtgr(String sCtgr) {
		this.sCtgr = sCtgr;
	}

	public String getsSubCtgr() {
		return sSubCtgr;
	}

	public void setsSubCtgr(String sSubCtgr) {
		this.sSubCtgr = sSubCtgr;
	}

	public String getOrderCd() {
		return orderCd;
	}

	public void setOrderCd(String orderCd) {
		this.orderCd = orderCd;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsCrtnNum() {
		return sCrtnNum;
	}

	public void setsCrtnNum(String sCrtnNum) {
		this.sCrtnNum = sCrtnNum;
	}

	public String getsLAT() {
		return sLAT;
	}

	public void setsLAT(String sLAT) {
		this.sLAT = sLAT;
	}

	public String getsLON() {
		return sLON;
	}

	public void setsLON(String sLON) {
		this.sLON = sLON;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String getsPrmtNum() {
		return sPrmtNum;
	}

	public void setsPrmtNum(String sPrmtNum) {
		this.sPrmtNum = sPrmtNum;
	}

	public List<String> getPrdtNumList() {
		return prdtNumList;
	}

	public void setPrdtNumList(List<String> prdtNumList) {
		this.prdtNumList = prdtNumList;
	}

	public List<String> getCtgrList() {
		return ctgrList;
	}

	public void setCtgrList(List<String> ctgrList) {
		this.ctgrList = ctgrList;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getsCtgrDiv() {
		return sCtgrDiv;
	}

	public void setsCtgrDiv(String sCtgrDiv) {
		this.sCtgrDiv = sCtgrDiv;
	}

	public String getsCrtnMainYn() {
		return sCrtnMainYn;
	}

	public void setsCrtnMainYn(String sCrtnMainYn) {
		this.sCrtnMainYn = sCrtnMainYn;
	}

	public String getsCorpCd() {
		return sCorpCd;
	}

	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}

	public String getsPrdc() {
		return sPrdc;
	}

	public void setsPrdc(String sPrdc) {
		this.sPrdc = sPrdc;
	}

	public String getsTamnacardYn() {
		return sTamnacardYn;
	}

	public void setsTamnacardYn(String sTamnacardYn) {
		this.sTamnacardYn = sTamnacardYn;
	}
}
