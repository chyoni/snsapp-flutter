import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/view_models/playback_config_view_model.dart';
import 'package:tiktok/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok/features/videos/views/widgets/video_button.dart';
import 'package:tiktok/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ! Riverpod의 Provider로 제공하는 state뿐 아니라 그냥 이 클래스에서 State가 필요할 땐 ConsumerStatefulWidget으로 상속받으면 된다.
// ! 그럼 이 ConsumerStatefulWidget은 build method에서 WidgetRef를 받지 않는데 얘는 어디서나 ref를 사용할 수 있다.
class VideoPost extends ConsumerStatefulWidget {
  final VideoModel video;
  final void Function() onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.video,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  // ! VideoPlayer의 실행 비디오를 설정
  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;
  late bool _isPaused;
  late int _likeCount;
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
    _videoPlayerController =
        VideoPlayerController.network(widget.video.fileUrl);
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    // ! 만약, Web이라면 소리를 0으로 한 상태로 autoplay를 하겠다는 의미
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    if (!mounted) return;
    _videoPlayerController
        .setVolume(ref.read(playbackConfigProvider).muted ? 0 : 1);
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _onVolumeHighTap(BuildContext context) async {
    if (!ref.read(playbackConfigProvider).muted) return;
    await _videoPlayerController.setVolume(1);

    if (!mounted) return;
    ref.read(playbackConfigProvider.notifier).setMuted(false);
  }

  void _onVolumeMuteTap(BuildContext context) async {
    if (ref.read(playbackConfigProvider).muted) return;
    await _videoPlayerController.setVolume(0);

    if (!mounted) return;
    ref.read(playbackConfigProvider.notifier).setMuted(true);
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
    _isPaused = ref.read(playbackConfigProvider).autoplay ? false : true;
    _likeCount = widget.video.likes;
    // videoConfig.addListener(() {
    //   setState(() {
    //     _isMuted = videoConfig.autoMute;
    //   });
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // ! mounted가 아닌 상태에서는 그냥 return
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying &&
        ref.read(playbackConfigProvider).autoplay) {
      _videoPlayerController.play();
    }
    // ! Home에서 다른 탭으로 이동했을 때 재생중인 비디오는 꺼져야하므로
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // ! 플레이 중 스탑을 하면 애니메이션 컨트롤러가 upperBound -> lowerBound로 value를 변경하는 statement
      _animationController.reverse();
    } else {
      _videoPlayerController
          .setVolume(ref.read(playbackConfigProvider).muted ? 0 : 1);
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

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    // ! flutter에서 제공하는 바텀 모달 시트
    // ! 이 showModalBottomSheet은 Future 타입이고 그 이유는 얘가 실행되면 얘가 다시 닫힐때까지 이 밑에 코드가 실행되지 않는다.
    await showModalBottomSheet(
      context: context,
      // ! 얘는 만약 이 모달 바텀 시트안에서 스크롤뷰를 사용할 때 그녀석의 크기를 조절하고 싶으면 이 값을 true로 준다.
      isScrollControlled: true,
      // ! 이 backgroundColor를 transparent로 해주지 않으면 borderRadius를 주어도 radius가 안 먹네 ?
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  void _onLikeTap() {
    final currentLiked =
        ref.watch(videoPostProvider(widget.video.id).notifier).isLiked;
    ref.read(videoPostProvider(widget.video.id).notifier).toggleVideo();
    print(currentLiked);
    if (currentLiked) {
      _likeCount = _likeCount - 1;
    } else {
      _likeCount = _likeCount + 1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(videoPostProvider(widget.video.id)).when(
        error: (error, stackTrace) => Center(
              child: Text("error occured -> $error"),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        data: (isLiked) => VisibilityDetector(
              key: Key("${widget.index}"),
              onVisibilityChanged: _onVisibilityChanged,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _videoPlayerController.value.isInitialized
                        ? VideoPlayer(_videoPlayerController)
                        : Image.network(
                            widget.video.thumbnailUrl,
                            fit: BoxFit.cover,
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
                            Text(
                              "@${widget.video.creator}",
                              style: const TextStyle(
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
                          child: widget.video.description.length > 25 &&
                                  !_isAllDesc
                              ? Row(
                                  children: [
                                    Text(
                                      widget.video.description.substring(0, 10),
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
                                  widget.video.description,
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
                      children: [
                        !ref.watch(playbackConfigProvider).muted
                            ? GestureDetector(
                                onTap: () => _onVolumeMuteTap(context),
                                child: const VideoButton(
                                    icon: FontAwesomeIcons.volumeHigh,
                                    text: ""),
                              )
                            : GestureDetector(
                                onTap: () => _onVolumeHighTap(context),
                                child: const VideoButton(
                                    icon: FontAwesomeIcons.volumeXmark,
                                    text: ""),
                              ),
                        Gaps.v10,
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          foregroundImage: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/chiwon99881tiktok.appspot.com/o/avatars%2F${widget.video.creatorUid}?alt=media",
                          ),
                          child: Text(widget.video.creator),
                        ),
                        Gaps.v20,
                        GestureDetector(
                          onTap: _onLikeTap,
                          child: VideoButton(
                              icon: FontAwesomeIcons.solidHeart,
                              text: S.of(context).likeCount(_likeCount),
                              isLiked: isLiked),
                        ),
                        Gaps.v20,
                        GestureDetector(
                          onTap: () => _onCommentsTap(context),
                          child: VideoButton(
                              icon: FontAwesomeIcons.solidComment,
                              text: S
                                  .of(context)
                                  .commentCount(widget.video.comments)),
                        ),
                        Gaps.v20,
                        const VideoButton(
                            icon: FontAwesomeIcons.share, text: "Share"),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
