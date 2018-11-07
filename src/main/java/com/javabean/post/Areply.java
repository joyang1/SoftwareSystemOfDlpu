/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.javabean.post;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *areply表的相关操作
 * 
 * @author 挺
 */
public class Areply {
     private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;
    
    //通过post_reply_id得到对应追加回复数
    public int getAreplyCount(int pr_id) {
        int areplycount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from areply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("post_reply_id") == pr_id) {
                    areplycount++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return areplycount;
    }
    
     //通过帖子的标题得到对应回复的id数组
    public int[] getAreplyId(int pr_id) {
       int[] id = new int[this.getAreplyCount(pr_id)];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from areply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("post_reply_id") == pr_id) {
                    id[i] = rs.getInt("areply_id");
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
    public String getAreplyTime(int id) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from areply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("areply_id") == id) {
                   return rs.getString("areply_time");
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
    public String getAreplyContent(int id) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from areply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("areply_id") == id) {
                   return rs.getString("areply_content");
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
    public String getAreplyOwner(int id) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from areply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("areply_id") == id) {
                   return rs.getString("areply_owner");
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
    public boolean addareply(String owner, String realowner, String content, String time, int pr_id) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into areply values(" + null + " ,'" + owner + "','" + realowner + "','" + content + "','" + time + "', "+pr_id+")";
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
