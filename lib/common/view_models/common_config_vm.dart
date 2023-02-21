import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/common/models/common_config_model.dart';
import 'package:tiktok/common/repo/common_config_repo.dart';

class CommonConfigViewModel extends Notifier<CommonConfigModel> {
  final CommonConfigRepository _repository;

  CommonConfigViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = CommonConfigModel(darkMode: value);
  }

  @override
  CommonConfigModel build() {
    return CommonConfigModel(
      darkMode: _repository.getDarkMode(),
    );
  }
}

final commonConfigProvider =
    NotifierProvider<CommonConfigViewModel, CommonConfigModel>(
  // ! 잠깐만 이렇게 해놓을거야
  () => throw UnimplementedError(),
);
