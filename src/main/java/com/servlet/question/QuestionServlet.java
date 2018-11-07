/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.question;

import com.javabean.login.Login;
import com.javabean.question.Question;
import com.yt.getTime.GetTime;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 挺
 */
public class QuestionServlet extends HttpServlet {

    private Login lg;
    private HttpSession session;
    private Question qt;

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
        response.setContentType("text/html; charset=utf-8");
        //PrintWriter out = response.getWriter();
        qt = new Question();
        int length = qt.getLength();
        if (length > 0) {
            int[] id = new int[length];
            id = qt.getId();
            String[] qcontent = new String[length];
            String[] qowner = new String[length];
            String[] qtime = new String[length];
            for (int i = length - 1; i >= 0; i--) {
                qcontent[i] = qt.getContent(id[i]);
                qowner[i] = qt.getOwner(id[i]);
                qtime[i] = qt.getTime(id[i]);

                request.setAttribute("qcontent" + i, qcontent[i]);
                request.setAttribute("qowner" + i, qowner[i]);
                request.setAttribute("qtime" + i, qtime[i]);
                request.setAttribute("id" + i, id[i]);
                //out.print(length+qcontent[i]+qowner[i]+qtime[i]);
            }
        }
        request.setAttribute("length", length);
        request.getRequestDispatcher("question/question.jsp").forward(request, response);
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
        response.setContentType("text/html; charset=utf-8");
        request.setCharacterEncoding("utf-8");
        session = request.getSession();
        String owner = session.getAttribute("user").toString();
        lg = new Login();
        String realowner = lg.getRealname(owner);
        String content = request.getParameter("q_content");
        if(content.equals("")){
            response.sendRedirect("QuestionServlet");
            return;
        }
        String time = GetTime.getTime();
        qt = new Question();
        if (qt.addquestion(owner, realowner, content, time)) {
            response.sendRedirect("QuestionServlet");
        } else {
            //error界面
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
