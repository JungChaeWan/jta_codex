package apiCn.vo;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "response")
@XmlAccessorType(XmlAccessType.FIELD)
public class ILSVO {

	@XmlElement(name = "item")
	private List<ILSDTLVO> ilsDtlVOList;

	public List<ILSDTLVO> getIlsDtlVOList() {
		return ilsDtlVOList;
	}

	public void setIlsDtlVOList(List<ILSDTLVO> ilsDtlVOList) {
		this.ilsDtlVOList = ilsDtlVOList;
	}

	

}