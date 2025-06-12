package api.service.impl;

import api.service.APIAligoService;
import api.service.APITLBookingService;
import api.vo.APIAligoVO;
import api.vo.APITLBookingLogVO;
import api.vo.APITLBookingVO;
import egovframework.cmmn.service.EgovProperties;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebOrderService;
import web.order.vo.AD_RSV_DAYPRICEVO;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.soap.*;
import javax.xml.transform.dom.DOMSource;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLStreamHandler;
import java.text.SimpleDateFormat;
import java.util.*;
import common.Constant;

@Service("apitlBookingService")
public class APITLBookingServiceImpl implements APITLBookingService {
    Logger log = (Logger) LogManager.getLogger(this.getClass());

    @Autowired
    private APITLBookingDAO apiTlBookingDao;

    @Autowired
    private WebOrderService webOrderService;

    @Autowired
    private APIAligoService apiAligoService;

    /**
    * 설명 : 예약 전송
    * 파일명 :
    * 작성일 : 2021-06-15 오후 4:08
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public List<APITLBookingLogVO> bookingSend(String rsvNum) {

        List<APITLBookingLogVO> listBookingLogVO = new ArrayList<APITLBookingLogVO>();
        try {
            //예약 내역 List
            List<APITLBookingVO> listBooking = apiTlBookingDao.selectByBooking(rsvNum);
            for (APITLBookingVO bookingVO : listBooking) { //룸별 loop

                //접속정보
                String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
                String agentID = "test".equals(CST_PLATFORM.trim()) ? "2G" : "2G";
                String agentPassword = "test".equals(CST_PLATFORM.trim()) ? "test_Tamnao" : "yi2BoVFOPrrY";

                //예약 전송기준(판매가, 입금가)으로 값 셋팅
                String tllRsvLink = bookingVO.getTllRsvLink();
                int saleAmt = 0;
                int nmlAmt = 0;
                if ("NET".equals(tllRsvLink)){
                    saleAmt = bookingVO.getSaleAmtNet();
                    nmlAmt = bookingVO.getNmlAmtNet();
                }else{
                    saleAmt = bookingVO.getSaleAmt();
                    nmlAmt = bookingVO.getNmlAmt();
                }

                //시설사 전화번호가 있으면, 전화번호 노출과 함께 sendDiv = 0값으로 설정
                String sendDiv = "".equals(bookingVO.getCorpTelNum()) ? "" : "0";

                //객실 수 (건당예약 발송으로 변경 하여 객실 수는 1로 고정)
                int totalRoomCount = 1;

                //결제 금액
                String AmountClaimed = String.valueOf(saleAmt - bookingVO.getUsePoint());

                //업체명 특수문자 제거
                String CorpNm = bookingVO.getCorpNm().replaceAll("[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]", " ");

                //Date Time Setting
                Date now = new Date();
                SimpleDateFormat systemDate = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat systemTime = new SimpleDateFormat("HH:mm:ss");
                SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");
                String checkInDate = systemDate.format(dtFormat.parse(bookingVO.getUseDt()));
                Calendar cal = Calendar.getInstance();

                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                factory.setNamespaceAware(true);
                factory.setIgnoringElementContentWhitespace(true);
                DocumentBuilder parser = factory.newDocumentBuilder();

                String sendMessage = "";

                //request SOAP message DOMSource create
                sendMessage =
                    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:book=\"http://www2.risapls.jp/BookingService\">" +
                        "<soapenv:Header/>" +
                        "<soapenv:Body>" +
                        "   <book:setReserve>" +
                        "      <setReserve>" +
                        "         <RmRequest>" +
                        "            <expiryTime/>" +
                        "            <replyPattern>Callback</replyPattern>" +
                        "            <ackRequested/>" +
                        "            <duplicateElimination/>" +
                        "            <messageOrder/>" +
                        "            <messageId>" +
                        "               <groupId>" + bookingVO.getAdRsvNum() + "@tamnao.com</groupId>" +
                        "               <sequenceNum>0</sequenceNum>" +
                        "               <status>Start</status>" +
                        "            </messageId>" +
                        "         </RmRequest>" +
                        "         <SendInformation>" +
                        "            <version>4.0</version>" +
                        "            <travelXMLversion>1.4</travelXMLversion>" +
                        "            <agentID>" + agentID + "</agentID>" +
                        "            <agentPassword>" + agentPassword + "</agentPassword>" +
                        "            <sendQueueing>1</sendQueueing>" +
                        "            <sendDiv>" + sendDiv + "</sendDiv>" +
                        "            <sendTel>" + bookingVO.getCorpTelNum() + "</sendTel>" +
                        "            <sendFax/>" +
                        "            <assignDiv>0</assignDiv>" +
                        "            <telegramDiv>0</telegramDiv>" +
                        "            <genderDiv>0</genderDiv>" +
                        "         </SendInformation>" +
                        "         <AllotmentBookingReport>" +
                        "            <TransactionType>" +
                        "               <DataFrom>FromTravelAgency</DataFrom>" +
                        "               <DataClassification>NewBookReport</DataClassification>" +
                        "               <DataID>" + bookingVO.getDataId() + "</DataID>" +
                        "               <SystemDate>" + systemDate.format(now) + "</SystemDate>" +
                        "            </TransactionType>" +
                        "            <AccommodationInformation>" +
                        "               <AccommodationArea/>" +
                        "               <AccommodationName>" + CorpNm + "</AccommodationName>" +
                        "               <AccommodationCode>" + bookingVO.getCorpId() + "</AccommodationCode>" +
                        "               <ChainName/>" +
                        "               <AccommodationPersonInCharge/>" +
                        "               <AccommodationEmail/>" +
                        "               <AccommodationPhoneNumber/>" +
                        "               <AccommodationCPUAddress/>" +
                        "               <!--1 or more repetitions:-->" +
                        "               <BankList>" +
                        "                  <BankName/>" +
                        "                  <BankAccountNumber/>" +
                        "                  <BankBranchName/>" +
                        "                  <BankAccountClassification/>" +
                        "                  <BankAccountName/>" +
                        "               </BankList>" +
                        "            </AccommodationInformation>" +
                        "            <SalesOfficeInformation>" +
                        "               <SalesOfficeCompanyName>tamnao.com</SalesOfficeCompanyName>" +
                        "               <SalesOfficeName>tamnao</SalesOfficeName>" +
                        "               <SalesOfficeCode>2G</SalesOfficeCode>" +
                        "               <SalesOfficePersonInCharge/>" +
                        "               <SalesOfficeEmail>tamnao@tamnao.com</SalesOfficeEmail>" +
                        "               <SalesOfficePhoneNumber>1522-3454</SalesOfficePhoneNumber>" +
                        "               <SalesOfficeFaxNumber/>" +
                        "               <SalesOfficeStateProvidence/>" +
                        "               <SalesOfficeCityName/>" +
                        "               <SalesOfficeAddressLine/>" +
                        "               <SalesOfficeStreetNumber/>" +
                        "               <SalesOfficePostalCode/>" +
                        "               <SalesOfficeRegisteredCategory/>" +
                        "               <SalesOfficeLicenseNumber/>" +
                        "               <SalesOfficeRegisteredPrefecture/>" +
                        "               <SalesOfficeCPUAddress/>" +
                        "               <RetailerCompanyName/>" +
                        "               <RetailerOfficeName/>" +
                        "               <RetailerOfficeCode/>" +
                        "               <RetailerPersonInCharge/>" +
                        "               <RetailerEmail/>" +
                        "               <RetailerPhoneNumber/>" +
                        "               <RetailerStateProvidence/>" +
                        "               <RetailerCityName/>" +
                        "               <RetailerAddressLine/>" +
                        "               <RetailerStreetNumber/>" +
                        "               <RetailerPostalCode/>" +
                        "               <RetailerRegisteredCategory/>" +
                        "               <RetailerLicenseNumber/>" +
                        "               <RetailerRegisteredPrefecture/>" +
                        "            </SalesOfficeInformation>" +
                        "            <BasicInformation>" +
                        "               <TravelAgencyBookingNumber>" + bookingVO.getAdRsvNum() + "</TravelAgencyBookingNumber>" +
                        "               <TravelAgencyBookingDate>" + systemDate.format(now) + "</TravelAgencyBookingDate>" +
                        "               <TravelAgencyBookingTime>" + systemTime.format(now) + "</TravelAgencyBookingTime>" +
                        "               <TravelAgencyReportNumber/>" +
                        "               <AccommodationConfirmationNumber/>" +
                        "               <GuestOrGroupMiddleName/>" +
                        "               <GuestOrGroupNameSingleByte>" + bookingVO.getUseNm() + "</GuestOrGroupNameSingleByte>" +
                        "               <GuestOrGroupNameDoubleByte/>" +
                        "               <GuestOrGroupKanjiName>" + bookingVO.getUseNm() + "</GuestOrGroupKanjiName>" +
                        "               <GuestOrGroupContactDiv/>" +
                        "               <GuestOrGroupCellularNumber/>" +
                        "               <GuestOrGroupOfficeNumber/>" +
                        "               <GuestOrGroupPhoneNumber>" + bookingVO.getUseTelnum() + "</GuestOrGroupPhoneNumber>" +
                        "               <GuestOrGroupEmail>" + bookingVO.getUseEmail() + "</GuestOrGroupEmail>" +
                        "               <GuestOrGroupPostalCode />" +
                        "               <GuestOrGroupAddress />" +
                        "               <GroupNameWelcomeBoard/>" +
                        "               <GuestGenderDiv/>" +
                        "               <GuestGeneration/>" +
                        "               <GuestAge/>" +
                        "               <CheckInDate>" + checkInDate + "</CheckInDate>" +
                        "               <CheckInTime/>" +
                        "               <CheckOutDate/>" +
                        "               <CheckOutTime/>" +
                        "               <Nights>" + bookingVO.getUseNight() + "</Nights>" +
                        "               <Transportaion/>" +
                        "               <CoachCount/>" +
                        "               <CoachCompany/>" +
                        "               <TotalRoomCount>" + totalRoomCount + "</TotalRoomCount>" +
                        "               <GrandTotalPaxCount>" + bookingVO.getAdNum() + "</GrandTotalPaxCount>" +
                        "               <TotalPaxMaleCount>" + bookingVO.getAdultNum() + "</TotalPaxMaleCount>" +
                        "               <TotalPaxFemaleCount />" +
                                        getTotalChildTag(bookingVO.getJuniorAgeStdApicode(), bookingVO.getChildAgeStdApicode(), bookingVO.getJuniorNum(), bookingVO.getChildNum()) +
                        "               <TotalTourConductorCount/>" +
                        "               <TotalCoachDriverCount/>" +
                        "               <TotalGuideCount/>" +
                        "               <TypeOfGroupDoubleByte/>" +
                        "               <Status/>" +
                        "               <PackageType/>" +
                        "               <PackagePlanName>TamnaoBasicPlan</PackagePlanName>" +
                        "               <PackagePlanCode>P001</PackagePlanCode>" +
                        "               <PackagePlanCodeSC/>" +
                        "               <PackagePlanContent/>" +
                        "               <MealCondition>Other</MealCondition>" +
                        "               <SpecificMealCondition/>" +
                        "               <MealPlace/>" +
                        "               <BanquetRoom/>" +
                        "               <ModificationType/>" +
                        "               <ModificationPoint/>" +
                        "               <CancellationNumber/>" +
                        "               <PreviousPlace/>" +
                        "               <PreviousAccommodationName/>" +
                        "               <SpecialServiceRequest/>" +
                        "               <OtherServiceInformation/>" +
                        "               <SalesOfficeComment/>" +
                        "               <FollowUpInformation/>" +
                        "               <!--1 or more repetitions:-->" +
                        "               <QuestionAndAnswerList>" +
                        "                  <FromHotelQuestion/>" +
                        "                  <ToHotelAnswer/>" +
                        "               </QuestionAndAnswerList>" +
                        "            </BasicInformation>" +
                        "            <BasicRateInformation>" +
                        "               <RoomRateOrPersonalRate>RoomRate</RoomRateOrPersonalRate>" +
                        "               <TaxServiceFee>IncludingServiceAndTax</TaxServiceFee>" +
                        "               <Payment/>" +
                        "               <SettlementDiv>6</SettlementDiv>" +
                        "               <BareNetRate/>" +
                        "               <CancellationCharges/>" +
                        "               <CancellationNotice/>" +
                        "               <CreditCardAuthority/>" +
                        "               <CreditCardNumber/>" +
                        "               <ExpireDate/>" +
                        "               <CardHolderName/>" +
                        "               <TotalAccommodationCharge>" + nmlAmt + "</TotalAccommodationCharge>" +
                        "               <TotalAccommodationConsumptionTax/>" +
                        "               <TotalAccommodationHotSpringTax/>" +
                        "               <TotalAccommodationHotelTax/>" +
                        "               <TotalAccomodationServiceCharge/>" +
                        "               <TotalAccommodationServiceFee/>" +
                        "               <TotalAccommodationBreakfastFee/>" +
                        "               <TotalAccommodationOtherFee/>" +
                        "               <ComissionPercentage/>" +
                        "               <TotalAccommodationComissionAmount/>" +
                        "               <TotalAccommodationComissionConsumptionTax/>" +
                        "               <TotalAccommodationChargeAfterCheckIn/>" +
                        "               <TotalBalanceAfterCheckIn/>" +
                        "               <TotalAccommodationConsumptionAfterCheckIn/>" +
                        "               <CancellationChargeAfterCheckIn/>" +
                        "               <MembershipFee/>" +
                        "               <AdjustmentFee/>" +
                        "               <TotalAccommodationDiscountPoints/>" +
                        "               <TotalAccommodationConsumptionTaxAfterDiscountPoints/>" +
                        "               <AmountClaimed>" + AmountClaimed + "</AmountClaimed>" +
                        //쿠폰 (포인트) 설정
                        "               <!--1 or more repetitions:-->" +
                        getPointTag(bookingVO.getAdRsvNum()) +
                        //.쿠폰 (포인트) 설정
                        "               <!--1 or more repetitions:-->" +
                        "               <DepositList>" +
                        "                  <DepositAmount/>" +
                        "               </DepositList>" +
                        "               <!--1 or more repetitions:-->" +
                        "               <CouponList>" +
                        "                  <CouponIssueDate/>" +
                        "                  <CouponNumber/>" +
                        "                  <CouponType/>" +
                        "                  <CouponAmount/>" +
                        "               </CouponList>" +
                        "            </BasicRateInformation>" +
                        "            <MemberInformation>" +
                        "               <MemberName>" + bookingVO.getRsvNm() + "</MemberName>" +
                        "               <MemberKanjiName>" + bookingVO.getRsvNm() + "</MemberKanjiName>" +
                        "               <MemberMiddleName/>" +
                        "               <MemberDateOfBirth/>" +
                        "               <MemberEmergencyNumber/>" +
                        "               <MemberOccupation/>" +
                        "               <MemberOrganization/>" +
                        "               <MemberOrganizationKana/>" +
                        "               <MemberOrganizationCode/>" +
                        "               <MemberPosition/>" +
                        "               <MemberPostalCode/>" +
                        "               <MemberOfficeAddress/>" +
                        "               <MemberOfficeTelephoneNumber/>" +
                        "               <MemberOfficeFaxNumber/>" +
                        "               <MemberGenderDiv/>" +
                        "               <MemberClass/>" +
                        "               <CurrentPoints/>" +
                        "               <MailDemandDiv/>" +
                        "               <PamphletDemandDiv/>" +
                        "               <MemberID/>" +
                        "               <MemberPhoneNumber>" + bookingVO.getRsvTelnum() + "</MemberPhoneNumber>" +
                        "               <MemberEmail>" + bookingVO.getRsvEmail() + "</MemberEmail>" +
                        "               <MemberOfficePostalCode/>" +
                        "               <MemberAddress/>" +
                        "               <GivingPoints/>" +
                        "               <UsePoints/>" +
                        "            </MemberInformation>" +
                        "            <OptionInformation>" +
                        "               <!--1 or more repetitions:-->" +
                        "               <OptionList>" +
                        "                  <OptionDate/>" +
                        "                  <OptionCode/>" +
                        "                  <Name/>" +
                        "                  <NameRequest/>" +
                        "                  <OptionCount/>" +
                        "                  <OptionRate/>" +
                        "               </OptionList>" +
                        "            </OptionInformation>" +
                        "            <RoomInformationList>" +
                        "               <RoomAndGuestList>" +
                        "                  <!--1 or more repetitions:-->";
                for (int i = 0; i < bookingVO.getUseNight(); i++) { //숙박일별
                    //숙박시작일 부터 날짜 증가
                    cal.setTime(dtFormat.parse(bookingVO.getUseDt()));
                    cal.add(Calendar.DATE, i);


                    //일별 숙박 요금 (params 숙박예약코드, 일자)
                    AD_RSV_DAYPRICEVO adRsvDaypriceVO = apiTlBookingDao.selectByDayPrice(bookingVO.getAdRsvNum(), dtFormat.format(cal.getTime()));
                    int totalPerRoomRate = 0;

                    if (adRsvDaypriceVO != null) {
                        if ("NET".equals(tllRsvLink)) {
                            totalPerRoomRate = adRsvDaypriceVO.getTotAmtNet();
                        }else{
                            totalPerRoomRate = adRsvDaypriceVO.getTotAmt();
                        }
                    }

                    sendMessage += "       <RoomAndGuest>" +
                        "                     <RoomInformation>" +
                        "                        <RoomTypeCode>" + bookingVO.getPrdtNum() + "</RoomTypeCode>" +
                        "                        <RoomTypeName>" + bookingVO.getPrdtNm() + "</RoomTypeName>" +
                        "                        <RoomCategory />" +
                        "                        <ViewType/>" +
                        "                        <SmokingOrNonSmoking/>" +
                        "                        <PerRoomPaxCount>" + bookingVO.getAdNum() + "</PerRoomPaxCount>" +
                        "                        <RoomByRoomStatus/>" +
                        "                        <RoomByRoomConfirmationNumber/>" +
                        "                        <Facilities/>" +
                        "                        <AssignedRoomNumber/>" +
                        "                        <RoomSpecialRequest/>" +
                        "                        <RepresentativePersonName/>" +
                        "                     </RoomInformation>" +
                        "                     <!--1 or more repetitions:-->" +
                        "                     <RoomRateInformation>" +
                        "                        <RoomDate>" + systemDate.format(cal.getTime()) + "</RoomDate>" +
                        "                        <PerPaxRate/>" +
                        "                        <PerPaxFemaleRate/>" +
                        "                        <PerChildA70Rate/>" +
                        "                        <PerChildB50Rate/>" +
                        "                        <PerChildC30Rate/>" +
                        "                        <PerChildDNoneRate/>" +
                        "                        <RoomRatePaxMaleCount>" + bookingVO.getAdultNum() + "</RoomRatePaxMaleCount>" +
                        "                        <RoomRatePaxFemaleCount/>" +
                        getRoomRateChildTag(bookingVO.getJuniorAgeStdApicode(), bookingVO.getChildAgeStdApicode(), bookingVO.getJuniorNum(), bookingVO.getChildNum()) +
                        "                        <RoomPaxMaleRequest/>" +
                        "                        <RoomPaxFemaleRequest/>" +
                        "                        <RoomChildA70Request/>" +
                        "                        <RoomChildB50Request/>" +
                        "                        <RoomChildC30Request/>" +
                        "                        <RoomChildDNoneRequest/>" +
                        "                        <TotalPerRoomRate>" + totalPerRoomRate + "</TotalPerRoomRate>" +
                        "                        <TotalPerRoomConsumptionTax/>" +
                        "                        <TotalPerRoomHotSpringTax/>" +
                        "                        <TotalPerRoomHotelTax/>" +
                        "                        <TotalPerRoomServiceFee/>" +
                        "                        <TotalPerRoomBreakfastFee/>" +
                        "                        <TotalPerRoomOtherFee/>" +
                        "                        <TotalPerRoomComissionAmount/>" +
                        "                        <TotalPerRoomComissionConsumptionTax/>" +
                        "                     </RoomRateInformation>" +
                        "                     <GuestInformation>" +
                        "                        <!--1 or more repetitions:-->" +
                        "                        <GuestInformationList>" +
                        "                           <GuestNameSingleByte/>" +
                        "                           <GuestSurName/>" +
                        "                           <GuestGivenName/>" +
                        "                           <GuestMiddleName/>" +
                        "                           <GuestNamePrefix/>" +
                        "                           <GuestKanjiName/>" +
                        "                           <GuestGender/>" +
                        "                           <GuestAge/>" +
                        "                           <GuestDateOfBirth/>" +
                        "                           <GuestType/>" +
                        "                           <GuestShubetsu/>" +
                        "                           <GuestPhoneNumber/>" +
                        "                           <GuestEmergencyPhoneNumber/>" +
                        "                           <GuestEmail/>" +
                        "                           <GuestCountry/>" +
                        "                           <GuestStateProvidence/>" +
                        "                           <GuestCityName/>" +
                        "                           <GuestAddressLine/>" +
                        "                           <GuestStreetNumber/>" +
                        "                           <GuestPostalCode/>" +
                        "                           <GuestBuildingName/>" +
                        "                           <GuestFFPCarrier/>" +
                        "                           <GuestFFPNumber/>" +
                        "                           <GuestCoachNumber/>" +
                        "                           <SpecialInformation/>" +
                        "                        </GuestInformationList>" +
                        "                     </GuestInformation>" +
                        "                  </RoomAndGuest>";
                }
                sendMessage += "        </RoomAndGuestList>" +
                    "            </RoomInformationList>" +
                    "         </AllotmentBookingReport>" +
                    "      </setReserve>" +
                    "   </book:setReserve>" +
                    "</soapenv:Body>" +
                    "</soapenv:Envelope>";

                //System.out.println("-----------------sendMessage----------------------------");
                //System.out.println(sendMessage);

                StringReader reader = new StringReader(sendMessage);
                InputSource is = new InputSource(reader);
                Document document = parser.parse(is);
                DOMSource requestSource = new DOMSource(document);

                Map<String, String> soap = getSoapResult(requestSource);
                String soapResult = soap.get("soapResult");
                String soapSuccess = soap.get("successYN");

                // parser
                document = parser.parse(new InputSource(new StringReader(soapResult)));

                //booking 저장
                APITLBookingLogVO bookingLogVO = new APITLBookingLogVO();
                bookingLogVO.setDataId(bookingVO.getDataId());
                bookingLogVO.setRsvNum(rsvNum);
                bookingLogVO.setAdRsvNum(bookingVO.getAdRsvNum());
                bookingLogVO.setSeqNum("0");
                bookingLogVO.setRsvXml(sendMessage);
                bookingLogVO.setReturnXml(soapResult.replace("'", "\""));
                bookingLogVO.setSystemDate(systemDate.format(now));

                if (document.getElementsByTagName("faultcode").getLength() <= 0) { //성공
                    bookingLogVO.setRsvResult("Y");
                } else { //실패
                    bookingLogVO.setRsvResult("N");
                    bookingLogVO.setFaultReason(document.getElementsByTagName("faultcode").item(1).getFirstChild().getNodeValue());
                }

                //TimeOut
                if ("N".equals(soapSuccess)){
                    bookingLogVO.setRsvResult("N");
                    bookingLogVO.setFaultReason("TimeOut");
                }

                //전송 실패 시 알림톡 전송
                if ("N".equals(bookingLogVO.getRsvResult())) {
                    failAligoSend("예약전송 실패 : " + bookingLogVO.getFaultReason());
                }

                apiTlBookingDao.insertBookingLog(bookingLogVO);
                listBookingLogVO.add(bookingLogVO);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listBookingLogVO;
    }

    /**
    * 설명 : 취소 전송
    * 파일명 :
    * 작성일 : 2021-07-05 오후 6:07
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public APITLBookingLogVO bookingCancel(String adRsvNum) {

        APITLBookingLogVO bookingLogVO = new APITLBookingLogVO();
        try {
            APITLBookingLogVO apitlBookingLogVO = apiTlBookingDao.bookingCancel(adRsvNum);
            //TLL과 연동 업체인지 확인
            if("TLL".equals(getAdApiLinkNm(adRsvNum))) {
                if (apitlBookingLogVO != null) {
                    String sendMessage = apitlBookingLogVO.getRsvXml();
                    System.out.println("-------------------------bookingCancel logic Start-------------------------");
                    //Date Time Setting
                    Date now = new Date();
                    SimpleDateFormat systemDate = new SimpleDateFormat("yyyy-MM-dd");

                    //취소 getDataID
                    String dataId = apiTlBookingDao.getDataId();

                    //전송 전문을 불러와서 취소전문으로 수정
                    sendMessage = sendMessage.replace("<sequenceNum>0</sequenceNum>", "<sequenceNum>1</sequenceNum>");
                    sendMessage = sendMessage.replace("<status>Start</status>", "<status>End</status>");
                    sendMessage = sendMessage.replace("<DataClassification>NewBookReport</DataClassification>", "<DataClassification>CancellationReport</DataClassification>");
                    sendMessage = sendMessage.replace("<SystemDate>" + apitlBookingLogVO.getSystemDate() + "</SystemDate>", "<SystemDate>" + systemDate.format(now) + "</SystemDate>");
                    sendMessage = sendMessage.replace("<DataID>" + apitlBookingLogVO.getDataId() + "</DataID>", "<DataID>" + dataId + "</DataID>");

                    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                    factory.setNamespaceAware(true);
                    factory.setIgnoringElementContentWhitespace(true);
                    DocumentBuilder parser = factory.newDocumentBuilder();
                    StringReader reader = new StringReader(sendMessage);
                    InputSource is = new InputSource(reader);
                    Document document = parser.parse(is);
                    DOMSource requestSource = new DOMSource(document);

                    Map<String, String> soap = getSoapResult(requestSource);
                    String soapResult = soap.get("soapResult");
                    String soapSuccess = soap.get("successYN");

                    // parser
                    document = parser.parse(new InputSource(new StringReader(soapResult)));

                    //booking 저장
                    bookingLogVO.setDataId(dataId);
                    bookingLogVO.setRsvNum(apitlBookingLogVO.getRsvNum());
                    bookingLogVO.setAdRsvNum(adRsvNum);
                    bookingLogVO.setSeqNum("1");
                    bookingLogVO.setRsvXml(sendMessage);
                    bookingLogVO.setReturnXml(soapResult.replace("'", "\""));
                    bookingLogVO.setSystemDate(systemDate.format(now));

                    if (document.getElementsByTagName("faultcode").getLength() <= 0) { //성공
                        bookingLogVO.setRsvResult("Y");
                    } else { //실패
                        bookingLogVO.setRsvResult("N");
                        bookingLogVO.setFaultReason(document.getElementsByTagName("faultcode").item(1).getFirstChild().getNodeValue());

                    }
                    //TimeOut
                    if ("N".equals(soapSuccess)) {
                        bookingLogVO.setRsvResult("N");
                        bookingLogVO.setFaultReason("TimeOut");
                    }

                    //전송 실패 시 알림톡 전송
                    if ("N".equals(bookingLogVO.getRsvResult())) {
                        failAligoSend("취소전송 실패 : " + bookingLogVO.getFaultReason());
                    }

                } else {
                    bookingLogVO.setRsvResult("N");
                    failAligoSend("취소전송 실패 : 전송 내역이 존재 하지 않음.");
                }

                apiTlBookingDao.insertBookingLog(bookingLogVO);
            } else {
                //TLL 연동 업체가 아니면 Result = "Y" 로 취급
                bookingLogVO.setRsvResult("Y");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookingLogVO;
    }

    /**
    * 설명 : 전송 후 결과 return
    * 파일명 :
    * 작성일 : 2021-07-07 오후 5:35
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    private Map<String, String> getSoapResult(DOMSource requestSource) throws SOAPException {

        //전역변수
        String soapResult;
        String successYN;
        Map<String, String> resultMap = new HashMap<String, String>();

        //SOAPMessage create
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage requestSoapMessage = messageFactory.createMessage();
        SOAPPart requestSoapPart = requestSoapMessage.getSOAPPart();
        requestSoapPart.setContent(requestSource);

        //SOAPConnection create instance
        SOAPConnectionFactory scf = SOAPConnectionFactory.newInstance();
        SOAPConnection connection = scf.createConnection();

        try {
            String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
            String url =  "test".equals(CST_PLATFORM.trim()) ? "https://snt1dev.risapls.jp" : "https://w2.risapls.jp";
            URL endpoint =
                new URL(new URL(url),
                    "/rsdwn/services/setReserveServiceService?wsdl",
                    new URLStreamHandler() {
                        @Override
                        protected URLConnection openConnection(URL url) throws IOException {
                            URL target = new URL(url.toString());
                            URLConnection connection = target.openConnection();
                            // Connection settings
                            connection.setConnectTimeout(5000); // 5 sec
                            connection.setReadTimeout(30000); // 30 sec
                            return (connection);
                        }
                    }
                );

            SOAPMessage responseSoapMessage = null;
            try {
                //SOAP SEND MESSAGE
                System.out.println("------------send-----------------");
                responseSoapMessage = connection.call(requestSoapMessage, endpoint);

            } catch (Exception r) {
                try {
                    //SOAP SEND MESSAGE RETRY
                    System.out.println("--------------Retry send-----------------");
                    responseSoapMessage = connection.call(requestSoapMessage, endpoint);

                } catch (Exception e1) {
                    System.out.println("------------------재시도 실패-------------------");
                }
            }

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            responseSoapMessage.writeTo(out);
            soapResult = new String(out.toByteArray(), "UTF-8");
            successYN = "Y";
        } catch (Exception e) {
            soapResult = "<?xml version='1.0' encoding='UTF-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:book='http://www2.risapls.jp/BookingService'><soapenv:Header/><soapenv:Body>   <book:setReserve>      <setReserve>TimeOut</setReserve>   </book:setReserve></soapenv:Body></soapenv:Envelope>";
            successYN = "N";

        }
        resultMap.put("soapResult", soapResult);
        resultMap.put("successYN", successYN);
        return resultMap;
    }

    public String getTotalChildTag(String juniorType, String childType, int juniorCount, int childCount) {
        String totalChildTag;

        if ("CHILDA".equals(juniorType) && juniorCount > 0) {
            totalChildTag = "<TotalChildA70Count>" + juniorCount + "</TotalChildA70Count>";
        } else if ("CHILDA".equals(childType) && childCount > 0) {
            totalChildTag = "<TotalChildA70Count>" + childCount + "</TotalChildA70Count>";
        } else {
            totalChildTag = "<TotalChildA70Count/>";
        }

        if ("CHILDB".equals(juniorType) && juniorCount > 0) {
            totalChildTag += "<TotalChildB50Count>" + juniorCount + "</TotalChildB50Count>";
        } else if ("CHILDB".equals(childType)  && childCount > 0) {
            totalChildTag += "<TotalChildB50Count>" + childCount + "</TotalChildB50Count>";
        } else {
            totalChildTag += "<TotalChildB50Count/>";
        }

        if ("CHILDC".equals(juniorType) && juniorCount > 0) {
            totalChildTag += "<TotalChildC30Count>" + juniorCount + "</TotalChildC30Count>";
        } else if ("CHILDC".equals(childType)  && childCount > 0) {
            totalChildTag += "<TotalChildC30Count>" + childCount + "</TotalChildC30Count>";
        } else {
            totalChildTag += "<TotalChildC30Count/>";
        }

        if ("CHILDD".equals(juniorType) && juniorCount > 0) {
            totalChildTag += "<TotalChildDNoneCount>" + juniorCount + "</TotalChildDNoneCount>";
        } else if ("CHILDD".equals(childType)  && childCount > 0) {
            totalChildTag += "<TotalChildDNoneCount>" + childCount + "</TotalChildDNoneCount>";
        } else {
            totalChildTag += "<TotalChildDNoneCount/>";
        }

        return totalChildTag;
    }
    /**
     * 설명 : 호텔 설정에 따라 childA,B,C, D 태그 생성
     * 파일명 :
     * 작성일 : 2021-06-29 오전 9:28
     * 작성자 : chaewan.jung
     *
     * @param : juniorCount, childCount
     * @return : Tag
     * @throws Exception
     */
    public String getRoomRateChildTag(String juniorType, String childType, int juniorCount, int childCount) {

        String roomRateChildTag;

        if ("CHILDA".equals(juniorType) && juniorCount > 0) {
            roomRateChildTag = "<RoomRateChildA70Count>" + juniorCount + "</RoomRateChildA70Count>";
        } else if ("CHILDA".equals(childType) && childCount > 0) {
            roomRateChildTag = "<RoomRateChildA70Count>" + childCount + "</RoomRateChildA70Count>";
        } else {
            roomRateChildTag = "<RoomRateChildA70Count/>";
        }

        if ("CHILDB".equals(juniorType) && juniorCount > 0) {
            roomRateChildTag += "<RoomRateChildB50Count>" + juniorCount + "</RoomRateChildB50Count>";
        } else if ("CHILDB".equals(childType)  && childCount > 0) {
            roomRateChildTag += "<RoomRateChildB50Count>" + childCount + "</RoomRateChildB50Count>";
        } else {
            roomRateChildTag += "<RoomRateChildB50Count/>";
        }

        if ("CHILDC".equals(juniorType) && juniorCount > 0) {
            roomRateChildTag += "<RoomRateChildC30Count>" + juniorCount + "</RoomRateChildC30Count>";
        } else if ("CHILDC".equals(childType)  && childCount > 0) {
            roomRateChildTag += "<RoomRateChildC30Count>" + childCount + "</RoomRateChildC30Count>";
        } else {
            roomRateChildTag += "<RoomRateChildC30Count/>";
        }

        if ("CHILDD".equals(juniorType) && juniorCount > 0) {
            roomRateChildTag += "<RoomRateChildDNoneCount>" + juniorCount + "</RoomRateChildDNoneCount>";
        } else if ("CHILDD".equals(childType)  && childCount > 0) {
            roomRateChildTag += "<RoomRateChildDNoneCount>" + childCount + "</RoomRateChildDNoneCount>";
        } else {
            roomRateChildTag += "<RoomRateChildDNoneCount/>";
        }

        return roomRateChildTag;
    }

    /**
     * 설명 : 쿠폰 사용 내역 태그 생성 , LPOINT 사용 내역 태그 생성
     * 파일명 :
     * 작성일 : 2021-07-02 오후 17:41
     * 작성자 : chaewan.jung
     *
     * @param : rsvNum
     * @return : tag
     * @throws Exception
     */
    public String getPointTag(String adRsvNum) {

        String getPointTag = "";

        // LPOINT 사용 내역
        int lPoint = apiTlBookingDao.getUseLpoint(adRsvNum);

        if (lPoint > 0) {
            getPointTag +=
                "<PointsDiscountList>" +
                    "   <PointsDiv>2</PointsDiv>" +
                    "   <PointsDiscountName>LPOINT</PointsDiscountName>" +
                    "   <PointsDiscount>" + lPoint + "</PointsDiscount>" +
                    "</PointsDiscountList>";
        }

        //쿠폰 사용 내역
        List<USER_CPVO> listUseCp = apiTlBookingDao.selectByPoint(adRsvNum);
        if (!listUseCp.isEmpty()) {
            for (USER_CPVO userCpVO : listUseCp) {
                getPointTag +=
                    "<PointsDiscountList>" +
                        "   <PointsDiv>2</PointsDiv>" +
                        "   <PointsDiscountName>" + userCpVO.getCpNm() + "</PointsDiscountName>" +
                        "   <PointsDiscount>" + userCpVO.getDisAmt() + "</PointsDiscount>" +
                        "</PointsDiscountList>";
            }
        }

        //사용 내역이 없을 경우
        if (listUseCp.isEmpty() && lPoint <= 0) {
            getPointTag +=
                "<PointsDiscountList>" +
                    "   <PointsDiv/>" +
                    "   <PointsDiscountName/>" +
                    "   <PointsDiscount>0</PointsDiscount>" +
                    "</PointsDiscountList>";
        }

        return getPointTag;
    }

    /**
    * 설명 : API연동 유무 체크
    * 파일명 :
    * 작성일 : 2021-07-19 오후 1:57
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public String getAdApiLinkNm(String adRsvNum) {
        return apiTlBookingDao.getAdApiLinkNm(adRsvNum);
    }

    /**
    * 설명 : 연동 실패 시 RS01로 변경
    * 파일명 :
    * 작성일 : 2021-07-15 오전 11:28
    * 작성자 : chaewan.jung
    * @param : String adRsvNum
    * @return : void
    * @throws Exception
    */
    public void chgAdRsvStatus(String adRsvNum) {
        apiTlBookingDao.chgAdRsvStatus(adRsvNum);
    }

    /**
    * 설명 : TLL 전송 실패 시 알림톡 발송 -> 실패시 대체문자 발송 Y
    * 파일명 :
    * 작성일 : 2024-07-02 오후 1:50
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public void failAligoSend(String errMsg){
        String[] receivers = {Constant.TAMNAO_TESTER1,Constant.TAMNAO_TESTER2};
        String[] recvNames = {Constant.TAMNAO_TESTER_NAME1,Constant.TAMNAO_TESTER_NAME2};

        APIAligoVO aligoVO = new APIAligoVO();
        aligoVO.setTplCode("TT_6610");
        aligoVO.setReceivers(receivers);
        aligoVO.setRecvNames(recvNames);
        aligoVO.setSubject("[시스템]TLL 전송 실패");
        aligoVO.setMsg("[긴급] TLL 전송 실패\n" +
            "아래와 같은 사유로 TLL 전송이 실패 하였습니다.\n" +
            errMsg);
        aligoVO.setFailover("Y"); //대체문자발송여부

        apiAligoService.aligoKakaoSend(aligoVO);
    }
}
