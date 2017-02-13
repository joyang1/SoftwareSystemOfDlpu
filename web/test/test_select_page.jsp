<%-- 
    Document   : testpage
    Created on : 2014-6-14, 20:48:13
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>答题系统</title>
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
    </head>
    <link href="../css/bootstrap-responsive.css" rel="stylesheet">
    <link href="../css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body{
        }
        h1{color:#1E90FF; text-align: center;}
        h3{color:#1E90FF;}
        .question_title{
            font-family: "隶书";
            font-size: 30px;
            margin-bottom: 10px;
            margin-left: 30px;
        }
        .question_option{
            margin:2px 0px 2px 15px;
        }
        .question{
            margin-left:30px;
            margin-right: 30px;
            font-family: "宋体";
            font-size: 20px;
        }
        .question>ul{
            list-style:none;
        }
        .question>ul>li{
            padding:5px;
            margin-left: -20px;
            cursor: pointer;
        }
        .question>ul>li:hover{
            background: #d4d4d4;
        }
        p{text-align: center}
        a{
            text-decoration: none;
            color: #D4D4D4;
        }
        a:hover{
            color: #FF33CC;
        }
    </style>
    <%
        String user = session.getAttribute("user").toString();
        String userpower = session.getAttribute("userpower").toString();
    %>
    <body background="../img/bg.jpg">
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
                            <a href="../login/login.jsp">登陆</a>
                            <a href="../login/register.jsp">注册</a>
                            <%} else if (userpower == "2") {%>
                            <span>管理员：<%=user%></span>
                            <a href="../index.jsp">注销</a>
                            <%} else {%>
                            <span>用户：<%=user%></span>
                            <a href="../LoginServlet">个人信息</a>
                            <a href="../index.jsp">注销</a>
                            <a href="home/homepage.jsp">返回主页</a>
                            <%}%>

                        </p>
                        <ul class="nav">
                            <li><a href="home/homepage.jsp">首页</a></li>
                            <li><a href="JudgeServlet?judge=2">新闻</a></li>
                            <li><a href="JudgeServlet?judge=3">论坛</a></td></li>
                            <li><a href="JudgeServlet?judge=4">相册</a></td></li>
                            <li><a href="JudgeServlet?judge=5">资源</a></td></li>
                            <li><a href="JudgeServlet?judge=6">咨询</a></li>
                            <li class="active"><a href="JudgeServlet?judge=7">答题系统</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>         

        <br/><br/>
        <h1>大连工业大学软件研究室测试系统</h1>
        <h3>一、选择题</h3>

        <%for (int i = 0; i < 10; i++) {%>
        <div class="question">
            <span><%=(i + 1)%></span>.&nbsp;&nbsp;<span><strong>选什么？？？？</strong></span><br />
            <ul>
                <li><span class="question_option"><input type="radio" value="A" name="<%=(i + 1)%>" />A.aaaaaaaqqqqqqq</span></li>
                <li><span class="question_option"><input type="radio" value="B" name="<%=(i + 1)%>" />B.bbbbbbb</span></li>
                <li><span class="question_option"><input type="radio" value="C" name="<%=(i + 1)%>" />C.ccccccc</span></li>
                <li><span class="question_option"><input type="radio" value="D" name="<%=(i + 1)%>" />D.ddddddd</span></li>
            </ul><hr/>
        </div>
        <%}%>
        <h3>二、填空题</h3>

        <%for (int i = 0; i < 10; i++) {%>
        <div class="question">
            <span><%=(i + 1)%></span>.&nbsp;&nbsp;<span><strong>问题<%=(i + 1)%></strong></span><br />
            <ul>
                <li><span class="question_option">填啥子<input type="text" name="<%=(i + 1)%>" /></span></li>
            </ul><hr/>
        </div>
        <%}%>
        <h3>三、编程题</h3>

        <%for (int i = 0; i < 10; i++) {%>
        <div class="question">
            <span><%=(i + 1)%></span>.&nbsp;&nbsp;<span><strong>怎么编</strong></span><br />
            <ul>
                <li><span class="question_option"><textarea rows="5" style="width:400px;" type="radio" value="A" name="<%=(i + 1)%>" /></textarea></span></li>
            </ul><hr/>
        </div>
        <%}%>

    </body>
</html>
