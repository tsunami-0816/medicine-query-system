# 药品智能查询系统 (Medicine Query System)

基于 **Spring Boot + MyBatis + MySQL** 后端 + **HarmonyOS (ArkTS)** 前端的药品信息查询系统。

用户在手机端输入药品名称，即可查询药品的价格、保质期、用法用量、药效说明等详细信息。

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 | HarmonyOS ArkTS (API 5.1.1)、DevEco Studio |
| 后端 | Spring Boot 2.7.4、MyBatis、Druid |
| 数据库 | MySQL 5.x |
| 构建工具 | Maven |

## 项目结构

```
medicine-query-system/
├── backend/        # 后端 Java 项目（Spring Boot）
├── frontend/       # 前端 HarmonyOS 项目（ArkTS）
├── docs/           # 项目文档（操作手册、数据库脚本、实训PPT）
├── scripts/        # 辅助脚本（Tomcat 启动/关闭）
└── archive/        # 归档（旧版本、练习项目、开发工具，已 gitignore）
```

## 核心功能

- 按药品名称搜索，返回匹配的药品列表（名称、价格、图片）
- 点击药品查看详情（价格、保质期、用法用量、药效说明）

## 后端接口

| 接口 | 方法 | 参数 | 说明 |
|------|------|------|------|
| `/med/selectMedByName` | GET/POST | `mname` 药品名称 | 按名称查询药品列表 |
| `/med/selectMedByMid` | GET/POST | `mid` 药品ID | 按ID查询药品详情 |

## 快速开始

详细的部署和操作步骤请参考 **[docs/操作手册.md](docs/操作手册.md)**，包含从零环境搭建到跑通全流程的每一步。

简要流程：

1. **安装环境**：JDK 8、Maven、MySQL 5.x、DevEco Studio
2. **初始化数据库**：创建 `medicinesystem` 库 → 建 `medicine` 表 → 导入 `docs/数据库.txt` 中的数据
3. **启动后端**：
   ```bash
   cd backend
   mvn clean compile
   mvn spring-boot:run
   ```
   后端运行在 `http://localhost:8082`
4. **启动前端**：用 DevEco Studio 打开 `frontend/`，将代码中的 `localhost` 改为电脑 IP，启动模拟器运行
5. **验证**：在 APP 搜索框输入 `Paracetamol`，点搜索，查看结果

## 注意事项

- 数据库默认端口 **3308**，用户名 `root`，密码 `123`（可在 `backend/src/main/resources/application.properties` 修改）
- 前端在模拟器中运行时，必须将请求地址中的 `localhost` 改为电脑的实际 IP
- 药品图片需通过 Tomcat（8085端口）提供静态资源服务，不启动图片服务不影响文字查询
