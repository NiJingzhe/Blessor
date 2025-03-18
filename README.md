# Blessor

<div align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue.svg?style=flat-square" alt="版本">
  <img src="https://img.shields.io/badge/language-fish%20|%20PowerShell-green.svg?style=flat-square" alt="语言">
  <img src="https://img.shields.io/badge/platform-Linux%20|%20Windows-lightgrey.svg?style=flat-square" alt="平台">
  <img src="https://img.shields.io/badge/license-MIT-orange.svg?style=flat-square" alt="许可证">
</div>

<div align="center">

[中文文档](#中文文档) | [English Documentation](#english-documentation)

</div>

---

<a id="中文文档"></a>
# Blessor - Cursor 机器码检查绕过工具

<div align="right">

[English](#english-documentation) | [返回顶部](#blessor)

</div>

## 📝 项目简介

Blessor 是一个用于修改 Cursor 的工具，通过替换 main.js 中的机器码获取逻辑，实现绕过 Cursor 的机器码检查。修改后的 Cursor 将使用随机生成的标识符，而不是读取系统的机器码。本工具同时支持 Linux 和 Windows 平台。

## ✨ 功能特点

- 🔍 自动查找并替换 Cursor 中的机器码获取逻辑
- 🛡️ 自动备份原始文件，确保安全
- 💻 跨平台支持（Linux/Windows）
- 🎨 漂亮的彩色输出界面
- 💼 完整的错误处理机制
- 🌐 双语界面支持（中文/英文）

## 🔧 环境要求

### Linux 版本
- Linux 操作系统
- [Fish Shell](https://fishshell.com/)
- [appimagetool](https://github.com/AppImage/AppImageKit)
- sudo 权限

### Windows 版本
- Windows 10/11 操作系统
- PowerShell 5.1 或更高版本
- 管理员权限

## 📥 安装方法

1. 克隆本仓库或下载脚本文件：

```bash
git clone https://github.com/yourusername/blessor.git
cd blessor
```

2. 根据您的操作系统，给相应脚本添加执行权限：

### Linux
```bash
chmod +x blessor.fish
```

### Windows
在 PowerShell 中执行（需要管理员权限）：
```powershell
# 允许执行脚本
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3. 对于 Linux 用户，确保已安装 appimagetool：

```bash
# Debian/Ubuntu
sudo apt-get install appimagetool

# Arch Linux
sudo pacman -S appimagetool
```

## 📋 使用方法

### Linux 版本

#### 基本用法
```bash
./blessor.fish /path/to/Cursor.AppImage
```

#### 查看帮助
```bash
./blessor.fish -h
```
或
```bash
./blessor.fish --help
```

### Windows 版本

#### 基本用法
```powershell
.\blessor.ps1
```
或指定 Cursor 安装路径:
```powershell
.\blessor.ps1 "D:\Program Files\cursor"
```

#### 查看帮助
```powershell
.\blessor.ps1 -help
```

## 🔍 工作原理

### Linux 版本
Blessor 在 Linux 上的工作流程如下：

1. 复制 AppImage 文件到当前目录
2. 解包 AppImage 到临时目录
3. 查找 main.js 文件
4. 定位并替换机器码获取指令
5. 重新打包 AppImage
6. 备份原始文件并替换
7. 清理临时文件

主要替换内容：
- 原始指令：`( cat /var/lib/dbus/machine-id /etc/machine-id 2> /dev/null || hostname ) | head -n 1 || :`
- 替换为：`openssl rand -hex 16 | head -c 32; echo`

### Windows 版本
Blessor 在 Windows 上的工作流程如下：

1. 定位 Cursor 安装目录（默认为 `%LOCALAPPDATA%\Programs\cursor`）
2. 查找 main.js 文件
3. 备份 main.js 文件
4. 定位并替换机器码获取指令
5. 验证替换是否成功

主要替换内容：
- 原始指令：``` win32:`${b5[o$()]}\\REG.exe QUERY HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography /v MachineGuid\` ```
- 替换为：``` win32: `@powershell -NoProfile -Command "echo xxxx    REG_SZ    $([guid]::NewGuid().toString())"` ```

## ⚠️ 注意事项

- 该工具需要`管理员` / `sudo` 权限才能运行
- 原始文件将被备份（Linux: `[原文件名].bak`；Windows: `main.js.bak`）
- 该工具仅用于学习和研究目的
- 请尊重开发者的劳动成果，有条件请购买正版软件

## 📜 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](LICENSE) 文件。

## 🔄 更新日志

### v1.0.0
- 初始版本发布
- Linux 版本支持自动查找和替换机器码获取逻辑
- Linux 版本支持自动检测 AppImage 架构
- Windows 版本支持修改安装版 Cursor
- 添加彩色输出界面
- 添加双语支持（中文/英文）

## 📞 联系方式

如有问题或建议，请提交 Issue 或通过以下方式联系我：

- Email: lildinosaurni@outlook.com
- GitHub: [Ni Jingzhe](https://github.com/NiJingzhe)

<div align="right">

[English](#english-documentation) | [返回顶部](#blessor)

</div>

---

<a id="english-documentation"></a>
# Blessor - Cursor Machine ID Bypass Tool

<div align="right">

[中文](#中文文档) | [Back to Top](#blessor)

</div>

## 📝 Project Introduction

Blessor is a tool for modifying Cursor, bypassing machine ID checks by replacing the machine ID retrieval logic in main.js. The modified Cursor will use randomly generated identifiers instead of reading the system's machine ID. This tool supports both Linux and Windows platforms.

## ✨ Features

- 🔍 Automatically find and replace machine ID retrieval logic in Cursor
- 🛡️ Automatically backup original files for safety
- 💻 Cross-platform support (Linux/Windows)
- 🎨 Beautiful colored output interface
- 💼 Complete error handling mechanism
- 🌐 Bilingual interface support (Chinese/English)

## 🔧 Requirements

### Linux Version
- Linux operating system
- [Fish Shell](https://fishshell.com/)
- [appimagetool](https://github.com/AppImage/AppImageKit)
- sudo privileges

### Windows Version
- Windows 10/11 operating system
- PowerShell 5.1 or higher
- Administrator privileges

## 📥 Installation

1. Clone this repository or download the script files:

```bash
git clone https://github.com/yourusername/blessor.git
cd blessor
```

2. Depending on your operating system, add execution permission to the appropriate script:

### Linux
```bash
chmod +x blessor.fish
```

### Windows
In PowerShell (requires administrator privileges):
```powershell
# Allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3. For Linux users, make sure appimagetool is installed:

```bash
# Debian/Ubuntu
sudo apt-get install appimagetool

# Arch Linux
sudo pacman -S appimagetool
```

## 📋 Usage

### Linux Version

#### Basic Usage
```bash
./blessor.fish /path/to/Cursor.AppImage
```

#### View Help
```bash
./blessor.fish -h
```
or
```bash
./blessor.fish --help
```

### Windows Version

#### Basic Usage
```powershell
.\blessor.ps1
```
or specify Cursor installation path:
```powershell
.\blessor.ps1 "D:\Program Files\cursor"
```

#### View Help
```powershell
.\blessor.ps1 -help
```

## 🔍 How It Works

### Linux Version
The workflow of the Blessor tool on Linux is as follows:

1. Copy the AppImage file to the current directory
2. Extract the AppImage to a temporary directory
3. Find the main.js file
4. Locate and replace the machine ID retrieval instructions
5. Repack the AppImage
6. Backup the original file and replace it
7. Clean up temporary files

Main content replacement:
- Original command: `( cat /var/lib/dbus/machine-id /etc/machine-id 2> /dev/null || hostname ) | head -n 1 || :`
- Replaced with: `openssl rand -hex 16 | head -c 32; echo`

### Windows Version
The workflow of the Blessor tool on Windows is as follows:

1. Locate the Cursor installation directory (default: `%LOCALAPPDATA%\Programs\cursor`)
2. Find the main.js file
3. Backup the main.js file
4. Locate and replace the machine ID retrieval instructions
5. Verify the replacement was successful

Main content replacement:
- Original command: ``` win32:`${b5[o$()]}\\REG.exe QUERY HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography /v MachineGuid\` ```
- Replaced with: ``` win32:`@powershell -NoProfile -Command "echo xxxx    REG_SZ    $([guid]::NewGuid().toString())"` ```

## ⚠️ Notes

- This tool requires `administrator` / `sudo` privileges to run
- The original file will be backed up (Linux: `[original filename].bak`; Windows: `main.js.bak`)
- This tool is for learning and research purposes only
- Please respect the work of developers and purchase licensed software if possible

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🔄 Changelog

### v1.0.0
- Initial release
- Linux version supports automatically finding and replacing machine ID retrieval logic
- Linux version supports automatically detecting AppImage architecture
- Windows version supports modifying installed Cursor
- Added colored output interface
- Added bilingual support (Chinese/English)

## 📞 Contact

If you have any questions or suggestions, please submit an Issue or contact me through:

- Email: lildinosaurni@outlook.com
- GitHub: [Ni Jingzhe](https://github.com/NiJingzhe)

<div align="center">
⭐ 如果这个项目对你有帮助，请给它一个星星！ | If this project helps you, please give it a star! ⭐
</div>

<div align="right">

[中文](#中文文档) | [Back to Top](#blessor)

</div> 