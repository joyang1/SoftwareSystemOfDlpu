
package com.servlet.login;

import com.javabean.login.Login;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *检查用户名是否存在
 * 
 * @author 挺
 */
public class CheckServlet extends HttpServlet {
    private Login lg;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String name = request.getParameter("username");
        lg = new Login();
        int length = lg.getLength();
        String[] username = new String[length];
        username = lg.getUsername();
        boolean flag = false;
        for (int i = 0; i < length; i++) {
           if(name.equals(username[i])){
               flag = true;
               if(flag){
                   break;
               }
           }
        }
        //.println(username[0]);
        out.println("{\"id\":\""+flag+"\"}");
        
    }

}
