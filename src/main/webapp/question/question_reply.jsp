<%-- 
    Document   : question
    Created on : 2014-4-29, 9:52:21
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<%
    request.setCharacterEncoding("UTF-8");
    String htmlData = request.getParameter("q_content") != null ? request.getParameter("q_content") : "";
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
        <title>咨询回复</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-signin {
                max-width: 1100px;
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

        <script>
            KindEditor.ready(function(K) {
                var editor1 = K.create('textarea[name="q_content"]', {
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
    <body background="img/bg.jpg">
        <%=htmlData%>
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
            //question的内容
            String qcontent = request.getAttribute("qcontent").toString();
            String qowner = request.getAttribute("qowner").toString();
            String qtime = request.getAttribute("qtime").toString();
            String qid = request.getAttribute("qid").toString();

            //回复的内容
            int count = Integer.parseInt(request.getAttribute("count").toString());
            String[] rcontent = new String[count];
            String[] rowner = new String[count];
            String[] rtime = new String[count];
            if (count > 0) {
                for (int i = count - 1; i >= 0; i--) {
                    rcontent[i] = request.getAttribute("rcontent" + i).toString();
                    rowner[i] = request.getAttribute("rowner" + i).toString();
                    rtime[i] = request.getAttribute("rtime" + i).toString();
                }
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
                            <li><a href="JudgeServlet?judge=3">论坛</a></td></li>
                            <li><a href="JudgeServlet?judge=4">相册</a></td></li>
                            <li><a href="JudgeServlet?judge=5">资源</a></td></li>
                            <li class="active"><a href="JudgeServlet?judge=6">咨询</a></li>
                            <li><a href="JudgeServlet?judge=7">答题系统</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div></br>
        <div class="container">


            <%
                if (count > 0) {
                    for (int i = count - 1; i >= 0; i--) {
            %>            
            <table class ="table">
                <tr>
                    <td align="center" rowspan="2"><img src="images/admin.jpg" style="width:50px;height:50px;">
                        <br/><%=rowner[i]%>
                    </td>
                    <td>回复内容</td>
                    <td>回复时间</td>    
                </tr>
                <tr>
                    <td><%=rcontent[i]%></td>
                    <td><%=rtime[i]%></td>
                </tr>
            </table>
            <hr style="border: 1px solid #0E2D5F"/>
            <%
                    }
                }
            %>

            <%
                if (userpower.equals("2")) {
            %>
            <form action="QtReplyServlet" method="post">
                <table border="0">
                    <tr><td style="color:green">管理员回复</td></tr>
                    <tr><input type="hidden" class="input-block-level" value="<%=qid%>" name="qid"></tr>
                    <tr><td><textarea name="q_content"  rows="5" style="width: 790%;height: 200px;"><%=htmlspecialchars(htmlData)%></textarea></td></tr>
                    <tr><td align="center"><input type="submit" class="btn btn-large btn-primary" value="回复"/></td></tr>
                </table>
            </form>
            <%} else if (userpower.equals("1")) {%>


            <form action="QuestionServlet" method="post">
                <table border="0">
                    <tr><td style="color:green">还有疑问？？？</td></tr>
                    <tr><td><textarea name="q_content" rows="5" style="width:1150px;"><%=htmlspecialchars(htmlData)%></textarea></td></tr>
                    <tr><td align="center"><input type="submit" name="question" class="btn btn-large btn-primary" value="继续提问"/></td></tr>
                </table>
            </form>
            <%}%>        
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