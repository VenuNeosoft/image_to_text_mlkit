import 'package:flutter/material.dart';
import 'package:image_to_text_mlkit/image_to_text_mlkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image to Text Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ImageToTextMLKit _imageToTextMLKit = ImageToTextMLKit();
  String _extractedText = 'No text extracted yet';
  final TextEditingController _urlController = TextEditingController();

  /// Pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    String? text = await _imageToTextMLKit.pickImageFromGallery();
    setState(() {
      _extractedText = text ?? 'No text found';
    });
  }

  /// Capture an image from the camera
  Future<void> _pickImageFromCamera() async {
    String? text = await _imageToTextMLKit.pickImageFromCamera();
    setState(() {
      _extractedText = text ?? 'No text found';
    });
  }

  /// Process an image from a URL
  Future<void> _processImageFromUrl() async {
    if (_urlController.text.isEmpty) {
      setState(() {
        _extractedText = 'Please enter a valid URL.';
      });
      return;
    }

    String? text = await _imageToTextMLKit.processImageFromUrl(
      _urlController.text,
    );
    setState(() {
      _extractedText = text ?? 'No text found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Image to Text ML Kit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: const Text('Pick Image from Gallery'),
              ),
              ElevatedButton(
                onPressed: _pickImageFromCamera,
                child: const Text('Pick Image from Camera'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Enter Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _processImageFromUrl,
                child: const Text('Process Image from URL'),
              ),
              const SizedBox(height: 20),
              Text(_extractedText, textAlign: TextAlign.left),
            ],
          ),
        ),
      ),
    );
  }
}
