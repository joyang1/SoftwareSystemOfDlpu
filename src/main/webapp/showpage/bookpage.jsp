<%-- 
    Document   : bookpage
    Created on : 2014-4-29, 17:32:37
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
        <link href="../EasyUI/themes/icon.css" rel="stylesheet" />
        <link href="../EasyUI/themes/default/easyui.css" rel="stylesheet" />
        <script src="../EasyUI/jquery.min.js"></script>
        <script src="../EasyUI/jquery.easyui.min.js"></script>
        <script src="../EasyUI/locale/easyui-lang-zh_CN.js"></script>
        <link href="<%=cp%>/css/bootstrap.css" rel="stylesheet">     
        <link href="<%=cp%>/css/bootstrap-responsive.min.css" rel="stylesheet">
        <title>书籍中心</title>
    </head>
    <style type="text/css">
        body{
            text-align: center;

        }

    </style>
    <body>
        <%
            //判断session值是否有效,或者以防用户直接输地址
            String user = session.getAttribute("user").toString();
            if (user == "" || user == null) {
                response.sendRedirect("../login/login.jsp");
                return;
            }
        %>
        <!--导航开始-->
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <a class="brand" href="<%=cp%>/JudgeServlet?judge=1">返回</a>
                <h4 class="form-signin-heading">书籍中心</h4>
            </div>
        </div>
        <!--导航结束-->
        <br/><br/>
        <table id="dg">
        </table>
    </body>
</html>

<script>
    $('#dg').datagrid({
        url: '../BookServlet',
        fit: true,
        fitColumns: true,
        columns: [[
                {field: 'bid', title: '编号', width: 20},
                {field: 'bname', title: '书名', width: 30},
                {field: 'bnum', title: '剩余数量', width: 20},
                {field: 'btype', title: '类别', width: 30}
            ]],
        onLoadSuccess: function() {
//            $('.borrow').click(function() {
//                $('#dg').datagrid('unselectAll');
//                $('#dg').datagrid('selectRow', this.id);
//                var row = $('#dg').datagrid('getSelected');
//                $.messager.confirm('借阅', '您确定借阅吗？', function(r) {
//                    if (r) {
//                        $.ajax({
//                            type: "post",
//                            url: "../BookCountServlet",
//                            data: {
//                                bid: row.bid
//                            },
//                            success: function(data) {
//                                var datas = eval("(" + data + ")");
//                                if (datas.data == "0") {
//                                    $.messager.alert('我的消息', '恭喜你借阅成功，请按时归还书籍，谢谢！', 'info');
//                                    $('#dg').datagrid('reload', null);
//                                } else if (datas.data == "1") {
//                                    $.messager.alert('我的消息', '借阅失败！', 'info');
//                                }
//                                else {
//                                    $.messager.alert('我的消息', '已经借阅过了！', 'info');
//                                }
//                            }
//
//                        });
//                    }
//                });
//            });
        }
    });
</script>  
