/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javabean.admin;

import com.yt.connectdb.dbOperator;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author 挺
 */
public class GetJson {

    private static dbOperator db = null;

    public static String getResJson() {
        db = new dbOperator();
        String json = "[";
        ResultSet rs = db.getRs("select r_id,r_title,r_content from resources");
        try {
            rs.beforeFirst();
            while (rs.next()) {
                json += "{\"id\":\"" + rs.getInt(1) + "\",\"title\":\"" + rs.getString(2) + "\",\"content\":\"" + rs.getString(3) + "\"},";
            }
            rs.close();
        } catch (SQLException e) {
        }
        json = json.substring(0, json.length() - 1);
        json += "]";
        return json;
    }

    public static String getNewsJson(int pageNumber, int pageSize) {
        db = new dbOperator();
        String json = "";

        ResultSet rs = db.getRs("select * from news");
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
                json += "{\"nid\":\"" + rs.getInt(1) + "\",\"ntitle\":\"" + rs.getString(2) + "\","
                        + "\"ntime\":\"" + rs.getString(4) + "\"},";
                i++;
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        json = json.substring(0, json.length() - 1);
        json += "]}";
        return json;
    }
    
     public static String getAlbumJson(int pageNumber, int pageSize) {
        db = new dbOperator();
        String json = "";

        ResultSet rs = db.getRs("select album_id,album_name,album_time,album_url from album");
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
                json += "{\"aid\":\"" + rs.getInt(1) + "\",\"aname\":\"" + rs.getString(2) + "\","
                        + "\"atime\":\"" + rs.getString(3) + "\",\"aurl\":\"" + rs.getString(4) + "\"},";
                i++;
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        json = json.substring(0, json.length() - 1);
        json += "]}";
        return json;
    }
}
