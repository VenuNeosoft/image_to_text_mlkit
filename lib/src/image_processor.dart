import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageToTextMLKit {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();

  /// Pick image from gallery and convert to text
  Future<String?> pickImageFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return _processImageFromFile(image?.path);
  }

  /// Pick image from camera and convert to text
  Future<String?> pickImageFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return _processImageFromFile(image?.path);
  }

  /// Pick image from a URL and convert to text
  Future<String?> processImageFromUrl(String imageUrl) async {
    try {
      final File? imageFile = await _downloadImage(imageUrl);
      if (imageFile == null) {
        return 'Failed to load image from URL';
      }
      return _processImageFromFile(imageFile.path);
    } catch (e) {
      return 'Error processing image: $e';
    }
  }

  /// Process image from file path and extract text
  Future<String?> _processImageFromFile(String? imagePath) async {
    if (imagePath == null) return null;

    final inputImage = InputImage.fromFilePath(imagePath);
    try {
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      return 'Error processing image: $e';
    }
  }

  /// Download image from URL and save to a temporary file
  Future<File?> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/temp_image.jpg';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return file.existsSync() ? file : null;
      } else {
        if (kDebugMode) {
          print('Failed to download image. Status: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading image: $e');
      }
      return null;
    }
  }

  /// Call this when done using the class to release resources
  void dispose() {
    _textRecognizer.close();
  }
}
