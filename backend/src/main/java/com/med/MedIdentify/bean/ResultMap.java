package com.med.MedIdentify.bean;

import org.springframework.stereotype.Component;

import java.util.List;

@Component("resultMap")
public class ResultMap {//返回结果类: 将后台要返回的所有类型的数据，封装到这个类中
    private boolean status;
    private String message;
    private List<?> list;
    private Object object;


    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
