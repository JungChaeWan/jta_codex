/**
 * 
 */
package oss.corp.vo;


/**
 * @author younghu
 *
 */
public class CORPVO extends CORPSVO{

	/** 업체 아이디 */
	private String corpId;
	/** 거래 상태 코드 */
	private String tradeStatusCd;
	/** 업체 코드 */
	private String corpCd;
	/** 업체 수정 코드 */
	private String corpModCd;
	/** 업체 코드 명 */
	private String corpCdNm;
	/** 업체 명 */
	private String corpNm;
	/** 상호명 */
	private String shopNm;
	/** 사업자등록 번호 */
	private String coRegNum;
	/** 업체 유형 */
	private String corpType;
	/** 예약 전화 번호 */
	private String rsvTelNum;
	/** 팩스 번호 */
	private String faxNum;
	/** 업체 이메일 */
	private String corpEmail;
	/** 홈페이지 주소 */
	private String hmpgAddr;
	/** 분과 명 */
	private String branchNm;
	/** 도로명 주소 */
	private String roadNmAddr;
	/** 상세 주소 */
	private String dtlAddr;
	/** 경도 */
	private String lon;
	/** 위도 */
	private String lat;
	
	/** 대표자 명 */
	private String ceoNm;
	/** 대표자 생년월일 */
	private String ceoBth;
	/** 대표자 전화 번호 */
	private String ceoTelNum;
	/** 업종 */
	private String bsncon;
	/** 업태 */
	private String bsntyp;
	
	/** 은행 */
	private String bankNm;
	/** 계좌번호 */
	private String accNum;
	/** 예금주 */
	private String depositor;
	
	/** 관리자(담당자) 명 */
	private String admNm;
	/** 관리자(담당자) 부서 */
	private String admDep;
	/** 관리자(담당자) 직위 */
	private String admOfcpos;
	/** 관리자(담당자) 모바일(핸드폰번호) */	
	private String admMobile;
	/** 관리자(담당자) 모바일2(핸드폰번호) */
	private String admMobile2;
	/** 관리자(담당자) 모바일3(핸드폰번호) */
	private String admMobile3;
	/** 관리자(담당자) 직통번호*/
	private String admTelnum;
	/** 관리자(담당자) 이메일 */
	private String admEmail;
	/** 관리자(담당자) 이메일2 */
	private String admEmail2;

	/** 광고 이미지 */
	private String adtmImg;
	/** 광고 URL */
	private String adtmUrl;
	/** 광고 간략설명 */
	private String adtmSimpleExp;
	
	/** 업체 연계 여부 */
	private String corpLinkYn;
	/** 렌터카 실시간 금액보험연계 여부 */
	private String corpLinkIsrYn;
	/** 연계 B2B 아이디 */
	private String linkB2bId;
	/** 연계 맵핑 번호 */
	private String linkMappingNum;
	/** 연계 거래 번호 */
	private String linkTradeNum;	
	/** HI JEJU 맵핑 번호 */
	private Integer hijejuMappingNum;
	
	/** 승인 일자 */
	private String confDt;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최종 수정 일시 */
	private String lastModDttm;
	
	/** 담당자 */
	private String managerId;
	/** 담당자 명 */
	private String managerNm;	
	/** 담당자 Email */
	private String managerEmail;
	
	/** 업체 서브 코드 */
	private String corpSubCd;
	/** 업체 신청 번호 */
	private String requestNum;
	
	/** 협회 회원 여부 */
	private String asctMemYn;
	/** 수수료 번호*/
	private String cmssNum;
	/** B2B 사용 여부 */
	private String b2bUseYn;
	/** B2B 수수료 번호*/
	private String b2bCmssNum;
	/** 포스 사용 여부 */
	private String posUseYn;
	
	/** 우수관광사업체 */
	private String superbCorpYn;
	
	/** LINK 상품 사용 여부 */
	private String linkPrdtUseYn;
	
	/** VISIT 제주 맵핑 ID */
	private String visitMappingId;
	/** VISIT 제주 맵핑 명칭 */
	private String visitMappingNm;
	/** LS컴퍼니 링크여부*/
	private String lsLinkYn;
	/** 비짓제주 매핑여부 */
	private String visitMappingYn;
	/** 업체별명 */
	private String corpAliasNm;
	/** 탐나는전 가맹점여부 */
	private String tamnacardMngYn;
	/**숙소 API 연동 업체명 2021.07.01 chaewan.jung**/
	private String adApiLinkNm;
	/** 렌터카 구분 그림(G)인스(I)리본(R)*/
	private String apiRentDiv;
	/**업체 코멘트 2022.06.10 chaewan.jung**/
	private String corpComment;
	
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCorpModCd() {
		return corpModCd;
	}
	public void setCorpModCd(String corpModCd) {
		this.corpModCd = corpModCd;
	}
	public String getCorpCdNm() {
		return corpCdNm;
	}
	public void setCorpCdNm(String corpCdNm) {
		this.corpCdNm = corpCdNm;
	}
	public String getTradeStatusCd() {
		return tradeStatusCd;
	}
	public void setTradeStatusCd(String tradeStatusCd) {
		this.tradeStatusCd = tradeStatusCd;
	}
	public String getCoRegNum() {
		return coRegNum;
	}
	public void setCoRegNum(String coRegNum) {
		this.coRegNum = coRegNum;
	}
	public String getCeoNm() {
		return ceoNm;
	}
	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}
	public String getRsvTelNum() {
		return rsvTelNum;
	}
	public void setRsvTelNum(String rsvTelNum) {
		this.rsvTelNum = rsvTelNum;
	}
	public String getCorpEmail() {
		return corpEmail;
	}
	public void setCorpEmail(String corpEmail) {
		this.corpEmail = corpEmail;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getRoadNmAddr() {
		return roadNmAddr;
	}
	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}
	public String getDtlAddr() {
		return dtlAddr;
	}
	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}
	public String getHmpgAddr() {
		return hmpgAddr;
	}
	public void setHmpgAddr(String hmpgAddr) {
		this.hmpgAddr = hmpgAddr;
	}
	public String getCorpLinkYn() {
		return corpLinkYn;
	}
	public void setCorpLinkYn(String corpLinkYn) {
		this.corpLinkYn = corpLinkYn;
	}
	public String getConfDt() {
		return confDt;
	}
	public void setConfDt(String confDt) {
		this.confDt = confDt;
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
	public String getCeoTelNum() {
		return ceoTelNum;
	}
	public void setCeoTelNum(String ceoTelNum) {
		this.ceoTelNum = ceoTelNum;
	}
	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public String getManagerNm() {
		return managerNm;
	}
	public void setManagerNm(String managerNm) {
		this.managerNm = managerNm;
	}
	public String getShopNm() {
		return shopNm;
	}
	public void setShopNm(String shopNm) {
		this.shopNm = shopNm;
	}
	public String getAdtmImg() {
		return adtmImg;
	}
	public void setAdtmImg(String adtmImg) {
		this.adtmImg = adtmImg;
	}
	public String getAdtmUrl() {
		return adtmUrl;
	}
	public void setAdtmUrl(String adtmUrl) {
		this.adtmUrl = adtmUrl;
	}
	public String getAdtmSimpleExp() {
		return adtmSimpleExp;
	}
	public void setAdtmSimpleExp(String adtmSimpleExp) {
		this.adtmSimpleExp = adtmSimpleExp;
	}
	public String getRequestNum() {
		return requestNum;
	}
	public void setRequestNum(String requestNum) {
		this.requestNum = requestNum;
	}
	public Integer getHijejuMappingNum() {
		return hijejuMappingNum;
	}
	public void setHijejuMappingNum(Integer hijejuMappingNum) {
		this.hijejuMappingNum = hijejuMappingNum;
	}
	public String getAdmNm() {
		return admNm;
	}
	public void setAdmNm(String admNm) {
		this.admNm = admNm;
	}
	public String getAdmDep() {
		return admDep;
	}
	public void setAdmDep(String admDep) {
		this.admDep = admDep;
	}
	public String getAdmOfcpos() {
		return admOfcpos;
	}
	public void setAdmOfcpos(String admOfcpos) {
		this.admOfcpos = admOfcpos;
	}
	public String getAdmMobile() {
		return admMobile;
	}
	public void setAdmMobile(String admMobile) {
		this.admMobile = admMobile;
	}
	public String getAdmEmail() {
		return admEmail;
	}
	public void setAdmEmail(String admEmail) {
		this.admEmail = admEmail;
	}
	public String getLinkB2bId() {
		return linkB2bId;
	}
	public void setLinkB2bId(String linkB2bId) {
		this.linkB2bId = linkB2bId;
	}
	public String getLinkMappingNum() {
		return linkMappingNum;
	}
	public void setLinkMappingNum(String linkMappingNum) {
		this.linkMappingNum = linkMappingNum;
	}
	public String getLinkTradeNum() {
		return linkTradeNum;
	}
	public void setLinkTradeNum(String linkTradeNum) {
		this.linkTradeNum = linkTradeNum;
	}
	public String getCorpType() {
		return corpType;
	}
	public void setCorpType(String corpType) {
		this.corpType = corpType;
	}
	public String getFaxNum() {
		return faxNum;
	}
	public void setFaxNum(String faxNum) {
		this.faxNum = faxNum;
	}
	public String getBranchNm() {
		return branchNm;
	}
	public void setBranchNm(String branchNm) {
		this.branchNm = branchNm;
	}
	public String getCeoBth() {
		return ceoBth;
	}
	public void setCeoBth(String ceoBth) {
		this.ceoBth = ceoBth;
	}
	public String getBsncon() {
		return bsncon;
	}
	public void setBsncon(String bsncon) {
		this.bsncon = bsncon;
	}
	public String getBsntyp() {
		return bsntyp;
	}
	public void setBsntyp(String bsntyp) {
		this.bsntyp = bsntyp;
	}
	public String getBankNm() {
		return bankNm;
	}
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	public String getAccNum() {
		return accNum;
	}
	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}
	public String getDepositor() {
		return depositor;
	}
	public void setDepositor(String depositor) {
		this.depositor = depositor;
	}
	public String getAdmTelnum() {
		return admTelnum;
	}
	public void setAdmTelnum(String admTelnum) {
		this.admTelnum = admTelnum;
	}
	public String getManagerEmail() {
		return managerEmail;
	}
	public void setManagerEmail(String managerEmail) {
		this.managerEmail = managerEmail;
	}
	public String getCorpSubCd() {
		return corpSubCd;
	}
	public void setCorpSubCd(String corpSubCd) {
		this.corpSubCd = corpSubCd;
	}
	public String getAsctMemYn() {
		return asctMemYn;
	}
	public void setAsctMemYn(String asctMemYn) {
		this.asctMemYn = asctMemYn;
	}
	public String getCmssNum() {
		return cmssNum;
	}
	public void setCmssNum(String cmssNum) {
		this.cmssNum = cmssNum;
	}
	public String getB2bUseYn() {
		return b2bUseYn;
	}
	public void setB2bUseYn(String b2bUseYn) {
		this.b2bUseYn = b2bUseYn;
	}
	public String getB2bCmssNum() {
		return b2bCmssNum;
	}
	public void setB2bCmssNum(String b2bCmssNum) {
		this.b2bCmssNum = b2bCmssNum;
	}
	public String getPosUseYn() {
		return posUseYn;
	}
	public void setPosUseYn(String posUseYn) {
		this.posUseYn = posUseYn;
	}
	public String getSuperbCorpYn() {
		return superbCorpYn;
	}
	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}
	public String getLinkPrdtUseYn() {
		return linkPrdtUseYn;
	}
	public void setLinkPrdtUseYn(String linkPrdtUseYn) {
		this.linkPrdtUseYn = linkPrdtUseYn;
	}
	public String getVisitMappingId() {
		return visitMappingId;
	}
	public void setVisitMappingId(String visitMappingId) {
		this.visitMappingId = visitMappingId;
	}
	public String getVisitMappingNm() {
		return visitMappingNm;
	}
	public void setVisitMappingNm(String visitMappingNm) {
		this.visitMappingNm = visitMappingNm;
	}
	public String getLsLinkYn() {
		return lsLinkYn;
	}
	public void setLsLinkYn(String lsLinkYn) {
		this.lsLinkYn = lsLinkYn;
	}
	public String getVisitMappingYn() {
		return visitMappingYn;
	}
	public void setVisitMappingYn(String visitMappingYn) {
		this.visitMappingYn = visitMappingYn;
	}
	public String getAdmMobile2() {
		return admMobile2;
	}
	public void setAdmMobile2(String admMobile2) {
		this.admMobile2 = admMobile2;
	}
	public String getAdmEmail2() {
		return admEmail2;
	}
	public void setAdmEmail2(String admEmail2) {
		this.admEmail2 = admEmail2;
	}
	public String getCorpAliasNm() {
		return corpAliasNm;
	}
	public void setCorpAliasNm(String corpAliasNm) {
		this.corpAliasNm = corpAliasNm;
	}
	public String getCorpLinkIsrYn() {
		return corpLinkIsrYn;
	}
	public void setCorpLinkIsrYn(String corpLinkIsrYn) {
		this.corpLinkIsrYn = corpLinkIsrYn;
	}

	public String getTamnacardMngYn() {
		return tamnacardMngYn;
	}

	public void setTamnacardMngYn(String tamnacardMngYn) {
		this.tamnacardMngYn = tamnacardMngYn;
	}

	public String getAdApiLinkNm() {
		return adApiLinkNm;
	}

	public void setAdApiLinkNm(String adApiLinkNm) {
		this.adApiLinkNm = adApiLinkNm;
	}

	public String getApiRentDiv() {
		return apiRentDiv;
	}

	public void setApiRentDiv(String apiRentDiv) {
		this.apiRentDiv = apiRentDiv;
	}

	public String getCorpComment() {
		return corpComment;
	}

	public void setCorpComment(String corpComment) {
		this.corpComment = corpComment;
	}

	public String getAdmMobile3() {
		return admMobile3;
	}

	public void setAdmMobile3(String admMobile3) {
		this.admMobile3 = admMobile3;
	}
}
