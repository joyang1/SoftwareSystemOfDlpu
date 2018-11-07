<%-- 
    Document   : manageuser
    Created on : 2014-6-19, 9:48:30
    Author     : 挺
    注释:这是对普通用户进行增删改查的界面
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
        <title>用户信息管理</title>
    </head>
    <body>
        <table id="dg">
        </table>
    </body>
</html>

<script>
    var flag;
    var dep = [{"value": "信息学院", "text": "信息学院"}];
    var major = [{"value": "网络工程", "text": "网络工程"}, {"value": "计算机科学与工程", "text": "计算机科学与工程"}];
    var sex = [{"value": "男", "text": "男"}, {"value": "女", "text": "女"}];
    var Class = [{"value": "网络121", "text": "网络121"}, {"value": "网络122", "text": "网络122"}, {"value": "计算机121", "text": "计算机121"}, {"value": "计算机122", "text": "计算机122"}, {"value": "计算机123", "text": "计算机123"}];

    $('#dg').datagrid({
        url: '../../UserServlet',
        loadMsg: "数据加载中...",
        pagination: true,
        fit: true,
        singleSelect: true,
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
                {field: 'uname', title: '用户名', width: 10, editor: 'text'},
                {field: 'urealname', title: '姓名', width: 10, editor: 'text'},
                {field: 'uage', title: '年龄', width: 5, editor: 'numberbox'},
                {field: 'usex', title: '性别', width: 5,
                    editor: {
                        type: 'combobox', options: {data: sex, valueField: 'value', textField: 'text', panelHeight: 'auto', editable: false}
                    }
                },
                {field: 'uaddress', title: '地址', width: 15, editor: 'text'},
                {field: 'uinstitute', title: '学院', width: 10,
                    editor: {
                        type: 'combobox', options: {data: dep, valueField: 'value', textField: 'text', panelHeight: 'auto', editable: false}
                    }
                },
                {field: 'umajor', title: '专业', width: 10,
                    editor: {
                        type: 'combobox', options: {data: major, valueField: 'value', textField: 'text', panelHeight: 'auto', editable: false}
                    }
                },
                {field: 'uclass', title: '班级', width: 10,
                    editor: {
                        type: 'combobox', options: {data: Class, valueField: 'value', textField: 'text', panelHeight: 'auto', editable: false}
                    }
                },
                {field: 'ustudentid', title: '学号', width: 10},
                {field: 'uemail', title: '邮箱', width: 15, editor: 'text'}
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
                    if (row.uname + "" == "" || row.urealname + "" == "") {
                        alert("信息不能为空!");
                        $('#btn_edit').linkbutton('enable');
                        $('#btn_no').linkbutton('enable');
                        $('#btn_save').linkbutton('enable');
                        $('#dg').datagrid('beginEdit', index);
                        return;
                    }
                    if (flag == 1) {
                        $.messager.prompt('提示信息', '请输入学号：', function(r) {
                            if (r) {
                                row.ustudentid = r;
                                $.ajax({
                                    type: "post",
                                    url: "../../UserAdminServlet", //对管理员进行添加和编辑进行逻辑处理的servlet
                                    data: {
                                        flag: flag,
                                        ustudentid: row.ustudentid,
                                        uname: row.uname,
                                        urealname: row.urealname,
                                        uage: row.uage,
                                        usex: row.usex,
                                        uaddress: row.uaddress,
                                        uinstitute: row.uinstitute,
                                        umajor: row.umajor,
                                        uclass: row.uclass,
                                        uemail: row.uemail
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
                                            $('#dg').datagrid('reload', null);
                                        }
                                        else if (datas.data == "2") {
                                            $.messager.alert('我的消息', '添加失败!', 'info');
                                            $('#dg').datagrid('reload', null);
                                        } else {
                                            $.messager.alert('我的消息', '添加的用户名已存在!', 'info');
                                            //$('#dg').datagrid('reload', null);
                                            $('#dg').datagrid('beginEdit', 0);
                                        }
                                    }
                                });
                            }
                        });
                    } else if (flag == 2) {
                        $.ajax({
                            type: "post",
                            url: "../../UserAdminServlet", //对管理员进行添加和编辑进行逻辑处理的servlet
                            data: {
                                flag: flag,
                                ustudentid: row.ustudentid,
                                uname: row.uname,
                                urealname: row.urealname,
                                uage: row.uage,
                                usex: row.usex,
                                uaddress: row.uaddress,
                                uinstitute: row.uinstitute,
                                umajor: row.umajor,
                                uclass: row.uclass,
                                uemail: row.uemail
                            },
                            success: function(datas) {
                                var datas = eval("(" + datas + ")");
                                if (datas.data == "1") {
                                    $.messager.alert('我的消息', '编辑成功!', 'info');
                                    $('#dg').datagrid('reload', null);
                                    $('#btn_edit').linkbutton('disable');
                                    $('#btn_no').linkbutton('disable');
                                    $('#btn_save').linkbutton('disable');
                                    $('#btn_reload').linkbutton('disable');
                                    $('#btn_cut').linkbutton('disable');
                                    $('#dg').datagrid('reload', null);
                                }
                                else {
                                    $.messager.alert('我的消息', '编辑失败!', 'info');
                                    $('#dg').datagrid('reload', null);
                                }
                            }
                        });
                    }

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
                                url: "../../UserAdminServlet",
                                data: {
                                    flag: flag,
                                    ustudentid: row.ustudentid
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
                            flag = 4;
                            // 退出操作;
                            $.ajax({
                                type: "post",
                                url: "../../UserAdminServlet",
                                data: {
                                    flag: flag,
                                    ustudentid: row.ustudentid
                                },
                                success: function(datas) {
                                    var datas = eval("(" + datas + ")");
                                    if (datas.data == "7") {
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
