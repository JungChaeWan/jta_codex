package oss.useepil.vo;

import java.util.List;

public class USEEPILVO extends USEEPILSVO{

	private String useEpilNum;
	private String corpId;
	private String prdtnum;
	private String userId;
	private String email;
	private String subject;
	private String gpa;
	private String contents;
	private String cmtCnt;
	private String printYn;
	private String frstRegDttm;
	private String lastModDttm;
	private String frstRegId;
	private String frstRegIp;
	private String lastModId;
	private String lastModIp;
	private String corpNm;
	private String prdtNm;

	private String contentsOrg;
	private String subjectHeder;
	private String prdtInf;

	private String imgCnt;
	private String userNm;
	private String telNum;
	private String coCd;

	private List<USEEPILIMGVO> imgList;
	private List<USEEPILCMTVO> cmtList;

	private String reviewType;
	private String cate;
	private String subCate;


	public String getUseEpilNum() {
		return useEpilNum;
	}
	public void setUseEpilNum(String useEpilNum) {
		this.useEpilNum = useEpilNum;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getPrdtnum() {
		return prdtnum;
	}
	public void setPrdtnum(String prdtnum) {
		this.prdtnum = prdtnum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getGpa() {
		return gpa;
	}
	public void setGpa(String gpa) {
		this.gpa = gpa;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCmtCnt() {
		return cmtCnt;
	}
	public void setCmtCnt(String cmtCnt) {
		this.cmtCnt = cmtCnt;
	}
	public String getPrintYn() {
		return printYn;
	}
	public void setPrintYn(String printYn) {
		this.printYn = printYn;
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
	public List<USEEPILCMTVO> getCmtList() {
		return cmtList;
	}
	public void setCmtList(List<USEEPILCMTVO> cmtList) {
		this.cmtList = cmtList;
	}
	public String getContentsOrg() {
		return contentsOrg;
	}
	public void setContentsOrg(String contentsOrg) {
		this.contentsOrg = contentsOrg;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getSubjectHeder() {
		return subjectHeder;
	}
	public void setSubjectHeder(String subjectHeder) {
		this.subjectHeder = subjectHeder;
	}
	public String getPrdtInf() {
		return prdtInf;
	}
	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}

	public List<USEEPILIMGVO> getImgList() {
		return imgList;
	}
	public void setImgList(List<USEEPILIMGVO> imgList) {
		this.imgList = imgList;
	}
	public String getImgCnt() {
		return imgCnt;
	}
	public void setImgCnt(String imgCnt) {
		this.imgCnt = imgCnt;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}
	public String getCoCd() {
		return coCd;
	}
	public void setCoCd(String coCd) {
		this.coCd = coCd;
	}

	public String getReviewType() {
		return reviewType;
	}

	public void setReviewType(String reviewType) {
		this.reviewType = reviewType;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public String getSubCate() {
		return subCate;
	}

	public void setSubCate(String subCate) {
		this.subCate = subCate;
	}
}
