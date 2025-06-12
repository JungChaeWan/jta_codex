package api.vo;

public class NAVERVO {

	private String id;					// 상품 ID
	private String title;				// 상품명(100)
	private String price_pc;			// 상품가격
	private String price_mobile;		//모바일 가격.
	private String normal_price;			// 정가
	private String link;				// 상품URL
	private String mobile_link;			// 모바일 상품 URL
	private String image_link;			// 이미지 URL
	private String add_image_link;		// 추가이미지 URL (10개까지-구분자|)
	private String category_name1;		// 카테고리 대분류 
	private String category_name2;		// 카테고리 중분류
	private String naver_category;		//  네이버카테고리(쇼핑파트너존 다운로드)
	private String naver_product_id;	// 가격비교 페이지 ID 
	private String condition;			// 상품상태 - 빈값 - 신상품(신상품/중고/리퍼/전시/반품/스크레치)
	private String import_flag;			// 해외구매대행 여부 
	private String parallel_import;		// 병행수입여부
	private String order_made;			// 주문제작상품 여
	private String product_flag;		// 판매방식 구분(도매/렌탈/대여/할부/예약판매/구매대행)
	private String adult;				//미성년자 구매불가 상품여부
	private String brand;				// 브랜드
	private String maker;				// 제조사(60)
	private String origin;				// 원산지 (30)
	private String event_words;			// 이벤트(100)
	private String coupon;				// 일반/제휴 쿠폰
	private String partner_coupon_download;	//쿠폰다운로드 필요 여부
	private String interest_free_event;		// 카드 무이자할부 정보
	private String search_tag;			// 검색태그(100자 - 10개까지-구분자 |)
	private String group_id;			//50자 쇼셜커머스몰 상품중 구매옵션이 분리된 상품들에 메인상품ID
	private String coordi_id;			//코디상품의 경우 메인상품에 서브상품ID-구분자 |
	private String minimum_purchase_quantity;	// 최소구매수량
	private String review_count;		// 상품평 개수 
	private String shipping;			// 배송료(100)
	private String delivery_grade;		// 차등배송비 여부(Y)
	private String delivery_detail;		//지역이나 품목에 따라 배송비가 추가로 발생한 경우 상세내용 기입.
	private String attribute;			// 속성(^으로 연결해서 순차적으로)(500)
	private String option_detail;		// 구매옵션(구매옵션명^가격|구매옵션명^가격)-50개 or 1000자.
	private String seller_id;			// 입점한 셀러의 ID
	private String age_group;			//사용층(유아/아동/청소년/성인)-기본-성인
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPrice_pc() {
		return price_pc;
	}
	public void setPrice_pc(String price_pc) {
		this.price_pc = price_pc;
	}
	public String getPrice_mobile() {
		return price_mobile;
	}
	public void setPrice_mobile(String price_mobile) {
		this.price_mobile = price_mobile;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getMobile_link() {
		return mobile_link;
	}
	public void setMobile_link(String mobile_link) {
		this.mobile_link = mobile_link;
	}
	public String getImage_link() {
		return image_link;
	}
	public void setImage_link(String image_link) {
		this.image_link = image_link;
	}
	public String getAdd_image_link() {
		return add_image_link;
	}
	public void setAdd_image_link(String add_image_link) {
		this.add_image_link = add_image_link;
	}
	public String getCategory_name1() {
		return category_name1;
	}
	public void setCategory_name1(String category_name1) {
		this.category_name1 = category_name1;
	}
	public String getCategory_name2() {
		return category_name2;
	}
	public void setCategory_name2(String category_name2) {
		this.category_name2 = category_name2;
	}
	public String getNaver_category() {
		return naver_category;
	}
	public void setNaver_category(String naver_category) {
		this.naver_category = naver_category;
	}
	public String getNaver_product_id() {
		return naver_product_id;
	}
	public void setNaver_product_id(String naver_product_id) {
		this.naver_product_id = naver_product_id;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getImport_flag() {
		return import_flag;
	}
	public void setImport_flag(String import_flag) {
		this.import_flag = import_flag;
	}
	public String getParallel_import() {
		return parallel_import;
	}
	public void setParallel_import(String parallel_import) {
		this.parallel_import = parallel_import;
	}
	public String getOrder_made() {
		return order_made;
	}
	public void setOrder_made(String order_made) {
		this.order_made = order_made;
	}
	public String getProduct_flag() {
		return product_flag;
	}
	public void setProduct_flag(String product_flag) {
		this.product_flag = product_flag;
	}
	public String getAdult() {
		return adult;
	}
	public void setAdult(String adult) {
		this.adult = adult;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getMaker() {
		return maker;
	}
	public void setMaker(String maker) {
		this.maker = maker;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getEvent_words() {
		return event_words;
	}
	public void setEvent_words(String event_words) {
		this.event_words = event_words;
	}
	public String getCoupon() {
		return coupon;
	}
	public void setCoupon(String coupon) {
		this.coupon = coupon;
	}
	public String getPartner_coupon_download() {
		return partner_coupon_download;
	}
	public void setPartner_coupon_download(String partner_coupon_download) {
		this.partner_coupon_download = partner_coupon_download;
	}
	public String getInterest_free_event() {
		return interest_free_event;
	}
	public void setInterest_free_event(String interest_free_event) {
		this.interest_free_event = interest_free_event;
	}
	public String getSearch_tag() {
		return search_tag;
	}
	public void setSearch_tag(String search_tag) {
		this.search_tag = search_tag;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getCoordi_id() {
		return coordi_id;
	}
	public void setCoordi_id(String coordi_id) {
		this.coordi_id = coordi_id;
	}
	public String getMinimum_purchase_quantity() {
		return minimum_purchase_quantity;
	}
	public void setMinimum_purchase_quantity(String minimum_purchase_quantity) {
		this.minimum_purchase_quantity = minimum_purchase_quantity;
	}
	public String getReview_count() {
		return review_count;
	}
	public void setReview_count(String review_count) {
		this.review_count = review_count;
	}
	public String getShipping() {
		return shipping;
	}
	public void setShipping(String shipping) {
		this.shipping = shipping;
	}
	public String getDelivery_grade() {
		return delivery_grade;
	}
	public void setDelivery_grade(String delivery_grade) {
		this.delivery_grade = delivery_grade;
	}
	public String getDelivery_detail() {
		return delivery_detail;
	}
	public void setDelivery_detail(String delivery_detail) {
		this.delivery_detail = delivery_detail;
	}
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	public String getOption_detail() {
		return option_detail;
	}
	public void setOption_detail(String option_detail) {
		this.option_detail = option_detail;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getAge_group() {
		return age_group;
	}
	public void setAge_group(String age_group) {
		this.age_group = age_group;
	}
	@Override
	public String toString() {
		return "NAVERVO [id=" + id + ", title=" + title + ", price_pc=" + price_pc + ", price_mobile=" + price_mobile
				+ ", nomal_price=" + normal_price + ", link=" + link + ", mobile_link=" + mobile_link + ", image_link="
				+ image_link + ", add_image_link=" + add_image_link + ", category_name1=" + category_name1
				+ ", category_name2=" + category_name2 + ", naver_category=" + naver_category + ", naver_product_id="
				+ naver_product_id + ", condition=" + condition + ", import_flag=" + import_flag + ", parallel_import="
				+ parallel_import + ", order_made=" + order_made + ", product_flag=" + product_flag + ", adult=" + adult
				+ ", brand=" + brand + ", maker=" + maker + ", origin=" + origin + ", event_words=" + event_words
				+ ", coupon=" + coupon + ", partner_coupon_download=" + partner_coupon_download
				+ ", interest_free_event=" + interest_free_event + ", search_tag=" + search_tag + ", group_id="
				+ group_id + ", coordi_id=" + coordi_id + ", minimum_purchase_quantity=" + minimum_purchase_quantity
				+ ", review_count=" + review_count + ", shipping=" + shipping + ", delivery_grade=" + delivery_grade
				+ ", delivery_detail=" + delivery_detail + ", attribute=" + attribute + ", option_detail="
				+ option_detail + ", seller_id=" + seller_id + ", age_group=" + age_group + "]";
	}
	public String getNormal_price() {
		return normal_price;
	}
	public void setNormal_price(String normal_price) {
		this.normal_price = normal_price;
	}
	
}
