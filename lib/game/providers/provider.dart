import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  int _num = 7;
  double _x1 = 0;
  double _x2 = 0;
  double _speed = 0.1;
  Vector2 _targetPos = Vector2(0, 0);
  double _distanceToPos = 0;
  double _y1 = 0;
  double _y2 = 0;
  double _sinus = 0;
  double _cosinus = 0;

  double get x1 => _x1;
  double get x2 => _x2;
  double get speed => _speed;
  Vector2 get targetPos => _targetPos;
  double get distanceToPos => _distanceToPos;
  double get y1 => _y1;
  double get y2 => _y2;
  double get sinus => _sinus;
  double get cosinus => _cosinus;
  int get num => _num;

  void increment(int a) {
    _num += a;
    notifyListeners();
  }

  void tapDown(info, playerComponent, tapComponent) {
    _x1 = playerComponent.position.x + playerComponent.size.x / 2;
    _y1 = playerComponent.position.y + playerComponent.size.y / 2;
    _x2 = info.eventPosition.game.x;
    _y2 = info.eventPosition.game.y;

    var playerPos = Vector2(_x1, _y1);
    var targetPos = Vector2(_x2, _y2);

    var angle = atan2(targetPos.y - playerPos.y, targetPos.x - playerPos.x);

    var per_Frame_Distance = 2;
    _sinus = sin(angle) * per_Frame_Distance;
    _cosinus = cos(angle) * per_Frame_Distance;

    tapComponent.position = Vector2(x2, y2);
    tapComponent.size = Vector2.all(30);
    Future.delayed(const Duration(milliseconds: 200), () {})
        .then((value) => tapComponent.size = Vector2.all(0));

    notifyListeners();
  }

  void playerGoToTap(_playerComponent) {
    _x1 = _playerComponent.position.x + _playerComponent.size.x / 2;
    _y1 = _playerComponent.position.y + _playerComponent.size.y / 2;
    _distanceToPos = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    if (_distanceToPos > 10) {
      _playerComponent.position.x += _cosinus;
      _playerComponent.position.y += _sinus;
    }
    notifyListeners();
  }
}
