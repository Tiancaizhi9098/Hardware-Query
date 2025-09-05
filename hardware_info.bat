@echo off
chcp 65001 >nul
title 硬件信息查询工具
color 0A

echo =====================================================
echo                 硬件信息查询工具
echo =====================================================
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Name
echo 计算机名称
echo =====================================================
hostname
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++OS
echo 操作系统信息
echo =====================================================
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"OS Configuration" /C:"OS Build Type" /C:"System Type" /C:"Processor(s)" /C:"BIOS Version" /C:"Windows Directory" /C:"System Directory" /C:"Boot Device" /C:"System Locale" /C:"Input Locale" /C:"Time Zone" /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"Virtual Memory: Max Size" /C:"Virtual Memory: Available" /C:"Virtual Memory: In Use"
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++CPU
echo 处理器信息
echo =====================================================
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed,CurrentClockSpeed,Manufacturer,Family,Model,Stepping,Architecture,L2CacheSize,L3CacheSize /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Memory
echo 内存信息
echo =====================================================
echo 内存模块详细信息:
wmic memorychip get BankLabel,Capacity,Speed,Manufacturer,PartNumber,SerialNumber,DeviceLocator /format:table
echo.
echo 内存使用情况:
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Storage
echo 存储设备信息
echo =====================================================
echo 磁盘驱动器:
wmic diskdrive get Model,Size,InterfaceType,MediaType,SerialNumber,Manufacturer /format:table
echo.
echo 逻辑磁盘:
wmic logicaldisk get Size,FreeSpace,FileSystem,VolumeName,DeviceID /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Graphics
echo 显卡信息
echo =====================================================
wmic path win32_VideoController get Name,AdapterRAM,DriverVersion,VideoProcessor,CurrentHorizontalResolution,CurrentVerticalResolution,CurrentRefreshRate /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Motherboard
echo 主板信息
echo =====================================================
wmic baseboard get Manufacturer,Product,Version,SerialNumber /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++BIOS
echo BIOS信息
echo =====================================================
wmic bios get Manufacturer,SMBIOSBIOSVersion,ReleaseDate,SerialNumber /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Network
echo 网络适配器信息
echo =====================================================
wmic path win32_NetworkAdapter where "NetEnabled=true" get Name,MACAddress,Speed,AdapterType /format:table
echo.
echo 网络配置:
ipconfig /all | findstr /C:"适配器" /C:"物理地址" /C:"IPv4" /C:"子网掩码" /C:"默认网关" /C:"DNS"
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++USB
echo USB设备信息
echo =====================================================
wmic path win32_USBControllerDevice get Antecedent,Dependent /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Audio
echo 音频设备信息
echo =====================================================
wmic sounddev get Name,Manufacturer /format:table
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++System
echo 系统详细信息
echo =====================================================
echo 系统启动时间:
wmic os get LastBootUpTime /format:table
echo.
echo 系统运行时间:
systeminfo | findstr /C:"System Boot Time" /C:"System Up Time"
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Temperature
echo 温度信息 (如果支持)
echo =====================================================
wmic /namespace:\\root\wmi PATH MSAcpi_ThermalZoneTemperature get CurrentTemperature /format:table 2>nul || echo 温度信息不可用或需要管理员权限
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Processes
echo 当前运行进程 (前20个按内存使用排序)
echo =====================================================
tasklist /fo table | sort /r /+5 | head -n 20
echo.

echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Services
echo 系统服务状态
echo =====================================================
echo 正在运行的服务数量:
sc query type=service state=all | find /c "SERVICE_NAME"
echo.

echo =====================================================
echo 硬件信息查询完成！
echo =====================================================
echo 按任意键退出...
pause >nul