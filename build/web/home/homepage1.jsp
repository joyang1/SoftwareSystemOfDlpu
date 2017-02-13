<%-- 
    Document   : index
    Created on : 2014-4-26, 11:23:19
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>软件技术应用研究室</title>		
        <style type="text/css">
            body{
                position: absolute;
                left: 3%;
                background: url(../images/beijing.png) repeat-y;
            }
            #div1{
                position: absolute;
                left: 80px;
                top: 127px;
            }
            #div1 table{
                top: 100px;
                font-size:24px;
                font-family:"宋体";
                background-color:#888888;
                border-radius:10px;
                border:10px;
            }
            #div1 a:link{
                color:#FFF;
                display: block;
                border:0px solid #00F;
                background-color:#808080;
            }
            #div1 a{
                text-decoration:none;  
                padding:0px;
                display: block;
                border:0px solid #00F;
                width: 150px;
                color:#FFF;
                background-color:#505050;
            }
            #div1 a:hover{
                display: block;
                border:0px solid;
                background-color:#989898;
                width: 150px;
                color:#FFF;
            }
            #div2{
                position: absolute;
                left:80px;
                top: 162px;
                width:150px;
                height:500px;
                border-style:solid;
                border-color:#ffeedd;
                border-width:1px;
                border-radius:10px;
                margin: 0em 0em 0em 0em;
                font-size:10px;
                background-color:#F0F0F0;
                color:red;
                font-family:Arial;	  
            }
            #div2 dir{ 
                list-style: none outside none; 
                padding: 12px; 
                text-align:left;
                background: #FFF;
                font-size:10px; 
                line-height:40px;
            } 
            #div2 dir li 
            { 
                display: inline-block; 
                display: inline;        
                zoom: 1; 
                text-align:left;
                padding: 2px; 
                font-size: 16px; 
                color:#00FFFF;
                font-weight:bold;
                font-family:"宋体";
            }
            #div2 a:link,#div2 a:visited{
                color:#00BB00;
                text-decoration:none;
            }
            #div2 a:hover{
                color:#007500;
                text-decoration:none;}
            #div3{
                position: absolute;
                left: 150px;
                top: 0px;
                width:926px;
                height:497px;
                border-style:solid;
                border-color:white;
                border-width:2px;
                border-radius:10px;
                margin: 0em 0em 0em 0em;
                font-size:10px;
                color:red;
                font-family:Arial;	 
            }
            #div4{
                position: absolute;
                top:14px;
                left: 80px;
            }
            #div4 img{
                border:10px;
                width:1080px;
                height: 114px;
            }
            #div5{
                position:absolute;
                top: -5px;
                left: 950px;
                height: 12px;
                width: 220px;
            }

            #div5 a{color: yellowgreen;text-decoration: none;}
            #div5 a:hover {color: red}
        </style>
    </head>
    <body align="center">
        <%
            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
             //判断session值是否有效,或者以防用户直接输地址     
//            if(user == "" || user ==null){
//                response.sendRedirect("../home/homepage.jsp");
//                return;
//            }
        %>
        <div id="div4">
            <img src="../images/logo.png">
        </div>

        <div id="div5">
            <% if (userpower == "0") { %>
            <span>欢迎游客</span>
            <a href="../login/login.jsp">登陆</a>
            <a href="../login/register.jsp">注册</a>
            <%} else if (userpower == "2") {%>
            <span>管理员：<%=user%></span>
            <a href="../index.jsp">注销</a>
            <%} else {%>
            <span>用户：<%=user%></span>
            <a href="../LoginServlet">个人信息</a>
            <a href="../index.jsp">注销</a>
            <%}%>
        </div>
        <div width="980" align="left">
            <div id="div1">
                <table width="50%">
                    <tr align=center >
                        <td><a href="../home/homepage.jsp">首页</a></td>
                        <td><a href="../JudgeServlet?judge=2">新闻</a></td>
                        <td><a href="../JudgeServlet?judge=3">论坛</a></td>
                        <td><a href="../JudgeServlet?judge=4">相册</a></td>
                        <td><a href="../JudgeServlet?judge=5">资源</a></td>
                        <td><a href="../JudgeServlet?judge=6">咨询</a></td>
                        <td><a href="../JudgeServlet?judge=7">答题系统</a></td>
                    </tr>
                </table>
            </div>
            <div id="div2">
                <dir>
                    <table>
                        <li><a href="#" id="ttt">资源下载</a></li>
                        <li><a href="#" id="ttt">计算机语言介绍</a></li>
                        <li><a href="#" id="ttt">资源共享</a></li>
                        <li><a href="#" id="ttt">资源链接</a></li>
                        <li><a href="#" id="ttt">书籍借阅</a></li>
                    </table>
                </dir>
                <div id="div3">
                    <table>

                    </table>
                </div>
            </div>
        </div>
    </body>
</html>


