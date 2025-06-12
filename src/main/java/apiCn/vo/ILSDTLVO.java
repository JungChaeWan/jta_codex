package apiCn.vo;


public class ILSDTLVO {

	// 차량 코드
	private String code;
	
	// 차량명
	private String name;
	
	// 차종구분 01:경차, 02:소형차, 03:중형차, 04:고급차, 05:RV/SUV차, 06:승합차
	private String gubun;
	
	// 기어 M:수동, A:자동
	private String gear;
	
	// 제조사 01:현대, 02:기아, 03:르노삼성, 04:쌍용, 05:GM대우, 06:외제
	private String maker;

	// 연료타입 G:휘발유, D:경유, L:LPG
	private String fuel;
	
	// 배기량
	private String baegi;
	
	// 승차정원
	private String jeongwon;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getGear() {
		return gear;
	}

	public void setGear(String gear) {
		this.gear = gear;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getFuel() {
		return fuel;
	}

	public void setFuel(String fuel) {
		this.fuel = fuel;
	}

	public String getBaegi() {
		return baegi;
	}

	public void setBaegi(String baegi) {
		this.baegi = baegi;
	}

	public String getJeongwon() {
		return jeongwon;
	}

	public void setJeongwon(String jeongwon) {
		this.jeongwon = jeongwon;
	}

}