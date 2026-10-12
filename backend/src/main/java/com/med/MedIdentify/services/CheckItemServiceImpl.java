package com.med.MedIdentify.services;

import com.med.MedIdentify.bean.Medicine;
import com.med.MedIdentify.dao.MedicineDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CheckItemServiceImpl implements CheckItemServiceI{//业务逻辑层
    @Autowired
    private MedicineDao checkItemDao;

    @Override
    public List<Medicine> selectMedByName(String mname) {
        if (mname.isEmpty()){
            throw new RuntimeException("请输入药品名！");
        }
        List<Medicine> list = checkItemDao.selectMedByName(mname);
        if(list == null || list.size() == 0){
            throw new RuntimeException("无此相关药品！");
        }
        return list;
    }

    @Override
    public Medicine selectMedByMid(String mid) {
        if (mid.isEmpty()){
            throw new RuntimeException("未知药品！");
        }
        Medicine medicine = checkItemDao.selectMedByMid(mid);
        if(medicine == null){
            throw new RuntimeException("药品已出库！");
        }
        return medicine;
    }

}
