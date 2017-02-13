<%-- 
    Document   : addnewsjsp
    Created on : 2014-4-30, 22:15:19
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String htmlData = request.getParameter("news_content") != null ? request.getParameter("news_content") : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../../images/b128.png" rel="icon" type="images/x-ico"/>
        <link rel="stylesheet" href="../../kindeditor/themes/default/default.css" />
        <link rel="stylesheet" href="../../kindeditor/plugins/code/prettify.css" />
        <script charset="utf-8" src="../../kindeditor/kindeditor.js"></script>
        <script charset="utf-8" src="../../kindeditor/lang/zh_CN.js"></script>
        <script charset="utf-8" src="../../kindeditor/plugins/code/prettify.js"></script>
        <title>管理员添加新闻</title>
    </head>
    <style type="text/css">
        body{
            text-align: center;
        }
        #textarea{
            width: 1090px;
            height: 150px;
            font-size: 15px;
        }
        #submit{
            width: 80px;
            height: 40px;
            background: #990099;
        }
    </style>

    <script>
        KindEditor.ready(function(K) {
            var editor1 = K.create('textarea[name="news_content"]', {
                cssPath: '../../kindeditor/plugins/code/prettify.css',
                uploadJson: '../../kindeditor/jsp/upload_json.jsp',
                fileManagerJson: '../../kindeditor/jsp/file_manager_json.jsp',
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

    <body>
        <%=htmlData%>
        <h1>欢迎管理员</h1>
        <form action="../../NewsServlet" method="post">
            <div>
                标题：<input type="text" name="news_title">
            </div>
            <br/>
            <div>
                <p>内容：</p>
                <textarea type="text" name="news_content" id="textarea"cols="100" rows="8" style="width:100%;height:200px;visibility:hidden;"><%=htmlspecialchars(htmlData)%></textarea><br/>
                <input type="submit" value="确认添加" id="submit">
            </div>
        </form>
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