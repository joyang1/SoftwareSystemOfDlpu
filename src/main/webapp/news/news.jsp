

<%@page import="com.servlet.news.NewsServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>新闻</title>
        <link href="images/b128.png" rel="icon" type="images/x-ico"/>
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
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
    </head>
    <body background="img/bg1.jpg">
        <%
            //判断session值是否有效,或者以防用户直接输地址
            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
            if (user == "" || user == null) {
                response.sendRedirect("login/login.jsp");
                return;
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
                            <li class="active"><a href="JudgeServlet?judge=2">新闻</a></li>
                            <li><a href="JudgeServlet?judge=3">论坛</a></td></li>
                            <li><a href="JudgeServlet?judge=4">相册</a></td></li>
                            <li><a href="JudgeServlet?judge=5">资源</a></td></li>
                            <li><a href="JudgeServlet?judge=6">咨询</a></li>
                            <li><a href="JudgeServlet?judge=7">答题系统</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class="container">


            <table class="table table-striped">
                <tr>
                    <td width="600px">新闻标题</td><td width="350px">日期</td>
                </tr>
                <%
                    int startnews = Integer.parseInt(request.getAttribute("startnews").toString());
                    int stopnews = Integer.parseInt(request.getAttribute("stopnews").toString());
                    int allnewscount = Integer.parseInt(request.getAttribute("allnewscount").toString());
                    int pageCount = Integer.parseInt(request.getAttribute("pageCount").toString());
                    int pageNow = Integer.parseInt(request.getAttribute("pageNow").toString());
                    String[] title = new String[allnewscount];
                    String[] time = new String[allnewscount];
                    if (startnews >= 0){
                        for (int i = startnews; i >= stopnews; i--) {
                            title[i] = request.getAttribute("title" + i).toString();
                            time[i] = request.getAttribute("time" + i).toString();
                            if (stopnews < 0) {
                                stopnews = 0;
                            }
                        }
                    }

                %>
                <%
                    if (startnews >= 0){
                        for (int i = startnews; i >= stopnews; i--) {
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("<a class='a' href='NewsShowServlet?id=" + i + " '>");
                            out.print(title[i]);
                            out.println("</a>");
                            out.println("</td>");
                            out.println("<td>");
                            out.print(time[i]);
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    }

                %>
                <tr><td>
                        <%if (pageNow - 1 > 0) {%>
                        <a href="NewsServlet?pageNow=<%=pageNow - 1%>" class="a">上一页</a>
                        <%}%>
                    </td>
                    <td>
                        <%if (pageNow + 1 <= pageCount) {%>
                        <a href="NewsServlet?pageNow=<%=pageNow + 1%>" class="a">下一页</a>
                        <%}%>
                    </td>
                </tr>
            </table>

            <div class="input-append">
                <input class="span2" id="pageNow" name="pageNow" placeholder="页码" type="text" >
                <button class="btn btn-primary" onclick="checkpage()">点此跳转</button>
            </div>
            <%if (pageNow < pageCount) {%>
            <span>第<span style="color: #111111; font-size: 16px"><i><%=pageNow%></i></span>页 共<span style="color: #111111; font-size: 16px"><i><%=pageCount%></i></span>页</span>
            <%} else {%>
            <span>最后一页&nbsp;共<span style="color: #33ccff"><%=pageCount%></span>页</span>&nbsp;&nbsp;&nbsp;
            <%}%>


        </div>
    </body>
</html>

<script>
    function checkpage() {
        var page = document.getElementById("pageNow").value;
        var reg = /^[0-9]*$/;
        if (page == "" || !reg.test(page)) {
            alert("页码必须输入且必须为整数");
            return false;
        } else {
            window.location.href = "NewsServlet?pageNow=" + page;
        }
    }
</script>