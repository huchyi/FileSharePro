<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <style>
        .divCenter {
            text-align: center;
        }
    </style>
    <title>文件的上传和下载</title>
</head>
<body>
<div class="divCenter">
    <br style="margin-top: 200px"/>
    <div class="divCenter">
        <%--<a href="/hcy/file/upload" style="margin-right: 30px">单文件上传</a>--%>
        <%--<a href="/hcy/file/uploadMulti" style="margin-right: 30px">多文件上传</a>--%>
        <h2><a href="/hcy/file/uploadMore">上传文件</a></h2>
        <h6>上传文件在D:/MyServerFile/file/路径下</h6>
    </div>
    <p>
    <div class="divCenter" style="margin-top: 100px">
        <h2><a href="/hcy/file/download">下载文件</a></h2>
        <h6>只能下载D:/MyServerFile/路径下的文件</h6>
    </div>

</div>
</body>
</html>
