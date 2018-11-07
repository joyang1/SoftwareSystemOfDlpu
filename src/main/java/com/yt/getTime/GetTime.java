package com.yt.getTime;

import java.text.DateFormat;
import java.util.Date;

/**
 * 获取系统的当前时间的类
 *其中定义一个类方法getTime
 * 
 * @author 挺
 */
public class GetTime {

    public static String getTime() {
        Date now = new Date();
        DateFormat df = DateFormat.getDateInstance();
        String time = df.format(now);
        return time;
        
    }
}
