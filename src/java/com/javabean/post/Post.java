package com.javabean.post;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * post表的相关操作
 *
 * @author 挺
 */
public class Post {

    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //获得表的长度
    public int getLength() {
        int length = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                length++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }finally{
            this.close();
        }
        return length;

    }
    
    //获得帖子的页数
    public int getPageCount(int allnewsCount,int pageSize) {
        int pageCount;
        if (allnewsCount % pageSize == 0) {
            pageCount = allnewsCount / pageSize;
        } else {
            pageCount = allnewsCount / pageSize + 1;
        }
        return pageCount;
    }

    //获取所有帖子的id
    public int[] getId() {
        int[] id = new int[this.getLength()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                id[i] = rs.getInt("post_id");
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return id;
    }

    //获取指定id对应帖子的标题
    public String getName(int id) {
        String name = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("post_id") == id) {
                    name = rs.getString("post_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return name;
    }

    //获取指定id对应帖子的内容
    public String getContent(int id) {
        String content = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("post_id") == id) {
                    content = rs.getString("post_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return content;
    }

    //获取指定id对应帖子的owner
    public String getOwner(int id) {
        String owner = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("post_id") == id) {
                    owner = rs.getString("post_owner");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return owner;
    }

    //获取指定id对应帖子的时间
    public String getTime(int id) {
        String time = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from post";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("post_id") == id) {
                    time = rs.getString("post_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return time;
    }

    //将用户发的帖子填入数据库的表中
    public boolean addpost(String name, String content, String owner, String realowner, String time) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into post values(" + null + ",'" + name + "','" + content + "','" + owner + "','"+realowner+"','"+time+"')";
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
