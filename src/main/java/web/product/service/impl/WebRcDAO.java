package web.product.service.impl;

import mas.rc.vo.RC_PRDTINFVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("webRcDAO")
public class WebRcDAO extends EgovAbstractDAO {

	public RC_PRDTINFVO selectByPrdt(RC_PRDTINFVO prdtVO) {
		return (RC_PRDTINFVO) select("RC_PRDTINF_S_06", prdtVO);
	}

}
