package oss.sv.service;

import java.util.List;
import java.util.Map;

import oss.sp.vo.OSS_PRDTINFSVO;
import oss.sv.vo.OSS_SV_PRDTINFSVO;
import oss.sv.vo.OSS_SV_PRDTINFVO;

public interface OssSvService {

	Map<String, Object> selectOssSvPrdtInfList(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO);

	/**
	 * 통합운영 기념품 상품 엑셀 다운로드 용
	 * 파일명 : selectOssSvPrdtInfList2
	 * 작성일 : 2017. 1. 10. 오후 3:37:20
	 * 작성자 : 최영철
	 * @param oss_SV_PRDTINFSVO
	 * @return
	 */
	List<OSS_SV_PRDTINFVO> selectOssSvPrdtInfList2(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO);

	/**
	 * 상품 리스트 갯수
	 * @param searchVO
	 * @return
	 */
	int getCntOssSvPrdtInfList(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO);
}
