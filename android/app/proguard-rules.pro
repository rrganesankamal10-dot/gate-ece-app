# Flutter keep rules
-keep class io.flutter.** { *; }
-keep class com.kamal.gateece.** { *; }

# Google Play Core – referenced by Flutter's deferred component manager.
# These classes may be absent at build time; keep rules prevent R8 errors.
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Prevent R8 from stripping referenced-but-absent Play Core split-install classes
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# General Android keep rules
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
