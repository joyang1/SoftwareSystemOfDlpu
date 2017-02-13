<%-- 
    Document   : manageadmin
    Created on : 2014-6-19, 9:48:30
    Author     : 挺
    注释:这是对管理员进行增删改查的界面
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
        url: '../../AdminServlet',
        loadMsg: "数据加载中...",
        fit: true,
        singleSelect:true,
        fitColumns: true,
        onSelect: function() {
            $('#btn_edit').linkbutton('enable');
            $('#btn_no').linkbutton('enable');
            $('#btn_save').linkbutton('enable');
            $('#btn_reload').linkbutton('enable');
            $('#btn_cut').linkbutton('enable');
        },
        onUnselect: function() {
            $('#btn_edit').linkbutton('disable');
            $('#btn_no').linkbutton('disable');
            $('#btn_save').linkbutton('disable');
            $('#btn_reload').linkbutton('disable');
            $('#btn_cut').linkbutton('disable');
        },
        columns: [[
                {field: 'aid', title: '序号', width: 20},
                {field: 'aname', title: '管理员名', width: 80, editor: 'text'}
            ]],
        toolbar: [
            {
                iconCls: 'icon-add',
                id: 'btn_add',
                text: '添加',
                handler: function() {
                    flag = 1;
                    $('#dg').datagrid('insertRow', {index: 0, row: {}});
                    $('#dg').datagrid('selectRow', 0);
                    $('#dg').datagrid('beginEdit', 0);
                }
            }, '-', {
                iconCls: 'icon-edit',
                id: 'btn_edit',
                text: '编辑',
                disabled: true,
                handler: function() {
                    flag = 2;
                    var row = $('#dg').datagrid("getSelected");
                    var index = $('#dg').datagrid('getRowIndex', row);
                    $('#dg').datagrid('beginEdit', index);
                }
            }, '-', {
                iconCls: 'icon-save',
                id: 'btn_save',
                text: '保存',
                disabled: true,
                handler: function() {
                    var row = $('#dg').datagrid("getSelected");
                    $('#edit').linkbutton('disable');
                    $('#no').linkbutton('disable');
                    $('#save').linkbutton('disable');
                    $('#reload').linkbutton('disable');
                    var index = $('#dg').datagrid('getRowIndex', row);
                    $('#dg').datagrid('endEdit', index);
                    if (row.aname + "" == "") {
                        alert("信息不能为空!");
                        $('#btn_edit').linkbutton('enable');
                        $('#btn_no').linkbutton('enable');
                        $('#btn_save').linkbutton('enable');
                        $('#dg').datagrid('beginEdit', index);
                        return;
                    }
                    $.ajax({
                        type: "post",
                        url: "../../AdminManageServlet_1", //对管理员进行添加和编辑进行逻辑处理的servlet
                        data: {
                            flag: flag,
                            aid: row.aid,
                            aname: row.aname
                        },
                        success: function(datas) {
                            var datas = eval("(" + datas + ")");
                            if (datas.data == "0") {
                                $.messager.alert('我的消息', '添加成功!', 'info');
                                $('#dg').datagrid('reload', null);
                                $('#btn_edit').linkbutton('disable');
                                $('#btn_no').linkbutton('disable');
                                $('#btn_save').linkbutton('disable');
                                $('#btn_reload').linkbutton('disable');
                                $('#btn_cut').linkbutton('disable');
                            }
                            else if (datas.data == "1")
                            {
                                $.messager.alert('我的消息', '编辑成功!', 'info');
                                $('#dg').datagrid('reload', null);
                                $('#btn_edit').linkbutton('disable');
                                $('#btn_no').linkbutton('disable');
                                $('#btn_save').linkbutton('disable');
                                $('#btn_reload').linkbutton('disable');
                                $('#btn_cut').linkbutton('disable');
                            }
                            else if (datas.data == "4") {
                                $.messager.alert('我的消息', '添加的管理员已经存在!', 'info');
                                $('#dg').datagrid('reload', null);
                                $('#btn_edit').linkbutton('disable');
                                $('#btn_no').linkbutton('disable');
                                $('#btn_save').linkbutton('disable');
                                $('#btn_reload').linkbutton('disable');
                                $('#btn_cut').linkbutton('disable');
                            }
                            else {
                                $.messager.alert('我的消息', '操作失败!', 'info');
                                $('#dg').datagrid('reload', null);
                            }
                        }
                    });
                }
            }, '-', {
                iconCls: 'icon-cut',
                id: 'btn_cut',
                text: '删除',
                disabled: true,
                handler: function() {
                    var row = $('#dg').datagrid("getSelected");
                    $.messager.confirm('删除', '确认删除吗？', function(r) {
                        if (r) {
                            flag = 3;
                            // 退出操作;
                            $.ajax({
                                type: "post",
                                url: "../../AdminManageServlet_1",
                                data: {
                                    flag: flag,
                                    aid: row.aid,
                                    aname: row.aname
                                },
                                success: function(data) {
                                    var data = eval("(" + data + ")");
                                    if (data.data == "5") {
                                        $.messager.alert('我的消息', '删除成功!', 'info');
                                        $('#dg').datagrid('reload', null);
                                        $('#btn_edit').linkbutton('disable');
                                        $('#btn_no').linkbutton('disable');
                                        $('#btn_save').linkbutton('disable');
                                        $('#btn_reload').linkbutton('disable');
                                        $('#btn_cut').linkbutton('disable');
                                    }
                                    else {
                                        $.messager.alert('我的消息', '删除失败!', 'info');
                                    }
                                }
                            })
                        }
                    });
                }
            }, '-', {
                iconCls: 'icon-no',
                id: 'btn_no',
                text: '取消编辑',
                disabled: true,
                handler: function() {
                    var row = $('#dg').datagrid("getSelected");
                    var index = $('#dg').datagrid('getRowIndex', row);
                    $('#dg').datagrid('cancelEdit', index);
                }
            }, '-', {
                iconCls: 'icon-reload',
                id: 'btn_reload',
                text: '重置密码',
                disabled: true,
                handler: function() {
                    var row = $('#dg').datagrid("getSelected");
                    $.messager.confirm('重置', '确认重置吗？', function(r) {
                        if (r) {
                            // 退出操作;
                            $.ajax({
                                type: "post",
                                url: "../../AdminChongzhi",
                                data: {
                                    aid: row.aid
                                },
                                success: function(datas) {
                                    var datas = eval("(" + datas + ")");
                                    if (datas.data == "0") {
                                        $.messager.alert('我的消息', '重置成功!', 'info');
                                        $('#dg').datagrid('reload', null);
                                        $('#btn_edit').linkbutton('disable');
                                        $('#btn_no').linkbutton('disable');
                                        $('#btn_save').linkbutton('disable');
                                        $('#btn_reload').linkbutton('disable');
                                        $('#btn_cut').linkbutton('disable');
                                    }
                                    else {
                                        $.messager.alert('我的消息', '重置失败!', 'info');
                                    }
                                }
                            });
                        }
                    });
                }
            }]

    });
</script>
