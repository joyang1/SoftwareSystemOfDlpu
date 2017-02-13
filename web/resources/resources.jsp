<%--
    Document   : resource
    Created on : 2014-4-26, 11:46:48
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=cp%>/images/b128.png" rel="icon" type="images/x-ico"/>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <title>资源</title>
        <style type="text/css">
            body{
                padding: 0;
                margin: 0;
                background: #efeeea; 
            }
            #biaoti{
                background: #2A3440;
                width: 100%;
                height: 100px;
                margin: 0;
                text-align:center; 
                padding-top: 40px;
            }
            #biaoti >a{
                text-decoration: none;
                color: #00ffff;
                float: left;
                margin-top: -25px;
                margin-left: 20px;
            }
            #biaoti >a:hover{
                color: #ff3300;
            }
            .h1{
                font-size: 50px;
                color: white;
                margin-top: 0px;
            }
            #instroduce{
                margin-left: 265px;
                margin-top: -505px;
                width: 100%;
                height: 100%;
            }
            #shangc{
                float: right;
                margin-right: 30px;
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
            int rows = Integer.parseInt(request.getAttribute("rows").toString());
            int pageNow = 1;
            int pageCount = 1;
            if (rows > 0) {
                pageNow = Integer.parseInt(request.getAttribute("pageNow").toString());
                pageCount = Integer.parseInt(request.getAttribute("pageCount").toString());
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

                            <% if (userpower == "0") {%>
                            <span>欢迎游客</span>
                            <a href="<%=cp%>/login/login.jsp">登陆</a>
                            <a href="<%=cp%>/login/register.jsp">注册</a>
                            <%} else if (userpower == "2") {%>
                            <span>管理员：<%=user%></span>
                            <a href="<%=cp%>/index.jsp">注销</a>
                            <%} else {%>
                            <span>用户：<%=user%></span>
                            <a href="<%=cp%>/LoginServlet">个人信息</a>
                            <a href="<%=cp%>/index.jsp">注销</a>
                            <%}%>

                        </p>
                        <ul class="nav">
                            <li ><a href="<%=cp%>/JudgeServlet?judge=1">首页</a></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=2">新闻</a></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=3">论坛</a></td></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=4">相册</a></td></li>
                            <li class="active"><a href="<%=cp%>/JudgeServlet?judge=5">资源</a></td></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=6">咨询</a></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=7">答题系统</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <br/><br/>
        
        <a id="shangc" href="<%=cp%>/resources/useraddres.jsp">上传资源</a>
        <p style="color:red; font-size: 18px;text-align: center;margin-top: 30px;">${no}</p>
        <table class="table table-condensed">
            <%if (rows > 0) {%>
            <caption>资源中心--资源下载</caption>
            <thead>
                <tr>
                    <th>资源序号</th>
                    <th>资源名称</th>
                    <th>资源介绍</th>
                    <th>资源下载</th>
                </tr>
            </thead>
            <%}%>
            <tbody>
                <%if (rows > 0) {
                        Integer[] id = new Integer[rows];
                        String[] title = new String[rows];
                        String[] content = new String[rows];
                        for (int i = 0; i < rows; i++) {
                            id[i] = Integer.parseInt(request.getAttribute("id" + i).toString());
                            title[i] = request.getAttribute("title" + i).toString();
                            content[i] = request.getAttribute("content" + i).toString();
                        }
                        for (int i = 0; i < rows; i++) {
                %>
                <%if (i % 2 == 0) {%>
                <tr class="error">
                    <%} else {%>
                <tr class="success">
                    <%}%>
                    <td><%=(i + 1)%></td>
                    <td><%=title[i]%></td>
                    <td><%=content[i]%></td>
                    <td><a href="<%=cp%>/DownLoadResServlet?id=<%=id[i]%>">下载</a></td>
                </tr>
                <%}
                    }%>
            </tbody>
        </table>
        <%if (rows > 0) {%>
        <ul class="pager">
            <li>
                <%if (pageNow > 1) {%>
                <a href="<%=cp%>/ResServlet?pageNow=<%=pageNow - 1%>">前一页</a>
                <%} else if (pageNow == 1) {%>
                <a href="<%=cp%>/ResServlet?pageNow=<%=pageNow%>">前一页</a>
                <%}%>
            </li>
            <li>
                <%if (pageNow < pageCount) {%>
                <a href="<%=cp%>/ResServlet?pageNow=<%=pageNow + 1%>">后一页</a>
                <%} else if (pageNow == pageCount) {%>
                <a href="<%=cp%>/ResServlet?pageNow=<%=pageCount%>">后一页</a>
                <%}%>
            </li>
        </ul>
        <%}%>
    </body>
</html>
