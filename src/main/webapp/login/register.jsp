<%-- 
    Document   : register
    Created on : 2014-4-26, 12:10:52
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
        <script type="text/javascript" src="../js/ajax.js"></script>
        <script type="text/javascript" src="../js/md5.js"></script>
        <script type="text/javascript" src="../js/register.js"></script>
        <link href="../css/bootstrap.css" rel="stylesheet">
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

        </style>
        <link href="../css/bootstrap-responsive.css" rel="stylesheet">
        <title>注册</title>
    </head>
    <body background="../img/bg1.jpg">
        <h1 align="center">注册</h1>
        <form action="../RegisterServlet" class="form-signin" method="post" id="form" name="form" onsubmit="return checkform()">
            <!--<table align="center" border="1" id="s">
                <tr><td>用户名</td> <td><input type="text" name="u_name" class="td"></td></tr>
                <tr><td>密码</td> <td><input type="password" name="u_passwd" class="td"></td></tr>
                <tr><td>确认密码</td> <td><input type="password" name="u_rpasswd" class="td"></td></tr>
                <tr><td>真实姓名</td><td><input type="text" name="u_realname" class="td"></td></tr>
                <tr><td>年龄</td><td><input type="text" name="u_age" class="td"></td></tr>
                <tr><td>性别</td><td><select  name="u_sex" class="sex">
                            <option value="保密">保密</option>
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select></td>
                </tr>
                <tr><td>地址</td> <td><input type="text" name="u_address" class="td"></td></tr>
                <tr><td>图像</td> <td><input type="text" name="u_hpicture" class="td"></td></tr>
                <tr><td>学院</td><td><select name="u_institute" class="institute">
                            <option value="信息学院">信息学院</option>
                            <option value="艺术学院">艺术学院</option>
                        </select></td>
                </tr>
                <tr><td>专业</td><td><select name="u_major" class="major">
                            <option value="网络工程">网络工程</option>
                            <option value="计算机科学与技术">计算机科学与技术</option>
                            <option value="信息与计算科学">信息与计算科学</option>
                        </select></td>
                </tr>
                <tr><td>班级</td> <td><input type="text" name="u_class" class="td"></td></tr>
                <tr><td>学号</td> <td><input type="text" name="u_studentid" class="td"></td></tr>
                <tr><td>邮箱</td> <td><input type="text" name="u_email" class="td"></td></tr>
                <tr><td>验证码：<img src="../VerifyCodeServlet"></td><td><input type="text" name="code"></td></tr>
                <tr><td colspan="2" align="center"><input type="submit" value="提交"></td></tr>
            </table>-->

            <input type="text" name="u_name" id="name" class="input-block-level" placeholder="*用户名" onblur="shiquguangbiao()"><font id="msg1"></font></li><br/>
        <input type="password" class="input-block-level" name="u_passwd" placeholder="*密码" id="pswd"></li><br/>
        <input type="password" name="u_rpasswd" class="input-block-level" id="rpswd" placeholder="*确认密码" onblur="checkp()"><font id="msg2"></font></li><br/>
    <input type="text" name="u_realname" class="input-block-level" id="name" placeholder="*真实姓名" onblur="checkname()"><font id="msg5"></font></li><br/>
<input type="text" name="u_age" class="input-block-level" placeholder="*年龄" class="td"></li><br/>
<select name="u_sex" class="select">
    <option value=""><--请选择性别--></option>
    <option value="保密">保密</option>
    <option value="男">男</option>
    <option value="女">女</option>
</select></li><br/>
<input type="text" name="u_address" class="input-block-level" placeholder="地址"><br/>
<select name="u_institute" class="select" >
    <option value=""><--请选择学院--></option>
    <option value="信息学院">信息学院</option>
    <option value="艺术学院">艺术学院</option>
</select></li><br/>
<select name="u_major" class="select">
    <option value=""><--请选择专业--></option>
    <option value="网络工程">网络工程</option>
    <option value="计算机科学与技术">计算机科学与技术</option>
    <option value="信息与计算科学">信息与计算科学</option>
</select></li><br/>
<input type="text" name="u_class" class="input-block-level" placeholder="*班级"><br/>
<input type="text" name="u_studentid" class="input-block-level" placeholder="*学号" onblur="shiquguangbiao1()" id="studentid"> <font class="font"id="msg3"></font><br/>
<input type="text" name="u_email" id="email" class="input-block-level"  placeholder="*邮箱" onblur="leave()"> <font class="font"id="msg4"></font><br/>
<img alt="看不清楚?点击更换验证码" src="../VerifyCodeServlet" class="img"  onclick="crash(this)">&nbsp;&nbsp;点击图片刷新</br></br>
<input type="text" name="code" class="input-block-level" placeholder="*验证码"> </br>
<input type="submit"  value="确认注册" id="submit"  class="btn btn-large btn-primary" onclick="return checkform()">
<button onclick="reset()" value="重置" class="btn btn-large btn-primary" id="button">重置</button>
</div>

</form>
</body>
</html>
