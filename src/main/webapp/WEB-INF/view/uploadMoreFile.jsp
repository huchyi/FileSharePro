<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/6
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <style>
        .Center {
            text-align: center;
        }

        .inputSubmit {
            margin-top: 60px;
            height: 32px;
            width: 120px;
            background: #64AEE0;
            color: #FFFFFF;
        }

        .inputAdd {
            margin-top: 10px;
            height: 40px;
            width: 34px;
            background: image("<%=basePath%>image/add_file.png");
        }
    </style>
    <script type="text/javascript">
        function _add() {
            var tb = document.getElementById("tb");
            //写入一行
            var tr = tb.insertRow();
            //写入列
            var td = tr.insertCell();
            //写入数据
            td.innerHTML = "File：";
            //再声明一个新的td
            var td2 = tr.insertCell();
            //写入一个input
            var timestamp = new Date().getTime();

            td2.innerHTML = '<input type="file" name= "' + timestamp + '" /><button onclick="_del(this);">删除</button>';
        }
        function _del(btn) {
            var tr = btn.parentNode.parentNode;
            //alert(tr.tagName);
            //获取tr在table中的下标
            var index = tr.rowIndex;
            //删除
            var tb = document.getElementById("tb");
            tb.deleteRow(index);
        }
        function _submit() {
            //遍历所的有文件
            var files = document.getElementsByName("file");
            if (files.length == 0) {
                alert("没有可以上传的文件");
                return false;
            }
            for (var i = 0; i < files.length; i++) {
                if (files[i].value == "") {
                    alert("第" + (i + 1) + "个文件不能为空");
                    return false;
                }
            }
            document.forms['formSubmit'].submit();
        }
    </script>
</head>
<body>
<form name="formSubmit" action="/hcy/file/doMultiUpload" method="post" enctype="multipart/form-data" class="Center">
    <table id="tb" border="1" style="margin-top: 100px" align="center">
        <tr>
            <td>
                File：
            </td>
            <td>
                <input type="file" name="file">
                <button onclick="_del(this);">删除</button>
            </td>
        </tr>
    </table>
    <%--<input type="button" onclick="_add();" value="增加文件" class="inputAdd">--%>
    <img src="<%=basePath%>image/add_file.png" alt="" onclick="_add();" class="inputAdd">
    <p/>
    <input type="button" onclick="_submit();" value="上传" class="inputSubmit" align="right">
    <%--<img src="<%=basePath%>image/add_file.png" alt="">--%>
</form>
</body>
</html>