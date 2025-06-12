package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class APILSRECIEVEVO {

	/** 결과상태 */
	private String status;

	/** 결과코드 */
	private String resultCode;

	/** 결과메시지 */
	private String resultMessage;
	
	/** 예약번호 */
	private String orderNo;

	/** 바코드 */
	private String barcode;

	/** 사용개수 */
	private int useNum;

	/** 미연동 옵션 */
	private int noOptCnt;

	private List<lsList> list;

	@JsonIgnoreProperties(ignoreUnknown = true)
	public static class lsList{
		private String product_name;
		private String product_code;
		private List<lsImages> images;
		private List<lsOptions> option;


		private String product_match;

		@JsonIgnoreProperties(ignoreUnknown = true)
		public static class lsImages{
			private String imageType;
			private String imageUri;

			public String getImageType() {return imageType;}
			public void setImageType(String imageType) {this.imageType = imageType;}
			public String getImageUri() {return imageUri;}
			public void setImageUri(String imageUri) {this.imageUri = imageUri;}
		}

		@JsonIgnoreProperties(ignoreUnknown = true)
		public static class lsOptions{
			private String optionId;
			private String name;
			private String startDate;
			private String endDate;
			private String expireType;
			private String expireStartDate;
			private String expireEndDate;
			private String expireDay;
			private String normalPrice;
			private String salePrice;
			private String classify;

			private String option_match;

			public String getOptionId() {return optionId;}
			public void setOptionId(String optionId) {this.optionId = optionId;}
			public String getName() {return name;}
			public void setName(String name) {this.name = name;}
			public String getStartDate() {return startDate;}
			public void setStartDate(String startDate) {this.startDate = startDate;}
			public String getEndDate() {return endDate;}
			public void setEndDate(String endDate) {this.endDate = endDate;}
			public String getExpireType() {return expireType;}
			public void setExpireType(String expireType) {this.expireType = expireType;}
			public String getExpireStartDate() {return expireStartDate;}
			public void setExpireStartDate(String expireStartDate) {this.expireStartDate = expireStartDate;}
			public String getExpireEndDate() {return expireEndDate;}
			public void setExpireEndDate(String expireEndDate) {this.expireEndDate = expireEndDate;}
			public String getExpireDay() {return expireDay;}
			public void setExpireDay(String expireDay) {this.expireDay = expireDay;}
			public String getNormalPrice() {return normalPrice;}
			public void setNormalPrice(String normalPirce) {this.normalPrice = normalPirce;}
			public String getSalePrice() {return salePrice;}
			public void setSalePrice(String salePrice) {this.salePrice = salePrice;}
			public String getClassify() {return classify;}
			public void setClassify(String classify) {this.classify = classify;}
			public String getOption_match() {return option_match;}
			public void setOption_match(String option_match) {this.option_match = option_match;}
		}

		public String getProduct_name() {return product_name;}
		public void setProduct_name(String product_name) {this.product_name = product_name;}
		public String getProduct_code() {return product_code;}
		public void setProduct_code(String product_code) {this.product_code = product_code;}
		public List<lsImages> getImages() {return images;}
		public void setImages(List<lsImages> images) {this.images = images;}
		public List<lsOptions> getOption() {return option;}
		public void setOption(List<lsOptions> option) {this.option = option;}
		public String getProduct_match() {return product_match;}
		public void setProduct_match(String product_match) {this.product_match = product_match;}
	}

	public List<lsList> getList() {return list;}
	public void setList(List<lsList> list) {this.list = list;}
	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}
	public String getResultCode() {return resultCode;}
	public void setResultCode(String resultCode) {this.resultCode = resultCode;}
	public String getResultMessage() {return resultMessage;}
	public void setResultMessage(String resultMessage) {this.resultMessage = resultMessage;}
	public String getOrderNo() {return orderNo;}
	public void setOrderNo(String orderNo) {this.orderNo = orderNo;}
	public String getBarcode() {return barcode;}
	public void setBarcode(String barcode) {this.barcode = barcode;}
	public int getUseNum() {return useNum;}
	public void setUseNum(int useNum) {this.useNum = useNum;}
	public int getNoOptCnt() {return noOptCnt;}
	public void setNoOptCnt(int noOptCnt) {this.noOptCnt = noOptCnt;}
}
