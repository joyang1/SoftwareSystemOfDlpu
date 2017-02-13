<%-- 
    Document   : addpicture
    Created on : 2014-5-14, 19:34:21
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
        <title>添加照片</title>
        <script type="text/javascript" src="../js/shangchuan.js"></script>
        <style type="text/css">
            body{text-align: center}
            img{width: 150px; height: 80px; margin-right: 80px;border: solid 1px #d2e2e2;}
        </style>
    <link href="../css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
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

    </style>
    <link href="..css/bootstrap-responsive.css" rel="stylesheet">        
    </head>
    <body background="../img/bg1.jpg">
        
        <%
            //判断session值是否有效,或者以防用户直接输地址
            String user = session.getAttribute("user").toString();         
            if(user == "" || user ==null){
                response.sendRedirect("login/login.jsp");
                return;
            }
        %>
        
        <%
            //得到相册的id
            int album_id = Integer.parseInt(request.getParameter("album_id"));
        %>
        <form action="../PictureServlet" method="post" enctype="multipart/form-data" class="form-signin">
            <h2 class="form-signin-heading">添加照片</h2>
            <input type="hidden" value="<%=album_id%>" name="album_id">
            <input type="text" name="a_name" class="input-block-level" placeholder="相片名"><br/>
            <textarea rows="5" type="text" name="a_content" class="input-block-level" placeholder="相片介绍"></textarea><br/>
            <input type="file" id="updImg" placeholder="选择你要上传的图片" class="input-block-level" name="picture" onchange="previewImage(this, 'imgPreview', 'divPreview')" size="20"><br/>               
            <img id="imgPreview"><br/>
            <input type="submit" class="btn btn-large btn-primary" value="上传">
        </form>
    </body>
</html>




