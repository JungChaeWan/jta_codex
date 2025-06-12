package api.service;

import api.vo.*;
import com.jcraft.jsch.HASH;
import common.LowerHashMap;
import mas.prmt.vo.PRMTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import org.apache.commons.collections.map.HashedMap;
import oss.corp.vo.CORPVO;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface APIService {

	boolean apiReservation(String rsvNum);

	void apiCancellation(String rsvNum);

	int daehongPreventSaleNum(String telNum);

	DtlPrdtVO detailProductByCorp(CORPVO corpVO, HttpServletRequest request);
	
	DtlPrdtVO detailProductByVisitjeju(CORPVO corpVO, HttpServletRequest request);

	List<SPPRDTSVO> spProductList(ParamVO paramVO, HttpServletRequest request);

	List<RCSVO> rcList(HttpServletRequest request);
	/** 해당 업체에 판매중인 상품이 있는지 체크 */
	ERRORVO checkPrdtByCorp(CORPVO corpVO);
	/** 콕콕114 업체 리스트 */
	List<LowerHashMap> visitjejuList();
	/** 그림 API를 이용한 예약여부 확인 */
	Map<String, String> chkGrimRcAble(RC_PRDTINFVO prdtVO, RC_PRDTINFSVO prdtSVO);
	/** 그림 API를 이용한 예약 처리 */
	String insertGrimRcRsv(String rcRsvNum);
	/** 그림 API를 이용한 예약 취소 처리 */
	String cancelGrimRcRsv(String rcRsvNum);
	/** 넥스트이지 데이터제공 수집*/
	void insertNexezData(ApiNextezPrcAdd apiNextezPrcAdd);
	/** 넥스트이지 데이터제공 숙박 API*/
	List<LowerHashMap> selectlistAdNextez(ApiNextezSVO apiNextezSVO);
	/** 넥스트이지 데이터제공 숙박 API*/
	List<LowerHashMap> selectlistRcNextez(ApiNextezSVO apiNextezSVO);
	/** 넥스트이지 데이터제공 숙박 API*/
	List<LowerHashMap> selectlistSpNextez(ApiNextezSVO apiNextezSVO);
	List<LowerHashMap> hdcReqCnt();
	String corpCert(Map<String,Object> map);
	String selectCorpId(Map<String,Object> map);
	List<HashMap<String,Object>> selectMallRsvList(Map<String,Object> map);
	List<HashMap<String,Object>> selectMallRsvDetail(Map<String,Object> map);
	void updatePrdt(Map<String,Object> map);
	void updateDiv(Map<String,Object> map);
	void updateOpt(Map<String,Object> map);
	
	List<LowerHashMap> prmtAuthList(PRMTVO prmtVO);
}
