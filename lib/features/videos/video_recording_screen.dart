import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routePath = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  late final AnimationController _recordButtonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_recordButtonAnimationController);

  late FlashMode _flashMode;
  late double maxZoom, minZoom;
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  Future<void> initCamera() async {
    // ! selfi mode랑 back mode 둘 다 말함
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    // ! enableAudio를 false로 한 건 Android Emulator에서 자동 재생이 정상적이지 않기 때문 이거는 실제 핸드폰에서는 상관없고 에뮬레이터로 할 때만 이렇게 !
    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh,
        enableAudio: false);
    await _cameraController.initialize();
    // ! Only iOS
    await _cameraController.prepareForVideoRecording();

    maxZoom = await _cameraController.getMaxZoomLevel();
    minZoom = await _cameraController.getMinZoomLevel();
    _flashMode = _cameraController.value.flashMode;
    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    final mediaPermission = await Permission.mediaLibrary.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    final mediaDenied =
        mediaPermission.isDenied || mediaPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied && !mediaDenied) {
      await initCamera();
      setState(() {
        _hasPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    // ! CircularProgressIndicator에 걸은 Animation을 실행하기 위해 listener를 걸고 그 안에 setState를 실행
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    // ! addStatusListener는 만약에 Animation을 걸었을 경우에 Animation이 끝난 상태인지 아닌지 판단이 가능하게 된다.
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onStopRecording();
      }
    });
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

  Future<void> _onStartRecording() async {
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();

    _recordButtonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _onStopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _recordButtonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isFromGallery: false,
        ),
      ),
    );
  }

  Future<void> _onPanUpdated(LongPressMoveUpdateDetails details) async {
    double dy = details.localOffsetFromOrigin.dy;

    if (dy < 0 && dy < -maxZoom) await _cameraController.setZoomLevel(maxZoom);
    if (dy < 0 && dy > -maxZoom) await _cameraController.setZoomLevel(dy * -1);
    if (dy > 0) await _cameraController.setZoomLevel(minZoom);
    // if (details.delta.dy < 0) {
    //   if ((details.delta.dy * 10) * -1 > 10) {
    //     await _cameraController.setZoomLevel(10);
    //   }
    //   await _cameraController.setZoomLevel((details.delta.dy * 10) * -1);
    // }
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isFromGallery: true,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermission || _noCamera) return;

    if (state == AppLifecycleState.inactive &&
        _cameraController.value.isInitialized) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _recordButtonAnimationController.dispose();
    _recordButtonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_hasPermission
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
                if (!_noCamera && _cameraController.value.isInitialized)
                  CameraPreview(_cameraController),
                if (!_noCamera)
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
                          icon: const Icon(Icons.flash_auto),
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
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 30,
                  child: Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onLongPressStart: (details) => _onStartRecording(),
                        onLongPressEnd: (details) => _onStopRecording(),
                        onLongPressMoveUpdate: (details) =>
                            _onPanUpdated(details),
                        // onPanUpdate: (details) => _onPanUpdated(details),
                        child: ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: Sizes.size64,
                                height: Sizes.size64,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                  value: _progressAnimationController.value,
                                ),
                              ),
                              Container(
                                width: Sizes.size56,
                                height: Sizes.size56,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: _onPickVideoPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.image,
                              color: Colors.white,
                            ),
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
