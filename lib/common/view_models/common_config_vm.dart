import 'package:flutter/material.dart';
import 'package:tiktok/common/models/common_config_model.dart';
import 'package:tiktok/common/repo/common_config_repo.dart';

class CommonConfigViewModel extends ChangeNotifier {
  final CommonConfigRepository _repository;

  late final CommonConfigModel _model = CommonConfigModel(
    darkMode: _repository.getDarkMode(),
  );

  CommonConfigViewModel(this._repository);

  bool get darkMode => _model.darkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.darkMode = value;
    notifyListeners();
  }
}
