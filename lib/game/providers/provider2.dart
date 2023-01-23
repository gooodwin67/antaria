import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RectPaint extends RectangleComponent {
  RectPaint({position}) : super(position: position) {
    size = Vector2(60, 60);
    paint = Paint()..color = Colors.red;
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

  final Vector2 _playerPos = Vector2(2, 2);
  final Vector2 _targetPos = Vector2(3, 3);
  bool isPlayerRun = false;
  bool _isPlayerRunVert = false;
  bool _isPlayerRunHor = false;
  var rectPaint;
  bool lookingPath = false;
  Vector2 targetPos = Vector2(0, 0);

  Vector2 get playerPos => _playerPos;

////////////////////////////////////////////////////////////////////////

  void tapDown(info, mapComponent, player, myMap, mySizeTile) {
    List map = myMap;
    double sizeTile = mySizeTile;
    targetPos = Vector2(0, 0);

    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (info.eventPosition.game.x < j * sizeTile &&
            info.eventPosition.game.y < i * sizeTile) {
          targetPos = Vector2(j - 1.toDouble(), i - 1.toDouble());
          rectPaint = RectPaint(
              position: Vector2((j - 1) * sizeTile, (i - 1) * sizeTile));
          mapComponent.add(rectPaint);
          i = map.length;
          break;
        }
      }
    }

    lookingPath = true;
  }

  pathFind(playerPos, map, mapComponent) {
    if (lookingPath) {
      var random = Random().nextInt(4);
      print(random);
      // print(playerPos);
      // print(targetPos);
      print(map[0].length);
      var newPlayerPos = playerPos;

      if (random == 0) {
        if (playerPos.x < map[0].length - 2) {
          playerPos.x += 1;
        }
      } else if (random == 1) {
        if (playerPos.x > 1) {
          playerPos.x -= 1;
        }
      } else if (random == 2) {
        if (playerPos.y > 1) {
          playerPos.y -= 1;
        }
      } else if (random == 3) {
        if (playerPos.y < map.length - 2) {
          playerPos.y += 1;
        }
      }
    }
  }

  void tapUp(mapComponent, player, myMap, mySizeTile) {
    List map = myMap;
    double sizeTile = mySizeTile;
    //mapComponent.remove(rectPaint);
  }

////////////////////////////////////////////////////////////////////////

  void playerRun(info, player, myMap, mySizeTile) {
    List _map = myMap;
    double _sizeTile = mySizeTile;
    int _x = (player.position.x / _sizeTile).toInt();
    int _y = (player.position.y / _sizeTile).toInt();

    if (_map[_y][_x + 1] == '1') {
      _playerPos.x = _playerPos.x + 1;

      _map[_y][_x + 1] = 'f';
    } else if (_map[_y][_x - 1] == '1') {
      _playerPos.x = _playerPos.x - 1;
      _map[_y][_x - 1] = 'f';
    } else if (_map[_y + 1][_x] == '1') {
      _playerPos.y = _playerPos.y + 1;
      _map[_y + 1][_x] = 'f';
    } else if (_map[_y - 1][_x] == '1') {
      _playerPos.y = _playerPos.y - 1;

      // player.add(MoveEffect.to(
      //   Vector2(500, 500),
      //   EffectController(duration: 1.0),
      // ));

      _map[_y - 1][_x] = 'f';
    }
    notifyListeners();
  }
}
