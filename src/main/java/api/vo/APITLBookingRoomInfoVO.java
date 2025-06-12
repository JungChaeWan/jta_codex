package api.vo;

public class APITLBookingRoomInfoVO {
    private String TravelAgencyBookingNumber;
    private String roomTypeCode;
    private String roomTypeName;
    private String roomDate;
    private String guestNameSingleByte;
    private int perRoomPaxCount;
    /** 몇박 **/
    private int nights;
    /** 성.소.유. Count **/
    private int roomRatePaxMaleCount;
    private int juniorCount;
    private int childCount;
    /**일별 숙박요금**/
    private int totalPerRoomRate;
    /**일별 숙박요금 청구액 (숙박요금 + 인당추가요금)**/
    private int totalSaleAmt;
    /**LPOINT 사용 내역**/
    private String usePoint;

    public String getTravelAgencyBookingNumber() {
        return TravelAgencyBookingNumber;
    }

    public void setTravelAgencyBookingNumber(String travelAgencyBookingNumber) {
        TravelAgencyBookingNumber = travelAgencyBookingNumber;
    }

    public String getRoomTypeCode() {
        return roomTypeCode;
    }

    public void setRoomTypeCode(String roomTypeCode) {
        this.roomTypeCode = roomTypeCode;
    }

    public String getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    public String getRoomDate() {
        return roomDate;
    }

    public void setRoomDate(String roomDate) {
        this.roomDate = roomDate;
    }

    public String getGuestNameSingleByte() {
        return guestNameSingleByte;
    }

    public void setGuestNameSingleByte(String guestNameSingleByte) {
        this.guestNameSingleByte = guestNameSingleByte;
    }

    public int getPerRoomPaxCount() {
        return perRoomPaxCount;
    }

    public void setPerRoomPaxCount(int perRoomPaxCount) {
        this.perRoomPaxCount = perRoomPaxCount;
    }

    public int getNights() {
        return nights;
    }

    public void setNights(int nights) {
        this.nights = nights;
    }

    public int getRoomRatePaxMaleCount() {
        return roomRatePaxMaleCount;
    }

    public void setRoomRatePaxMaleCount(int roomRatePaxMaleCount) {
        this.roomRatePaxMaleCount = roomRatePaxMaleCount;
    }

    public int getJuniorCount() {
        return juniorCount;
    }

    public void setJuniorCount(int juniorCount) {
        this.juniorCount = juniorCount;
    }

    public int getChildCount() {
        return childCount;
    }

    public void setChildCount(int childCount) {
        this.childCount = childCount;
    }

    public int getTotalPerRoomRate() {
        return totalPerRoomRate;
    }

    public void setTotalPerRoomRate(int totalPerRoomRate) {
        this.totalPerRoomRate = totalPerRoomRate;
    }

    public int getTotalSaleAmt() {
        return totalSaleAmt;
    }

    public void setTotalSaleAmt(int totalSaleAmt) {
        this.totalSaleAmt = totalSaleAmt;
    }

    public String getUsePoint() {
        return usePoint;
    }

    public void setUsePoint(String usePoint) {
        this.usePoint = usePoint;
    }
}

