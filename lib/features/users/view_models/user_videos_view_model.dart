import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/users/repositories/user_repository.dart';
import 'package:tiktok/features/videos/repositories/videos_repository.dart';

class UserVideosViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;
  late final VideosRepository _videosRepository;

  @override
  FutureOr<void> build() {
    _userRepository = ref.read(userRepo);
    _videosRepository = ref.read(videosRepo);
  }

  fetchUserVideos() async {
    final user = ref.read(authRepo).user;
    if (user == null) throw Error();
    final videos = await _userRepository.getUserVideos(user.uid);

    for (var doc in videos.docs) {
      final videoId = doc.data()["videoId"];
      if (videoId == null) throw Error();
      // TODO: videoId로 video 가져오기
    }
  }
}

final userVideosProvider = AsyncNotifierProvider<UserVideosViewModel, void>(
  () => UserVideosViewModel(),
);
