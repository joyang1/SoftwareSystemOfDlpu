/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.yt.utils;

import com.javabean.exam.score;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

/**
 *
 * @author 挺
 */
public class ExcelUtils {

    public static List<score> readExceltoDB(String filepath) {
        List<score> list = new ArrayList<score>();
        try {
            FileInputStream inStream = new FileInputStream(filepath);
            POIFSFileSystem poi = new POIFSFileSystem(inStream);
            HSSFWorkbook workbook = new HSSFWorkbook(poi);//创建excel工作簿对象
            HSSFSheet sheet = workbook.getSheetAt(0);//获取第一个工作表
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                score s = new score();
                HSSFRow row = sheet.getRow(i);   //获取第i行
                HSSFCell cell1 = row.getCell((short) 0);
                HSSFCell cell2 = row.getCell((short) 1);
                HSSFCell cell3 = row.getCell((short) 2);
                s.setSno(cell1.getStringCellValue());
                s.setName(cell2.getStringCellValue());
                s.setScore((int) cell3.getNumericCellValue());
                list.add(s);
            }
            inStream.close();
            return list;
        } catch (IOException ex) {
            Log.write(System.currentTimeMillis() + "：" + ex.getMessage());
            return null;
        }
    }
}
