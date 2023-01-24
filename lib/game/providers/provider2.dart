import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RectPaint extends RectangleComponent {
  RectPaint({position}) : super(position: position) {
    size = Vector2(50, 50);
    paint = Paint()..color = Color.fromARGB(146, 54, 244, 63);
  }
}

class RectPaintRed extends RectangleComponent {
  RectPaintRed({position}) : super(position: position) {
    size = Vector2(50, 50);
    paint = Paint()..color = Color.fromARGB(146, 244, 67, 54);
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

  Vector2 _playerPos = Vector2(2, 2);
  final Vector2 _targetPos = Vector2(3, 3);
  bool isPlayerRun = false;
  bool _isPlayerRunVert = false;
  bool _isPlayerRunHor = false;
  var rectPaint;
  var rectPaintPath;
  late List reachable = [_playerPos];
  bool lookingPath = false;
  Vector2 targetPos = Vector2(0, 0);
  List newMap = [];

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
    pathFind(playerPos, map, mapComponent, sizeTile);
  }

  pathFind(playerPos, map, mapComponent, sizeTile) async {
    print(playerPos);
    //print(targetPos);
    if (newMap.isEmpty) newMap = map;

    //reachable = [playerPos];

    if (reachable.isNotEmpty) {
      newMap[(reachable[0].x).toInt()][(reachable[0].y).toInt()] = '0';
      if (newMap[(_playerPos.y).toInt() - 1][(_playerPos.x).toInt()] == 'f') {
        reachable.add(Vector2((_playerPos.y) - 1, (_playerPos.x)));
        rectPaintPath = RectPaint(
            position: Vector2(
                (_playerPos.y - 1) * sizeTile, (_playerPos.x) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else {
        newMap[(_playerPos.y).toInt() - 1][(_playerPos.x).toInt()] = '0';
        rectPaintPath = RectPaintRed(
            position: Vector2(
                (_playerPos.y - 1) * sizeTile, (_playerPos.x) * sizeTile));
        mapComponent.add(rectPaintPath);
      }

      if (newMap[(_playerPos.y).toInt() + 1][(_playerPos.x).toInt()] == 'f') {
        reachable.add(Vector2((_playerPos.y) + 1, (_playerPos.x)));
        rectPaintPath = RectPaint(
            position: Vector2(
                (_playerPos.y + 1) * sizeTile, (_playerPos.x) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else {
        newMap[(_playerPos.y).toInt() + 1][(_playerPos.x).toInt()] = '0';
        rectPaintPath = RectPaintRed(
            position: Vector2(
                (_playerPos.y + 1) * sizeTile, (_playerPos.x) * sizeTile));
        mapComponent.add(rectPaintPath);
      }

      if (newMap[(_playerPos.y).toInt()][(_playerPos.x).toInt() + 1] == 'f') {
        reachable.add(Vector2((_playerPos.y), (_playerPos.x) + 1));
        rectPaintPath = RectPaint(
            position: Vector2(
                (_playerPos.y) * sizeTile, (_playerPos.x + 1) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else {
        newMap[(_playerPos.y).toInt()][(_playerPos.x).toInt() + 1] = '0';
        rectPaintPath = RectPaintRed(
            position: Vector2(
                (_playerPos.y) * sizeTile, (_playerPos.x + 1) * sizeTile));
        mapComponent.add(rectPaintPath);
      }

      if (newMap[(_playerPos.y).toInt()][(_playerPos.x).toInt() - 1] == 'f') {
        reachable.add(Vector2((_playerPos.y), (_playerPos.x) - 1));
        rectPaintPath = RectPaint(
            position: Vector2(
                (_playerPos.y) * sizeTile, (_playerPos.x - 1) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else {
        newMap[(_playerPos.y).toInt()][(_playerPos.x).toInt() - 1] = '0';
        rectPaintPath = RectPaintRed(
            position: Vector2(
                (_playerPos.y) * sizeTile, (_playerPos.x - 1) * sizeTile));
        mapComponent.add(rectPaintPath);
      }

      rectPaintPath = RectPaintRed(
          position:
              Vector2((_playerPos.y) * sizeTile, (_playerPos.x) * sizeTile));
      mapComponent.add(rectPaintPath);
      await reachable.removeAt(0);
      Future.delayed(const Duration(milliseconds: 500), () {})
          .then((value) => _playerPos = reachable[0]);
    }
  }

  void tapUp(mapComponent, player, myMap, mySizeTile) {
    List map = myMap;
    double sizeTile = mySizeTile;
    mapComponent.remove(rectPaint);
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
