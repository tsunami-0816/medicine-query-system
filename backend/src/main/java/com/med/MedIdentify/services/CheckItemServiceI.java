package com.med.MedIdentify.services;

import com.med.MedIdentify.bean.Medicine;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

public interface CheckItemServiceI {

    public List<Medicine> selectMedByName(String mname);

    public Medicine selectMedByMid(String mid);
}
