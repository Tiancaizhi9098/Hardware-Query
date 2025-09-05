@echo off
title 管理员: 硬件查询工具
color 0A

echo 品牌: Micro-Star International Co., Ltd.
echo 型号: B660M GAMING PLUS WIFI (MS-7E24)
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Name
echo 主板名称
echo MS-7E24
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++TP
echo 硬盘物理序列号
for /f "skip=1 tokens=*" %%i in ('wmic diskdrive get SerialNumber') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++MC
echo 内存条序列号
for /f "skip=1 tokens=*" %%i in ('wmic memorychip get SerialNumber') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++SX
echo 内存条时序
for /f "skip=1 tokens=*" %%i in ('wmic memorychip get PartNumber') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++cpu
echo 主板CPU序列号
for /f "skip=1 tokens=*" %%i in ('wmic cpu get ProcessorId') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++bios
echo 主板bios序列号
for /f "skip=1 tokens=*" %%i in ('wmic bios get SerialNumber') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ZB
echo 主板物理序列号
for /f "skip=1 tokens=*" %%i in ('wmic baseboard get SerialNumber') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++uuid
echo 主板UUID
for /f "skip=1 tokens=*" %%i in ('wmic csproduct get UUID') do if not "%%i"=="" echo %%i
echo.

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++MAC
echo 网卡信息MAC
for /f "skip=1 tokens=*" %%i in ('wmic path win32_NetworkAdapter where "NetEnabled=true" get MACAddress') do if not "%%i"=="" echo %%i
echo.

echo 处理地址                传输名称
echo ===============================================================
ipconfig /all | findstr "物理地址\|适配器"
echo.

echo 显卡GPU
for /f "skip=1 tokens=*" %%i in ('wmic path win32_VideoController get Name') do if not "%%i"=="" echo %%i
echo.

echo 默认网关: 
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr "默认网关"') do echo %%i
echo.

echo Press Enter to Update
pause