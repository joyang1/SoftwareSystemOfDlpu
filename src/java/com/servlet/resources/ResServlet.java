/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.resources;

import com.javabean.login.Login;
import com.javabean.news.GetNews;
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
public class ResServlet extends HttpServlet {

    private dbOperator db = null;
    private GetNews gn = null;
    private int pageCount; //总页数
    private int pageSize;
    private final int NumofOnePage = 3; //每页显示10条新闻
    private int pageNow = 1; //当前页

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
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String Str_pageNow = request.getParameter("pageNow");
        gn = new GetNews();
        db = new dbOperator();
        ResultSet rs1 = db.getRs("select * from resources");
        try {
            rs1.last();
            pageSize = rs1.getRow();
            rs1.close();
        } catch (SQLException e) {

        }

        pageCount = gn.getPageCount(pageSize, NumofOnePage);
        if (Str_pageNow != null) {
            if (Str_pageNow.matches("^[0-9]*$")) {  //判断是否是数字字符串
                pageNow = Integer.parseInt(Str_pageNow);
            } else {
                pageNow=1;
            }
            if (pageNow > pageCount) {
                pageNow = pageCount;
            }
            if (pageNow < 1) {
                pageNow = 1;
            }
        }

        ResultSet rs = db.getRs("select * from resources limit " + (pageNow - 1) * NumofOnePage + "," + NumofOnePage + "");
        try {
            rs.last();
            int rows = rs.getRow();
            request.setAttribute("rows", rows);
            if (rows > 0) {
                rs.beforeFirst();
                Integer[] id = new Integer[rows];
                String[] title = new String[rows];
                String[] content = new String[rows];
                int i = 0;
                while (rs.next()) {
                    id[i] = rs.getInt("r_id");
                    title[i] = rs.getString("r_title");
                    content[i] = rs.getString("r_content");
                    request.setAttribute("id" + i, id[i]);
                    request.setAttribute("title" + i, title[i]);
                    request.setAttribute("content" + i, content[i]);
                    i++;
                }
                rs.close();
                request.setAttribute("pageNow", pageNow);
                request.setAttribute("pageCount", pageCount);
            } else {
                request.setAttribute("no", "暂时还没有资源......");
            }
            request.getRequestDispatcher("resources/resources.jsp").forward(request, response);
        } catch (SQLException ex) {

        }
    }

}
