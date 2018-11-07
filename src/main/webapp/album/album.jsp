<%-- 
    Document   : album
    Created on : 2014-5-1, 16:12:04
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="images/b128.png" rel="icon" type="images/x-ico"/>
        <title>相册</title>
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
    <body background="<%=cp%>/img/bg2.jpg">

         <%
            //判断session值是否有效,或者以防用户直接输地址
            String user = session.getAttribute("user").toString();
            if (user == "" || user == null) {
                response.sendRedirect("login/login.jsp");
                return;
            }
        %>

        <%
            //得到权限
            String userpower = session.getAttribute("userpower").toString();
            //得到相册的信息
            int count = Integer.parseInt(request.getAttribute("count").toString());
            int[] album_id = new int[count];
            String[] name = new String[count];
            String[] content = new String[count];
            String[] time = new String[count];
            for (int i = count - 1; i >= 0; i--) {
                album_id[i] = Integer.parseInt(request.getAttribute("id" + i).toString());
                name[i] = request.getAttribute("name" + i).toString();
                content[i] = request.getAttribute("content" + i).toString();
                time[i] = request.getAttribute("time" + i).toString();
            }
        %>
        
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">软件技术应用研究室</a>
          
          <div class="nav-collapse collapse">
            <p class="navbar-text pull-right">
                
                <% if (userpower == "0") { %>
                <span>欢迎游客</span>
                <a href="login/login.jsp">登陆</a>
                <a href="login/register.jsp">注册</a>
                <%} else if (userpower == "2") {%>
                <span>管理员：<%=user%></span>
                <a href="index.jsp">注销</a>
                <%} else {%>
                <span>用户：<%=user%></span>
                <a href="LoginServlet">个人信息</a>
                <a href="index.jsp">注销</a>
                <%}%>
                              
            </p>
            <ul class="nav">
              <li><a href="JudgeServlet?judge=1">首页</a></li>
              <li><a href="JudgeServlet?judge=2">新闻</a></li>
              <li><a href="JudgeServlet?judge=3">论坛</a></td></li>
              <li class="active"><a href="JudgeServlet?judge=4">相册</a></td></li>
              <li><a href="JudgeServlet?judge=5">资源</a></td></li>
              <li><a href="JudgeServlet?judge=6">咨询</a></li>
              <li><a href="JudgeServlet?judge=7">答题系统</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>         
 
        <div class="container">
            <h2><font style="color: #00cc99">那些年B128的回忆...</font><h2> 
            <% if (userpower.equals("2")) {%><a href="admin/admin_manage/addalbum.jsp"><span>添加相册</span></a>
            <%}%>

        <% for (int i = count - 1; i >= 0; i--) {%> 
            <table class ="table">
                <tr><td rowspan="4"><img src="images/admin.jpg" style="height:250px;width:250px;"></td></tr>
                <tr ><td>相册名：<%=name[i]%></td></tr>
                <tr ><td >相册时间：<%=time[i]%></td></tr>
                <tr ><td>相册简介：<%=content[i]%></td></tr>
                <tr ><td align="center"><a href="ShowAlbumServlet?album_id=<%=album_id[i]%>">查看相册</td></tr>
            </table>
      
        <%}%>
    </div>            
    </body>
</html>
