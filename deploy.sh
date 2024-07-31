#!/bin/bash

# dist目录
distPath = "/var/lib/jenkins/workspace/pre_blog_site/dist"

# 查看当前目录
echo "===========查看当前目录============="
pwd

# 查看git版本
echo "===========查看当前git版本============="
git --version

# 查看node版本
echo "===========查看当前node版本============="
node --version

# 查看npm版本
echo "===========查看当前npm版本============="
npm --version

# 查看yarn版本
echo "===========查看当前yarn版本============="
yarn --version

# 拉取最新代码
echo "===========拉取最新代码============="
git pull origin master

# 查看README.md
echo "===========查看README.md============="
cat README.md

# 清空依赖
echo "===========清空依赖、上次dist、上次/usr/local/my_project/pre_blog_site/*============="
rm -rf .output
rm -rf dist
rm -rf node_modules
rm -rf package-lock.json
rm -rf /usr/local/my_project/pre_blog_site/*

# 安装依赖
echo "===========安装依赖npm i============="
npm i

# 打包dist
echo "===========打包dist npm run build============="
yarn build
ls -a -l

# 移动dist
if [ -d "${distPath}"];
    then
        echo "===========移动dist到/usr/local/my_project/pre_blog_site============="
        mv dist/*  /usr/local/my_project/pre_blog_site
else 
        echo "没有找到dist目录"
fi

# 重启nginx 服务
echo "===========重启nginx服务============="
cd /usr/local/nginx/sbin
./nginx -s reload

exit 0

