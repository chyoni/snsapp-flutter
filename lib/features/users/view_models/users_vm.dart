import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) throw Exception("account not created");

    state = AsyncValue.data(
      UserProfileModel(
        bio: "undefined",
        link: "undefined",
        email: credential.user!.email ?? "anonymous@noreply.com",
        name: credential.user!.displayName ?? "Anonymous",
        uid: credential.user!.uid,
      ),
    );
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UserViewModel(),
);
