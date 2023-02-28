// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/videos/repositories/videos_repository.dart';

// ! FamilyAsyncNotifier는 이 NotifierProvider에게 extra data를 던져줄 수 있게 해주는 Notifier다.
// ! 관리 대상 state는 void, 받는 인자의 타입은 String
class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideosRepository _repository;
  late final _videoId;
  bool isLiked = false;

  bool? get getIsLiked => state.value;

  @override
  FutureOr<bool> build(String arg) async {
    _videoId = arg;
    _repository = ref.read(videosRepo);

    final user = ref.read(authRepo).user;
    if (user == null) {
      isLiked = false;
      return isLiked;
    }
    isLiked = await _repository.isLiked(_videoId, user.uid);
    return isLiked;
  }

  Future<void> toggleVideo() async {
    final user = ref.read(authRepo).user;
    if (user == null) return;
    await _repository.toggleVideo(_videoId, user.uid);

    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncValue.data(!currentState);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
  () => VideoPostViewModel(),
);
