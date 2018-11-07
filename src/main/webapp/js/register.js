//md5对密码加密,然后比较两次输入的密码是否相同
//        function md5jiami() {
//            var password = hex_md5(document.getElementById("pswd").value);
//            var rpassword = hex_md5(document.getElementById("rpswd").value);
//            document.getElementById("pswd").value = password;
//            document.getElementById("rpswd").value = rpassword;
//        }
//刷新验证码
function crash(t) {
    t.src = "../VerifyCodeServlet?a=" + Math.random() + 10;
}
//将用户名发到后台验证
function shiquguangbiao() {
    var username = document.getElementById("name").value;
    if (username.search(/^[A-Za-z0-9]+$/) == -1) {
        document.getElementById("msg1").innerHTML = "用户名必须是字母或数字";
    } else {
        StartAjax("post", "../CheckServlet", true, "username=" + username);
    }
}

    //将学号发到后台验证
function shiquguangbiao1() {
    var studentid = document.getElementById("studentid").value;
    StartAjax("post", "../CheckStudentidServlet", true, "studentid=" + studentid);
}

//检查和用户名学号是否已存在
function CallbackSuccess() {
    var t1 = xmlHttpRequest.responseText;
    var t2 = xmlHttpRequest.responseText;
    var text1 = eval("(" + t1 + ")");
    var text2 = eval("(" + t2 + ")");
    //alert(text2.id);
    if (text1.id == "true") {
        document.getElementById("msg1").innerHTML = "用户名已经存在";
        document.form.u_name.value = "";
    } else {
        document.getElementById("msg1").innerHTML = "";
    }
    if (text2.id == "1") {
        document.getElementById("msg3").innerHTML = "该学号已经存在";
        document.form.u_studentid.value = "";
    } else {
        document.getElementById("msg3").innerHTML = "";
    }
}

//检查两次输入的密码是否相同
function checkp() {
    var pswd = document.getElementById("pswd").value;
    var rpswd = document.getElementById("rpswd").value;
    if (rpswd != pswd) {
        document.getElementById("msg2").innerHTML = "两次输入的密码不同";
    } else {
        document.getElementById("msg2").innerHTML = "";
    }
}

//检查姓名是否不全部是汉字
function checkname(){
    var name = document.getElementById("name").value;
    if(name.search(/[u4E00-u9FA5]/g)==-1){
        document.getElementById("msg5").innerHTML="请输入真实姓名";
    }else{
        document.getElementById("msg5").innerHTML="";
    }
}

//判断表单是否有没有填写的内容
function checkform() {
    if (document.form.u_name.value =="") {
        document.form.u_name.focus();
        alert("请填写用户名");
        return false;
    } else if (document.form.u_passwd.value == "") {
        document.form.u_passwd.focus();
        alert("请填写密码");
        return false;
    } else if (document.form.u_rpasswd.value == "") {
        document.form.u_rpasswd.focus();
        alert("请确认密码");
        return false;
    } else if (document.form.u_realname.value == "") {
        document.form.u_realname.focus();
        alert("请填写真实姓名");
        return false;
    } else if (document.form.u_age.value == "") {
        document.form.u_age.focus();
        alert("请填写年龄");
        return false;
    } else if (document.form.u_institute.value == "") {
        document.form.u_class.focus();
        alert("请填写学院");
        return false;
    } else if (document.form.u_major.value == "") {
        document.form.u_class.focus();
        alert("请填写专业");
        return false;
    }else if (document.form.u_class.value == "") {
        document.form.u_class.focus();
        alert("请填写班级");
        return false;
    }  else if (document.form.u_studentid.value == "") {
        document.form.u_studentid.focus();
        alert("请填写学号");
        return false;
    } else if (document.form.u_email.value == "") {
        document.form.u_email.focus();
        alert("请填写邮箱");
        return false;
    } else if (document.form.code.value == "") {
        document.form.code.focus();
        alert("请填写注册码");
        return false;
    }
}

function reset() {
    document.form.reset();
}

function leave() {
    var email = document.getElementById("email").value;
    if (email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) == -1) {
        document.getElementById("msg4").innerHTML = "邮箱输入不正确";
    } else {
        document.getElementById("msg4").innerHTML = "";
    }
}