import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/users/repositories/user_repository.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repositories/videos_repository.dart';

class UserVideosViewModel extends AsyncNotifier<List<VideoModel>> {
  late final UserRepository _userRepository;
  late final VideosRepository _videosRepository;
  List<VideoModel> videos = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _userRepository = ref.read(userRepo);
    _videosRepository = ref.read(videosRepo);

    videos = await fetchUserVideos();
    return videos;
  }

  Future<List<VideoModel>> fetchUserVideos() async {
    final user = ref.read(authRepo).user;
    if (user == null) throw FlutterError("current user is null");
    List<VideoModel> results = [];
    final videos = await _userRepository.getUserVideos(user.uid);

    for (var doc in videos.docs) {
      final videoId = doc.data()["videoId"];
      if (videoId == null) throw FlutterError("doc video id is null");
      final video = await _videosRepository.getVideo(videoId);
      if (video == null) throw FlutterError("video from firebase was null");
      results.add(VideoModel.fromJson(json: video, videoId: videoId));
    }
    return results;
  }
}

final userVideosProvider =
    AsyncNotifierProvider<UserVideosViewModel, List<VideoModel>>(
  () => UserVideosViewModel(),
);
