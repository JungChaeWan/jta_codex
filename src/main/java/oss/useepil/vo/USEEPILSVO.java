package oss.useepil.vo;

import oss.cmm.vo.pageDefaultVO;

import java.util.List;


public class USEEPILSVO extends pageDefaultVO{
    
	private String sCorpId;
	private String sPrdtNum;
	private String sPrintYn;
	
	private String sUserId;
	
	private String sKey;
	private String sKeyOpt;
	
	private String corpCd;
	private int useepilPI;
	
	private String sSubject;
	
	private String sRsvNum;

	/**검색 기준 */
	private String sStartFrstRegDttm;
	private String sEndFrstRegDttm;
	private String sCorpNm;
	private String sPrdtNm;
	private String sCate;
	private String sReviewType;
	private String sReviewFeedback;

	/** 상품평 추가 된 list */
	private List<String> useepilPrdtList;

	public String getsCorpId() {
		return sCorpId;
	}
	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}
	public String getsPrintYn() {
		return sPrintYn;
	}
	public void setsPrintYn(String sPrintYn) {
		this.sPrintYn = sPrintYn;
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
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public int getUseepilPI() {
		return useepilPI;
	}
	public void setUseepilPI(int useepilPI) {
		this.useepilPI = useepilPI;
	}
	public String getsUserId() {
		return sUserId;
	}
	public void setsUserId(String sUserId) {
		this.sUserId = sUserId;
	}
	public String getsSubject() {
		return sSubject;
	}
	public void setsSubject(String sSubject) {
		this.sSubject = sSubject;
	}
	public String getsRsvNum() {
		return sRsvNum;
	}
	public void setsRsvNum(String sRsvNum) {
		this.sRsvNum = sRsvNum;
	}

	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String getsCate() {
		return sCate;
	}

	public void setsCate(String sCate) {
		this.sCate = sCate;
	}

	public String getsReviewType() {
		return sReviewType;
	}

	public void setsReviewType(String sReviewType) {
		this.sReviewType = sReviewType;
	}

	public String getsReviewFeedback() {
		return sReviewFeedback;
	}

	public void setsReviewFeedback(String sReviewFeedback) {
		this.sReviewFeedback = sReviewFeedback;
	}

	public String getsStartFrstRegDttm() {
		return sStartFrstRegDttm;
	}

	public void setsStartFrstRegDttm(String sStartFrstRegDttm) {
		this.sStartFrstRegDttm = sStartFrstRegDttm;
	}

	public String getsEndFrstRegDttm() {
		return sEndFrstRegDttm;
	}

	public void setsEndFrstRegDttm(String sEndFrstRegDttm) {
		this.sEndFrstRegDttm = sEndFrstRegDttm;
	}

	public List<String> getUseepilPrdtList() {
		return useepilPrdtList;
	}

	public void setUseepilPrdtList(List<String> useepilPrdtList) {
		this.useepilPrdtList = useepilPrdtList;
	}
}
