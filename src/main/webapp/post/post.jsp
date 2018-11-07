<%-- 
    Document   : post
    Created on : 2014-4-27, 20:36:17
    Author     : 挺
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<%
    request.setCharacterEncoding("UTF-8");
    String htmlData = request.getParameter("p_content") != null ? request.getParameter("p_content") : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="images/b128.png" rel="icon" type="images/x-ico"/>
        <link rel="stylesheet" href="kindeditor/themes/default/default.css" />
        <link rel="stylesheet" href="kindeditor/plugins/code/prettify.css" />
        <script charset="utf-8" src="kindeditor/kindeditor.js"></script>
        <script charset="utf-8" src="kindeditor/lang/zh_CN.js"></script>
        <script charset="utf-8" src="kindeditor/plugins/code/prettify.js"></script>
        <title>论坛</title>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
                background: #e5e5e5
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

        <script>
            //编辑器
            KindEditor.ready(function(K) {
                var editor1 = K.create('textarea[name="p_content"]', {
                    cssPath: 'kindeditor/plugins/code/prettify.css',
                    uploadJson: 'kindeditor/jsp/upload_json.jsp',
                    fileManagerJson: 'kindeditor/jsp/file_manager_json.jsp',
                    allowFileManager: true,
                    afterCreate: function() {
                        var self = this;
                        K.ctrl(document, 13, function() {
                            self.sync();
                            document.forms['example'].submit();
                        });
                        K.ctrl(self.edit.doc, 13, function() {
                            self.sync();
                            document.forms['example'].submit();
                        });
                    }
                });
                prettyPrint();
            });</script>



    </head>
    <body>
        <%=htmlData%>
        <div class="container">

            <%
                String user = "";
                String userpower = "";
                //判断session值是否有效,或者以防用户直接输地址
                if (session == null) {
                    response.sendRedirect("login/login.jsp");
                    return;
                } else {
                    user = session.getAttribute("user").toString();
                    userpower = session.getAttribute("userpower").toString();
                }

            %>

            <%//获得从后台传来的页面显示数据%>
            <%
                int length = Integer.parseInt(request.getAttribute("length").toString());
                int startpost = Integer.parseInt(request.getAttribute("startpost").toString());
                int stoppost = Integer.parseInt(request.getAttribute("stoppost").toString());
                int pageCount = Integer.parseInt(request.getAttribute("pageCount").toString());
                int pageNow = Integer.parseInt(request.getAttribute("pageNow").toString());
                //int[] pid = new int[length];
                String[] name = new String[length];
                String[] content = new String[length];
                String[] owner = new String[length];
                String[] time = new String[length];
                for (int i = startpost; i >= stoppost; i--) {
                    //pid[i] = Integer.parseInt(request.getAttribute("pid"+i).toString());
                    name[i] = request.getAttribute("name" + i).toString();
                    content[i] = request.getAttribute("content" + i).toString();
                    owner[i] = request.getAttribute("owner" + i).toString();
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
                                <li class="active"><a href="JudgeServlet?judge=3">论坛</a></td></li>
                                <li><a href="JudgeServlet?judge=4">相册</a></td></li>
                                <li><a href="JudgeServlet?judge=5">资源</a></td></li>
                                <li><a href="JudgeServlet?judge=6">咨询</a></li>
                                <li><a href="JudgeServlet?judge=7">答题系统</a></li>
                            </ul>
                        </div><!--/.nav-collapse -->
                    </div>
                </div>
            </div>  
            <span style="font-size:16px">论坛专区</span>
            <a href="#C1">点此发帖</a>
            <table class="table table-striped">
                <tr style="color:#000; font-size: 16px">
                    <td width="600px">帖子标题</td><td width="350px">发帖人</td><td width="350px">时间</td>
                </tr>
                <%for (int i = startpost; i >= stoppost; i--) {%>
                <tr>
                    <td width="500px"> <a href="PostReplyServlet?id=<%=i%>" class="a" target="_blank"><%=name[i]%></a></td>

                    <td width="400px"><%=owner[i]%></td>
                    <td><%=time[i]%></td>
                </tr>
                <%}%>
                <tr>
                    <%if (pageNow - 1 > 0) {%>
                    <td><a href="PostServlet?pageNow=<%=pageNow - 1%> " class="a">上一页</td>
                    <%} else {%>
                    <td></td>
                    <%}%>

                    <%if (pageNow + 1 <= pageCount) {%>
                    <td><a href="PostServlet?pageNow=<%=pageNow + 1%>" class="a">下一页</td>
                    <%} else {%>
                    <td></td>
                    <%}%>
                    <td> <%if (pageNow < pageCount) {%>
                        第<span style="color:#111111; font-size: 16px"><i><%=pageNow%></i></span>页 共<span style="color: #111111; font-size: 16px" ><i><%=pageCount%></i></span>页
                                <%} else {%>
                        最后一页 共<span><%=pageCount%></span>页
                        <%}%></td>
                </tr>
            </table> 

            <form action="FSPostServlet" method="POST">
                <a name="C1">我要发帖</a>
                <input type="text" id="p_name" name="p_name" class="input-block-level" placeholder="标题">
                <textarea type="text" rows="8" name="p_content" style="width: 1165px;height: 200px; visibility:hidden;"><%=htmlspecialchars(htmlData)%></textarea>
                <input type="submit" class="btn btn-large btn-primary" value="确定发帖"><br/><br/>
            </form>

            <div class="input-append">
                <input class="span2" id="pageNow" name="pageNow" placeholder="页码" type="text" >
                <button class="btn btn-primary" onclick="checkpage()">点此跳转</button>
            </div>


            <script>
                function checkpage() {
                    var page = document.getElementById("pageNow").value;
                    var reg = /^[0-9]*$/;
                    if (page == "" || !reg.test(page)) {
                        alert("页码必须输入且必须为整数");
                        return false;
                    } else {
                        window.location.href = "PostServlet?pageNow=" + page;
                    }

                }
            </script>
        </div>
    </body>
</html>
<%!
    private String htmlspecialchars(String str) {
        str = str.replaceAll("&", "&amp;");
        str = str.replaceAll("<", "&lt;");
        str = str.replaceAll(">", "&gt;");
        str = str.replaceAll("\"", "&quot;");
        return str;
    }
%>

