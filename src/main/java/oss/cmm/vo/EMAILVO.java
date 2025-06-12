package oss.cmm.vo;

import java.util.List;

public class EMAILVO extends pageDefaultVO{
	private String sendNames;
	private String sendEmails;
	private String subject;
	private String msg;
	private String callback;
	
	List<String> emailList;
	private String saveFilePath;
	private String saveFileName;
	
	private String prmtDiv;
	private String prmtNum;

	
	public String getSendNames() {
		return sendNames;
	}
	public void setSendNames(String sendNames) {
		this.sendNames = sendNames;
	}
	public String getSendEmails() {
		return sendEmails;
	}
	public void setSendEmails(String sendEmails) {
		this.sendEmails = sendEmails;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public List<String> getEmailList() {
		return emailList;
	}
	public void setEmailList(List<String> emailList) {
		this.emailList = emailList;
	}
	public String getSaveFilePath() {
		return saveFilePath;
	}
	public void setSaveFilePath(String saveFilePath) {
		this.saveFilePath = saveFilePath;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getPrmtDiv() {
		return prmtDiv;
	}
	public void setPrmtDiv(String prmtDiv) {
		this.prmtDiv = prmtDiv;
	}
	public String getPrmtNum() {
		return prmtNum;
	}
	public void setPrmtNum(String prmtNum) {
		this.prmtNum = prmtNum;
	}
	
	
}
