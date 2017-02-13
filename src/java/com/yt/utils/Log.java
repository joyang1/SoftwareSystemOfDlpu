/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.yt.utils;

import com.javabean.url.URL;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 *
 * @author 挺
 */
public class Log {

    public static void write(String content) {
        String url = URL.getUrl();
        String logPath = url + "log\\softlab.log";
        File file = new File(logPath);
        FileWriter fw = null;
        try {
            fw = new FileWriter(file, true);
            fw.write("\r\n" + content + "\r\n");
            fw.close();
        } catch (IOException e) {

        }

    }
}
