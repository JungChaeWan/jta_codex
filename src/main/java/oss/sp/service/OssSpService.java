package oss.sp.service;

import java.util.Map;

import oss.sp.vo.OSS_PRDTINFSVO;

public interface OssSpService {
	
	/**
	 * 협회 관리자 상품승인 상품리스트.
	 * @param sp_PRDTINFSVO
	 * @return
	 */
	Map<String, Object> selectOssSpPrdtInfList(OSS_PRDTINFSVO oss_PRDTINFSVO);
	
	/**
	 * 협회 관리자 상품승인 상품리스트2
	 * @param sp_PRDTINFSVO
	 * @Notice 여행사상품(sCtgr : C100) 인 경우 여행사단품(sCtgr : C400 - 숙박, 렌터카)을 포함해서 출력 
	 * @return
	 */
	Map<String, Object> selectOssSpPrdtInfList2(OSS_PRDTINFSVO oss_PRDTINFSVO);

	/**
	 * 상품 리스트 갯수
	 * @param searchVO
	 * @return
	 */
	int getCntOssSpPrdtInfList(OSS_PRDTINFSVO searchVO);
}
	
