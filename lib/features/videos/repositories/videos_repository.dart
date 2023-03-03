import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
          "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
        );
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel video) async {
    // ! firebase의 firestore에 id는 만들어질 때 해시값 같이 생긴 unique ID가 알아서 생김
    await _db.collection("videos").add(video.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos({
    int? lastItemCreatedAt,
  }) {
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);

    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      // ! startAfter는 orderBy에 따라 그 orderBy에 대해서 주어진 조건에 의해 query를 가져온다.
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> toggleVideo(String videoId, String userId) async {
    final query = _db.collection("likes").doc("${videoId}000$userId");
    final like = await query.get();

    if (!like.exists) {
      await query.set({
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
    } else {
      await query.delete();
    }
  }

  Future<bool> isLiked(String videoId, String userId) async {
    final query = _db.collection("likes").doc("${videoId}000$userId");
    final like = await query.get();

    if (like.exists) return true;
    return false;
  }

  Future<Map<String, dynamic>?> getVideo(String videoId) async {
    final video = await _db.collection("videos").doc(videoId).get();
    return video.data();
  }
}

final videosRepo = Provider(
  (ref) => VideosRepository(),
);
