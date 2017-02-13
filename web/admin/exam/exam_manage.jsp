<%-- 
    Document   : 
    Created on : 2014-6-19, 9:48:30
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../../images/b128.png" rel="icon" type="images/x-ico"/>
        <link href="../../EasyUI/themes/icon.css" rel="stylesheet" />
        <link href="../../EasyUI/themes/default/easyui.css" rel="stylesheet" />
        <script src="../../EasyUI/jquery.min.js"></script>
        <script src="../../EasyUI/jquery.easyui.min.js"></script>
        <script src="../../EasyUI/locale/easyui-lang-zh_CN.js"></script>
        <title>管理员信息管理</title>
    </head>
    <body>
        <table id="dg">
        </table>
    </body>
</html>

<script>
    var flag;
    $('#dg').datagrid({
        url: '../../GetExamServlet',
        loadMsg: "数据加载中...",
        fit: true,
        singleSelect: true,
        fitColumns: true,
        onSelect: function() {
            $('#btn_cut').linkbutton('enable');
        },
        onUnselect: function() {
            $('#btn_cut').linkbutton('disable');
        },
        columns: [[
                {field: 'id', title: '试卷序号', width: 20},
                {field: 'title', title: '试卷标题', width: 40},
                {field: 'name', title: '试卷名', width: 40}
            ]],
        toolbar: [{
                iconCls: 'icon-cut',
                id: 'btn_cut',
                text: '删除',
                disabled: true,
                handler: function() {
                    var row = $('#dg').datagrid("getSelected");
                    $.messager.confirm('删除', '确认删除吗？', function(r) {
                        if (r) {
                            // 退出操作;
                            $.ajax({
                                type: "post",
                                url: "../../delExamServlet",
                                data: {
                                    id: row.id
                                },
                                success: function(data) {
                                    var data = eval("(" + data + ")");
                                    if (data.data == "1") {
                                        $.messager.alert('我的消息', '删除成功!', 'info');
                                        $('#dg').datagrid('reload', null);
                                        $('#btn_cut').linkbutton('disable');
                                    }
                                    else {
                                        $.messager.alert('我的消息', '删除失败!', 'info');
                                    }
                                }
                            });
                        }
                    });
                }
            }]

    });
</script>
