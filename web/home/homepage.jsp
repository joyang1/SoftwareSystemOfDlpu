<%-- 
    Document   : test
    Created on : 2014-9-9, 19:44:09
    Author     : Pefla_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">     
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="<%=cp%>/images/b128.png" rel="icon" type="images/x-ico"/>
        <title>软件技术应用研究室</title>
        <!-- Le styles -->
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">      
        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
            @-ms-viewport       
            { 
                width: device-width; 
            }
            @-webkit-viewport   
            { 
                width: device-width; 
            }
            @-moz-viewport      
            {
                width: device-width; 
            }
            @-ms-viewport       
            { 
                width: device-width; 
            }
            @-o-viewport        
            { 
                width: device-width; 
            }
            @viewport           
            { 
                width: device-width; 
            }
            @media (max-width: 980px) {
                /* Enable use of floated navbar text */
                .navbar-text.pull-right {
                    float: none;
                    padding-left: 5px;
                    padding-right: 5px;
                }
            }
            /* Carousel base class */
            .carousel {
                margin-bottom: 60px;
            }

            .carousel .container {
                position: relative;
                z-index: 9;
            }

            .carousel-control {
                height: 80px;
                margin-top: 0;
                font-size: 120px;
                text-shadow: 0 1px 1px rgba(0,0,0,.4);
                background-color: transparent;
                border: 0;
                z-index: 10;
            }

            .carousel .item {
                height: 500px;
            }
            .carousel img {
                position: absolute;
                top: 0;
                left: 0;
                min-width: 100%;
                height: 500px;
            }

            .carousel-caption {
                background-color: transparent;
                position: static;
                max-width: 550px;
                padding: 0 20px;
                margin-top: 200px;
            }
            .carousel-caption h1,
            .carousel-caption .lead {
                margin: 0;
                line-height: 1.25;
                color: #fff;
                text-shadow: 0 1px 1px rgba(0,0,0,.4);
            }
            .carousel-caption .btn {
                margin-top: 10px;
            }


        </style>
        <link href="<%=cp%>/css/bootstrap-responsive.css" rel="stylesheet">

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="../assets/js/html5shiv.js"></script>
        <![endif]-->

        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
        <link rel="shortcut icon" href="<%=cp%>/assets/ico/favicon.png">
    </head>

    <body background="<%=cp%>/img/bg.jpg">
        <%
            String user = session.getAttribute("user").toString();
            String userpower = session.getAttribute("userpower").toString();
        %>

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="#">软件技术应用研究室</a>

                    <div class="nav-collapse collapse">
                        <p class="navbar-text pull-right">

                            <% if (userpower == "0") {%>
                            <span>欢迎游客</span>
                            <a href="<%=cp%>/login/login.jsp">登陆</a>
                            <a href="<%=cp%>/login/register.jsp">注册</a>
                            <%} else if (userpower == "2") {%>
                            <span>管理员：<%=user%></span>
                            <a href="<%=cp%>/index.jsp">注销</a>
                            <%} else {%>
                            <span>用户：<%=user%></span>
                            <a href="<%=cp%>/LoginServlet">个人信息</a>
                            <a href="<%=cp%>/index.jsp">注销</a>
                            <%}%>

                        </p>
                        <ul class="nav">
                            <li class="active"><a href="<%=cp%>/home/homepage.jsp">首页</a></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=2">新闻</a></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=3">论坛</a></td></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=4">相册</a></td></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=5">资源</a></td></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=6">咨询</a></li>
                            <li><a href="<%=cp%>/JudgeServlet?judge=7">答题系统</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class="container" >
            <div id="myCarousel" class="carousel slide">
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="../img/1.jpg" alt="">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>Java</h1>
                                <p class="lead">Java是一种可以撰写跨平台应用软件的面向对象的程序设计语言，是由Sun Microsystems公司于1995年5月推出的Java程序设计语言和Java平台（即JavaSE, JavaEE, JavaME）的总称。Java 技术具有卓越的通用性、高效性、平台移植性和安全性，广泛应用于个人PC、数据中心、游戏控制台、科学超级计算机、移动电话和互联网，同时拥有全球最大的开发者专业社群。</p>
                                <a class="btn btn-large btn-primary" href="http://resource.boxuegu.com/java/" target="_blank">点击学习</a>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <img src="../img/4.jpg" alt="">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>C#</h1>
                                <p class="lead">C#是微软公司发布的一种面向对象的、运行于.NET Framework之上的高级程序设计语言。并定于在微软职业开发者论坛(PDC)上登台亮相。C#是微软公司研究员Anders Hejlsberg的最新成果。</p>
                                <a class="btn btn-large btn-primary" href="http://resource.boxuegu.com/net/" target="_blank">点击学习</a>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <img src="../img/2.jpg" alt="">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>PHP</h1>
                                <p class="lead">PHP（外文名: Hypertext Preprocessor，中文名：“超文本预处理器”）是一种通用开源脚本语言。语法吸收了C语言、Java和Perl的特点，易于学习，使用广泛，主要适用于Web开发领域。</p>
                                <a class="btn btn-large btn-primary" href="http://resource.boxuegu.com/php/" target="_blank">点击学习</a>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <img src="../img/3.jpg" alt="">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1 style="color:#00FFFF">GitHub</h1>
                                <p class="lead" style="color:#00FFFF">Git是一个分布式的版本控制系统，最初由Linus Torvalds编写，用作Linux内核代码的管理。在推出后，Git在其它项目中也取得了很大成功，尤其是在Ruby社区中。目前，包括Rubinius、Merb和Bitcoin在内的很多知名项目都使用了Git。Git同样可以被诸如Capistrano和Vlad the Deployer这样的部署工具所使用。</p>
                                <a class="btn btn-large btn-primary" href="https://github.com/joyang1" target="_blank">我的Git</a>
                            </div>
                        </div>
                    </div>
                </div>
                <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
            </div><!-- /.carousel --> 
            <div class="row-fluid">

                <div class="span13">            

                    <div class="span6">
                        <h2>资源下载</h2>
                        <p>该处是网站下载资源的中心,点击进入下载</p>
                        <p><a class="btn" href="<%=cp%>/ResServlet">前往下载&raquo;</a></p>
                    </div><!--/span-->
                    <div class="span6">
                        <h2>计算机语言介绍</h2>
                        <p>当下各大流行的编程语言介绍</p>
                        <p><a class="btn" href="http://www.cnblogs.com/joyang/p/4141358.html" target="_blank">查看介绍&raquo;</a></p>
                    </div><!--/span-->

                    <div class="">
                        <div class="span6">
                            <h2>联系我们</h2>
                            <p>网站开发人员</p>
                            <p><a class="btn" href="../home/contact.jsp">联系&raquo;</a></p>
                        </div><!--/span-->
                        <div class="span6">
                            <h2>研究室书籍一览表</h2>
                            <p>大家可以从这里查看想借阅的书籍</p>
                            <p><a class="btn" href="<%=cp%>/showpage/bookpage.jsp">查看书籍&raquo;</a></p>
                        </div><!--/span-->
                    </div><!--/row-->
                </div><!--/span-->

            </div><!--/row-->

        </div><!--/.fluid-container-->
<!--        Google站内搜索开始
        <script type="text/javascript">
            function googlesearch() {
                var wq = document.getElementsByName("wq")[0].value;
                var link = "http://www.google.com/search?domains=www.ziyexing.com&sitesearch=www.ziyexing.com&q=" + wq;
                window.open(link);
            }
        </script>
        <input type="text" name="wq"/><input type="submit" onclick="javascript :googlesearch()" value="Google 搜索" />
        Google站内搜索结束-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="<%=cp%>/js/jquery.js"></script>
        <script src="<%=cp%>/js/bootstrap-transition.js"></script>
        <script src="<%=cp%>/js/bootstrap-alert.js"></script>
        <script src="<%=cp%>/js/bootstrap-modal.js"></script>
        <script src="<%=cp%>/js/bootstrap-dropdown.js"></script>
        <script src="<%=cp%>/js/bootstrap-scrollspy.js"></script>
        <script src="<%=cp%>/js/bootstrap-tab.js"></script>
        <script src="<%=cp%>/js/bootstrap-tooltip.js"></script>
        <script src="<%=cp%>/js/bootstrap-popover.js"></script>
        <script src="<%=cp%>/js/bootstrap-button.js"></script>
        <script src="<%=cp%>/js/bootstrap-collapse.js"></script>
        <script src="<%=cp%>/js/bootstrap-carousel.js"></script>
        <script src="<%=cp%>/js/bootstrap-typeahead.js"></script>
        <script>
            !function($) {
                $(function() {
                    // carousel demo
                    $('#myCarousel').carousel();
                });
            }(window.jQuery);
        </script>
        <script src="../assets/js/holder/holder.js"></script>
    </body>
</html>