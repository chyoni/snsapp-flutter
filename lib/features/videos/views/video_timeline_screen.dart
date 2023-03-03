import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  final List<VideoModel>? videos;
  const VideoTimelineScreen({super.key, this.videos});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0;
  final PageController _pageController = PageController();
  final Duration _scrollDuration = const Duration(milliseconds: 300);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    // ! 현재 페이지가 마지막 페이지라면 다음 비디오를 firebase에서 패치
    if (page == _itemCount - 1) {
      if (widget.videos == null) {
        ref.watch(timelineProvider.notifier).fetchNextPage();
      }
    }
  }

  // void _onVideoFinished() {
  //   _pageController.nextPage(
  //     duration: _scrollDuration,
  //     curve: _scrollCurve,
  //   );
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videos == null) {
      // ! timelineProvider의 initialState를 가져오는 방식
      return ref.watch(timelineProvider).when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (error, stackTrace) => Center(
              child: Text("Could not load videos $error"),
            ),
            data: (videos) {
              _itemCount = videos.length;
              return RefreshIndicator(
                onRefresh: _onRefresh,
                displacement: 50,
                edgeOffset: 20,
                color: Theme.of(context).primaryColor,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: _onPageChanged,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final videoData = videos[index];
                    return VideoPost(
                      onVideoFinished: () {},
                      index: index,
                      video: videoData,
                    );
                  },
                ),
              );
            },
          );
    }
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: widget.videos!.length,
        itemBuilder: (context, index) {
          final videoData = widget.videos![index];
          return VideoPost(
            onVideoFinished: () {},
            index: index,
            video: videoData,
          );
        },
      ),
    );
  }
}
