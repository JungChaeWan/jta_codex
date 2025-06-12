package api.web;

import api.service.APIGoodsFlowService;
import api.vo.APIGoodsFlowSendTraceRequestVO;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class APIGoodsFlowController {
    @Resource(name="apiGoodsFlowService")
    private APIGoodsFlowService apiGoodsFlowService;

    @RequestMapping("/goodsFlow/sendTraceRequest.ajax")
    public ModelAndView sendTraceRequest(	@ModelAttribute("APIGoodsFlowSendTraceRequestVO") APIGoodsFlowSendTraceRequestVO apiGoodsFlowSendTraceRequestVO) throws ParseException {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String resultStr = apiGoodsFlowService.sendTraceRequest(apiGoodsFlowSendTraceRequestVO);
        if("Y".equals(resultStr)){
            resultMap.put("success",true);
        }else{
            resultMap.put("success",false);
        }
        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

    @RequestMapping("/goodsFlow/receiveTraceResult.ajax")
    public void receiveTraceResult(	@ModelAttribute("APIGoodsFlowSendTraceRequestVO") APIGoodsFlowSendTraceRequestVO apiGoodsFlowSendTraceRequestVO)  {
        apiGoodsFlowService.receiveTraceResult();
        }
}