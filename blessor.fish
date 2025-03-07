#!/usr/bin/env fish

# 定义语言选择变量（默认为中文）
set lang "zh"

# 语言选择函数
function choose_language
    echo (set_color -o magenta)"请选择语言 / Please choose language:"(set_color normal)
    echo (set_color -o blue)"1) 中文 (Chinese)"
    echo "2) English (英文)"(set_color normal)
    
    read -P (set_color yellow)"请输入选项 / Please enter option (1-2): "(set_color normal) lang_choice
    
    switch $lang_choice
        case "1"
            set -g lang "zh"
            return 0
        case "2"
            set -g lang "en"
            return 0
        case "*"
            echo (set_color yellow)"无效选项，默认使用中文 / Invalid option, using Chinese as default"(set_color normal)
            set -g lang "zh"
            return 0
    end
end

# 获取对应语言的消息
function get_msg
    set msg_id $argv[1]
    
    # 定义消息映射
    switch $msg_id
        case "help_title"
            if test "$lang" = "zh"
                echo "Blessor - Cursor 机器码检查绕过工具"
            else
                echo "Blessor - Cursor Machine ID Bypass Tool"
            end
        case "help_purpose"
            if test "$lang" = "zh"
                echo "  通过修改 Cursor 的 AppImage 中的 main.js 文件，绕过机器码检查"
            else
                echo "  Bypass machine ID check by modifying main.js file in Cursor's AppImage"
            end
        case "help_usage"
            if test "$lang" = "zh"
                echo "  ./blessor.fish <AppImage路径>"
            else
                echo "  ./blessor.fish <AppImage path>"
            end
        case "help_options"
            if test "$lang" = "zh"
                echo "  -h, --help     显示此帮助信息"
            else
                echo "  -h, --help     Show this help message"
            end
        case "help_example"
            if test "$lang" = "zh"
                echo "  ./blessor.fish /path/to/Cursor.AppImage"
            else
                echo "  ./blessor.fish /path/to/Cursor.AppImage"
            end
        case "help_note1"
            if test "$lang" = "zh"
                echo "  - 脚本需要管理员权限"
            else
                echo "  - The script requires administrator privileges"
            end
        case "help_note2"
            if test "$lang" = "zh"
                echo "  - 原始 AppImage 将被备份"
            else
                echo "  - The original AppImage will be backed up"
            end
        case "help_note3"
            if test "$lang" = "zh"
                echo "  - 修改会替换机器码获取逻辑，使用随机生成的标识符"
            else
                echo "  - Modification replaces machine ID logic with randomly generated identifier"
            end
        case "error_no_path"
            if test "$lang" = "zh"
                echo "请提供AppImage文件的路径"
            else
                echo "Please provide the path to the AppImage file"
            end
        case "usage"
            if test "$lang" = "zh"
                echo "用法: ./blessor.fish /path/to/your.AppImage"
            else
                echo "Usage: ./blessor.fish /path/to/your.AppImage"
            end
        case "error_file_not_exist"
            if test "$lang" = "zh"
                echo "文件 '$argv[2]' 不存在"
            else
                echo "File '$argv[2]' does not exist"
            end
        case "warning_not_appimage"
            if test "$lang" = "zh"
                echo "文件 '$argv[2]' 可能不是AppImage文件"
            else
                echo "File '$argv[2]' may not be an AppImage file"
            end
        case "continue_prompt"
            if test "$lang" = "zh"
                echo "是否继续? (y/n) "
            else
                echo "Continue? (y/n) "
            end
        case "start_processing"
            if test "$lang" = "zh"
                echo "=== 开始处理 $argv[2] ==="
            else
                echo "=== Start processing $argv[2] ==="
            end
        case "step_copying"
            if test "$lang" = "zh"
                echo "正在复制AppImage到当前目录..."
            else
                echo "Copying AppImage to current directory..."
            end
        case "error_copy"
            if test "$lang" = "zh"
                echo "无法复制AppImage文件"
            else
                echo "Failed to copy AppImage file"
            end
        case "step_create_temp"
            if test "$lang" = "zh"
                echo "创建临时目录..."
            else
                echo "Creating temporary directory..."
            end
        case "error_create_temp"
            if test "$lang" = "zh"
                echo "无法创建临时目录"
            else
                echo "Failed to create temporary directory"
            end
        case "step_extract"
            if test "$lang" = "zh"
                echo "正在解包AppImage..."
            else
                echo "Extracting AppImage..."
            end
        case "info_sudo"
            if test "$lang" = "zh"
                echo "需要管理员权限来解包AppImage..."
            else
                echo "Administrator privileges required to extract AppImage..."
            end
        case "success_sudo"
            if test "$lang" = "zh"
                echo "成功获得管理员权限..."
            else
                echo "Successfully obtained administrator privileges..."
            end
        case "error_extract"
            if test "$lang" = "zh"
                echo "解包AppImage失败"
            else
                echo "Failed to extract AppImage"
            end
        case "step_find_main"
            if test "$lang" = "zh"
                echo "正在查找main.js文件..."
            else
                echo "Finding main.js file..."
            end
        case "error_find_main"
            if test "$lang" = "zh"
                echo "无法找到main.js文件"
            else
                echo "Failed to find main.js file"
            end
        case "success_find_main"
            if test "$lang" = "zh"
                echo "找到main.js文件: $argv[2]"
            else
                echo "Found main.js file: $argv[2]"
            end
        case "step_modify"
            if test "$lang" = "zh"
                echo "正在检查并修改main.js文件..."
            else
                echo "Checking and modifying main.js file..."
            end
        case "warning_not_found"
            if test "$lang" = "zh"
                echo "在main.js中未找到需要替换的内容"
            else
                echo "Target content not found in main.js"
            end
        case "info_find_line"
            if test "$lang" = "zh"
                echo "找到目标内容在第 $argv[2] 行"
            else
                echo "Target content found at line $argv[2]"
            end
        case "info_command"
            if test "$lang" = "zh"
                echo "即将执行的命令: $argv[2]"
            else
                echo "Command to execute: $argv[2]"
            end
        case "error_modify"
            if test "$lang" = "zh"
                echo "无法修改main.js文件"
            else
                echo "Failed to modify main.js file"
            end
        case "success_modify"
            if test "$lang" = "zh"
                echo "成功修改main.js文件"
            else
                echo "Successfully modified main.js file"
            end
        case "step_repack"
            if test "$lang" = "zh"
                echo "正在重新打包AppImage..."
            else
                echo "Repacking AppImage..."
            end
        case "error_find_squashfs"
            if test "$lang" = "zh"
                echo "无法找到squashfs-root目录"
            else
                echo "Failed to find squashfs-root directory"
            end
        case "error_find_apprun"
            if test "$lang" = "zh"
                echo "在解包目录中未找到AppRun文件"
            else
                echo "AppRun file not found in extracted directory"
            end
        case "step_detect_arch"
            if test "$lang" = "zh"
                echo "正在检测AppImage架构..."
            else
                echo "Detecting AppImage architecture..."
            end
        case "warning_arch_detect"
            if test "$lang" = "zh"
                echo "无法自动检测AppImage架构"
            else
                echo "Unable to automatically detect AppImage architecture"
            end
        case "arch_select"
            if test "$lang" = "zh"
                echo "请选择架构:"
            else
                echo "Please select architecture:"
            end
        case "arch1"
            if test "$lang" = "zh"
                echo "1) x86_64 (64位Intel/AMD)"
            else
                echo "1) x86_64 (64-bit Intel/AMD)"
            end
        case "arch2"
            if test "$lang" = "zh"
                echo "2) i686 (32位Intel/AMD)"
            else
                echo "2) i686 (32-bit Intel/AMD)"
            end
        case "arch3"
            if test "$lang" = "zh"
                echo "3) aarch64 (64位ARM)"
            else
                echo "3) aarch64 (64-bit ARM)"
            end
        case "arch4"
            if test "$lang" = "zh"
                echo "4) armhf (32位ARM)"
            else
                echo "4) armhf (32-bit ARM)"
            end
        case "arch_prompt"
            if test "$lang" = "zh"
                echo "请输入选项 (1-4): "
            else
                echo "Please enter option (1-4): "
            end
        case "warning_invalid_arch"
            if test "$lang" = "zh"
                echo "无效选项，默认使用x86_64"
            else
                echo "Invalid option, using x86_64 as default"
            end
        case "success_arch"
            if test "$lang" = "zh"
                echo "检测到架构: $argv[2]"
            else
                echo "Detected architecture: $argv[2]"
            end
        case "step_sudo_repack"
            if test "$lang" = "zh"
                echo "需要管理员权限来重新打包AppImage..."
            else
                echo "Administrator privileges required to repack AppImage..."
            end
        case "info_arch"
            if test "$lang" = "zh"
                echo "使用架构: $argv[2]"
            else
                echo "Using architecture: $argv[2]"
            end
        case "error_repack"
            if test "$lang" = "zh"
                echo "重新打包AppImage失败"
            else
                echo "Failed to repack AppImage"
            end
        case "info_install"
            if test "$lang" = "zh"
                echo "请确保已安装appimagetool"
            else
                echo "Please make sure appimagetool is installed"
            end
        case "info_install_cmd"
            if test "$lang" = "zh"
                echo "可以通过以下命令安装: sudo apt-get install appimagetool 或 sudo pacman -S appimagetool"
            else
                echo "You can install it with: sudo apt-get install appimagetool or sudo pacman -S appimagetool"
            end
        case "step_backup"
            if test "$lang" = "zh"
                echo "正在备份原始AppImage并替换..."
            else
                echo "Backing up original AppImage and replacing..."
            end
        case "error_backup"
            if test "$lang" = "zh"
                echo "无法备份原始AppImage"
            else
                echo "Failed to backup original AppImage"
            end
        case "error_replace"
            if test "$lang" = "zh"
                echo "无法替换原始AppImage"
            else
                echo "Failed to replace original AppImage"
            end
        case "success_backup"
            if test "$lang" = "zh"
                echo "成功备份原始AppImage为: $argv[2]"
            else
                echo "Successfully backed up original AppImage to: $argv[2]"
            end
        case "success_replace"
            if test "$lang" = "zh"
                echo "成功替换原始AppImage"
            else
                echo "Successfully replaced original AppImage"
            end
        case "warning_no_original"
            if test "$lang" = "zh"
                echo "原始AppImage不存在，无法替换"
            else
                echo "Original AppImage does not exist, cannot replace"
            end
        case "info_new_path"
            if test "$lang" = "zh"
                echo "新的AppImage已保存为: $argv[2]"
            else
                echo "New AppImage has been saved as: $argv[2]"
            end
        case "step_cleanup"
            if test "$lang" = "zh"
                echo "正在清理临时文件..."
            else
                echo "Cleaning up temporary files..."
            end
        case "finish"
            if test "$lang" = "zh"
                echo "=== 处理完成! ==="
            else
                echo "=== Processing complete! ==="
            end
        case "success_modified"
            if test "$lang" = "zh"
                echo "修改后的AppImage已替换原始文件"
            else
                echo "Modified AppImage has replaced the original file"
            end
        case "success_backup_path"
            if test "$lang" = "zh"
                echo "原始AppImage已备份为: $argv[2]"
            else
                echo "Original AppImage has been backed up to: $argv[2]"
            end
    end
end

# 修改帮助函数
function show_help
    echo (set_color -o blue)(get_msg "help_title")(set_color normal)
    echo
    echo (set_color yellow)(if test "$lang" = "zh"; echo "用途:"; else; echo "Purpose:"; end)(set_color normal)
    echo (get_msg "help_purpose")
    echo
    echo (set_color yellow)(if test "$lang" = "zh"; echo "用法:"; else; echo "Usage:"; end)(set_color normal)
    echo (get_msg "help_usage")
    echo
    echo (set_color yellow)(if test "$lang" = "zh"; echo "选项:"; else; echo "Options:"; end)(set_color normal)
    echo (get_msg "help_options")
    echo
    echo (set_color yellow)(if test "$lang" = "zh"; echo "示例:"; else; echo "Example:"; end)(set_color normal)
    echo (get_msg "help_example")
    echo
    echo (set_color yellow)(if test "$lang" = "zh"; echo "注意:"; else; echo "Notes:"; end)(set_color normal)
    echo (get_msg "help_note1")
    echo (get_msg "help_note2")
    echo (get_msg "help_note3")
end

# 定义颜色函数
function print_info
    echo (set_color -o cyan)"["(if test "$lang" = "zh"; echo "信息"; else; echo "INFO"; end)"]"(set_color normal) $argv
end

function print_success
    echo (set_color -o green)"["(if test "$lang" = "zh"; echo "成功"; else; echo "SUCCESS"; end)"]"(set_color normal) $argv
end

function print_warning
    echo (set_color -o yellow)"["(if test "$lang" = "zh"; echo "警告"; else; echo "WARNING"; end)"]"(set_color normal) $argv
end

function print_error
    echo (set_color -o red)"["(if test "$lang" = "zh"; echo "错误"; else; echo "ERROR"; end)"]"(set_color normal) $argv
end

function print_step
    echo (set_color -o blue)"["(if test "$lang" = "zh"; echo "步骤"; else; echo "STEP"; end)"]"(set_color normal) $argv
end

# 解析参数
set show_help_flag 0
set appimage_path ""

for arg in $argv
    switch $arg
        case "-h" "--help"
            set show_help_flag 1
        case "*"
            if test -z "$appimage_path"
                set appimage_path $arg
            end
    end
end

# 语言选择
choose_language

# 如果显示帮助
if test $show_help_flag -eq 1
    show_help
    exit 0
end

# 检查是否提供了AppImage路径参数
if test (count $argv) -eq 0 -o $show_help_flag -eq 1
    show_help
    exit 1
end

# 打印欢迎信息
echo (set_color -o blue)'
██████╗ ██╗     ███████╗███████╗███████╗ ██████╗ ██████╗ 
██╔══██╗██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗
██████╔╝██║     █████╗  ███████╗███████╗██║   ██║██████╔╝
██╔══██╗██║     ██╔══╝  ╚════██║╚════██║██║   ██║██╔══██╗
██████╔╝███████╗███████╗███████║███████║╚██████╔╝██║  ██║
╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝'(set_color normal)
echo (set_color -o magenta)"                                        v1.0.0"(set_color normal)
echo

# 获取AppImage路径
set appimage_path $argv[1]
set appimage_name (basename $appimage_path)
set current_dir (pwd)
set temp_dir "$current_dir/appimage_temp"

# 检查文件是否存在
if not test -f $appimage_path
    print_error (get_msg "error_file_not_exist" $appimage_path)
    exit 1
end

# 检查是否为AppImage文件
if not string match -q "*.AppImage" $appimage_path
    print_warning (get_msg "warning_not_appimage" $appimage_path)
    read -P (set_color yellow)(get_msg "continue_prompt")(set_color normal) confirm
    if test "$confirm" != y
        exit 1
    end
end

echo (set_color -o magenta)(get_msg "start_processing" $appimage_name)(set_color normal)

# 复制AppImage到当前目录
print_step (get_msg "step_copying")
cp $appimage_path ./$appimage_name
if test $status -ne 0
    print_error (get_msg "error_copy")
    exit 1
end

# 确保AppImage可执行
chmod +x ./$appimage_name

# 创建临时目录
print_step (get_msg "step_create_temp")
mkdir -p $temp_dir
if test $status -ne 0
    print_error (get_msg "error_create_temp")
    exit 1
end

# 解包AppImage
print_step (get_msg "step_extract")
print_info (get_msg "info_sudo")
sudo echo "test sudo" > /dev/null 2>&1
print_success (get_msg "success_sudo")
print_step (get_msg "step_extract")    
sudo ./$appimage_name --appimage-extract > /dev/null 2>&1
if test $status -ne 0
    print_error (get_msg "error_extract")
    rm -rf $temp_dir
    exit 1
end
sudo chown -R $USER:$USER squashfs-root > /dev/null 2>&1
mv squashfs-root $temp_dir/ > /dev/null 2>&1

# 查找main.js文件
print_step (get_msg "step_find_main")
set main_js_path (find $temp_dir -path "*/resources/app/out/main.js" -type f | head -n 1)

if test -z "$main_js_path"
    print_error (get_msg "error_find_main")
    rm -rf $temp_dir
    exit 1
end

print_success (get_msg "success_find_main" $main_js_path)

# 检查文件中是否包含需要替换的内容
set search_content '( cat /var/lib/dbus/machine-id /etc/machine-id 2> /dev/null || hostname ) | head -n 1 || :'
set replace_content 'openssl rand -hex 16 | head -c 32; echo'

print_step (get_msg "step_modify")
if not grep -F "$search_content" $main_js_path
    print_warning (get_msg "warning_not_found")
    rm -rf $temp_dir
    rm -f $appimage_name
    exit 1
else
    # 找到包含目标内容的行
    set target_line (grep -F -n "$search_content" $main_js_path | cut -d ':' -f1)
    print_info (get_msg "info_find_line" $target_line)

    # 使用perl进行替换，使用#作为分隔符
    set perl_cmd "perl -pi -e 'if (\$. == $target_line) { s#\\Q$search_content\\E#$replace_content#g }' $main_js_path"
    print_info (get_msg "info_command" (set_color yellow)$perl_cmd(set_color normal))

    eval $perl_cmd
    if test $status -ne 0
        print_error (get_msg "error_modify")
        rm -rf $temp_dir
        rm -f $appimage_name    
        exit 1
    end

    # 验证替换是否成功
    set result (sed -n "$target_line"p $main_js_path)
    print_success (get_msg "success_modify")
end

# 重新打包AppImage
print_step (get_msg "step_repack")
set squashfs_root "$temp_dir/squashfs-root"
if not test -d $squashfs_root
    set squashfs_root (find $temp_dir -name "squashfs-root" -type d | head -n 1)
    if test -z "$squashfs_root"
        print_error (get_msg "error_find_squashfs")
        rm -rf $temp_dir
        exit 1
    end
end

# 检查是否有AppRun文件
if not test -f "$squashfs_root/AppRun"
    print_error (get_msg "error_find_apprun")
    rm -rf $temp_dir
    exit 1
end

# 获取原始AppImage的权限
set original_permissions (stat -c "%a" ./$appimage_name)

# 检测架构
print_step (get_msg "step_detect_arch")
set arch_detected ""

# 尝试从AppRun文件中检测架构
if test -f "$squashfs_root/AppRun"
    set arch_from_apprun (file "$squashfs_root/AppRun" | grep -o "x86-64\|i386\|aarch64\|armv7l" | head -n 1)
    if test -n "$arch_from_apprun"
        switch $arch_from_apprun
            case x86-64
                set arch_detected x86_64
            case i386
                set arch_detected i686
            case aarch64
                set arch_detected aarch64
            case armv7l
                set arch_detected armhf
        end
    end
end

# 如果从AppRun无法检测到，尝试从其他可执行文件检测
if test -z "$arch_detected"
    set bin_files (find "$squashfs_root" -type f -executable -not -path "*/\.*" | head -n 5)
    for bin_file in $bin_files
        set arch_from_bin (file "$bin_file" | grep -o "x86-64\|i386\|aarch64\|armv7l" | head -n 1)
        if test -n "$arch_from_bin"
            switch $arch_from_bin
                case x86-64
                    set arch_detected x86_64
                    break
                case i386
                    set arch_detected i686
                    break
                case aarch64
                    set arch_detected aarch64
                    break
                case armv7l
                    set arch_detected armhf
                    break
            end
        end
    end
end

# 如果仍然无法检测，询问用户
if test -z "$arch_detected"
    print_warning (get_msg "warning_arch_detect")
    echo (get_msg "arch_select")
    echo (set_color -o)(get_msg "arch1")
    echo (get_msg "arch2")
    echo (get_msg "arch3")
    echo (get_msg "arch4")(set_color normal)
    read -P (set_color yellow)(get_msg "arch_prompt")(set_color normal) arch_choice

    switch $arch_choice
        case 1
            set arch_detected x86_64
        case 2
            set arch_detected i686
        case 3
            set arch_detected aarch64
        case 4
            set arch_detected armhf
        case "*"
            print_warning (get_msg "warning_invalid_arch")
            set arch_detected x86_64
    end
else
    print_success (get_msg "success_arch" $arch_detected)
end

# 重新打包
cd (dirname $squashfs_root)
print_step (get_msg "step_sudo_repack")
print_info (get_msg "info_arch" $arch_detected)
sudo env ARCH=$arch_detected appimagetool squashfs-root "$current_dir/$appimage_name.new"
if test $status -ne 0
    print_error (get_msg "error_repack")
    print_info (get_msg "info_install")
    print_info (get_msg "info_install_cmd")
    cd $current_dir
    rm -rf $temp_dir
    exit 1
end

cd $current_dir

# 设置新AppImage的权限
sudo chmod $original_permissions "$appimage_name.new"

# 备份原始AppImage并替换
print_step (get_msg "step_backup")
if test -f $appimage_path
    sudo cp $appimage_path "$appimage_path.bak"
    if test $status -ne 0
        print_error (get_msg "error_backup")
        rm -rf $temp_dir
        exit 1
    end

    sudo cp "$appimage_name.new" $appimage_path
    if test $status -ne 0
        print_error (get_msg "error_replace")
        rm -rf $temp_dir
        exit 1
    end

    print_success (get_msg "success_backup" "$appimage_path.bak")
    print_success (get_msg "success_replace")
else
    print_warning (get_msg "warning_no_original")
    print_info (get_msg "info_new_path" "$current_dir/$appimage_name.new")
end

# 清理
print_step (get_msg "step_cleanup")
rm -f "./$appimage_name.new"
rm -rf $temp_dir

echo (set_color -o magenta)(get_msg "finish")(set_color normal)
print_success (get_msg "success_modified")
print_success (get_msg "success_backup_path" "$appimage_path.bak")
