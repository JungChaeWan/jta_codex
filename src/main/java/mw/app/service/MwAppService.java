package mw.app.service;

import java.util.List;

import com.google.android.gcm.server.Result;

import mw.app.vo.DEVICEINFVO;



public interface MwAppService {

	/**
	 * 앱 디바이스 정보 등록 / 수정
	 * 파일명 : mergeDeviceInf
	 * 작성일 : 2015. 12. 30. 오후 2:07:57
	 * 작성자 : 최영철
	 * @param deviceinfVO
	 */
	void mergeDeviceInf(DEVICEINFVO deviceinfVO);

	/**
	 * 디바이스 정보 조회
	 * 파일명 : selectDeviceInfo
	 * 작성일 : 2016. 1. 25. 오후 3:35:28
	 * 작성자 : 최영철
	 * @param deviceInfo
	 * @return
	 */
	DEVICEINFVO selectDeviceInfo(DEVICEINFVO deviceInfo);

	/**
	 * 푸쉬 발송 여부 변경
	 * 파일명 : updateDevicePush
	 * 작성일 : 2016. 1. 25. 오후 3:45:55
	 * 작성자 : 최영철
	 * @param deviceInfo
	 */
	void updateDevicePush(DEVICEINFVO deviceInfo);

	/**
	 * 디바이스 전체 목록 조회
	 * 파일명 : selectDeviceAllList
	 * 작성일 : 2016. 1. 25. 오후 5:54:37
	 * 작성자 : 최영철
	 * @return
	 */
	List<DEVICEINFVO> selectDeviceAllList();

	/**
	 * IOS 푸쉬 발송
	 * 파일명 : sendPushIOS
	 * 작성일 : 2016. 1. 25. 오후 6:03:07
	 * 작성자 : 최영철
	 * @param regId
	 * @param string
	 * @param url
	 * @throws Exception 
	 */
	void sendPushIOS(String regId, String string, String url) throws Exception;

	/**
	 * 안드로이드 푸쉬 발송
	 * 파일명 : sendPushAndroid
	 * 작성일 : 2016. 1. 25. 오후 6:03:14
	 * 작성자 : 최영철
	 * @param regId
	 * @param string
	 * @param url
	 * @param imgUrl
	 * @return 
	 * @throws Exception 
	 */
	Result sendPushAndroid(String regId, String string, String url, String imgUrl) throws Exception;
	
	
}