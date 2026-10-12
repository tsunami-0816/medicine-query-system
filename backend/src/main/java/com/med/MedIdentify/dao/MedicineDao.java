package com.med.MedIdentify.dao;

import com.med.MedIdentify.bean.Medicine;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository  //factory -- 代理对象 MedicineDaoClass、UserDaoClass、OrderDaoClass
public interface MedicineDao {//数据访问层: 执行sql语句

    public List<Medicine> selectMedByName(String mname);


    public Medicine selectMedByMid(String mid);
}
