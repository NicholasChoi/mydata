export ANDROID_HOME='/Users/Nick/Library/Android/sdk'
export JAVA_HOME=`/usr/libexec/java_home`
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias logcat='adb logcat -v threadtime' #logcat은 이렇게 alias 해두면 편함.
