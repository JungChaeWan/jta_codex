package oss.rsv.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.rsv.service.impl.RsvDAO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import oss.rsv.service.OssRsvService;
import oss.rsv.vo.OSS_RSVEXCELVO;
import oss.user.service.impl.UserDAO;
import oss.user.vo.REFUNDACCINFVO;
import web.order.service.impl.WebOrderDAO;
import web.order.vo.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Row;
@Service("ossRsvService")
public class OssRsvServiceImpl extends EgovAbstractServiceImpl implements OssRsvService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;
	
	@Resource(name = "userDAO")
	private UserDAO userDAO;
	
	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;

	@Autowired
	private OssRsvDAO ossRsvDAO;
	
	/**
	 * 통합 예약 리스트 조회
	 * 파일명 : selectRsvList
	 * 작성일 : 2015. 12. 11. 오전 10:18:38
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectRsvList(RSVSVO rsvSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<RSVVO> resultList = rsvDAO.selectRsvList(rsvSVO);
		
		String sRsvNumList[] = new String[resultList.size()];
		
		for(int i=0;i<resultList.size();i++){
			sRsvNumList[i] = resultList.get(i).getRsvNum();
		}
		rsvSVO.setsRsvNumList(sRsvNumList);
		List<ORDERVO> orderList = new ArrayList<ORDERVO>();
		if(resultList.size() > 0){
			orderList = rsvDAO.selectDtlRsvList(rsvSVO);
		}
		
		Integer totalCnt = rsvDAO.getCntRsvList(rsvSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("orderList", orderList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 환불 요청건 리스트 조회
	 * 파일명 : selectRefundList
	 * 작성일 : 2016. 1. 17. 오후 1:37:14
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectRefundList(ORDERSVO orderSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<ORDERVO> orderList = rsvDAO.selectRefundList(orderSVO);
		Integer totalCnt = rsvDAO.getCntRefundList(orderSVO);
		
		resultMap.put("orderList", orderList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	/**
	 * 환불 요청건 단건 조회
	 * 파일명 : selectByPrdtRsvInfo
	 * 작성일 : 2016. 1. 22. 오후 3:14:49
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	@Override
	public ORDERVO selectByPrdtRsvInfo(ORDERSVO orderSVO){
		return rsvDAO.selectByPrdtRsvInfo(orderSVO);
	}
	
	/**
	 * 사용자 환불 계좌 정보 조회
	 * 파일명 : selectByRefundAccInf
	 * 작성일 : 2016. 1. 22. 오후 3:46:22
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	@Override
	public REFUNDACCINFVO selectByRefundAccInf(ORDERSVO orderSVO){
		return userDAO.selectByRefundAccInf(orderSVO);
	}
	
	/**
	 * 예약 환불정보 등록
	 * 파일명 : insertRefundInfo
	 * 작성일 : 2016. 1. 22. 오후 4:45:24
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	@Override
	public void updateRefundInfo(ORDERVO orderVO){
		rsvDAO.updateRefundInfo(orderVO);
	}

	/**
	 * 환불사유 등록
	 */
	@Override
	public void updateRefundRsn(ORDERVO orderVO){
		rsvDAO.updateRefundRsn(orderVO);
	}

	@Override
	public int getRsvOssMain(RSVVO rsvVO) {
		return rsvDAO.getRsvOssMain(rsvVO);
	}
	
	/**
	 * 환불정보 등록
	 * 파일명 : mergeAccNum
	 * 작성일 : 2016. 1. 28. 오전 11:05:53
	 * 작성자 : 최영철
	 * @param refundAccInfVO
	 */
	@Override
	public void mergeAccNum(REFUNDACCINFVO refundAccInfVO){
		rsvDAO.mergeAccNum(refundAccInfVO);
	}
	
	/**
	 * 상품별 예약 리스트 조회
	 * 파일명 : selectRsvAtPrdtList
	 * 작성일 : 2016. 3. 2. 오후 2:39:37
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectRsvAtPrdtList(RSVSVO rsvSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<ORDERVO> resultList = rsvDAO.selectRsvAtPrdtList(rsvSVO);
		Integer totalCnt = rsvDAO.getCntRsvAtPrdtList(rsvSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 상품별 예약 리스트 전체 조회
	 * 파일명 : selectRsvAtPrdtListAll
	 * 작성일 : 2016. 3. 2. 오후 3:38:30
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<ORDERVO> selectRsvAtPrdtListAll(RSVSVO rsvSVO){
		return rsvDAO.selectRsvAtPrdtListAll(rsvSVO);
	}
	
	/**
	 * 사용자 예약내역 조회
	 * 파일명 : selectUserRsvList
	 * 작성일 : 2016. 5. 27. 오전 9:52:56
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectUserRsvList(RSVVO rsvVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<RSVVO> resultList = webOrderDAO.selectRsvList(rsvVO);
		
		String sRsvNumList[] = new String[resultList.size()];
		
		for(int i=0; i < resultList.size(); i++) {
			sRsvNumList[i] = resultList.get(i).getRsvNum();
		}
		RSVSVO rsvSVO = new RSVSVO();
		rsvSVO.setsRsvNumList(sRsvNumList);

		List<ORDERVO> orderList = new ArrayList<ORDERVO>();

		if(resultList.size() > 0) {
			orderList = rsvDAO.selectDtlRsvList(rsvSVO);
		}
		
		resultMap.put("resultList", resultList);
		resultMap.put("orderList", orderList);
		
		return resultMap;
	}

	@Override
	public Map<String, Object> selectAvRsvList(AV_RSVSVO avRsvSVO) {		
		Map<String, Object> resultMap = new HashMap<String, Object>();
				
		List<AV_RSVVO> resultList = rsvDAO.selectAvRsvList(avRsvSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", rsvDAO.getCntAvRsvList(avRsvSVO));
		
		return resultMap;
	}
	
	/**
	 * 기념품 상품별 예약 조회
	 * 파일명 : selectRsvAtSvPrdtList
	 * 작성일 : 2016. 12. 26. 오후 5:23:43
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectRsvAtSvPrdtList(RSVSVO rsvSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<ORDERVO> resultList = rsvDAO.selectRsvAtSvPrdtList(rsvSVO);
		Integer totalCnt = rsvDAO.getCntRsvAtSvPrdtList(rsvSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 기념품 상품별 예약 조회 엑셀 다운로드용
	 * 파일명 : selectRsvAtSvPrdtListAll
	 * 작성일 : 2016. 12. 27. 오전 11:18:44
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<ORDERVO> selectRsvAtSvPrdtListAll(RSVSVO rsvSVO){
		return rsvDAO.selectRsvAtSvPrdtListAll(rsvSVO);
	}
	
	//대시보드 실시간 상품/특산기념품 취소요청
	@Override
	public Integer getCntRsvList(RSVSVO rsvSVO){
		return rsvDAO.getCntRsvList(rsvSVO);
	}

	/**
	* 설명 : 관리자 직접 예약 시 예약처리 후 금액 합계 처리
	* 파일명 : updateTotalAmt
	* 작성일 : 2021-06-21 오후 5:25
	* 작성자 : chaewan.jung
	* @param : [rsvVO]
	* @return : void
	* @throws Exception
	*/
	@Override
	public void updateTotalAmt(RSVVO rsvVO){
		rsvDAO.updateToTalAmt(rsvVO);
	}

	/**
	* 설명 : 관리자 직접 예약 시스템에서 [엑셀 상품 등록] Log(확인) Table에 저장
	* 파일명 : insertRsvRegExcelUp
	* 작성일 : 2021-11-11 오전 10:23
    * 수정일 : 2023-03-24 개편
	* 작성자 : chaewan.jung
	* @param : workbook 확장자 형식 , excelUpFile 엑셀업로드파일
	* @return :
	* @throws Exception
	*/
	public Integer insertRsvRegExcelUp(Workbook workbook, MultipartFile excelUpFile, String corpDiv) {

		// GROUP NUMBER GET
		Integer groupNo = ossRsvDAO.getRsvExcelUpGroupNo();

		//Excel DATA insert (in TB_EXCELUP_RSV table)
        Sheet worksheet = workbook.getSheetAt(0);
        for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {
            Row row = worksheet.getRow(i);

			// A열이 null이거나 값이 없으면 반복문 종료
			if (row == null || row.getCell(0) == null || row.getCell(0).getStringCellValue().trim().isEmpty()) {
				break;
			}

            OSS_RSVEXCELVO data = new OSS_RSVEXCELVO();
            data.setGroupNo(groupNo);
            data.setCorpDiv(corpDiv);
            data.setRsvNm(row.getCell(0).getStringCellValue()); //구매자명
            data.setRsvTelnum(row.getCell(1).getStringCellValue()); //구매자 연락처
            data.setUseNm(row.getCell(2).getStringCellValue()); //수취인명
            data.setUseTelnum(row.getCell(3).getStringCellValue()); //수취인연락처
			if (row.getCell(21) != null) {
				data.setPostNum(row.getCell(21).getStringCellValue()); //우편번호
				data.setRoadNmAddr(row.getCell(17).getStringCellValue());
				if (row.getCell(18) != null) {
					data.setDtlAddr(row.getCell(18).getStringCellValue());
				}
			}
			data.setBuyNum(Integer.toString((int) row.getCell(5).getNumericCellValue()));		//구매수량
			if (row.getCell(10) != null) {														//배송요청정보 *null 입력 허용
				data.setDlvRequestInf(row.getCell(10).getStringCellValue());
			}
			data.setDirectRecvYn("N"); //직접수령여부
			data.setsPrdtNm(row.getCell(4).getStringCellValue()); //네이버상품명
			if (row.getCell(14) != null) {
				data.setsOptNm(row.getCell(14).getStringCellValue()); //네이버옵션명
			}

			ossRsvDAO.insertRsvRegExcelUp(data);
        }

        return groupNo;
	}

	/**
	* 설명 : 관리자 직접 예약 시스템에서 [예약 리스트]
	* 파일명 :
	* 작성일 : 2021-11-11 오후 5:00
	* 작성자 : chaewan.jung
	* @param : 
	* @return :
	* @throws Exception
	*/
	public List<OSS_RSVEXCELVO> selectRsvRegExcel(OSS_RSVEXCELVO ossRsvExcelVO){
		return ossRsvDAO.selectRsvRegExcel(ossRsvExcelVO);
	}

	/**
	* 설명 : 엑셀업로드한 Data와 검증된 Data 비교를 위해 조회
	* 파일명 :
	* 작성일 : 2021-11-16 오전 9:37
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public Integer selectExcelUpRsvCnt(OSS_RSVEXCELVO ossRsvExcelVO){
		return ossRsvDAO.selectExcelUpRsvCnt(ossRsvExcelVO);
	}

	@Override
	public String getLastGroupNo(String corpDiv) {
		return ossRsvDAO.getLastGroupNo(corpDiv);
	}

	@Override
	public List<OSS_RSVEXCELVO> selectSprdtOptNm(OSS_RSVEXCELVO ossRsvExcelVO) {
		return ossRsvDAO.selectSprdtOptNm(ossRsvExcelVO);
	}

	@Override
	public void updateRsvMatch(OSS_RSVEXCELVO ossRsvExcelVO) {
		ossRsvDAO.updateRsvMatch(ossRsvExcelVO);
	}

	@Override
	public Integer getVerifyCnt(OSS_RSVEXCELVO ossRsvExcelVO) {
		return ossRsvDAO.getVerifyCnt(ossRsvExcelVO);
	}

	@Override
	public void updateRsvComplete(Integer seq) {
		ossRsvDAO.updateRsvComplete(seq);
	}

	@Override
	public void updateRsvInfo(RSVVO rsvVO) {
		ossRsvDAO.updateRsvInfo(rsvVO);
	}
}
