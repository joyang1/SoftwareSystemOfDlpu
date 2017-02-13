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
        <title>添加试题</title>
        <style type="text/css">
            body{text-align: center}
            img{width: 150px; height: 80px; margin-right: 80px;border: solid 1px #d2e2e2;}
        </style>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
                //padding-top: 40px;
                //padding-bottom: 40px;
                //background-color: #f5f5f5;
                background: #efeeea; 
            }
            .navbar{                
                margin-top: -40px;
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

        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">        
    </head>
    <body>
        <%
            //判断session值是否有效,或者以防用户直接输地址
            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
            if (user == "" || user == null) {
                response.sendRedirect(cp + "/login/login.jsp");
                return;
            }
        %>
        <br/><br/>
        <!--导航开始-->
        <div class="navbar">
            <div class="navbar-inner">
                <a class="brand" href="<%=cp%>/ResServlet">返回</a>
                <h4 class="form-signin-heading">上传资源</h4>
            </div>
        </div>
        <!--导航结束-->
        <font style="color:red">${message}</font>
        <!--上传的<input type=file>标记一定要有name,如果没有，commons fielupload不作处理。-->
        <br/><br/><br/>
        <form action="<%=cp%>/uploadResServlet" method="post" enctype="multipart/form-data" class="form-signin">
            <textarea  name="introduce" class="input-block-level" placeholder="资源介绍"></textarea>
            <input type="file" placeholder="选择你要上传的资料" class="input-block-level" name="res" size="20"><br/>               
            <input type="submit" class="btn btn-large btn-primary" value="上传">
        </form>
    </body>
</html>




