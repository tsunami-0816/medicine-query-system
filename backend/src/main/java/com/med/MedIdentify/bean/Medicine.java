package com.med.MedIdentify.bean;

public class Medicine {
    //主键、药品名称、单价、保质期、用法用量、适应症状
    private String mid;
    private String mname;
    private double price;
    private int valid;
    private String eatNum;
    private String handle;
    private String mImage;


    public String getmImage() {
        return mImage;
    }

    public void setmImage(String mImage) {
        this.mImage = mImage;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getValid() {
        return valid;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }

    public String getEatNum() {
        return eatNum;
    }

    public void setEatNum(String eatNum) {
        this.eatNum = eatNum;
    }

    public String getHandle() {
        return handle;
    }

    public void setHandle(String handle) {
        this.handle = handle;
    }
}
