package oss.cmm.vo;

import java.util.Calendar;

public class CALENDARVO {


	@SuppressWarnings("static-access")
	public void initValue(Calendar cal){
		
		this.setiYear(cal.get(Calendar.YEAR));
    	this.setiMonth(cal.get(Calendar.MONTH)+1);
    	this.setiDay(1);
    	this.setiMonthLastDay(cal.getActualMaximum(cal.DAY_OF_MONTH));
    	this.setiWeek(cal.get(Calendar.DAY_OF_WEEK));
    	
	}
	
	private int iYear;
	private int iMonth;
	private int iMonthLastDay;

	private int iDay;
	private int iWeek;
	private String sWeek;
		
	private String sHolidayYN;
	private String sHolidayNm;
	
	private String sPrevNext;
	
	public int getiYear() {
		return iYear;
	}
	public void setiYear(int iYear) {
		this.iYear = iYear;
	}
	public int getiMonth() {
		return iMonth;
	}
	public void setiMonth(int iMonth) {
		this.iMonth = iMonth;
	}
	public int getiMonthLastDay() {
		return iMonthLastDay;
	}
	public void setiMonthLastDay(int iMonthLastDay) {
		this.iMonthLastDay = iMonthLastDay;
	}
	public int getiDay() {
		return iDay;
	}
	public void setiDay(int iDay) {
		this.iDay = iDay;
	}
	public int getiWeek() {
		return iWeek;
	}
	public void setiWeek(int iWeek) {
		this.iWeek = iWeek;
	}
	public String getsWeek() {
		return sWeek;
	}
	public void setsWeek(String sWeek) {
		this.sWeek = sWeek;
	}
	public String getsHolidayYN() {
		return sHolidayYN;
	}
	public void setsHolidayYN(String sHolidayYN) {
		this.sHolidayYN = sHolidayYN;
	}
	public String getsHolidayNm() {
		return sHolidayNm;
	}
	public void setsHolidayNm(String sHolidayNm) {
		this.sHolidayNm = sHolidayNm;
	}
	public String getsPrevNext() {
		return sPrevNext;
	}
	public void setsPrevNext(String sPrevNext) {
		this.sPrevNext = sPrevNext;
	}
	@Override
	public String toString() {
		return "CALENDARVO [iYear=" + iYear + ", iMonth=" + iMonth
				+ ", iMonthLastDay=" + iMonthLastDay  + ", iDay=" + iDay + ", iWeek=" + iWeek
				+ ", sWeek=" + sWeek + ", sHolidayYN=" + sHolidayYN
				+ ", sHolidayNm=" + sHolidayNm + ", sPrevNext=" + sPrevNext
				+ "]";
	}
}
