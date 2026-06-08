import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Prescription%20Scan/precriptionscan_cubit.dart';
import 'package:grad_project/screens/Scanner/PrescriptionPreviewScreen.dart';
import 'package:grad_project/services/prescriptionscan_service.dart';
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
  bool _isFlashOn = false;

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

  Future<void> _toggleFlash() async {
    try {
      await _initializeControllerFuture;
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await _controller.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    } catch (e) {
      debugPrint('Flash toggle error: $e');
    }
  }

  Future<void> takePicture() async {
    await _initializeControllerFuture;

    if (_isFlashOn) {
      await _controller.setFlashMode(FlashMode.off);
    }

    final image = await _controller.takePicture();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => PrescriptionCubit(
            PrescriptionService(
              Dio(
                BaseOptions(
                  baseUrl:
                      "https://8080-dep-01kp3cxxfzs0chgwd41w54zmem-d.cloudspaces.litng.ai",
                ),
              ),
            ),
          ),
          child: PrescriptionPreviewScreen(imageFile: File(image.path)),
        ),
      ),
    );
  }

  Future<void> pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PrescriptionCubit(
              PrescriptionService(
                Dio(
                  BaseOptions(
                    baseUrl:
                        "https://8080-dep-01kp3cxxfzs0chgwd41w54zmem-d.cloudspaces.litng.ai",
                  ),
                ),
              ),
            ),
            child: PrescriptionPreviewScreen(imageFile: File(picked.path)),
          ),
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
    final sw = size.width;
    final sh = size.height;
    final frameSize = size.shortestSide * 0.7;

    // All sizes derived from screen width — fully responsive
    final flashBtnSize = sw * 0.11;
    final flashIconSize = sw * 0.06;
    final shutterSize = sw * 0.18;
    final galleryIconSize = sw * 0.075;
    final bottomPadding = MediaQuery.of(context).padding.bottom + sh * 0.025;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Prescription Scanning",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: sw * 0.045,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white, size: sw * 0.06),
      ),
      body: Stack(
        children: [
          SizedBox.expand(child: _buildCameraPreview()),

          Container(color: Colors.black.withOpacity(0.4)),

          // Scan frame
          Center(
            child: Container(
              width: frameSize,
              height: frameSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: sw * 0.007),
                borderRadius: BorderRadius.circular(sw * 0.04),
              ),
            ),
          ),

          // Hint text below frame

          // Bottom controls
          Positioned(
            bottom: bottomPadding,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gallery
                GestureDetector(
                  onTap: pickFromGallery,
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: galleryIconSize,
                  ),
                ),

                // Shutter
                GestureDetector(
                  onTap: takePicture,
                  child: Container(
                    width: shutterSize,
                    height: shutterSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: sw * 0.01),
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                ),

                // Flash toggle
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Container(
                    width: flashBtnSize,
                    height: flashBtnSize,
                    decoration: BoxDecoration(
                      color: _isFlashOn
                          ? Colors.yellow.withOpacity(0.25)
                          : Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isFlashOn
                            ? Colors.yellow
                            : Colors.white.withOpacity(0.5),
                        width: sw * 0.004,
                      ),
                    ),
                    child: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: _isFlashOn ? Colors.yellow : Colors.white,
                      size: flashIconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
