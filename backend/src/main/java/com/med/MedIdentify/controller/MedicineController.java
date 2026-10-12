package com.med.MedIdentify.controller;

import com.med.MedIdentify.bean.Medicine;
import com.med.MedIdentify.bean.ResultMap;
import com.med.MedIdentify.services.CheckItemServiceI;
import com.med.MedIdentify.services.CheckItemServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MedicineController {//检查项控制层: 接受前端请求、响应前端请求
    @Autowired
    private CheckItemServiceI checkItemServiceI;
    @Autowired
    private ResultMap resultMap;

    @RequestMapping("/selectMedByName")
    @ResponseBody
    public ResultMap selectMedByName(String mname){
        try{
            List<Medicine> list = checkItemServiceI.selectMedByName(mname);
            resultMap.setStatus(true);
            resultMap.setList(list);
        }catch (Exception e){// e = new RuntimeException("请输入药品名！");
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

    @RequestMapping("/selectMedByMid")
    @ResponseBody
    public ResultMap selectMedByMid(String mid){
        try{
            Medicine medicine = checkItemServiceI.selectMedByMid(mid);
            resultMap.setStatus(true);
            resultMap.setObject(medicine);
        }catch (Exception e){// e = new RuntimeException("请输入药品名！");
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

}
