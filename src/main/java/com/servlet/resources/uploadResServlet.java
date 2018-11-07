/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.resources;

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
public class uploadResServlet extends HttpServlet {

    private final String local = URL.getUrl();
    private final String tempFile = local + "resources\\tempFile"; //临时上传目录
    private final String uploadFile = local + "resources\\uploadFile"; //上传目录
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
        response.setContentType("text/html;charset=utf-8");
        ServletFileUpload upload = getUpload();
        String user = request.getSession().getAttribute("user").toString();
        String userpower = request.getSession().getAttribute("userpower").toString();
        String content = "";
        String fileName = "";
        String filePath = "";
        String path  = "";
        if(userpower.equals("1")){
            path = "resources/useraddres.jsp";
        }else if(userpower.equals("2")){
            path = "admin/resources/uploadres.jsp";
        }
        
        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String formName = item.getFieldName();
                    String formContent = item.getString("utf-8");
                    if (formName.equals("introduce")) {
                        content = formContent;
                    }
                } else {
                    fileName = item.getName();
                    String extName = fileName.substring(fileName.indexOf(".") + 1);
                    try {
                        validate(extName);
                        db = new dbOperator();
                        if (!db.isSameName("r_title", "resources", fileName)) {
                            InputStream inStream = item.getInputStream();
                            filePath = uploadFile + "\\" + fileName;
                            String sql = "insert into resources values(" + null + ",'" + fileName + "','" + content + "','" + filePath.replace('\\', '/') + "','" + user + "')";
                            if (db.SqlQuery(sql) != 0) {
                                byte[] buffer = new byte[1024];
                                int len = 0;
                                OutputStream outStream = new FileOutputStream(filePath);
                                while ((len = inStream.read(buffer)) != -1) {
                                    outStream.write(buffer, 0, len);
                                }
                                inStream.close();
                                outStream.close();
                                request.setAttribute("message", "上传成功!");
                            } else {
                                request.setAttribute("message", "上传失败!");
                            }
                        } else {
                            request.setAttribute("message", "上传失败,该文件名已存在!请检查是否已经上传!");
                        }

                    } catch (InvalidExtNameException ex) {
                        request.setAttribute("message", ex.getMessage());
                        ex.printStackTrace(System.err);
                    }
                }

            }
            request.getRequestDispatcher(path).forward(request, response);
        } catch (FileUploadException e) {
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
        if (!extList.contains(extName)) {
            throw new InvalidExtNameException("文件类型错误!请上传文档类型的资源(doc,docx,pptx,ppt,txt)!");
        }
    }

}
