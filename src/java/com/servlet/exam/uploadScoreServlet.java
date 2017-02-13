/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.exam;

import com.javabean.exam.score;
import com.javabean.url.URL;
import com.yt.connectdb.dbOperator;
import com.yt.exception.InvalidExtNameException;
import com.yt.utils.DeleteFileUtils;
import com.yt.utils.ExcelUtils;
import com.yt.utils.FileUploadProperties;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author 挺
 */
public class uploadScoreServlet extends HttpServlet {

    private final String local = URL.getUrl();
    private final String tempFile = local + "exam\\tempFile"; //临时上传目录
    private final String uploadFile = local + "exam\\score"; //上传目录
    FileUploadProperties instance = FileUploadProperties.getInstance();
    private final String exts = instance.getPropertyValue("exts");
    private final String fileMaxSize = instance.getPropertyValue("file.max.size");
    private final String total = instance.getPropertyValue("total.file.max.size");
    private dbOperator db = null;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        ServletFileUpload upload = getUpload();
        String message = "";
        String path = "admin/exam/uploadscore.jsp";
        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    InputStream inStream = item.getInputStream();
                    String fileName = item.getName();
                    try {
                        String extName = fileName.substring(fileName.indexOf(".")+1);
                        validate(extName);
                        int len = 0;
                        byte[] buffer = new byte[1024];
                        String filePath = uploadFile + "\\" + fileName;
                        OutputStream outStream = new FileOutputStream(filePath);
                        while ((len = inStream.read(buffer)) != -1) {
                            outStream.write(buffer, 0, len);
                        }
                        outStream.close();
                        inStream.close();
                        List<score> list = ExcelUtils.readExceltoDB(filePath);
                        String[] sql = new String[list.size()];
                        int i = 0;
                        for (score s : list) {
                            sql[i] = "insert into score values('" + s.getSno() + "','" + s.getName() + "'," + s.getScore() + ")";
                            i++;
                        }
                        db = new dbOperator();
                        try {
                            if (db.insertExcel(sql) == 1) {
                                message="上传成功！";
                                DeleteFileUtils.delete(filePath);
                            }else{
                                message="上传失败！学号重复或其他原因!请检查！";
                                DeleteFileUtils.delete(filePath);
                                
                            }

                        }catch(SQLException e){
                        }

                    } catch (InvalidExtNameException ex) {
                        message = ex.getMessage();
                        ex.printStackTrace(System.err);
                    }

                }
            }
        } catch (FileUploadException ex) {
            message = "上传失败!";
        }
        request.setAttribute("message", message);
        request.getRequestDispatcher(path).forward(request, response);
    }

    private ServletFileUpload getUpload() {
        // 为基于硬盘文件的项目集创建一个工厂
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置工厂的约束条件
        factory.setSizeThreshold(1024 * 5);

        File tempDir = new File(tempFile);
        File uploadDir = new File(uploadFile);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        factory.setRepository(tempDir);

        // Create a new file upload handler(创建一个新文件上传处理程序)
        ServletFileUpload upload = new ServletFileUpload(factory);
        //设置请求的总大小限制
        upload.setSizeMax(Integer.parseInt(fileMaxSize));
        return upload;
    }

    private void validate(String extName) {
        if (!(extName.equals("xls") || extName.equals("xlsx"))) {
            throw new InvalidExtNameException("文件类型错误!请上传execl文档!");
        }
    }

}
