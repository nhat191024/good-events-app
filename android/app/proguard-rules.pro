# Tránh lỗi thiếu Google Play Core (Deferred Components)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Tránh lỗi SLF4J (Thường đi kèm với các thư viện log/backend)
-dontwarn org.slf4j.**
-keep class org.slf4j.** { *; }

# Các rule quan trọng cho Flutter bản mới
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# Nếu vẫn báo thiếu các class cụ thể trong log, dùng thêm dòng này:
-ignorewarnings