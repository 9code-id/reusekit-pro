@echo off
echo Setting up memory optimization for APK build...

REM Set environment variables for increased memory
set FLUTTER_MEMORY_MAX=8192
set DART_VM_OPTIONS=--old-space-heap-size=8192 --new-space-heap-size=512
set GRADLE_OPTS=-Xmx8g -XX:MaxMetaspaceSize=4g -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC

echo Cleaning previous builds...
flutter clean

echo Starting APK build with memory optimization...
flutter build apk --release --target-platform android-arm,android-arm64

echo Build completed!
pause
