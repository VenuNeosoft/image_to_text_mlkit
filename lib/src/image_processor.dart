import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageToTextMLKit {
  final ImagePicker _picker = ImagePicker();

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
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);
      textRecognizer.close();
      return recognizedText.text;
    } catch (e) {
      textRecognizer.close();
      return 'Error processing image: $e';
    }
  }

  /// Download image from URL and save to a temporary file
  /// Download image from URL and save to a temporary file
  Future<File?> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      // Check if response is successful
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/temp_image.jpg';
        final file = File(filePath);

        // Write image data to file
        await file.writeAsBytes(response.bodyBytes);

        // Check if the file is properly saved
        if (await file.exists()) {
          return file;
        } else {
          print('Error: File not created properly.');
          return null;
        }
      } else {
        print('Error: Failed to load image. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

}
