import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final void Function() onVideoFinished;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  // ! VideoPlayer의 실행 비디오를 설정
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");

  // ! 비디오 컨트롤러의 비디오 전체 길이가 현재 사용자의 비디오 실행기간이 같다 즉, 비디오가 다 끝났다면 props로 받은 onVideoFinished()를 실행
  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  // ! 비디오 컨트롤러를 초기화하고, 초기화가 끝나면 바로 자동재생을 실행하는 코드, 그리고 이벤트 리스너를 초기화
  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
