/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.news;

import com.javabean.news.GetNews;
import com.yt.getTime.GetTime;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * 1.doGet将数据库中的新闻读出来发送给前台页面
 * 
 * 2.doPost将管理员添加的新闻写进数据库
 * 
 * @author 挺
 */
public class NewsServlet extends HttpServlet {

    private GetNews gn;
    private int allnewscount;
    private int pageCount; //总页数
    private final int NewsofOnePage = 10; //每页显示10条新闻
    private int pageNow=1; //当前页

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        gn = new GetNews();
        allnewscount = gn.getAllNewsCount();
        pageCount = gn.getPageCount(allnewscount, NewsofOnePage);
        String spageNow = request.getParameter("pageNow");
        if(spageNow != null){
            if (spageNow.matches("^[0-9]*$")) {  //判断是否是数字字符串
                pageNow = Integer.parseInt(spageNow);
            } else {
                response.sendRedirect("NewsServlet");  //
                return;
            }
        }
        //防止有人有意攻击网站
        if(pageNow > pageCount){
            //将别人直接通过网站输入一些较大的数攻击，直接将该数赋值给最后一页
            pageNow = pageCount;
        }else if(pageNow < 1){
            pageNow = 1;
        }
        String[] title = new String[allnewscount];
        String[] time = new String[allnewscount];
        int[] id = new int[allnewscount];
        id = gn.getId();
        int startnews = allnewscount-1-NewsofOnePage*(pageNow-1); //每页开始新闻的序号
        int stopnews =  allnewscount-NewsofOnePage*pageNow; //每页结束新闻的序号
        for (int i = startnews; i >= stopnews; i--) {
            title[i] = gn.getTitle(id[i]);
            time[i] = gn.getTime(id[i]);
            request.setAttribute("title" + i, title[i]);
            request.setAttribute("time" + i, time[i]);
            if(stopnews < 0){
                stopnews = 0;
            }
        }
        request.setAttribute("pageCount",  pageCount);
        request.setAttribute("startnews", startnews);
        request.setAttribute("stopnews", stopnews);
        request.setAttribute("pageNow",  pageNow);
        request.setAttribute("allnewscount", allnewscount);
        request.getRequestDispatcher("news/news.jsp").forward(request, response);
//        out.println(title[allnewscount-1]);
//        out.println(id[0] + "");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        
        gn = new GetNews();
        String title = request.getParameter("news_title");
        String content = request.getParameter("news_content");
        String time = GetTime.getTime();
        if (gn.addnews(title, content, time)) {
            out.write("<script>alert(\"添加成功\");</script>");
            response.sendRedirect("admin/news/addnews.jsp");
        } else {
            out.println("添加失败");
        }
    }

}
