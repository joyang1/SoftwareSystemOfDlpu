<%-- 
    Document   : addpicture
    Created on : 2014-5-14, 19:34:21
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath(); //获得当前web的根路径
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=cp%>/images/b128.png" rel="icon" type="images/x-ico"/>
        <title>查询分数</title>
        <link href="<%=cp%>/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=cp%>/js/jquery.js"></script>
        <style type="text/css">
            body {
                text-align: center;
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
                background: #efeeea; 
            }

            .form-signin {
                max-width: 300px;
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
            .form-search{
                float: right;
            }
            .pager{
                margin-left: 300px;
            }
            a{
                float: left;
                margin-left: 100px;
            }
           
            .brand{
                text-align: center;
            }
        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.min.css" rel="stylesheet">        
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
            int pageNow = 1;
            int pageCount = 1;
            if (rows > 0) {
                pageNow = Integer.parseInt(request.getAttribute("pageNow").toString());
                pageCount = Integer.parseInt(request.getAttribute("pageCount").toString());
            }
        %>
        <!--导航开始-->
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <a class="brand" href="<%=cp%>/ExamListServlet">返回</a>
                <h4 class="form-signin-heading">查询分数</h4>
            </div>
        </div>
        <p style="color:red; font-size: 18px">${no}</p>
        <!--导航结束-->
        <%if (rows > 0) {%>
        <!- form-search start-->
        <form class="form-search">
            <div class="input-prepend">
                <span class="add-on">@</span>
                <input class="span2" id="prependedInput1" type="text" placeholder="学号">
            </div>
            <div class="input-prepend">
                <span class="add-on">@</span>
                <input class="span2" id="prependedInput2" type="text" placeholder="姓名">
            </div>
            <button type="submit" class="btn" id="submit">查询</button>
        </form>
        <!- form-search end-->
        <%}%>
        <!--上传的<input type=file>标记一定要有name,如果没有，commons fielupload不作处理。-->
        <p style="color:red; font-size: 18px;">${message}</p>
        <table class="table table-condensed">
            <%if (rows > 0) {%>
            <caption>成绩列表(高-->低)</caption>
            <thead>
                <tr>
                    <th>序号</th>
                    <th>姓名</th>
                    <th>学号</th>         
                    <th>成绩</th>
                </tr>
            </thead>
            <%}%>
            <tbody>
                <%if (rows > 0) {
                        Integer[] score = new Integer[rows];
                        String[] name = new String[rows];
                        String[] sno = new String[rows];
                        for (int i = 0; i < rows; i++) {
                            score[i] = Integer.parseInt(request.getAttribute("score" + i).toString());
                            name[i] = request.getAttribute("name" + i).toString();
                            sno[i] = request.getAttribute("sno" + i).toString();
                        }
                        for (int i = 0; i < rows; i++) {
                %>
                <%if (i % 2 == 0) {%>
                <tr class="success">
                    <%} else {%>
                <tr class="error">
                    <%}%>
                    <td><%=(i + 1)%></td>
                    <td><%=name[i]%></td>
                    <td><%=sno[i]%></td>
                    <td><%=score[i]%></td>
                </tr>
                <%}
                    }%>
            </tbody>
        </table>
        <%if (rows > 0) {%>
        <ul class="pager">
            <li>
                <%if (pageNow > 1) {%>
                <a href="<%=cp%>/ChafenServlet?pageNow=<%=pageNow - 1%>">前一页</a>
                <%} else if (pageNow == 1) {%>
                <a href="<%=cp%>/ChafenServlet?pageNow=<%=pageNow%>">前一页</a>
                <%}%>
            </li>
            <li>
                <%if (pageNow < pageCount) {%>
                <a href="<%=cp%>/ChafenServlet?pageNow=<%=pageNow + 1%>">后一页</a>
                <%} else if (pageNow == pageCount) {%>
                <a href="<%=cp%>/ChafenServlet?pageNow=<%=pageCount%>">后一页</a>
                <%}%>
            </li>
        </ul>
        <%}%>

    </body>
</html>
<script type="text/javascript">
    $(function() {
        $("#submit").click(function() {
            var sno = $('#prependedInput1').val();
            var sname = $('#prependedInput2').val();
            if (sno == "") {
                alert("学号不允许为空!");
                return  false;
            }
            if (sname == "") {
                alert("姓名不允许为空!");
                return  false;
            }
            $.post("<%=cp%>/GerenChafenServlet", {sname: sname, sno: sno}, function(data) {
                alert(data.data);
               // $.messager.alert('查询结果', 'ss', 'info');
            }, "json");
        });
    });
</script>




