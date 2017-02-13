/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.question;

import com.javabean.question.QtReply;
import com.javabean.question.Question;
import com.yt.getTime.GetTime;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 挺
 */
public class QtReplyServlet extends HttpServlet {

    private Question qt;
    private QtReply qtr;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
    }

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        int qid = Integer.parseInt(request.getParameter("qid"));
        qt = new Question();
        qtr = new QtReply();
        String qcontent = qt.getContent(qid);
        String qowner = qt.getOwner(qid);
        String qtime = qt.getTime(qid);
        request.setAttribute("qcontent", qcontent);
        request.setAttribute("qowner",qowner);
        request.setAttribute("qtime",qtime);
        request.setAttribute("qid",qid);
        
        int count = qtr.getReplyCount(qid);
        if(count > 0){
            int[] rid = new int[count];
            rid = qtr.getId(qid);
            String[] rcontent = new String[count];
            String[] rowner = new String[count];
            String[] rtime = new String[count];
            for(int i=count-1; i>=0; i--){
                rcontent[i] = qtr.getContent(rid[i]);
                rowner[i] = qtr.getAdmin(rid[i]);
                rtime[i] = qtr.getTime(rid[i]);
                request.setAttribute("rcontent"+i, rcontent[i]);
                request.setAttribute("rowner"+i, rowner[i]);
                request.setAttribute("rtime"+i, rtime[i]);
                //out.println(rcontent[i]+rowner[i]+rtime[i]+count);
            }
        }       
        request.setAttribute("count", count);
        request.getRequestDispatcher("question/question_reply.jsp").forward(request, response);
    }

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
        int qid = Integer.parseInt(request.getParameter("qid"));
        String content = request.getParameter("q_content");
        String user = request.getSession().getAttribute("user").toString();
        String time = GetTime.getTime();
        
        qtr = new QtReply();
        if(qtr.addqtreply(user, content, time, qid)){
            response.sendRedirect("QtReplyServlet?qid="+qid);
        }else{
            //
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
