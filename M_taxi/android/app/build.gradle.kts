plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // Firebase plugin qo'shildi
}

android {
    namespace = "com.example.m_taksi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.m_taksi"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true  // Agar Firebase Auth yoki Firestore ishlatilsa
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
             // Proguard qoidalari (agar kerak bo'lsa)
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}


dependencies {
    // Flutterning asosiy dependencysi
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.9.0")
    
    // Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:33.16.0"))
    
    // Firebase modullari (kerakli bo'lganlarini qo'shing)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-auth-ktx")     // Authentication uchun
    implementation("com.google.firebase:firebase-firestore-ktx") // Firestore uchun
    implementation("com.google.firebase:firebase-messaging-ktx") // FCM uchun
    implementation("com.google.firebase:firebase-storage-ktx")  // Storage uchun
    
    // MultiDex (agar minSdk 21 dan past bo'lsa)
    implementation("androidx.multidex:multidex:2.0.1")
    
    // Flutter Firebase pluginsi uchun (pubspec.yaml da qo'shilgan bo'lsa)
    implementation("com.google.firebase:firebase-core:21.1.1")
}