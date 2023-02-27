import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  Future<void> uploadVideo() async {
    // ! 이 provider에게 현재 로딩중이다를 알려주는 statement
    // ! 그래서 watch(timelineProvider).isLoading을 호출하면 true를 리턴하게 된다.
    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 1));

    _list = [..._list];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
