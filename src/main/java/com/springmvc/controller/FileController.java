package com.springmvc.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;

import com.springmvc.controller.utils.Base64;
import com.springmvc.controller.utils.CustomFileUtils;
import com.springmvc.controller.utils.ToolUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//url:  http://localhost:8080/hcy/file/
@Controller  //告诉DispatcherServlet相关的容器， 这是一个Controller，
@RequestMapping(value = "/file")  //类级别的RequestMapping，告诉DispatcherServlet由这个类负责处理以及URL。HandlerMapping依靠这个标签来工作
public class FileController {

//    private static Logger log = LoggerFactory.getLogger(FileController.class);
//
//    //方法级别的RequestMapping， 限制并缩小了URL路径匹配，同类级别的标签协同工作，最终确定拦截到的URL由那个方法处理
//    //并指定访问方法为GET
//    @RequestMapping(value = "/mvc", method = RequestMethod.GET)
//    public String HelloWorld(Model model) {
//
//        model.addAttribute("message", "Hello Spring MVC!!!");  //传参数给前端
//
//        //视图渲染，/WEB-INF/view/HelloWorld.jsp
//        return "HelloWorld";  //页面的名称，根据此字符串会去寻找名为HelloWorld.jsp的页面
//    }
//
//    //定位到上传文件界面 /file/upload
//    @RequestMapping(value = "/upload", method = RequestMethod.GET)
//    public String showUploadPage() {
//        return "uploadFile";         //上传单个文件
//    }
//
//    /**
//     * 上传单个文件操作
//     *
//     * @param file
//     * @return
//     */
//    @RequestMapping(value = "/doUpload", method = RequestMethod.POST)
//    public String doUploadFile(@RequestParam("file") MultipartFile file) {
//
//        if (!file.isEmpty()) {
//            log.debug("Process file: {}", file.getOriginalFilename());
//            try {
//                //这里将上传得到的文件保存至 d:\\temp\\file 目录
//                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(CustomFileUtils.FILE_PATH_UPLOAD,
//                        System.currentTimeMillis() + file.getOriginalFilename()));
//            } catch (IOException e) {
//                e.printStackTrace();
//                log.error(e.toString());
//            }
//        }
//
//        return "success";
//    }
//
//    //定位到上传多个文件界面 /file/uploadMulti
//    @RequestMapping(value = "/uploadMulti", method = RequestMethod.GET)
//    public String showUploadPage2() {
//        return "uploadMultifile";         //view文件夹下的上传多个文件的页面
//    }


    //自定义到上传多个文件界面 /file/uploadMore
    @RequestMapping(value = "/uploadMore", method = RequestMethod.GET)
    public String showUploadPage3() {
        CustomFileUtils.createFile();
        return "uploadMoreFile";         //view文件夹下的上传多个文件的页面
    }

    /**
     * 上传多个附件的操作类
     *
     * @param multiRequest
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/doMultiUpload", method = RequestMethod.POST)
    public String doUploadFile2(MultipartHttpServletRequest multiRequest) throws IOException {
        Iterator<String> filesNames = multiRequest.getFileNames();
        while (filesNames.hasNext()) {
            String fileName = filesNames.next();
            MultipartFile file = multiRequest.getFile(fileName);
            if (!file.isEmpty()) {

                File[] lists = new File(CustomFileUtils.FILE_PATH_UPLOAD).listFiles();
                boolean isSameName = false;
                if(lists != null && lists.length > 0){
                    for (File fileItem :lists) {
                        if(fileItem.getName().equals(file.getOriginalFilename())){
                            isSameName = true;
                        }
                    }
                }

                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(CustomFileUtils.FILE_PATH_UPLOAD,
                        isSameName?(System.currentTimeMillis() + "_" + file.getOriginalFilename()):file.getOriginalFilename()));
                //System.currentTimeMillis() + file.getOriginalFilename()));
            }
        }
        return "success";
    }


    //下载文件
    //自定义到上传多个文件界面 /file/uploadMore
    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public String showDownload() {
        CustomFileUtils.createFile();
        return "downloadFile";         //view文件夹下的上传多个文件的页面
    }

    @RequestMapping(value = "/getRootFilePath", method = RequestMethod.GET)
    @ResponseBody
    public String getRootFilePath() {
        return Base64.encode(CustomFileUtils.FILE_PATH_DOWNLOAD);
    }


    //获取文件列表
    //自定义到上传多个文件界面 /file/getFileList
    //列出doenload文件夹目录下的所有文件
    @RequestMapping(value = "/getFileList", method = RequestMethod.GET)
    @ResponseBody
    public String getFileList(String path) {
        if(path == null || path.equals("")){
            path = CustomFileUtils.FILE_PATH_DOWNLOAD;
        }else{
            path = Base64.getFromBase64(path);
        }
        if(!path.startsWith("D:" + File.separator + "MyServerFile")){
            path = CustomFileUtils.FILE_PATH_DOWNLOAD;
        }
        ArrayList<String> lists = CustomFileUtils.getFilePath(path);
        //[{"url","E:\workserver\"},{}....]
        StringBuffer json = new StringBuffer("[");
        for (int i = 0; i < lists.size(); i++) {
            String baseStr = ToolUtils.replaceBlank( Base64.encode(lists.get(i)));
            if (i == lists.size() - 1) {
                json.append("{\"url\":\"").append(baseStr).append("\"}");
            } else {
                json.append("{\"url\":\"").append(baseStr).append("\"},");
            }
        }
        json = json.append("]");
        return json.toString();       //view文件夹下的上传多个文件的页面
    }

    /**
     * 文件下载
     * @Description:
     * @param filePath
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/downloadFile")
    @ResponseBody
    public String downloadFile(@RequestParam("filePath") String filePath,
                               HttpServletRequest request, HttpServletResponse response) {
        String errorMsg = "path is empty";
        if (filePath == null || filePath.equals("")) {
            return errorMsg;
        }
        filePath = Base64.getFromBase64(filePath);
        if (filePath != null) {

            File file = new File(filePath);
            String fileName = String.valueOf(System.currentTimeMillis());
            try {
                int lastIndex = filePath.lastIndexOf("\\");
                fileName = filePath.substring(lastIndex + 1,filePath.length());
                fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");//为了解决中文名称乱码问题
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

            if (file.exists()) {
                response.setContentType("application/force-download");// 设置强制下载不打开
                response.addHeader("Content-Disposition",
                        "attachment;fileName=" + fileName);// 设置文件名
                byte[] buffer = new byte[1024];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = response.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                } finally {
                    if (bis != null) {
                        try {
                            bis.close();
                        } catch (IOException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return null;
    }


    @RequestMapping(value = "/deleteFile", method = RequestMethod.GET)
    @ResponseBody
    public String deleteFile(String path) {
        if(path ==null || path.equals("")){
            return "has delete";
        }
        path = Base64.getFromBase64(path);
        File file = new File(path);
        boolean isDelete = false;
        if(file.exists()){
            isDelete = file.delete();
        }

        return isDelete ? "delete success": "delete fail";
    }



}
