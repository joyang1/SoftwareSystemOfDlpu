/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.exam;

import com.yt.connectdb.dbOperator;
import java.io.IOException;
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
public class ExamListServlet extends HttpServlet {

    private dbOperator db = null;

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charest=utf-8");
        String sql = "select * from exam";
        db = new dbOperator();
        ResultSet rs = db.getRs(sql);
        try {
            rs.last();
            int rows = rs.getRow();
            request.setAttribute("rows",rows);
            if (rows > 0) {
                Integer[] list_id = new Integer[rows];
                String[] list_name = new String[rows];
                String[] list_content = new String[rows];

                rs.beforeFirst();
                int i = 0;
                while (rs.next()) {
                    list_id[i] = rs.getInt("exam_id");
                    list_name[i] = rs.getString("exam_name");
                    list_content[i] = rs.getString("exam_content");
                    request.setAttribute("list_id" + i, list_id[i]);
                    request.setAttribute("list_name" + i, list_name[i]);
                    request.setAttribute("list_content" + i, list_content[i]);
                    i++;
                }
                rs.close();

            } else {
                request.setAttribute("error", "答题系统未开放!");
            }
            request.getRequestDispatcher("test/wordforexam.jsp").forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        }

    }

}
