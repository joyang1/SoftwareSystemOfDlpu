<%-- 
    Document   : useradd
    Created on : 2014-11-30, 15:31:04
    Author     : 挺
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../images/b128.png" rel="icon" type="images/x-ico"/>
        <link href="../css/bootstrap.css" rel="stylesheet">
        <script type="text/javascript" src="../js/jquery.js"></script>
        <title>用户上传资料</title>
        <script type="text/javascript">
            $(function() {
                var i = 2;
                $("#addFile").click(function() {
                    $(this).parent().parent().before("<tr class = 'file'><td> 文件"
                            + i + "</td><td > <input type = 'file' name = 'file"
                            + i + "' /> </td></tr><tr class = 'desc' ><td > 描述"
                            + i + " </td><td > <input type = 'text' name = 'desc"
                            + i + "'/> <button id='delete" + i + "'>删除</button></td></tr>");
                    i++;

                    $('#delete' + (i - 1)).click(function() {
                        var $tr = $(this).parent().parent();
                        $tr.prev().remove();
                        $tr.remove();

                        //对结点排序
                        $(".file").each(function(index) {
                            var num = index + 1;
                            $(this).find("td:first").text("文件"+num);
                            $(this).find("td:last input").attr("name","file"+num);
                        });
                         $(".desc").each(function(index) {
                            var num = index + 1;
                            $(this).find("td:first").text("描述"+num);
                            $(this).find("td:last input").attr("name","desc"+num);
                        });
                    });
                });
            });
        </script>
    </head>
    <body>
        <table>
            <tr class = "file">
                <td> 文件1 </td>
                <td > <input type = "file" name = "file1" value = "" /> </td>
            </tr>
            <tr class = "desc" >
                <td > 描述1 </td>
                <td > <input type = "text" name = "desc1" value = "" /> </td>
            </tr>
            <tr >
                <td > <input type = "submit" value = "提交" /> </td>
                <td > <input id = "addFile" type = "button" value = "新增一个文件" /> </td>
            </tr>
        </table>
    </body>
</html>
