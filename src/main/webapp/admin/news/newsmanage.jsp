<%-- 
    Document   : newsmanage
    Created on : 2014-12-17, 12:40:20
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
        <title>新闻管理</title>
    </head>
    <body>
        <table id="dg">
        </table>
    </body>
</html>

<script>
    var flag;
    $('#dg').datagrid({
        url: '../../GetNewsServlet',
        loadMsg: "数据加载中...",
        fit: true,
        singleSelect:true,
        fitColumns: true,
        pagination:true,
        onSelect: function() {
            $('#btn_remove').linkbutton('enable');
        },
        onUnselect: function() {
            $('#btn_remove').linkbutton('disable');
        },
        columns: [[
                {field: 'nid',hidden:true},
                {field: 'ntitle', title: '新闻标题', width: 50},
                {field: 'ntime', title: '新闻发布时间', width: 50}
            ]],
        toolbar: [
            {
                iconCls: 'icon-remove',
                id: 'btn_remove',
                text: '删除',
                disabled: true,
                handler: function() {
                    var row = $('#dg').datagrid("getSelected");
                    $.messager.confirm('删除', '确认删除吗？', function(r) {
                        if (r) {
                            // 退出操作;
                            $.ajax({
                                type: "post",
                                url: "../../delNewsServlet",
                                data: {
                                    nid: row.nid
                                },
                                success: function(data) {
                                    var data = eval("(" + data + ")");
                                    if (data.data == "1") {
                                        $.messager.alert('我的消息', '删除成功!', 'info');
                                        $('#dg').datagrid('reload', null);
                                        $('#btn_remove').linkbutton('disable');
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
    
    
    //分页
    var pagenum = 10;
    load();
    function load() {
        var p = $('#dg').datagrid('getPager');
        $(p).pagination({
            pageSize: pagenum, //每页显示的记录条数，默认为10  
            pageList: [10, 20, 30], //可以设置每页记录条数的列表 
            beforePageText: '第', //页数文本框前显示的汉字  
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
            onBeforeRefresh: function(pageNumberNow, pageSizeNow) {
                pagenum = pageSizeNow;
                $('#dg').datagrid('load', null);
                load();
            }

        });
    }
</script>

