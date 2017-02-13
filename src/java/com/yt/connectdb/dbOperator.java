package com.yt.connectdb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class dbOperator {

    public Connection c = null;
    public PreparedStatement ps = null;
    public Statement st = null;
    public ResultSet rs = null;
    public ConnDB cd = null;
    /*测试多少条记录*/

    public int textLength(String tableName) {
        int length = 0;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from " + tableName;
        /*根据用户输入的表名探寻长度*/
        System.out.println(sql);
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                length++;
            }
        } catch (SQLException e) {
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return length;
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
        } finally {
            this.close();
        }
        return i;
    }
    /*如果有相同，返回True,没找到相同的，返回False*/

    public boolean isSameId(String column, String table, int value) {
        /*要执行的sql语句*/
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select " + column + " from " + table + "";
        //System.out.print(sql);
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt(column) == value) {
                    flag = true;
                    break;
                }
            }
        } catch (SQLException e) {
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return flag;
    }

    public boolean isSameName(String column, String table, String value) {
        /*要执行的sql语句*/
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select " + column + " from " + table + "";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString(column).equals(value)) {
                    flag = true;
                    break;
                }
            }
        } catch (SQLException e) {
            System.out.println("操作失败!错误代码：SN0001");
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return flag;
    }
    /*insert、update语句和delete语句公用方法*/

    public int SqlQuery(String sql) {
        int a = 0;
        boolean flag = true;
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            a = ps.executeUpdate();
            /*a表示受影响的行数*/
        } catch (SQLException e) {
            flag = false;
            System.out.println("操作失败! 错误代码：UD0001");
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return a;
    }
    /*判断Id与账号是否匹配*/

    public boolean isMatch(String columnA, String columnB, int valueA, String valueB, String table) {
        boolean flag = false;
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from " + table + " where " + columnA + " = '" + valueA + "'";
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString(columnB).equals(valueB)) {
                    flag = true;
                    break;
                }
            }
        } catch (SQLException e) {
            flag = false;
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return flag;
    }
    /*获取主键Id,以便执行delete语句*/

    public String getId(String column, String value, String table) {
        String Id = "";
        cd = new ConnDB();
        c = cd.getConn();
        String sql = "select * from " + table + " where " + column + " = '" + value + "'";
        System.out.println(sql);
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
            int tId = rs.getInt(column);
            Id = String.valueOf(tId);/*转换为String型数据*/

        } catch (SQLException e) {
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
        } finally {
            this.close();
        }
        return Id;
    }

    public ResultSet getRs(String sql) {
        cd = new ConnDB();
        c = cd.getConn();
        try {
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            System.out.println("操作失败!");
            e.printStackTrace(System.err);
            try {
                ps.close();
                c.close();
            } catch (SQLException e1) {
                System.out.println("操作失败!");
                e1.printStackTrace(System.err);
            }

        }
        return rs;
    }

    /**
     *
     * 事物处理
     *
     * @param sql[]
     * @return
     * @throws java.sql.SQLException
     */
    public int insertExcel(String[] sql) throws SQLException {
        int a[] = new int[sql.length];
        cd = new ConnDB();
        c = cd.getConn();
        try {
            c.setAutoCommit(false);// 更改JDBC事务的默认提交方式 
            int i = 0;
            for (String sql1 : sql) {
                ps = c.prepareStatement(sql1);
                a[i] = ps.executeUpdate();
                i++;
            }
            boolean flag = false;
            for (i = 0; i < sql.length; i++) {
                if (!(a[i] != 0)) {
                    flag = false;
                } else {
                    if (i == sql.length - 1) {
                        flag = true;
                    }
                }
            }
            if (flag) {
                c.commit();//提交JDBC事务 
                c.setAutoCommit(true);// 恢复JDBC事务的默认提交方式 
                c.close();
                return 1;
            }else{
                return 0;
            }

        } catch (SQLException ex) {
            c.rollback();//回滚JDBC事务 
            ex.printStackTrace(System.err);
            c.close();
            return -1;
        }
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
