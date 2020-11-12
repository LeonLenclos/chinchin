# Chin Chin


make .love file
```
cd src/
zip -r ../dist/chinchin.love
```

make win32 exec file

```
cd dist/
wget https://github.com/love2d/love/releases/download/0.9.1/love-0.9.1-win32.zip
unzip love-0.9.1-win32.zip
mkdir chinchin-win32
cat love-0.9.1-win32/love.exe chinchin.love > chinchin-win32/chinchin.exe
mv love-0.9.1-win32/*.dll love-0.9.1-win32/license.txt chinchin-win32
rm love-0.9.1-win32.zip
rm -r love-0.9.1-win32
```
mac macosX

```
cd dist/
wget https://github.com/love2d/love/releases/download/0.9.1/love-0.9.1-macosx-x64.zip
unzip love-0.9.1-macosx-x64.zip
mkdir chinchin-macosx
mv love.app chinchin-macosx/chinchin.app
cp chinchin.love chinchin-macosx/chinchin.app/Contents/Resources/
echo '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>BuildMachineOSBuild</key><string>13D65</string><key>CFBundleDevelopmentRegion</key><string>English</string><key>CFBundleDocumentTypes</key><array><dict><key>CFBundleTypeIconFile</key><string>LoveDocument.icns</string><key>CFBundleTypeName</key><string>LÖVE Project</string><key>CFBundleTypeRole</key><string>Viewer</string><key>LSHandlerRank</key><string>Owner</string><key>LSItemContentTypes</key><array><string>org.love2d.love-game</string></array></dict><dict><key>CFBundleTypeName</key><string>Folder</string><key>CFBundleTypeOSTypes</key><array><string>fold</string></array><key>CFBundleTypeRole</key><string>Viewer</string><key>LSHandlerRank</key><string>None</string></dict></array><key>CFBundleExecutable</key><string>love</string><key>CFBundleIconFile</key><string>Love.icns</string><key>CFBundleIdentifier</key><string>net.leonlenclos.chinchin</string><key>CFBundleInfoDictionaryVersion</key><string>6.0</string><key>CFBundleName</key><string>Chin Chin</string><key>CFBundlePackageType</key><string>APPL</string><key>CFBundleShortVersionString</key><string>0.9.1</string><key>CFBundleSignature</key><string>LoVe</string><key>DTCompiler</key><string>com.apple.compilers.llvm.clang.1_0</string><key>DTPlatformBuild</key><string>5B1008</string><key>DTPlatformVersion</key><string>GM</string><key>DTSDKBuild</key><string>13C64</string><key>DTSDKName</key><string>macosx10.9</string><key>DTXcode</key><string>0511</string><key>DTXcodeBuild</key><string>5B1008</string><key>LSApplicationCategoryType</key><string>public.app-category.games</string><key>NSHumanReadableCopyright</key><string>© 2006-2014 LÖVE Development Team</string><key>NSPrincipalClass</key><string>NSApplication</string></dict></plist>' > chinchin-macosx/chinchin.app/Contents/Info.plist
rm love-0.9.1-macosx-x64.zip
rm -r love-0.9.1-macosx-x64

```