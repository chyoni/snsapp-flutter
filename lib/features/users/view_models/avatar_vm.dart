import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repo/authentication_repo.dart';
import 'package:tiktok/features/users/repo/user_repo.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final filename = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async => await _repository.uploadAvatar(file, filename),
    );
  }
}
