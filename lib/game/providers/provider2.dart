import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Pos extends SpriteComponent with HasGameRef {
  Pos() : super();
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}

class PlayerProvider2 with ChangeNotifier {
  final mark = RectangleComponent(
    size: Vector2(50, 50),
    position: Vector2(100, 200),
    paint: BasicPalette.red.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2,
  );
  List marks = [];

  Vector2 _playerSpeed = Vector2(0, 0);

  final Vector2 _playerPos = Vector2(3 * 50, 3 * 50);
  final Vector2 _targetPos = Vector2(3, 3);
  bool isPlayerRun = false;
  bool _isPlayerRunVert = false;
  bool _isPlayerRunHor = false;

  Vector2 get playerSpeed => _playerSpeed;
  Vector2 get playerPos => _playerPos;

  void findPath(info, player, myMap, mySizeTile) {
    // List map = myMap;
    // int sizeTile = mySizeTile;
    // for (int i = 0; i < map.length; i++) {
    //   for (int j = 0; j < map[i].length; j++) {

    //   }
    // }
  }

  addMark(info, myMap, mySizeTile) {
    marks.clear();
    List map = myMap;
    int sizeTile = mySizeTile;
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (info.eventPosition.game.x < j * 50 &&
            info.eventPosition.game.y < i * 50) {
          mark.position.x = (j - 1) * 50;
          mark.position.y = (i - 1) * 50;
          for (int k = i; k > _playerPos.y / 50 + 1; k--) {
            marks.add(mark);
          }
          print(marks.length);
          return marks;
        }
      }
    }

    return mark;
  }

  void playerStartRun(info, player, myMap, mySizeTile) {
    List map = myMap;
    int sizeTile = mySizeTile;
    isPlayerRun = false;

    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (info.eventPosition.game.x < j * 50 &&
            info.eventPosition.game.y < i * 50) {
          _playerPos.x = player.position.x;
          _playerPos.y = player.position.y;
          _targetPos.x = (j - 1) * 50;
          _targetPos.y = (i - 1) * 50;
          isPlayerRun = true;
          return;
        }
      }
    }
  }

  void tapDown(info, playerComponent, tapComponent) {
    notifyListeners();
  }

  void playerMove(_playerComponent) {
    if (isPlayerRun) {
      if (_playerComponent.position.y < _targetPos.y && !_isPlayerRunHor) {
        _playerSpeed.y = 1;
        _isPlayerRunVert = true;
      } else if (_playerComponent.position.y > _targetPos.y &&
          !_isPlayerRunHor) {
        _playerSpeed.y = -1;
        _isPlayerRunVert = true;
      } else {
        _playerSpeed.y = 0;
        _isPlayerRunVert = false;

        if (_playerComponent.position.x < _targetPos.x && !_isPlayerRunVert) {
          _playerSpeed.x = 1;
          _isPlayerRunHor = true;
        } else if (_playerComponent.position.x > _targetPos.x &&
            !_isPlayerRunVert) {
          _playerSpeed.x = -1;
          _isPlayerRunHor = true;
        } else {
          _playerSpeed.x = 0;
          _isPlayerRunHor = false;
        }
      }
    }

    notifyListeners();
  }
}
