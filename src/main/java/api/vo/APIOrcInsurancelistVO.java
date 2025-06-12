package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIOrcInsurancelistVO {
    private String partnersCompanyCode;
    private int id;
    private String name;
    private String type;
    private String coverageLimit;
    private String deductible;
    private String lossOfUseCompensation;
    private String content;
    private int driverAge;
    private int driverExperience;
    private int vehicleModelId;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCoverageLimit() {
        return coverageLimit;
    }

    public void setCoverageLimit(String coverageLimit) {
        this.coverageLimit = coverageLimit;
    }

    public String getDeductible() {
        return deductible;
    }

    public void setDeductible(String deductible) {
        this.deductible = deductible;
    }

    public String getLossOfUseCompensation() {
        return lossOfUseCompensation;
    }

    public void setLossOfUseCompensation(String lossOfUseCompensation) {
        this.lossOfUseCompensation = lossOfUseCompensation;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public int getVehicleModelId() {
        return vehicleModelId;
    }

    public void setVehicleModelId(int vehicleModelId) {
        this.vehicleModelId = vehicleModelId;
    }
}
