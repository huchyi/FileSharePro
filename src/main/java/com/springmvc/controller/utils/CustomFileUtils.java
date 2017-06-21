package com.springmvc.controller.utils;

import java.io.File;
import java.util.ArrayList;

/**
 * 文件工具类
 */
public class CustomFileUtils {

    public final static String FILE_PATH_DOWNLOAD = "D:" + File.separator + "MyServerFile" + File.separator;

    public final static String FILE_PATH_UPLOAD = "D:" + File.separator + "MyServerFile" + File.separator + "file" + File.separator;

    public static ArrayList<String> getFilePath(String path) {
        File file = new File(path);
        ArrayList<String> listFile = new ArrayList<String>();
        list(file, listFile);
        return listFile;
    }

    private static void list(File file, ArrayList<String> listFile) {
        if (file.isDirectory())//判断file是否是目录
        {
            File[] lists = file.listFiles();
            if (lists != null) {
                for (File file2 : lists) {
                    if (file2.isDirectory()) {//判断file是否是目录
                        listFile.add(file2.getAbsolutePath() + File.separator);
                    } else {
                        listFile.add(file2.getAbsolutePath());
                    }
                }
            }
        } else {
            listFile.add(file.getAbsolutePath());
        }


//        if (file.isDirectory())//判断file是否是目录
//        {
//            File[] lists = file.listFiles();
//            if (lists != null) {
//                for (int i = 0; i < lists.length; i++) {
//                    list(lists[i],listFile);//是目录就递归进入目录内再进行判断
//                }
//            }
//        }
//        listFile.add(file.getAbsolutePath());
//        System.out.println(file);//file不是目录，就输出它的路径名，这是递归的出口
    }


    public static void createFile(){
        File file = new File(CustomFileUtils.FILE_PATH_DOWNLOAD);
        if(file.exists()){
           file.mkdirs();
        }
    }
}
