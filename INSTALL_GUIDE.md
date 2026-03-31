# Maccy 安装指南

## 功能说明
这是 Maccy 的修改版本，新增了智能去重功能：
- ✅ 自动去除复制文本的前后空格和制表符（保留换行符）
- ✅ 相同内容不会重复记录，自动移到最前面
- ✅ 智能比对，即使格式不同也能识别相同内容

## 系统要求
- macOS Sonoma 14.0 或更高版本

## 安装步骤

### 方法一：从 ZIP 文件安装

1. **下载并解压** `Maccy.zip`

2. **移动到应用程序文件夹**
   ```bash
   # 如果已安装旧版本，先删除
   rm -rf /Applications/Maccy.app

   # 复制新版本
   cp -r Maccy.app /Applications/
   ```

3. **首次打开**
   - ⚠️ 双击打开可能会提示"无法打开"
   - 正确做法：**右键点击** Maccy.app → **选择「打开」** → **点击「打开」**
   - 这个步骤只需要做一次

4. **授予权限**
   - 打开 **系统设置** → **隐私与安全性** → **辅助功能**
   - 确保 **Maccy** 已勾选

5. **开始使用**
   - 快捷键：<kbd>⇧</kbd> + <kbd>⌘</kbd> + <kbd>C</kbd>

### 方法二：从 DMG 文件安装

1. 双击 `Maccy.dmg`
2. 将 Maccy 图标拖到 Applications 文件夹
3. 右键点击 Maccy → 打开
4. 授予辅助功能权限

## 测试新功能

1. 复制一段文本，例如：`hello`
2. 再复制相同文本但带空格：`  hello  `
3. 打开 Maccy（⇧⌘C）
4. 应该只看到一条 `hello` 记录，而不是两条 ✅

## 卸载

```bash
rm -rf /Applications/Maccy.app
rm -rf ~/Library/Preferences/org.p0deje.Maccy.plist
rm -rf ~/Library/Application\ Support/Maccy
```

## 常见问题

### Q: 提示"已损坏，无法打开"？
A: 这是因为应用未经过 Apple 公证。解决方法：
```bash
# 移除隔离属性
xattr -cr /Applications/Maccy.app
```

### Q: 无法粘贴？
A: 确保在「系统设置 → 隐私与安全性 → 辅助功能」中授予了 Maccy 权限

### Q: 想恢复原版 Maccy？
A: 使用 Homebrew 重新安装：
```bash
brew reinstall maccy
```

## 反馈问题

如果遇到问题，请联系开发者或在 GitHub 上提交 Issue。
