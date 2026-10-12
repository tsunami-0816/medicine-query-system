package com.med.MedIdentify;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.med.MedIdentify.dao")
public class MedIdentifyApplication {

	public static void main(String[] args) {
		SpringApplication.run(MedIdentifyApplication.class, args);
	}

}
