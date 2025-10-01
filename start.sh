cat > start.sh << EOF
#!/bin/sh
# 如果你有设置主题的需要，可以取消注释下一行（记得把前面的空格也清下），然后按照自己的需求设置。
# export THEME="berry"
export TIKTOKEN_CACHE_DIR="$PWD"
# 把下一行的  newapi 与 PORT 改为自己放行的程序文件的名称 与 端口
exec ./newapi --port 63255 --log-dir ./logs
