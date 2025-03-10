plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.gurkha_pasal"
    compileSdk = 34  // Latest stable as of 2025, or use flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // Matches Firebase requirements

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"  // Simplified from VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.gurkha_pasal"
        minSdk = 23  // Required by firebase-auth:23.2.0
        targetSdk = 34  // Matches compileSdk
        versionCode = flutter.versionCode  // Or set manually, e.g., 1
        versionName = flutter.versionName  // Or set manually, e.g., "1.0.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("debug")  // TODO: Update for release
        }
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.10.0"))
    implementation("com.google.firebase:firebase-analytics")  // For analytics
    implementation("com.google.firebase:firebase-auth")  // For LoginScreen/SignupScreen
}