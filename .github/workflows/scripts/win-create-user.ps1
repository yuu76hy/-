# 生成5位随机阿拉伯数字密码
$rdpPassword = Get-Random -Minimum 10000 -Maximum 99999
$env:RDP_CREDS = $rdpPassword

# 创建用户并设置密码
$userParams = @{
    Name = "vum"
    AccountPassword = ConvertTo-SecureString $rdpPassword -AsPlainText -Force
    Enabled = $true
    PasswordNeverExpires = $true
}
New-LocalUser @userParams -ErrorAction SilentlyContinue

# 将用户添加到管理员组
Add-LocalGroupMember -Group "Administrators" -Member "vum" -ErrorAction SilentlyContinue

# 输出密码到环境变量供后续使用
Write-Output "密码已设置为: $rdpPassword"
