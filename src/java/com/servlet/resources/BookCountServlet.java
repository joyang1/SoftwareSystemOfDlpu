/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.resources;

import com.javabean.login.Login;
import com.javabean.resources.Resources;
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
public class BookCountServlet extends HttpServlet {

    private Resources resources = null;
    private Login lg = null;
    private String datas = ""; //响应的数据
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();    
        HttpSession session = request.getSession();
        lg = new Login(); 
        resources = new Resources();
        
        String bnumber = request.getParameter("bid");
        String realname = lg.getRealname(session.getAttribute("user").toString());
        String corrSql = "select count(*) from borrow_book where book_id = "+resources.getBid(bnumber)+" and borrow_time='"+GetTime.getTime()+"' and borrow_realname='"+realname+"'";
//        System.out.println(resources.IsNull(corrSql));
        if(!resources.IsNull(corrSql)){
            datas = "{\"data\":\"2\"}";  //已经借阅过
            out.write(datas);
            return;
        }
        
        String sql = "insert into borrow_book values("+null+",'"+realname+"','"+GetTime.getTime()+"',"+resources.getBid(bnumber)+")"; 
        if(resources.IsBorrow(bnumber) && resources.insert(sql) != 0){
            datas = "{\"data\":\"0\"}";  //借阅成功
        }else{
            datas = "{\"data\":\"1\"}";  //借阅失败
        }
        out.write(datas);
    }

}
