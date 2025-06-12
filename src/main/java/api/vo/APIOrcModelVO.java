package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIOrcModelVO {

	private String partnersCompanyCode;
    private int id;
    private String name;
    private int seat;
    private String fuel;
    private String transmission;
    private int displacement;
    private String drivingSystem;
    private List<String> options;
    private int minModelYear;
    private int maxModelYear;
    private int totalVehicleCount;
    private int driverAge;
    private int driverExperience;
    private APIOrcInsurancelistVO basicInsurance;
    private APIOrcInsurancelistVO premiumInsurance;
    private List<APIOrcPartnersCarlistVO> partnersVehicleModels;

	public String getPartnersCompanyCode() {
		return partnersCompanyCode;
	}

	public void setPartnersCompanyCode(String partnersCompanyCode) {
		this.partnersCompanyCode = partnersCompanyCode;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSeat() {
		return seat;
	}

	public void setSeat(int seat) {
		this.seat = seat;
	}

	public String getFuel() {
		return fuel;
	}

	public void setFuel(String fuel) {
		this.fuel = fuel;
	}

	public String getTransmission() {
		return transmission;
	}

	public void setTransmission(String transmission) {
		this.transmission = transmission;
	}

	public int getDisplacement() {
		return displacement;
	}

	public void setDisplacement(int displacement) {
		this.displacement = displacement;
	}

	public String getDrivingSystem() {
		return drivingSystem;
	}

	public void setDrivingSystem(String drivingSystem) {
		this.drivingSystem = drivingSystem;
	}

	public List<String> getOptions() {
		return options;
	}

	public void setOptions(List<String> options) {
		this.options = options;
	}

	public int getMinModelYear() {
		return minModelYear;
	}

	public void setMinModelYear(int minModelYear) {
		this.minModelYear = minModelYear;
	}

	public int getMaxModelYear() {
		return maxModelYear;
	}

	public void setMaxModelYear(int maxModelYear) {
		this.maxModelYear = maxModelYear;
	}

	public int getTotalVehicleCount() {
		return totalVehicleCount;
	}

	public void setTotalVehicleCount(int totalVehicleCount) {
		this.totalVehicleCount = totalVehicleCount;
	}

	public int getDriverAge() {
		return driverAge;
	}

	public void setDriverAge(int driverAge) {
		this.driverAge = driverAge;
	}

	public int getDriverExperience() {
		return driverExperience;
	}

	public void setDriverExperience(int driverExperience) {
		this.driverExperience = driverExperience;
	}

	public APIOrcInsurancelistVO getBasicInsurance() {
		return basicInsurance;
	}

	public void setBasicInsurance(APIOrcInsurancelistVO basicInsurance) {
		this.basicInsurance = basicInsurance;
	}

	public APIOrcInsurancelistVO getPremiumInsurance() {
		return premiumInsurance;
	}

	public void setPremiumInsurance(APIOrcInsurancelistVO premiumInsurance) {
		this.premiumInsurance = premiumInsurance;
	}

	public List<APIOrcPartnersCarlistVO> getPartnersVehicleModels() {
		return partnersVehicleModels;
	}

	public void setPartnersVehicleModels(List<APIOrcPartnersCarlistVO> partnersVehicleModels) {
		this.partnersVehicleModels = partnersVehicleModels;
	}
}
