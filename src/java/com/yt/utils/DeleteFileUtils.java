package com.yt.utils;

import java.io.File;

/**
 * 一个删除文件的工具类
 *
 * @author 挺(joyang)
 */
public class DeleteFileUtils {

    /**
     * 删除文件，可以是单个文件，也可以是目录
     *
     * @param fileName 要删除的文件路径或目录路径
     * @return 返回结果(删除成功或失败)
     */
    public static boolean delete(String fileName) {
        File file = new File(fileName);
        if (!file.exists()) {
            System.out.println("不存在该文件或目录");
            return false;
        } else {
            if (file.isFile()) {
                return deleteFile(fileName);
            } else {
                return deleteDirectory(fileName);
            }
        }
    }

    /**
     * 删除文件单个文件
     *
     * @param fileName 要删除的文件路径
     * @return 返回结果(删除成功或失败)
     */
    private static boolean deleteFile(String fileName) {
        File file = new File(fileName);
        if (file.exists() && file.isFile()) {
            file.delete();
            Log.write(System.currentTimeMillis() + ":删除单个文件" + fileName + "成功！");
            return true;

        } else {
            Log.write(System.currentTimeMillis() + ":删除单个文件" + fileName + "失败！");
            return false;
        }
    }

    /**
     * 删除目录以及目录下的文件
     *
     * @param fileName 要删除的目录路径
     * @return 返回结果(删除成功或失败)
     */
    private static boolean deleteDirectory(String dir) {
        //如果dir不以文件分隔符结尾，自动添加文件分隔符     
        if (!dir.endsWith(File.separator)) {
            dir = dir + File.separator;
        }
        File dirFile = new File(dir);

        //如果dir对应的文件不存在，或者不是一个目录，则退出     
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            Log.write(System.currentTimeMillis() + ":删除目录失败" + dir + "目录不存在！");
            return false;
        }

        boolean flag = true;
        //删除文件夹下的所有文件(包括子目录)    
        File[] files = dirFile.listFiles();
        for (File file : files) {
            //删除子文件     
            if (file.isFile()) {
                flag = deleteFile(file.getAbsolutePath());
                if (!flag) {
                    break;
                }
            } //删除子目录
            else {
                flag = deleteDirectory(file.getAbsolutePath());
                if (!flag) {
                    break;
                }
            }
        }

        if (!flag) {
            Log.write(System.currentTimeMillis() + ":删除目录失败");
            return false;
        }

        if (dirFile.delete()) {
            Log.write(System.currentTimeMillis() + "：删除目录" + dir + "成功！");
            return false;
        } else {
            Log.write(System.currentTimeMillis() + "：删除目录" + dir + "失败！");
            return true;
        }
    }
 
}
