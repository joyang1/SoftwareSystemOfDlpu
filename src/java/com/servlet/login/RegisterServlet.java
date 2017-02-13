package com.servlet.login;

import com.javabean.login.Login;
import com.yt.check.CheckCode;
import com.yt.md5.MD5;
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
public class RegisterServlet extends HttpServlet {

    private Login lg;
    private HttpSession session;
    private CheckCode ck;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String name = request.getParameter("u_name");  
        //编码统一，这是一种比较麻烦的办法，还有一种比较简单的，后面其它地方有用
        String password = request.getParameter("u_passwd");
        String dbpasswd = MD5.GetMD5Code(password);
        String realname = request.getParameter("u_realname");
        int age = Integer.parseInt(request.getParameter("u_age"));
        String sex = request.getParameter("u_sex");
        String address = request.getParameter("u_address");
        //String hpicture = new String(request.getParameter("u_hpicture").getBytes("iso-8859-1"), "UTF-8");
        String institute = request.getParameter("u_institute");
        String major = request.getParameter("u_major");
        String grade = request.getParameter("u_class");
        String studentid = request.getParameter("u_studentid");
        String email = request.getParameter("u_email");
        String code = request.getParameter("code");
        session = request.getSession();
        String rcode = (String) session.getAttribute("validateCode");
        lg = new Login();
        ck = new CheckCode();
        if (ck.checkcode(code, rcode)) {
            if (lg.adduser(name, dbpasswd, realname, age, sex, address, "123", institute, major, grade, studentid, email)) {
                //out.println("注册成功");
                response.sendRedirect("login/login.jsp");
            } else {
                out.println("注册失败");
                //response.sendRedirect("../login/Error.jsp");
            }
        } else {
            out.println("注册失败");
        }

    }

}
