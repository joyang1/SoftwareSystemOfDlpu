package com.javabean.album;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * album表的相关操作
 *
 * @author 挺
 */
public class Album {

    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //获得相册的数目
    public int getAlbumCount() {
        int albumscount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from album";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                albumscount++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return albumscount;
    }

    //获得所有相册的id组成的id数组
    public int[] getId() {
        int[] id = new int[this.getAlbumCount()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from album";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                id[i] = rs.getInt("album_id");
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return id;
    }

    //获得对应id的相册的内容
    public String getContent(int id) {
        String content = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from album";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("album_id") == id) {
                    content = rs.getString("album_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return content;
    }

    //获得对应id的相册的创建时间
    public String getTime(int id) {
        String time = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from album";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("album_id") == id) {
                    time = rs.getString("album_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return time;
    }

    //获得对应id的相册名
    public String getName(int id) {
        String name = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from album";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("album_id") == id) {
                    name = rs.getString("album_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return name;
    }
    
    //得到指定id的相册路径
    public String getAlbumUrl(int id){
        String url="";
         cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from album";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("album_id") == id) {
                    url = rs.getString("album_url");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return url;
    }

    //管理员添加新闻到数据库中
    public boolean addAlbum(String name, String content, String time, String url) {
        boolean flag = false;
        int type = 1;    //确定相册有效
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into album values(" + null + ",'" + name + "','" + content + "', '" + time + "', '" + url + "' , " + type + ")";
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
