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
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  late FlashMode _flashMode;

  Future<void> initCamera() async {
    // ! selfi mode랑 back mode 둘 다 말함
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);
    await _cameraController.initialize();

    _flashMode = _cameraController.value.flashMode;
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

  void _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
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
          : Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                CameraPreview(_cameraController),
                Positioned(
                  top: 60,
                  right: 10,
                  child: Column(
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.cameraswitch),
                        onPressed: () => _toggleSelfieMode(),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.off
                            ? Colors.amber.shade200
                            : Colors.white,
                        icon: const Icon(Icons.flash_off_rounded),
                        onPressed: () => _setFlashMode(FlashMode.off),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.always
                            ? Colors.amber.shade200
                            : Colors.white,
                        icon: const Icon(Icons.flash_on_rounded),
                        onPressed: () => _setFlashMode(FlashMode.always),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.auto
                            ? Colors.amber.shade200
                            : Colors.white,
                        icon: const Icon(Icons.flash_auto_rounded),
                        onPressed: () => _setFlashMode(FlashMode.auto),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.torch
                            ? Colors.amber.shade200
                            : Colors.white,
                        icon: const Icon(Icons.flashlight_on_sharp),
                        onPressed: () => _setFlashMode(FlashMode.torch),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
