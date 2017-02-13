package com.servlet.album;

import com.javabean.album.Album;
import com.yt.getTime.GetTime;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 1.doGet 从数据库中读出相册信息发送给前台
 * 2.doPost 将管理员添加相册的信息填入数据库中
 * @author 挺
 */
public class AlbumServlet extends HttpServlet {

    private Album album;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=utf-8");
        album = new Album();
        int count = album.getAlbumCount();
        int[] id = new int[count];
        String[] name = new String[count];
        String[] content = new String[count];
        String[] time = new String[count];
        id = album.getId();
        for (int i = count - 1; i >= 0; i--) {
            name[i] = album.getName(id[i]);
            content[i] = album.getContent(id[i]);
            time[i] = album.getTime(id[i]);
            request.setAttribute("name" + i, name[i]);
            request.setAttribute("content" + i, content[i]);
            request.setAttribute("time" + i, time[i]);
            request.setAttribute("id" + i, id[i]);
        }
        request.setAttribute("count", count);
        request.getRequestDispatcher("album/album.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("album_name");
        String url = request.getParameter("album_url");
        String content = request.getParameter("album_content");
        
        String time = GetTime.getTime();
        album = new Album();
        if(album.addAlbum(name, content, time ,url)){
            response.sendRedirect("admin/album/addalbum.jsp");
        }else{
            //System.out.println("error");
        }
    }

}
