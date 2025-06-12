package mas.main.web;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dext5.DEXT5Handler;

import Raonwiz.Dext5.UploadCompleteEventClass;
import Raonwiz.Dext5.UploadHandler;
import egovframework.cmmn.service.EgovProperties;

@Controller
public class DextUploadHandlerController{
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@RequestMapping(value="/mas/dext/uploadHandler.dext")
	public @ResponseBody String uploadHandler(HttpServletResponse response, HttpServletRequest request) throws IOException{
		
		UploadHandler upload = new UploadHandler();
		UploadCompleteEventClass event = new UploadCompleteEventClass();
		
		upload.SetDebugMode(true);
		
		 response.setHeader("Content-Type", "text/html; charset=utf-8");
		 response.setContentType("text/html; charset=utf-8");
	    /*
		event.addUploadBeforeInitializeEventListenerEx(new Raonwiz.Dext5.UploadBeforeInitializeEventListenerEx() {
			public void UploadBeforeInitializeEventEx(Raonwiz.Dext5.Process.Entity.UploadEventEntity parameterEntity) {
				// 파일 저장전 발생하는 이벤트 입니다.
				// 파일에 대한 저장 경로를 변경해야 하는 경우 사용합니다.
				// 아직 클라이언트 측으로 출력을 내보내기 전이므로, 이곳에서 Response값을 변경하시면 클라이언트로 적용된 값이 전달됩니다.
				log.info("addUploadBeforeInitializeEventListenerEx call");
				HttpServletRequest request = parameterEntity.getRequest(); //Request Value
				HttpServletResponse response = parameterEntity.getResponse(); //Response Value
				String newFileLocation = parameterEntity.getNewFileLocation(); //NewFileLocation Value
				String responseFileName = parameterEntity.getResponseFileName(); //ResponseFileName Value
				
				log.info("newFileLocation2 : " + newFileLocation);
				
				parameterEntity.setNewFileLocation(newFileLocation); //Change NewFileLocation Value
				parameterEntity.setResponseFileName(responseFileName); //Change ResponseFileName Value
			}
	    });
		
		event.addUploadCompleteBeforeEventListenerEx(new Raonwiz.Dext5.UploadCompleteBeforeEventListenerEx() {
			public void UploadCompleteBeforeEventEx(Raonwiz.Dext5.Process.Entity.UploadEventEntity parameterEntity) {
				log.info("addUploadCompleteBeforeEventListenerEx call");
				// 파일 업로드 완료전 발생하는 이벤트 입니다.
				// 업로드된 파일의 DRM을 해제와 같은 파일처리 작업이 필요할 경우 사용합니다.
				// 아직 클라이언트 측으로 출력을 내보내기 전이므로, 이곳에서 Response값을 변경하시면 클라이언트로 적용된 값이 전달됩니다.
		
				HttpServletRequest request = parameterEntity.getRequest(); //Request Value
				HttpServletResponse response = parameterEntity.getResponse(); //Response Value
				String newFileLocation = parameterEntity.getNewFileLocation(); //NewFileLocation Value
				String responseFileServerPath = parameterEntity.getResponseFileServerPath(); //ResponseFileServerPath Value
				String responseFileName = parameterEntity.getResponseFileName(); //ResponseFileName Value
				String responseGroupId = parameterEntity.getResponseGroupId(); //GroupId Value
				String fileIndex = parameterEntity.getFileIndex(); //FileIndex Value - 마지막 파일은 index 앞에 z가 붙습니다.
				
				parameterEntity.setNewFileLocation(newFileLocation); //Change NewFileLocation Value
				parameterEntity.setResponseFileServerPath(responseFileServerPath); //Change ResponseFileServerPath Value
				parameterEntity.setResponseFileName(responseFileName); //Change ResponseFileName Value
				//parameterEntity.setResponseCustomValue("ResponseCustomValue"); //Set ResponseCustomValue (특수기호(:,::,*,|,^)가 포함되면 ResponseCustomValue가 설정되지 않습니다.)
				//parameterEntity.setResponseGroupId(GroupId); //Change GroupId Value (특수기호(:,::,*,|,^)가 포함되면 ResponseCustomValue가 설정되지 않습니다.)
				//parameterEntity.setCustomError("사용자오류");
				//parameterEntity.setCustomError("999", "사용자오류"); //Error Code를 설정하실 때에는 900이상의 3자리로 설정
			}
	    });
		*/
		/*
	    event.addUploadCompleteEventListenerEx(new Raonwiz.Dext5.UploadCompleteEventListenerEx() {
			public void UploadCompleteEventEx(Raonwiz.Dext5.Process.Entity.UploadEventEntity parameterEntity) {
				// 파일 업로드 완료후 발생하는 이벤트 입니다.
				log.info("addUploadCompleteEventListenerEx call");
				HttpServletRequest _request = parameterEntity.getRequest(); //Request Value
				HttpServletResponse _response = parameterEntity.getResponse(); //Response Value
				String _newFileLocation = parameterEntity.getNewFileLocation(); //NewFileLocation Value
		        String _responseFileServerPath = parameterEntity.getResponseFileServerPath(); //ResponseFileServerPath Value
		        String _responseFileName = parameterEntity.getResponseFileName(); //ResponseFileName Value
		        String sPathChar = java.io.File.separator;
		        // 이미지 처리 관련 API
		        Raonwiz.Dext5.Common.Dext5Image dextImage = new Raonwiz.Dext5.Common.Dext5Image();
		        try {
	               // String tempFilePath = "";                
	               // String sourceFileFullPath = _newFileLocation;
	                
	               // log.info(" thumbnail   sourceFileFullPath :: " + sourceFileFullPath);
	                // 동일 폴더에 이미지 썸네일 생성하기
	               	//tempFilePath = dextImage.MakeThumbnail(sourceFileFullPath, "_thumb", 490, 326, false);

	                // 특정위치에 이미지 썸네일 생성하기
	                //String targetFileFullPath = sourceFileFullPath.substring(0,sourceFileFullPath.lastIndexOf("/")) + sPathChar + "thumb" + sourceFileFullPath.substring(sourceFileFullPath.lastIndexOf("/"));
	               // log.info(" thumbnail   targetFileFullPath :: " + targetFileFullPath);
	                //tempFilePath = dextImage.MakeThumbnailEX(sourceFileFullPath, targetFileFullPath, 490, 326, false);

	                // 이미지 포멧 변경
	                //tempFilePath = dextImage.ConvertImageFormat(sourceFileFullPath, "", "png", false, false);

	                // 이미지 크기 변환
	                //dextImage.ConvertImageSize(sourceFileFullPath, 500, 30);

	                // 비율로 이미지 크기 변환
	                //dextImage.ConvertImageSizeByPercent(sourceFileFullPath, 50);

	                // 이미지 회전
	                //dextImage.Rotate(sourceFileFullPath, 90);

	                // 이미지 워터마크
	                //String waterMarkFilePath = "c:\\temp\\dext5_logo.png";
	                //dextImage.SetImageWaterMark(sourceFileFullPath, waterMarkFilePath, "TOP", 10, "RIGHT", 10, 0);

	                // 텍스트 워터마크
	                //Raonwiz.Dext5.Common.Entity.TextWaterMark txtWaterMark = new Raonwiz.Dext5.Common.Entity.TextWaterMark("DEXT5 Upload", "굴림", 12, "#FF00FF");                
	                //dextImage.SetTextWaterMark(sourceFileFullPath, txtWaterMark, "TOP", 10, "CENTER", 10, 0, 0);

	                // 이미지 크기
	                //java.awt.Dimension size = dextImage.GetImageSize(sourceFileFullPath);
	                //int _width = size.width;
	                //int _height = size.height;
					
					// EXIF 추출 (Exif standard 2.2, JEITA CP-2451)
	         		// jdk 1.6 이상에서만 사용가능합니다.
					// 기능 활성화를 원하시면 1.6버전으로 컴파일된 jar를 고객센터로 요청하십시오.
					//Raonwiz.Dext5.Common.Dext5ImageExif dextImageExif = new Raonwiz.Dext5.Common.Dext5ImageExif();
	                //Raonwiz.Dext5.Common.Exif.ExifEntity exifData = dextImageExif.GetExifData(sourceFileFullPath);

	            } catch (Exception ex) {
	                String errorMsg = ex.getMessage();
	            }
			}
	    });
	    */
		// 다운로드 전 이벤트
		/*
		event.addOpenDownloadBeforeInitializeEventListenerEx(new Raonwiz.Dext5.OpenDownloadBeforeInitializeEventListenerEx() {
			public void OpenDownloadBeforeInitializeEventEx(Raonwiz.Dext5.Process.Entity.UploadEventEntity parameterEntity) {
				// 파일 열기 및 다운로드시 발생하는 이벤트 입니다.
				HttpServletRequest request = parameterEntity.getRequest(); //Request Value
				HttpServletResponse response = parameterEntity.getResponse(); //Response Value
				String[] downloadFilePath = parameterEntity.getDownloadFilePath(); //DownloadFilePath Value
				String[] downloadFileName = parameterEntity.getDownloadFileName(); //DownloadFileName Value
				String[] downloadCustomValue = parameterEntity.getDownloadCustomValue(); //DownloadCustomValue
				
				parameterEntity.setDownloadFilePath(downloadFilePath); //Change DownloadFilePath Value
				parameterEntity.setDownloadFileName(downloadFileName); //Change DownloadFileName Value
				//parameterEntity.setUseDownloadServerFileName(true); //DownloadFileName 변경했을 경우 설정해야 합니다.
			}
	    });
		*/

		// 다운로드 완료후 이벤트
		/*
		event.addOpenDownloadCompleteEventListenerEx(new Raonwiz.Dext5.OpenDownloadCompleteEventListenerEx() {
			public void OpenDownloadCompleteEventEx(Raonwiz.Dext5.Process.Entity.UploadEventEntity parameterEntity) {
				// 파일 업로드 열기 및 다운로드시 발생하는 이벤트 입니다.
				
				HttpServletRequest request = parameterEntity.getRequest(); //Request Value
				HttpServletResponse response = parameterEntity.getResponse(); //Response Value
				String[] downloadFilePath = parameterEntity.getDownloadFilePath(); //DownloadFilePath Value
				String[] downloadFileName = parameterEntity.getDownloadFileName(); //DownloadFileName Value
				String[] downloadCustomValue = parameterEntity.getDownloadCustomValue(); //DownloadCustomValue
			}
	    });
		*/

	    String sPathChar = java.io.File.separator;
	    String PATH_SRV = EgovProperties.getProperty("HOST.WEBROOT") + sPathChar + "data"+ sPathChar + "dext";
	    log.info("PATH_SRV :: " + PATH_SRV );
		// 임시파일 물리적 경로설정
	    String tmpPath = PATH_SRV + sPathChar + "tmp";
		
		File cFile = new File(tmpPath);
	    log.info("tmpPath::" + tmpPath);
	    
	    upload.SetTempPath(tmpPath);
		// 실제 업로드 할 기본경로 설정 (가상경로와 물리적 경로로 설정 가능)
	    // 폴더명 제일 뒤에 .과 공백이 있다면 제거하시고 설정해 주세요.(운영체제에서 지원되지 않는 문자열입니다.)
	    // 해당 설정은 DEXT5 Upload 제품폴더\dext5uploaddata\ 를 저장 Root 경로로 설정하는 내용입니다.
	   //String saveRootFolder = request.getServletPath();
		
		
	  //  saveRootFolder = saveRootFolder.substring(0,saveRootFolder.lastIndexOf("/"));
	   // saveRootFolder = request.getSession().getServletContext().getRealPath(saveRootFolder.substring(0,saveRootFolder.lastIndexOf("/")));
	    
	    upload.SetPhysicalPath(PATH_SRV);
	    
	    // upload.SetVirtualPath("/dext5uploaddata");
	    

		// 환경설정파일 물리적 폴더 (서버 환경변수를 사용할 경우)
	    // upload.SetConfigPhysicalPath(tmpPath);
		// 서버 구성정보중 Context Path가 있다며, 아래와 같이 설정해주세요. (SetVirtualPath 사용시만 필요)
		// upload.SetContextPath("Context Path");
	    
	    // upload.SetZipFileName("download.zip");

		// DEXT5 Upload는 업로드시 클라이언트와 서버에서 보안을 위하여 이중으로 확장자 체크를 합니다.
	    // 서버 확장자 체크는 클라이언트에서 적용한 값으로 기본 설정되며, 
	    // 아래 부분을 적용하시면, 설정한 값으로 서버에서 확장자 체크가 이루어집니다.
	    // 1번째 인자는 0: 제한으로 설정, 1: 허용으로 설정, 두번째 인자는 확장자 목록 : jpg,exe (구분자,)
	    // upload.SetUploadCheckFileExtension(0, "exe,aspx,jsp");

	    // DEXT5 Upload는 업로드시 서버에서 파일명에대한 제어를 위한 설정 기능을 제공합니다.
	    // String[] tempWordList  = {"hacking"};
	    // upload.SetFileBlackWordList(tempWordList);
		
	    // DEXT5 Upload는 다운로드시 서버에서 보안을 위하여 확장자 체크를 합니다. (부모 경로 접근을 이용한 서버파일 다운로드 방지 등)
	    // 아래 부분을 적용하시면, 설정한 값으로 서버에서 확장자 체크가 이루어집니다.
	    // 1번째 인자는 0: 제한으로 설정, 1: 허용으로 설정, 두번째 인자는 확장자 목록 : jpg,exe (구분자,)
	    // upload.SetDownloadCheckFileExtension(0, "exe,aspx,jsp"); 
		
		// 불필요한 파일을 삭제 처리하는 설정 (단위: 일)
	    upload.SetGarbageCleanDay(2);
		
		// 업로드시 Multipart File을 서버에 바로 업로드할 수 있는 설정입니다.
		// upload.SetMultipartDirectUpload(true);

		 
		String result = "";
		try {
			log.info("result try   :: " + event.toString());
			
			result = upload.Process(request, response, event);
			log.info("result try   :: " + result);
			return result;
		} catch (Exception e) {
			return e.getMessage();
		}
		/*
		ServletOutputStream out = response.getOutputStream();
	    out.print(result);
	    out.close(); */
	}
	
	@RequestMapping(value="/mas/dext/ImageUploadHandler.dext")
	public @ResponseBody String ImageUploadHandler(HttpServletResponse response, HttpServletRequest request) throws IOException{
		String _allowFileExt = "gif, jpg, jpeg, png, bmp, wmv, asf, swf, avi, mpg, mpeg, mp4, txt, doc, docx, xls, xlsx, ppt, pptx, hwp, zip, pdf,flv";
		int upload_max_size = 2147483647;
		
		DEXT5Handler DEXT5 = new DEXT5Handler();
		String sPathChar = java.io.File.separator;
	    String PATH_SRV = EgovProperties.getProperty("HOST.WEBROOT") + sPathChar + "data"+ sPathChar + "dext";
	    log.info("PATH_SRV :: " + PATH_SRV );
		// 임시파일 물리적 경로설정
	    String tmpPath = PATH_SRV + sPathChar + "editor";
	    
		DEXT5.SetTempRealPath(tmpPath);
		DEXT5.SetRealPath(tmpPath);
		String webPath = "/data/dext/editor/";
		DEXT5.SetWebPath(webPath);
		String result = DEXT5.DEXTProcess(request, response, request.getSession().getServletContext(), _allowFileExt, upload_max_size);

		if(DEXT5.IsImageUpload()) {
			/*
			// 동일 폴더에 이미지 썸네일 생성하기
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.ImageThumbnail(strSourceFile, "_thumb", 600, 0);
			if (rtn_value != 0) {
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 썸네일 파일 생성
			String strSourceFile = DEXT5.LastSaveFile();
			String strNewFileName = strSourceFile.replaceAll("\\\\image\\\\", "\\thumbnail\\");
			int rtn_value = DEXT5.GetImageThumbOrNewEx(strSourceFile, strNewFileName, 200, 0, 0);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 이미지 포멧 변경
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.ImageConvertFormat(strSourceFile, "png", 0);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 이미지 크기 변환
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.ImageConvertSize(strSourceFile, 500, 30);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 비율로 이미지 크기 변환
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.ImageConvertSizeByPercent(strSourceFile, 50);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 비율로 이미지 크기 변환
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.ImageConvertSizeByPercent(strSourceFile, 50);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 이미지 회전
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.ImageRotate(strSourceFile, 90);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 이미지 워터마크
			String strSourceFile = DEXT5.LastSaveFile();
			String strWaterMarkFile = "C:\\Temp\\watermark.jpg";
			int rtn_value = DEXT5.ImageWaterMark(strSourceFile, strWaterMarkFile, "TOP", 10, "RIGHT", 10, 0);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/

			/*
			// 텍스트 워터마크
			String strSourceFile = DEXT5.LastSaveFile();
			DEXT5.SetFontInfo("굴림", 50, "FF00FF");
			int rtn_value = DEXT5.TextWaterMark(strSourceFile, "DEXT5", "TOP", 10, "CENTER", 10, 0, 45);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
	        
	        /*
			// 다른 파일명.확장자 
			String strSourceFile = DEXT5.LastSaveFile();
	        String rtn_value = DEXT5.GetNewFileNameEx("jpg", "TIME");
			if (rtn_value.equals(""))
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
	        */
	        
	        /*
	        // 이미지 가로(Width) 크기
	        String strSourceFile = DEXT5.LastSaveFile();
	        int rtn_value = DEXT5.GetImageWidth(strSourceFile);
	        if (rtn_value <= 0)
	        {
	            String strLastError = DEXT5.LastErrorMessage();
	        }
	        */
			
			/*
			// 이미지 세로(Height) 크기
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.GetImageHeight(strSourceFile);
			if (rtn_value <= 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/

			/*
			// 이미지 Format 정보
			String strSourceFile = DEXT5.LastSaveFile();
			String rtn_value = DEXT5.GetImageFormat(strSourceFile);
			if (rtn_value == "")
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 이미지 파일 크기
			String strSourceFile = DEXT5.LastSaveFile();
			long rtn_value = DEXT5.GetImageFileSize(strSourceFile);
			if (rtn_value <= 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/
			
			/*
			// 파일 삭제
			String strSourceFile = DEXT5.LastSaveFile();
			int rtn_value = DEXT5.DeleteFile(strSourceFile);
			if (rtn_value != 0)
			{
				String strLastError = DEXT5.LastErrorMessage();
			}
			*/

			/*
			// 원본 파일명 가져오기
			String strOriginalFileName = DEXT5.OriginalFileName();
			*/
			ServletOutputStream out = response.getOutputStream();
		    out.print(result);
		    out.close();
		} else {
		}

		// 파일 저장 경로 (물리적 경로)
		//if(DEXT5.LastSaveFile().length() > 0) { 
		//	System.out.println("save file : [" + DEXT5.LastSaveFile() + "]");
		//}

		// 파일 저장 경로 (WEB URL)
		//if(DEXT5.LastSaveUrl().length() > 0) { 
		//System.out.println("save url : [" + DEXT5.LastSaveUrl() + "]");
		//}

		// 에러 Message 
		//if(DEXT5.LastErrorMessage().length() > 0) { 
		//	System.out.println("DEXT5 Handler Error : [" + DEXT5.LastErrorMessage() + "]");
		//}

		/*out.clear();
		if(!result.equals("")) {
			out.print(result);
		} else {
			out.clear();
		}*/

		// Servlet으로 handler 작업을 하시려면 다음과 같이 작성해 주세요.
		/*
		ServletOutputStream out = response.getOutputStream();
	    out.print(result);
	    out.close();
	    */
	    return result;
	}
}
