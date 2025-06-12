package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIOrcCarlistVO {

	private APIOrcCarlistItemVO vehicleModel;
    private String pickUpAt;  // 예시로 문자열로 처리, 실제로는 LocalDateTime 권장
    private String dropOffAt;
    private int availableVehicleCount;
    private int preallocatedVehicleCount;
    private int defaultPrice;
    private int standardPrice;
    private int basicInsuredPrice;
    private int premiumInsuredPrice;

	public APIOrcCarlistItemVO getVehicleModel() {
		return vehicleModel;
	}

	public void setVehicleModel(APIOrcCarlistItemVO vehicleModel) {
		this.vehicleModel = vehicleModel;
	}

	public String getPickUpAt() {
		return pickUpAt;
	}

	public void setPickUpAt(String pickUpAt) {
		this.pickUpAt = pickUpAt;
	}

	public String getDropOffAt() {
		return dropOffAt;
	}

	public void setDropOffAt(String dropOffAt) {
		this.dropOffAt = dropOffAt;
	}

	public int getAvailableVehicleCount() {
		return availableVehicleCount;
	}

	public void setAvailableVehicleCount(int availableVehicleCount) {
		this.availableVehicleCount = availableVehicleCount;
	}

	public int getPreallocatedVehicleCount() {
		return preallocatedVehicleCount;
	}

	public void setPreallocatedVehicleCount(int preallocatedVehicleCount) {
		this.preallocatedVehicleCount = preallocatedVehicleCount;
	}

	public int getDefaultPrice() {
		return defaultPrice;
	}

	public void setDefaultPrice(int defaultPrice) {
		this.defaultPrice = defaultPrice;
	}

	public int getStandardPrice() {
		return standardPrice;
	}

	public void setStandardPrice(int standardPrice) {
		this.standardPrice = standardPrice;
	}

	public int getBasicInsuredPrice() {
		return basicInsuredPrice;
	}

	public void setBasicInsuredPrice(int basicInsuredPrice) {
		this.basicInsuredPrice = basicInsuredPrice;
	}

	public int getPremiumInsuredPrice() {
		return premiumInsuredPrice;
	}

	public void setPremiumInsuredPrice(int premiumInsuredPrice) {
		this.premiumInsuredPrice = premiumInsuredPrice;
	}
}
