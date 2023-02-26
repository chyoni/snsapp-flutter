import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:tiktok/features/users/repositories/user_repository.dart';
import 'package:tiktok/utils.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    await Future.delayed(const Duration(seconds: 2));
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        // ! build method에서 이렇게 인스턴스를 return하면 어디선가 ref.read(usersProvider)로 호출해서 data를 가져올 수 있다.
        // ! 그 데이터 타입은 UserProfileModel이 되는거고
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) throw Exception("account not created");

    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anonymous@noreply.com",
      name: form["username"],
      uid: credential.user!.uid,
      birthday: form["birthday"],
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> updateProfile(
      String username, String bio, String link, BuildContext context) async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(
      state.value!.copyWith(name: username, bio: bio, link: link),
    );
    await _userRepository.updateUser(
      state.value!.uid,
      {"name": username, "bio": bio, "link": link},
    );

    if (state.hasError) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, state.error);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Update successfully !"),
        ),
      );
    }
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

final usersProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
