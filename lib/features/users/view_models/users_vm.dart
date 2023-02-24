import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:tiktok/features/users/repo/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) throw Exception("account not created");

    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anonymous@noreply.com",
      name: credential.user!.displayName ?? "Anonymous",
      uid: credential.user!.uid,
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
