package mw.product.web;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import web.product.service.WebSpProductService;
import web.product.vo.WEB_AVVO;
import web.product.vo.WEB_SPPRDTVO;


/**
 * 실시간 항공 컨트롤러 클레스
 * 파일명 : MwAvProductController.java
 * 작성일 : 2015. 11. 11. 오전 10:27:25
 * 작성자 : 신우섭
 * NOTE : 2017-10-26 페이지 분리 처리 (By 정동수)
 */
@Controller
public class MwAvProductController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;    
    
    @Resource(name = "webSpService")
	protected WebSpProductService webSpService;
        
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    @RequestMapping("/mw/av/mainList.do")
    public String mainList(@ModelAttribute("searchVO") WEB_AVVO webAvVO,
    		   					ModelMap model){
    	
    	log.info("/mw/av/mainList.do Call");
    	
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
    	
    	/*model.addAttribute("searchVO", webAvVO);*/
    	
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
    	
    	return "/mw/av/mainList";
    }
    
    // 항공 목록 (변경 이전)
    @RequestMapping("/mw/av/productList.do")
    public String avlList(@ModelAttribute("searchVO") WEB_AVVO webAvVO,
    		   					ModelMap model){
    	
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
    		
    		return "redirect:/mw/av/mainList.do";
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
    	
    	/*
    	List<WEB_SPPRDTVO> bestList = webSpService.selectBestProductList("C110", "2");
    	model.addAttribute("bestList", bestList);
    	*/
    	
    	return "/mw/av/productList";
    }
}
