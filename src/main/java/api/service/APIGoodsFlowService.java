package api.service;

import api.vo.APIGoodsFlowSendTraceRequestVO;
import org.json.simple.parser.ParseException;

import javax.jws.WebService;
import java.io.IOException;

@WebService
public interface APIGoodsFlowService {

    String sendTraceRequest(APIGoodsFlowSendTraceRequestVO requestVO) throws ParseException;

    void receiveTraceResult() ;

}
