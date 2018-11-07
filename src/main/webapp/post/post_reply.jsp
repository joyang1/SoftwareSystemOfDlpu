<%-- 
    Document   : post_reply
    Created on : 2014-4-28, 16:10:23
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<%
    request.setCharacterEncoding("UTF-8");
    String htmlData = request.getParameter("post_reply") != null ? request.getParameter("post_reply") : "";
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
        <title>论坛回复</title>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
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
            .img{
                width:60px;
                height:60px;
            } 
        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">
        
        <script>
            KindEditor.ready(function(K) {
                var editor1 = K.create('textarea[name="post_reply"]', {
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
    <body background="<%=cp%>/img/bg.jpg">
        <%=htmlData%>
        <%
            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
            /* 判断session值是否有效,或者以防用户直接输地址     
             if(user == "" || user ==null){
             response.sendRedirect("../home/homepage.jsp");
             return;           
             }*/
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
                            <a href="JudgeServlet?judge=1">返回主页</a>
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
        </div><br/>
        <div class="container">            

            <%
                //获得待回应的帖子的标题和内容以及帖子的id
                String name = request.getAttribute("name").toString();
                String content = request.getAttribute("content").toString();
                int pid = Integer.parseInt(request.getAttribute("pid").toString());

                //获得对应帖子的回复信息
                String scount = request.getAttribute("count").toString();
            %>

            <div id="div5" cellpadding="10px">
                <font style="font-family:黑体;font-size: 30px;"><%=name%></font>
                <p style="font-family: 宋体;font-size: 20px;"><%=content%></p>
                <a href="#C1">点此回帖</a>
            </div>
            <hr style="border: 1px solid #0E2D5F"/>
            <%if (scount != null) {
                    int count = Integer.parseInt(scount);
                    int[] rid = new int[count];
                    String[] rcontent = new String[count];
                    String[] rowner = new String[count];
                    String[] rtime = new String[count];

                    for (int i = count - 1; i >= 0; i--) {
                        rid[i] = Integer.parseInt(request.getAttribute("rid" + i).toString());
                        rcontent[i] = request.getAttribute("rcontent" + i).toString();
                        rowner[i] = request.getAttribute("rowner" + i).toString();
                        rtime[i] = request.getAttribute("rtime" + i).toString();
                    }
                    for (int i = count - 1; i >= 0; i--) {%>

            <table>
                <tr>
                    <td width="100px" align="center">
                        <img src="images/dengpao.jpg" class="img"></br>
                        <%=rowner[i]%>
                    </td>
                    <td width="800px"><%=rcontent[i]%></td>
                    <td width="200px" align="right">                       
                        &nbsp&nbsp<a href="AreplyServlet?rid=<%=rid[i]%>" target="blank">回复</a></br> 
                        <%=rtime[i]%>
                    </td>
                </tr>
            </table>
            <hr style="border: 1px solid #0E2D5F"/>
            <%}
                }%>

            <form action="PostReplyServlet?id=<%=pid%>" method="post">
                <table>
                    <tr><td><a name="C1">快来回帖吧...</a></td></tr>
                    <tr><td><textarea type="text" name="post_reply" style="width: 1160px;height: 150px;visibility:hidden;"><%=htmlspecialchars(htmlData)%></textarea></td></tr>
                    <tr><td align="center"><input type="submit"  class="btn btn-large btn-primary" name="post_reply" value="确定回复"></td></tr>
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