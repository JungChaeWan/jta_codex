package api.vo;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name = "items")
public class APIRibbonCarlistVOitems {
    @XmlAttribute(name = "possibleCount")
    private String possibleCount;

    @XmlAttribute(name = "vhctyCode")
    private String vhctyCode;

    @XmlElement(name = "item")
    private List<APIRibbonCarlistVOitem> item;

    public List<APIRibbonCarlistVOitem> getItem() {
        return item;
    }

    public String getPossibleCount() {
        return possibleCount;
    }

    public String getVhctyCode() {
        return vhctyCode;
    }
}
