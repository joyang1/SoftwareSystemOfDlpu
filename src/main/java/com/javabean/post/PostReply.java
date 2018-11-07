package com.javabean.post;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * post_reply表的相关操作
 *
 * @author 挺
 */
public class PostReply {

    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //通过帖子的id得到对应回复数
    public int getReplyCount(int p_id) {
        int replycount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post_reply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("post_id") == p_id) {
                    replycount++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return replycount;
    }
    
    //通过帖子的id得到对应回复的id数组   
    public int[] getReplyId(int p_id) {
       int[] id = new int[this.getReplyCount(p_id)];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post_reply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("post_id") == p_id) {
                    id[i] = rs.getInt("post_reply_id");
                    i++;
                }             
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return id;
    }
    
    //通过回复的id得到对应回复的时间
    public String getReplyTime(int id) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post_reply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("post_reply_id") == id) {
                   return rs.getString("post_reply_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return null;
    }
    
    //通过回复的id得到对应回复的时间
    public String getReplyContent(int id) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post_reply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("post_reply_id") == id) {
                   return rs.getString("post_reply_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return null;
    }
    
     //通过回复的id得到对应回复的用户
    public String getReplyOwner(int id) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post_reply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("post_reply_id") == id) {
                   return rs.getString("post_reply_owner");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return null;
    }
        
    //将用户发的帖子填加到数据库的表中
    public boolean addpost_reply(int p_id, String owner, String realowner, String content, String time) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into post_reply values(" + null + ", " + p_id + ", '" + owner + "','" + realowner + "','" + content + "','" + time + "')";
        try {
            ps = c.prepareStatement(sql);
            int a = ps.executeUpdate();
            if (a != 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return flag;
    }

    //关闭数据库链接的方法
    private void close() {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        }
        if (st != null) {
            try {
                st.close();
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        }
        if (c != null) {
            try {
                c.close();
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        }
    }
}
