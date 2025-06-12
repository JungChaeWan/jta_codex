package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIOrcCarlistItemVO {

	private String partnersCompanyCode;
    private int id;

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
}
