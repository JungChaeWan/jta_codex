package api.web;

import api.service.APITLBookingService;
import api.vo.APITLBookingLogVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Controller
public class APITLBookingController {
    @Autowired
    private APITLBookingService apitlBookingService;

    /**
    * 설명 : 예약 테스트 PAGE
    * 파일명 :
    * 작성일 : 2021-06-14 오후 1:23
    * 작성자 : chaewan.jung
    * @param : String rsvNum
    * @return : 예약 xml 전송
    * @throws Exception
    */
    @RequestMapping(value = "/api/tl/booking.do")
    public String booking() throws Exception {
        return "/web/tlLincoln/bookingTest";
    }

    /**
    * 설명 : 예약 전송
    * 파일명 : bookingSend
    * 작성일 : 2021-07-05 오후 5:59
    * 작성자 : chaewan.jung
    * @param : [req]
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping(value = "/api/tl/bookingSend.ajax", method = RequestMethod.POST)
    public ModelAndView bookingSend(HttpServletRequest req) throws Exception {
        return null;
//        Map<String, Object> resultMap = new HashMap<String, Object>();
//        String rsvNum = req.getParameter("rsvNum");
//
//        List<APITLBookingLogVO> bookingLogVO = apitlBookingService.bookingXml(rsvNum);
//        resultMap.put("bookingLogVO", bookingLogVO);
//        ModelAndView mav = new ModelAndView("jsonView", resultMap);
//        return mav;
    }

    /**
    * 설명 : 취소 전송
    * 파일명 : bookingCancel
    * 작성일 : 2021-07-05 오후 5:59
    * 작성자 : chaewan.jung
    * @param : [req]
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping(value = "/api/tl/bookingCancel.ajax", method = RequestMethod.POST)
    public ModelAndView bookingCancel(HttpServletRequest req)  {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String adRsvNum = req.getParameter("adRsvNum");

        APITLBookingLogVO bookingLogVO = apitlBookingService.bookingCancel(adRsvNum);
        resultMap.put("bookingLogVO", bookingLogVO);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

}
