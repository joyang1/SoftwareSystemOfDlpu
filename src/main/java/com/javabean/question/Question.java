/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.javabean.question;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * question表的相关操作
 * 
 * @author 挺
 */
public class Question {
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
        String sql = "select * from question";
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
    
    public int[] getId(){
        int[] id = new int[this.getLength()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question";
        try{
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while(rs.next()){
                id[i] = rs.getInt("question_id");
                i++;
            }
        }catch(SQLException e){
            e.printStackTrace(System.err);
        }
        
        return id;
    }
    
      //获取指定id对应question的内容
    public String getContent(int id) {
        String content = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("question_id") == id) {
                    content = rs.getString("question_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return content;
    }

    //获取指定id对应question的owner
    public String getOwner(int id) {
        String owner = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("question_id") == id) {
                    owner = rs.getString("question_owner");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return owner;
    }

    //获取指定id对应question的时间
    public String getTime(int id) {
        String time = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("question_id") == id) {
                    time = rs.getString("question_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return time;
    }
    
    //将用户发的question填入数据库的表中
    public boolean addquestion(String owner, String realowner, String content, String time) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into question values(" + null + ", '" + owner + "','"+realowner+"', '" + content + "', '"+time+"')";
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
