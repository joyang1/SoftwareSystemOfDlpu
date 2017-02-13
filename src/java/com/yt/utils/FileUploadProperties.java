/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.yt.utils;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author 挺
 */
public class FileUploadProperties {
    private static final FileUploadProperties instance = new FileUploadProperties();
    public FileUploadProperties(){}
    
    private final Map<String,String> properties = new HashMap<String,String>();

    public static FileUploadProperties getInstance() {
        return instance;
    }
    
    public void addProperty(String propertyName, String propertyValue){
        properties.put(propertyName, propertyValue);
    }
    
    public String getPropertyValue(String propertyName){
        return properties.get(propertyName);
    }
    
}
