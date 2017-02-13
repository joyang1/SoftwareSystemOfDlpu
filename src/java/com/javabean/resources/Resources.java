/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javabean.resources;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * 操作与资源有关的表
 *
 * @author 挺
 */
public class Resources {

    private Connection c = null;
    private Statement st = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null;
    private ConnDB cd = null;

    //获得r_book表的总行数
    public int getallBookCount() {
        int allcount = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from r_book";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                allcount++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return allcount;
    }

    //获得所有书籍的
    public int[] getBookId() {
        int[] id = new int[this.getallBookCount()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from r_book";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                id[i] = rs.getInt("book_id");
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return id;
    }

    //将编号为number的书的数量减1
    public boolean IsBorrow(String number) {
        boolean flag = false;
        int count = this.getBookCount(this.getBid(number));
        String sql = "update r_book set book_count = " + (count - 1) + " where book_id=" + this.getBid(number) + "";
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            if (ps.executeUpdate() != 0) {
                flag = true;
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return flag;
    }

    //通过书的编号得到它的id
    public int getBid(String number) {
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select book_id from r_book where book_number=?";
        try {
            ps = c.prepareStatement(sql);
            ps.setString(1, number);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("book_id");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return 0;
    }

    //获得指定id的书籍的编号
    public String getBookNumber(int id) {
        String number = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from r_book";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("book_id") == id) {
                    number = rs.getString("book_number");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return number;
    }

    //获得指定id的书籍的书名
    public String getBookName(int id) {
        String name = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from r_book";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("book_id") == id) {
                    name = rs.getString("book_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return name;
    }

    //获得指定id的书籍的数量
    public int getBookCount(int id) {
        int count = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from r_book";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getInt("book_id") == id) {
                    count = rs.getInt("book_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return count;
    }

    //获得指定id的书籍的类别
    public String getBookType(int id) {
        String type = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from r_book";
        try {
            st = c.createStatement();
            rs = st.executeQuery(sql);
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("book_id") == id) {
                    type = rs.getString("book_type");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }

        return type;
    }

    //获得书籍的json数据
    public String getBookJson() {
        String json = "";
        json += "[";
        int allbookcount = this.getallBookCount();
        int[] bookid = new int[allbookcount];
        String[] number = new String[allbookcount];
        String[] name = new String[allbookcount];
        int count[] = new int[allbookcount];
        String[] type = new String[allbookcount];
        bookid = this.getBookId();
        for (int i = 0; i < allbookcount; i++) {
            number[i] = this.getBookNumber(bookid[i]);
            name[i] = this.getBookName(bookid[i]);
            count[i] = this.getBookCount(bookid[i]);
            type[i] = this.getBookType(bookid[i]);
            if (count[i] > 0) {
                json += "{\"bid\":\"" + number[i] + "\",\"bname\":\"" + name[i] + "\",\"bnum\":\"" + count[i] + "\",\"btype\":\"" + type[i] + "\",\"isborrow\":\"<input type='button' class='borrow' value='借阅' id='" + i + "'>\"},";
            } else {
                json += "{\"bid\":\"" + number[i] + "\",\"bname\":\"" + name[i] + "\",\"bnum\":\"" + count[i] + "\",\"btype\":\"" + type[i] + "\",\"isborrow\":\"<input type='button' class='borrow' value='借阅' disabled='disabled' id='" + i + "'>\"},";
            }
        }
        json = json.substring(0, json.length() - 1);
        json += "]";
        return json;
    }

    //将借阅人的信息写入借阅borrow_book表中
    public int insert(String sql) {
        int result = 0;
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            result = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }
    
    /*搜索方法并返回符合条件的记录数*/
    /*可用于搜索数据是否存在于表中*/
    public int Selector(String sql) {
        int i = 0;
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (SQLException e) {
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
        }
        return i;
    }
    
    //判断一个查询语句的结果是否为空
    public boolean IsNull(String sql) {
        boolean flag = true;
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                flag = false;
            }
        } catch (SQLException e) {
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
        }
        return flag;
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
