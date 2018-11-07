/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.yt.check;

/**
 *
 * @author 挺
 */
public class CheckCode {
    public boolean checkcode(String code,String rcode){
        boolean flag = false;
        char[] achar = new char[4];
        char[] ochar = new char[4];
        for(int i=0; i<achar.length; i++){
            achar[i] = rcode.charAt(i);
            ochar[i] = code.charAt(i);
            if((achar[i]==ochar[i]) || (achar[i]-ochar[i] == 32) || (ochar[i]-achar[i] == 32)){
                flag = true;
            }
        }
        return flag;
    }

}
