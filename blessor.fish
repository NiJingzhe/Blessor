#!/usr/bin/env fish

# 定义帮助函数
function show_help
    echo (set_color -o blue)"Blessor - Cursor 机器码检查绕过工具"(set_color normal)
    echo
    echo (set_color yellow)"用途:"(set_color normal)
    echo "  通过修改 Cursor 的 AppImage 中的 main.js 文件，绕过机器码检查"
    echo
    echo (set_color yellow)"用法:"(set_color normal)
    echo "  ./blessor.fish <AppImage路径>"
    echo
    echo (set_color yellow)"选项:"(set_color normal)
    echo "  -h, --help     显示此帮助信息"
    echo
    echo (set_color yellow)"示例:"(set_color normal)
    echo "  ./blessor.fish /path/to/Cursor.AppImage"
    echo
    echo (set_color yellow)"注意:"(set_color normal)
    echo "  - 脚本需要管理员权限"
    echo "  - 原始 AppImage 将被备份"
    echo "  - 修改会替换机器码获取逻辑，使用随机生成的标识符"
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

# 定义颜色函数
function print_info
    echo (set_color -o cyan)"[信息]"(set_color normal) $argv
end

function print_success
    echo (set_color -o green)"[成功]"(set_color normal) $argv
end

function print_warning
    echo (set_color -o yellow)"[警告]"(set_color normal) $argv
end

function print_error
    echo (set_color -o red)"[错误]"(set_color normal) $argv
end

function print_step
    echo (set_color -o blue)"[步骤]"(set_color normal) $argv
end

# 获取AppImage路径
set appimage_path $argv[1]
set appimage_name (basename $appimage_path)
set current_dir (pwd)
set temp_dir "$current_dir/appimage_temp"
set backup_name "$appimage_name.bak"

# 检查文件是否存在
if not test -f $appimage_path
    print_error "文件 '$appimage_path' 不存在"
    exit 1
end

# 检查是否为AppImage文件
if not string match -q "*.AppImage" $appimage_path
    print_warning "文件 '$appimage_path' 可能不是AppImage文件"
    read -P (set_color yellow)"是否继续? (y/n) "(set_color normal) confirm
    if test "$confirm" != y
        exit 1
    end
end

echo (set_color -o magenta)"=== 开始处理 $appimage_name ==="(set_color normal)

# 复制AppImage到当前目录
print_step "正在复制AppImage到当前目录..."
cp $appimage_path ./$appimage_name
if test $status -ne 0
    print_error 无法复制AppImage文件
    exit 1
end

# 确保AppImage可执行
chmod +x ./$appimage_name

# 创建临时目录
print_step "创建临时目录..."
mkdir -p $temp_dir
if test $status -ne 0
    print_error 无法创建临时目录
    exit 1
end

# 解包AppImage
print_step "正在解包AppImage..."
print_info "需要管理员权限来解包AppImage..."
sudo echo "test sudo" > /dev/null 2>&1
print_success "成功获得管理员权限..."
print_step "正在解包AppImage..."    
sudo ./$appimage_name --appimage-extract > /dev/null 2>&1
if test $status -ne 0
    print_error 解包AppImage失败
    rm -rf $temp_dir
    exit 1
end
sudo chown -R $USER:$USER squashfs-root > /dev/null 2>&1
mv squashfs-root $temp_dir/ > /dev/null 2>&1

# 查找main.js文件
print_step "正在查找main.js文件..."
set main_js_path (find $temp_dir -path "*/resources/app/out/main.js" -type f | head -n 1)

if test -z "$main_js_path"
    print_error "无法找到main.js文件"
    rm -rf $temp_dir
    exit 1
end

print_success "找到main.js文件: $main_js_path"

# 检查文件中是否包含需要替换的内容
set search_content '( cat /var/lib/dbus/machine-id /etc/machine-id 2> /dev/null || hostname ) | head -n 1 || :'
set replace_content 'openssl rand -hex 16 | head -c 32; echo'

print_step "正在检查并修改main.js文件..."
if not grep -F "$search_content" $main_js_path
    print_warning "在main.js中未找到需要替换的内容"
    rm -rf $temp_dir
    exit 1
else
    # 找到包含目标内容的行
    set target_line (grep -F -n "$search_content" $main_js_path | cut -d ':' -f1)
    print_info "找到目标内容在第 $target_line 行"

    # 使用perl进行替换，使用#作为分隔符
    set perl_cmd "perl -pi -e 'if (\$. == $target_line) { s#\\Q$search_content\\E#$replace_content#g }' $main_js_path"
    print_info "即将执行的命令: "(set_color yellow)$perl_cmd(set_color normal)

    eval $perl_cmd
    if test $status -ne 0
        print_error "无法修改main.js文件"
        rm -rf $temp_dir
        rm -f $appimage_name    
        exit 1
    end

    # 验证替换是否成功
    set result (sed -n "$target_line"p $main_js_path)
    print_success "成功修改main.js文件"
end

# 重新打包AppImage
print_step "正在重新打包AppImage..."
set squashfs_root "$temp_dir/squashfs-root"
if not test -d $squashfs_root
    set squashfs_root (find $temp_dir -name "squashfs-root" -type d | head -n 1)
    if test -z "$squashfs_root"
        print_error 无法找到squashfs-root目录
        rm -rf $temp_dir
        exit 1
    end
end

# 检查是否有AppRun文件
if not test -f "$squashfs_root/AppRun"
    print_error 在解包目录中未找到AppRun文件
    rm -rf $temp_dir
    exit 1
end

# 获取原始AppImage的权限
set original_permissions (stat -c "%a" ./$appimage_name)

# 检测架构
print_step "正在检测AppImage架构..."
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
    print_warning 无法自动检测AppImage架构
    echo "请选择架构:"
    echo (set_color -o)"1) x86_64 (64位Intel/AMD)"
    echo "2) i686 (32位Intel/AMD)"
    echo "3) aarch64 (64位ARM)"
    echo "4) armhf (32位ARM)"(set_color normal)
    read -P (set_color yellow)"请输入选项 (1-4): "(set_color normal) arch_choice

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
            print_warning "无效选项，默认使用x86_64"
            set arch_detected x86_64
    end
else
    print_success "检测到架构: $arch_detected"
end

# 重新打包
cd (dirname $squashfs_root)
print_step "需要管理员权限来重新打包AppImage..."
print_info "使用架构: $arch_detected"
sudo env ARCH=$arch_detected appimagetool squashfs-root "$current_dir/$appimage_name.new"
if test $status -ne 0
    print_error 重新打包AppImage失败
    print_info 请确保已安装appimagetool
    print_info "可以通过以下命令安装: "(set_color yellow)"sudo apt-get install appimagetool"(set_color normal)" 或 "(set_color yellow)"sudo pacman -S appimagetool"(set_color normal)
    cd $current_dir
    rm -rf $temp_dir
    exit 1
end

cd $current_dir

# 设置新AppImage的权限
sudo chmod $original_permissions "$appimage_name.new"

# 备份原始AppImage并替换
print_step "正在备份原始AppImage并替换..."
if test -f $appimage_path
    sudo cp $appimage_path "$appimage_path.$backup_name"
    if test $status -ne 0
        print_error 无法备份原始AppImage
        rm -rf $temp_dir
        exit 1
    end

    sudo cp "$appimage_name.new" $appimage_path
    if test $status -ne 0
        print_error 无法替换原始AppImage
        rm -rf $temp_dir
        exit 1
    end

    print_success "成功备份原始AppImage为: $appimage_path.$backup_name"
    print_success 成功替换原始AppImage
else
    print_warning "原始AppImage不存在，无法替换"
    print_info "新的AppImage已保存为: $current_dir/$appimage_name.new"
end

# 清理
print_step "正在清理临时文件..."
rm -f "./$appimage_name.new"
rm -rf $temp_dir

echo (set_color -o magenta)"=== 处理完成! ==="(set_color normal)
print_success 修改后的AppImage已替换原始文件
print_success "原始AppImage已备份为: $appimage_path.bak"
