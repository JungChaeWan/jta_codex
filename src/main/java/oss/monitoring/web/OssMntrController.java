package oss.monitoring.web;

import api.service.APITLBookingService;
import api.vo.APITLBookingLogVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import oss.monitoring.service.OssMntrService;
import oss.monitoring.vo.TLCORPVO;
import web.order.vo.ORDERVO;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OssMntrController {
    @Autowired
    private OssMntrService ossMntrService;

    @Autowired
    private APITLBookingService apitlBookingService;

    /**
     * 설명 : TL린칸 예약 전송 후 Tamnao 취소(RS99) 인데 취소전송을 보내지 않은 리스트
     * 파일명 : tlCancelErrList
     * 작성일 : 2021-10-22 오후 2:35
     * 작성자 : chaewan.jung
     * @param : [model]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/tlCancelErrList.do")
    public String tlCancelErrList(ModelMap model){
        List<ORDERVO> resultList = ossMntrService.selectCancelErrList();

        model.addAttribute("resultList", resultList);
        return "/oss/monitoring/tlCancelErrList";
    }

    /**
     * 설명 : TL린칸 취소 전송
     * 파일명 : directRecvCompRsv
     * 작성일 : 2021-10-22 오후 2:48
     * 작성자 : chaewan.jung
     * @param : [request]
     * @return : org.springframework.web.servlet.ModelAndView
     * @throws Exception
     */
    @RequestMapping("/oss/tlBookingCancel.ajax")
    public ModelAndView directRecvCompRsv(HttpServletRequest request) throws Exception{
        String adRsvNum = request.getParameter("adRsvNum");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        APITLBookingLogVO bookingLogVO  = apitlBookingService.bookingCancel(adRsvNum);
        resultMap.put("cancelResult", bookingLogVO);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
    * 설명 : TL린칸 연동 업체 List
    * 파일명 : tlApiList
    * 작성일 : 2021-10-29 오전 10:25
    * 작성자 : chaewan.jung
    * @param : [model]
    * @return : java.lang.String
    * @throws Exception
    */
    @RequestMapping("/oss/tlCorpList.do")
    public String tlApiList(ModelMap model){
        List<TLCORPVO> resultList = ossMntrService.selectTlCorpList();
        model.addAttribute("resultList", resultList);
        return "/oss/monitoring/tlCorpList";
    }

    /**
    * 설명 : 어린이 Type Update
    * 파일명 : updateTlChildType
    * 작성일 : 2021-10-29 오후 4:39
    * 작성자 : chaewan.jung
    * @param : ageType='juniorAgeStdApicode, childAgeStdApicode', apiCode = 'A,B,C,D'
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping("/oss/updateTlChildType.ajax")
    public ModelAndView updateTlChildType(TLCORPVO tlCorpVO) throws Exception{
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ossMntrService.updateTlChildType(tlCorpVO);
        resultMap.put("Status", "success");
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
    * 설명 : TLL 금액 연동 기준 update
    * 파일명 : updateTlChildType
    * 작성일 : 2022-03-11 오후 2:33
    * 작성자 : chaewan.jung
    * @param : [tlCorpVO]
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping("/oss/updateTlPriceLink.ajax")
    public ModelAndView updateTlPriceLink(TLCORPVO tlCorpVO) throws Exception{
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ossMntrService.updateTlPriceLink(tlCorpVO);
        resultMap.put("Status", "success");
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 설명 : POINT 결제 된 후 TB_RSV와 TB_POINT가 다른경우
     * 파일명 : pointRsvErrList
     * 작성일 : 2023-04-26 오전 11:09
     * 작성자 : chaewan.jung
     * @param : [model]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/pointRsvErrList.do")
    public String pointRsvErrList(ModelMap model){
        List<ORDERVO> resultList = ossMntrService.selectPointRsvErrList();

        model.addAttribute("resultList", resultList);
        return "/oss/monitoring/pointRsvErrList";
    }
}
