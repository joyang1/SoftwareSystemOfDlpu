package com.javabean.login;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author 挺
 */
public class Login {

    private Connection c = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private ConnDB cd = null;

    //获得表的长度
    public int getLength() {
        int length = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from user";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                length++;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return length;

    }

    //添加注册成功的用户到数据库
    public boolean adduser(String name, String password, String realname, int age, String sex, String address,
            String hpicture, String institute, String major, String grade, String studentid, String email) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into user values(" + null + ",'" + name + "','" + password + "','" + realname + "'," + age + ",'" + sex + "','" + address + "','" + hpicture + "','" + institute + "',"
                + "'" + major + "','" + grade + "','" + studentid + "','" + email + "')";
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

    //判断登陆的用户是否注册
    public boolean checkuser(String studentid, String password) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select u_password from user where u_studentid=? limit 0,1";
        try {
            ps = c.prepareStatement(sql);
            ps.setString(1, studentid);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbpassword = rs.getString(1);
                if (dbpassword.equals(password)) {
                    flag = true;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return flag;
    }

    //获取所有的用户名
    public String[] getUsername() {
        String[] username = new String[this.getLength()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from user";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                username[i] = rs.getString("u_name");
                i++;
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return username;
    }

    //获取所有的学号
    public String[] getStudentid() {
        String[] studentid = new String[this.getLength()];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from user";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                studentid[i] = rs.getString("u_studentid");
                i++;
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return studentid;
    }

    //获得指定studentid的用户名
    public String getUsername(String studentid) {
        String username = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from user";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("u_studentid").equals(studentid)) {
                    username = rs.getString("u_name");
                    break;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return username;
    }

    //获得指定用户名的真实姓名
    public String getRealname(String user) {
        String realname = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from user";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("u_name").equals(user)) {
                    realname = rs.getString("u_realname");
                    break;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return realname;
    }

    //获得指定用户的个人信息
    public String[] getUserContent(String user) {
        String[] usercontent = new String[8];
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from user";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString("u_name").equals(user)) {
                    usercontent[0] = rs.getString("u_name");
                    usercontent[1] = rs.getString("u_realname");
                    usercontent[2] = "" + rs.getInt("u_age");
                    usercontent[3] = rs.getString("u_sex");
                    usercontent[4] = rs.getString("u_institute");
                    usercontent[5] = rs.getString("u_major");
                    usercontent[6] = rs.getString("u_class");
                    usercontent[7] = rs.getString("u_studentid");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return usercontent;
    }

    //添加注册成功的管理员到数据库
    public boolean addadmin(String name, String password) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "insert into admin values(" + null + ",'" + name + "','" + password + "')";
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

    //判断用户是否是管理员
    public boolean checkadmin(String name, String password) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select a_password from admin where a_name=? limit 0,1";
        try {
            ps = c.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                String adminpassword = rs.getString(1);
                if (password.equals(adminpassword)) {
                    flag = true;
                }
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
        if (c != null) {
            try {
                c.close();
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        }
    }
}
