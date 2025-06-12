package mas.ad.vo;

import java.util.List;

public class AD_DFTINFVO extends AD_DFTINFSVO {

	private String corpId;
	private String adNm;
	private String adInf;
	private String frstRegDttm;
	private String lastModDttm;
	private String adInfImg;
	private String adSimpleExp;
	private String frstRegId;
	private String lastModId;
	private String totalBuyNum;
	private String adultAgeStd;
	private String juniorAgeStd;
	private String childAgeStd;
	private String adDiv;
	private String adArea;
	private String adGrd;
	private String tip;
	private String infIntrolod;
	private String infEquif;
	private String infOpergud;
	private String infNti;
	private String chkinTm;
	private String chkoutTm;
	private String cancelGuide;

	private String juniorAbleYn;
	private String childAbleYn;

	private String adDivNm;
	private String adAreaNm;
	private String mappingNum;

	private List<String> iconCd;

	/** 당일예약불가여부 */
	private String dayRsvUnableYn;
	/** 당일예약불가시간 */
	private String dayRsvUnableTm;
	
	/** 홍보영상 URL */
	private String sccUrl;

	/** 검색어 */
	private String srchWord1;
	private String srchWord2;
	private String srchWord3;
	private String srchWord4;
	private String srchWord5;
	private String srchWord6;
	private String srchWord7;
	private String srchWord8;
	private String srchWord9;
	private String srchWord10;

	/** 성.소.유 연령 기준 API MAPPING CODE **/
	private String adultAgeStdApicode;
	private String juniorAgeStdApicode;
	private String childAgeStdApicode;

	/** TLL 금액 연동 기준 **/
	private String tllPriceLink;

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getAdNm() {
		return adNm;
	}

	public void setAdNm(String adNm) {
		this.adNm = adNm;
	}

	public String getAdInf() {
		return adInf;
	}

	public void setAdInf(String adInf) {
		this.adInf = adInf;
	}

	public String getFrstRegDttm() {
		return frstRegDttm;
	}

	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}

	public String getLastModDttm() {
		return lastModDttm;
	}

	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}

	public String getAdInfImg() {
		return adInfImg;
	}

	public void setAdInfImg(String adInfImg) {
		this.adInfImg = adInfImg;
	}

	public String getAdSimpleExp() {
		return adSimpleExp;
	}

	public void setAdSimpleExp(String adSimpleExp) {
		this.adSimpleExp = adSimpleExp;
	}

	public String getFrstRegId() {
		return frstRegId;
	}

	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}

	public String getLastModId() {
		return lastModId;
	}

	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}

	public String getTotalBuyNum() {
		return totalBuyNum;
	}

	public void setTotalBuyNum(String totalBuyNum) {
		this.totalBuyNum = totalBuyNum;
	}

	public String getAdultAgeStd() {
		return adultAgeStd;
	}

	public void setAdultAgeStd(String adultAgeStd) {
		this.adultAgeStd = adultAgeStd;
	}

	public String getJuniorAgeStd() {
		return juniorAgeStd;
	}

	public void setJuniorAgeStd(String juniorAgeStd) {
		this.juniorAgeStd = juniorAgeStd;
	}

	public String getChildAgeStd() {
		return childAgeStd;
	}

	public void setChildAgeStd(String childAgeStd) {
		this.childAgeStd = childAgeStd;
	}

	public String getAdDiv() {
		return adDiv;
	}

	public void setAdDiv(String adDiv) {
		this.adDiv = adDiv;
	}

	public String getAdArea() {
		return adArea;
	}

	public void setAdArea(String adArea) {
		this.adArea = adArea;
	}

	public String getAdGrd() {
		return adGrd;
	}

	public void setAdGrd(String adGrd) {
		this.adGrd = adGrd;
	}

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public String getAdDivNm() {
		return adDivNm;
	}

	public void setAdDivNm(String adDivNm) {
		this.adDivNm = adDivNm;
	}

	public String getAdAreaNm() {
		return adAreaNm;
	}

	public void setAdAreaNm(String adAreaNm) {
		this.adAreaNm = adAreaNm;
	}

	public String getInfIntrolod() {
		return infIntrolod;
	}

	public void setInfIntrolod(String infIntrolod) {
		this.infIntrolod = infIntrolod;
	}

	public String getInfEquif() {
		return infEquif;
	}

	public void setInfEquif(String infEquif) {
		this.infEquif = infEquif;
	}

	public String getInfOpergud() {
		return infOpergud;
	}

	public void setInfOpergud(String infOpergud) {
		this.infOpergud = infOpergud;
	}

	public String getInfNti() {
		return infNti;
	}

	public void setInfNti(String infNti) {
		this.infNti = infNti;
	}

	public String getChkinTm() {
		return chkinTm;
	}

	public void setChkinTm(String chkinTm) {
		this.chkinTm = chkinTm;
	}

	public String getChkoutTm() {
		return chkoutTm;
	}

	public void setChkoutTm(String chkoutTm) {
		this.chkoutTm = chkoutTm;
	}

	public String getMappingNum() {
		return mappingNum;
	}

	public void setMappingNum(String mappingNum) {
		this.mappingNum = mappingNum;
	}

	public String getCancelGuide() {
		return cancelGuide;
	}

	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}

	public String getJuniorAbleYn() {
		return juniorAbleYn;
	}

	public void setJuniorAbleYn(String juniorAbleYn) {
		this.juniorAbleYn = juniorAbleYn;
	}

	public String getChildAbleYn() {
		return childAbleYn;
	}

	public void setChildAbleYn(String childAbleYn) {
		this.childAbleYn = childAbleYn;
	}

	public List<String> getIconCd() {
		return iconCd;
	}

	public void setIconCd(List<String> iconCd) {
		this.iconCd = iconCd;
	}

	public String getSrchWord1() {
		return srchWord1;
	}

	public void setSrchWord1(String srchWord1) {
		this.srchWord1 = srchWord1;
	}

	public String getSrchWord2() {
		return srchWord2;
	}

	public void setSrchWord2(String srchWord2) {
		this.srchWord2 = srchWord2;
	}

	public String getSrchWord3() {
		return srchWord3;
	}

	public void setSrchWord3(String srchWord3) {
		this.srchWord3 = srchWord3;
	}

	public String getSrchWord4() {
		return srchWord4;
	}

	public void setSrchWord4(String srchWord4) {
		this.srchWord4 = srchWord4;
	}

	public String getSrchWord5() {
		return srchWord5;
	}

	public void setSrchWord5(String srchWord5) {
		this.srchWord5 = srchWord5;
	}

	public String getSrchWord6() {
		return srchWord6;
	}

	public void setSrchWord6(String srchWord6) {
		this.srchWord6 = srchWord6;
	}

	public String getSrchWord7() {
		return srchWord7;
	}

	public void setSrchWord7(String srchWord7) {
		this.srchWord7 = srchWord7;
	}

	public String getSrchWord8() {
		return srchWord8;
	}

	public void setSrchWord8(String srchWord8) {
		this.srchWord8 = srchWord8;
	}

	public String getSrchWord9() {
		return srchWord9;
	}

	public void setSrchWord9(String srchWord9) {
		this.srchWord9 = srchWord9;
	}

	public String getSrchWord10() {
		return srchWord10;
	}

	public void setSrchWord10(String srchWord10) {
		this.srchWord10 = srchWord10;
	}

	public String getDayRsvUnableYn() {
		return dayRsvUnableYn;
	}

	public void setDayRsvUnableYn(String dayRsvUnableYn) {
		this.dayRsvUnableYn = dayRsvUnableYn;
	}

	public String getDayRsvUnableTm() {
		return dayRsvUnableTm;
	}

	public void setDayRsvUnableTm(String dayRsvUnableTm) {
		this.dayRsvUnableTm = dayRsvUnableTm;
	}

	public String getSccUrl() {
		return sccUrl;
	}

	public void setSccUrl(String sccUrl) {
		this.sccUrl = sccUrl;
	}

	public String getAdultAgeStdApicode() {
		return adultAgeStdApicode;
	}

	public void setAdultAgeStdApicode(String adultAgeStdApicode) {
		this.adultAgeStdApicode = adultAgeStdApicode;
	}

	public String getJuniorAgeStdApicode() {
		return juniorAgeStdApicode;
	}

	public void setJuniorAgeStdApicode(String juniorAgeStdApicode) {
		this.juniorAgeStdApicode = juniorAgeStdApicode;
	}

	public String getChildAgeStdApicode() {
		return childAgeStdApicode;
	}

	public void setChildAgeStdApicode(String childAgeStdApicode) {
		this.childAgeStdApicode = childAgeStdApicode;
	}

	public String getTllPriceLink() {
		return tllPriceLink;
	}

	public void setTllPriceLink(String tllPriceLink) {
		this.tllPriceLink = tllPriceLink;
	}
}
