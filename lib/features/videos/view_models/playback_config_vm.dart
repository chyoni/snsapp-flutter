import 'package:flutter/material.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/repo/playback_config_repo.dart';

// ! MVVM 구조의 유저와 모델 간 인터페이스 역할을 하는 중간 다리
class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.getMuted(),
    autoplay: _repository.getAutoplay(),
  );

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted;

  bool get autoplay => _model.autoplay;

  void setMuted(bool value) {
    // ! 디스크에 데이터를 저장
    _repository.setMuted(value);
    // ! 현재 View의 모델의 데이터를 적용
    _model.muted = value;
    // ! Listener에게 알림 (rebuild)
    notifyListeners();
  }

  void setAutoplay(bool value) {
    // ! 디스크에 데이터를 저장
    _repository.setAutoplay(value);
    // ! 현재 View의 모델의 데이터를 적용
    _model.autoplay = value;
    // ! Listener에게 알림 (rebuild)
    notifyListeners();
  }
}
