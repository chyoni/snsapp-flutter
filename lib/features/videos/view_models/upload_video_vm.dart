import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repo/authentication_repo.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repo/videos_repo.dart';
import 'package:tiktok/utils.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (user == null) return;
    if (userProfile == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(video, user.uid);
      if (task.metadata != null) {
        await _repository.saveVideo(
          VideoModel(
            title: "Code Challenge",
            description: "Code Challenge",
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: "",
            creatorUid: user.uid,
            creator: userProfile.name,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }
    });

    if (state.hasError) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, state.error);
    } else {
      // ignore: use_build_context_synchronously
      context.pushReplacement("/home");
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
