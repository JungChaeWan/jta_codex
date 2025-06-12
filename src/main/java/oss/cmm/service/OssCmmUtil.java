package oss.cmm.service;

import java.util.Date;

public class OssCmmUtil {

	/**
	 * 두 날짜의 시간차 구하기
	 * 파일명 : getDifTime
	 * 작성일 : 2015. 10. 23. 오전 9:52:53
	 * 작성자 : 최영철
	 * @param fromDate	yyyyMMddHHmm
	 * @param toDate	yyyyMMddHHmm
	 * @return
	 */
	public static String getDifTime(Date fromDate, Date toDate) {
		long startTime = fromDate.getTime();
		long endTime   = toDate.getTime();
		
		long mills = endTime - startTime;
		String difTime = String.valueOf(mills / 60000 / 60);
		
		return difTime;
		
	}
	
	public static long getDifTimeSec(Date fromDate, Date toDate) {
		long startTime = fromDate.getTime();
		long endTime   = toDate.getTime();
		
		long mills = (endTime - startTime) / 1000 ;
		
		return mills;
		
	}
	
	public static long getDifDay(Date fromDate, Date toDate) {
		long diff = toDate.getTime() - fromDate.getTime();
	    long diffDays = diff / (24 * 60 * 60 * 1000);
	 
	    return diffDays;
	  }

	public static String getFullDay(int year, int month, int day) {
		String fullDay = String.valueOf(year);
		
		if(month <= 9) {
			fullDay += "0" + String.valueOf(month);
		} else {
			fullDay += String.valueOf(month);
		}
		
		if(day <=9) {
			fullDay += "0" + String.valueOf(day);
		} else {
			fullDay += String.valueOf(day);
		}
		return fullDay;
	}
}
