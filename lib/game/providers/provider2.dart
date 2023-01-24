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
    //print(playerPos);
    //print(newMap);
    if (newMap.isEmpty) {
      newMap = List.generate(
          map[0].length, (_) => new List.generate(map.length, (index) => '1'));

      for (int i = 0; i < map[0].length; i++) {
        for (int j = map.length - 1; j >= 0; j--) {
          //print('i$i--j$j');
          newMap[i][j] = map[j][i];
        }
      }
    }
    var closedWall = 0;

    var node = reachable.first;
    print(reachable);

    if (reachable.isNotEmpty) {
      if (newMap[(node.x - 1).toInt()][(node.y).toInt()] == 'f') {
        reachable.insert(0, Vector2((node.x) - 1, (node.y)));
        rectPaintPath = RectPaint(
            position: Vector2((node.x - 1) * sizeTile, (node.y) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else if (newMap[(node.x - 1).toInt()][(node.y).toInt()] != '0') {
        closedWall++;
        rectPaintPath = RectPaintRed(
            position: Vector2((node.x - 1) * sizeTile, (node.y) * sizeTile));
        mapComponent.add(rectPaintPath);
        newMap[(node.x - 1).toInt()][(node.y).toInt()] = '0';
        reachable.remove(Vector2((node.x) - 1, (node.y)));
      }
      if (newMap[(node.x + 1).toInt()][(node.y).toInt()] == 'f') {
        reachable.insert(0, Vector2((node.x) + 1, (node.y)));
        rectPaintPath = RectPaint(
            position: Vector2((node.x + 1) * sizeTile, (node.y) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else if (newMap[(node.x + 1).toInt()][(node.y).toInt()] != '0') {
        closedWall++;
        rectPaintPath = RectPaintRed(
            position: Vector2((node.x + 1) * sizeTile, (node.y) * sizeTile));
        mapComponent.add(rectPaintPath);
        newMap[(node.x + 1).toInt()][(node.y).toInt()] = '0';
        reachable.remove(Vector2((node.x) + 1, (node.y)));
      }
      if (newMap[(node.x).toInt()][(node.y + 1).toInt()] == 'f') {
        reachable.insert(0, Vector2((node.x), (node.y) + 1));
        rectPaintPath = RectPaint(
            position: Vector2((node.x) * sizeTile, (node.y + 1) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else if (newMap[(node.x).toInt()][(node.y + 1).toInt()] != '0') {
        closedWall++;
        rectPaintPath = RectPaintRed(
            position: Vector2((node.x) * sizeTile, (node.y + 1) * sizeTile));
        mapComponent.add(rectPaintPath);
        newMap[(node.x).toInt()][(node.y + 1).toInt()] = '0';
        reachable.remove(Vector2((node.x), (node.y) + 1));
      }
      if (newMap[(node.x).toInt()][(node.y - 1).toInt()] == 'f') {
        reachable.insert(0, Vector2((node.x), (node.y) - 1));
        rectPaintPath = RectPaint(
            position: Vector2((node.x) * sizeTile, (node.y - 1) * sizeTile));
        mapComponent.add(rectPaintPath);
      } else if (newMap[(node.x).toInt()][(node.y - 1).toInt()] != '0') {
        closedWall++;
        rectPaintPath = RectPaintRed(
            position: Vector2((node.x) * sizeTile, (node.y - 1) * sizeTile));
        mapComponent.add(rectPaintPath);
        newMap[(node.x).toInt()][(node.y - 1).toInt()] = '0';
        reachable.remove(Vector2((node.x), (node.y) - 1));
      }
      if (closedWall == 4) {}

      reachable.removeLast();

      newMap[(node.x).toInt()][(node.y).toInt()] = '0';
      rectPaintPath = RectPaintRed(
          position: Vector2((node.x) * sizeTile, (node.y) * sizeTile));
      mapComponent.add(rectPaintPath);

      //print(newMap[(_playerPos.x).toInt()][(_playerPos.y).toInt()]);

      //Future.delayed(const Duration(milliseconds: 0), () {})
      _playerPos = reachable.first;
      print(reachable);
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
