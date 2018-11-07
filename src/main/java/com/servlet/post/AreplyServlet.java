/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.post;

import com.javabean.login.Login;
import com.javabean.post.Areply;
import com.javabean.post.PostReply;
import com.yt.getTime.GetTime;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * doGet()将数据库中的表areply表中的数据读出显示到前台
 *
 * doPost()接受前台的追加评论并添加到数据库表areply中
 *
 * @author 挺
 */
public class AreplyServlet extends HttpServlet {

    private PostReply pr = null;
    private Areply ar = null;
    private Login lg = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        pr = new PostReply();
        ar = new Areply();
        int rid = Integer.parseInt(request.getParameter("rid"));
        String rowner = pr.getReplyOwner(rid);
        String rcontent = pr.getReplyContent(rid);
        int areplycount = ar.getAreplyCount(rid);
        if (areplycount > 0) {
            int[] arid = new int[areplycount];
            arid = ar.getAreplyId(rid);
            String[] owner = new String[areplycount];
            String[] acontent = new String[areplycount];
            String[] time = new String[areplycount];
            for (int i = areplycount - 1; i >= 0; i--) {
                owner[i] = ar.getAreplyOwner(arid[i]);
                acontent[i] = ar.getAreplyContent(arid[i]);
                time[i] = ar.getAreplyTime(arid[i]);
                request.setAttribute("owner" + i, owner[i]);
                request.setAttribute("acontent" + i, acontent[i]);
                request.setAttribute("time" + i, time[i]);
                //out.println(owner[i]+acontent[i]+time[i]);
            }            
        }
        request.setAttribute("areplycount", areplycount);
        request.setAttribute("rid", rid);
        request.setAttribute("rowner", rowner);
        request.setAttribute("rcontent", rcontent);
        //out.println(areplycount+"");
        request.getRequestDispatcher("post/areply.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        ar = new Areply();
        lg = new Login();
        HttpSession session = request.getSession();
        int rid = Integer.parseInt(request.getParameter("rid"));
        String owner = session.getAttribute("user").toString();
        String realowner = lg.getRealname(owner);
        String acontent = request.getParameter("acontent");
        String time = GetTime.getTime();

        if (ar.addareply(owner, realowner, acontent, time, rid)) {
            response.sendRedirect("AreplyServlet?rid=" + rid);
        } else {
  
        }

    }

}
