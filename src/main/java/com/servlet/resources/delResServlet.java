/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.resources;

import com.yt.connectdb.dbOperator;
import com.yt.utils.DeleteFileUtils;
import java.io.IOException;
import java.io.PrintWriter;
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
public class delResServlet extends HttpServlet {
    private dbOperator db = null;
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        String data = "";
        int id = Integer.parseInt(request.getParameter("id"));
        String sql1 = "select r_path from resources where r_id=" + id + "";
        String sql = "delete from resources where r_id=" + id + "";
        db = new dbOperator();
        ResultSet rs = db.getRs(sql1);
        try {
            if (rs.next()) {
                if (DeleteFileUtils.delete(rs.getString(1))) {
                    if (db.SqlQuery(sql) != 0) {
                        data = "{\"data\":\"1\"}";
                    } else {
                        data = "{\"data\":\"0\"}";
                    }
                }
                rs.close();

            }
        } catch (SQLException e) {
        }

        out.write(data);

    }

}
