import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/widgets/video_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final void Function() onVideoFinished;
  final int index;
  final String description =
      "#chyonee #tiktok #clonecoding #flutter #flutterisawesome #iwanttobecomeflutterdeveloper";

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // ! VideoPlayer의 실행 비디오를 설정
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  late final AnimationController _animationController;
  bool _isPaused = false;
  bool _isAllDesc = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);

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
    await _videoPlayerController.setLooping(true);
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    // ! value는 기본값, lowerBound와 upperBound는 하단값 / 상단값
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // ! 플레이 중 스탑을 하면 애니메이션 컨트롤러가 upperBound -> lowerBound로 value를 변경하는 statement
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      // ! 스탑 중 플레이를 하면 애니메이션 컨트롤러가 lowerBound -> upperBound로 value를 변경하는 statement
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _seeAllDescriptionTap() {
    setState(() {
      _isAllDesc = !_isAllDesc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "@chyonee",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Gaps.h5,
                    FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size16,
                      color: Colors.teal.shade200,
                    ),
                  ],
                ),
                Gaps.v10,
                Container(
                  width: MediaQuery.of(context).size.width - 160,
                  decoration: const BoxDecoration(),
                  child: widget.description.length > 25 && !_isAllDesc
                      ? Row(
                          children: [
                            Text(
                              widget.description.substring(0, 10),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gaps.h10,
                            const FaIcon(
                              FontAwesomeIcons.ellipsis,
                              color: Colors.white,
                              size: Sizes.size12,
                            ),
                            Gaps.h10,
                            GestureDetector(
                              onTap: _seeAllDescriptionTap,
                              child: const Text(
                                "See more",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          ],
                        )
                      : Text(
                          widget.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fichef.bbci.co.uk%2Fnews%2F640%2Fcpsprodpb%2F7036%2Fproduction%2F_111162782__313.jpg&f=1&nofb=1&ipt=19a400e48009148eee6558a4fa3c6b795dd962030b00bd5be0f646d4d5465fa1&ipo=images"),
                  child: Text("백예린"),
                ),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.solidHeart, text: "2.9M"),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.solidComment, text: "33K"),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.share, text: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
