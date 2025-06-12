package web.product.web;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import egovframework.cmmn.service.EgovClntInfo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.ad.vo.AD_WEBLIST2VO;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.marketing.serive.OssBestprdtService;
import oss.marketing.serive.OssKwaService;
import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;
import oss.marketing.vo.KWASVO;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_AVVO;


/**
 * 웹 실시간항공 컨트롤러 클레스
 * 파일명 : WebAvProductController.java
 * 작성일 : 2015. 11. 11. 오전 10:27:25
 * 작성자 : 신우섭
 */
@Controller
public class WebAvProductController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;    
    
    @Resource(name = "webSpService")
	protected WebSpProductService webSpService;
    
    @Resource(name = "webRcProductService")
    protected WebRcProductService webRcProductService;
    
    @Resource(name = "webAdProductService")
    protected WebAdProductService webAdProductService;
    
    @Resource(name="ossKwaService")
	private OssKwaService ossKwaService;
    
    @Resource(name="ossBestprdtService")
	private OssBestprdtService ossBestprdtService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
        
    @RequestMapping("/web/av/mainList.do")
    public String mainList(@ModelAttribute("searchVO") WEB_AVVO webAvVO,
    		   					ModelMap model, HttpServletRequest request){
    	
    	log.info("/web/av/mainList.do Call");

    	try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/av/mainList.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	if(webAvVO.getStart_date() == null){
    		//초기 날짜 지정
    		Calendar calNow = Calendar.getInstance();
    		
    		webAvVO.setStart_date( String.format("%d-%02d-%02d",
									calNow.get(Calendar.YEAR),
									calNow.get(Calendar.MONTH) + 1, 
									calNow.get(Calendar.DAY_OF_MONTH)  ) 
    								);
    		
    		calNow.add(Calendar.DAY_OF_MONTH, 3);
    		webAvVO.setEnd_date( String.format("%d-%02d-%02d",
									calNow.get(Calendar.YEAR),
									calNow.get(Calendar.MONTH) + 1, 
									calNow.get(Calendar.DAY_OF_MONTH)  ) 
									);
    	}
    	
    	model.addAttribute("searchVO", webAvVO);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
    	
    	return "/web/av/mainList";
    }
    
    @RequestMapping("/web/av/productList.do")
    public String avlList(@ModelAttribute("searchVO") WEB_AVVO webAvVO,
    		   					ModelMap model, HttpServletRequest request){
    	
    	log.info("/web/av/productList.do>>"
    			+ "[trip_type:"+webAvVO.getTrip_type()+"]"
    			+ "[seat_type:"+webAvVO.getSeat_type()+"]"
    			+ "[airline_code:"+webAvVO.getAirline_code()+"]"
    			+ "[start_region:"+webAvVO.getStart_region()+"]"
    			+ "[start_date:"+webAvVO.getStart_date()+"]"
    			+ "[end_region:"+webAvVO.getEnd_region()+"]"
    			+ "[end_date:"+webAvVO.getEnd_date()+"]"
    			+ "[adult_cnt:"+webAvVO.getAdult_cnt()+"]"
    			+ "[child_cnt:"+webAvVO.getChild_cnt()+"]"
    			+ "[baby_cnt:"+webAvVO.getBaby_cnt()+"]"    			
    			+ "[cearchVal:"+webAvVO.getCearchVal()+"]"
    			);
    	
    	if(webAvVO.getStart_date() == null){

    		try {
    			if(EgovClntInfo.isMobile(request)) {
    				return "forward:/mw/av/mainList.do";
    			} else {
    				return "forward:/web/av/mainList.do";
    			}
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    		/*
    		//초기 날짜 지정
    		Calendar calNow = Calendar.getInstance();
    		
    		webAvVO.setStart_date( String.format("%d-%02d-%02d",
									calNow.get(Calendar.YEAR),
									calNow.get(Calendar.MONTH) + 1, 
									calNow.get(Calendar.DAY_OF_MONTH)  ) 
    								);
    		
    		webAvVO.setEnd_date( String.format("%d-%02d-%02d",
									calNow.get(Calendar.YEAR),
									calNow.get(Calendar.MONTH) + 1, 
									calNow.get(Calendar.DAY_OF_MONTH)  ) 
									);
			*/
    	}
    	/*
    	if(webAvVO.getStart_region() == null || webAvVO.getStart_region() == "") {
    		webAvVO.setStart_region("GMP");
    	}
    	if(webAvVO.getEnd_region() == null || webAvVO.getEnd_region() == "") {
    		webAvVO.setEnd_region("CJU");
    	}
    	*/
    	model.addAttribute("searchVO", webAvVO);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

    	return "/web/av/productList";
    }
    
    //임시 - 항공
    @RequestMapping("/web/evnt/productList.do")
    public String evntlList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
    		   					ModelMap model){
    
    	return "/web/evnt/productList";
    }
}