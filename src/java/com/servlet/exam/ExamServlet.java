package com.servlet.exam;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.javabean.url.URL;
import com.yt.connectdb.dbOperator;
import com.yt.exception.InvalidExtNameException;
import com.yt.utils.FileUploadProperties;
import java.io.File;
import java.io.FileOutputStream;
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
public class ExamServlet extends HttpServlet {

    private final String local = URL.getUrl();
    private final String tempFile = local + "exam\\tempFile"; //临时上传目录
    private final String uploadFile = local + "exam\\uploadFile"; //上传目录
    FileUploadProperties instance = FileUploadProperties.getInstance();
    private final String exts = instance.getPropertyValue("exts");
    private final String fileMaxSize = instance.getPropertyValue("file.max.size");
    private final String total = instance.getPropertyValue("total.file.max.size");
    private dbOperator db = null;

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
        response.setContentType("text/html; charset=utf-8");
        ServletFileUpload upload = getUpload();
        //解析请求
        String title = "";
        String content = "";
        try {
            //1、得到FileItem的集合items
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String formname = item.getFieldName(); // 获取form中的名字
                    String formcontent = item.getString("utf-8"); //utf-8解决乱码
                    if (formname.equals("title")) {
                        title = formcontent;
                    } else if (formname.equals("introduce")) {
                        content = formcontent;
                    }
                } else {
//                    String fieldName = item.getFieldName();
//                    String fileName = item.getName();
//                    String contentType = item.getContentType();
//                    long sizeInBytes = item.getSize();
                    String path = "admin/exam/exam.jsp";
                    String message = "";
                    try {
                        String fileName = item.getName();
                        String extName = fileName.substring(fileName.indexOf(".") + 1);
                        validate(extName);
                        File uploadDir = new File(uploadFile);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        InputStream inStream = item.getInputStream();
                        int len = 0;
                        byte[] buffer = new byte[1024];
                        String filePath = uploadFile + "\\" + fileName;

                        db = new dbOperator();
                        if (!db.isSameName("exam_title", "exam", fileName)) {
                            if (db.SqlQuery("insert into exam values(" + null + ",'" + fileName + "','" + title + "','" + content + "','" + filePath.replace('\\', '/') + "')") != 0) {
                                OutputStream outStream = new FileOutputStream(filePath);
                                while ((len = inStream.read(buffer)) != -1) {
                                    outStream.write(buffer, 0, len);
                                }
                                outStream.close();
                                inStream.close();
                                message = "上传成功,是否需要继续上传?";
                            }
                        } else {
                            message = "上传失败,该文件名已存在!请检查是否已经上传!";
                        }
                    } catch (InvalidExtNameException e) {
                        message = e.getMessage();
                        e.printStackTrace(System.err);
                    }
                    request.setAttribute("message", message);
                    request.getRequestDispatcher(path).forward(request, response);
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace(System.err);
        }

        /*
         String formname = fi.getFieldName();// 获取form中的名字
         String formcontent = fi.getString();
         if (formname.equals("id")) {
         id = formcontent;
         } else if (formname.equals("title")) {
         title = formcontent;
         } else if (formname.equals("memo")) {
         memo = formcontent;
         }
         */
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
        if (!extList.contains(extName) || extName.equals("pptx") || extName.equals("ppt") || extName.equals("txt")) {
            throw new InvalidExtNameException("文件类型错误!请上传word文档!");
        }
    }

}
