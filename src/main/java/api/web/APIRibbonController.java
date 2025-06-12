package api.web;

import api.service.APIRibbonService;
import api.vo.APIRibbonVO;
import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CORPCONFVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class APIRibbonController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="apiRibbonService")
    private APIRibbonService apiRibbonService;

	/** 목록제공 */
	@RequestMapping(value="/api/ribbon.do")
	public void lsCompanyConsume(HttpServletResponse response) throws ParserConfigurationException, TransformerException, IOException {
		log.info("/api/ribbon.do");

		List<APIRibbonVO> resultList = apiRibbonService.selectListRibbonTamnaoCarType();
		/** XML 문서 파싱 */
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();

		/** Document 객체생성 */
		Document document = documentBuilder.newDocument();
		/** root 생성 */
		Element root = document.createElement("response");
		document.appendChild(root);

		for(APIRibbonVO tempVO : resultList){
			Element item = document.createElement("item");

			/** 차량코드 */
			Element code = document.createElement("code");
			code.setTextContent(tempVO.getCode());
			item.appendChild(code);

			/** 차량명 */
			Element name = document.createElement("name");
			name.setTextContent(tempVO.getName());
			item.appendChild(name);

			/** 연료타입 */
			Element fuel = document.createElement("fuel");
			fuel.setTextContent(tempVO.getFuel());
			item.appendChild(fuel);

			root.appendChild(item);
		}

		/** XML 문자열로 변환 */
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		DOMSource source = new DOMSource(document);
		StreamResult result = new StreamResult(out);
		TransformerFactory transFactory = TransformerFactory.newInstance();
		Transformer transformer = transFactory.newTransformer();
		transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		/** 들여 쓰기 */
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.transform(source, result);
		PrintWriter screenOut = response.getWriter();
		screenOut.println(new String(out.toByteArray(), StandardCharsets.UTF_8));
	}

	/** 등록차종*/
	@RequestMapping("/apiRib/carModelInfo.ajax")
	public ModelAndView ribCarModelInfo(@ModelAttribute("searchVO") RC_PRDTINFVO webParam){
		HashMap<String,Object> resultData = apiRibbonService.carModelInfo(webParam);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	/** 차량목록조회*/
	@RequestMapping("/apiRib/ribCarlist.ajax")
	public List<RC_PRDTINFVO> apiInsCarlist(@ModelAttribute("searchVO") RC_PRDTINFVO webParam){
		List<RC_PRDTINFVO> resultData = apiRibbonService.riblist(webParam);
		return resultData;
	}

	/** 차량목록조회*/
	@RequestMapping("/apiRib/ribDetail.ajax")
	public ModelAndView apiInsCarInfo(@ModelAttribute("searchVO") RC_PRDTINFVO webParam){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		RC_PRDTINFVO resultData = apiRibbonService.ribDetailInfo(webParam);
		resultMap.put("resultData", resultData);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
}

