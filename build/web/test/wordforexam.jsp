<%-- 
    Document   : wordforexam
    Created on : 2014-11-29, 17:17:35
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=cp%>/images/b128.png" rel="shortcut icon" type="images/x-ico"/>
        <meta http-equiv="refresh" content="10;url=<%=cp%>/ExamListServlet"> 
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">
        <script type="text/javascript" src="<%=cp%>/js/bootstrap.min.js"></script>
        <title>答题系统--试卷下载</title>
        <style type="text/css">
            body { 
                background: #efeeea; 
            } 
            #cx{
                float:right;
                margin-right: 20px;
            }
        </style>
        <script type="text/javascript">

        </script>
    </head>
    <body>
        <%
            //判断session值是否有效,或者以防用户直接输地址

            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
            if (user == "" || user == null) {
                response.sendRedirect("login/login.jsp");
                return;
            }
            int rows = Integer.parseInt(request.getAttribute("rows").toString());
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
        <p style="color:red; text-align: center; font-size: 20px">${error}</p>
        <font><a id="cx" href="<%=cp%>/ChafenServlet">查询分数</a></font>
        <table class="table table-condensed">
            <%if (rows > 0) {%>
            <caption>答题系统--试卷下载</caption>
            <thead>
                <tr>
                    <th>试卷序号</th>
                    <th>试卷名称</th>
                    <th>试卷介绍</th>
                    <th>试卷下载</th>
                    <th>提交试卷</th>
                </tr>
            </thead>
            <%}%>
            <tbody>
                <%if (rows > 0) {

                        Integer[] list_id = new Integer[rows];
                        String[] list_name = new String[rows];
                        String[] list_content = new String[rows];
                        for (int i = 0; i < rows; i++) {
                            list_id[i] = Integer.parseInt(request.getAttribute("list_id" + i).toString());
                            list_name[i] = request.getAttribute("list_name" + i).toString();
                            list_content[i] = request.getAttribute("list_content" + i).toString();
                        }
                        for (int i = 0; i < rows; i++) {
                %>
                <%if (i % 2 == 0) {%>
                <tr class="success">
                    <%} else {%>
                <tr class="error">
                    <%}%>
                    <td><%=(i + 1)%></td>
                    <td><%=list_name[i]%></td>
                    <td><%=list_content[i]%></td>
                    <td><a href="<%=cp%>/ExamDownLoadServlet?id=<%=list_id[i]%>">试卷下载</a></td>
                    <td><a href="test/uploadExam.jsp">提交</a></td>
                </tr>
                <%}
                    }%>
            </tbody>
        </table>
    </body>
</html>
