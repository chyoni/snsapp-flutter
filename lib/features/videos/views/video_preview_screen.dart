import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/views/video_meta_screen.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  // ! 얘는 비디오를 방금 만든게 아니고, 내 갤러리에서 가져온 비디오일 때 true가 된다. (저장 버튼을 안보이게해서 또 저장하지 않기 위해)
  final bool isFromGallery;
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isFromGallery,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _onSaveToGallery() async {
    if (_savedVideo) return;

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: "TikTokClone",
    );
    _savedVideo = true;
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    _videoPlayerController.pause();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoMetaScreen(video: widget.video),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview Video"),
        actions: [
          if (!widget.isFromGallery)
            IconButton(
              onPressed: _onSaveToGallery,
              icon: _savedVideo
                  ? const FaIcon(FontAwesomeIcons.check)
                  : const FaIcon(FontAwesomeIcons.download),
            ),
          TextButton(
            onPressed: _onNextPressed,
            child: const Text(
              "Next",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
