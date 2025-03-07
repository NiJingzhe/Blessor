# Blessor

<div align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue.svg?style=flat-square" alt="版本">
  <img src="https://img.shields.io/badge/language-fish-green.svg?style=flat-square" alt="语言">
  <img src="https://img.shields.io/badge/platform-Linux-lightgrey.svg?style=flat-square" alt="平台">
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

Blessor 是一个用于修改 Cursor AppImage 文件的工具，通过替换 main.js 中的机器码获取逻辑，实现绕过 Cursor 的机器码检查。修改后的 Cursor 将使用随机生成的标识符，而不是读取系统的机器码。

## ✨ 功能特点

- 🔍 自动查找并替换 Cursor AppImage 中的机器码获取逻辑
- 🛡️ 自动备份原始文件，确保安全
- 🔄 自动检测 AppImage 架构，适配不同系统
- 🎨 漂亮的彩色输出界面
- 💼 完整的错误处理机制
- 🌐 双语界面支持（中文/英文）

## 🔧 环境要求

- Linux 操作系统
- [Fish Shell](https://fishshell.com/)
- [appimagetool](https://github.com/AppImage/AppImageKit)
- sudo 权限

## 📥 安装方法

1. 克隆本仓库或下载脚本文件：

```bash
git clone https://github.com/yourusername/blessor.git
cd blessor
```

2. 给脚本添加执行权限：

```bash
chmod +x blessor.fish
```

3. 确保已安装 appimagetool：

```bash
# Debian/Ubuntu
sudo apt-get install appimagetool

# Arch Linux
sudo pacman -S appimagetool
```

## 📋 使用方法

### 基本用法

```bash
./blessor.fish /path/to/Cursor.AppImage
```

### 查看帮助

```bash
./blessor.fish -h
```
或
```bash
./blessor.fish --help
```

## 🔍 工作原理

Blessor 工具的工作流程如下：

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

## ⚠️ 注意事项

- 该工具需要管理员权限才能运行
- 原始 AppImage 将被备份为 `[原文件名].bak`
- 该工具仅用于学习和研究目的
- 请尊重开发者的劳动成果，有条件请购买正版软件

## 📜 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](LICENSE) 文件。

## 🔄 更新日志

### v1.0.0
- 初始版本发布
- 支持自动查找和替换机器码获取逻辑
- 支持自动检测 AppImage 架构
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

Blessor is a tool for modifying Cursor AppImage files, bypassing machine ID checks by replacing the machine ID retrieval logic in main.js. The modified Cursor will use randomly generated identifiers instead of reading the system's machine ID.

## ✨ Features

- 🔍 Automatically find and replace machine ID retrieval logic in Cursor AppImage
- 🛡️ Automatically backup original files for safety
- 🔄 Automatically detect AppImage architecture for different systems
- 🎨 Beautiful colored output interface
- 💼 Complete error handling mechanism
- 🌐 Bilingual interface support (Chinese/English)

## 🔧 Requirements

- Linux operating system
- [Fish Shell](https://fishshell.com/)
- [appimagetool](https://github.com/AppImage/AppImageKit)
- sudo privileges

## 📥 Installation

1. Clone this repository or download the script file:

```bash
git clone https://github.com/yourusername/blessor.git
cd blessor
```

2. Add execution permission to the script:

```bash
chmod +x blessor.fish
```

3. Make sure appimagetool is installed:

```bash
# Debian/Ubuntu
sudo apt-get install appimagetool

# Arch Linux
sudo pacman -S appimagetool
```

## 📋 Usage

### Basic Usage

```bash
./blessor.fish /path/to/Cursor.AppImage
```

### View Help

```bash
./blessor.fish -h
```
or
```bash
./blessor.fish --help
```

## 🔍 How It Works

The workflow of the Blessor tool is as follows:

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

## ⚠️ Notes

- This tool requires administrator privileges to run
- The original AppImage will be backed up as `[original filename].bak`
- This tool is for learning and research purposes only
- Please respect the work of developers and purchase licensed software if possible

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🔄 Changelog

### v1.0.0
- Initial release
- Support for automatically finding and replacing machine ID retrieval logic
- Support for automatically detecting AppImage architecture
- Add colored output interface
- Add bilingual support (Chinese/English)

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