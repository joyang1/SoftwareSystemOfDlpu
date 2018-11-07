<%-- 
    Document   : error
    Created on : 2014-10-26, 16:04:03
    Author     : 小小一
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String error = request.getParameter("error");
            String album_id = request.getParameter("id");
            if (error.equals("t_m")) {
                out.println("<tr><td class=\"warning\">该图片已存在！</td></tr>");
                out.println("<tr><td class=\"warning\"><a href= \"../ShowAlbumServlet?album_id="+ album_id +"\" />点此返回</a></td></tr>");
            } else if (error.equals("u_p")) {
                out.println("<tr><td class=\"warning\">用户名或密码错误！</td></tr>");
                out.println("<tr><td class=\"warning\"><a href= \"../login/login.jsp\" />点此返回</a></td></tr>");
            } else if (error.equals("y_z")) {
                out.println("<tr><td class=\"warning\">验证码错误！</td></tr>");
                out.println("<tr><td class=\"warning\"><a href= \"../login/login.jsp\" />点此返回</a></td></tr>");
            }
        %>
    </body>
</html>
