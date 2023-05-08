# 连接大屏并推送release版本脚本

flutter build apk

adb connect 192.168.16.120

 adb install build/app/outputs/flutter-apk/app-release.apk

 echo 'success install apk'

 adb disconnect

 adb connect 192.168.16.115

# adb install build/app/outputs/flutter-apk/app-release.apk

# echo 'success install apk'

# adb disconnect

# adb connect 192.168.16.144

adb install build/app/outputs/flutter-apk/app-release.apk

echo 'success install apk'