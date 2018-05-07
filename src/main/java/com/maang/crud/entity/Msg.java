package com.maang.crud.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

/**
 * 描述:
 * 通用的返回
 *
 * @outhor ming
 * @create 2018-05-06 10:54
 */
@Setter
@Getter
public class Msg {

    //状态码
    private Integer code;
    //提示信息
    private String msg;

    //用户要返回给浏览器的信息
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success(){

        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功!");
        return result;
    }
    public static Msg fail(){

        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败!");
        return result;
    }

    public Msg add(String key, Object value) {

        this.getExtend().put(key, value);
        return this;
    }
}
