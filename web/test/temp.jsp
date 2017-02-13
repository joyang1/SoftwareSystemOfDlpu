<%-- 
    Document   : wordforexam
    Created on : 2014-11-29, 17:17:35
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="10;url=<%=cp%>/ExamListServlet"> 
        <link href="<%=cp%>/images/b128.png" rel="icon" type="images/x-ico"/>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">
        <script type="text/javascript" src="<%=cp%>/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%=cp%>/js/jquery.js"></script>
        <title>答题系统--试卷下载</title>
        <style type="text/css">
            * { 
                box-sizing: border-box; 
            } 
            html { 
                height: 100%; 
            } 
            body { 
                background: #efeeea; 
                background: linear-gradient(#f9f9f9, #cecbc4); 
                background: -moz-linear-gradient(#f9f9f9, #cecbc4); 
                background: -webkit-linear-gradient(#f9f9f9, #cecbc4); 
                background: -o-linear-gradient(#f9f9f9, #cecbc4); 
                color: #757575; 
                font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif; 
                text-align: center; 
            } 
            h1, p { 
                padding:0; margin:0; 
            } 
            .wrapper { 
                width: 450px; 
                margin: 200px auto; 
            } 
            .wrapper p a {color:#757575; text-decoration:none;} 
            .wrapper .load-bar { 
                width: 100%; 
                height: 25px; 
                border-radius: 30px; 
                background: #dcdbd7; 
                position: relative; 
                box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8), inset 0 2px 3px rgba(0, 0, 0, 0.2); 
            } 
            .wrapper .load-bar:hover .load-bar-inner, .wrapper .load-bar:hover #counter { 
                animation-play-state: paused; 
                -moz-animation-play-state: paused; 
                -o-animation-play-state: paused; 
                -webkit-animation-play-state: paused; 
            } 
            .wrapper .load-bar-inner { 
                height: 99%; 
                width: 0%; 
                border-radius: inherit; 
                position: relative; 
                background: #c2d7ac; 
                background: linear-gradient(#e0f6c8, #98ad84); 
                background: -moz-linear-gradient(#e0f6c8, #98ad84); 
                background: -webkit-linear-gradient(#e0f6c8, #98ad84); 
                background: -o-linear-gradient(#e0f6c8, #98ad84); 
                box-shadow: inset 0 1px 0 rgba(255, 255, 255, 1), 0 1px 5px rgba(0, 0, 0, 0.3), 0 4px 5px rgba(0, 0, 0, 0.3); 
                animation: loader 10s linear infinite; 
                -moz-animation: loader 10s linear infinite; 
                -webkit-animation: loader 10s linear infinite; 
                -o-animation: loader 10s linear infinite; 
            } 
            .wrapper #counter { 
                position: absolute; 
                background: #eeeff3; 
                background: linear-gradient(#eeeff3, #cbcbd3); 
                background: -moz-linear-gradient(#eeeff3, #cbcbd3); 
                background: -webkit-linear-gradient(#eeeff3, #cbcbd3); 
                background: -o-linear-gradient(#eeeff3, #cbcbd3); 
                padding: 5px 10px; 
                border-radius: 0.4em; 
                box-shadow: inset 0 1px 0 rgba(255, 255, 255, 1), 0 2px 4px 1px rgba(0, 0, 0, 0.2), 0 1px 3px 1px rgba(0, 0, 0, 0.1); 
                left: -25px; 
                top: -50px; 
                font-size: 12px; 
                font-weight: bold; 
                width: 44px; 
                animation: counter 10s linear infinite; 
                -moz-animation: counter 10s linear infinite; 
                -webkit-animation: counter 10s linear infinite; 
                -o-animation: counter 10s linear infinite; 
            } 
            .wrapper #counter:after { 
                content: ""; 
                position: absolute; 
                width: 8px; 
                height: 8px; 
                background: #cbcbd3; 
                transform: rotate(45deg); 
                -moz-transform: rotate(45deg); 
                -webkit-transform: rotate(45deg); 
                -o-transform: rotate(45deg); 
                left: 50%; 
                margin-left: -4px; 
                bottom: -4px; 
                box-shadow: 3px 3px 4px rgba(0, 0, 0, 0.2), 1px 1px 1px 1px rgba(0, 0, 0, 0.1); 
                border-radius: 0 0 3px 0; 
            } 
            .wrapper h1 { 
                font-size: 28px; 
                padding: 20px 0 8px 0; 
            } 
            .wrapper p { 
                font-size: 13px; 
            } 
            @keyframes loader { 
                from { 
                    width: 0%; 
                } 
                to { 
                    width: 100%; 
                } 
            } 
            @-moz-keyframes loader { 
                from { 
                    width: 0%; 
                } 
                to { 
                    width: 100%; 
                } 
            } 
            @-webkit-keyframes loader { 
                from { 
                    width: 0%; 
                } 
                to { 
                    width: 100%; 
                } 
            } 
            @-o-keyframes loader { 
                from { 
                    width: 0%; 
                } 
                to { 
                    width: 100%; 
                } 
            } 
            @keyframes counter { 
                from { 
                    left: -25px; 
                } 
                to { 
                    left: 323px; 
                } 
            } 
            @-moz-keyframes counter { 
                from { 
                    left: -25px; 
                } 
                to { 
                    left: 323px; 
                } 
            } 
            @-webkit-keyframes counter { 
                from { 
                    left: -25px; 
                } 
                to { 
                    left: 323px; 
                } 
            } 
            @-o-keyframes counter { 
                from { 
                    left: -25px; 
                } 
                to { 
                    left: 323px; 
                } 
            } 
        </style>
        <script type="text/javascript">
            $(function() {
                var interval = setInterval(increment, 100);
                var current = 0;
                function increment() {
                    current++;
                    $('#counter').html(current + '%');
                    if (current == 100) {
                      clearInterval(interval);
                      return false;
                    }
                }
//                $('.load-bar').mouseover(function() {
//                    clearInterval(interval);
//                }).mouseout(function() {
//                    interval = setInterval(increment, 10000);
//                });
            });
        </script>
    </head>
    <body>
        <div class="wrapper"> 
            <div class="load-bar"> 
                <div class="load-bar-inner" data-loading="0"> <span id="counter"></span> </div> 
            </div> 
            <h1>加载中...</h1> 
            <p>即将进入答题系统的试卷下载界面(By:Joyang)</p> 
        </div> 
    </body>
</html>
