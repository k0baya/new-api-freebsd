# New-API-FreeBSD
Automatically build New-API (FreeBSD version)

## 部署步骤

### 1. 环境准备
确保服务器满足基本运行条件（足够磁盘空间、内存，支持Shell脚本执行）。


### 2. 目录与文件准备
将下载好的 `newapi` 和 `start.sh`，上传至自己网站的目标目录：  
```
/home/用户名/domains/域名/public_html
```


### 3. 设置文件权限
为保证程序正常读写和执行，执行以下权限配置：
```bash
# 进入项目目录
cd /home/用户名/domains/域名/public_html

# 赋予启动脚本执行权限
chmod +x start.sh

# 赋予主程序执行权限
chmod +x newapi

# 赋予数据库文件读写权限（若需初始化/修改数据）
chmod 664 one-api.db

# 确保当前目录有读写执行权限
chmod 755 .
```


### 4. 启动服务
通过以下命令在后台启动程序：
```bash
nohup ./start.sh &
```
或
```bash
nohup /home/用户名/domains/域名/public_html/start.sh &
```
程序默认监听端口 `63255`，可通过 `http://服务器IP:63255`（本地环境用 `http://localhost:63255`）访问。


## 常见问题解决

### 1. “No such file or directory” 错误
**原因**：执行的文件（如 `start.sh`/`newapi`）路径错误或文件不存在。
**解决**：
- 用 `ls` 确认文件存在于当前目录。
- 若文件在其他路径，使用**完整绝对路径**执行（例：`nohup /完整路径/start.sh &`）。


### 2. “Permission denied” 错误
**原因**：文件缺少执行/读写权限。
**解决**：参考“部署步骤-3. 设置文件权限”，为对应文件添加权限。



### 3. 数据库错误（如 `创建管理员账号失败: unable to open database file: out of memory (14)`）
**原因**：数据库文件权限不足、磁盘空间不足或内存不足。
**解决**：
- 检查 `one-api.db` 权限（执行 `chmod 664 one-api.db` 赋予读写权限）。
- 用 `df -h` 检查磁盘空间、`free -m` 检查内存使用，清理空间或释放内存。
- 若数据库损坏，可备份后删除（`mv one-api.db one-api.db.bak`），重启程序重建数据库。


### 4. 域名访问报505（HTTP版本不支持）错误
**原因**：服务器与客户端HTTP协议版本不兼容，或中间设备（代理、CDN）配置问题。
**解决**：
- 创建网站时取消勾选Use HTTPS
- 检查Web服务器（Nginx/Apache等）的HTTP版本支持配置。
- 排查CDN、代理等中间设备的HTTP版本兼容性设置。


## 其他说明

### 配置项（修改 `start.sh`）
- `THEME`：主题配置（例：`export THEME="berry"`）。
- `TIKTOKEN_CACHE_DIR`：缓存目录路径（例：`export TIKTOKEN_CACHE_DIR="/path/to/cache"`）。
- `--port`：服务监听端口（例：`--port 8080`）。
- `--log-dir`：日志存储目录（例：`--log-dir ./custom-logs`）。


### 日志查看
程序日志默认存于 `./logs` 目录，可通过以下命令查看：
```bash
tail -f logs/xxx.log  # 替换为具体日志文件名
```


若遇其他异常，可结合日志进一步排查~



