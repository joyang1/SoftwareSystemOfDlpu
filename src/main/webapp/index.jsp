<%-- 
    Document   : index
    Created on : 2014-3-4, 18:56:47
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="images/b128.png" rel="icon" type="images/x-ico"/>
        <title></title>
    </head>
    <body>
        <%
            session.setAttribute("user", "");
            session.setAttribute("userpower", "0");
            response.sendRedirect("JudgeServlet?judge="+1+"");
        %>
    </body>
</html>
