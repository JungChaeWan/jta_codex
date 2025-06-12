package web.product.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import web.product.service.WebPrdtInqService;
import web.product.vo.PRDTINQVO;

@Service("webPrdtInqService")
public class WebPrdtInqServiceImpl implements WebPrdtInqService {
	
	@Resource(name = "WebPrdtInqDAO")
	private WebPrdtInqDAO webPrdtInqDAO;
	
	@Override
	public void insertPrdtInq(PRDTINQVO prdtInqVO) {		
		PRDTINQVO infoVO = webPrdtInqDAO.selectPrdtInq(prdtInqVO);
		if (infoVO == null) {
			webPrdtInqDAO.insertPrdtInq(prdtInqVO);
		} else {
			if (prdtInqVO.getInqNum() == 1) {
				prdtInqVO.setInqNum(infoVO.getInqNum() + 1);
			} else {
				prdtInqVO.setSnsPublicNum(infoVO.getSnsPublicNum() + 1);
			}
			webPrdtInqDAO.updatePrdtInq(prdtInqVO);
		}
	}
}
