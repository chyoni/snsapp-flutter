import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  late final CameraController _cameraController;

  Future<void> initCamera() async {
    // ! selfi mode랑 back mode 둘 다 말함
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController =
        CameraController(cameras[0], ResolutionPreset.ultraHigh);
    await _cameraController.initialize();
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDinied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDinied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDinied && !micDinied) {
      await initCamera();
      setState(() {
        _hasPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_hasPermission || !_cameraController.value.isInitialized
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Requesting permissions...",
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive()
                ],
              ),
            )
          : CameraPreview(_cameraController),
    );
  }
}
