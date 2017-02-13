/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.exam;

import com.javabean.url.URL;
import com.yt.exception.InvalidExtNameException;
import com.yt.utils.FileUploadProperties;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
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
public class uploadExamServlet extends HttpServlet {

    private final String local = URL.getUrl();
    private final String tempFile = local + "exam\\tempFile"; //临时上传目录
    private final String uploadFile = local + "exam\\studentExam"; //上传目录
    FileUploadProperties instance = FileUploadProperties.getInstance();
    private final String exts = instance.getPropertyValue("exts");
    private final String fileMaxSize = instance.getPropertyValue("file.max.size");
    private final String total = instance.getPropertyValue("total.file.max.size");

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

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
        response.setContentType("text/html;charet=utf-8");
        ServletFileUpload upload = getUpload();
        String path = "test/uploadExam.jsp";
        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    InputStream inStream = item.getInputStream();
                    String fileName = item.getName();
                    String filePath = uploadFile + "\\" + fileName;
                    String extName = fileName.substring(fileName.indexOf(".") + 1);
                    try {
                        validate(extName);
                        OutputStream outStream = new FileOutputStream(filePath);
                        byte[] buffer = new byte[1024];
                        int len = 0;
                        while ((len = inStream.read(buffer)) != -1) {
                            outStream.write(buffer, 0, len);
                        }
                        outStream.close();
                        inStream.close();
                        request.setAttribute("message", "恭喜你,答题完成,试卷提交成功!");
                    } catch (InvalidExtNameException e) {
                        request.setAttribute("message", e.getMessage());
                        String logPath = URL.getUrl() + "log\\";
                        FileWriter fw = new FileWriter(logPath + "softlab.log", true);
                        fw.write("\r\nuploadExamServlet\r\n" + System.currentTimeMillis() + e.getMessage() + "\r\n");
                        fw.close();
                    }

                }
            }
            request.getRequestDispatcher(path).forward(request, response);
        } catch (FileUploadException ex) {
            request.setAttribute("message", "sorry,上传失败!");
            String logPath = URL.getUrl() + "log\\";
            //OutputStream outStream = new FileOutputStream(logPath + "softlab.log");
            FileWriter fw = new FileWriter(logPath + "softlab.log", true);
            fw.write("\r\nuploadExamServlet\r\n" + System.currentTimeMillis() + ex.getMessage() + "\r\n");
            fw.close();
        }
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
        List<String> extList = Arrays.asList(exts.split(","));
        if (!extList.contains(extName)||extName.equals("pptx")||extName.equals("ppt")||extName.equals("txt")) {
            throw new InvalidExtNameException("文件类型错误!请上传word文档!");
        }
    }

}
