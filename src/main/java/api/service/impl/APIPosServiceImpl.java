package api.service.impl;

import java.util.List;

import javax.annotation.Resource;

import mas.rsv.service.impl.RsvDAO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import web.order.vo.RSVSVO;
import web.order.vo.SP_RSVVO;
import api.service.APIPosService;
import api.vo.POSVO;

@Service("apiPosService")
public class APIPosServiceImpl implements APIPosService {
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;
	
	@Resource(name = "apiDAO")
	private APIDAO apiDAO;
	
	@Override
	public List<POSVO> selectByRsvList(RSVSVO rsvSVO) {		
		return apiDAO.selectByRsvList(rsvSVO);
	}

	@Override
	public POSVO selectByRsvInfo(POSVO posVO) {		
		return apiDAO.selectByRsvInfo(posVO);
	}

	@Override
	public List<POSVO> selectByPrdtList(POSVO posVO) {		
		return apiDAO.selectByPrdtList(posVO);
	}

	@Override
	public SP_RSVVO selectSpRsv(SP_RSVVO spRsvVO) {		
		return rsvDAO.selectSpRsv(spRsvVO);
	}

	@Override
	public List<POSVO> selectByUsedPrdtList(POSVO posVO) {		
		return apiDAO.selectByUsedPrdtList(posVO);
	}

	@Override
	public POSVO selectByDayStat(POSVO posVO) {		
		return apiDAO.selectByDayStat(posVO);
	}

	@Override
	public void updateSpUseDttm(SP_RSVVO spRsvVO) {
		apiDAO.updateSpUseDttm(spRsvVO);
	}
	
	

}
