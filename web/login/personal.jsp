<%-- 
    Document   : personal
    Created on : 2014-5-20, 19:31:18
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="images/b128.png" rel="icon" type="images/x-ico"/>
        <title>个人信息</title>
    <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 400px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }
    
    </style>
    <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">
    </head>
    <body background="<%=cp%>/img/bg1.jpg">
        <%
            String[] usercontent = new String[8];
            for(int i=0; i<usercontent.length; i++){
                usercontent[i] = request.getAttribute("usercontent"+i).toString();
            }
        %>
     <div class="container">
         <a href="<%=cp%>/JudgeServlet?judge=1">返回主页</a> <h1>个人信息</h1>
        <table class="table table-striped">
            <tr><td>用户名:<%=usercontent[0]%></td><td>真实姓名:<%=usercontent[1]%></td></tr>
            <tr><td>年龄:<%=usercontent[2]%></td><td>性别:<%=usercontent[3]%></td></tr>
            <tr><td>学院:<%=usercontent[4]%></td><td>专业:<%=usercontent[5]%></td></tr>
            <tr><td>班级:<%=usercontent[6]%></td><td>学号:<%=usercontent[7]%></td></tr>
        <table>
     </div>        
      </body>
</html>
