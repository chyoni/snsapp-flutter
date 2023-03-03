import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String filename) async {
    // ! firebase에서 storage가 저장하는 방식을 avatars의 filename으로 하겠다는 의미
    final fileRef = _storage.ref().child("avatars/$filename");
    await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLikeVideos(String uid) async {
    final likeVideos =
        await _db.collection("users").doc(uid).collection("likes").get();
    return likeVideos;
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
