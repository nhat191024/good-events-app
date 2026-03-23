# Tránh lỗi thiếu Google Play Core (Deferred Components)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Tránh lỗi SLF4J (Thường đi kèm với các thư viện log/backend)
-dontwarn org.slf4j.**
-keep class org.slf4j.** { *; }

# Các rule quan trọng cho Flutter bản mới
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# Fix: PlatformException channel-error cho path_provider_android (Pigeon)
# R8/ProGuard xóa các Pigeon-generated class trong release mode
-keep class dev.flutter.pigeon.** { *; }
-keep class io.flutter.plugins.pathprovider.** { *; }
-dontwarn io.flutter.plugins.pathprovider.**

# Giữ tất cả Flutter plugin channels khỏi bị obfuscate
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Nếu vẫn báo thiếu các class cụ thể trong log, dùng thêm dòng này:
-ignorewarnings