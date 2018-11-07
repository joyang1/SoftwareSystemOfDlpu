/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.post;

import com.javabean.login.Login;
import com.javabean.post.Post;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * 1.doPost将用户发帖记录到数据库
 *
 * 2.doGet将数据库中的帖子读出来发送给前台页面
 *
 * @author 挺
 */
public class PostServlet extends HttpServlet {

    private Post p;
    private Login lg;
    private int pageCount; //总页数
    private final int PostofOnePage = 4; //每页显示2条帖子
    private int pageNow = 1; //当前页

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");
        request.setCharacterEncoding("utf-8");
        p = new Post();
        int length = p.getLength();
        int[] pid = new int[length];
        pid = p.getId();
        pageCount = p.getPageCount(length, PostofOnePage);
        String spageNow = request.getParameter("pageNow");
        if (spageNow != null) {
            if (spageNow.matches("^[0-9]*$")) {  //判断是否是数字字符串
                pageNow = Integer.parseInt(spageNow);
            } else {
                response.sendRedirect("PostServlet");  //
                return;
            }
        }
        if (pageNow > pageCount) {
            pageNow = pageCount;
        } else if (pageNow < 1) {
            pageNow = 1;
        }
        String[] name = new String[length];
        String[] content = new String[length];
        String[] owner = new String[length];
        String[] time = new String[length];
        int startpost = length - 1 - PostofOnePage * (pageNow - 1); //每页开始帖子的序号
        int stoppost = length - PostofOnePage * pageNow; //每页结束帖子的序号
        for (int i = startpost; i >= stoppost; i--) {
            name[i] = p.getName(pid[i]);
            content[i] = p.getContent(pid[i]);
            owner[i] = p.getOwner(pid[i]);
            time[i] = p.getTime(pid[i]);
            //request.setAttribute("pid"+i, pid[i]);
            request.setAttribute("name" + i, name[i]);
            request.setAttribute("content" + i, content[i]);
            request.setAttribute("owner" + i, owner[i]);
            request.setAttribute("time" + i, time[i]);
            if (stoppost < 0) {
                stoppost = 0;
            }
        }
        request.setAttribute("length", length);
        request.setAttribute("startpost", startpost);
        request.setAttribute("stoppost", stoppost);
        request.setAttribute("pageCount", pageCount);
        request.setAttribute("pageNow", pageNow);
        request.getRequestDispatcher("post/post.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
