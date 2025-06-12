package mw.app.service.impl;

import java.util.List;

import javapns.communication.ConnectionToAppleServer;
import javapns.devices.implementations.basic.BasicDevice;
import javapns.notification.AppleNotificationServerBasicImpl;
import javapns.notification.PushNotificationManager;
import javapns.notification.PushNotificationPayload;
import javapns.notification.PushedNotification;
import javapns.notification.ResponsePacket;

import javax.annotation.Resource;

import mw.app.service.MwAppService;
import mw.app.vo.DEVICEINFVO;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("mwAppService")
public class MwAppServiceImpl extends EgovAbstractServiceImpl implements MwAppService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	/** appDAO */
	@Resource(name = "appDAO")
	private AppDAO appDAO;
	
	/**
	 * 앱 디바이스 정보 등록 / 수정
	 * 파일명 : mergeDeviceInf
	 * 작성일 : 2015. 12. 30. 오후 2:07:57
	 * 작성자 : 최영철
	 * @param deviceinfVO
	 */
	@Override
	public void mergeDeviceInf(DEVICEINFVO deviceinfVO){
		appDAO.mergeDeviceInf(deviceinfVO);
	}
	
	/**
	 * 안드로이드 푸쉬 전송
	 * 파일명 : sendPushAndroid
	 * 작성일 : 2016. 1. 25. 오후 2:09:02
	 * 작성자 : 최영철
	 * @param regId
	 * @param msg
	 * @param url
	 * @param imgUrl
	 * @throws Exception
	 */
	public Result sendPushAndroid(String regId, String msg, String url, String imgUrl) throws Exception{
		Sender sender = new Sender("AIzaSyDZnuSJng2aLTUrdAgrIAtMTW0DY14_Q_Y");
		
		Message.Builder mb = new Message.Builder();
		
		mb.delayWhileIdle(false);
		mb.timeToLive(1800);
		mb.addData("title", "탐나오");
		mb.addData("msg", msg);
		mb.addData("url", url);
		mb.addData("pictureurl", imgUrl);
		
		Result result = sender.send(mb.build(), regId, 5);
		return result;
		
	}
	
	/**
	 * IOS 푸쉬 전송
	 * 파일명 : sendPushIOS
	 * 작성일 : 2016. 1. 25. 오후 2:20:29
	 * 작성자 : 최영철
	 * @param reg_id
	 * @param msg
	 * @param url
	 * @throws Exception
	 */
	public void sendPushIOS(String reg_id, String msg, String url) throws Exception{
		PushNotificationPayload payload = new PushNotificationPayload();
		
		PushNotificationManager pnm = new PushNotificationManager();
		
		try {
			payload.addAlert(msg);
			payload.addBadge(1);
			payload.addSound("default");
			payload.addCustomDictionary("url", url);
			
			
			BasicDevice device = new BasicDevice(reg_id);
	        device.setDeviceId("iPhone");
	        
	        // 운영
	        String host = "gateway.push.apple.com";
	        // 개발
//	        String host = "gateway.sandbox.push.apple.com";
	        
	        // 운영
	        String apnsPath = EgovProperties.getProperty("Push.Folder") + "/tamnao-apns-dist.p12";
	        // 개발
//	        String apnsPath = "c:/tamnao-apns-dev.p12";
	        
	        
			AppleNotificationServerBasicImpl appleNoti = new AppleNotificationServerBasicImpl(apnsPath, "tamnao2016", ConnectionToAppleServer.KEYSTORE_TYPE_PKCS12, host, 2195);
			
			pnm.initializeConnection(appleNoti);
			log.info("SEND : " + payload.getPayload().toString());
			
			//Send Push
	        PushedNotification pushed = pnm.sendNotification(device, payload);
	        
	        ResponsePacket resultPacket = pushed.getResponse();

	        if (resultPacket != null) {
	        	log.info("resultPacket.isErrorResponsePacket() [" + resultPacket.isErrorResponsePacket() + "]");
	        	log.info("resultPacket.isValidErrorMessage() [" + resultPacket.isValidErrorMessage() + "]");
	    		log.info("RESPONSE : " + resultPacket.getMessage() + " [" + resultPacket.getStatus() + "]");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(pnm != null){
				pnm.stopConnection();
			}
		}
	}
	
	/**
	 * 디바이스 정보 조회
	 * 파일명 : selectDeviceInfo
	 * 작성일 : 2016. 1. 25. 오후 3:35:28
	 * 작성자 : 최영철
	 * @param deviceInfo
	 * @return
	 */
	@Override
	public DEVICEINFVO selectDeviceInfo(DEVICEINFVO deviceInfo){
		return appDAO.selectDeviceInfo(deviceInfo);
	}
	
	/**
	 * 푸쉬 발송 여부 변경
	 * 파일명 : updateDevicePush
	 * 작성일 : 2016. 1. 25. 오후 3:45:55
	 * 작성자 : 최영철
	 * @param deviceInfo
	 */
	@Override
	public void updateDevicePush(DEVICEINFVO deviceInfo){
		appDAO.updateDevicePush(deviceInfo);
	}
	
	/**
	 * 디바이스 전체 목록 조회
	 * 파일명 : selectDeviceAllList
	 * 작성일 : 2016. 1. 25. 오후 5:54:37
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<DEVICEINFVO> selectDeviceAllList(){
		return appDAO.selectDeviceAllList();
	}
}
