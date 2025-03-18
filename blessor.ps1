# blessor.ps1 - Cursor 机器码检查绕过工具 (Windows版)

# 解析命令行参数
param(
    [string]$CursorPath,
    [switch]$help
)

# 定义语言选择变量（默认为中文）
$global:lang = "zh"
# 定义执行状态变量
$global:executionSuccess = $true

# 获取对应语言的消息
function Get-Message {
    param (
        [Parameter(Mandatory=$true)]
        [string]$MessageId,
        
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Args
    )
    
    # 定义消息映射
    $messages = @{
        # 帮助信息
        "help_title" = @{
            "zh" = "Blessor - Cursor 机器码检查绕过工具 (Windows版)";
            "en" = "Blessor - Cursor Machine ID Bypass Tool (Windows version)";
        };
        "help_purpose" = @{
            "zh" = "  修改 Cursor 程序中的 main.js 文件，绕过机器码检查";
            "en" = "  Bypass machine ID check by modifying main.js file in Cursor installation";
        };
        "help_usage" = @{
            "zh" = "  .\blessor.ps1 [Cursor安装路径]";
            "en" = "  .\blessor.ps1 [Cursor installation path]";
        };
        "help_params" = @{
            "zh" = "  [Cursor安装路径]  可选，默认为: $env:LOCALAPPDATA\Programs\cursor";
            "en" = "  [Cursor installation path]  Optional, default: $env:LOCALAPPDATA\Programs\cursor";
        };
        "help_options" = @{
            "zh" = "  -h, -help     显示此帮助信息";
            "en" = "  -h, -help     Show this help message";
        };
        "help_example1" = @{
            "zh" = "  .\blessor.ps1";
            "en" = "  .\blessor.ps1";
        };
        "help_example2" = @{
            "zh" = "  .\blessor.ps1 D:\Programs\cursor";
            "en" = "  .\blessor.ps1 D:\Programs\cursor";
        };
        "help_note1" = @{
            "zh" = "  - 原始main.js文件将被备份";
            "en" = "  - The original main.js file will be backed up";
        };
        "help_note2" = @{
            "zh" = "  - 修改会替换机器码获取逻辑，使用随机生成的GUID";
            "en" = "  - The modification replaces machine ID logic with a randomly generated GUID";
        };
        
        # 语言选择
        "lang_select" = @{
            "zh" = "请选择语言 / Please choose language:";
            "en" = "请选择语言 / Please choose language:";
        };
        "lang_option1" = @{
            "zh" = "1) 中文 (Chinese)";
            "en" = "1) 中文 (Chinese)";
        };
        "lang_option2" = @{
            "zh" = "2) English (英文)";
            "en" = "2) English (英文)";
        };
        "lang_prompt" = @{
            "zh" = "请输入选项 / Please enter option (1-2): ";
            "en" = "请输入选项 / Please enter option (1-2): ";
        };
        "lang_invalid" = @{
            "zh" = "无效选项，默认使用中文 / Invalid option, using Chinese as default";
            "en" = "无效选项，默认使用中文 / Invalid option, using Chinese as default";
        };
        
        # 状态消息
        "default_path" = @{
            "zh" = "未提供路径，使用默认安装路径: {0}";
            "en" = "No path provided, using default installation path: {0}";
        };
        "path_not_exist" = @{
            "zh" = "指定的Cursor路径不存在: {0}";
            "en" = "Specified Cursor path does not exist: {0}";
        };
        "check_path" = @{
            "zh" = "请检查Cursor的安装路径或手动指定路径";
            "en" = "Please check the Cursor installation path or specify it manually";
        };
        "mainjs_not_found" = @{
            "zh" = "在指定路径中未找到main.js文件: {0}";
            "en" = "main.js file not found in specified path: {0}";
        };
        "confirm_path" = @{
            "zh" = "请确认Cursor安装路径是否正确";
            "en" = "Please confirm if the Cursor installation path is correct";
        };
        "found_mainjs" = @{
            "zh" = "找到main.js文件: {0}";
            "en" = "Found main.js file: {0}";
        };
        "backing_up" = @{
            "zh" = "正在备份main.js文件...";
            "en" = "Backing up main.js file...";
        };
        "backup_success" = @{
            "zh" = "成功备份main.js到: {0}";
            "en" = "Successfully backed up main.js to: {0}";
        };
        "backup_failed" = @{
            "zh" = "备份文件失败: {0}";
            "en" = "Failed to backup file: {0}";
        };
        "reading_file" = @{
            "zh" = "正在读取main.js文件...";
            "en" = "Reading main.js file...";
        };
        "read_success" = @{
            "zh" = "成功读取main.js文件";
            "en" = "Successfully read main.js file";
        };
        "read_failed" = @{
            "zh" = "读取文件失败: {0}";
            "en" = "Failed to read file: {0}";
        };
        "finding_modifying" = @{
            "zh" = "正在查找并修改机器码获取逻辑...";
            "en" = "Finding and modifying machine ID retrieval logic...";
        };
        "found_target" = @{
            "zh" = "找到目标内容，开始替换...";
            "en" = "Target content found, starting replacement...";
        };
        "write_success" = @{
            "zh" = "成功修改main.js文件";
            "en" = "Successfully modified main.js file";
        };
        "write_failed" = @{
            "zh" = "写入文件失败: {0}";
            "en" = "Failed to write file: {0}";
        };
        "restored" = @{
            "zh" = "已恢复原始文件";
            "en" = "Original file has been restored";
        };
        "target_not_found" = @{
            "zh" = "在main.js中未找到目标内容";
            "en" = "Target content not found in main.js";
        };
        "searching_alt" = @{
            "zh" = "尝试查找相关内容...";
            "en" = "Trying to find related content...";
        };
        "found_related" = @{
            "zh" = "找到相关内容 {0}，出现 {1} 次";
            "en" = "Found related content {0}, found {1} occurrences";
        };
        "match_content" = @{
            "zh" = "  匹配内容: {0}";
            "en" = "  Matched content: {0}";
        };
        "no_related" = @{
            "zh" = "未找到任何相关内容，无法执行替换";
            "en" = "No related content found, cannot perform replacement";
        };
        "manual_edit" = @{
            "zh" = "无法自动替换，建议手动编辑文件";
            "en" = "Cannot automatically replace, manual file editing is recommended";
        };
        "backup_saved" = @{
            "zh" = "main.js备份已保存在: {0}";
            "en" = "main.js backup has been saved to: {0}";
        };
        "manual_edit_hint" = @{
            "zh" = "您可以手动编辑文件，查找并替换相关内容";
            "en" = "You can manually edit the file, find and replace related content";
        };
        "cleanup" = @{
            "zh" = "清理完成...";
            "en" = "Cleanup complete...";
        };
        "processing_complete" = @{
            "zh" = "=== 处理完成! ===";
            "en" = "=== Processing complete! ===";
        };
        "mod_success" = @{
            "zh" = "已成功修改Cursor的机器码获取逻辑";
            "en" = "Successfully modified Cursor's machine ID retrieval logic";
        };
        "backup_path" = @{
            "zh" = "原始文件已备份为: {0}";
            "en" = "Original file has been backed up to: {0}";
        };
        "problem_hint" = @{
            "zh" = "如果Cursor出现问题，可以用备份文件恢复";
            "en" = "If Cursor has issues, you can restore using the backup file";
        };
        "execution_success" = @{
            "zh" = "操作成功完成！";
            "en" = "Operation completed successfully!";
        };
        "execution_failure" = @{
            "zh" = "操作过程中出现错误，请检查日志获取详细信息。";
            "en" = "Errors occurred during operation. Please check the log for details.";
        };
    }
    
    # 根据lang获取消息
    $msg = $messages[$MessageId][$global:lang]
    
    # 如果提供了参数，进行替换
    if ($Args -and $Args.Count -gt 0) {
        for ($i = 0; $i -lt $Args.Count; $i++) {
            $placeholder = "{$i}"
            $msg = $msg -replace [regex]::Escape($placeholder), $Args[$i]
        }
    }
    
    return $msg
}

# 语言选择函数
function Choose-Language {
    Write-Host (Get-Message "lang_select") -ForegroundColor Magenta
    Write-Host (Get-Message "lang_option1") -ForegroundColor Blue
    Write-Host (Get-Message "lang_option2") -ForegroundColor Blue
    
    $choice = Read-Host -Prompt (Get-Message "lang_prompt")
    
    switch ($choice) {
        "1" {
            $global:lang = "zh"
            return
        }
        "2" {
            $global:lang = "en"
            return
        }
        default {
            Write-Host (Get-Message "lang_invalid") -ForegroundColor Yellow
            $global:lang = "zh"
            return
        }
    }
}

# 彩色输出函数
function Write-ColorOutput {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$true)]
        [string]$ForegroundColor,
        
        [string]$Prefix
    )
    
    if ($Prefix) {
        Write-Host "[$Prefix] " -NoNewline -ForegroundColor $ForegroundColor
    }
    Write-Host $Message
}

function Write-Info {
    param ([string]$Message)
    $prefix = if ($global:lang -eq "zh") { "信息" } else { "INFO" }
    Write-ColorOutput -Message $Message -ForegroundColor Cyan -Prefix $prefix
}

function Write-Success {
    param ([string]$Message)
    $prefix = if ($global:lang -eq "zh") { "成功" } else { "SUCCESS" }
    Write-ColorOutput -Message $Message -ForegroundColor Green -Prefix $prefix
}

function Write-Warning {
    param ([string]$Message)
    $prefix = if ($global:lang -eq "zh") { "警告" } else { "WARNING" }
    Write-ColorOutput -Message $Message -ForegroundColor Yellow -Prefix $prefix
}

function Write-Error {
    param ([string]$Message)
    $prefix = if ($global:lang -eq "zh") { "错误" } else { "ERROR" }
    Write-ColorOutput -Message $Message -ForegroundColor Red -Prefix $prefix
    # 设置全局执行状态为失败
    $global:executionSuccess = $false
}

function Write-Step {
    param ([string]$Message)
    $prefix = if ($global:lang -eq "zh") { "步骤" } else { "STEP" }
    Write-ColorOutput -Message $Message -ForegroundColor Blue -Prefix $prefix
}

function Show-Banner {
    Write-Host "" 
    $banner = @"
██████╗ ██╗     ███████╗███████╗███████╗ ██████╗ ██████╗ 
██╔══██╗██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗
██████╔╝██║     █████╗  ███████╗███████╗██║   ██║██████╔╝
██╔══██╗██║     ██╔══╝  ╚════██║╚════██║╚════██║██║   ██║
██████╔╝███████╗███████╗███████║███████║╚██████╔╝██║  ██║
╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
"@
    Write-Host $banner -ForegroundColor Blue
    Write-Host "                                        v1.0.0" -ForegroundColor Magenta
    Write-Host ""
}

function Show-Help {
    Write-Host (Get-Message "help_title") -ForegroundColor Blue
    Write-Host ""
    Write-Host ($global:lang -eq "zh" ? "用途:" : "Purpose:") -ForegroundColor Yellow
    Write-Host (Get-Message "help_purpose")
    Write-Host ""
    Write-Host ($global:lang -eq "zh" ? "用法:" : "Usage:") -ForegroundColor Yellow
    Write-Host (Get-Message "help_usage")
    Write-Host ""
    Write-Host ($global:lang -eq "zh" ? "参数:" : "Parameters:") -ForegroundColor Yellow
    Write-Host (Get-Message "help_params")
    Write-Host ""
    Write-Host ($global:lang -eq "zh" ? "选项:" : "Options:") -ForegroundColor Yellow
    Write-Host (Get-Message "help_options")
    Write-Host ""
    Write-Host ($global:lang -eq "zh" ? "示例:" : "Examples:") -ForegroundColor Yellow
    Write-Host (Get-Message "help_example1")
    Write-Host (Get-Message "help_example2")
    Write-Host ""
    Write-Host ($global:lang -eq "zh" ? "注意:" : "Notes:") -ForegroundColor Yellow
    Write-Host (Get-Message "help_note1")
    Write-Host (Get-Message "help_note2")
}

# 语言选择
Choose-Language

# 显示帮助
if ($help -or $args -contains "-h" -or $args -contains "-help" -or $args -contains "--help") {
    Show-Help
    exit 0
}

# 显示欢迎信息
Show-Banner

# 设置默认路径
if ([string]::IsNullOrEmpty($CursorPath)) {
    $username = $env:USERNAME
    $CursorPath = "$env:LOCALAPPDATA\Programs\cursor"
    Write-Info (Get-Message "default_path" $CursorPath)
}

# 确认Cursor安装路径存在
if (-not (Test-Path -Path $CursorPath)) {
    Write-Error (Get-Message "path_not_exist" $CursorPath)
    Write-Info (Get-Message "check_path")
    exit 1
}

# 构建main.js的路径
$mainJsPath = Join-Path -Path $CursorPath -ChildPath "resources\app\out\main.js"

# 检查main.js文件是否存在
if (-not (Test-Path -Path $mainJsPath)) {
    Write-Error (Get-Message "mainjs_not_found" $mainJsPath)
    Write-Info (Get-Message "confirm_path")
    exit 1
}

Write-Success (Get-Message "found_mainjs" $mainJsPath)

# 备份main.js文件
$backupPath = "$mainJsPath.bak"
Write-Step (Get-Message "backing_up")

try {
    Copy-Item -Path $mainJsPath -Destination $backupPath -Force
    if (Test-Path -Path $backupPath) {
        Write-Success (Get-Message "backup_success" $backupPath)
    } else {
        Write-Error (Get-Message "backup_failed" "无法创建备份文件")
        exit 1
    }
}
catch {
    Write-Error (Get-Message "backup_failed" $_)
    exit 1
}

# 读取main.js文件内容
Write-Step (Get-Message "reading_file")
try {
    $content = Get-Content -Path $mainJsPath -Raw
    if ($content) {
        Write-Success (Get-Message "read_success")
    } else {
        Write-Error (Get-Message "read_failed" "文件内容为空")
        exit 1
    }
}
catch {
    Write-Error (Get-Message "read_failed" $_)
    exit 1
}

# 查找并替换机器码获取逻辑
Write-Step (Get-Message "finding_modifying")

# 要搜索和替换的内容
$searchContent = 'win32:`${b5[o$()]}\\REG.exe QUERY HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography /v MachineGuid`'
$replaceContent = 'win32:`@powershell -NoProfile -Command "echo xxxx    REG_SZ    $([guid]::NewGuid().toString())"`'

if ($content -match [regex]::Escape($searchContent)) {
    Write-Info (Get-Message "found_target")
    
    # 执行替换
    $newContent = $content -replace [regex]::Escape($searchContent), $replaceContent
    
    # 写入文件
    try {
        Set-Content -Path $mainJsPath -Value $newContent
        
        # 验证修改是否成功
        $verifyContent = Get-Content -Path $mainJsPath -Raw
        if ($verifyContent -match [regex]::Escape($replaceContent)) {
            Write-Success (Get-Message "write_success")
        } else {
            Write-Error (Get-Message "write_failed" "验证修改内容失败")
            # 尝试恢复备份
            Copy-Item -Path $backupPath -Destination $mainJsPath -Force
            Write-Info (Get-Message "restored")
            exit 1
        }
    }
    catch {
        Write-Error (Get-Message "write_failed" $_)
        # 尝试恢复备份
        Copy-Item -Path $backupPath -Destination $mainJsPath -Force
        Write-Info (Get-Message "restored")
        exit 1
    }
}
else {
    Write-Warning (Get-Message "target_not_found")
    Write-Info (Get-Message "searching_alt")
    
    # 尝试查找与Cryptography或MachineGuid相关的内容
    $patterns = @(
        "Cryptography",
        "MachineGuid",
        "REG.exe QUERY"
    )
    
    $found = $false
    foreach ($pattern in $patterns) {
        if ($content -match $pattern) {
            $found = $true
            $matches = Select-String -InputObject $content -Pattern $pattern -AllMatches
            $matchCount = $matches.Matches.Count
            Write-Info (Get-Message "found_related" "'$pattern'" $matchCount)
            
            # 显示部分匹配内容
            foreach ($match in $matches.Matches | Select-Object -First 3) {
                $lineContent = ($content -split "`n")[$match.Index..($match.Index+100) -join ""]
                $shortContent = $lineContent.Substring(0, [Math]::Min(100, $lineContent.Length))
                Write-Host (Get-Message "match_content" "$shortContent...") -ForegroundColor Yellow
            }
        }
    }
    
    if (-not $found) {
        Write-Error (Get-Message "no_related")
        # 恢复备份
        Copy-Item -Path $backupPath -Destination $mainJsPath -Force
        Write-Info (Get-Message "restored")
        exit 1
    }
    
    # 询问用户是否尝试手动替换
    Write-Warning (Get-Message "manual_edit")
    Write-Info (Get-Message "backup_saved" $backupPath)
    Write-Info (Get-Message "manual_edit_hint")
    exit 1
}

Write-Step (Get-Message "cleanup")
Write-Host ""
Write-Host (Get-Message "processing_complete") -ForegroundColor Magenta

# 根据执行状态提供最终反馈
if ($global:executionSuccess) {
    Write-Success (Get-Message "execution_success")
    Write-Success (Get-Message "mod_success")
    Write-Success (Get-Message "backup_path" $backupPath)
    Write-Info (Get-Message "problem_hint")
    exit 0
} else {
    Write-Error (Get-Message "execution_failure")
    exit 1
} 