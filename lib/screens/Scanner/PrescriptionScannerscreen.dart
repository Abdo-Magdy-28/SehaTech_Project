import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/screens/Scanner/PrescriptionPreviewScreen.dart';
import 'package:image_picker/image_picker.dart';

class Prescriptionscannerscreen extends StatefulWidget {
  final CameraDescription camera;

  const Prescriptionscannerscreen({super.key, required this.camera});

  @override
  State<Prescriptionscannerscreen> createState() => _ScannerscreenState();
}

class _ScannerscreenState extends State<Prescriptionscannerscreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    await _initializeControllerFuture;

    final image = await _controller.takePicture();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrescriptionPreviewScreen(imageFile: File(image.path)),
      ),
    );
  }

  Future<void> pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              PrescriptionPreviewScreen(imageFile: File(picked.path)),
        ),
      );
    }
  }

  Widget _buildCameraPreview() {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final size = MediaQuery.of(context).size;

          return SizedBox(
            width: size.width,
            height: size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.previewSize!.height,
                height: _controller.value.previewSize!.width,
                child: CameraPreview(_controller),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final frameSize = size.shortestSide * 0.7;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Prescription Scanning",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SizedBox.expand(child: _buildCameraPreview()),

          Container(color: Colors.black.withOpacity(0.4)),

          Center(
            child: Container(
              width: frameSize,
              height: frameSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.white, size: 30),
                  onPressed: pickFromGallery,
                ),

                GestureDetector(
                  onTap: takePicture,
                  child: Container(
                    width: size.width * 0.18,
                    height: size.width * 0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                ),

                const SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
