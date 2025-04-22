Here’s the complete and polished README.md:


# 📸 Image to Text MLKit

A Flutter package that converts images to text using Google ML Kit. It supports extracting text from:

✅ Camera  
✅ Gallery  
✅ Network URLs
---

### 📷 Extracting Text from Camera:

<table>

  <tr>
    <td><img src="https://raw.githubusercontent.com/VenuNeosoft/image_to_text_mlkit/main/camera.gif" width=270 height=560></td>
    <td><img src="https://raw.githubusercontent.com/VenuNeosoft/image_to_text_mlkit/main/gallery.gif" width=270 height=560></td>
    <td><img src="https://raw.githubusercontent.com/VenuNeosoft/image_to_text_mlkit/main/networkUrl.gif" width=270 height=560></td>

  </tr>
 </table>




## 🚀 Getting Started

### 1. **Add Dependency**
Add the following to your `pubspec.yaml`:
``` yaml
dependencies:
  image_to_text_mlkit: ^1.0.6
  ```
2. Install Package
Run the following command:

flutter pub get

3. Import the Package
``` package
import 'package:image_to_text_mlkit/image_to_text_mlkit.dart';
```

📖 Usage
🖼️ Pick Image from Gallery
``` example gallery image to text
final imageToText = ImageToTextMLKit();
String? text = await imageToText.pickImageFromGallery();
print(text);
```


📸 Capture Image from Camera
``` example camera image to text
String? textFromCamera = await imageToText.pickImageFromCamera();
print(textFromCamera);
```

🌐 Process Image from URL
``` example network url image to text
String url = 'https://example.com/sample-image.jpg';
String? textFromUrl = await imageToText.processNetworkImage(url);
print(textFromUrl);
```


⚙️ Permissions
🟢 Android Permissions

Add the following permissions in android/app/src/main/AndroidManifest.xml:

``` xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<application
    android:requestLegacyExternalStorage="true"
    android:networkSecurityConfig="@xml/network_security_config"
    ...
 ```
    
Add the following permissions in  /android/app/src/main/res/xml/network_security_config.xml
if you dont have create one file and add below code in xml/network_security_config.xml

``` network_security_config.xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">images.template.net</domain>
    </domain-config>
</network-security-config>
```

Add the following permissions in android/app/build.gradle:

``` xml
android {
    compileSdkVersion 34 // Or latest
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```
🍎 iOS Permissions

Add the following keys to your ios/Runner/Info.plist file:

``` plist
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture and process images.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select and process images.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need access to save processed images to your library.</string>

```

# 📸 Developed by
✅ VENU RENANGI  
✅ SONAM GUPTA
✅ KAMNA JOSHI
