// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/views/chats_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';

class NotificationProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    if (user == null) return;
    await _db.collection("users").doc(user.uid).update({"token": token});
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    // ! Foreground (app이 켜져있을 때)
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("I just got a message, i am foreground.");
      print(event.notification?.title);
    });
    // ! Background (app이 안켜져 있고 background에 남아있을 때)
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      context.pushNamed(ChatScreen.routeName);
    });
    // ! Terminated (app이 background로도 안 남아 있고 아예 종료된 상태일 때)
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  @override
  FutureOr build(BuildContext arg) async {
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners(arg);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider =
    AsyncNotifierProvider.family<NotificationProvider, void, BuildContext>(
  () => NotificationProvider(),
);
