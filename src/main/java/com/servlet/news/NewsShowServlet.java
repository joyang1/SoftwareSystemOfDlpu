/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.news;

import com.javabean.news.GetNews;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 挺
 */
public class NewsShowServlet extends HttpServlet {

    private GetNews gn;
    private int allnewscount;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        gn = new GetNews();
        allnewscount = gn.getAllNewsCount();
        String[] content = new String[allnewscount];
        String[] title = new String[allnewscount];
        int[] id = new int[allnewscount];
        id = gn.getId();
        //从前台传过来的id
        int tid = Integer.parseInt(request.getParameter("id"));
        for (int i = allnewscount - 1; i >= 0; i--) {
            title[i] = gn.getTitle(id[i]);
            content[i] = gn.getContent(id[i]);
        }
        request.setAttribute("title" , title[tid]);
        request.setAttribute("content" , content[tid]);
        if(id.length>0){
            request.getRequestDispatcher("showpage/newspage.jsp").forward(request, response);
        }

    }

}
