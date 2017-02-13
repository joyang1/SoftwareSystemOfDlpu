/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet.album;

import com.javabean.album.Album;
import com.javabean.login.Login;
import com.javabean.picture.Picture;
import com.javabean.url.URL;
import com.yt.getTime.GetTime;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * 1.doGet 从数据库中读出照片信息发送给前台
 *
 * 2.doPost 将管理员添加相册的信息填入数据库中
 *
 * @author 挺
 */
public class PictureServlet extends HttpServlet {
    private Picture p = null;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        //PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Login lg = new Login();
        String owner = session.getAttribute("user").toString();  //此处的owner就是user的用户名
        String realname = lg.getRealname(owner);
        String time = GetTime.getTime();
        
        int album_id = 0;  
        String title = null;
        String introduce = null;
        String fileName = null;
        String Picturename = null;

        String local = URL.getUrl();//根据当前服务器目录修改地址
        String uploadPath = local + "picture\\picture\\"; // 上传文件的目录
        String tempPath = local + "picture\\temp_picture\\"; // 临时文件目录
        File tempPathFile = new File(tempPath);
        File uploadFile = new File(uploadPath);
        if (!uploadFile.exists()) {
            //out.println(uploadFile);
            uploadFile.mkdirs();
        }

        try {
            // Create a factory for disk-based file items
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // Set factory constraints
            factory.setSizeThreshold(4096); // 设置缓冲区大小，这里是4kb
            factory.setRepository(tempPathFile);// 设置缓冲区目录
            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            // Set overall request size constraint
            upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
            List<FileItem> items = upload.parseRequest(request);// 得到所有的文件
            Iterator<FileItem> i = items.iterator();
            //out.println(items);
            int atemp = 1;
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (fi.isFormField()) {//获得其它输入值
                    String getstring = fi.getString("utf-8");
                    if(atemp == 1){
                        if(getstring.length()<2){
                            album_id = Integer.parseInt(getstring);
                            //out.println(album_id);
                        }
                        atemp++;
                       
                    }else if (atemp == 2) {
                        title = getstring;
                        atemp++;
                    } else if (atemp == 3) {
                        introduce = getstring;
                        atemp++;
                    }
                }
                fileName = fi.getName();
                if (fileName != null && !("".equals(fileName))) {
                    File fullFile = new File(fi.getName());
                    Picturename = fullFile.getName();
                    Album album = new Album();
                    String AlbumUrl = album.getAlbumUrl(album_id);
                    File savePictureUrl = new File(uploadPath , "\\"+AlbumUrl+"\\");
                    if(!savePictureUrl.exists()){
                        savePictureUrl.mkdirs();
                    }
                    File savedPictureFile = new File(savePictureUrl, fullFile.getName());
                    if (savedPictureFile.exists()) {
//                      response.sendRedirect("error/error.jsp?error=p_exists");
                        response.sendRedirect("errorJudge?error="+1+"&id="+album_id);  
                    } else {
//                        out.println(title+introduce);
                        p = new Picture();
                        if(p.addPicture(Picturename ,title, introduce, time, owner, realname, album_id)){
                            fi.write(savedPictureFile);
                            response.sendRedirect("ShowAlbumServlet?album_id="+album_id);                           
                        }else{
                            //out.println("error");
                        }
                      
                    }

                }
                else {
                    //response.sendRedirect("errorJudge?error="+1+"&id="+album_id);  
                }
            }
//            out.println(title+introduce+" "+fileName);
        } catch (Exception e) {
            e.printStackTrace(System.err);
        }
    }

}
