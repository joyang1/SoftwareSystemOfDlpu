<%-- 
    Document   : post_reply
    Created on : 2014-4-28, 16:10:23
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<%
    request.setCharacterEncoding("UTF-8");
    String htmlData = request.getParameter("acontent") != null ? request.getParameter("acontent") : "";
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
        <title>追加评论</title>
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
            .img{
                width: 40px;
                height:40px;
            }

        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">

        <script>
            KindEditor.ready(function(K) {
                var editor1 = K.create('textarea[name="acontent"]', {
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
            });
        </script>
    </head>
    <body background="<%=cp%>/img/bg1.jpg">
        <%=htmlData%>
        <div class="container">
            <%
                //判断session值是否有效,或者以防用户直接输地址
                String user = session.getAttribute("user").toString();
                String userpower = session.getAttribute("userpower").toString();
                if (user == "" || user == null) {
                    response.sendRedirect("login/login.jsp");
                    return;
                }
            %>

            <%
                String rowner = request.getAttribute("rowner").toString();
                String rcontent = request.getAttribute("rcontent").toString();
                int rid = Integer.parseInt(request.getAttribute("rid").toString());
                int areplycount = Integer.parseInt(request.getAttribute("areplycount").toString());
            %>

            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container-fluid">
                        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="brand" href="home/home.jsp">软件技术应用研究室</a>

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
            </div></br> 

            <a href="home/homepage.jsp">返回主页</a>
            <a href="#C1">追加评论</a>
            <p style="font-family: 宋体;font-size: 20px;"><%=rcontent%></p>
            <p>评论者:<%=rowner%></p>
            <hr style="border: 1px solid #0E2D5F"/>
            <%if (areplycount > 0) {
                    String[] owner = new String[areplycount];
                    String[] acontent = new String[areplycount];
                    String[] time = new String[areplycount];
                    for (int i = areplycount - 1; i >= 0; i--) {
                        owner[i] = request.getAttribute("owner" + i).toString();
                        acontent[i] = request.getAttribute("acontent" + i).toString();
                        time[i] = request.getAttribute("time" + i).toString();
                    }
                    for (int i = areplycount - 1; i >= 0; i--) {%>
            <div id="div6">
                <table>
                    <tr>
                        <td width="100px" align="center">
                            <img src="images/dengpao.jpg" class="img"></br>
                            <%=owner[i]%>
                        </td>
                        <td width="800px"><%=acontent[i]%></td>
                        <td width="200px" align="right"> </br> 
                            <%=time[i]%>   
                        </td>
                    </tr>
                </table>
                <hr style="border: 1px solid #0E2D5F"/>
            </div> 
            <%}
                }%>

            <form action="AreplyServlet?rid=<%=rid%>" method="post">
                <table>
                    <tr><td><a name="C1">快来评论吧...</a></td></tr>
                    <tr><td><textarea type="text" name="acontent" style="width: 1150px;height: 150px;font-size: 15px;visibility:hidden;"><%=htmlspecialchars(htmlData)%></textarea></td></tr>
                    <tr><td align="center"><input type="submit"  value="确定回复" class="btn btn-large btn-primary"></td></tr>
                </table>
            </form>              
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