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
 * 表question_reply的操作
 *
 * @author 挺
 */
public class QtReply {

    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //获得qid对应的回复的条数
    public int getReplyCount(int qid) {
        int count = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question_reply";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (qid == rs.getInt("question_id")) {
                    count++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return count;
    }

    //qid获得回复的id数组
    public int[] getId(int qid) {
        int[] rid = new int[this.getReplyCount(qid)];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question_reply";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("question_id") == qid) {
                    rid[i] = rs.getInt("question_reply_id");
                    i++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }

        return rid;
    }

    //获取指定id对应question_reply的内容
    public String getContent(int id) {
        String content = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question_reply";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("question_reply_id") == id) {
                    content = rs.getString("question_reply_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return content;
    }

    //获取指定id对应question的admin
    public String getAdmin(int id) {
        String owner = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from question_reply";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("question_reply_id") == id) {
                    owner = rs.getString("question_reply_admin");
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
        String sql = "select * from question_reply";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            rs.beforeFirst();
            while (rs.next()) {
                if (rs.getInt("question_reply_id") == id) {
                    time = rs.getString("question_reply_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return time;
    }

    //将管理员的回复填入数据库的表中
    public boolean addqtreply(String owner, String content, String time, int qid) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into question_reply values(" + null + ", '" + owner + "', '" + content + "', '" + time + "'," + qid + ")";
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
