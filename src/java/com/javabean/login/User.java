/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javabean.login;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 对用户表(user,admin)进行基本的操作
 *
 * @author 挺
 */
public class User {

    private Connection c = null;
    private Statement st = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null;
    private ConnDB cd = null;

    //获得admin,user表的ResultSet对象
    public ResultSet getRs(String sql) {
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            //this.close();
        }
        return rs;
    }

    //获得管理员的json数据
    public String getAdminJson(ResultSet rs) {
        String json = "";
        json += "[";
        try {
            rs.beforeFirst();
            while (rs.next()) {
                json += "{\"aid\":\"" + rs.getInt(1) + "\",\"aname\":\"" + rs.getString(2) + "\"},";
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        json = json.substring(0, json.length() - 1);
        json += "]";
        return json;
    }

    //获得普通的json数据
    public String getUserJson(ResultSet rs, int pageNumber, int pageSize) {
        String json = "";
        int total = 0;  //记录总数
        try {
            rs.last();
            total = rs.getRow();
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        }

        json += "{\"total\":\"" + total + "\",\"rows\":[";
        int totals = (pageNumber * pageSize) <= total ? (pageNumber * pageSize) : total;
        try {        
            int i = (pageNumber - 1) * pageSize;
            
            while (i< totals) {
                rs.absolute(i+1);
                json += "{\"uname\":\"" + rs.getString(1) + "\",\"urealname\":\"" + rs.getString(2) + "\",\"uage\":\"" + rs.getInt(3) + "\",\"usex\":\"" + rs.getString(4) + "\",\"uaddress\":\"" + rs.getString(5) + "\","
                        + "\"uinstitute\":\"" + rs.getString(6) + "\",\"umajor\":\"" + rs.getString(7) + "\",\"uclass\":\"" + rs.getString(8) + "\",\"ustudentid\":\"" + rs.getString(9) + "\",\"uemail\":\"" + rs.getString(10) + "\"},";
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        json = json.substring(0, json.length() - 1);
        json += "]}";
        return json;
    }

    //关闭连接
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
