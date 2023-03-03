// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repositories/videos_repository.dart';

// ! FamilyAsyncNotifier는 이 NotifierProvider에게 extra data를 던져줄 수 있게 해주는 Notifier다.
// ! 관리 대상 state는 void, 받는 인자의 타입은 String
class VideoPostViewModel extends FamilyAsyncNotifier<VideoModel, String> {
  late final VideosRepository _repository;
  late final _videoId;
  late VideoModel _video;

  Future<bool> fetchIsLiked() async {
    final user = ref.read(authRepo).user;
    if (user == null) {
      return false;
    }
    final result = await _repository.isLiked(_videoId, user.uid);
    return result;
  }

  Future<VideoModel> fetchVideo() async {
    final videoJson = await _repository.getVideo(_videoId);
    if (videoJson == null) throw Error();

    bool isLiked = await fetchIsLiked();
    final video = VideoModel.fromJson(
      json: videoJson,
      videoId: _videoId,
      isLiked: isLiked,
    );
    return video;
  }

  @override
  FutureOr<VideoModel> build(String arg) async {
    _videoId = arg;
    _repository = ref.read(videosRepo);

    _video = await fetchVideo();
    return _video;
  }

  Future<void> toggleVideo() async {
    final user = ref.read(authRepo).user;
    if (user == null) return;
    await _repository.toggleVideo(_videoId, user.uid);

    final currentState = state.value;
    if (currentState == null) return;

    final currentIsLiked = currentState.isLiked;
    final newState;
    if (currentIsLiked) {
      newState = currentState.copyWith(
        isLiked: !currentIsLiked,
        likes: currentState.likes - 1,
      );
    } else {
      newState = currentState.copyWith(
        isLiked: !currentIsLiked,
        likes: currentState.likes + 1,
      );
    }
    _video = newState;
    state = AsyncValue.data(_video);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, VideoModel, String>(
  () => VideoPostViewModel(),
);
