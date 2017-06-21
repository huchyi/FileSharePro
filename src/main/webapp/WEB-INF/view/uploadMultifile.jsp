<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>上传多个文件示例</title>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css" type="text/css"/>
</head>
<body>
<div align="center">
    <h1 style="margin-bottom: 100px">上传多个文件</h1>
    <form method="post" action="/hcy/file/doMultiUpload" enctype="multipart/form-data">
        <div align="center">
            <input type="file" name="file1"/>
            <p>
            <input type="file" name="file2"/>
        </div>
        <button type="submit">提交</button>
    </form>

</div>
</body>
</html>