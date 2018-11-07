/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.exam;

import com.yt.connectdb.dbOperator;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 挺
 */
public class ExamDownLoadServlet extends HttpServlet {

    private dbOperator db = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/x-msdownload");
        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "select exam_title,exam_path from exam where exam_id=" + id;
        db = new dbOperator();
        String fileName = "";
        String filePath = "";
        ResultSet rs = db.getRs(sql);
        try {
            if (rs.next()) {
                fileName = rs.getString(1);
                filePath = rs.getString(2);
            }
            rs.close();
        } catch (SQLException ex) {

        }
        response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName, "UTF-8"));
        OutputStream outStream = response.getOutputStream();
        InputStream inStream = new FileInputStream(filePath);
        
        byte[] buffer = new byte[1024];
        int len = 0;
        while((len = inStream.read(buffer))!=-1){
            outStream.write(buffer, 0, len);
        }
        inStream.close();
     }

}
