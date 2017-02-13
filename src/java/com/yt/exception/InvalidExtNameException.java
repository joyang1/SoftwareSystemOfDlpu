/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.yt.exception;

/**
 * 处理上传的文件名错误的异常类
 * @author 挺
 */
public class InvalidExtNameException extends RuntimeException{
    public InvalidExtNameException(String msg){
        super(msg);
    }
}
