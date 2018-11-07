/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.javabean.url;

/**
 *获得web的根目录
 * @author 挺
 */
public class URL {
     private static final String Local = "";
     //private static final String Local ="C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\softlab\\";
     public  static  String getUrl(){
         return Local;
     }
}
