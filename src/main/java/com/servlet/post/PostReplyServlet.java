package com.servlet.post;

import com.javabean.login.Login;
import com.javabean.post.Post;
import com.javabean.post.PostReply;
import com.yt.getTime.GetTime;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 1.doGet 将回复的信息从数据库中读出发送到前台
 *
 * 2.将帖子回复读入数据库中的post_reply表中
 *
 * @author 挺
 */
public class PostReplyServlet extends HttpServlet {

    private PostReply reply;
    private Post p;
    private Login lg;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        p = new Post();
        lg = new Login();
        int length = p.getLength();
        int id[] = new int[length];
        id = p.getId();
        //得到从前台传过来帖子的id
        int pid = Integer.parseInt(request.getParameter("id"));

        //得到待回复帖子的标题，内容，并发送给前台显示
        String name = p.getName(id[pid]);
        String content = p.getContent(id[pid]);
        request.setAttribute("name", name);
        request.setAttribute("content", content);

        reply = new PostReply();
        //帖子对应回复的数量
        int count = reply.getReplyCount(pid);
        if (count > 0) {
            int[] rid = new int[count];
            rid = reply.getReplyId(pid);
            String[] rcontent = new String[count];
            String[] rtime = new String[count];
            String[] rowner = new String[count];
            for (int i = count - 1; i >= 0; i--) {
                rcontent[i] = reply.getReplyContent(rid[i]);
                rowner[i] = reply.getReplyOwner(rid[i]);
                rtime[i] = reply.getReplyTime(rid[i]);
                request.setAttribute("rid" + i, rid[i]);
                request.setAttribute("rcontent" + i, rcontent[i]);
                request.setAttribute("rowner" + i, rowner[i]);
                request.setAttribute("rtime" + i, rtime[i]);
//                out.println(rid[i]);
//                out.println(rtime[i]);
//                out.println(rcontent[i]);
            }
        }
        
//        out.print(""+count);
        
        request.setAttribute("count", count);
        request.setAttribute("pid", pid);
        request.getRequestDispatcher("post/post_reply.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        lg = new Login();
        reply = new PostReply();
        HttpSession session = request.getSession();
        //String name = request.getParameter("name");
        String owner = session.getAttribute("user").toString();
        String realowner = lg.getRealname(owner);
        String content = new String(request.getParameter("post_reply").getBytes("iso-8859-1"), "utf-8");
        String time = GetTime.getTime();

        //得到从前台传过来帖子的id
        int pid = Integer.parseInt(request.getParameter("id"));
        if (reply.addpost_reply(pid, owner , realowner, content, time)) {
            response.sendRedirect("PostReplyServlet?id=" + pid);
        } else {
            out.print("error");
        }

    }

}
