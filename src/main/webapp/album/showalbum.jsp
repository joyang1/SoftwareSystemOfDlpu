<%-- 
    Document   : showalbum
    Created on : 2014-5-1, 17:38:39
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="images/b128.png" rel="icon" type="images/x-ico"/>
        <title>查看相册</title>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <script src="EasyUI/jquery.min.js"></script>
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
            #div1 {
                float: left;
                left: 10px;
                top:100px;
                border-style:solid;
                border-width:thin;
                border-color: #cccccc;
            }
            img{
                width: 160px;
                height:160px;
            }

        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">
        <script>
            $('#add').onmouseover(function (){
                alert('aaaa');           
            });
        </script>
    </head>
    <body>
        <%
            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
            if (user == "" || user == null) {
                response.sendRedirect("login/login.jsp");
                return;
            }
        %>
        <%
            int album_id = Integer.parseInt(request.getAttribute("album_id").toString());
            int albumpicturecount = Integer.parseInt(request.getAttribute("albumpicturecount").toString());
            String albumurl = request.getAttribute("albumurl").toString();
            String[] introduce = new String[albumpicturecount];
            String[] name = new String[albumpicturecount];
            for (int i = albumpicturecount - 1; i >= 0; i--) {
                introduce[i] = request.getAttribute("introduce" + i).toString();
                name[i] = request.getAttribute("name" + i).toString();
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
            <br/>
            <%for (int i = albumpicturecount - 1; i >= 0; i--) {%>
            <div id="div1">
                <table boder = "1"> 
                    <tr>
                        <td> <img src = "picture/picture/<%=albumurl%>/<%=name[i]%>" > </td > 
                    </tr> 
                    <tr> <td> <%=introduce[i]%> </td> </tr> 
                </table> 
            </div>
            <%}%>
            <div id="div1">
                <table boder="1">
                    <tr><td><a href="album/addpicture.jsp?album_id=<%=album_id%>"><img id="add" src="images/jia.png"></a></td></tr>
                    <tr><td align="center">添加</td></tr>
                </table>
            </div>
        </div>
    </body>
</html>
