<%-- 
    Document   : addnewsjsp
    Created on : 2014-5-7, 8:46:19
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../../images/b128.png" rel="icon" type="images/x-ico"/>
        <title>管理员添加相册</title>
         <link href="../../css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 350px;
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
    <link href="../../css/bootstrap-responsive.css" rel="stylesheet">
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
    <body background="../../img/bg1.jpg">
        <form action="../../AlbumServlet" class="form-signin" method="post"> 
            <h3 class="form-signin-heading">添加相片</h3>
            <input type="text" class="input-block-level" placeholder="相册名" name="album_name">
            <input type="text" class="input-block-level" placeholder="相册路径" name="album_url">
            <h3 class="form-signin-heading">添加描述</h3>
            <textarea rows="5" name="album_content" class="input-block-level" name="masterDescription" placeholder="添加描述"></textarea>
            <input type="submit" value="确认添加" class="btn btn-large btn-primary ">
            </div>
        </form>
    </body>
</html>
