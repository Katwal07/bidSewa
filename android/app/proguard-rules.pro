# Keep OkHttp classes
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep BouncyCastle classes
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# Keep Conscrypt classes
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**

# Keep OpenJSSE classes
-keep class org.openjsse.** { *; }
-dontwarn org.openjsse.**
