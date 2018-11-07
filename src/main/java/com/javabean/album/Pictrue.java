/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javabean.album;

import com.yt.connectdb.ConnDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *picture表的相关操作
 * 
 * @author 挺
 */
public class Pictrue {
    private Connection c = null;
    private PreparedStatement ps = null;
    private Statement st = null;
    private ResultSet rs = null;
    private ConnDB cd = null;
}
