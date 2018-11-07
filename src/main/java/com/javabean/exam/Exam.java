/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javabean.exam;

import com.yt.connectdb.dbOperator;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author 挺
 */
public class Exam {

    private static dbOperator db = null;

    public static String getExamJson() {
        db = new dbOperator();
        String json = "[";
        ResultSet rs = db.getRs("select exam_id,exam_title,exam_name from exam");
        try {
            rs.beforeFirst();
            while (rs.next()) {
                json += "{\"id\":\"" + rs.getInt(1) + "\",\"title\":\"" + rs.getString(2) + "\",\"name\":\"" + rs.getString(3) + "\"},";
            }
            rs.close();
        } catch (SQLException e) {
        }
        json = json.substring(0, json.length() - 1);
        json += "]";
        return json;
    }
}
