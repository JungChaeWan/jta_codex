package common;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.EnumMap;
import java.util.Map;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import egovframework.cmmn.service.EgovProperties;

public class QrCodeUtil {
	
	private static String FILE_PATH = EgovProperties.getProperty("HOST.WEBROOT") + EgovProperties.getProperty("QR.SAVEDFILE");
	
	private static int size = 250;
	
	private static String fileType = "png";
	
	/**
	 * 예약번호로 qrCode 생성.
	 * @param rsvNum
	 * @return
	 */
	public static String qrCodeWriterByRsvNum(String rsvNum) {
		String filePath = FILE_PATH;
		File myFilePath = new File(filePath);
		try {
			 if (!myFilePath.isDirectory()) {
			    	boolean _flag = myFilePath.mkdirs();
					if (!_flag) {
					    throw new IOException("Directory creation Failed ");
					}
			    }
			File myFile = new File(FILE_PATH + rsvNum + "." + fileType);
			if(!myFile.exists()) {
				
				Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
				hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
				
				// Now with zxing version 3.2.1 you could change border size (white border size to just 1)
				hintMap.put(EncodeHintType.MARGIN, 1); /* default = 4 */
				hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
	 
				QRCodeWriter qrCodeWriter = new QRCodeWriter();
				BitMatrix byteMatrix = qrCodeWriter.encode(rsvNum, BarcodeFormat.QR_CODE, size,
						size, hintMap);
				int CrunchifyWidth = byteMatrix.getWidth();
				BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,
						BufferedImage.TYPE_INT_RGB);
				image.createGraphics();
	 
				Graphics2D graphics = (Graphics2D) image.getGraphics();
				graphics.setColor(Color.WHITE);
				graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
				graphics.setColor(Color.BLACK);
	 
				for (int i = 0; i < CrunchifyWidth; i++) {
					for (int j = 0; j < CrunchifyWidth; j++) {
						if (byteMatrix.get(i, j)) {
							graphics.fillRect(i, j, 1, 1);
						}
					}
				}
				ImageIO.write(image, fileType, myFile);
			}
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return EgovProperties.getProperty("QR.SAVEDFILE") + rsvNum + "." + fileType;
	}

}
