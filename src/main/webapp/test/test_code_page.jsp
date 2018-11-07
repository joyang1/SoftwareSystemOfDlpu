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
    </head>
    <style type="text/css">
        body{
        }
        h1{color:#00ff00; text-align: center;}
        h3{color:#00ffee;}
        .question_title{
            font-family: "楷体";
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
            color: #ff33cc;
        }
        a:hover{
            color: #99eeff;
        }
    </style>
    <body background="../img/bg.jpg">

        <%
            //判断session值是否有效,或者以防用户直接输地址
            String user = session.getAttribute("user").toString();
            if (user == "" || user == null) {
                response.sendRedirect("../login/login.jsp");
                return;
            }
        %>

        <h1>大连工业大学软件研究室测试系统</h1>
        <h3>一、选择题</h3>

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
