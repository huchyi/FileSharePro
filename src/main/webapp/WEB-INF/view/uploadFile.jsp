<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传单个文件示例</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css" type="text/css" />
</head>
<body>
<div align="center">

<h3 style="margin-bottom: 100px">单上传文件</h3>
<form method="post" action="/hcy/file/doUpload" enctype="multipart/form-data">
<input type="file" name="file"/>
<button type="submit" >提交</button>
</form>
</div>
</body>
</html>