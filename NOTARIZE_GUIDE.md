# Maccy 公证发布指南

⚠️ 此方法需要付费的 Apple Developer 账号（$99/年）

## 为什么需要公证？

公证（Notarization）让用户可以直接双击打开应用，无需右键点击。

## 前置要求

1. **Apple Developer 账号**
   - 注册地址：https://developer.apple.com/programs/
   - 费用：$99/年

2. **Developer ID Application 证书**
   - 在 developer.apple.com 下载安装

3. **App-Specific Password**
   - 访问：https://appleid.apple.com/account/manage
   - 生成一个应用专用密码用于公证

## 步骤 1：配置代码签名

1. 打开 Xcode 项目
2. 选择 Maccy target → Signing & Capabilities
3. Team 选择你的付费开发者账号
4. Signing Certificate 选择 "Developer ID Application"

## 步骤 2：构建并签名

```bash
cd /Users/nick.song/work/vibe/Maccy

# 清理
xcodebuild clean

# 构建 Release 版本
xcodebuild -scheme Maccy \
           -configuration Release \
           -derivedDataPath build/DerivedData \
           archive \
           -archivePath build/Maccy.xcarchive

# 导出签名的 app
xcodebuild -exportArchive \
           -archivePath build/Maccy.xcarchive \
           -exportPath build \
           -exportOptionsPlist exportOptions.plist
```

## 步骤 3：创建 exportOptions.plist

```bash
cat > exportOptions.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>developer-id</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
</dict>
</plist>
EOF
```

将 `YOUR_TEAM_ID` 替换为你的 Team ID（在 developer.apple.com 可以找到）

## 步骤 4：公证应用

```bash
# 1. 打包为 ZIP
cd build
ditto -c -k --keepParent Maccy.app Maccy.zip

# 2. 提交公证
xcrun notarytool submit Maccy.zip \
    --apple-id "your@email.com" \
    --password "your-app-specific-password" \
    --team-id "YOUR_TEAM_ID" \
    --wait

# 3. 如果公证成功，装订公证凭证
xcrun stapler staple Maccy.app

# 4. 验证
spctl -a -vv Maccy.app
```

## 步骤 5：创建最终分发包

```bash
# 创建 DMG
create-dmg \
  --volname "Maccy" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Maccy.app" 200 190 \
  --app-drop-link 600 185 \
  Maccy.dmg \
  Maccy.app

# 公证 DMG
xcrun notarytool submit Maccy.dmg \
    --apple-id "your@email.com" \
    --password "your-app-specific-password" \
    --team-id "YOUR_TEAM_ID" \
    --wait

# 装订 DMG
xcrun stapler staple Maccy.dmg
```

## 步骤 6：发布

现在你可以：
1. 上传到 GitHub Releases
2. 分享下载链接
3. 提交到 Homebrew

用户可以直接双击打开，无需任何额外步骤！

## 自动化脚本

如果需要频繁发布，可以使用 fastlane 或 GitHub Actions 自动化这个流程。
