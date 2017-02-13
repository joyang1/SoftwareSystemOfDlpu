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
        <title>咨询</title>
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

        <form class="form-signin" action="QuestionServlet" method="post">
            <h2>你的问题，我来解决！</h2>
            <textarea name="q_content" rows="5" style="width:1080px;visibility:hidden;"><%=htmlspecialchars(htmlData)%></textarea></br>
            <td align="center"><input type="submit" class="btn btn-large btn-primary" value="提问"/>
        </form>
        <div class="container">
            <table class ="table table-striped">
                <%
                    int length = Integer.parseInt(request.getAttribute("length").toString());
                    int[] id = new int[length];
                    String[] qcontent = new String[length];
                    String[] qowner = new String[length];
                    String[] qtime = new String[length];

                    if (length > 0) {
                        for (int i = length - 1; i >= 0; i--) {
                            qcontent[i] = request.getAttribute("qcontent" + i).toString();
                            qowner[i] = request.getAttribute("qowner" + i).toString();
                            qtime[i] = request.getAttribute("qtime" + i).toString();
                            id[i] = Integer.parseInt(request.getAttribute("id" + i).toString());
                        }
                    }
                %>

                <%
                    if (length > 0) {
                        for (int i = length - 1; i >= 0; i--) {
                %>
                <tr>
                    <td rowspan="2" width="55px"><img src="images/dengpao.jpg" style="height:50px;width:50px;"><br/><%=qowner[i]%></td>
                    <td>问题内容</td><td>提问时间</td>
                </tr>
                <tr>
                    <td><%=qcontent[i]%></td>
                    <td>
                        <%=qtime[i]%>
                        <br/><a href="QtReplyServlet?qid=<%=id[i]%>" target="blank">查看回复</a>
                    </td>
                </tr>

                <%
                        }
                    }
                %>
            </table>
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