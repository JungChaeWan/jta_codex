package oss.marketing.serive.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.impl.MasAdPrdtServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.marketing.serive.OssKwaService;
import oss.marketing.serive.OssUserCateService;
import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;
import oss.marketing.vo.USERCATEVO;
import oss.user.service.impl.UserDAO;
import oss.user.vo.USERVO;

@Service("ossUserCateService")
public class OssUserCateServiceImpl implements OssUserCateService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasAdPrdtServiceImpl.class);

	@Resource(name = "userDAO")
	private UserDAO userDAO;

	@Override
	public List<USERVO> selectUserCate(USERCATEVO userCateVO) {
		List<USERVO> retList = new ArrayList<USERVO>();

		String strCate = userCateVO.getsCate();

		//상품 품목 조건 조합
		if(strCate != null){
			if(strCate.indexOf("AD") > -1){
				userCateVO.setsCateAD("Y");
			}else{
				userCateVO.setsCateAD("N");
			}

			if(strCate.indexOf("RC") > -1){
				userCateVO.setsCateRC("Y");
			}else{
				userCateVO.setsCateRC("N");
			}

			if(strCate.indexOf("SPC200") > -1){
				userCateVO.setsCateSPC200("Y");
			}else{
				userCateVO.setsCateSPC200("N");
			}
			if(strCate.indexOf("SPC300") > -1){
				userCateVO.setsCateSPC300("Y");
			}else{
				userCateVO.setsCateSPC300("N");
			}
			if(strCate.indexOf("SPC130") > -1){
				userCateVO.setsCateSPC130("Y");
			}else{
				userCateVO.setsCateSPC130("N");
			}
			if(strCate.indexOf("SPC170") > -1){
				userCateVO.setsCateSPC170("Y");
			}else{
				userCateVO.setsCateSPC170("N");
			}
			if(strCate.indexOf("SPC160") > -1){
				userCateVO.setsCateSPC160("Y");
			}else{
				userCateVO.setsCateSPC160("N");
			}

			if(strCate.indexOf("SV") > -1){
				userCateVO.setsCateSV("Y");
			}else{
				userCateVO.setsCateSV("N");
			}
		}


		//사용자 테이블 검색
		retList = userDAO.selectUserCateList(userCateVO);

		//재구매주기 얻기 위함
		if( !(userCateVO.getsReBuy() ==null || userCateVO.getsReBuy().isEmpty() || "".equals(userCateVO.getsReBuy())) ){

			List<USERVO> retListTemp = new ArrayList<USERVO>();

			for (USERVO data : retList) {
				USERCATEVO userCateTVO = new USERCATEVO();

				userCateTVO.setsUserId(data.getUserId());
				userCateTVO.setsReBuy(userCateVO.getsReBuy());
				userCateTVO.setsProcStdS(userCateVO.getsProcStdS());
				userCateTVO.setsProcStdE(userCateVO.getsProcStdE());

				int nCnt = userDAO.selectUserCateReBuyCnt(userCateTVO);

				//LOGGER.debug("-----" + data.getUserId() + " : " +  nCnt);

				if(nCnt>0){
					//0이상 이면 넣기
					retListTemp.add(data);
				}
			}

			retList = retListTemp;//최종꺼 바꾸기
		}

		return retList;
	}





}
