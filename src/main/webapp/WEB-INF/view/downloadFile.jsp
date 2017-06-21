<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/6
  Time: 18:20
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
    <title>文件下载</title>
    <style>
        .imageClass {
            height: 22px;
            width: 22px;
            margin-right: 5px;
        }
    </style>
    <script type="text/javascript" src="/hcy/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/hcy/js/Base64.js"></script>
    <script type="text/javascript" language="javascript">
        function loadPage(filePath, tBody) {
            $.get("/hcy/file/getFileList?path=" + filePath, function (data, status) {
//            alert("数据：" + data + "\n状态：" + status);
                var base = new Base64();
                var obj = eval(data);
                if (obj.length === 0) {
                    tBody = "<tr><td><h6>该文件夹没有文件</h6></tr></td>";
                }
                for (var i = 0; i < obj.length; i++) {
                    var itemUrl = base.decode(obj[i].url);
                    if (itemUrl.charAt(itemUrl.length - 1) === "\\") {//如果是以\结尾，则为目录；否则为文件
                        itemUrl = itemUrl.substring(0, itemUrl.length - 1);
                        var index = itemUrl.lastIndexOf("\\");
                        var itemFileName = itemUrl.substring(index + 1, itemUrl.length) + "\/...";
                        tBody += "<tr><td>";
                        tBody += "<img src=\"<%=basePath%>image/file_icon.png\" alt=\"\" class=\"imageClass\"/>";
                        tBody += "<a href=\"javascript:void(0);\" onclick=\"reloadPage('" + obj[i].url + "');return false;\">" + itemFileName + "</a>";


                        tBody += "</td></tr>";
                    } else {
                        var index2 = itemUrl.lastIndexOf("\\");
                        var itemFileName2 = itemUrl.substring(index2 + 1, itemUrl.length);
                        tBody += "<tr><td>";
                        if(isContains(itemFileName2,".png")){
                            tBody += "<img src=\"<%=basePath%>image/img_png_icon.png\" alt=\"\" class=\"imageClass\"/>";
                        }else if(isContains(itemFileName2,".jpg")){
                            tBody += "<img src=\"<%=basePath%>image/img_jpg_icon.png\" alt=\"\" class=\"imageClass\"/>";
                        }else{
                            tBody += "<img src=\"<%=basePath%>image/file2_icon.png\" alt=\"\" class=\"imageClass\"/>";
                        }
                        tBody += "<a href=\"/hcy/file/downloadFile?filePath=" + obj[i].url + "\">" + itemFileName2 + "</a>";
                        tBody += "<a style='margin-left: 20px' href=\"javascript:void(0);\" onclick=\"deleteFile('" + obj[i].url + "')\">删除文件</a>";
                        tBody += "</td></tr>";
                    }
                }
                $("#partList").html(tBody);//这里动态的为tbody添加内容
            });
        }

        function reloadPage(filePath) {
            var tBody = "";
            var base = new Base64();
            var newFilePath = base.decode(filePath);
            if (newFilePath.charAt(newFilePath.length - 1) === "\\") {
                newFilePath = newFilePath.substring(0, newFilePath.length - 1);
            }
            var index = newFilePath.lastIndexOf("\\");
            var itemFileName = newFilePath.substring(index + 1, newFilePath.length + 1);
            if (itemFileName !== "MyServerFile") {
                itemFileName = "\/......";
                newFilePath = newFilePath.substring(0, index);
                newFilePath = base.encode(newFilePath);
                tBody += "<tr><td>" + "<a href=\"javascript:void(0);\" onclick=\"reloadPage('" + newFilePath + "');return false;\">" + itemFileName + "</a></td></tr>";
            }
            loadPage(filePath, tBody);
        }
        
        function deleteFile(path) {
            var newPath = path;
            var base = new Base64();
            newPath = base.decode(newPath);
            var index = newPath.lastIndexOf("\\");
            var fielName = newPath.substring(index + 1, newPath.length);
            newPath = newPath.substring(0, index);
            newPath = base.encode(newPath);

            if(window.confirm('你确定要删除' + fielName + '吗？')){
                $.get("/hcy/file/deleteFile?path=" + path, function (data, status) {
                    reloadPage(newPath)
                });
                return true;
            }else{
                return false;
            }

        }

        function getRootPath() {
            $.get("/hcy/file/getRootFilePath", function (data, status) {
                loadPage(data, "");
            });
        }

        function isContains(str, substr) {
            return new RegExp(substr).test(str);
        }
    </script>
</head>
<body onload="getRootPath()">
<table class="table table-hover">
    <tbody id="partList">
    </tbody>
</table>
<p style="margin-top: 50px">
<a href="/hcy">返回首页</a>
</p>
</body>
</html>

