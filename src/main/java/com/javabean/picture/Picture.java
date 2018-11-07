/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javabean.picture;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * picture表的相关操作
 *
 * @author 挺
 */
public class Picture {

    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //用户上传图片到数据库
    public boolean addPicture(String Picturename, String title, String introduce, String time, String owner, String realname, int album_id) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into picture values(" + null + ",'" + Picturename + "','" + title + "','" + introduce + "','" + time + "','" + owner + "','" + realname + "'," + album_id + ")";
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

    //获取新闻的条数
    public int getAllPictureCount() {
        int allpicturecount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from picture";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                allpicturecount++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return allpicturecount;
    }

    //获得对应相册里面的图片的数量
    public int getEachAlbumPictureCount(int id) {
        int albumpicturecount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from picture";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("album_id") == id) {
                    albumpicturecount++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return albumpicturecount;
    }

    //获得所有相册的id组成的id数组
    public int[] getId() {
        int[] id = new int[this.getAllPictureCount()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from picture";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                id[i] = rs.getInt("picture_id");
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return id;
    }

    //获得对应相册的id组成的id数组
    public int[] getPictureId(int album_id) {
        int[] id = new int[this.getEachAlbumPictureCount(album_id)];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from picture";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("album_id") == album_id) {
                    id[i] = rs.getInt("picture_id");
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

    //获得对应id的图片的介绍
    public String getIntroduce(int id) {
        String introduce = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from picture";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("picture_id") == id) {
                    introduce = rs.getString("picture_introduction");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return introduce;
    }

    //获得对应id的图片名
    public String getName(int id) {
        String name = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from picture";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("picture_id") == id) {
                    name = rs.getString("picture_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return name;
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
