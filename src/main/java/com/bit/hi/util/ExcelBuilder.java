package com.bit.hi.util;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.bit.hi.mongo.vo.ExcelVo;

//아파치 POI 라이브러리를 이용하여 엑셀파일을 생성하는 클래스
public class ExcelBuilder extends AbstractXlsView { //AbstractExcelView를 상속받아야 함.
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		List<ExcelVo> listInterviews = (List<ExcelVo>)model.get("VideoLists");
		
		//엑셀 sheet 만들기
		Sheet sheet = workbook.createSheet("자바책");
		sheet.setDefaultColumnWidth(20);
		
		// 셀 스타일 지정
		CellStyle style = workbook.createCellStyle();
		
		// 폰트 지정
		Font font = workbook.createFont();
		font.setFontName("맑은고딕");
		
		style.setFillForegroundColor(HSSFColor.GREEN.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		font.setBold(true);
		font.setColor(HSSFColor.WHITE.index);

		
		style.setFont(font); //스타일에 폰트를 설정
		
		// 타이틀 행(row)을 추가
		Row title = sheet.createRow(0); //첫번째 행은 무조건 0 (1이 아님)
		
		title.createCell(0).setCellValue("번호"); //첫번째 열 (첫번째 열도 무조건 0)
		title.getCell(0).setCellStyle(style);
		
		title.createCell(1).setCellValue("제목"); //두번째 열
		title.getCell(1).setCellStyle(style);
		
		title.createCell(2).setCellValue("날짜"); //세번째 열
		title.getCell(2).setCellStyle(style);
		
		title.createCell(3).setCellValue("점수"); //네번째 열
		title.getCell(3).setCellStyle(style);
		
		// 이전에 만들었던 책 데이타 행을 추가
		int rowCnt = 1;
		
		for(ExcelVo excelVo : listInterviews){
			Row row = sheet.createRow(rowCnt++); //한바퀴 돌고나서 2가 됨.
			row.createCell(0).setCellValue(excelVo.getRn());
			row.createCell(1).setCellValue(excelVo.getVideoOriginName());
			row.createCell(2).setCellValue(excelVo.getVideoDate());
			row.createCell(3).setCellValue(excelVo.getTotal_grade());		
		}//for
	}
}
