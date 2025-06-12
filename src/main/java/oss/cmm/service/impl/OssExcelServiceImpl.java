package oss.cmm.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import mas.rsv.service.impl.RsvDAO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_OPTINFVO;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssExcelService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.sp.service.impl.SpDAO;
import web.order.vo.AV_RSVVO;

import common.Constant;

import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;

@Service("ossExcelService")
public class OssExcelServiceImpl implements OssExcelService {

	private static final Logger log = LoggerFactory.getLogger(OssExcelServiceImpl.class);

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name= "spDAO")
	private SpDAO spDAO;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name="ossCmmService")
	protected OssCmmService ossCmmService;

	/**
	 * 항공 예약의 Excel 파일 업로드
	 * Function : OssRsvServiceImpl.java
	 * 작성일 : 2016. 8. 30. 오전 11:23:21
	 * 작성자 : 정동수
	 * @throws Exception
	 */
	@Override
	public void uploadAvRsvExcel(AV_RSVVO avRsvVO,
			MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("oss.cmm.service.impl.uploadAvRsvExcel 호출");

		String uploadPath = EgovProperties.getProperty("SP.OPTION.SAVEDFILE");

		MultipartFile excelFile = multiRequest.getFile("rsvAvExel");
		if(!excelFile.isEmpty()) {
			String ext =  FilenameUtils.getExtension(excelFile.getOriginalFilename());
			String newFileName = "AvRsvEXCEL." +  ext;
			ossFileUtilService.uploadFile(excelFile, newFileName, uploadPath);

			// 항공사 노선 리스트
			Map<String, String> airLineMap = new HashMap<String, String>();
			List<CDVO> airLineArr = ossCmmService.selectCode("AVLN");
			for (CDVO cd : airLineArr) {
				airLineMap.put(cd.getCdNm(), cd.getCdNum());
			}

			// 항공사 리스트
			Map<String, String> airCorpMap = new HashMap<String, String>();
			List<CDVO> airCorpArr = ossCmmService.selectCode("AVCP");
			for (CDVO cd : airCorpArr) {
				airCorpMap.put(cd.getCdNm(), cd.getCdNum());
			}

			// 예약현황
			Map<String, String> statusMap = new HashMap<String, String>();
			statusMap.put("예약", Constant.RSV_STATUS_CD_READY);
			statusMap.put("결제완료", Constant.RSV_STATUS_CD_COM);
			statusMap.put("예약취소", Constant.RSV_STATUS_CD_CCOM);

	        File file = null;
	        try {
	            file = new File(EgovProperties.getProperty("HOST.WEBROOT") + uploadPath +File.separator +  newFileName);

	            @SuppressWarnings("resource")
				XSSFWorkbook workbook = new XSSFWorkbook(OPCPackage.openOrCreate(file));

				XSSFSheet workSheet = workbook.getSheetAt(0);	// 첫번째 sheet

				int rowSize = workSheet.getLastRowNum();	// 행의 총 개수 (마직막 행 제외)
				for (int i=1; i<rowSize; i++) {	// 타이틀을 제외한 2행 부터
					Row row = workSheet.getRow(i);
					int cellLength = (int) row.getLastCellNum();	// 열의 총 개수

					// excel 컬럼 수 체크
					if (cellLength != 22)
						break;

					avRsvVO = new AV_RSVVO();
					String saleCorp = "jlair".equals(row.getCell(21).getStringCellValue()) ? Constant.AIR_SALE_CORP_JL : Constant.AIR_SALE_CORP_DC;
					avRsvVO.setSaleCorpDiv(saleCorp);
					for (int j=0; j<cellLength; j++) {
						org.apache.poi.ss.usermodel.Cell cell = row.getCell(j);
						switch (j) {
							case 0:		// 예약 번호
								avRsvVO.setRsvNum(cell.getStringCellValue());
								break;
							case 1:		// 예약자명
								avRsvVO.setRsvNm(cell.getStringCellValue());
								break;
							case 2:		// 예약일
								avRsvVO.setRsvDttm(cell.getDateCellValue());
								break;
							case 6:		// 항공사
								avRsvVO.setAvCorpDiv(airCorpMap.get(cell.getStringCellValue()));
								break;
							case 7:		// 노선
								String[] lineArr = cell.getStringCellValue().split("->");
								avRsvVO.setStartCourseDiv(airLineMap.get(lineArr[0]));
								avRsvVO.setEndCourseDiv(airLineMap.get(lineArr[1]));
								break;
							case 8:		// 이용일시
								avRsvVO.setUseDttm(cell.getDateCellValue());
								break;
							case 12:	// 인원수
								avRsvVO.setMem(cell.getNumericCellValue() + "");
								break;
							case 13:	// 이용금액
								avRsvVO.setSaleAmt(cell.getNumericCellValue() + "");
								break;
							case 18:	// 처리상태
								avRsvVO.setRsvStatusCd(statusMap.get(cell.getStringCellValue()));
								break;
						}
					}
					rsvDAO.insertAvRsvExcel(avRsvVO);
				}
	        } catch (Exception e ){
	        	e.printStackTrace();
	        } finally {
	            if ( file != null && file.exists()){
	                file.delete();
	            }
	        }
		}

		/*Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());

				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);

					if (ext.equals("xlsx")) {
						workbook = new XSSFWorkbook(file.getInputStream());

						XSSFSheet workSheet = workbook.getSheetAt(0);	// 첫번째 sheet

						int rowSize = workSheet.getLastRowNum() + 1;	// 행의 총 개수
						for (int i=1; i<rowSize; i++) {	// 타이틀을 제외한 2행 부터
							Row row = workSheet.getRow(i);
							int cellLength = (int) row.getLastCellNum();	// 열의 총 개수

							// excel 컬럼 수 체크
							if (cellLength != 22)
								break;

							avRsvVO = new AV_RSVVO();
							for (int j=0; j<cellLength; j++) {
								Cell cell = (Cell) row.getCell(j);
								switch (j) {
									case 0:		// 예약 번호
										avRsvVO.setRsvnum(cell.getContents());
										break;
									case 1:		// 예약자명
										avRsvVO.setRsvNm(cell.getContents());
										break;
									case 2:		// 예약일
										avRsvVO.setRsvday(cell.getContents());
										break;
									case 6:		// 항공사
										avRsvVO.setAvCorpDiv(cell.getContents());
										break;
									case 7:		// 노선
										String[] lineArr = cell.getContents().split("->");
										avRsvVO.setStartCourseDiv(lineArr[0]);
										avRsvVO.setEndCourseDiv(lineArr[1]);
										break;
									case 8:		// 이용일
										avRsvVO.setUseDttm(cell.getContents());
										break;
									case 12:	// 인원수
										avRsvVO.setMem(cell.getContents());
										break;
									case 13:	// 이용금액
										avRsvVO.setSaleAmt(cell.getContents());
										break;
									case 18:	// 처리상태
										avRsvVO.setRsvStatusCd(cell.getContents());
										break;
								}
							}
							webOrderDAO.insertAvRsvExcel(avRsvVO);
						}
					}
				}
			}
		}	*/
	}

	private boolean validateSpOption(SP_OPTINFVO spOptionInfo ) {
		boolean result = true;

		if(!EgovStringUtil.checkDate(spOptionInfo.getAplDt())) {
			result = false;
		}
		if(StringUtils.isEmpty(spOptionInfo.getPrdtDivNm())) {
			result = false;
		}

		return result;
	}

}
