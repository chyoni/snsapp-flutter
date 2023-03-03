import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/users/repositories/user_repository.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repositories/videos_repository.dart';

class UserLikeVideoViewModel extends AsyncNotifier<List<VideoModel>> {
  late final UserRepository _userRepository;
  late final VideosRepository _videosRepository;

  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _userRepository = ref.read(userRepo);
    _videosRepository = ref.read(videosRepo);

    _list = await getLikeVideos();
    return _list;
  }

  Future<List<VideoModel>> getLikeVideos() async {
    List<VideoModel> videos = [];
    final user = ref.read(authRepo).user;
    if (user == null) throw Error();

    final likeVideos = await _userRepository.getLikeVideos(user.uid);

    for (var doc in likeVideos.docs) {
      final videoId = doc.id.split("000").first.trim();
      final video = await _videosRepository.getVideo(videoId);
      if (video == null) throw Error();
      videos.add(VideoModel.fromJson(json: video, videoId: videoId));
    }
    return videos;
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 7));
    final updated = await getLikeVideos();

    _list = updated;
    state = AsyncValue.data(_list);
  }
}

final userLikeVideoProvider =
    AsyncNotifierProvider<UserLikeVideoViewModel, List<VideoModel>>(
  () => UserLikeVideoViewModel(),
);
