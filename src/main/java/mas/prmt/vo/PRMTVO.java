package mas.prmt.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class PRMTVO extends pageDefaultVO{
	private String prmtNum;
	private String corpId;
	private String prmtNm;
	private String prmtExp;
	private String startDt;
	private String endDt;
	private String prmtDiv;
	private String listImg;
	private String dtlImg;
	private String mobileDtlImg;
	private String winsImg;
	private String statusCd;
	private String frstRegDttm;
	private String frstRegId;
	private String frstRegIp;
	private String lastModDttm;
	private String lastModId;
	private String lastModIp;
	private String confRequestDttm;
	private String confDttm;
	
	private String dtlUrl;
	private String dtlNwdYn;
	private String dtlUrlMobile;
	
	private String cmtYn;
	
	private List<String> prdtNum;
	private String prdtNumOne;
	private String corpCd;
	private String corpNm;
	
	private String sKey;
	private String sKeyOpt;
	
	/** 상품 노출 구분 */
	private String prdtViewDiv;
	/** Dday 출력 여부 */
	private String ddayViewYn;
	/** 종료 여부 */
	private String finishYn;
	/** 당첨자 페이지 여부 */
	private String winsYn;
	/** 메인 배너 */
	private String mainImg;
	/** 배경 색 번호 */
	private String bgColorNum;
	// 모바일 메인 배너
	private String mobileMainImg;

	private String dtlBgColor;
	private String dtlBgImg;
	private String mobileDtlBgImg;

	private String prevPrmtNum;
	private String prevPrmtNm;
	private String prevStartDt;
	private String prevEndDt;
	private String nextPrmtNum;
	private String nextPrmtNm;
	private String nextStartDt;
	private String nextEndDt;

	private String sPrmtDiv;
	private String prmtDivNm;
	private String adbannerViewYn;

	private String viewCnt;
	
	public String getPrmtNum() {
		return prmtNum;
	}
	public void setPrmtNum(String prmtNum) {
		this.prmtNum = prmtNum;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getPrmtNm() {
		return prmtNm;
	}
	public void setPrmtNm(String prmtNm) {
		this.prmtNm = prmtNm;
	}
	public String getPrmtExp() {
		return prmtExp;
	}
	public void setPrmtExp(String prmtExp) {
		this.prmtExp = prmtExp;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getPrmtDiv() {
		return prmtDiv;
	}
	public void setPrmtDiv(String prmtDiv) {
		this.prmtDiv = prmtDiv;
	}
	public String getListImg() {
		return listImg;
	}
	public void setListImg(String listImg) {
		this.listImg = listImg;
	}
	public String getDtlImg() {
		return dtlImg;
	}
	public void setDtlImg(String dtlImg) {
		this.dtlImg = dtlImg;
	}
	public String getMobileDtlImg() {
		return mobileDtlImg;
	}
	public void setMobileDtlImg(String mobileDtlImg) {
		this.mobileDtlImg = mobileDtlImg;
	}
	public String getWinsImg() {
		return winsImg;
	}
	public void setWinsImg(String winsImg) {
		this.winsImg = winsImg;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getFrstRegIp() {
		return frstRegIp;
	}
	public void setFrstRegIp(String frstRegIp) {
		this.frstRegIp = frstRegIp;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public String getLastModIp() {
		return lastModIp;
	}
	public void setLastModIp(String lastModIp) {
		this.lastModIp = lastModIp;
	}
	public String getConfRequestDttm() {
		return confRequestDttm;
	}
	public void setConfRequestDttm(String confRequestDttm) {
		this.confRequestDttm = confRequestDttm;
	}
	public String getConfDttm() {
		return confDttm;
	}
	public void setConfDttm(String confDttm) {
		this.confDttm = confDttm;
	}
	public List<String> getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(List<String> prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getDtlUrl() {
		return dtlUrl;
	}
	public void setDtlUrl(String dtlUrl) {
		this.dtlUrl = dtlUrl;
	}
	public String getDtlNwdYn() {
		return dtlNwdYn;
	}
	public void setDtlNwdYn(String dtlNwdYn) {
		this.dtlNwdYn = dtlNwdYn;
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
	public String getDtlUrlMobile() {
		return dtlUrlMobile;
	}
	public void setDtlUrlMobile(String dtlUrlMobile) {
		this.dtlUrlMobile = dtlUrlMobile;
	}
	public String getPrdtNumOne() {
		return prdtNumOne;
	}
	public void setPrdtNumOne(String prdtNumOne) {
		this.prdtNumOne = prdtNumOne;
	}
	public String getCmtYn() {
		return cmtYn;
	}
	public void setCmtYn(String cmtYn) {
		this.cmtYn = cmtYn;
	}
	public String getPrdtViewDiv() {
		return prdtViewDiv;
	}
	public void setPrdtViewDiv(String prdtViewDiv) {
		this.prdtViewDiv = prdtViewDiv;
	}
	public String getDdayViewYn() {
		return ddayViewYn;
	}
	public void setDdayViewYn(String ddayViewYn) {
		this.ddayViewYn = ddayViewYn;
	}
	public String getFinishYn() {
		return finishYn;
	}
	public void setFinishYn(String finishYn) {
		this.finishYn = finishYn;
	}
	public String getWinsYn() {
		return winsYn;
	}
	public void setWinsYn(String winsYn) {
		this.winsYn = winsYn;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public String getBgColorNum() {
		return bgColorNum;
	}
	public void setBgColorNum(String bgColorNum) {
		this.bgColorNum = bgColorNum;
	}
	public String getMobileMainImg() {
		return mobileMainImg;
	}
	public void setMobileMainImg(String mobileMainImg) {
		this.mobileMainImg = mobileMainImg;
	}
	public String getDtlBgColor() {
		return dtlBgColor;
	}
	public void setDtlBgColor(String dtlBgColor) {
		this.dtlBgColor = dtlBgColor;
	}
	public String getDtlBgImg() {
		return dtlBgImg;
	}
	public void setDtlBgImg(String dtlBgImg) {
		this.dtlBgImg = dtlBgImg;
	}
	public String getMobileDtlBgImg() {
		return mobileDtlBgImg;
	}
	public void setMobileDtlBgImg(String mobileDtlBgImg) {
		this.mobileDtlBgImg = mobileDtlBgImg;
	}
	public String getPrevPrmtNum() {
		return prevPrmtNum;
	}
	public void setPrevPrmtNum(String prevPrmtNum) {
		this.prevPrmtNum = prevPrmtNum;
	}
	public String getPrevPrmtNm() {
		return prevPrmtNm;
	}
	public void setPrevPrmtNm(String prevPrmtNm) {
		this.prevPrmtNm = prevPrmtNm;
	}
	public String getPrevStartDt() {
		return prevStartDt;
	}
	public void setPrevStartDt(String prevStartDt) {
		this.prevStartDt = prevStartDt;
	}
	public String getPrevEndDt() {
		return prevEndDt;
	}
	public void setPrevEndDt(String prevEndDt) {
		this.prevEndDt = prevEndDt;
	}
	public String getNextPrmtNum() {
		return nextPrmtNum;
	}
	public void setNextPrmtNum(String nextPrmtNum) {
		this.nextPrmtNum = nextPrmtNum;
	}
	public String getNextPrmtNm() {
		return nextPrmtNm;
	}
	public void setNextPrmtNm(String nextPrmtNm) {
		this.nextPrmtNm = nextPrmtNm;
	}
	public String getNextStartDt() {
		return nextStartDt;
	}
	public void setNextStartDt(String nextStartDt) {
		this.nextStartDt = nextStartDt;
	}
	public String getNextEndDt() {
		return nextEndDt;
	}
	public void setNextEndDt(String nextEndDt) {
		this.nextEndDt = nextEndDt;
	}
	public String getsPrmtDiv() {
		return sPrmtDiv;
	}
	public void setsPrmtDiv(String sPrmtDiv) {
		this.sPrmtDiv = sPrmtDiv;
	}
	public String getPrmtDivNm() {
		return prmtDivNm;
	}
	public void setPrmtDivNm(String prmtDivNm) {
		this.prmtDivNm = prmtDivNm;
	}

	public String getAdbannerViewYn() {
		return adbannerViewYn;
	}

	public void setAdbannerViewYn(String adbannerViewYn) {
		this.adbannerViewYn = adbannerViewYn;
	}
	public String getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(String viewCnt) {
		this.viewCnt = viewCnt;
	}

}
