import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/repo/playback_config_repo.dart';

// ! MVVM 구조의 유저와 모델 간 인터페이스 역할을 하는 중간 다리
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    // ! 디스크에 데이터를 저장
    _repository.setMuted(value);
    // ! 현재 View의 모델의 데이터를 적용
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    // ! 디스크에 데이터를 저장
    _repository.setAutoplay(value);
    // ! 현재 View의 모델의 데이터를 적용
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.getMuted(),
      autoplay: _repository.getAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  // ! 잠깐만 이렇게 해놓을거야
  () => throw UnimplementedError(),
);
