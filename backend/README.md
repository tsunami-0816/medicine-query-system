# MedIdentify - 药品查询系统

## 项目简介

MedIdentify 是一个基于 Spring Boot + MyBatis 的药品查询后端系统，提供药品信息的查询接口。

## 技术栈

- **后端框架**: Spring Boot 2.7.4
- **持久层框架**: MyBatis 1.3.0
- **数据库**: MySQL 5.x
- **连接池**: Druid 1.1.10
- **JDK版本**: 1.8

## 项目结构

```
MedIdentify/
├── src/main/
│   ├── java/com/med/MedIdentify/
│   │   ├── bean/              # 实体类
│   │   │   ├── Medicine.java  # 药品实体
│   │   │   └── ResultMap.java # 统一返回结果类
│   │   ├── controller/        # 控制器层
│   │   │   ├── MedicineController.java
│   │   │   └── UserController.java
│   │   ├── dao/               # 数据访问层
│   │   │   └── MedicineDao.java
│   │   ├── services/          # 业务逻辑层
│   │   │   ├── CheckItemServiceI.java
│   │   │   └── CheckItemServiceImpl.java
│   │   └── MedIdentifyApplication.java
│   └── resources/
│       ├── mapping/           # MyBatis映射文件
│       │   └── medicineMapping.xml
│       └── application.properties
└── pom.xml
```

## 功能模块

### 药品查询

- 根据药品名称查询药品信息
- 根据药品ID查询药品详情

## API 接口

### 1. 根据药品名称查询

**接口地址**: `/med/selectMedByName`

**请求方式**: GET

**请求参数**:
- `mname` (String): 药品名称

**返回示例**:
```json
{
  "status": true,
  "message": null,
  "list": [
    {
      "mid": "001",
      "mname": "阿莫西林",
      "price": 25.5,
      "valid": 24,
      "eatNum": "每日2次，每次1片",
      "handle": "用于敏感菌所致的感染",
      "mImage": "xxx.jpg"
    }
  ],
  "object": null
}
```

### 2. 根据药品ID查询

**接口地址**: `/med/selectMedByMid`

**请求方式**: GET

**请求参数**:
- `mid` (String): 药品ID

**返回示例**:
```json
{
  "status": true,
  "message": null,
  "list": null,
  "object": {
    "mid": "001",
    "mname": "阿莫西林",
    "price": 25.5,
    "valid": 24,
    "eatNum": "每日2次，每次1片",
    "handle": "用于敏感菌所致的感染",
    "mImage": "xxx.jpg"
  }
}
```

## 快速开始

### 环境要求

- JDK 1.8+
- Maven 3.6+
- MySQL 5.5+

### 数据库配置

1. 创建数据库:
```sql
CREATE DATABASE medicinesystem CHARACTER SET utf8;
```

2. 创建药品表:
```sql
CREATE TABLE medicine (
    mid VARCHAR(50) PRIMARY KEY COMMENT '药品ID',
    mname VARCHAR(100) NOT NULL COMMENT '药品名称',
    price DOUBLE COMMENT '单价',
    valid INT COMMENT '保质期(月)',
    eatNum VARCHAR(200) COMMENT '用法用量',
    handle VARCHAR(500) COMMENT '适应症状',
    mImage VARCHAR(200) COMMENT '药品图片'
);
```

### 配置修改

修改 `src/main/resources/application.properties` 中的数据库配置:

```properties
# 数据库连接配置
spring.datasource.username=root
spring.datasource.password=你的密码
spring.datasource.url=jdbc:mysql://127.0.0.1:3306/medicinesystem?characterEncoding=UTF-8&serverTimezone=GMT%2b8&useSSL=false&requireSSL=false
```

### 运行项目

1. 克隆项目到本地
2. 使用 Maven 构建项目:
```bash
mvn clean install
```
3. 运行启动类 `MedIdentifyApplication`
4. 访问地址: `http://localhost:8082/med`

## 开发说明

- **端口**: 8082
- **上下文路径**: /med
- **编码**: UTF-8

## 许可证

This Project is for SXWL
