package oss.visitjeju.vo;

import oss.cmm.vo.pageDefaultVO;

public class VISITJEJUSVO extends pageDefaultVO {
	
	/** VISITJEJUSVO **/
	private String sCorpCd;
	private String sCorpId;
	private String sCorpNm;
	private String sContentsId;
	private String sApiCorpYn;
	/** VISITJEJUSVO **/
	
	/** CORPSVO **/
	private String sCorpSubCd;
	private Integer sDist;
	private String sCoRegNum;
	private String sKey;
	private String sKeyOpt;
	private String sTradeStatusCd;
	private String sAsctMemYn;
	private String sSuperbCorpYn;
	private String sSpCtgr;
	/** 실시간 연동 유무 **/
	private String sCorpLinkYn;
	/** 실시간 연동 업체 2022.08.09**/
	private String sCorpLinkApi;
	private String sFileYn;
	private String[] sFileNum;
	private String sCorpCd2;
	private String sVisitMappingYn;
	private String sTamnacardMngYn;
	/** 파트너(협력사) 코드 **/
	private String partnerCode;
	/** CORPSVO **/
	
	/** PRDTSVO **/
	/** 상품명 */
	private String sPrdtNm;
	/** 거래상태 */
	private String sTradeStatus;
	/** 검색시작일 */
	private String sFromDt;
	/** 검색종료일 */
	private String sToDt;
	/** 검색시작일_V */
	private String sFromDtView;
	/** 검색종료일_V */
	private String sToDtView;
	/** 검색시작시간 */
	private String sFromTm;
	/** 검색종료시간 */
	private String sToTm;
	/** 승인시작일 */
	private String sConfRequestStartDt;
	/** 승인종료일 */
	private String sConfRequestEndDt;
	/** 상품검색코드 */
	private String sPrdtCd;
	/** 노출 여부 */
	private String sDisplayYn;
	/** 지역 */
	private String sAreaCd;
	/*수량만료 개월수*/
	private String sMonthEnd;
	private String sTamnacardPrdtYn;
	private String sPrdtNum;
	/** PRDTSVO **/
	public String getsCorpCd() {
		return sCorpCd;
	}
	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}
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
	public String getsContentsId() {
		return sContentsId;
	}
	public void setsContentsId(String sContentsId) {
		this.sContentsId = sContentsId;
	}
	public String getsApiCorpYn() {
		return sApiCorpYn;
	}
	public void setsApiCorpYn(String sApiCorpYn) {
		this.sApiCorpYn = sApiCorpYn;
	}
	public String getsCorpSubCd() {
		return sCorpSubCd;
	}
	public void setsCorpSubCd(String sCorpSubCd) {
		this.sCorpSubCd = sCorpSubCd;
	}
	public Integer getsDist() {
		return sDist;
	}
	public void setsDist(Integer sDist) {
		this.sDist = sDist;
	}
	public String getsCoRegNum() {
		return sCoRegNum;
	}
	public void setsCoRegNum(String sCoRegNum) {
		this.sCoRegNum = sCoRegNum;
	}
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
	public String getsTradeStatusCd() {
		return sTradeStatusCd;
	}
	public void setsTradeStatusCd(String sTradeStatusCd) {
		this.sTradeStatusCd = sTradeStatusCd;
	}
	public String getsAsctMemYn() {
		return sAsctMemYn;
	}
	public void setsAsctMemYn(String sAsctMemYn) {
		this.sAsctMemYn = sAsctMemYn;
	}
	public String getsSuperbCorpYn() {
		return sSuperbCorpYn;
	}
	public void setsSuperbCorpYn(String sSuperbCorpYn) {
		this.sSuperbCorpYn = sSuperbCorpYn;
	}
	public String getsSpCtgr() {
		return sSpCtgr;
	}
	public void setsSpCtgr(String sSpCtgr) {
		this.sSpCtgr = sSpCtgr;
	}
	public String getsCorpLinkYn() {
		return sCorpLinkYn;
	}
	public void setsCorpLinkYn(String sCorpLinkYn) {
		this.sCorpLinkYn = sCorpLinkYn;
	}
	public String getsCorpLinkApi() {
		return sCorpLinkApi;
	}
	public void setsCorpLinkApi(String sCorpLinkApi) {
		this.sCorpLinkApi = sCorpLinkApi;
	}
	public String getsFileYn() {
		return sFileYn;
	}
	public void setsFileYn(String sFileYn) {
		this.sFileYn = sFileYn;
	}
	public String[] getsFileNum() {
		return sFileNum;
	}
	public void setsFileNum(String[] sFileNum) {
		this.sFileNum = sFileNum;
	}
	public String getsCorpCd2() {
		return sCorpCd2;
	}
	public void setsCorpCd2(String sCorpCd2) {
		this.sCorpCd2 = sCorpCd2;
	}
	public String getsVisitMappingYn() {
		return sVisitMappingYn;
	}
	public void setsVisitMappingYn(String sVisitMappingYn) {
		this.sVisitMappingYn = sVisitMappingYn;
	}
	public String getsTamnacardMngYn() {
		return sTamnacardMngYn;
	}
	public void setsTamnacardMngYn(String sTamnacardMngYn) {
		this.sTamnacardMngYn = sTamnacardMngYn;
	}
	public String getPartnerCode() {
		return partnerCode;
	}
	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}
	public String getsPrdtNm() {
		return sPrdtNm;
	}
	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}
	public String getsTradeStatus() {
		return sTradeStatus;
	}
	public void setsTradeStatus(String sTradeStatus) {
		this.sTradeStatus = sTradeStatus;
	}
	public String getsFromDt() {
		return sFromDt;
	}
	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}
	public String getsToDt() {
		return sToDt;
	}
	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}
	public String getsFromDtView() {
		return sFromDtView;
	}
	public void setsFromDtView(String sFromDtView) {
		this.sFromDtView = sFromDtView;
	}
	public String getsToDtView() {
		return sToDtView;
	}
	public void setsToDtView(String sToDtView) {
		this.sToDtView = sToDtView;
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
	public String getsConfRequestStartDt() {
		return sConfRequestStartDt;
	}
	public void setsConfRequestStartDt(String sConfRequestStartDt) {
		this.sConfRequestStartDt = sConfRequestStartDt;
	}
	public String getsConfRequestEndDt() {
		return sConfRequestEndDt;
	}
	public void setsConfRequestEndDt(String sConfRequestEndDt) {
		this.sConfRequestEndDt = sConfRequestEndDt;
	}
	public String getsPrdtCd() {
		return sPrdtCd;
	}
	public void setsPrdtCd(String sPrdtCd) {
		this.sPrdtCd = sPrdtCd;
	}
	public String getsDisplayYn() {
		return sDisplayYn;
	}
	public void setsDisplayYn(String sDisplayYn) {
		this.sDisplayYn = sDisplayYn;
	}
	public String getsAreaCd() {
		return sAreaCd;
	}
	public void setsAreaCd(String sAreaCd) {
		this.sAreaCd = sAreaCd;
	}
	public String getsMonthEnd() {
		return sMonthEnd;
	}
	public void setsMonthEnd(String sMonthEnd) {
		this.sMonthEnd = sMonthEnd;
	}
	public String getsTamnacardPrdtYn() {
		return sTamnacardPrdtYn;
	}
	public void setsTamnacardPrdtYn(String sTamnacardPrdtYn) {
		this.sTamnacardPrdtYn = sTamnacardPrdtYn;
	}
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}
}
