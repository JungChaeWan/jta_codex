package mw.app.web;


import com.google.android.gcm.server.Result;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.property.EgovPropertyService;
import mw.app.service.MwAppService;
import mw.app.vo.DEVICEINFVO;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import oss.cmm.service.OssFileUtilService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;

/**
 * 앱 관련 컨트롤러
 * @author 최영철
 * @since  2015. 12. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class MwAppController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "mwAppService")
	private MwAppService mwAppService;
	
	// 파일 관리 서비스
	@Resource(name = "ossFileUtilService")
	private OssFileUtilService fileUtilService;


    Logger log = LogManager.getLogger(this.getClass());
    
    /**
     * 앱 디바이스 정보 등록 / 수정
     * 파일명 : insertDeviceInfo
     * 작성일 : 2015. 12. 30. 오후 2:12:48
     * 작성자 : 최영철
     * @param deviceinfVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/app/insertDeviceInfo.ajax")
	public ModelAndView insertDeviceInfo(@ModelAttribute("DEVICEINFVO") DEVICEINFVO deviceinfVO) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
		boolean paramChk = true;
		
		if(StringUtils.isEmpty(deviceinfVO.getRegId())) {
			resultMap.put("resultCode", "10");
			resultMap.put("resultMsg", "Device ID가 입력되지 않았습니다.");
			paramChk = false;
		}
		if(StringUtils.isEmpty(deviceinfVO.getDeviceDiv())) {
			resultMap.put("resultCode", "10");
			resultMap.put("resultMsg", "Device 구분이 입력되지 않았습니다.");
			paramChk = false;
		}
		if(StringUtils.isEmpty(deviceinfVO.getDeviceVer())) {
			resultMap.put("resultCode", "10");
			resultMap.put("resultMsg", "Device 버전이 입력되지 않았습니다.");
			paramChk = false;
		}
		if(paramChk) {
			try {
				if(StringUtils.isNotEmpty(deviceinfVO.getPushYn())) {
					deviceinfVO.setPushYn("Y");
				}
				mwAppService.mergeDeviceInf(deviceinfVO);

				resultMap.put("resultCode", "00");
				resultMap.put("resultMsg", "정상처리됐습니다.");
			} catch (Exception e) {
				log.error(e.toString());

				resultMap.put("resultCode", "20");
				resultMap.put("resultMsg", "접속 이력 처리중 오류가 발생했습니다.");
			}
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
	}
    
    /**
     * 디바이스 정보 조회
     * 파일명 : selectDeviceInfo
     * 작성일 : 2016. 1. 25. 오후 3:38:42
     * 작성자 : 최영철
     * @param deviceinfVO
     * @return
     */
    @RequestMapping("/mw/selectDeviceInfo.ajax")
    public ModelAndView selectDeviceInfo(@ModelAttribute("DEVICEINFVO") DEVICEINFVO deviceinfVO) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	DEVICEINFVO deviceInfo = mwAppService.selectDeviceInfo(deviceinfVO);
    	resultMap.put("deviceInfo", deviceInfo);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
    }
    
    /**
     * 푸쉬 발송 여부 변경
     * 파일명 : updateDevicePush
     * 작성일 : 2016. 1. 25. 오후 3:48:27
     * 작성자 : 최영철
     * @param params
     * @return
     */
    @RequestMapping("/mw/updateDevicePush.ajax")
    public ModelAndView updateDevicePush(@RequestParam Map<String, String> params) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	DEVICEINFVO deviceInfo = new DEVICEINFVO();
		deviceInfo.setDeviceNum(params.get("deviceNum"));
		deviceInfo.setPushYn(params.get("pushYn"));
		
		mwAppService.updateDevicePush(deviceInfo);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
    }
    
    @RequestMapping("/oss/sendPush.do")
    public ModelAndView sendPush(final MultipartHttpServletRequest multiRequest,
								@RequestParam Map<String, String> params) throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	List<DEVICEINFVO> deviceList = mwAppService.selectDeviceAllList();
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String imgUrl = "";
		
		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			
			while (itr.hasNext()) {
				
				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				String fileName = file.getOriginalFilename();
				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())) {
					String ext = FilenameUtils.getExtension(fileName);
					log.info(fileUtilService.imageCheck(ext));
					// 이미지 확장자 체크
					if(!fileUtilService.imageCheck(ext)) {
						log.info("이미지 파일이 아닙니다.");
						
					} else {
						String savePath = EgovProperties.getProperty("Push.SAVEDFILE");
						
						// tBLPRDT.setPrdtDtlImg(savePath + "/" + prdtNum + "." + ext);
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						Date ct = new Date();
						String mTime = sdf.format(ct);
						fileUtilService.uploadFile(file, "push" + mTime + "." + ext, savePath);
						log.info("file 존재");
						
						imgUrl = EgovProperties.getProperty("Globals.MobileWeb") + "/" + savePath + "/" + "push" + mTime + "." + ext;
					}
				}
			}
		}
		String url;
		if("on".equals(params.get("urlChk"))) {
			url = "";
		} else {
			url = EgovProperties.getProperty("Globals.MobileWeb") + "/mw/" + params.get("url");
		}
		log.info(url);
		for(int i = 0; i < deviceList.size(); i++) {
			DEVICEINFVO deviceInfo = deviceList.get(i);

			if("Y".equals(deviceInfo.getPushYn())) {
				if("I".equals(deviceInfo.getDeviceDiv())) {
					mwAppService.sendPushIOS(deviceInfo.getRegId(), params.get("trMsg"), url);
				} else {
					Result rst = mwAppService.sendPushAndroid(deviceInfo.getRegId(), params.get("trMsg"), url, imgUrl);
					
					log.info(rst.getMessageId());
					log.info("error :: " + rst.getErrorCodeName());
				}
			}
		}
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
    }
    
}
