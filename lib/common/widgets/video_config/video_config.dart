import 'package:flutter/widgets.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMute = false;
  bool isAutoPlay = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}
