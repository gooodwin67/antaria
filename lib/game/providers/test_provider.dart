import 'package:flutter/cupertino.dart';

class TestProvider extends ChangeNotifier {
  String testText = 'text';

  void updateText(text) {
    testText = text;
    notifyListeners();
  }
}
