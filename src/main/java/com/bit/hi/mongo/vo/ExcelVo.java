package com.bit.hi.mongo.vo;

public class ExcelVo {
	private int rn;
	private String videoOriginName;
	private String videoDate;
	private int total_grade;
	
	public ExcelVo() {
		super();
	}

	public ExcelVo(int rn, String videoOriginName, String videoDate, int total_grade) {
		this.rn = rn;
		this.videoOriginName = videoOriginName;
		this.videoDate = videoDate;
		this.total_grade = total_grade;
	}

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

	public String getVideoOriginName() {
		return videoOriginName;
	}

	public void setVideoOriginName(String videoOriginName) {
		this.videoOriginName = videoOriginName;
	}

	public String getVideoDate() {
		return videoDate;
	}

	public void setVideoDate(String videoDate) {
		this.videoDate = videoDate;
	}

	public int getTotal_grade() {
		return total_grade;
	}

	public void setTotal_grade(int total_grade) {
		this.total_grade = total_grade;
	}

	@Override
	public String toString() {
		return "ExcelVo [rn=" + rn + ", videoOriginName=" + videoOriginName + ", videoDate=" + videoDate
				+ ", total_grade=" + total_grade + "]";
	}
	
	
	
}
