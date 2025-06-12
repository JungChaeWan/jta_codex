package common;

/*Update 
 * V1.1B190429 �Ǹ� API : branch_id �ʵ� �߰� by wschoi 
 * 
 */
public class NmcConstants {
	
	public static final String NMC_LIB_VERSION= "NMCLITEV1.2B190510";	// ����
	
	public static final int SERVER_TIMEOUT_MILL=  25000;

	public static final String NMC_SERVER_DOMAIN = "https://api.nmcs.co.kr";	//� ���� 
	public static final String TEST_NMC_SERVER_DOMAIN = "http://devapi.nmcs.co.kr";	//���� ����

	public static final String NMC_ORDER = "/payment/order.do";	//�ֹ�
	public static final String NMC_APPROVAL = "/payment/approval.do";	//����
	public static final String NMC_APPROVAL_CANCEL = "/payment/cancel.do";	//�������
	public static final String NMC_ORDER_SEARCH = "/payment/inquiry.do";	//�ֹ�������ȸ
	public static final String NMC_REPAY = "/payment/repay.do";	//�����
	
	public static final String API_ERR_4001_CODE = "4001";
	public static final String API_ERR_4001_MSG = "��û���� ��������";
	
	public static final String API_ERR_4002_CODE = "4002";
	public static final String API_ERR_4002_MSG = "��ȣȭ ��������";
	
	public static final String API_ERR_4003_CODE = "4003";
	public static final String API_ERR_4003_MSG = "��ȣȭ ��������";
	
	public static final String API_ERR_4004_CODE = "4004";
	public static final String API_ERR_4004_MSG = "���������� ����ġ";
	
	
	public static final String API_ERR_5001_CODE = "5001";
	public static final String API_ERR_5001_MSG = "���� �������(Timeout)";

	public static final String API_ERR_5002_CODE = "5002";
	public static final String API_ERR_5002_MSG = "���� ���ſ���(Server Internal Error)";
	
	public static final String API_ERR_5003_CODE = "5003";
	public static final String API_ERR_5003_MSG = "���� ���ſ���";
	
	public static final String API_ERR_5004_CODE = "5004";
	public static final String API_ERR_5004_MSG = "���� ��ſ���";
	
	public static final String API_ERR_6001_CODE = "6001";
	public static final String API_ERR_6001_MSG = "���䵥���� �Ľ̿���";
	
}
