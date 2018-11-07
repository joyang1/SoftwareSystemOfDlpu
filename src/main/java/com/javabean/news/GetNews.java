
package com.javabean.news;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *news表的相关操作
 * 
 * @author 挺
 */
public class GetNews {

    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //获取新闻的条数
    public int getAllNewsCount() {
        int allnewscount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from news";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                allnewscount++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return allnewscount;
    }

    //获得新闻的页数
    public int getPageCount(int allnewsCount,int pageSize) {
        int pageCount;
        if (allnewsCount % pageSize == 0) {
            pageCount = allnewsCount / pageSize;
        } else {
            pageCount = allnewsCount / pageSize + 1;
        }
        return pageCount;
    }

    //获取指定id的新闻的题目
    public String getTitle(int id) {
        String title = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from news";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("news_id") == id) {
                    title = rs.getString("news_title");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return title;
    }

    //获取所有新闻的id
    public int[] getId() {
        int[] id = new int[this.getAllNewsCount()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from news";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                id[i] = rs.getInt("news_id");
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return id;

    }

    //获取指定id的新闻的内容
    public String getContent(int id) {
        String content = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from news";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("news_id") == id) {
                    content = rs.getString("news_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return content;
    }

    //获取指定id的新闻的时间
    public String getTime(int id) {
        String time = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from news";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("news_id") == id) {
                    time = rs.getString("news_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return time;
    }

    //管理员添加新闻时调用的方法
    public boolean addnews(String title, String content, String time) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into news values(" + null + ",'" + title + "','" + content + "','" + time + "')";
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
        if (st != null) {
            try {
                st.close();
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
        if (c != null) {
            try {
                c.close();
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        }
    }
}
