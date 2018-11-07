<%-- 
    Document   : addpicture
    Created on : 2014-5-14, 19:34:21
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath(); //获得当前web的根路径
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=cp%>/images/b128.png" rel="icon" type="images/x-ico"/>
        <title>提交试卷</title>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
                text-align: center;
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-signin {
                max-width: 300px;
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
            a{
                float: left;
                margin-left: 100px;
            }
            .brand{
                text-align: center;
            }
        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">        
    </head>
    <body background="<%=cp%>/img/bg1.jpg">
        <%
            //判断session值是否有效,或者以防用户直接输地址

            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
            if (user == "" || user == null) {
                response.sendRedirect("login/login.jsp");
                return;
            }
        %>
        <!--导航开始-->
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <a class="brand" href="<%=cp%>/ExamListServlet">返回</a>
                <h4 class="form-signin-heading">提交试卷</h4>
            </div>
        </div>
        <!--导航结束-->

        <!--上传的<input type=file>标记一定要有name,如果没有，commons fielupload不作处理。-->
        
        <br/><br/>
        <p style="color:red; font-size: 18px;">${message}</p>
        <form action="<%=cp%>/uploadExamServlet" method="post" enctype="multipart/form-data" class="form-signin">
            <p>用户名:<%=user%></p>
            <input type="file" placeholder="选择你要上传的word文档" class="input-block-level" name="word" size="20"><br/>               
            <input type="submit" class="btn btn-large btn-primary" value="提交">
        </form>
    </body>
</html>




