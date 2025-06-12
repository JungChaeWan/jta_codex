package oss.point.vo;
import oss.cmm.vo.pageDefaultVO;
import java.util.List;

public class POINT_CPNUMVO extends pageDefaultVO {

    /** 포인트 리스트 */
    private List<String> cpPointList;
    /** 수량 */
    private List<String> cpCntList;
    /** 파트너코드  */
    private String partnerCode;
    /** 그룹코드  */
    private String groupCode;
    /** 쿠폰번호  */
    private String cpNum;
    /** 포인트 */
    private int cpPoint;
    /** 쿠폰사용 유무*/
    private String useYn;
    /** 쿠폰사용 아이디*/
    private String userId;

    private String cpRegDttm;
    private String useRegDttm;


    public List<String> getCpPointList() {
        return cpPointList;
    }

    public void setCpPointList(List<String> cpPointList) {
        this.cpPointList = cpPointList;
    }

    public List<String> getCpCntList() {
        return cpCntList;
    }

    public void setCpCntList(List<String> cpCntList) {
        this.cpCntList = cpCntList;
    }

    public String getPartnerCode() {
        return partnerCode;
    }

    public void setPartnerCode(String partnerCode) {
        this.partnerCode = partnerCode;
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
    }

    public String getCpNum() {
        return cpNum;
    }

    public void setCpNum(String cpNum) {
        this.cpNum = cpNum;
    }

    public int getCpPoint() {
        return cpPoint;
    }

    public void setCpPoint(int cpPoint) {
        this.cpPoint = cpPoint;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCpRegDttm() {
        return cpRegDttm;
    }

    public void setCpRegDttm(String cpRegDttm) {
        this.cpRegDttm = cpRegDttm;
    }

    public String getUseRegDttm() {
        return useRegDttm;
    }

    public void setUseRegDttm(String useRegDttm) {
        this.useRegDttm = useRegDttm;
    }
}
