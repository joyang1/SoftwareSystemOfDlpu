<%-- 
    Document   : adminmanage
    Created on : 2014-9-8, 18:24:15
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
        <link href="<%=cp%>/EasyUI/themes/icon.css" rel="stylesheet" />
        <link href="<%=cp%>/EasyUI/themes/default/easyui.css" rel="stylesheet" />
        <script src="<%=cp%>/EasyUI/jquery.min.js"></script>
        <script src="<%=cp%>/EasyUI/jquery.easyui.min.js"></script>
        <script src="<%=cp%>/EasyUI/locale/easyui-lang-zh_CN.js"></script>
        <title>后台管理</title>
        <style type="text/css">
            a{
                text-decoration: none;
                color:#00ff00;
                font-size: 10px;
            }
            a:hover{
                color:turquoise;
                font-size: 15px;
            }
        </style>
    </head>
    <body class="easyui-layout">
        <div data-options="region:'west',title:'后台管理导航',split:false" id="aa" class="easyui-accordion" style="width:200px;height:650px;">  
            <div title="用户管理" data-options="iconCls:'icon-user',selected:true" style="overflow:auto;padding:10px;">   
                <a href="#" onclick="addTab('管理员管理', 'usermanage/manageadmin.jsp', 'icon-user')"><img src="../EasyUI/themes/icons/user.png">管理员信息管理</a><br/><br/>
                <a href="#" onclick="addTab('用户管理', 'usermanage/manageuser.jsp', 'icon-user')"><img src="../EasyUI/themes/icons/user.png">普通用户信息管理</a>
            </div>   
            <div title="新闻相册管理" data-options="iconCls:'icon-reload'" style="padding:10px;">   
                <a href="#" onclick="addTab('新闻发布', 'news/addnews.jsp')">1、新闻发布</a><br/><br/>
                <a href="#" onclick="addTab('新闻管理', 'news/newsmanage.jsp')">2、新闻管理</a><br/><br/>
                <a href="#" onclick="addTab('相册添加', 'album/addalbum.jsp')">3、相册添加</a><br/><br/>
                <a href="#" onclick="addTab('相册管理', 'album/albummanage.jsp')">4、相册管理</a><br/><br/>
            </div>   
            <div title="资源管理" data-options="iconCls:'icon-reload'" style="padding:10px;">   
                <a href="#" onclick="addTab('上传资源', 'resources/uploadres.jsp')">1、上传资源</a><br/><br/>
                <a href="#" onclick="addTab('资源管理', 'resources/manageres.jsp')">2、资源管理</a><br/><br/>   
            </div>
            <div title="答题系统管理" data-options="iconCls:'icon-reload'" style="padding:10px;">   
                <a href="#" onclick="addTab('添加试卷', 'exam/exam.jsp')">1、添加试卷(word)</a><br/><br/>
                <a href="#" onclick="addTab('试卷管理', 'exam/exam_manage.jsp')">2、试卷管理</a><br/><br/>
                <a href="#" onclick="addTab('上传分数', 'exam/uploadscore.jsp')">3、上传分数(execl)</a><br/><br/>
            </div>  
        </div>
        <div data-options="region:'center',fit:'true'" id="tt" class="easyui-tabs" style="padding:5px;background:#eee;">
            <div title="欢迎" style="padding:20px;">   
                <marquee  scrollamount="2" direction="up" >
                    <h1>欢迎使用大连工业大学软件应用研究室后台管理系统！</h1>
                </marquee> 
            </div>    
        </div>
    </body>
</html>
<script type="text/javascript">
    function addTab(title, url, img) {
        if ($('#tt').tabs('exists', title)) {
            $('#tt').tabs('select', title);
        } else {
            var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '"  style="width:85%;height:85%;"></iframe>';
            $('#tt').tabs('add', {
                title: title,
                content: content,
                closable: true,
                iconCls: img
            });
        }
    }

</script>
