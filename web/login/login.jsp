<%-- 
    Document   : login
    Created on : 2014-4-26, 12:13:32
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>欢迎登陆</title>
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
        <script type="text/javascript" src="../js/md5.js"></script>
        <script type="text/javascript">
            function crash(t) {
                t.src = "../VerifyCodeServlet?a=" + Math.random() + 10;
            }
//            //md5对密码加密
//            function md5jiami() {
//                    var password = hex_md5(document.getElementById("pswd").value);
//                    document.getElementById("pswd").value = password;
//            }
        </script>
        <script type="text/javascript">
            function formCheck() {
		var id = document.getElementById("u_studentid");
                var ps = document.getElementById("pswd");
		if(id.value == "" || id.value == null) {
			id.focus();
                        var ss = document.getElementById("sss");
                        alert("用户名不能为空！！");
			return false;
		}
                if(ps.value == "" || ps.value == null) {
			ps.focus();
                        alert("密码不能为空！！");
			return false;
		}
		return true;
	}
        </script>
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
        <link href="..css/bootstrap-responsive.css" rel="stylesheet">

        <script type="text/javascript">
            function d_alert()
            {
                alert("请联系管理员！！")
            }
        </script>
    </head>
    <body background="../img/bg1.jpg">
        <h1 id="h1" align="center">欢迎登陆软件应用研究室</h1>
        <form action="../LoginServlet" class="form-signin" method="post"  onsubmit="javascript:return formCheck()">
            <input type="text" class="input-block-level" name="u_studentid" id="u_studentid" placeholder="学号" onblur="CheckForm()"/>
            <input type="password" class="input-block-level" name="u_password" id="pswd" placeholder="密码" onblur="CheckForm()"/>
            <input type="text" placeholder="验证码" name="code">&nbsp;&nbsp;&nbsp;<img alt="看不清楚?点击更换验证码" src="../VerifyCodeServlet" class="img"  onclick="crash(this)"></br>
            点击图片刷新</br>
            <input type="submit" value="登陆" class="btn btn-large btn-primary">&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-large btn-primary" onclick="d_alert()" value="忘记密码？"/>&nbsp;&nbsp;&nbsp;<a id="a" href="../login/register.jsp">没有账号?</a>
        </form>
    </body>
</html>
